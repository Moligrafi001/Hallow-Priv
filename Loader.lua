local function MyBigHotPenis(filePath)
  local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
  local response = httrest({
    Url = "https://api.github.com/repos/Moligrafi001/Hallow-Priv/contents/" .. game:GetService("HttpService"):UrlEncode(filePath) .. "?ref=main",
    Method = "GET",
    Headers = {
      ["Authorization"] = "Bearer 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",
      ["Accept"] = "application/vnd.github.raw+json"
    }
  })
  local credits = httrest({
    Url = "https://api.github.com/repos/Moligrafi001/Hallow-Priv/contents/extra/credits.lua?ref=main",
    Method = "GET",
    Headers = {
      ["Authorization"] = "Bearer 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",
      ["Accept"] = "application/vnd.github.raw+json"
    }
  })
  local errado = httrest({
    Url = "https://api.github.com/repos/Moligrafi001/Hallow-Priv/contents/extra/error.lua?ref=main",
    Method = "GET",
    Headers = {
      ["Authorization"] = "Bearer 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",
      ["Accept"] = "application/vnd.github.raw+json"
    }
  })
  local carregar = loadstring(response.Body .. "\n" .. credits.Body) or loadstring(errado.Body .. "\n" .. credits.Body)
  carregar()
end
local success, err = pcall(function()
    if game.Players.LocalPlayer.Name ~= "Moligrafi" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/extra/FixBugs.lua", true))()
				print("FixBugs loaded, yay!")
    end
end)
if not success then
    print("FixBugs coudn't be loaded, please join the discord.gg/AESCuek87s and create a ticket to report this bug → " .. err)
end

local Place = game.PlaceId
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
else
  MyBigHotPenis("Hallow Hub.lua")
end