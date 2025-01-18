-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Classic%20Tycoon.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Classic Tycoon",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Locais
getgenv().AutoBuy = false
getgenv().AutoCollect = false

-- Funções
-- game.Players.LocalPlayer.leaderstats.Money.Value
-- workspace.Tycoons.Green.Buttons["Large Generator"].Bought.Value == true
-- workspace.Tycoons.Green.Buttons["Large Generator"].IsButtonVisible.Value == true
-- workspace.Tycoons.Green.Buttons["Large Generator"].Price.Value
local function AutoBuy()
	while getgenv().AutoBuy == true do
		for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
			if tycoon.Owner.Value == game.Players.LocalPlayer then
				for _, botao in pairs(tycoon.Buttons:GetChildren()) do
					if botao:FindFirstChild("Price") then
						if botao.IsButtonVisible.Value == true and botao.Bought.Value == false and botao.Price.Value <= game.Players.LocalPlayer.leaderstats.Money.Value then
							for _, tt in pairs(botao:GetDescendants()) do
								if tt.Name == "TouchInterest" then
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, tt.Parent, 0)
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, tt.Parent, 1)
									break
								end
							end
						end
					end
				end
			end
		end
		wait(0.33)
	end
end
local function AutoCollect()
	while getgenv().AutoCollect == true do
		for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
			if tycoon.Owner.Value == game.Players.LocalPlayer then
				for _, ti in pairs(tycoon.Build.Collect:GetDescendants()) do
					if ti.Name == "TouchInterest" then
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, ti.Parent, 0)
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, ti.Parent, 1)
					end
				end
			end
		end
		wait(1)
	end
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Money",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCollect = Value
   	AutoCollect()
   end,
})
local Section = Menu:CreateSection("Upgrade")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoBuy = Value
   	AutoBuy()
   end,
})