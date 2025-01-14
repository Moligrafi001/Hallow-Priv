-- loadstring(game:HttpGet("",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Ninja Legends⭐",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi & PrismX",
    Theme = "Amethyst"
})

-- Tabs
local AutofarmTab = Window:CreateTab("Autofarm", "rbxassetid://1234567890")
local ClientTab = Window:CreateTab("Local Player", "rbxassetid://1234567890")
local PetsTab = Window:CreateTab("Pets", "rbxassetid://1234567890")
local ShopTab = Window:CreateTab("Shop", "rbxassetid://1234567890")

-- Sections
local AutofarmSection = AutofarmTab:CreateSection("Autofarm")
local AutofarmConfigSection = AutofarmTab:CreateSection("Configurations")
local HumanoidSection = ClientTab:CreateSection("Humanoid")
local BypassSection = ClientTab:CreateSection("Bypass")
local AutoHatchSection = PetsTab:CreateSection("Auto Hatch")
local PetMiscSection = PetsTab:CreateSection("Miscellaneous")
local AutoPurchaseSection = ShopTab:CreateSection("Auto Purchase")
local PurchaseConfigSection = ShopTab:CreateSection("Configurations")

-- Globals
local Plr = game:GetService("Players").LocalPlayer
local NinjaEvent = Plr:FindFirstChild("ninjaEvent")

getgenv().AutoSwing = false
getgenv().AutoSell = false
getgenv().FarmHoops = false
getgenv().SwingDelay = 0.5
getgenv().HoopDelay = 0.5
getgenv().InfiniteJump = false
getgenv().AutoHatch = false
getgenv().CrystalToHatch = "Blue Crystal"
getgenv().AutoEvolve = false
getgenv().AutoSellPets = false
getgenv().PetToSell = nil
getgenv().AutoPurchaseSwords = false
getgenv().AutoPurchaseBelts = false
getgenv().AutoUpgradeSkills = false
getgenv().AutoPurchaseShurikens = false
getgenv().IslandToPurchaseFrom = "Ground"

-- Autofarm Toggles
AutofarmSection:CreateToggle({
    Name = "Auto Swing",
    CurrentValue = false,
    Callback = function(state)
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
})

AutofarmSection:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(state)
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
})

AutofarmConfigSection:CreateSlider({
    Name = "Swing Delay",
    Min = 0,
    Max = 1,
    Increment = 0.1,
    CurrentValue = getgenv().SwingDelay,
    Callback = function(value)
        getgenv().SwingDelay = value
    end
})

AutofarmConfigSection:CreateSlider({
    Name = "Hoop Delay",
    Min = 0,
    Max = 1,
    Increment = 0.1,
    CurrentValue = getgenv().HoopDelay,
    Callback = function(value)
        getgenv().HoopDelay = value
    end
})

-- Humanoid Controls
HumanoidSection:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 500,
    Increment = 1,
    CurrentValue = 16,
    Callback = function(value)
        Plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
    end
})

HumanoidSection:CreateSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 1000,
    Increment = 10,
    CurrentValue = 50,
    Callback = function(value)
        Plr.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
    end
})

BypassSection:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(state)
        getgenv().InfiniteJump = state
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if state and input.KeyCode == Enum.KeyCode.Space then
                Plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 150, 0)
            end
        end)
    end
})

-- Auto Hatch
AutoHatchSection:CreateToggle({
    Name = "Auto Hatch",
    CurrentValue = false,
    Callback = function(state)
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
})

AutoHatchSection:CreateDropdown({
    Name = "Crystal",
    Options = {"Blue Crystal", "Purple Crystal", "Golden Crystal"},
    CurrentOption = getgenv().CrystalToHatch,
    Callback = function(option)
        getgenv().CrystalToHatch = option
    end
})

-- Notifications
Rayfield:Notify({
    Title = "UI Loaded",
    Content = "Ninja Legends Script is ready!",
    Duration = 5,
    Image = 17091459839
})



-- Credits
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Founder Developer")
local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
local Section = Credits:CreateSection("Developer")
local Label = Credits:CreateLabel("Discord: _prismx", "at-sign")
local Section = Credits:CreateSection("Discord Server")
local Label = Credits:CreateLabel("discord.gg/AESCuek87s")
local Button = Credits:CreateButton({
   Name = "Copy Server Link",
   Callback = function()
   	setclipboard("discord.gg/AESCuek87s")
   	toclipboard("discord.gg/AESCuek87s")
    end,
})
local Section = Credits:CreateSection("Note")
local Label = Credits:CreateLabel("If you find any bug join the discord and open a ticket")
