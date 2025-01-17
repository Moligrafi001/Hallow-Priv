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
  loadstring(response.Body .. "\n" .. credits.Body)()
end

if game.PlaceId == 123748395762873 then
  MyBigHotPenis("games/Fruit Reborn.lua")
elseif game.PlaceId == 893973440 then
  MyBigHotPenis("games/Flee The Facility.lua")
elseif game.PlaceId == 3232996272 then
  MyBigHotPenis("games/Legends Of Speed.lua")
end