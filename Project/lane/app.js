var moment = require('moment')
  , d = require('./attack.json')

d = d.map(function(o) {
  var m = moment( o['Timestamp'], "DD/MMM/YYYY:HH:mm:ss");
//  console.log( m.format('MM/DD/YYYY HH:mm:ss') )
  o['Timestamp'] = m.format('MM/DD/YYYY HH:mm:ss')
  // 09/12/2013 09:08:08:07.6546
  return o;
})

console.log( ['AttackType', 'IP', 'Timestamp', 'Status'].join(',') )

d.forEach(function(o) {
  console.log( [o.AttackType, o.IP, o.Timestamp, o.Status].join(',') )
})
