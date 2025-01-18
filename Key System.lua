-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Loader.lua",true))()
local function SuckMyBallsSkid(filePath)
  local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
  local response = httrest({
    Url = "https://api.github.com/repos/Moligrafi001/Hallow-Priv/contents/" .. game:GetService("HttpService"):UrlEncode(filePath) .. "?ref=main",
    Method = "GET",
    Headers = {
      ["Authorization"] = "Bearer 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",
      ["Accept"] = "application/vnd.github.raw+json"
    }
  })
  local function isFuckingSkidShit()
    local testCode = "return 1 + 1"
    local success, compiledFunc = pcall(loadstring, testCode)
    if success and typeof(compiledFunc) == "function" then
      local ok, result = pcall(compiledFunc)
      if ok and result == 2 then
        return true
      end
    end
    return false
  end
  if isFuckingSkidShit() then
    local func = loadstring(response.Body)
    func()
  else
    local function AlertSkid()
    local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
    local function SendMessageEMBED(url, embed)
        local http = game:GetService("HttpService")
        local headers = {
            ["Content-Type"] = "application/json"
        }
        local data = {
            ["content"] = "@everyone! BAN! NOW!",
            ["embeds"] = {
                {
                    ["title"] = embed.title,
                    ["description"] = embed.description,
                    ["color"] = embed.color,
                    ["fields"] = embed.fields,
                    ["footer"] = {
                        ["text"] = embed.footer.text
                    }
                }
            }
        }
        local body = http:JSONEncode(data)
        local response = httrest({
            Url = url,
            Method = "POST",
            Headers = headers,
            Body = body
        })
    end
    local url = "https://discord.com/api/webhooks/1328260420775186504/YfQelXUZMdmqsvtXqCprvoa6hUqS-0nOZNRJ_aaNXcMelpusO5PW2N_3oMTgQjCBN4_h"
    local Gamepado = "false"
    local Toque = "false"
    local Teclado = "false"
    if game:GetService("UserInputService").TouchEnabled == true then
    	Toque = "__true__"
    end
    if game:GetService("UserInputService").KeyboardEnabled == true then
    	Teclado = "__true__"
    end
    if game:GetService("UserInputService").GamepadEnabled == true then
    	Gamepado = "__true__"
    end
    local execName = identifyexecutor() or "NO NAME!!!"
    local embed = {
        ["title"] = "SKIDDER DETECTED!",
        ["description"] = "Executed with: **__" .. execName .. "__**\n‎ ",
        ["color"] = 16743680,
        ["fields"] = {
            {
                ["name"] = "**Game Info**",
                ["value"] = "**Game Name**: __" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "__\n**Game ID**: __" .. game.PlaceId .. "__\n**Link**: https://www.roblox.com/games/" .. game.PlaceId .. "\n‎ "
            },
            {
                ["name"] = "**Server Info**",
                ["value"] = "**Players**: " .. #game.Players:GetPlayers() .. "/" .. game.Players.MaxPlayers .. "\n**Job ID**: __" .. game.JobId .. "__\n**Link**: __No Link Yet__\n‎ "
            },
            {
                ["name"] = "**User Info**",
                ["value"] = "**Username**: @__" .. game.Players.LocalPlayer.Name .. "__\n**Display**: __" .. game.Players.LocalPlayer.DisplayName .. "__\n**User ID**: __" .. game.Players.LocalPlayer.UserId .. "__\n**Link**: https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId .. "/profile" .. "\n\n**TouchScreen**: " .. Toque .. "\n**Keyboard**: " .. Teclado .. "\n**Gamepad**: " .. Gamepado
            }
        },
        ["footer"] = {
            ["text"] = "from Moligrafi to Hallow Hub"
        }
    }
    SendMessageEMBED(url, embed)
    end
    print("Dude why are you trying to skid this? Wtf bro.")
    AlertSkid()
    wait(3)
    game.Players.LocalPlayer:Kick("\nDon't skid, fag!\nhttps://discord.gg/AESCuek87s")
  end
end
local PandaAuth = loadstring(game:HttpGet("https://raw.githubusercontent.com/Panda-Repositories/PandaKS_Libraries/refs/heads/main/library/LuaLib/ROBLOX/PandaSVALLib.lua"))()
PandaAuth:Initialize({
  Service = "hallowhub",
  API_Key = "9e2587f18e0b05c969b3b383f9bb8465f202d7822191dbe81902b11a8db12389",
  DisplayName = "Hallow Hub",
  IsDebug = false,
  Allow_BlacklistUsers = false,
  GUIVersion = false,
  EnableWebhook = false,
  Webhook_URL = "https://discord.com/api/webhooks/1328260420775186504/YfQelXUZMdmqsvtXqCprvoa6hUqS-0nOZNRJ_aaNXcMelpusO5PW2N_3oMTgQjCBN4_h",
  Authenticated = function() 
    print("[Pelinda] Key authenticated successfully! Access granted.") 
  end, 
  NotAuthenticated = function()
    print("[Pelinda] Authentication failed. Access denied.") 
  end 
}) 
local ChaveHub = "nil"
local Verificado = false
local ChaveExpirou = false
local function CarregarPedido()
  local Portuguese = false
  if game:GetService("LocalizationService").RobloxLocaleId == "pt-br" then
    Portuguese = true
  end
  local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
  local function Verificando()
    if Portuguese then
      Rayfield:Notify({
        Title = "Verificando key...",
        Content = "Apenas espere.",
        Duration = 3,
        Image = 17091459839,
      })
    else
      Rayfield:Notify({
        Title = "Checking key...",
        Content = "Just wait.",
        Duration = 3,
        Image = 17091459839,
      })
    end
  end
  local function PegarChave()
    setclipboard(PandaAuth:GetKey())
    if Portuguese then
      Rayfield:Notify({
        Title = "Link copiado com sucesso!",
        Content = "Siga todas as instruções atentamente.",
        Duration = 9,
        Image = 17091459839,
      })
    else
      Rayfield:Notify({
        Title = "Got the link to the key!",
        Content = "Link copied! Follow the steps.",
        Duration = 9,
        Image = 17091459839,
      })
    end
  end
  local function SalvarChave()
    local foldername = "Hallow Hub"
    local filename = foldername .. "//Saved Key.txt"
    if isfolder(foldername) then
      if isfile(filename) then
        writefile(filename, ChaveHub)
      else
        writefile(filename, ChaveHub)
      end
    else
      makefolder(foldername)
      if isfile(filename) then
        writefile(filename, ChaveHub)
      else
        writefile(filename, ChaveHub)
      end
    end
  end
  local function ChecarChave()
    if PandaAuth:ValidateKey(ChaveHub) and Verificado == false then
      SalvarChave()
      if Portuguese then
        Rayfield:Notify({
          Title = "Yay! Key correta!",
          Content = "Script está carregando, aguarde...",
          Duration = 4,
          Image = 17091459839,
          })
      else
        Rayfield:Notify({
          Title = "Yay! Right key!",
          Content = "Script is loading... Don't execute it again.",
          Duration = 4,
          Image = 17091459839,
          })
      end
      wait(1)
      SuckMyBallsSkid("Loader.lua")
    else
      Verificado = false
      if Portuguese then
        Rayfield:Notify({
          Title = "Key incorreta!",
          Content = "Tem certeza que colou certo?",
          Duration = 4,
          Image = 17091459839,
        })
      else
        Rayfield:Notify({
          Title = "Wrong key!",
          Content = "Bad!",
          Duration = 4,
          Image = 17091459839,
        })
      end
    end
  end
  local Window = Rayfield:CreateWindow({
      Name = "Hallow Hub | Authentication",
      Icon = 17091459839,
      LoadingTitle = "Hallow Hub",
      LoadingSubtitle = "By Moligrafi",
      Theme = "Amethyst"
  })
  local Menu = Window:CreateTab("Key System", "key")
  local SectionInstructions = Menu:CreateSection("🔑 Key Instructions 🔑")
  local TutorialLabel = Menu:CreateParagraph({
      Title = "·-–— Steps to Get the Key —–-·",
      Content = "1. Click the 'Generate Link' button below;\n2. After you have clicked the button, a link will be copied to your clipboard, paste it into your browser;\n3. Go into your browser and paste in the link. Follow all the necessary steps until you reach the key page;\n4. Copy the key that is shown and paste it below in the text box."
  })
  local SectionGetKey = Menu:CreateSection("Get Your Key")
  local ButtonGetKey = Menu:CreateButton({
      Name = "Generate Link",
      Callback = function()
        PegarChave()
        getgenv().PegouChave = true
      end,
  })
  local SectionCheckKey = Menu:CreateSection("Authenticate Key")
  local InputKey = Menu:CreateInput({
     Name = "Key",
     CurrentValue = "",
     PlaceholderText = "Paste your key here",
     RemoveTextAfterFocusLost = false,
     Callback = function(Text)
     	Verificando()
     	ChaveHub = Text
     	ChecarChave()
     	Verificado = true
     end,
  })
  local VerifyKey = Menu:CreateButton({
      Name = "Check Key",
      Callback = function()
        Verificando()
        ChecarChave()
        Verificado = true
      end,
  })
  local DividerInstructions = Menu:CreateDivider()

  -- Credits
  local Credits = Window:CreateTab("Credits", "info")
  local FounderSection = Credits:CreateSection("Founder Developer")
  local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
  local DevSection = Credits:CreateSection("Co-Developer")
  local Label = Credits:CreateLabel("Discord: _prismx", "at-sign")
  local ServerSection = Credits:CreateSection("Discord Server")
  local Label = Credits:CreateLabel("discord.gg/AESCuek87s")
  local ButtonServer = Credits:CreateButton({
     Name = "Copy Server Link",
     Callback = function()
     	setclipboard("discord.gg/XnsG57tQWS")
     	toclipboard("discord.gg/XnsG57tQWS")
      end,
  })
  local NoteSection = Credits:CreateSection("Note")
  local NoteLabel = Credits:CreateLabel("If you find any bug join the discord and open a ticket")
  
  if Portuguese then
    SectionInstructions:Set("🔑 Instruções 🔑")
    TutorialLabel:Set({Title = "·-–— Passos para Autenticar —–-·", Content = "1. Clique no botão 'Gerar Link' logo abaixo;\n2. Após clicar, um link será copiado para sua área de transferência;\n3. Abra seu navegador, cole o link copiado e complete as tarefas;\n4. Assim que terminado o passo anterior, copie o código gerado e cole na caixa de texto aqui abaixo."})
    SectionGetKey:Set("Pegue sua Key")
    ButtonGetKey:Set("Gerar Link")
    SectionCheckKey:Set("Autenticar Key")
    VerifyKey:Set("Verificar Key")
    FounderSection:Set("Fundador Desenvolvedor")
    DevSection:Set("Co-Desenvolvedor")
    ServerSection:Set("Servidor Discord")
    ButtonServer:Set("Copiar Link")
    NoteSection:Set("Nota")
    NoteLabel:Set("Se você encontrar algum bug, entre no servidor e reporte via ticket")
    if ChaveExpirou == true then
      Rayfield:Notify({
        Title = "Key salva incorreta.",
        Content = "Sua key salva expirou ou é incorreta. Tente pegar outra key.",
        Duration = 7,
        Image = 17091459839,
      })
    end
    pcall(function()
      if PandaAuth:ValidateKey(getclipboard()) then
        Verificado = true
        ChaveHub = getclipboard()
        SalvarChave()
        Rayfield:Notify({
          Title = "Key copiada está correta!",
          Content = "Carregando script, aguarde...",
          Duration = 3,
          Image = 17091459839,
        })
        wait(1)
        SuckMyBallsSkid("Loader.lua")
      end
    end)
  else
    if ChaveExpirou == true then
      Rayfield:Notify({
        Title = "Saved key is wrong.",
        Content = "Your saved key expired or is wrong. Try to get a new one.",
        Duration = 7,
        Image = 17091459839,
      })
    end
    pcall(function()
      if PandaAuth:ValidateKey(getclipboard()) then
        Verificado = true
        ChaveHub = getclipboard()
        SalvarChave()
        Rayfield:Notify({
          Title = "Copied key is right!",
          Content = "Loading script, wait...",
          Duration = 3,
          Image = 17091459839,
        })
        wait(1)
        SuckMyBallsSkid("Loader.lua")
      end
    end)
  end
end
local function VerificarSalvo()
  local foldername = "Hallow Hub"
  local filename = foldername .. "//Saved Key.txt"
  if Verificado == false then
    if isfolder(foldername) and isfile(filename) then
      if PandaAuth:ValidateKey(readfile(filename)) then
        Verificado = true
        SuckMyBallsSkid("Loader.lua")
      else
        ChaveExpirou = true
        CarregarPedido()
      end
    else
      CarregarPedido()
    end
  end
end
VerificarSalvo()