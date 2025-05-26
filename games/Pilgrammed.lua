local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Pilgrammed",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoChest = false
getgenv().PlayerESP = false
-- Movement
local WalkSpeedText = 16
local JumpPowerText = 50
_G.SetWalkSpeed = false
_G.SetJumpPower = false
_G.InfJump = false
_G.NoClip = false

local function PlayerESP()
	while getgenv().PlayerESP == true do
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player then
				if player ~= game.Players.LocalPlayer.Character then
					if player:FindFirstChild("LuzESP") then
						if player.LuzESP.Enabled == false then
							player.LuzESP.Enabled = true
						end
					else
						local highlight = Instance.new("Highlight")
						highlight.Name = "LuzESP"
						highlight.FillColor = Color3.fromRGB(255, 125, 0)
						highlight.OutlineColor = Color3.fromRGB(255, 125, 0)
						highlight.FillTransparency = 0.6
						highlight.Adornee = player
						highlight.Parent = player
					end
					if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Head") and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local distance = player.Name .. " [" .. math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.HumanoidRootPart.Position).Magnitude) .. " Studs]"
						if player.Head:FindFirstChild("NameESP") then
							if player.Head.NameESP.TextESP.Text ~= distance then
								player.Head.NameESP.TextESP.Text = distance
							end
						else
							local bgui = Instance.new("BillboardGui", player.Head)
	            bgui.Name = "NameESP"
	            bgui.AlwaysOnTop = true
	            bgui.ExtentsOffset = Vector3.new(0, 3, 0)
	            bgui.Size = UDim2.new(0, 200, 0, 50)
	            bgui.MaxDistance = 1500
	            if not player.Head.NameESP:FindFirstChild("TextESP") then
	            	local nam = Instance.new("TextLabel", bgui)
	            	nam.Name = "TextESP"
	            	nam.Text = distance
	            	nam.BackgroundTransparency = 1
	            	nam.TextSize = 15
	            	nam.Font = Enum.Font.GothamBold
	            	nam.TextColor3 = Color3.fromRGB(255, 125, 0)
	            	nam.Size = UDim2.new(0, 200, 0, 50)
		          end
						end
					end
				end
			end
		end
		wait(0.01)
	end
	if getgenv().PlayerESP == false then
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player and player:FindFirstChild("LuzESP") then
				if player.LuzESP.Enabled == true then
					player.LuzESP.Enabled = false
				end
			end
			if players and player and player:FindFirstChild("Head") and player.Head:FindFirstChild("NameESP") then
				player.Head.NameESP:Destroy()
			end
		end
	end
end

local function SetWalkSpeed()
	while _G.SetWalkSpeed == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
		end
		wait(0.01)
	end
	if _G.SetWalkSpeed == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
	end
end
local function SetJumpPower()
	while _G.SetJumpPower == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower ~= JumpPowerText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = JumpPowerText
		end
		wait(0.01)
		end
	if _G.SetJumpPower == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
	end
end
local function InfJump()
	while _G.InfJump == true do
		game:GetService("UserInputService").JumpRequest:connect(function()
			if _G.InfJump == true then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			end
		end)
		wait(0.1)
	end
end
local function NoClip()
	while _G.NoClip == true do
		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				if _G.NoClip then
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
local Settings = {
  Mirror = "Select a Mirror",
  Player = "Select a Player",
  IsBusy = false,
  Position = ""
}
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function ReturnThing(type)
  local Names = {}
  
  if type == "Mirrors" then
    for _, mirror in pairs(workspace.Mirrors:GetChildren()) do
      table.insert(Names, mirror.Name)
    end
  elseif type == "Players" then
    for _, player in pairs(game.Players:GetPlayers()) do
      if player ~= eu then
        table.insert(Names, player.Name)
      end
    end
  end
  
  return Names
end
local function Teleport(type)
  pcall(function()
    if type == "Player" then
      if Settings.Player == "Select a Player" then
        Rayfield:Notify({
          Title = "Nothing is selected!",
          Content = "Select a player to teleport.",
          Duration = 3,
          Image = 17091459839,
        })
      else
        for _, player in pairs(game.Players:GetPlayers()) do
          if player.Name == Settings.Player then
            eu.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
          end
        end
      end
    elseif type == "Mirror" then
      if Settings.Mirror == "Select a Mirror" then
        Rayfield:Notify({
          Title = "Nothing is selected!",
          Content = "Select a mirror to teleport.",
          Duration = 3,
          Image = 17091459839,
        })
      else
        for _, mirror in pairs(workspace.Mirrors:GetChildren()) do
          if mirror:IsA("Model") and mirror.Name == Settings.Mirror then
            eu.Character.HumanoidRootPart.CFrame = mirror.WorldPivot or mirror.WorldPivot.Position
          end
        end
      end
    end
  end)
end
local function AutoChest()
  Settings.Position = eu.Character.HumanoidRootPart.CFrame
  while getgenv().AutoChest and not Settings.IsBusy and task.wait() do
    pcall(function()
-- workspace.Chests.Forest.Root
-- workspace.Chests.Forest.ProximityPrompt
-- workspace.GoldChests.Viking.Root.ProximityPrompt
      for _, vip in pairs(workspace.GoldChests:GetChildren()) do
        if vip:IsA("Model") and not Settings.IsBusy then
          Settings.IsBusy = true
          Settings.Position = eu.Character.HumanoidRootPart.CFrame
          
          eu.Character.HumanoidRootPart.CFrame = vip.WorldPivot or vip.WorldPivot.Position
          task.wait(0.3)
          fireproximityprompt(vip.Root.ProximityPrompt)
          task.wait(0.1)
          eu.Character.HumanoidRootPart.CFrame = Settings.Position
          task.wait(0.1)
          Settings.IsBusy = false
        end
      end
    end)
  end
  if not getgenv().AutoChest then
    pcall(function()
      eu.Character.HumanoidRootPart.CFrame = Settings.Position
    end)
  end
end

-- Teleport
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Chests",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoChest = Value
   	AutoChest()
   end,
})

Section = Menu:CreateSection("Visuals", "eye")
local Toggle =  Menu:CreateToggle({
    Name = "ESP Players",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().PlayerESP = Value
        PlayerESP()
    end,
 })


-- Teleport
local TPsTab = Window:CreateTab("Teleport", "shell")
Section = TPsTab:CreateSection("Teleport to Mirror")
--[[
  Button = TPsTab:CreateButton({
    Name = "Unlock All Mirrors",
    Callback = function()
    	for _, mirror in pairs(ReturnThing("Mirrors")) do
      game:GetService("ReplicatedStorage").Remotes.Mirror:FireServer(mirror)
    	end
    	Rayfield:Notify({
      Title = "Done!",
      Content = "Unlocked all the mirrors!",
      Duration = 3,
      Image = 17091459839,
    })
    end,
})
--]]
MirDrop = TPsTab:CreateDropdown({
   Name = "Selected Mirror",
   Options = ReturnThing("Mirrors"),
   CurrentOption = {Settings.Mirror},
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.Mirror = Options[1]
   end,
})
Button = TPsTab:CreateButton({
   Name = "Teleport to Mirror",
   Callback = function()
   	Teleport("Mirror")
   end,
})
Button = TPsTab:CreateButton({
   Name = "Update List",
   Callback = function()
   	MirDrop:Refresh(ReturnThing("Mirrors"))
   	Settings.Mirror = "Select a Mirror"
   	MirDrop:Set({Settings.Mirror})
   	Rayfield:Notify({
      Title = "Done!",
      Content = "Updated the mirrors list!",
      Duration = 3,
      Image = 17091459839,
    })
   end,
})
Section = TPsTab:CreateSection("Teleport to Player")
PlayDrop = TPsTab:CreateDropdown({
   Name = "Selected Player",
   Options = ReturnThing("Players"),
   CurrentOption = {Settings.Player},
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.Player = Options[1]
   end,
})
Button = TPsTab:CreateButton({
   Name = "Teleport to Player",
   Callback = function()
   	Teleport("Player")
   end,
})
Button = TPsTab:CreateButton({
   Name = "Update List",
   Callback = function()
   	PlayDrop:Refresh(ReturnThing("Players"))
   	Settings.Player = "Select a Player"
   	PlayDrop:Set({Settings.Player})
   	Rayfield:Notify({
      Title = "Done!",
      Content = "Updated the players list!",
      Duration = 3,
      Image = 17091459839,
    })
   end,
})

local M = Window:CreateTab("Movement", "move")
local Section = M:CreateSection("Player", "person-standing")

local Input = M:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "16",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Toggle = M:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	_G.SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = M:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	_G.NoClip = Value
   	NoClip()
   end,
})
local Section = M:CreateSection("Jump")
local Input = M:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
local Toggle = M:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	_G.SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = M:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	_G.InfJump = Value
   	InfJump()
   end,
})
