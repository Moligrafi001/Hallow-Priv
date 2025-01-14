-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Priv/refs/heads/main/games/NinjaLegends.lua?token=GHSAT0AAAAAAC4PUKQN7X62DKLTISICB5ZKZ4F2GJQ",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Ninja Legends⭐",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi & PrismX",
    Theme = "Amethyst"
})

local Plr = game:GetService("Players").LocalPlayer
local NinjaEvent = Plr:FindFirstChild("ninjaEvent")

getgenv().AutoSwing = false
getgenv().AutoSell = false
getgenv().FarmHoops = false
getgenv().SwingDelay = "0.5"
getgenv().HoopDelay = "0.5"
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


local function startAutoSwing()
    getgenv().AutoSwing = true
    local Plr = game.Players.LocalPlayer
    local NinjaEvent = Plr:FindFirstChild("ninjaEvent")

    while getgenv().AutoSwing do
        -- Equip Weapon
        pcall(function()
            local Weapon
            for _, Tool in pairs(Plr.Backpack:GetChildren()) do
                if Tool:FindFirstChild("ninjitsuGain") then
                    Weapon = Tool
                end
            end

            if Weapon then
                Plr.Character:FindFirstChildOfClass("Humanoid"):EquipTool(Weapon)
            end
        end)

        NinjaEvent:FireServer("swingKatana")
        wait(tonumber(getgenv().SwingDelay))
    end
end

local function stopAutoSwing()
    getgenv().AutoSwing = false
end

local function startAutoSell()
    getgenv().AutoSell = true
    local Plr = game.Players.LocalPlayer
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

local function stopAutoSell()
    getgenv().AutoSell = false
end

local function startFarmHoops()
    getgenv().FarmHoops = true

    while getgenv().FarmHoops do
        pcall(function()
            for i, hoop in pairs(game:GetService("Workspace").Hoops:GetChildren()) do
                if getgenv().FarmHoops then
                    local args = {
                        [1] = "useHoop",
                        [2] = hoop
                    }

                    game:GetService("ReplicatedStorage").rEvents.hoopEvent:FireServer(unpack(args))

                    wait(tonumber(getgenv().HoopDelay))
                end
            end
        end)
    end
end

local function stopFarmHoops()
    getgenv().FarmHoops = false
end

local function startAutoHatch()
    getgenv().AutoHatch = true

    while getgenv().AutoHatch do
        pcall(function()
            local args = {
                [1] = "openCrystal",
                [2] = getgenv().CrystalToHatch
            }

            game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(unpack(args))
        end)
    end
end

local function stopAutoHatch()
    getgenv().AutoHatch = false
end

local function startAutoEvolve()
    getgenv().AutoEvolve = true

    while getgenv().AutoEvolve do
        pcall(function()
            for i, type in pairs(Plr.petsFolder:GetChildren()) do
                for i2, pet in pairs(type:GetChildren()) do
                    game:GetService("ReplicatedStorage").rEvents.petNextEvolutionEvent:FireServer("evolvePet", pet, game:GetService("ReplicatedStorage").evolutionOrders.evolved)
                end
            end
        end)

        wait(2)
    end
end

local function stopAutoEvolve()
    getgenv().AutoEvolve = false
end

local function startAutoSellPets()
    getgenv().AutoSellPets = true

    while getgenv().AutoSellPets do
        for i, pet in pairs(Plr.petsFolder[getgenv().PetToSell]:GetChildren()) do
            game:GetService("ReplicatedStorage").rEvents.sellPetEvent:FireServer("sellPet", pet)
        end

        wait(5)
    end
end

local function stopAutoSellPets()
    getgenv().AutoSellPets = false
end

local function startAutoPurchaseSwords()
    getgenv().AutoPurchaseSwords = true

    while getgenv().AutoPurchaseSwords do
        pcall(function()
            NinjaEvent:FireServer("buyAllSwords", getgenv().IslandToPurchaseFrom)
        end)

        wait(5)
    end
end

local function stopAutoPurchaseSwords()
    getgenv().AutoPurchaseSwords = false
end

local function startAutoPurchaseBelts()
    getgenv().AutoPurchaseBelts = true

    while getgenv().AutoPurchaseBelts do
        pcall(function()
            NinjaEvent:FireServer("buyAllBelts", getgenv().IslandToPurchaseFrom)
        end)

        wait(5)
    end
end

local function stopAutoPurchaseBelts()
    getgenv().AutoPurchaseBelts = false
end

local function startAutoUpgradeSkills()
    getgenv().AutoUpgradeSkills = true

    while getgenv().AutoUpgradeSkills do
        pcall(function()
            NinjaEvent:FireServer("buyAllSkills", getgenv().IslandToPurchaseFrom)
        end)

        wait(5)
    end
end

local function stopAutoUpgradeSkills()
    getgenv().AutoUpgradeSkills = false
end

local function startAutoPurchaseShurikens()
    getgenv().AutoPurchaseShurikens = true

    while getgenv().AutoPurchaseShurikens do
        pcall(function()
            NinjaEvent:FireServer("buyAllShurikens", getgenv().IslandToPurchaseFrom)
        end)

        wait(5)
    end
end

local function stopAutoPurchaseShurikens()
    getgenv().AutoPurchaseShurikens = false
end

-- Movement
local WalkSpeedText = 16
local JumpPowerText = 50
_G.SetWalkSpeed = false
_G.SetJumpPower = false
_G.InfJump = false
_G.NoClip = false
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

local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")




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


