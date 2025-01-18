-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Ore%20Factory%20Tycoon.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Ore Factory Tycoon",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoClick = false
getgenv().GetItems = false
getgenv().AutoCollect = false

-- Funções
local Cash = game.Players.LocalPlayer.leaderstats.Cash.Value
-- workspace.Tycoon2.TycoonPreset.OwnerNameTycoon1.SurfaceGui.TextLabel
-- workspace.Tycoon2.TycoonUpgrades.Dropper1ClickTycoon1.Button.ClickDetector
-- workspace.Tycoon2.TycoonPreset.CashCollectorMachineTycoon1.CashCollectorPad.CollectCash
-- workspace.Items.SpeedChip
local function AutoClick()
	while getgenv().AutoClick == true do
		for _, tycoon in pairs(workspace:GetChildren()) do
			for numero = 1, 8 do
				if tycoon.Name == "Tycoon" .. numero then
					if tycoon.TycoonPreset.OwnerNameTycoon1.SurfaceGui.TextLabel.Text == game.Players.LocalPlayer.Name .. "'s Tycoon" then
						if tycoon.TycoonUpgrades:FindFirstChild("Dropper1ClickTycoon1") then
							for _, click in pairs(tycoon.TycoonUpgrades.Dropper1ClickTycoon1:GetDescendants()) do
								if click:IsA("ClickDetector") then
									fireclickdetector(click)
								end
							end
						end
					end
				end
			end
		end
		wait(0.01)
	end
end
local function GetItems()
	pcall(function()
		while getgenv().GetItems == true do
			for _, item in pairs(workspace.Items:GetChildren()) do
				if item:IsA("Model") then
					for _, pp in pairs(item:GetDescendants()) do
						if pp:IsA("ProximityPrompt") then
							if pp.Parent.CFrame then
								game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("Hallow_Hub", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
								wait(0.2)
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pp.Parent.CFrame
								wait(0.2)
								fireproximityprompt(pp)
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("Hallow_Hub")
							break
							end
						end
					end
				end
			end
			wait(0.1)
		end
	end)
end
local function AutoCollect()
	while getgenv().AutoCollect == true do
		for _, tycoon in pairs(workspace:GetChildren()) do
			for numero = 1, 8 do
				if tycoon.Name == "Tycoon" .. numero then
					if tycoon.TycoonPreset.OwnerNameTycoon1.SurfaceGui.TextLabel.Text == game.Players.LocalPlayer.Name .. "'s Tycoon" then
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, tycoon.TycoonPreset.CashCollectorMachineTycoon1.CashCollectorPad.CollectCash, 0)
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, tycoon.TycoonPreset.CashCollectorMachineTycoon1.CashCollectorPad.CollectCash, 1)
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
local Toggle = Menu:CreateToggle({
   Name = "Auto Collect Money",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCollect = Value
   	AutoCollect()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Auto Click Dropper",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoClick = Value
   	AutoClick()
   end,
})
local Section = Menu:CreateSection("Auto Farm")
local Toggle = Menu:CreateToggle({
   Name = "Auto Collect Items",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().GetItems = Value
   	GetItems()
   end,
})