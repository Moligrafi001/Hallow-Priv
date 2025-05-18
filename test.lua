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
  Title = 'Hallow Hub | Skinwalkers [ HORROR ]',
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

-- Global Values
getgenv().CollectMoneyBags = false
getgenv().RevealSkinwalkers = false
getgenv().ProtectDetector = false
getgenv().ShootSkinwalker = false
getgenv().CiviliansESP = false
getgenv().ExterminateSkinwalkers = false
getgenv().ExterminateNightwalkers = false
getgenv().Fullbright = false
getgenv().KillAura = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Distance = 30,
  Heal = {
    self = true,
    others = true
  }
}

-- Funções
local function AutoHeal()
  while getgenv().AutoHeal and task.wait(1) do
    if eu.Character:FindFirstChild("Bandage") or eu.Backpack:FindFirstChild("Bandage") then
      if Settings.Heal.self and eu.Humanoid.Health < eu.Humanoid.MaxHealth then
        game:GetService("ReplicatedStorage").Remotes.Heal:FireServer(eu.Character)
      end
      if Settings.Heal.others then
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
          if p.Character.Humanoid.Health < MaxHealth then
            game:GetService("ReplicatedStorage").Remotes.Heal:FireServer(p.Character)
          end
        end
      end
    end
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
RightGroupbox:AddToggle('CollectToggle', {
  Text = 'Auto Collect Money Bags',
  Callback = function(Value)
    getgenv().CollectMoneyBags = Value
    CollectMoneyBags()
  end
});
RightGroupbox:AddToggle('HealToggle', {
  Text = 'Auto Heal',
  Tooltip = 'Need Bandage',
  Callback = function(Value)
    getgenv().AutoHeal = Value
    AutoHeal()
  end
});
local Depbox = RightGroupbox:AddDependencyBox();
Depbox:AddToggle('SelfToggle', {
  Text = 'Self Heal',
  Callback = function(Value)
    Settings.Heal.self = Value
  end
});
Depbox:AddToggle('OthersToggle', {
  Text = 'Heal Others',
  Callback = function(Value)
    Settings.Heal.others = Value
  end
});
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
	{ Toggles.HealToggle, true }
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