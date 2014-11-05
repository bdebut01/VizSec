#	Comp 116: Security Systems
#	Assignment 2: Incident Alarm with Ruby and Packetfu
#	by Benjamin deButts (bdebut01) 
#	last updated: 10/7/14

require 'packetfu'
require 'base64'
require 'optparse'
require_relative 'docopt'

include PacketFu

# Convert from string to binary
def str_to_binary(text)
	text.each_byte.map { |b| sprintf(" 0x%02x ", b) }.join
end

def scan_stream()
	incidentCount = 0
	
	cap = PacketFu::Capture.new(:start => true, :iface => 'eth0', :promisc => true)
	cap.stream.each do |p|
		pkt = Packet.parse p
		protos = pkt.proto()
		
		#If protocol contains a TCP, check for NULL & XMAS scans
		if(protos.include?("TCP"))
			if(xmas_scan?(pkt))
				incidentCount += 1
				payload_ = str_to_binary(pkt.payload)
				if(payload_ != nil)
					payload_ = Base64.encode64(payload_)
				end
			elsif(null_scan?(pkt))
				incidentCount += 1
				payload = str_to_binary(pkt.payload)
				if(payload_ != nil)
					payload_ = Base64.encode64(payload_)
				end
			else
			end
		end
		#Check for HTTP protocol, and look for credit card number patterns
		if(protos.include?("IP"))	
			if(card_attack?(pkt))
				incidentCount += 1
				payload_ = str_to_binary(pkt.payload)
				payload_ = Base64.encode64(payload_)
			end
		end
		
	end
end


# Card Types: 
# VISA
# 4xxx-xxxx-xxxx-xxxx ## include variations: 4xxxxxxx... or 4xxx xxxx...
# MASTER
# 5xxx-xxxx-xxxx-xxxx ## include variations: 5xxxxxxx... or 4xxx xxxx...
# DISCOVER
# 6011-xxxx-xxxx-xxxx ## include variations: 6011xxxx... or 4xxx xxxx...
# EXPRESS
# 3xxx-xxxxxx-xxxxx ## include variations: 3xxxxxxxxx.... or 3xxx xxxxx
def card_attack?(pkt)
	pay = pkt.payload
	return (pay.match('4\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}') ||
		pay.match('5\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}') ||
		pay.match('6011(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}') ||
		pay.match('3\d{3}(\s|=)?\d{6}(\s|-)?\d{5}'))
end

#Assumed to be called solely for TCPPackets
def xmas_scan?(pkt)
	return (pkt.tcp_flags.fin == 1 && pkt.tcp_flags.urg == 1 && pkt.tcp_flags.psh == 1)
end

def null_scan?(pkt)
	return (pkt.tcp_flags.syn == 0 && pkt.tcp_flags.fin == 0 && pkt.tcp_flags.ack == 0 &&
	       	pkt.tcp_flags.urg == 0 && pkt.tcp_flags.psh == 0 && pkt.tcp_flags.rst == 0)
end

# Prints the detection to the screen. Called by all detection definitions.
def print_error(throw, attack, ipaddress, time, payload)
	puts "#{attack} #{ipaddress} (#{time}) (#{payload})"
end

# WEB SERVER SCAN #
def log_scan(web_log)
	file = File.open(web_log)
	numIncidents = 0
	file.each do |line|
		parts = line.split('"')
		ip = parts[0].split()
		body = parts[1]
		status = parts[2].split()[0]
		timestamp = parts[0].split()[3]
		#phpMyAdmin error
		if(line.include?("phpMyAdmin"))
			print_error(numIncidents, "phpMyAdmin", ip[0], timestamp, status)
		end
		#nmap scans
		if(line.include?("nmap" || line.includes?("NMAP")))
			print_error(numIncidents, "nmap", ip[0], timestamp, status)
		end
		#http errors
		if(status.to_i >= 400 && status.to_i < 500)
		#	print_error(numIncidents, "http error", ip[0], timestamp, status)
		end
		#andddd finally, shell code
		if(validHex(body))	
			print_error(numIncidents, "Shell", ip[0], timestamp, status)
		end
	end	
end


def validHex(body)
	if(body.start_with?("\\x") && body.match(/((\\+x+[[:xdigit:]]+[[:ascii:]]?){2,})/))
		return true
	else
		return false
	end
end

def main ()
doc = <<DOCOPT
Usage: 
	#{__FILE__}
	#{__FILE__} -r <web_server_log>
	#{__FILE__} -h | --help

Options: 
	-h --help Show this screen.
	-r <web_server_log> Scan a web server log.


DOCOPT
	begin 
		options = Docopt::docopt(doc)
		args = ARGV;
		if(args[0] == "-r")
			log_scan(args[1])
		else 
			scan_stream()
		end
	
	rescue Docopt::Exit => e
		puts e.message
	end
end

main()
