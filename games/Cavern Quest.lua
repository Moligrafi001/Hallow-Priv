local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Cavern Quest",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().KillAura = false
getgenv().MobsESP = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local ColorESP = Color3.fromRGB(255, 125, 0)

-- Funções
local function KillAura()
  while getgenv().KillAura and task.wait(0.25) do
    pcall(function()
      local Targets = {}
      for _, npc in pairs(workspace.Npc:GetChildren()) do
        table.insert(Targets, npc)
      end
      eu.Character.RE:FireServer("UseSkill", { ComboIndex = 1, UUID = "{9}", Slot = "NormalSkill", TargetList = Targets, SkillId = "SC_normal_sword_1" })
    end)
  end
end
local function MobsESP()
  while getgenv().MobsESP and task.wait(0.1) do
    pcall(function()
      for _, npc in pairs(workspace.Npc:GetChildren()) do
        if npc.Highlight.Enabled == true then
          if npc.Highlight.FillColor ~= ColorESP or npc.Highlight.OutlineColor ~= ColorESP then
            npc.Highlight.FillColor, npc.Highlight.OutlineColor = ColorESP, ColorESP
          end
        else
          npc.Highlight.Enabled = true
        end
      end
    end)
  end
  if not getgenv().MobsESP then
    pcall(function()
      for _, npc in pairs(workspace.Npc:GetChildren()) do
        if npc.Highlight.Enabled == true then
          npc.Highlight.Enabled = false
        end
      end
    end)
  end
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Combat")
Toggle =  Menu:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().KillAura = Value
   	KillAura()
   end,
})
Section = Menu:CreateSection("Visual")
Toggle =  Menu:CreateToggle({
   Name = "ESP Enemies",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().MobsESP = Value
   	MobsESP()
   end,
})
ColorPicker = Menu:CreateColorPicker({
   Name = "Highlight Color",
   Color = ColorESP,
   Callback = function(Value)
  	ColorESP = Value
   end
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