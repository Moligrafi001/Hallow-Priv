-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/TreeEl2.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub |The Upgrade Tree Of Elements 2",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
_G.UpgOx = false
_G.UpgCaOx = false
_G.Carbonizar = false
_G.UpgN = false
_G.Nitrogenar = false

-- Locais
local TempCarbo = 1
local TempNgnar = 1

-- Funções
local function UpgOx()
local touch = game.Players.LocalPlayer.Character.HumanoidRootPart
	while _G.UpgOx == true do
		firetouchinterest(touch, workspace.Map.Buttons.StartGeneratingOxygen.Button, 0)
		firetouchinterest(touch, workspace.Map.Buttons.StartGeneratingOxygen.Button, 1)
		for _, botao in pairs(workspace.Map.Buttons:GetChildren()) do
			if botao.UpgradeType.Value == "Oxygen" and botao.Button.Transparency ~= 1 and botao.Button.Border.Color == Color3.fromRGB(248, 248, 248) then
				firetouchinterest(touch, botao.Button, 0)
				firetouchinterest(touch, botao.Button, 1)
			end
		end
		wait(0.1)
	end
end
local function UpgCaOx()
local touch = game.Players.LocalPlayer.Character.HumanoidRootPart
	while _G.UpgCaOx == true do
		for _, botao in pairs(workspace.Map.Buttons:GetChildren()) do
			if botao.Name ~= "Carbonize" and botao.UpgradeType.Value == "Oxygen" and botao.Button.Transparency ~= 1 and botao.Button.Border.Color == Color3.fromRGB(160, 132, 79) then
				firetouchinterest(touch, botao.Button, 0)
				firetouchinterest(touch, botao.Button, 1)
			end
		end
		wait(0.1)
	end
end
local function Carbonizar()
local touch = game.Players.LocalPlayer.Character.HumanoidRootPart
	while _G.Carbonizar == true do
		local botao = workspace.Map.Buttons.Carbonize
		if botao.UpgradeType.Value == "Oxygen" and botao.Button.Transparency ~= 1 and botao.Button.Border.Color == Color3.fromRGB(160, 132, 79) then
				firetouchinterest(touch, botao.Button, 0)
				firetouchinterest(touch, botao.Button, 1)
			end
		wait(TempCarbo)
	end
end
local function UpgN()
local touch = game.Players.LocalPlayer.Character.HumanoidRootPart
	while _G.UpgN == true do
		for _, botao in pairs(workspace.Map.Buttons:GetChildren()) do
			if botao.Name ~= "Nitrogonize" and botao.UpgradeType.Value == "Oxygen" and botao.Button.Transparency ~= 1 and botao.Button.Border.Color == Color3.fromRGB(9, 137, 207) then
				firetouchinterest(touch, botao.Button, 0)
				firetouchinterest(touch, botao.Button, 1)
			end
		end
		wait(0.1)
	end
end
local function Nitrogenar()
local touch = game.Players.LocalPlayer.Character.HumanoidRootPart
	while _G.Nitrogenar == true do
		local botao = workspace.Map.Buttons.Nitrogonize
		if botao.UpgradeType.Value == "Oxygen" and botao.Button.Transparency ~= 1 and botao.Button.Border.Color == Color3.fromRGB(9, 137, 207) then
				firetouchinterest(touch, botao.Button, 0)
				firetouchinterest(touch, botao.Button, 1)
			end
		wait(TempNgnar)
	end
end


-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Oxygen")
local Toggle =  Menu:CreateToggle({
   Name = "Upgrade Oxygen",
   CurrentValue = false,
   Callback = function(Value)
   	_G.UpgOx = Value
   	UpgOx()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Upgrade Carbon Oxygen",
   CurrentValue = false,
   Callback = function(Value)
   	_G.UpgCaOx = Value
   	UpgCaOx()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Carbonize",
   CurrentValue = false,
   Callback = function(Value)
   	_G.Carbonizar = Value
   	Carbonizar()
   end,
})
local Input = Menu:CreateInput({
   Name = "Carbonize Cooldown",
   CurrentValue = "",
   PlaceholderText = "Number in seconds > Example: 2.5",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	TempCarbo = Text
   end,
})
local Section = Menu:CreateSection("Nitrogen")
local Toggle =  Menu:CreateToggle({
   Name = "Upgrade Nitrogen",
   CurrentValue = false,
   Callback = function(Value)
   	_G.UpgN = Value
   	UpgN()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Nitrogonize",
   CurrentValue = false,
   Callback = function(Value)
   	_G.Nitrogenar = Value
   	Nitrogenar()
   end,
})
local Input = Menu:CreateInput({
   Name = "Nitrogonize Cooldown",
   CurrentValue = "",
   PlaceholderText = "Number in seconds > Example: 2.5",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	TempNgnar = Text
   end,
})