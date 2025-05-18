-- Library Settings
local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = false
Library.NotifySide = "Right"

-- Window & Tabs Setup
local Window = Library:CreateWindow({
  Title = 'Hallow Hub | PETAPETA',
	Center = true,
	AutoShow = true,
	Resizable = false,
	ShowCustomCursor = false,
	NotifySide = "Right",
	TabPadding = 8,
	MenuFadeTime = 0.2
})
local Tabs = {
	Main = Window:AddTab('Main'),
	Credits = Window:AddTab('Credits'),
	['UI Settings'] = Window:AddTab('UI Settings'),
}

-- Valores
getgenv().AutoInteract = false
getgenv().ItemsESP = false
getgenv().EnemyESP = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  AutoInteract = {
    Diatance = 9
  },
  Colors = {
    Box = Color3.fromRGB(59, 158, 219),
    Zeni = Color3.fromRGB(255, 255, 20),
    Key = Color3.fromRGB(0, 255, 99),
    Enemy = Color3.fromRGB(255, 0, 0)
  }
}

-- Funções
local function AutoInteract()
  while getgenv().AutoInteract and task.wait(0.1) do
    pcall(function()
      for _, pp in pairs(workspace.Server.SpawnedItems:GetDescendants()) do
        if pp:IsA("ProximityPrompt") then
          if (eu.Character.HumanoidRootPart.CFrame.Position - (pp.Parent.Position or pp.Parent.CFrame.Position)).Magnitude <= Settings.AutoInteract.Distance then
            fireproximityprompt(pp)
          end
        end
      end
    end)
  end
end
local function ItemsESP()
  while getgenv().ItemsESP and task.wait(0.1) do
    pcall(function()
      for _, item in pairs(workspace.Server.SpawnedItems:GetChildren()) do
        if item:FindFirstChild("Luz") then
          if item.Luz.Enabled == false then
            item.Luz.Enabled = true
          elseif item.Luz.DepthMode ~= Enum.HighlightDepthMode.AlwaysOnTop then
            item.Luz.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
          end
        else
          local highlight = Instance.new("Highlight")
          highlight.FillTransparency = 0.6
          highlight.Adornee, highlight.Parent = item, item
          highlight.Name = "Luz"
          
          if string.find(item.Name, "Box") then
            highlight.FillColor, highlight.OutlineColor = Settings.Colors.Box, Settings.Colors.Box
          elseif string.find(item.Name, "Zeni") then
            highlight.FillColor, highlight.OutlineColor = Settings.Colors.Zeni, Settings.Colors.Zeni
          elseif string.find(item.Name, "Key") then
            highlight.FillColor, highlight.OutlineColor = Settings.Colors.Key, Settings.Colors.Key
          else
            highlight.FillColor, highlight.OutlineColor = Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
          end
        end
      end
    end)
  end
  if not getgenv().ItemsESP then
    pcall(function()
      for _, item in pairs(workspace.Server.SpawnedItems:GetChildren()) do
        if item:FindFirstChild("Luz") and item.Luz.Enabled == true then
          item.Luz.Enabled = false
        end
      end
    end)
  end
end
local function EnemyESP()
  while getgenv().EnemyESP and task.wait(0.1) do
    pcall(function()
      if workspace.Client.Enemy.ClientEnemy.EnemyModel:FindFirstChild("Luz") then
        if workspace.Client.Enemy.ClientEnemy.EnemyModel.Luz.Enabled == false then
          workspace.Client.Enemy.ClientEnemy.EnemyModel.Luz.Enabled = true
        end
        if workspace.Client.Enemy.ClientEnemy.EnemyModel.Luz.FillColor  ~= Settings.Colors.Enemy or workspace.Client.Enemy.ClientEnemy.EnemyModel.Luz.OutlineColor ~= Settings.Colors.Enemy then
          workspace.Client.Enemy.ClientEnemy.EnemyModel.Luz.FillColor, workspace.Client.Enemy.ClientEnemy.EnemyModel.Luz.OutlineColor = Settings.Colors.Enemy, Settings.Colors.Enemy
        end
      else
        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = 0.6
        highlight.Adornee, highlight.Parent = workspace.Client.Enemy.ClientEnemy.EnemyModel, workspace.Client.Enemy.ClientEnemy.EnemyModel
        highlight.FillColor, highlight.OutlineColor = Settings.Colors.Enemy, Settings.Colors.Enemy
        highlight.Name = "Luz"
      end
    end)
  end
  if not getgenv().Enemy then
    pcall(function()
      if workspace.Client.Enemy.ClientEnemy.EnemyModel.Luz.Enabled == true then
        workspace.Client.Enemy.ClientEnemy.EnemyModel.Luz.Enabled = false
      end
    end)
  end
end

-- Left Groupbox
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Movement')
LeftGroupBox:AddToggle('WalkspeedToggle', { Text = 'Change Walk Speed' });
LeftGroupBox:AddSlider('WalkspeedSlider', {
	Text = 'Selected Walk Speed',
	Default = 16,
	Min = 0,
	Max = 120,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		print('[cb] MySlider was changed! New value:', Value)
	end,

	Tooltip = 'I am a slider!',
	DisabledTooltip = 'I am disabled!',

	Disabled = false,
	Visible = true,
})
LeftGroupBox:AddDivider()
LeftGroupBox:AddToggle('JumppowerToggle', { Text = 'Change Jump Power' });
LeftGroupBox:AddSlider('JumppowerSlider', {
	Text = 'Selected Jump Power',
	Default = 50,
	Min = 0,
	Max = 120,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		print('[cb] MySlider was changed! New value:', Value)
	end,

	Tooltip = 'I am a slider!',
	DisabledTooltip = 'I am disabled!',

	Disabled = false,
	Visible = true,
})
LeftGroupBox:AddDivider()
LeftGroupBox:AddToggle('InfjumpToggle', {
  Text = 'Infinite Jump',
  Callback = function(Value)
    getgenv()
  end
});

local RightGroupbox = Tabs.Main:AddRightGroupbox('Helpful');
RightGroupbox:AddToggle('InteractToggle', {
  Text = 'Auto Interact',
  Callback = function(Value)
    getgenv().AutoInteract = Value
    AutoInteract()
  end
});
local Depbox = RightGroupbox:AddDependencyBox();
Depbox:AddSlider('DistanceSlider', {
  Text = 'Interaction Distance',
  Default = 9,
  Min = 0,
  Max = 15,
  Rounding = 0,
  
  Callback = function(Value)
    Settings.AutoInteract.Distance = tonumber(Value)
  end
});
Depbox:AddDivider()
Depbox:SetupDependencies({
	{ Toggles.InteractToggle, true }
});

local VisualsGroupbox = Tabs.Main:AddRightGroupbox('ESPs and Colors');
VisualsGroupbox:AddToggle('ESPsItemsToggle', {
  Text = 'ESP Items',
  Callback = function(Value)
    getgenv().ItemsESP = Value
    ItemsESP()
  end
});
VisualsGroupbox:AddToggle('ESPsEnemyToggle', {
  Text = 'ESP Enemy',
  Callback = function(Value)
    getgenv().EnemyESP = Value
    EnemyESP()
  end
});

-- UI Settings

Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
	FrameCounter += 1;

	if (tick() - FrameTimer) >= 1 then
		FPS = FrameCounter;
		FrameTimer = tick();
		FrameCounter = 0;
	end;

	Library:SetWatermark(('Hallow Hub | %s fps | %s ms'):format(
		math.floor(FPS),
		math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
	));
end);

Library:OnUnload(function()
	WatermarkConnection:Disconnect()

	print('Unloaded!')
	Library.Unloaded = true
end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddToggle("KeybindMenuOpen", { Default = Library.KeybindFrame.Visible, Text = "Open Keybind Menu", Callback = function(value) Library.KeybindFrame.Visible = value end})
MenuGroup:AddToggle("ShowCustomCursor", {Text = "Custom Cursor", Default = true, Callback = function(Value) Library.ShowCustomCursor = Value end})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
MenuGroup:AddButton("Unload", function() Library:Unload() end)

Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:SetSubFolder('specific-place')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()

-- workspace.Server.MapGenerated.Rooms:GetChildren()[8].HintPaper
-- workspace.Client.Enemy.ClientEnemy.EnemyModel
-- workspace.Server.MapGenerated.Rooms.Room.Props.Safe
-- workspace.Server.MapGenerated.Rooms:GetChildren()[8].Props:GetChildren()[6].tana1.Zeni_2.InteractPoint.ItemInteractP
-- workspace.Server.MapGenerated.Rooms:GetChildren()[8].Props:GetChildren()[6].tana1.InteractPoint.slidePrompt
-- workspace.Server.MapGenerated.Rooms:GetChildren()[8].Props:GetChildren()[6].tana1.Slide.Value