do
  local Players = game:GetService("Players")
  local eu = Players.LocalPlayer

  local function Eat(type)
    for _, giver in pairs(workspace.Map.Interactives.Givers:GetChildren()) do
      if giver:FindFirstChild("Item") and giver:GetAttribute("PowerUp") == type then
        firetouchinterest(eu.Character.HumanoidRootPart, giver.Item, 0)
        firetouchinterest(eu.Character.HumanoidRootPart, giver.Item, 1)
        return true
      end
    end
    return false
  end

  local function FinEat(humanoid)
    local missing = humanoid.MaxHealth - humanoid.Health
    if missing > 50 then
      if not Eat("Heart") then
        if not Eat("Burger") then
          Eat("Donut")
        end
      end
    elseif missing > 25 then
      if not Eat("Burger") then
        Eat("Donut")
      end
    elseif missing > 0 then
      if not Eat("Donut") then
        Eat("Burger")
      end
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