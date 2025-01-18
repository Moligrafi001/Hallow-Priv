local banneds = {"7862872050", "456", "789"}

if game.Players.LocalPlayer.UserId == unpack(banneds) then
  game.Players.LocalPlayer:Kick("\nYou are banned from Hallow Hub!\nJoin the discord below to appeal.")
end