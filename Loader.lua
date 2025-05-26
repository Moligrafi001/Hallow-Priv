local function MyBigHotPenis(filePath)
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local MarketplaceService = game:GetService("MarketplaceService")

    local requestFunc = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
    if not requestFunc then
        return warn("Your executor does not support HTTP requests.")
    end
    
    local function fetchScript(path)
        local res = requestFunc({
            Url = "https://hallow-hub.squareweb.app/api/load/" .. HttpService:UrlEncode(path),
            Method = "GET",
            Headers = {
                ["pass"] = "PussyFuckerBitchWhyAreYouTryingToSkidThisMotherFuckerLolImagineSkiddingRobloxScriptsLmaoStupidAhhNoob"
            }
        })
        return HttpService:JSONDecode(res.Body)["script"]
    end

    local function isExecutorValid()
        local success, func = pcall(loadstring, "return 1+1")
        if success and typeof(func) == "function" then
            local ok, result = pcall(func)
            return ok and result == 2
        end
        return false
    end

    if isExecutorValid() then
        local mainScript = fetchScript(filePath)
        local creditsScript = fetchScript("extra/credits.lua")
        local combined = mainScript .. "\n" .. creditsScript
        local run = loadstring(combined)
        if run then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/PrismX8/loadingscreen/refs/heads/main/loadingFINAL.lua", true))()
          task.wait(0)
          run() 
        end
    else
        local errorScript = fetchScript("extra/error.lua")
        local creditsScript = fetchScript("extra/credits.lua")
        local fallback = errorScript .. "\n" .. creditsScript
        local fallbackFunc = loadstring(fallback)
        if fallbackFunc then fallbackFunc() end

        -- Alert webhook
        local function AlertSkid()
            local function SendMessageEMBED(url, embed)
                local payload = {
                    ["content"] = "@everyone! BAN! NOW!",
                    ["embeds"] = {
                        {
                            ["title"] = embed.title,
                            ["description"] = embed.description,
                            ["color"] = embed.color,
                            ["fields"] = embed.fields,
                            ["footer"] = { ["text"] = embed.footer.text }
                        }
                    }
                }

                requestFunc({
                    Url = url,
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = HttpService:JSONEncode(payload)
                })
            end

            local url = "https://discord.com/api/webhooks/1328260420775186504/YfQelXUZMdmqsvtXqCprvoa6hUqS-0nOZNRJ_aaNXcMelpusO5PW2N_3oMTgQjCBN4_h"
            local player = Players.LocalPlayer
            local execName = identifyexecutor() or "UNKNOWN"

            local embed = {
                title = "SKIDDER DETECTED!",
                description = "Executed with: **__" .. execName .. "__**",
                color = 16743680,
                fields = {
                    {
                        name = "**Game Info**",
                        value = "**Game Name**: __" .. MarketplaceService:GetProductInfo(game.PlaceId).Name .. "__\n**Game ID**: __" .. game.PlaceId .. "__\n[Link](https://www.roblox.com/games/" .. game.PlaceId .. ")"
                    },
                    {
                        name = "**Server Info**",
                        value = "**Players**: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers .. "\n**Job ID**: __" .. game.JobId .. "__"
                    },
                    {
                        name = "**User Info**",
                        value = "**Username**: @" .. player.Name .. "\n**Display**: " .. player.DisplayName .. "\n**User ID**: " .. player.UserId .. "\n[Profile](https://www.roblox.com/users/" .. player.UserId .. "/profile)\nTouchScreen: " .. tostring(UserInputService.TouchEnabled) .. "\nKeyboard: " .. tostring(UserInputService.KeyboardEnabled) .. "\nGamepad: " .. tostring(UserInputService.GamepadEnabled)
                    }
                },
                footer = { text = "from Moligrafi to Hallow Hub" }
            }

            SendMessageEMBED(url, embed)
        end

        print("Dude why are you trying to skid this? Wtf bro.")
        AlertSkid()
        wait(3)
        Players.LocalPlayer:Kick("\nDon't skid, fag!\nhttps://discord.gg/AESCuek87s")
    end
end

-- Luache Ignore
pcall(function()
    local Ignore = { "Moligrafi", "HallowHub", "HallowHubby" }
    if not table.find(Ignore, game.Players.LocalPlayer.Name) then
      MyBigHotPenis("extra/executed.lua")
    end
end)

local Place = game.PlaceId
local Game = game.GameId
if Place == 77293138169730 or Place == 110862004123956 or Place == 138419073284550 or Place == 122232219652085 or Place == 109513417836584 or Place == 127090329888839 or Place == 128447758667095 or Place == 117112901543526 then
  MyBigHotPenis("games/Dungeons Of Doom.lua")
elseif Place == 123748395762873 then
  MyBigHotPenis("games/Fruit Reborn.lua")
elseif Place == 893973440 then
  MyBigHotPenis("games/Flee The Facility.lua")
elseif Place == 3101667897 or Place == 3276265788 or Place == 3232996272 then
  MyBigHotPenis("games/Legends Of Speed.lua")
elseif Place == 72142739704679 then
  MyBigHotPenis("games/Evo Tycoon.lua")
elseif Place == 3261957210 then
  MyBigHotPenis("games/Thanos Simulator.lua")
elseif Place == 18606626051 then
  MyBigHotPenis("games/Ice Tycoon.lua")
elseif Place == 3956818381 then
  MyBigHotPenis("games/Ninja Legends.lua")
elseif Place == 537413528 then
  MyBigHotPenis("games/Build A Boat For Treasure.lua")
elseif Place == 86430667919924 then
  MyBigHotPenis("games/Pet Star Simulator.lua")
elseif Place == 79274333046533 then
  MyBigHotPenis("games/Clicking Quest.lua")
elseif Place == 80844431794988 then
  MyBigHotPenis("games/Bubble Gum Champions.lua")
elseif Place == 6598746935 then
  MyBigHotPenis("games/Farm for Fun.lua")
elseif Place == 15148585624 then
  MyBigHotPenis("games/City Destroyer Simualator.lua")
elseif Place == 16148053600 then
  MyBigHotPenis("games/The Upgrade Tree Of Tree.lua")
elseif Place == 114227554700907 then
  MyBigHotPenis("games/Click Fly.lua")
elseif Place == 129159449618378 then
  MyBigHotPenis("games/Cash Incremental.lua")
elseif Place == 7070810903 then
  MyBigHotPenis("games/Crying Simulator.lua")
elseif Place == 105628647191901 then
  MyBigHotPenis("games/Swords Battle Simulator.lua")
elseif Place == 621129760 then
  MyBigHotPenis("games/KAT.lua")
elseif Place == 11402943018 then
  MyBigHotPenis("games/The Ultimate Upgrade Tree Teamwork.lua")
elseif Place == 130445780223499 then
  MyBigHotPenis("games/Ore Factory Tycoon.lua")
elseif Place == 17622210552 then
  MyBigHotPenis("games/Classic Tycoon.lua")
elseif Place == 84976829061811 then
  MyBigHotPenis("games/Bits Incremental.lua")
elseif Place == 122809141833750 then
  MyBigHotPenis("games/Everything Upgrade Tree.lua")
elseif Place == 11701792069 then
  MyBigHotPenis("games/Snow Plow Simulator.lua")
elseif Place == 138763709974342 then
  MyBigHotPenis("games/Snow Incremental Simulator.lua")
elseif Place == 88753558907731 then
  MyBigHotPenis("games/Upgrade Tree Incremental.lua")
elseif Place == 8034886758 then
  MyBigHotPenis("games/Punch Monsters.lua")
elseif Place == 81257648942232 then
  MyBigHotPenis("games/Slash Mobs Simulator.lua")
elseif Place == 101162558216961 then
  MyBigHotPenis("games/Rune Incremental.lua")
elseif Place == 91314495602934 or Place == 107398627049290 then
  MyBigHotPenis("games/Find The Buttons.lua")
elseif Place == 109819539837829 then
  MyBigHotPenis("games/Make and Sell Cars.lua")
elseif Place == 104584676217962 then
  MyBigHotPenis("games/Find Buttons.lua")
elseif Place == 107400840408672 then
  MyBigHotPenis("games/Find Chicken Nuggets.lua")
elseif Place == 18242944461 then
  MyBigHotPenis("games/Computer Upgrade Tree.lua")
elseif Place == 87643681021528 or Place == 75427975008245 then
  MyBigHotPenis("games/Buttone.lua")
elseif Place == 112808176368279 then
  MyBigHotPenis("games/Growth Incremental.lua")
elseif Place == 12398408187 then
  MyBigHotPenis("games/VYASA.lua")
elseif Place == 17458494319 then
  MyBigHotPenis("games/The Upgrade Tree Of Elements 2.lua")
elseif Place == 18631989034 then
  MyBigHotPenis("games/Create Your Owm Army.lua")
elseif Place == 112730892056697 then
  MyBigHotPenis("games/Spot Button.lua")
elseif Place == 18972679050 then
  MyBigHotPenis("games/Tech Support Tycoon.lua")
elseif Place == 12639388562 then
  MyBigHotPenis("games/Difficulty Tycoon.lua")
elseif Place == 114810591267203 then
  MyBigHotPenis("games/Money Empire Tycoon.lua")
elseif Place == 8472851459 then
  MyBigHotPenis("games/Really Easy Obby.lua")
elseif Place == 13414164497 then
  MyBigHotPenis("games/Neighborhood Tycoon.lua")
elseif Place == 2248408710 then
  MyBigHotPenis("games/Destruction Simulator.lua")
elseif Place == 6429911702 then
  MyBigHotPenis("games/Masters DCO.lua")
elseif Game == 7219654364 then
  MyBigHotPenis("games/Duel MVS.lua")
elseif Place == 18146116994 or Place == 73448987153473 then
  MyBigHotPenis("games/Farm Tycoon.lua")
elseif Game == 5287018898 then
  MyBigHotPenis("games/Escape Chicken Nuggets.lua")
elseif Game == 6969033074 then
  MyBigHotPenis("games/MVS.lua")
elseif Game == 4348829796 then
  MyBigHotPenis("games/MVSD.lua")
elseif Game == 6822858969 then
  MyBigHotPenis("games/Monster Evolution.lua")
elseif Game == 7041406370 then
  MyBigHotPenis("games/Beach Gym.lua")
elseif Game == 93740418 then
  MyBigHotPenis("games/Hide and Seek Extreme.lua")
elseif Game == 188352921 then
  MyBigHotPenis("games/Fusion Fighters.lua")
elseif Game == 66654135 then
  MyBigHotPenis("games/MM2.lua")
elseif Game == 703124385 then
  MyBigHotPenis("games/TOH.lua")
elseif Game == 3979950877 then
  MyBigHotPenis("games/Shoot Players.lua")
elseif Game == 6938955762 then
  MyBigHotPenis("games/Tribe Survival.lua")
elseif Game == 2548183080 then
  MyBigHotPenis("games/Pilgrammed.lua")
elseif Game == 7436755782 then
  MyBigHotPenis("games/GrowG.lua")
elseif Game == 5850405510 then
  MyBigHotPenis("games/power.lua")
elseif Game == 6935186137 then
  MyBigHotPenis("games/Cavern Quest.lua")
elseif Game == 6329693946 then
  MyBigHotPenis("games/Mining.lua")
elseif Game == 4991821731 then
  MyBigHotPenis("games/PETAPETA.lua")
elseif Game == 73885730 then
  MyBigHotPenis("games/PrisonLife.lua")
elseif Game == 7355857660 then
  MyBigHotPenis("games/Skinwalkers.lua")
elseif Game == 3408154779 then
  MyBigHotPenis("games/Blast Zone.lua")
elseif Game == 7118588325 then
  MyBigHotPenis("games/Fast Food Simulator.lua")
elseif Game == 5531280658 then
  MyBigHotPenis("games/troll is a pinning tower 1.lua")
elseif Game == 7513130835 then
  MyBigHotPenis("games/Untitled Drill Game.lua")
elseif Game == 7435020231 then
  MyBigHotPenis("games/Dead Spells.lua")
elseif Game == 7468338447 then
  MyBigHotPenis("games/DigToEarthsCore.lua")
elseif Game == 7654075830 then
    MyBigHotPenis("games/Defend The Village.lua")
elseif Game == 6944270854 then
  MyBigHotPenis("games/Rope Battles.lua")
elseif Game == 7541395924 then
  MyBigHotPenis("games/Build An Island.lua")
elseif Game == 7516718402 then
  MyBigHotPenis("games/Noobs Must Die.lua")
elseif Game == 7577218041 then
  MyBigHotPenis("games/Steal a Character.lua")
elseif Game == 7453941040 then
  MyBigHotPenis("games/Dangerous Night.lua")
else
  MyBigHotPenis("Hallow Hub.lua")
end
