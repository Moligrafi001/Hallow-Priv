-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Find%20Buttons.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Find Buttons!👀",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
_G.AutoSkip = false

-- Funções
local function SkipStage()
	local PlayerStage = game.Players.LocalPlayer.leaderstats.Easy.Value
  for _, button in pairs(workspace.Game.Buttons:GetChildren()) do
  	if button:FindFirstChild("ButtonLevel") and button.ButtonLevel.Value == PlayerStage then
  		local clickPart = button:FindFirstChild("ClickPart")
  		if clickPart and clickPart:FindFirstChild("ClickDetector") then
  				fireclickdetector(clickPart.ClickDetector)
  			return
				end
			end
		end
end
local function AutoSkip()
	while _G.AutoSkip == true do
		SkipStage()
		wait(0.15)
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Stage")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Skip Stage",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoSkip = Value
   	AutoSkip()
   end,
})
local Button = Menu:CreateButton({
   Name = "Skip Stage",
   Callback = function()
       SkipStage()
    end,
})