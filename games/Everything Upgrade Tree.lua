-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Everything%20Upgrade%20Tree.lua", true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Everything Upgrade Tree",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- curservisbility
game:GetService("UserInputService").MouseIconEnabled = true

-- Valores
local BuySpeed = "Slow"
_G.AutoUpgrade = false
_G.AutoConvert = false
_G.AutoUpLab = false
_G.AutoUpPrestige = false

-- Funções
local function AutoUpPrestige()
	while _G.AutoUpPrestige == true do
		for i = 2, 30 do
			local numero = i .. "p"
			game:GetService("ReplicatedStorage").remotes.upgrade:FireServer(numero)
		end
	wait(1)
	end
end

local function AutoUpgrade()
	while _G.AutoUpgrade == true do
		for i = 1, 30 do
			if i ~= 20 then
				game:GetService("ReplicatedStorage").remotes.upgrade:FireServer(i)
			end
		end
		game:GetService("ReplicatedStorage").remotes.upgrade:FireServer("1b", true)
		game:GetService("ReplicatedStorage").remotes.upgrade:FireServer("2b_3", true)
		game:GetService("ReplicatedStorage").remotes.upgrade:FireServer("4b", true)
		game:GetService("ReplicatedStorage").remotes.upgrade:FireServer("3b", true)
		game:GetService("ReplicatedStorage").remotes.upgrade:FireServer("5b_3", true)
		if BuySpeed == "Slow" then
			wait(0.5)
		end
		if BuySpeed == "Fast (Not Recommended)" then
			wait(0.2)
		end
	end
end

local function AutoConvert()
	while _G.AutoConvert == true do
		game:GetService("ReplicatedStorage").remotes.research_convert:FireServer(true)
		wait(1)
	end
end

local function AutoUpLab()
	while _G.AutoUpLab == true do
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("PointGain")
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("RightSide")
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("LeftSide")
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("Materialize")
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("Materialize2")
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("PointGain2")
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("PointGain3")
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("PointGain4")
		game:GetService("ReplicatedStorage").remotes.research_upgrade:FireServer("PointGain1b")
		wait(BuySpeed)
	end
end

-- Autoclicking
local autoclicking = false
local AutoClickThread

local function AutoClickLevel()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("remotes")
        and game.ReplicatedStorage.remotes:FindFirstChild("click_xp")

    if remote then
        remote:FireServer() 
    else
        warn("RemoteEvent 'click_xp' not found in ReplicatedStorage > remotes!")
    end
end


-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Upgrade")
local Toggle = Menu:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoUpgrade = Value
   	AutoUpgrade()
   end,
})

local Dropdown = Menu:CreateDropdown({
   Name = "Select the Auto Buy Speed",
   Options = {"Slow", "Fast (Not Recommended)"},
   CurrentOption = {"Slow"},
   MultipleOptions = false,
   Callback = function(Options)
   		BuySpeed = Options[1]
   end,
})

local Section = Menu:CreateSection("Research Center")
local Toggle = Menu:CreateToggle({
   Name = "Auto Convert",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoConvert = Value
   	AutoConvert()
   end,
})

local Toggle = Menu:CreateToggle({
   Name = "Auto Research",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoUpLab = Value
   	AutoUpLab()
   end,
})

-- AutoClick Leveling Center
local Toggle = Menu:CreateToggle({
    Name = "AutoClick Leveling Center",
    CurrentValue = false,
    Callback = function(Value)
        autoclicking = Value 

        if autoclicking then
            print("Autoclicker started!")
            AutoClickThread = task.spawn(function()
                while autoclicking do
                    AutoClickLevel()
                    task.wait(0) -- delay thingy
                end
            end)
        else
            print("Autoclicker stopped!")
            autoclicking = false
            if AutoClickThread then
                task.cancel(AutoClickThread)
                AutoClickThread = nil
            end
        end
    end,
})

-- Prestige
local Prestige = Window:CreateTab("Prestige", "shield")
local Section = Prestige:CreateSection("Upgrade")
local Toggle = Prestige:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoUpPrestige = Value
   	AutoUpPrestige()
   end,
})