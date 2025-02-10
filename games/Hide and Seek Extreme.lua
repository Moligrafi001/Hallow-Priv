-- workspace.GameObjects:GetChildren()[5]:GetChildren()[5]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Hide and Seek Extreme",
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
	  pcall(function()
  		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
  			if part:IsA("BasePart") then
  				if getgenv().NoClip then
  					part.CanCollide = false
  				else
  					part.CanCollide = true
  				end
  			end
  		end
		end)
		wait(0.1)
	end
end

-- Valores
getgenv().AutoCredit = false
getgenv().PlayerESP = false
getgenv().CoinESP = false
getgenv().AutoCapture = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local CorInocente = Color3.fromRGB(255, 125, 0)
local CorBesta = Color3.fromRGB(255, 0, 0)
local CorMoeda = Color3.fromRGB(245, 233, 66)

-- Funções
local function GetCredit()
  if not (eu and eu.PlayerData and eu.PlayerData.InGame and eu.PlayerData.InGame.Value) then
    return
  end

  local character = eu.Character
  local humanoidRoot = character and character:FindFirstChild("HumanoidRootPart")
  if not humanoidRoot then
    return
  end

  for _, credit in ipairs(workspace.GameObjects:GetChildren()) do
    if credit:FindFirstChild("TouchInterest") and credit.Name == "Credit" then
      firetouchinterest(humanoidRoot, credit, 0)
      firetouchinterest(humanoidRoot, credit, 1)
      task.wait(0.05)
    end
  end
end
local function AutoCredit()
  while getgenv().AutoCredit do
    local success, err = pcall(GetCredit)
    if not success then
      warn("Erro ao coletar créditos:", err)
    end
    task.wait(1.5)
  end
end
local function CaptureAll()
  pcall(function()
    for _, player in pairs(game.Players:GetPlayers()) do
      if player ~= eu and player.PlayerData.It.Value == false and player.PlayerData.InGame.Value == true and eu.PlayerData.It.Value == true then
        firetouchinterest(eu.Character.HumanoidRootPart, player.Character.HumanoidRootPart, 0)
        firetouchinterest(eu.Character.HumanoidRootPart, player.Character.HumanoidRootPart, 1)
        print("Toquei em" .. player.Name)
      end
      wait(0.09)
    end
  end)
end
local function AutoCapture()
  while getgenv().AutoCapture do
    pcall(function()
      CaptureAll()
    end)
    wait(1)
  end
end
local function PlayerESP()
	while getgenv().PlayerESP == true do
	  pcall(function()
  		for _, player in pairs(game:GetService("Players"):GetPlayers()) do
  		  if player ~= eu and player.PlayerData.InGame.Value == true then
  				if player.Character:FindFirstChild("Highlight") then
  					if player.Character.Highlight.Enabled == false then
  						player.Character.Highlight.Enabled = true
  					end
  					if player.PlayerData.It.Value == false then
  					  if player.Character.Highlight.FillColor ~= CorInocente or player.Character.Highlight.OutlineColor ~= CorInocente then
    					  player.Character.Highlight.FillColor = CorInocente
    					  player.Character.Highlight.OutlineColor = CorInocente
    					end
  					else
  					  if player.Character.Highlight.FillColor ~= CorBesta or player.Character.Highlight.OutlineColor ~= CorBesta then
    					  player.Character.Highlight.FillColor = CorBesta
    					  player.Character.Highlight.OutlineColor = CorBesta
    					end
  					end
  				else
  					local highlight = Instance.new("Highlight")
  					highlight.FillColor = CorInocente
  					highlight.OutlineColor = CorInocente
  					highlight.FillTransparency = 0.6
  					highlight.Adornee = player.Character
  					highlight.Parent = player.Character
  				end
  			end
  		end
		end)
		wait(0.33)
	end
	if getgenv().PlayerESP == false then
	  pcall(function()
  		for _, player in pairs(game.Players:GetPlayers()) do
  		  if player:FindFirstChild("Highlight") then
  				if player.Character.Highlight.Enabled == true then
  					player.Character.Highlight.Enabled = false
  				end
			  end
  		end
		end)
	end
end
local function CoinESP()
	while getgenv().CoinESP == true do
	  pcall(function()
  		for _, credit in ipairs(workspace.GameObjects:GetChildren()) do
      if credit:FindFirstChild("TouchInterest") and credit.Name == "Credit" then
  				if credit:FindFirstChild("Highlight") then
  					if credit.Highlight.Enabled == false then
  						credit.Highlight.Enabled = true
  					end
  					  if credit.Highlight.FillColor ~= CorMoeda or credit.Highlight.OutlineColor ~= CorMoeda then
    					  credit.Highlight.FillColor = CorMoeda
    					  credit.Highlight.OutlineColor = CorMoeda
    					end
  				else
  					local highlight = Instance.new("Highlight")
  					highlight.FillColor = CorMoeda
  					highlight.OutlineColor = CorMoeda
  					highlight.FillTransparency = 0.6
  					highlight.Adornee = credit
  					highlight.Parent = credit
  				end
  			end
  		end
		end)
		wait(0.33)
	end
	if getgenv().CoinESP == false then
	  pcall(function()
  		for _, credit in ipairs(workspace.GameObjects:GetChildren()) do
        if credit:FindFirstChild("TouchInterest") and credit.Name == "Credit" then
  				if credit.Highlight.Enabled == true then
  					credit.Highlight.Enabled = false
  				end
  			end
  		end
		end)
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Credits",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCredit = Value
   	AutoCredit()
   end,
})
Button =  Menu:CreateButton({
   Name = "Collect Credits",
   Callback = function(Value)
   	GetCredit()
   end,
})
Section = Menu:CreateSection("Seeker")
Toggle =  Menu:CreateToggle({
   Name = "Auto Capture Everyone",
   CurrentValue = false,
   Callback = function(Value)
     getgenv().AutoCapture = Value
   	AutoCapture()
   end,
})
Button =  Menu:CreateButton({
   Name = "Capture Everyone",
   Callback = function(Value)
   	if eu.PlayerData.It.Value == true and eu.PlayerData.InGame.Value == true then
   	  CaptureAll()
    elseif eu.PlayerData.InGame.Value == false then
      Rayfield:Notify({
        Title = "Hey, wait!",
        Content = "You are not alive.",
        Duration = 2.6,
        Image = 17091459839,
      })
    elseif eu.PlayerData.It.Value == false then
      Rayfield:Notify({
        Title = "Hey, wait!",
        Content = "You are not the seeker.",
        Duration = 2.6,
        Image = 17091459839,
      })
    end
   end,
})

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")
Section = VisualTab:CreateSection("ESP Player")
Toggle =  VisualTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().PlayerESP = Value
   	PlayerESP()
   end,
})
ColorPicker = VisualTab:CreateColorPicker({
    Name = "Hiders Color",
    Color = CorInocente,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorInocente = Value
    end
})
ColorPicker = VisualTab:CreateColorPicker({
    Name = "Seeker Color",
    Color = CorBesta,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorBesta = Value
    end
})
Section = VisualTab:CreateSection("ESP Item")
Toggle =  VisualTab:CreateToggle({
   Name = "Coins ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().CoinESP = Value
   	CoinESP()
   end,
})
ColorPicker = VisualTab:CreateColorPicker({
    Name = "Seeker Color",
    Color = CorMoeda,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorMoeda = Value
    end
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