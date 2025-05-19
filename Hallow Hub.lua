local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | No Game Dettected",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Teleport
local selectedGame = "The Upgrade Tree Of Tree"
function TeleportToGame(placeId)
  local success, errorMessage = pcall(function()
  game:GetService("TeleportService"):Teleport(placeId, game.Players.LocalPlayer)
  end)
end
-- Games List
local function GetGames()
  local gamePlaceIds = {
    ["Ninja Legends"] = 3956818381,
    ["The Upgrade Tree Of Tree"] = 16148053600,
    ["Everything Upgrade Tree"] = 122809141833750,
    ["Snow Plow Simulator"] = 11701792069,
    ["Farm for Fun! 🌾"] = 6598746935,
    ["⚔️ Slash Mobs Simulator"] = 81257648942232,
    ["Rune Inc"] = 101162558216961,
    ["Make and Sell Cars"] = 109819539837829,
    ["Find The Buttons! 🔎🔴"] = 91314495602934,
    ["🥊Punch Monsters!"] = 8034886758,
    ["Cash Incremental"] = 129159449618378,
    ["Legends Of Speed"] = 3101667897,
    ["Find The Buttons!"] = 112730892056697,
    ["Clicking Quest!"] = 79274333046533,
    ["Growth Incremental"] = 112808176368279,
    ["Find The Button"] = 87643681021528,
    ["Snow Incremental Simulator"] = 138763709974342,
    ["Ultimate Upgrade Tree"] = 129503100059800,
    ["Jump Incremental"] = 98896743739347,
    ["Find Chicken Nuggets"] = 107400840408672,
    ["Find Buttons! 👀"] = 104584676217962,
    ["Vyasa"] = 12398408187,
    ["Computer Upgrade Tree"] = 18242944461,
    ["Swords Battle Simulator"] = 105628647191901,
    ["Dungeons of Doom"] = 77293138169730,
    ["Flee The Facility"] = 893973440,
    ["City Destroyer Simulator"] = 15148585624
  }
  return gamePlaceIds
end
local function GetGameNames()
  local names = {}
  
  for name, _ in pairs(GetGames()) do
    table.insert(names, name)
  end
  
  return names
end

-- Games
local Games = Window:CreateTab("Supported Games", "gamepad-2")
Section = Games:CreateSection("Join game system")
Label = Games:CreateLabel("Here are all the supported games in this script <3", "smile")
Dropdown = Games:CreateDropdown({
  Name = "Select Game to Join",
  Options = GetGameNames(),
  CurrentOption = {"Choose one"},
  Callback = function(Options)
    selectedGame = Options[1]
  end,
})
Button = Games:CreateButton({
  Name = "Teleport to selected game",
  Callback = function()
    setclipboard("loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Loader.lua\",true))() -- https://discord.gg/AESCuek87s")
    Rayfield:Notify({
      Title = "Teleleporting...",
      Content = "The loadstring has copied, teleporting to selected game...",
      Duration = 3,
      Image = 17091459839,
    })
    wait(3.5)
    local id = GetGames()[selectedGame]
    if id then
      TeleportToGame(id)
    end
  end,
})