--
-- (C) 2013-20 - ntop.org
--

local dirs = ntop.getDirs()
package.path = dirs.installdir .. "/scripts/lua/modules/?.lua;" .. package.path

require "lua_utils"
local ts_utils = require("ts_utils_core")
local ts_dump = require "ts_5min_dump_utils"

-- ########################################################

local verbose = ntop.verboseTrace()
local when = os.time()
local config = ts_dump.getConfig()

local ifstats = interface.getStats()
local _ifname = ifstats.name

-- ########################################################

ts_dump.run_5min_tasks(_ifname, ifstats)

if not hasHighResolutionTs() then
  ts_dump.run_5min_dump(_ifname, ifstats, config, when, verbose)
-- else: perform the ts_dump.run_5min_dump in minute.lua
end
