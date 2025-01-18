-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/HallowHub.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | No Game Dettected",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Movement
local WalkSpeedText = 16
local JumpPowerText = 50
getgenv().SetWalkSpeed = false
getgenv().SetJumpPower = false
getgenv().InfJump = false
getgenv().NoClip = false
local function SetWalkSpeed()
	while getgenv().SetWalkSpeed == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
		end
		wait(0.01)
	end
	if getgenv().SetWalkSpeed == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
	end
end
local function SetJumpPower()
	while getgenv().SetJumpPower == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower ~= JumpPowerText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = JumpPowerText
		end
		wait(0.01)
		end
	if getgenv().SetJumpPower == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
	end
end
local function InfJump()
	while getgenv().InfJump == true do
		game:GetService("UserInputService").JumpRequest:connect(function()
			if getgenv().InfJump == true then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			end
		end)
		wait(0.1)
	end
end
local function NoClip()
	while getgenv().NoClip == true do
		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				if getgenv().NoClip then
					part.CanCollide = false
				else
					part.CanCollide = true
				end
			end
		end
		wait(0.1)
	end
end

local Uni = Window:CreateTab("Universal Stuff", "orbit")
local Section = Uni:CreateSection("Universal")
local Label = Uni:CreateLabel("Here are Some Universal Controls for all games", "smile")

local Input = Uni:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Toggle = Uni:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = Uni:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})
local Section = Uni:CreateSection("Jump")
local Input = Uni:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
local Toggle = Uni:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = Uni:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})

-- Teleport
local selectedGame = "The Upgrade Tree Of Tree"
function TeleportToGame(placeId)
    local teleportService = game:GetService("TeleportService")
    local success, errorMessage = pcall(function()
        teleportService:Teleport(placeId, game.Players.LocalPlayer)
    end)
end

-- Lista de Place IDs correspondentes aos jogos
local gamePlaceIds = {
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

-- Games
local Games = Window:CreateTab("Supported Games", "gamepad-2")
local Section = Games:CreateSection("Join game system")
local Label = Games:CreateLabel("Here are all the supported games in this script <3", "smile")
local Dropdown = Games:CreateDropdown({
   Name = "Select Game to Join",
   Options = {"The Upgrade Tree Of Tree", "Everything Upgrade Tree", "Snow Plow Simulator", "Farm for Fun! 🌾", "⚔️ Slash Mobs Simulator", "Rune Inc", "Make and Sell Cars", "Find The Buttons! 🔎🔴", "🥊Punch Monsters!", "Cash Incremental", "Legends Of Speed", "Find The Buttons!", "Clicking Quest!", "Growth Incremental", "Find The Button", "Snow Incremental Simulator", "Ultimate Upgrade Tree", "Jump Incremental", "Find Chicken Nuggets", "Find Buttons! 👀", "Vyasa", "Computer Upgrade Tree", "Swords Battle Simulator", "Dungeons of Doom", "Flee The Facility", "City Destroyer Simulator"},
   CurrentOption = {"Choose one"},
   MultipleOptions = false,
   Callback = function(Options)
   		selectedGame = Options[1]
   end,
})
local Button = Games:CreateButton({
   Name = "Teleport to selected game",
   Callback = function()
   			setclipboard("loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Loader.lua\",true))() -- https://discord.gg/AESCuek87s")
   			toclipboard("loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Loader.lua\",true))() -- https://discord.gg/AESCuek87s")
   			Rayfield:Notify({
			  Title = "Teleleporting...",
			   Content = "The loadstring has copied, teleporting to selected game...",
			   Duration = 3,
			   Image = 17091459839,
				})
   			wait(3.5)
        local placeId = gamePlaceIds[selectedGame]
        if placeId then
            TeleportToGame(placeId)
        end
    end,
})
