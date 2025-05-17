local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Untitled Drill Game",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().AutoDrill = false
getgenv().AutoSell = false
getgenv().AutoCollect = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local character = eu.Character or eu.CharacterAdded:Wait()
local backpack = eu:WaitForChild("Backpack")
local VirtualInputManager = game:GetService("VirtualInputManager")

local function equipSlot1Tool()
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
	task.wait(0.05)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)
end
-- Drill once
local function drill()
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("OreService"):WaitForChild("RE"):WaitForChild("RequestRandomOre"):FireServer()
end

-- Drill loop
local function AutoDrill()
	task.spawn(function()
		while getgenv().AutoDrill do
			drill()
			task.wait(0) 
		end
	end)
end

local function Sell()
    local char = eu.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local hrp = char.HumanoidRootPart
    local originalCFrame = hrp.CFrame

    hrp.CFrame = workspace.Scripted.Sell.CFrame + Vector3.new(0, 3, 0)

    task.wait(0.25)

    game:GetService("ReplicatedStorage")
        :WaitForChild("Packages")
        :WaitForChild("Knit")
        :WaitForChild("Services")
        :WaitForChild("OreService")
        :WaitForChild("RE")
        :WaitForChild("SellAll")
        :FireServer()

    task.wait(0.1)
    hrp.CFrame = originalCFrame
end

local function AutoSell()
	task.spawn(function()
		while getgenv().AutoSell do
			Sell()
			task.wait(1.5) 
		end
	end)
end

local function CollectDrill()
	local drillsFolder = workspace:WaitForChild("Plots")
	
	for _, plot in pairs(drillsFolder:GetChildren()) do
		if plot:FindFirstChild("Owner") and plot.Owner.Value == eu then
			local drills = plot:FindFirstChild("Drills")
			if drills then
				for _, drill in pairs(drills:GetChildren()) do
					local args = { drill }
					game:GetService("ReplicatedStorage")
						:WaitForChild("Packages")
						:WaitForChild("Knit")
						:WaitForChild("Services")
						:WaitForChild("PlotService")
						:WaitForChild("RE")
						:WaitForChild("CollectDrill")
						:FireServer(unpack(args))
				end
			end
		end
	end
end


local function AutoCollectDrill()
	task.spawn(function()
		while getgenv().AutoCollect do
			CollectDrill()
			task.wait(0) 
		end
	end)
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
local Section = Menu:CreateSection("Main")

Menu:CreateToggle({
	Name = "Auto Drill",
	CurrentValue = false,
	Callback = function(Value)
		getgenv().AutoDrill = Value
		if Value then
			equipSlot1Tool()
			AutoDrill()
		end
	end
})

Menu:CreateToggle({
	Name = "Auto Sell",
	CurrentValue = false,
	Callback = function(Value)
		getgenv().AutoSell = Value
		if Value then
			AutoSell()
		end
	end
})

Menu:CreateToggle({
	Name = "Auto Collect ores",
	CurrentValue = false,
	Callback = function(Value)
		getgenv().AutoCollect = Value
		if Value then
			AutoCollectDrill()
		end
	end
})



