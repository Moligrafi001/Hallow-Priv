-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Loader.lua",true))()
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
  local function ChecarChave()
    local foldername = "Hallow Hub"
    local filename = foldername .. "//Saved Key.txt"
    if PandaAuth:ValidateKey(ChaveHub) and Verificado == false then
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
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Games.lua",true))()
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
  local Section = Credits:CreateSection("Founder Developer")
  local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
  local Section = Credits:CreateSection("Developer")
  local Label = Credits:CreateLabel("Discord: _prismx", "at-sign")
  local Section = Credits:CreateSection("Discord Server")
  local Label = Credits:CreateLabel("discord.gg/AESCuek87s")
  local Button = Credits:CreateButton({
     Name = "Copy Server Link",
     Callback = function()
     	setclipboard("discord.gg/XnsG57tQWS")
     	toclipboard("discord.gg/XnsG57tQWS")
      end,
  })
  local Section = Credits:CreateSection("Note")
  local Label = Credits:CreateLabel("If you find any bug join the discord and open a ticket")
  
  if Portuguese then
    SectionInstructions:Set("🔑 Instruções 🔑")
    TutorialLabel:Set({Title = "·-–— Passos para Autenticar —–-·", Content = "1. Clique no botão 'Gerar Link' logo abaixo;\n2. Após clicar, um link será copiado para sua área de transferência;\n3. Abra seu navegador, cole o link copiado e complete as tarefas;\n4. Assim que terminado o passo anterior, copie o código gerado e cole na caixa de texto."})
    SectionGetKey:Set("Pegue sua Key")
    ButtonGetKey:Set("Gerar Link")
    SectionCheckKey:Set("Autenticar Key")
    VerifyKey:Set("Verificar Key")
    if ChaveExpirou == true then
      Rayfield:Notify({
        Title = "Key salva incorreta.",
        Content = "Sua key salva expirou ou é incorreta. Tente pegar outra key.",
        Duration = 7,
        Image = 17091459839,
      })
    end
  else
    if ChaveExpirou == true then
      Rayfield:Notify({
        Title = "Saved key is wrong.",
        Content = "Your saved key expired or is wrong. Try to get a new one.",
        Duration = 7,
        Image = 17091459839,
      })
    end
  end
end
local function VerificarSalvo()
  local foldername = "Hallow Hub"
  local filename = foldername .. "//Saved Key.txt"
  if Verificado == false then
    if isfolder(foldername) and isfile(filename) then
      if PandaAuth:ValidateKey(readfile(filename)) then
        Verificado = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Games.lua",true))()
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