local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Dig to earths crust!",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

-- Global Values
getgenv().AutoMoney = false

-- Locals
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local backpack = player:WaitForChild("Backpack")
local VirtualInputManager = game:GetService("VirtualInputManager")


local function AutoMoneyFarm()
    task.spawn(function()
        while getgenv().AutoMoney do
            for i = 1, 5 do
                -- DigEvent
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DigEvent"):FireServer("hello")

                -- TreasureEvent
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TreasureEvent"):FireServer("MoneyBag")

                -- SpinPrizeEvent
                local args = { 8 }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinPrizeEvent"):FireServer(unpack(args))

                task.wait() 
            end
        end
    end)
end


getgenv().AutoGems = false 

local function AutoGemsFarm()
    task.spawn(function()
        while getgenv().AutoGems do
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GemEvent"):FireServer(11, "bye")
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GemEvent"):FireServer(15, "bye")


            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinPrizeEvent"):FireServer(9)
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinPrizeEvent"):FireServer(5)
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinPrizeEvent"):FireServer(1)


            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TreasureEvent"):FireServer("Chest")

            task.wait() 
        end
    end)
end

getgenv().AutoWin = false

local function teleportToRandomSpawn(world)
    local spawnsFolder = world:FindFirstChild("Spawns")
    if spawnsFolder and #spawnsFolder:GetChildren() > 0 then
        local spawns = spawnsFolder:GetChildren()
        local randomSpawn = spawns[math.random(1, #spawns)]
        if randomSpawn:IsA("SpawnLocation") or randomSpawn:IsA("BasePart") then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = randomSpawn.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
end

local function AutoWin()
    task.spawn(function()
        while getgenv().AutoWin do
            local currentWorldNumber = player:FindFirstChild("CurrentWorld") and player.CurrentWorld.Value
            local worldName = "World" .. tostring(currentWorldNumber)
            local world = workspace:FindFirstChild(worldName)

            if not world then
                task.wait(1)
                continue
            end

            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")

            -- Teleport to a spawn in the current world
            teleportToRandomSpawn(world)
            task.wait(0.3)

            -- Reset character by breaking joints
            if char:FindFirstChild("Humanoid") then
                char:BreakJoints()
            end

            -- Wait for character to respawn
            char = player.CharacterAdded:Wait()
            hrp = char:WaitForChild("HumanoidRootPart")

            -- Teleport again to ensure full load
            teleportToRandomSpawn(world)
            task.wait(0.5)

            -- Move to WinPart
            local winPart = world:FindFirstChild("WinPart")
            if winPart then
                for i = 1, 3 do
                    hrp.CFrame = winPart.CFrame + Vector3.new(0, 1.5 + i * 0.1, 0)
                    task.wait(0.1)
                end
                task.wait(1)
            end

            task.wait(1.5)
        end
    end)
end


getgenv().AutoSpins = false

local function AutoInfiniteSpins()
    task.spawn(function()
        while getgenv().AutoSpins do
            local args = {10}
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinPrizeEvent"):FireServer(unpack(args))
            task.wait(0.3)
        end
    end)
end

getgenv().AutoHatch = false

-- Function
local function AutoHatchEgg()
    task.spawn(function()
        while getgenv().AutoHatch do
            local egg = workspace:WaitForChild("World9"):WaitForChild("Prompts"):WaitForChild("Eggs"):FindFirstChild("Egg19")
            if egg then
                local args = { egg }
                game:GetService("ReplicatedStorage"):WaitForChild("PetRemotes"):WaitForChild("HatchServer"):InvokeServer(unpack(args))
            end
            task.wait(1) -- Adjust delay as needed to avoid spam or throttling
        end
    end)
end

getgenv().AutoUpgrades = false

-- Function
local function AutoUpgrade()
    task.spawn(function()
        while getgenv().AutoUpgrades do
            local upgrades = {
                { "WalkSpeed", 230 },
                { "Strength", 195 },
                { "GemChance", 50 },
                { "PetLuck", 196 }
            }

            for _, upgrade in ipairs(upgrades) do
                local args = { upgrade[1], upgrade[2] }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpgradeEvent"):FireServer(unpack(args))
                task.wait(0.2)
            end

            task.wait(2) -- Delay before next upgrade attempt
        end
    end)
end

getgenv().AutoDig = false

-- Function
local function AutoDigToggle()
    task.spawn(function()
        local player = game:GetService("Players").LocalPlayer
        while getgenv().AutoDig do
            if player:FindFirstChild("AutoDig") then
                player.AutoDig.Value = true
            end
            task.wait(1)
        end
        -- Disable AutoDig when toggled off
        if player:FindFirstChild("AutoDig") then
            player.AutoDig.Value = false
        end
    end)
end

-- UI
local Menu = Window:CreateTab("Menu", "home")
local Section = Menu:CreateSection("Main")

Menu:CreateToggle({
    Name = "Auto Money (Unlimited MONEY)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoMoney = Value
        if Value then
            AutoMoneyFarm()
        end
    end
})

Menu:CreateToggle({
    Name = "Auto Gems",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoGems = Value
        if Value then
            AutoGemsFarm()
        end
    end
})

Menu:CreateToggle({
    Name = "Auto Win",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoWin = Value
        if Value then
            AutoWin()
        end
    end
})

Menu:CreateToggle({
    Name = "Auto Dig",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoDig = Value
        if Value then
            AutoDigToggle()
        end
    end
})

local DividerInstructions = Menu:CreateDivider()
Menu:CreateToggle({
    Name = "Auto Infinite Spins",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoSpins = Value
        if Value then
            AutoInfiniteSpins()
        end
    end
})

Menu:CreateToggle({
    Name = "Auto Upgrades",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoUpgrades = Value
        if Value then
            AutoUpgrade()
        end
    end
})

local Pets = Window:CreateTab("Pets", "dog")
local Section = Pets:CreateSection("Main")

Pets:CreateToggle({
    Name = "Auto Hatch Best Egg, get a lot of money first",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoHatch = Value
        if Value then
            AutoHatchEgg()
        end
    end
})


