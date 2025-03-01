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
getgenv().AutoSlash = false
getgenv().KnifeTrigger = false
getgenv().EquipKnife = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  TriggerbotCooldown = 3,
  SlashCooldown = 0.9,
  SpamSoundCooldown = 0.2,
  KnifeCooldown = 1,
  IgnoreWalls = false,
  KnifeMethod = "Single Target"
}
local HitSize = 5
local IsCooldown = false
local CorInocente = Color3.fromRGB(255, 125, 0)

-- Funções
local function EquipKnife()
  while getgenv().EquipKnife and task.wait(0.01) do
    pcall(function()
      for _, tool in pairs(eu.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Slash") and tool:FindFirstChild("Throw") then
          tool.Parent = eu.Character
        end
      end
    end)
  end
end
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
      for _, tool in pairs(eu.Character:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("fire") then
          tool.fire:FireServer()
        end
      end
    end)
    wait(Settings.SpamSoundCooldown)
  end
end
local function Triggerbot()
    -- Variáveis locais
    local Players = game:GetService("Players")
    local Workspace = game.Workspace
    local LocalPlayer = Players.LocalPlayer
    -- Função principal do Triggerbot
    while getgenv().Triggerbot do
        task.wait(0.01) -- Intervalo para evitar uso excessivo de CPU
        -- Iterar sobre todos os jogadores
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer 
                and player:GetAttribute("Game") == LocalPlayer:GetAttribute("Game")
                and player:GetAttribute("Team") ~= LocalPlayer:GetAttribute("Team") then
                local character = player.Character
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    -- Verificar se o raio atinge o jogador
                    local camera = Workspace.CurrentCamera
                    if camera then
                        local rayOrigin = camera.CFrame.Position
                        local rayDirection = (rootPart.Position - rayOrigin).Unit * 1000
                        local ray = Ray.new(rayOrigin, rayDirection)
                        local hit, _ = Workspace:FindPartOnRay(ray, LocalPlayer.Character)
                        if hit and hit.Parent == rootPart.Parent then
                            -- Iterar sobre as ferramentas do jogador local
                            local localCharacter = LocalPlayer.Character
                            if localCharacter then
                                for _, tool in ipairs(localCharacter:GetChildren()) do
                                    if not IsCooldown 
                                        and tool:IsA("Tool") 
                                        and tool:FindFirstChild("Handle") 
                                        and tool:FindFirstChild("showBeam") 
                                        and tool:FindFirstChild("kill") 
                                        and tool:FindFirstChild("fire") then
                                        local handle = tool.Handle
                                        -- Ativar as funções da ferramenta
                                        tool.fire:FireServer()
                                        tool.showBeam:FireServer(character.HumanoidRootPart.Position, handle.Position, handle)
                                        tool.kill:FireServer(player, Vector3.new(player.Character.Head.Position))
                                        
                                        -- Definir cooldown após o disparo
                                        IsCooldown = true
                                        task.spawn(function()
                                            task.wait(Settings.TriggerbotCooldown) -- Cooldown de 3 segundos
                                            IsCooldown = false
                                        end)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
local function AutoSlash()
  while getgenv().AutoSlash do
    pcall(function()
      for _, tool in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren() or game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Slash") then
          tool.Slash:FireServer()
        end
      end
    end)
    task.wait(Settings.SlashCooldown)
  end
end
local function KnifeTrigger()
    while getgenv().KnifeTrigger do
        pcall(function()
            local players = game:GetService("Players"):GetPlayers()
            for _, p in ipairs(players) do
                if p ~= eu and 
                   p:GetAttribute("Game") == eu:GetAttribute("Game") and 
                   p:GetAttribute("Team") ~= eu:GetAttribute("Team") then

                    local targetChar = p.Character
                    local euChar = eu.Character
                    if targetChar and euChar and 
                       targetChar:FindFirstChild("HumanoidRootPart") and 
                       euChar:FindFirstChild("HumanoidRootPart") then

                        local targetPos = targetChar.HumanoidRootPart.Position
                        local euPos = euChar.HumanoidRootPart.Position
                        local canThrow = true

                        if not Settings.IgnoreWalls then
                            local direction = (targetPos - euPos).unit * 500
                            local rayParams = RaycastParams.new()
                            rayParams.FilterDescendantsInstances = {euChar}
                            rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                            local rayResult = workspace:Raycast(euPos, direction, rayParams)
                            if rayResult then
                                canThrow = false
                            end
                        end

                        if canThrow then
                            -- Agrupa ferramentas do personagem e da mochila
                            local tools = {}
                            for _, tool in ipairs(euChar:GetChildren()) do
                                table.insert(tools, tool)
                            end

                            for _, tool in ipairs(tools) do
                                if tool:IsA("Tool") and tool:FindFirstChild("Throw") then
                                    local cf = CFrame.new(targetPos)
                                    tool.Throw:FireServer(cf, targetPos, euPos)
                                    if Settings.KnifeMethod == "Single Target" then
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(Settings.KnifeCooldown)
    end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Player ESP")
Toggle =  Menu:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().PlayerESP = Value
   	PlayerESP()
   end,
})
ColorPicker = Menu:CreateColorPicker({
    Name = "ESP Color",
    Color = CorInocente,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorInocente = Value
    end
})
Section = Menu:CreateSection("Hitbox Expander")
Input = Menu:CreateInput({
   Name = "Hitbox Size",
   CurrentValue = "",
   PlaceholderText = "Default HitBox Size = 5",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	HitSize = Text
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Expand Hitboxes",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().HitBox = Value
   	HitBox()
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

local GunTab = Window:CreateTab("Gun", "skull")
Section = GunTab:CreateSection("Undetectable")
Toggle = GunTab:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Triggerbot = Value
   	Triggerbot()
   end,
})
Input = GunTab:CreateInput({
   Name = "Cooldown",
   CurrentValue = "3",
   PlaceholderText = "Value in seconds",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	Settings.TriggerbotCooldown = tonumber(Text)
   end,
})
Section = GunTab:CreateSection("Blatant")
Button = GunTab:CreateButton({
   Name = "Kill All",
   Callback = function()
   	KillGun()
   end,
})
Toggle =  GunTab:CreateToggle({
   Name = "Auto Kill All",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoGun = Value
   	AutoGun()
   end,
})
Toggle =  GunTab:CreateToggle({
   Name = "Auto Equip Gun",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().PullGun = Value
   	PullGun()
   end,
})
Section = GunTab:CreateSection("Misc")
Toggle =  GunTab:CreateToggle({
   Name = "Spam Sound (FE)",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().GunSound = Value
   	GunSound()
   end,
})
Input = GunTab:CreateInput({
   Name = "Sound Cooldown",
   CurrentValue = "0.2",
   PlaceholderText = "Value in seconds",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	Settings.SpamSoundCooldown = tonumber(Text)
   end,
})

local KnifeTab = Window:CreateTab("Knife", "sword")
Section = KnifeTab:CreateSection("Legit")
Toggle =  KnifeTab:CreateToggle({
   Name = "Auto Equip.Knife",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().EquipKnife = Value
   	EquipKnife()
   end,
})
Toggle =  KnifeTab:CreateToggle({
   Name = "Auto Slash",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoSlash = Value
   	AutoSlash()
   end,
})
Input = KnifeTab:CreateInput({
   Name = "Slash Cooldown",
   CurrentValue = "1",
   PlaceholderText = "Value in seconds",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	Settings.SlashCooldown = tonumber(Text)
   end,
})
Section = KnifeTab:CreateSection("Undetectable")
Toggle =  KnifeTab:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().KnifeTrigger = Value
   	KnifeTrigger()
   end,
})
Dropdown = KnifeTab:CreateDropdown({
   Name = "Shoot Mode",
   Options = {"Single Target", "Multiple Targets"},
   CurrentOption = {"Single Target"},
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.KnifeMethod = Options[1]
   end,
})
Toggle =  KnifeTab:CreateToggle({
   Name = "Ignore Walls",
   CurrentValue = false,
   Callback = function(Value)
   	Settings.IgnoreWalls = Value
   end,
})
Input = KnifeTab:CreateInput({
   Name = "Cooldown",
   CurrentValue = "1",
   PlaceholderText = "Value in seconds",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	Settings.KnifeCooldown = tonumber(Text)
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

while true do
  if getgenv().Triggerbot then
    getgenv().Triggerbot = false
    getgenv().Triggerbot = true
    Triggerbot()
    print("Atualizado o Triggerbot!")
  end
  wait(60)
end