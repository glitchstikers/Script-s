local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/glitchstikers/Script-s/refs/heads/main/Core.lua"))()

for PlaceID, Execute in pairs(Games) do
    if PlaceID == game.PlaceId then
        loadstring(game:HttpGet(Execute))()
    end
end
