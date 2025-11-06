do
  local Players = game:GetService("Players")
  local eu = Players.LocalPlayer

  local function FinEat(humanoid)
    local MapName = workspace.Map:GetAttribute("Name")
    local function Eat(order)
      local function SearchForFood(path, foods)
        for _, food in ipairs(order) do
          if table.find(foods, food) then
            for _, giver in pairs(path:GetChildren()) do
              if giver:FindFirstChild("Item") and giver:GetAttribute("PowerUp") == food then
                firetouchinterest(eu.Character.HumanoidRootPart, giver.Item, 0)
                firetouchinterest(eu.Character.HumanoidRootPart, giver.Item, 1)
                return true
              end
            end
          end
        end
        return false
      end
      
      local Maps = {
        ["Lunar Arena"] = {
          Foods = { "Heart", "Burger" },
          Fallback = function()
            return SearchForFood(workspace.Map.Towers.RisingModel, { "Heart", "Burger", "Donut" })
          end,
        },
        ["Cloud Pass"] = {
          Foods = { "Heart", "Burger", "Donut" },
          Fallback = function()
            return SearchForFood(workspace.Map.V2.Interactives.Givers, { "Heart", "Burger", "Donut" })
          end,
        },
        ["Crossroads"] = {
          Foods = { "Heart", "Burger", "Donut" },
          Fallback = function()
            local part = workspace.Map.Interactives["Spase Aliens"].Josh.HealPart
            firetouchinterest(eu.Character.HumanoidRootPart, part, 0)
            firetouchinterest(eu.Character.HumanoidRootPart, part, 1)
            return true
          end
        },
        ["Haunted Mansion"] = {
          Fallback = function()
            return SearchForFood(workspace.Map.Structures.RopeBridge, { "Burger" })
          end,
        },
        ["Bamboo Beach"] = {
          Foods = { "Heart", "Burger", "Donut" },
          Fallback = function()
            return SearchForFood(workspace.Map.Environment.Event.Model, { "Donut" })
          end,
        },
        ["Reactor Core"] = {
          Foods = { "Heart", "Burger", "Donut" },
          Fallback = function()
            return SearchForFood(workspace.Map.Environment.Event.RisingModel.Boat.Interactives, { "Heart", "Burger", "BlastBurger" }) or SearchForFood(workspace.Map.Environment.Event.LoweringRocks, { "Donut" })
          end
        },
        ["Blackrock Castle"] = {
          Foods = { "Heart", "Burger" }
        },
        ["BloxBurg"] = {
          Foods = { "Heart", "Burger", "BlastBurger" }
        },
        ["Rocket Arena"] = {
          Foods = { "Heart", "Burger", "BlastBurger" }
        },
        ["Blast Summit"] = {
          Foods = { "Heart", "Burger", "Donut" }
        },
        ["Roblox HQ"] = {
          Foods = { "Heart", "Burger", "Donut" }
        }
      }
      
      local Map = Maps[MapName]
      if Map then
        if SearchForFood(workspace.Map.Interactives.Givers, Map.Foods or order) then
          return true
        elseif Map.Fallback then
          return Map.Fallback()
        end
      else
        return SearchForFood(workspace.Map.Interactives.Givers, order)
      end
    end
    
    local missing = humanoid.MaxHealth - humanoid.Health
    if missing > 50 then
      Eat({ "Heart", "Burger", "Donut", "BlastBurger" })
    elseif missing > 25 then
      Eat({ "Burger", "Donut", "BlastBurger" })
    elseif missing > 10 then
      Eat({ "Donut", "BlastBurger", "Burger" })
    elseif missing > 0 then
      Eat({ "BlastBurger", "Donut", "Burger" })
    end
  end
  local currentConnection -- para evitar múltiplos eventos ativos

  local function MonitorHealth()
    local char = eu.Character
    if not char then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    -- Desconecta o evento anterior, se houver
    if currentConnection then
      currentConnection:Disconnect()
    end

    currentConnection = humanoid.HealthChanged:Connect(function()
      if humanoid.Health < humanoid.MaxHealth then
        FinEat(humanoid)
      end
    end)
  end

  -- Loop de fallback que roda a cada 1s
  task.spawn(function()
    while task.wait(1) do
      pcall(function()
        local char = eu.Character
        if char then
          local humanoid = char:FindFirstChildOfClass("Humanoid")
          if humanoid and humanoid.Health < humanoid.MaxHealth then
            FinEat(humanoid)
          end
          if eu.Character:GetAttribute("Stamina") < 1 then
            eu.Character:SetAttribute("Stamina", 1)
          end
        end
      end)
    end
  end)

  -- Inicializa monitoramento para o personagem atual
  if eu.Character then
    MonitorHealth()
  end

  -- Reconecta em novos personagens (após respawn)
  eu.CharacterAdded:Connect(function()
    task.wait(1)
    MonitorHealth()
  end)
end

getgenv().NoKnockback = false
local knockbackConnection

local function ApplyNoKnockback()
    local player = game.Players.LocalPlayer
    local function apply()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        if knockbackConnection then
            knockbackConnection:Disconnect()
        end

        knockbackConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not getgenv().NoKnockback then return end 

            if hrp and hrp.Velocity.Magnitude > 50 then
                hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
            end

            for _, v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") or v:IsA("BodyForce") then
                    v:Destroy()
                end
            end
        end)
    end

    if player.Character then
        apply()
    end
    player.CharacterAdded:Connect(apply)
end

task.spawn(function()
    while true do
        if getgenv().NoKnockback and not knockbackConnection then
            ApplyNoKnockback()
        elseif not getgenv().NoKnockback and knockbackConnection then
            knockbackConnection:Disconnect()
            knockbackConnection = nil
        end
        task.wait(1) 
    end
end)


local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Blast Zone",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})
-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Helpful")
Section = Menu:CreateLabel("Auto Heal [ ENABLED ]")
Section = Menu:CreateLabel("Inf Stamina [ ENABLED ]")


Menu:CreateToggle({
    Name = "No Knockback",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().NoKnockback = Value
         ApplyNoKnockback()
    end
})
