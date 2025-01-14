-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Priv/refs/heads/main/games/NinjaLegends.lua?token=GHSAT0AAAAAAC4PUKQMGWXO2JAJTWMTGI4YZ4F2BDA",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Ninja Legends⭐",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi & PrismX",
    Theme = "Amethyst"
})

-- Globals
local Plr = game:GetService("Players").LocalPlayer
local NinjaEvent = Plr:FindFirstChild("ninjaEvent")

getgenv().AutoSwing = false
getgenv().AutoSell = false
getgenv().SwingDelay = 0.5
getgenv().HoopDelay = 0.5
getgenv().InfiniteJump = false
getgenv().AutoHatch = false
getgenv().CrystalToHatch = "Blue Crystal"

-- Functions
local function toggleAutoSwing(state)
    getgenv().AutoSwing = state
    while getgenv().AutoSwing do
        pcall(function()
            local Weapon
            for _, Tool in pairs(Plr.Backpack:GetChildren()) do
                if Tool:FindFirstChild("ninjitsuGain") then
                    Weapon = Tool
                end
            end
            Plr.Character:FindFirstChildOfClass("Humanoid"):EquipTool(Weapon)
        end)
        NinjaEvent:FireServer("swingKatana")
        wait(getgenv().SwingDelay)
    end
end

local function toggleAutoSell(state)
    getgenv().AutoSell = state
    while getgenv().AutoSell do
        local CurrentNinjitsu = Plr.leaderstats.Ninjitsu
        local GroundBelts = game:GetService("ReplicatedStorage").Belts.Ground
        local CurrentBelt = Plr.equippedBelt.Value

        CurrentNinjitsu:GetPropertyChangedSignal("Value"):Connect(function()
            if CurrentNinjitsu.Value >= GroundBelts[CurrentBelt.Name].capacity.Value then
                local sellPart = game:GetService("Workspace").sellAreaCircles.sellAreaCircle.circleInner
                firetouchinterest(sellPart, Plr.Character.Head, 1)
                wait(0.5)
                firetouchinterest(sellPart, Plr.Character.Head, 0)
            end
        end)
    end
end

local function setSwingDelay(value)
    getgenv().SwingDelay = value
end

local function setHoopDelay(value)
    getgenv().HoopDelay = value
end

local function setWalkSpeed(value)
    Plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
end

local function setJumpPower(value)
    Plr.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
end

local function toggleInfiniteJump(state)
    getgenv().InfiniteJump = state
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if state and input.KeyCode == Enum.KeyCode.Space then
            Plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 150, 0)
        end
    end)
end

local function toggleAutoHatch(state)
    getgenv().AutoHatch = state
    while getgenv().AutoHatch do
        pcall(function()
            local args = {
                [1] = "openCrystal",
                [2] = getgenv().CrystalToHatch
            }
            game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(unpack(args))
        end)
        wait(1)
    end
end

local function setCrystalToHatch(option)
    getgenv().CrystalToHatch = option
end

-- UI Setup
local AutofarmTab = Window:CreateTab("Autofarm")

-- Autofarm Toggles
local toggle = AutofarmTab:CreateToggle({
    Name = "Auto Swing",
    CurrentValue = false,
    Callback = function(state)
        toggleAutoSwing(state)
    end
})

local toggle = AutofarmTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(state)
        toggleAutoSell(state)
    end
})

local slider = AutofarmTab:CreateSlider({
    Name = "Swing Delay",
    Min = 0,
    Max = 1,
    Increment = 0.1,
    CurrentValue = getgenv().SwingDelay,
    Callback = function(value)
        setSwingDelay(value)
    end
})

local slider = AutofarmTab:CreateSlider({
    Name = "Hoop Delay",
    Min = 0,
    Max = 1,
    Increment = 0.1,
    CurrentValue = getgenv().HoopDelay,
    Callback = function(value)
        setHoopDelay(value)
    end
})

local ClientTab = Window:CreateTab("Local Player")

-- Local Player Controls
local slider = ClientTab:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 500,
    Increment = 1,
    CurrentValue = 16,
    Callback = function(value)
        setWalkSpeed(value)
    end
})

local slider = ClientTab:CreateSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 1000,
    Increment = 10,
    CurrentValue = 50,
    Callback = function(value)
        setJumpPower(value)
    end
})

local toggle = ClientTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(state)
        toggleInfiniteJump(state)
    end
})

local PetsTab = Window:CreateTab("Pets")

-- Pets Controls
local toggle = PetsTab:CreateToggle({
    Name = "Auto Hatch",
    CurrentValue = false,
    Callback = function(state)
        toggleAutoHatch(state)
    end
})

local dropdown = PetsTab:CreateDropdown({
    Name = "Crystal",
    Options = {"Blue Crystal", "Purple Crystal", "Golden Crystal"},
    CurrentOption = getgenv().CrystalToHatch,
    Callback = function(option)
        setCrystalToHatch(option)
    end
})

local CreditsTab = Window:CreateTab("Credits")
-- Credits
CreditsTab:CreateSection("Founder Developer")
CreditsTab:CreateLabel("Discord: moligrafi")
CreditsTab:CreateSection("Developer")
CreditsTab:CreateLabel("Discord: _prismx")
CreditsTab:CreateSection("Discord Server")
CreditsTab:CreateLabel("discord.gg/AESCuek87s")
CreditsTab:CreateButton({
    Name = "Copy Server Link",
    Callback = function()
        setclipboard("discord.gg/AESCuek87s")
    end
})
CreditsTab:CreateLabel("If you find any bug join the discord and open a ticket")

