-- **Load Rayfield UI Library**
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success then
    warn("⚠️ Failed to load Rayfield UI Library!")
    return
end

-- **Basic Information**
local CurrentName = "🌑 Shadowbyte 🌑"
local CurrentGame = "a literal Baseplate 🌐"
local DefaultVersion = "v1.0"

-- **Persistent Version Storage**
local VersionFile = "Shadowbyte_Version.txt"

local function LoadVersion()
    if isfile(VersionFile) then
        return readfile(VersionFile):match("^%s*(.-)%s*$") or DefaultVersion
    else
        return DefaultVersion
    end
end

local function SaveVersion(version)
    writefile(VersionFile, version)
end

local CurrentVersion = LoadVersion()

-- **Create UI Window**
local Window = Rayfield:CreateWindow({
    Name = string.format("%s | %s | %s", CurrentName, CurrentGame, CurrentVersion),
    Theme = "Dark"
})

-- **Home Tab**
local HomeTab = Window:CreateTab("🏠 Home")
HomeTab:CreateSection("📌 Support")

HomeTab:CreateButton({
    Name = "ℹ️ About Us",
    Callback = function()
        Rayfield:Notify({
            Title = "📢 About Us",
            Content = "Shadowbyte is designed for testing purposes.",
            Duration = 5
        })
    end
})

HomeTab:CreateSection("⚠️ Disclaimer")
HomeTab:CreateParagraph({
    Title = "🚨 Warning!",
    Content = "If you get kicked or banned, it's **your responsibility**, not ours."
})

-- **Main Tab**
local MainTab = Window:CreateTab("🌟 Main")
MainTab:CreateSection("📌 Auto Teleport & Chat System")

-- **Auto Teleport Variables**
local autoTP = false

-- **Auto Teleport Toggle**
MainTab:CreateToggle({
    Name = "Auto Teleport to All Players",
    Callback = function(state)
        autoTP = state
        if autoTP then
            teleportLoop()
        end
    end
})

-- **Auto-Teleport Function**
function teleportLoop()
    while autoTP do
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if not autoTP then return end -- Stop loop immediately when toggle is off
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                task.wait(0) -- Wait before teleporting to the next player
            end
        end
    end
end

-- **Function to Check for Updates**
local function CheckForUpdate()
    local success, response = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/glitchstikers/Script-s/refs/heads/main/A%20literal%20Baseplate/A%20literal%20Baseplate%20version%20update")
    end)

    if success and response then
        local LatestVersion = response:match("^%s*(.-)%s*$")

        if LatestVersion and LatestVersion ~= CurrentVersion then
            -- **Show Update Notification**
            Rayfield:Notify({
                Title = "⚠️ UPDATE DETECTED!",
                Content = "New version available: " .. LatestVersion .. ". Please rejoin.",
                Duration = 10
            })

            -- **Update UI Title & Save Version**
            SaveVersion(LatestVersion)
            CurrentVersion = LatestVersion
            Window:SetName(string.format("%s | %s | %s", CurrentName, CurrentGame, CurrentVersion))
        end
    else
        warn("⚠️ Failed to check for updates! Possible network issue.")
    end
end

-- **Check for Updates Periodically**
task.spawn(function()
    while true do
        CheckForUpdate()
        task.wait(30) -- Check every 30 seconds
    end
end)

-- **Check for Updates Immediately**
CheckForUpdate()

-- **Auto Load & Save Configurations**
pcall(function() Rayfield:LoadConfiguration() end)
local function AutoSave() pcall(function() Rayfield:SaveConfiguration() end) end
