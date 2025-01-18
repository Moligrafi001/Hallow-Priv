local banneds = {"123", "456", "789"}
if game.Players.LocalPlayer.UserId == unpack(banneds) then
game.Players.LocalPlayer:Kick("You are banned!")
end