print("--- main 1 ---")
local skynet       = require "skynet"

local config       = require "config.system"
local login_config = require "config.loginserver"
local game_config  = require "config.gameserver"

skynet.start(function()

	skynet.newservice("debug_console", config.debug_port)
	skynet.newservice("protod")
    print("starting database...")
	skynet.uniqueservice("database")

    print("")
    print("starting loginserver...")
	local loginserver = skynet.newservice("loginserver")
	skynet.call(loginserver, "lua", "open", login_config)	
    print("finishing loginserver")

	local gamed = skynet.newservice("gamed", loginserver)
	skynet.call(gamed, "lua", "open", game_config)

    skynet.error("::::::::::::::::::::::: Server Ready :::::::::::::::::::::::")
end)

