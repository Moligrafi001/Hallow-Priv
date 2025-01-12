--loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Prib/main/Key%20System.lua", true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Authentication",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

local function GetKey()
    Rayfield:Notify({
        Title = "Key Link has been copied!",
        Content = "Paste the link into your browser",
        Duration = 10,
        Image = 17091459839,
    })
end

local Menu = Window:CreateTab("Key System", "key")

local SectionInstructions = Menu:CreateSection("🔑 Key Instructions 🔑")
local Paragraph = Menu:CreateParagraph({
    Title = "How to Get the Key",
    Content = "To get the key, simply click the 'Get Key' button below. After you have clicked the button, a link will be copied to your clipboard. Go into your browser and paste in the link. Follow all the necessary steps until you reach the key page. Copy the key that is shown and paste it in the box below the Get Key button."
})

local DividerInstructions = Menu:CreateDivider()

local SectionGetKey = Menu:CreateSection("Get Your Key")
local DividerGetKey = Menu:CreateDivider()

local ButtonGetKey = Menu:CreateButton({
    Name = "Get Key",
    Callback = function()
        GetKey()
    end,
})

local DividerEnd = Menu:CreateDivider()

local Input = Menu:CreateInput({
    Name = "Enter Key",
    Info = "Paste your key here.",
    PlaceholderText = "Input your key",
    NumbersOnly = false,  
    CharacterLimit = 32,  
    OnEnter = true,  -
    RemoveTextAfterFocusLost = false,
    Callback = function(KeyInput)
        if KeyInput == "YOURCORRECTKEY" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Loader.lua", true))()
        else
            Rayfield:Notify({
                Title = "Incorrect Key",
                Content = "The key you entered is incorrect. Please try again.",
                Duration = 3,
                Image = 17091459839,
            })
        end
    end,
})
