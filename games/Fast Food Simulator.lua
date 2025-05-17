local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Fast Food Simulator",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().AutoDirty = false
getgenv().AutoOrder = false
getgenv().Opened = false
getgenv().AutoAction = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local dirtyConnected = false

-- Functions
local function AutoDirty()
  for _, tray in pairs(workspace.OwnedRestaurants[eu.Name].DirtyTrays:GetChildren()) do
    tray.Collect:FireServer()
  end

  if not dirtyConnected then
    dirtyConnected = true
    workspace.OwnedRestaurants[eu.Name].DirtyTrays.ChildAdded:Connect(function(instance)
      if getgenv().AutoDirty then
        instance.Collect:FireServer()
      end
    end)
  end
end

local function AutoOrder()
  task.spawn(function()
    while getgenv().AutoOrder do
      workspace.OwnedRestaurants[eu.Name].Furniture.CashRegisters.Register.TakeOrder:FireServer()
      task.wait(3)
    end
  end)
end

local function Open()
    task.spawn(function()
        while getgenv().Opened do
            local success, err = pcall(function()
                local remote = game:GetService("ReplicatedStorage")
                    :WaitForChild("Remotes")
                    :WaitForChild("Settings")
                    :WaitForChild("Setting")

                remote:FireServer("Open", true) 
            end)

            if not success then
                warn("Failed to open restaurant:", err)
            end

            task.wait(0.5)
        end

        pcall(function()
            local remote = game:GetService("ReplicatedStorage")
                :WaitForChild("Remotes")
                :WaitForChild("Settings")
                :WaitForChild("Setting")

            remote:FireServer("Open", false) 
        end)
    end)
end


-- Menu
local Menu = Window:CreateTab("Menu", "home")
local Section = Menu:CreateSection("Helpful")

Menu:CreateToggle({
  Name = "Collect Dirty Trays",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoDirty = Value
    if Value then AutoDirty() end
  end
})

Menu:CreateToggle({
  Name = "Auto Take Orders",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoOrder = Value
    if Value then AutoOrder() end
  end
})

Menu:CreateToggle({
  Name = "Auto Open Restaurant",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().Opened = Value
    if Value then Open() end
  end
})



-- workspace.OwnedRestaurants.HallowHubby.DirtyTrays:FindFirstChild("Dirty Tray").Collect:FireServer()
-- local args = {
--     [1] = workspace.OwnedRestaurants.HallowHubby.Ingredients:FindFirstChild("{aea78d64-214e-4190-8386-0ce3b6e8737e}")
-- }

-- game:GetService("ReplicatedStorage").Remotes.Gameplay.TakeIngredient:FireServer(unpack(args))
-- workspace.OwnedRestaurants.HallowHubby.Furniture.CashRegisters.Register.TakeOrder:FireServer()
-- -- workspace.OwnedRestaurants.HallowHubby.Trash.Tray.FoodsLeft.Burger["Cooked Patty"]
-- 7118588325
-- workspace.OwnedRestaurants.HallowHubby.Furniture.CashRegisters.Register.TakeOrder:FireServer()
-- local args = {
--     [1] = workspace.OwnedRestaurants.HallowHubby.Ingredients:FindFirstChild("{aea78d64-214e-4190-8386-0ce3b6e8737e}")
-- }

-- game:GetService("ReplicatedStorage").Remotes.Gameplay.TakeIngredient:FireServer(unpack(args))
-- local args = {
--     [1] = workspace.OwnedRestaurants.HallowHubby.Trash:FindFirstChild("Burger Bun"),
--     [2] = workspace.OwnedRestaurants.HallowHubby.Trash.Paper.Part
-- }

-- game:GetService("ReplicatedStorage").Remotes.Gameplay.SnapIngredient:FireServer(unpack(args))
