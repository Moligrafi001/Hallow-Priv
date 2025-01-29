local function WhyDidYouDeobfuscatedBruh(filePath)
  local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
  local response = httrest({
    Url = "https://hallow-hub.squareweb.app/api/load/" .. game:GetService("HttpService"):UrlEncode(filePath),
    Method = "GET",
    Headers = {
      ["pass"] = "SuperSecretHallowHubKey090609"
    }
  })
  local originalLoadstring = loadstring
  local function isFuckingSkidShit()
    local testCode = "return 1 + 1"
    local success, compiledFunc = pcall(loadstring, testCode)
    if success and typeof(compiledFunc) == "function" then
      local ok, result = pcall(compiledFunc)
      if ok and result == 2 then
        return true
      end
    end
    return false
  end
  if isFuckingSkidShit() then
    local func = loadstring(game:GetService("HttpService"):JSONDecode(response.Body)["script"])
    func()
  else
    local function AlertSkid()
    local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
    local function SendMessageEMBED(url, embed)
        local http = game:GetService("HttpService")
        local headers = {
            ["Content-Type"] = "application/json"
        }
        local data = {
            ["content"] = "@everyone! BAN! NOW!",
            ["embeds"] = {
                {
                    ["title"] = embed.title,
                    ["description"] = embed.description,
                    ["color"] = embed.color,
                    ["fields"] = embed.fields,
                    ["footer"] = {
                        ["text"] = embed.footer.text
                    }
                }
            }
        }
        local body = http:JSONEncode(data)
        local response = httrest({
            Url = url,
            Method = "POST",
            Headers = headers,
            Body = body
        })
    end
    local url = "https://discord.com/api/webhooks/1328260420775186504/YfQelXUZMdmqsvtXqCprvoa6hUqS-0nOZNRJ_aaNXcMelpusO5PW2N_3oMTgQjCBN4_h"
    local Gamepado = "false"
    local Toque = "false"
    local Teclado = "false"
    if game:GetService("UserInputService").TouchEnabled == true then
    	Toque = "__true__"
    end
    if game:GetService("UserInputService").KeyboardEnabled == true then
    	Teclado = "__true__"
    end
    if game:GetService("UserInputService").GamepadEnabled == true then
    	Gamepado = "__true__"
    end
    local execName = identifyexecutor() or "NO NAME!!!"
    local embed = {
        ["title"] = "SKIDDER DETECTED!",
        ["description"] = "Executed with: **__" .. execName .. "__**\n‎ ",
        ["color"] = 16743680,
        ["fields"] = {
            {
                ["name"] = "**Game Info**",
                ["value"] = "**Game Name**: __" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "__\n**Game ID**: __" .. game.PlaceId .. "__\n**Link**: https://www.roblox.com/games/" .. game.PlaceId .. "\n‎ "
            },
            {
                ["name"] = "**Server Info**",
                ["value"] = "**Players**: " .. #game.Players:GetPlayers() .. "/" .. game.Players.MaxPlayers .. "\n**Job ID**: __" .. game.JobId .. "__\n**Link**: __No Link Yet__\n‎ "
            },
            {
                ["name"] = "**User Info**",
                ["value"] = "**Username**: @__" .. game.Players.LocalPlayer.Name .. "__\n**Display**: __" .. game.Players.LocalPlayer.DisplayName .. "__\n**User ID**: __" .. game.Players.LocalPlayer.UserId .. "__\n**Link**: https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId .. "/profile" .. "\n\n**TouchScreen**: " .. Toque .. "\n**Keyboard**: " .. Teclado .. "\n**Gamepad**: " .. Gamepado
            }
        },
        ["footer"] = {
            ["text"] = "from Moligrafi to Hallow Hub"
        }
    }
    SendMessageEMBED(url, embed)
    end
    print("Dude why are you trying to skid this? Wtf bro.")
    AlertSkid()
    wait(3)
    game.Players.LocalPlayer:Kick("\nDon't skid, fag!\nhttps://discord.gg/AESCuek87s")
  end
end

WhyDidYouDeobfuscatedBruh("Loader.lua")