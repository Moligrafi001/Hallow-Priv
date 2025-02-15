local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | [DUELS] Murderers VS Sheriffs",
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
	  pcall(function()
  		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
  			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
  		end
		end)
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

-- Valores
getgenv().AutoGun = false
getgenv().PullGun = false
getgenv().HitBox = false
getgenv().PlayerESP = false
getgenv().GunSound = false
getgenv().AnnoyTrade = false
getgenv().CancelTrade = false
getgenv().Triggerbot = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local HitSize = 5
local IsCooldown = false
local CorInocente = Color3.fromRGB(255, 125, 0)

-- Funções
local function AnnoyTrade()
  while getgenv().AnnoyTrade do
    pcall(function()
      for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        game:GetService("ReplicatedStorage").Trade:FireServer("SENT", player)
      end
    end)
    wait(0.25)
  end
end
local function CancelTrade()
  while getgenv().CancelTrade do
    pcall(function()
      for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        game:GetService("ReplicatedStorage").Trade:FireServer("CANCEL_TRADE", player)
      end
    end)
    wait(0.25)
  end
end
local function KillGun()
  pcall(function()
    for _, player in pairs(game.Players:GetPlayers()) do
      if player ~= eu and player:GetAttribute("Game") == eu:GetAttribute("Game") and player:GetAttribute("Team") ~= eu:GetAttribute("Team") then
        for _, tool in pairs(eu.Character:GetChildren()) do
          if tool:IsA("Tool") then
          tool.kill:FireServer(player, Vector3.new(player.Character.Head.Position))
          end
        end
      end
    end
  end)
end
local function AutoGun()
  while getgenv().AutoGun == true do
    KillGun()
    wait(0.33)
  end
end
local function PullGun()
  while getgenv().PullGun == true do
    pcall(function()
      for _, tool in pairs(eu.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("kill") then
          tool.Parent = eu.Character
        end
      end
    end)
    wait(0.25)
  end
end
local function HitBox()
	while getgenv().HitBox == true do
	  pcall(function()
		for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= eu and player:GetAttribute("Game") == eu:GetAttribute("Game") and player:GetAttribute("Team") ~= eu:GetAttribute("Team") then
				if player.Character then
					if player.Character:FindFirstChild("HumanoidRootPart") then
						if player.Character.HumanoidRootPart.Size ~= Vector3.new(HitSize, HitSize, HitSize) or player.Character.HumanoidRootPart.Transparency ~= 0.6 then
							player.Character.HumanoidRootPart.Size = Vector3.new(HitSize, HitSize, HitSize)
							player.Character.HumanoidRootPart.Transparency = 0.6
							player.Character.HumanoidRootPart.CanCollide = false
						end
					end
				end
			end
		end
	  end)
		wait()
	end
	if getgenv().HitBox == false then
		for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= game.Players.LocalPlayer then
				if player.Character and game.Players.LocalPlayer.Character then
					if player.Character:FindFirstChild("HumanoidRootPart") then
						if player.Character.HumanoidRootPart.Size ~= Vector3.new(2, 2, 1) or player.Character.HumanoidRootPart.Transparency ~= 0 then
							player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
							player.Character.HumanoidRootPart.Transparency = 0
						end
					end
				end
			end
		end
	end
end
local function PlayerESP()
	while getgenv().PlayerESP == true do
	  pcall(function()
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if player and player.Parent and players:GetAttribute("Game") == eu:GetAttribute("Game") and players:GetAttribute("Team") ~= eu:GetAttribute("Team") then
				if player ~= game.Players.LocalPlayer.Character then
					if player:FindFirstChild("Highlight") then
						if player.Highlight.Enabled == false then
							player.Highlight.Enabled = true
						end
						if player.Highlight.FillColor ~= CorInocente or player.Highlight.OutlineColor ~= CorInocente then
						  player.Highlight.FillColor = CorInocente
						  player.Highlight.OutlineColor = CorInocente
						end
					else
						local highlight = Instance.new("Highlight")
						highlight.FillColor = CorInocente
						highlight.OutlineColor = CorInocente
						highlight.FillTransparency = 0.6
						highlight.Adornee = player
						highlight.Parent = player
					end
				end
			end
		end
		end)
		wait(0.33)
	end
	if getgenv().PlayerESP == false then
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if player and players:GetAttribute("Game") == eu:GetAttribute("Game") and players:GetAttribute("Team") ~= eu:GetAttribute("Team") and player:FindFirstChild("Highlight") then
				if player.Highlight.Enabled == true then
					player.Highlight.Enabled = false
				end
			end
		end
	end
end
local function GunSound()
  while getgenv().GunSound == true do
    pcall(function()
      game:GetService("Players").LocalPlayer.Character.DragonGun.fire:FireServer()
    end)
    wait(0.20)
  end
end
local function Triggerbot()
  local function RayOn(part)
      local success, result = pcall(function()
          local camera = game.Workspace.CurrentCamera
          local ray = Ray.new(camera.CFrame.Position, (part.Position - camera.CFrame.Position).unit * 1000)
          local hitPart, _ = workspace:FindPartOnRay(ray, eu.Character)
          
          return hitPart and hitPart.Parent == part.Parent
      end)
      return success and result or false
  end

  local function SetCooldown()
      if not IsCooldown then
          IsCooldown = true
          task.wait(2.5)
          IsCooldown = false
      end
  end

  while getgenv().Triggerbot and not IsCooldown do
      pcall(function()
          for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
              if player ~= eu 
                  and player:GetAttribute("Game") == eu:GetAttribute("Game")
                  and player:GetAttribute("Team") ~= eu:GetAttribute("Team") then
                  
                  local character = player.Character
                  if character and RayOn(character:FindFirstChild("HumanoidRootPart")) then
                      for _, tool in ipairs(eu.Character:GetChildren()) do
                          if not IsCooldown 
                              and tool:IsA("Tool") 
                              and tool:FindFirstChild("Handle") 
                              and tool:FindFirstChild("showBeam") 
                              and tool:FindFirstChild("kill") then

                              local handle = tool.Handle
                              tool.showBeam:FireServer(character.HumanoidRootPart.Position, handle.Position, handle)
                              tool.kill:FireServer(player, Vector3.new(player.Character.Head.Position))
                              SetCooldown()
                              break
                          end
                      end
                  end
              end
          end
      end)
      task.wait(0.1)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Gun Features")
Toggle =  Menu:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Triggerbot = Value
   	Triggerbot()
   end,
})
Button = Menu:CreateButton({
   Name = "Kill All",
   Callback = function()
   	KillGun()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Kill All",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoGun = Value
   	AutoGun()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Equip Gun",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().PullGun = Value
   	PullGun()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Spam Sound (FE)",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().GunSound = Value
   	GunSound()
   end,
})
Section = Menu:CreateSection("Misc")
Toggle =  Menu:CreateToggle({
   Name = "Annoy Trade",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AnnoyTrade = Value
   	AnnoyTrade()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Cancel Trade",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().CancelTrade = Value
   	CancelTrade()
   end,
})

-- Combat
local CombatTab = Window:CreateTab("Combat", "swords")
Toggle =  CombatTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().PlayerESP = Value
   	PlayerESP()
   end,
})
ColorPicker = CombatTab:CreateColorPicker({
    Name = "ESP Color",
    Color = CorInocente,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorInocente = Value
    end
})
Section = CombatTab:CreateSection("Hitbox Expander")
Input = CombatTab:CreateInput({
   Name = "Hitbox Size",
   CurrentValue = "",
   PlaceholderText = "Default HitBox Size = 5",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	HitSize = Text
   end,
})
Toggle =  CombatTab:CreateToggle({
   Name = "Expand Hitboxes",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().HitBox = Value
   	HitBox()
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