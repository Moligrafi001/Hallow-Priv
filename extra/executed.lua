local function TestCode()
  local ExecutorName = identifyexecutor() or "NO NAME!!!"
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
  local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
  local response = httrest({
    Url = "https://hallow-hub.squareweb.app/api/integrity",
    Method = "GET",
    Headers = {
      ["executor"] = tostring(ExecutorName),
      ["gamename"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
      ["gameid"] = tostring(game.PlaceId),
      ["serversize"] = tostring(#game.Players:GetPlayers()) .. "/" .. tostring(game.Players.MaxPlayers),
      ["jobid"] = tostring(game.JobId),
      ["username"] = tostring(game:GetService("Players").LocalPlayer.Name),
      ["displayname"] = tostring(game:GetService("Players").LocalPlayer.DisplayName),
      ["userid"] = tostring(game:GetService("Players").LocalPlayer.UserId),
      ["touch"] = tostring(Toque),
      ["gamepad"] = tostring(Gamepado),
      ["keyboard"] = tostring(Teclado)
    }
  })
  print(response.Body)
end
TestCode()

pcall(function()
  if game.Players.LocalPlayer.Name == "Yhawbachh" then
    game.Players.LocalPlayer:Kick("You are banned!\ndiscord.gg/AESCuek87s")
  end
end)