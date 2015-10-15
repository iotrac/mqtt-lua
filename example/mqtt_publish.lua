#!/usr/local/bin/lua
--
-- mqtt_publish.lua
-- ~~~~~~~~~~~~~~~~
-- Version: 0.2 2012-06-01
-- ------------------------------------------------------------------------- --
-- Copyright (c) 2011-2012 Geekscape Pty. Ltd.
-- All rights reserved. This program and the accompanying materials
-- are made available under the terms of the Eclipse Public License v1.0
-- which accompanies this distribution, and is available at
-- http://www.eclipse.org/legal/epl-v10.html
--
-- Contributors:
--    Andy Gelme - Initial implementation
-- -------------------------------------------------------------------------- --
--
-- Description
-- ~~~~~~~~~~~
-- Publish an MQTT message on the specified topic with an optional last will.
--
-- References
-- ~~~~~~~~~~
-- Lapp Framework: Lua command line parsing
--   http://lua-users.org/wiki/LappFramework
--
-- ToDo
-- ~~~~
-- None, yet.
-- ------------------------------------------------------------------------- --
package.path = package.path .. ";../paho/?.lua"

local MQTT = require "mqtt"
local socket = require "socket"
local lapp = require("pl.lapp")

function is_openwrt()
  return(os.getenv("USER") == "root")  -- Assume logged in as "root" on OpenWRT
end
-- if (not is_openwrt()) then require("luarocks.require") end
-- ------------------------------------------------------------------------- --

print("[mqtt_publish v0.2 2012-06-01]")


local args = lapp [[
  Publish a message to a specified MQTT topic
  -d,--debug                                Verbose console logging
  -H,--host          (default localhost)    MQTT server hostname
  -i,--id            (default mqtt_pub)     MQTT client identifier
  -m,--message       (string)               Message to be published
  -p,--port          (default 1883)         MQTT server port number
  -t,--topic         (string)               Topic on which to publish
  -w,--will_message  (default .)            Last will and testament message
  -w,--will_qos      (default 0)            Last will and testament QOS
  -w,--will_retain   (default 0)            Last will and testament retention
  -w,--will_topic    (default .)            Last will and testament topic
]]



if (args.debug) then MQTT.Utility.set_debug(true) end

local mqtt_client = MQTT.client.create(args.host, args.port)

if (args.will_message == "."  or  args.will_topic == ".") then
  mqtt_client:connect(args.id)
else
  mqtt_client:connect(
    args.id, args.will_topic, args.will_qos, args.will_retain, args.will_message
  )
end

mqtt_client:publish(args.topic, args.message)

mqtt_client:destroy()

-- ------------------------------------------------------------------------- --
