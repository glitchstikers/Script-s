local success, Games = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/glitchstikers/Script-s/refs/heads/main/Core.lua"))()
end)

if success and type(Games) == "table" then
    local Execute = Games[game.PlaceId]
    if Execute then
        local loadSuccess, errorMsg = pcall(function()
            loadstring(game:HttpGet(Execute))()
        end)

        if not loadSuccess then
            warn("Error executing script for PlaceID " .. game.PlaceId .. ": " .. errorMsg)
        end
    else
        warn("No script found for PlaceID: " .. game.PlaceId)
    end
else
    warn("Failed to load Core.lua")
end
