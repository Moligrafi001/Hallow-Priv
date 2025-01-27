local function TestCode()
  local ExecutorName = identifyexecutor() or "NO NAME!!!"
  local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
  local response = httrest({
    Url = "https://hallow-hub.squareweb.app/api/integrity",
    Method = "GET",
    Headers = {
      ["executor"] = ExecutorName,
      ["gamename"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    }
  })
  print(response.Body)
end
TestCode()