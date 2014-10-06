package = 'paho-mqtt'
version = '0.3.0-1'
source = {
  url = 'git://git.eclipse.org/gitroot/paho/org.eclipse.paho.mqtt.lua.git',
  tag = 'v0.3.0-1',
}

description = {
  summary = 'Client-side implementation of MQTT',
  detailed = [[Implements the client-side subset of the MQTT protocol
    specification 3.1, plus command-line utilities for publishing and
    subscribing to MQTT topics. Typically, one or more MQTT servers,
    such as mosquitto or rsmb will be running on host systems, with
    which the Lua MQTT client can interact.]],
  license = 'EPL',
  homepage = 'https://www.eclipse.org/paho/',
  maintainer = 'Kevin KIN-FOO <kkinfoo@sierrawireless.com>',
}

dependencies = {
  'lua ~> 5.1',
  'luafilesystem ~> 1.6',
  'luasocket ~> 3.0',
  'penlight ~> 1.3',
}

build = {
  type = 'builtin',
  modules = {
    ['paho.mqtt'] = 'paho/mqtt.lua',
    ['paho.utility']  = 'paho/utility.lua',
  },
  install = {
    bin = {
      mqtt_publish = 'paho/example/mqtt_publish.lua',
      mqtt_subscribe = 'paho/example/mqtt_subscribe.lua',
    }
  }
}
