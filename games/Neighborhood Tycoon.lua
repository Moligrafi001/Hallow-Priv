local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Neighborhood Tycoon",
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

-- Locais
local eu = game:GetService("Players").LocalPlayer

-- Valores
getgenv().AutoUpg = false
getgenv().AutoCollect = false
getgenv().AutoNPC = false
getgenv().NoCdNPC = false

-- Funções
local function AutoUpg()
  while getgenv().AutoUpg == true do
    pcall(function()
      for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
       if tycoon.OwnerId.Value == eu.UserId then
         for _, button in pairs(tycoon.Buttons:GetChildren()) do
            if button.ShopId.Value == 0 and button.Price.Value <= eu.leaderstats.Cash.Value then
              pcall(function()
               firetouchinterest(eu.Character.HumanoidRootPart, button.Hit, 0)
               firetouchinterest(eu.Character.HumanoidRootPart, button.Hit, 1)
             end)
            end
          end
        end
      end
    end)
    wait(1)
  end
end
local function AutoCollect()
  while getgenv().AutoCollect == true do
    pcall(function()
      for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
        if tycoon.OwnerId.Value == eu.UserId then
          pcall(function()
            firetouchinterest(eu.Character.HumanoidRootPart, tycoon.StarterProps.Mailbox.Hitpart, 0)
            firetouchinterest(eu.Character.HumanoidRootPart, tycoon.StarterProps.Mailbox.Hitpart, 1)
          end)
        end
      end
    end)
    wait(1)
  end
end
-- workspace.Tycoons["1"].Purchases.restaurantcashier.restaurantcashier
local function AutoNPC()
  while getgenv().AutoNPC == true do
    for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
      if tycoon.OwnerId.Value == eu.UserId then
        for _, build in pairs(tycoon.Purchases:GetChildren()) do
          if build:IsA("Model") and build:FindFirstChild(build.Name) then
            for _, pp in pairs(build:GetDescendants()) do
              if pp:IsA("ProximityPrompt") and pp.Enabled == true then
                local distance = (eu.Character.HumanoidRootPart.Position - pp.Parent.Position).Magnitude
                if distance <= 7 then
                  fireproximityprompt(pp)
                end
              end
            end
          end
          if build:IsA("Model") and build:FindFirstChild("NPCs") then
            for _, npc in pairs(build.NPCs:GetChildren()) do
              pcall(function()
                local distance = (eu.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude
                if distance <= 7 then
                  for _, pp in pairs(npc:GetDescendants()) do
                    if pp:IsA("ProximityPrompt") and pp.Enabled == true then
                      fireproximityprompt(pp)
                    end
                  end
                end
              end)
            end
          end
        end
      end
    end
    wait()
  end
end
local function NoCdNPC()
  while getgenv().NoCdNPC == true do
    for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
      if tycoon.OwnerId.Value == eu.UserId then
        for _, build in pairs(tycoon.Purchases:GetChildren()) do
          if build:IsA("Model") and build:FindFirstChild(build.Name) then
            for _, pp in pairs(build:GetDescendants()) do
              if pp:IsA("ProximityPrompt") and pp.Enabled == false then
                pp.Enabled = true
              end
            end
          end
          if build:IsA("Model") and build:FindFirstChild("NPCs") then
            for _, npc in pairs(build.NPCs:GetChildren()) do
              for _, pp in pairs(npc:GetDescendants()) do
                if pp:IsA("ProximityPrompt") and pp.Enabled == false then
                  pp.Enabled = true
                end
              end
            end
          end
        end
      end
    end
    wait()
  end
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Money",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCollect = Value
   	AutoCollect()
   end,
})
Section = Menu:CreateSection("Upgrade")
Toggle =  Menu:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoUpg = Value
   	AutoUpg()
   end,
})

-- Interact
local InteractTab = Window:CreateTab("Interact", "mouse-pointer-click")
Section = InteractTab:CreateSection("NPCs")
Toggle =  InteractTab:CreateToggle({
   Name = "Auto Interact",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoNPC = Value
   	AutoNPC()
   end,
})
Toggle =  InteractTab:CreateToggle({
   Name = "No Cooldown",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().NoCdNPC = Value
   	NoCdNPC()
   end,
})

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
Section = MoveTab:CreateSection("Walk")
Input = MoveTab:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})
Section = MoveTab:CreateSection("Jump")
Input = MoveTab:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})