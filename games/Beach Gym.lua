local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | BaBGaPBW",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoTrain = false
getgenv().AutoBuy = false
getgenv().Win1 = false
getgenv().Win2 = false

-- Locais
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function AutoTrain()
  while getgenv().AutoTrain do
    game:GetService("ReplicatedStorage").Remotes.Trick:FireServer("Train")
    wait(0.1)
  end
end
local function AutoBuy()
  while getgenv().AutoBuy do
    for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
      if tycoon:GetAttribute("Owner") == eu.Name then
        for _, button in pairs(tycoon.Buttons:GetChildren()) do
          if button.Touch.Transparency == 0 and button.Touch.Color == Color3.fromRGB(34, 159, 61) and not button.Touch:FindFirstChild("Attachment") then
            firetouchinterest(eu.Character.HumanoidRootPart, button.Touch, 0)
            firetouchinterest(eu.Character.HumanoidRootPart, button.Touch, 1)
            break
          end
        end
      end
    end
    wait(1)
  end
end
local function Win1()
	local Busy = false
	while getgenv().Win1 == true do
		if Busy == false then
			game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("EasyPosition", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
		end
		if workspace.Obbystuff["3MinCD"].SurfaceGui.Enabled == false then
			Busy = true
			wait(0.25)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Obbystuff["3Min"], 0)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Obbystuff["3Min"], 1)
			wait(0.25)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("EasyPosition")
			Busy = false
		end
		wait(0.50)
	end
end
local function Win2()
	local Busy = false
	while getgenv().Win2 == true do
		if Busy == false then
			game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("MediumPosition", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
		end
		if workspace.Obbystuff["5MinCD"].SurfaceGui.Enabled == false then
			Busy = true
			wait(0.25)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Obbystuff["5Min"], 0)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Obbystuff["5Min"], 1)
			wait(0.25)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("MediumPosition")
			Busy = false
		end
		wait(0.50)
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Train",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoTrain = Value
   	AutoTrain()
   end,
})
Section = Menu:CreateSection("Upgrade")
Toggle =  Menu:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoBuy = Value
   	AutoBuy()
   end,
})
Section = Menu:CreateSection("Auto Obby")
Toggle =  Menu:CreateToggle({
   Name = "3 Min Obby",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Win1 = Value
   	Win1()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "5 Min Obby",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Win2 = Value
   	Win2()
   end,
})