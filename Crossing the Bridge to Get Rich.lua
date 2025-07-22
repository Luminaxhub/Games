-- UI Script: Crossing the Bridge to Get Rich (Fixed for Android)
-- Owner: Luminaprojects
-- YouTube: Luminaprojects

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
repeat wait() until LocalPlayer:FindFirstChild("PlayerGui")

-- Load UI library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3"))()
local ui = library:CreateWindow("🌈 Crossing the Bridge to Get Rich")

-- ✅ Toggle Button (WORKS ON ANDROID)
local toggleGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
toggleGui.Name = "ToggleUI"

local toggleBtn = Instance.new("TextButton", toggleGui)
toggleBtn.Size = UDim2.new(0, 120, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 100)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.Text = "🧱 Toggle UI"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16

toggleBtn.MouseButton1Click:Connect(function()
    library:ToggleUI()
end)

-- ---------------------------
-- Semua Tab dan Fitur Sama
-- ---------------------------

-- 📦 TREASURE TAB
local t = ui:CreateTab("TREASURE CHEST")
t:CreateButton("1K CASH", function() LocalPlayer.Character:MoveTo(Vector3.new(-1, 50, -1138)) end)
t:CreateButton("2.5K CASH", function() LocalPlayer.Character:MoveTo(Vector3.new(500, 52, -2636)) end)
t:CreateButton("5K CASH", function() LocalPlayer.Character:MoveTo(Vector3.new(999, 55, -5125)) end)
t:CreateButton("10K CASH", function() LocalPlayer.Character:MoveTo(Vector3.new(1499, 56, -10135)) end)
t:CreateButton("25K CASH", function() LocalPlayer.Character:MoveTo(Vector3.new(1999, 52, -25139)) end)

-- 🗺️ TELEPORT TAB
local tele = ui:CreateTab("TELEPORT")
tele:CreateButton("World 5", function() LocalPlayer.Character:MoveTo(Vector3.new(2000, 3, 11)) end)
tele:CreateButton("World 4", function() LocalPlayer.Character:MoveTo(Vector3.new(1498, 3, 13)) end)
tele:CreateButton("World 3", function() LocalPlayer.Character:MoveTo(Vector3.new(999, 3, 12)) end)
tele:CreateButton("World 2", function() LocalPlayer.Character:MoveTo(Vector3.new(499, 3, 11)) end)
tele:CreateButton("World 1", function() LocalPlayer.Character:MoveTo(Vector3.new(0, 3, 10)) end)
tele:CreateButton("Obby Maps", function() LocalPlayer.Character:MoveTo(Vector3.new(-199, 3, 11)) end)

-- 🧗‍♂️ OBBY TAB
local obby = ui:CreateTab("OBBY")
obby:CreateButton("Easy Obby", function()
    local path = {
        Vector3.new(-328, 3, 90), Vector3.new(-367, 13, 89), Vector3.new(-392, 3, 90),
        Vector3.new(-428, 3, 89), Vector3.new(-447, 3, 90), Vector3.new(-466, 3, 88)
    }
    for _, p in ipairs(path) do LocalPlayer.Character:MoveTo(p) wait(1) end
end)

obby:CreateButton("Medium Obby", function()
    local path = {
        Vector3.new(-308, 4, 10), Vector3.new(-325, 3, 9), Vector3.new(-342, 3, 10),
        Vector3.new(-349, 3, 10), Vector3.new(-367, 8, 14), Vector3.new(-419, 3, 10),
        Vector3.new(-447, 3, 9), Vector3.new(-470, 3, 10), Vector3.new(-494, 3, 9),
        Vector3.new(-506, 3, 8)
    }
    for _, p in ipairs(path) do LocalPlayer.Character:MoveTo(p) wait(1) end
end)

obby:CreateButton("Hard Obby", function()
    local path = {
        Vector3.new(-304, 3, -71), Vector3.new(-330, 3, -70), Vector3.new(-340, 3, -70),
        Vector3.new(-351, 3, -70), Vector3.new(-359, 3, -70), Vector3.new(-379, 6, -71),
        Vector3.new(-403, 3, -66), Vector3.new(-424, 3, -74), Vector3.new(-434, 3, -70),
        Vector3.new(-453, 3, -70), Vector3.new(-475, 3, -70), Vector3.new(-481, 9, -76),
        Vector3.new(-486, 15, -70), Vector3.new(-499, 3, -70), Vector3.new(-517, 3, -69),
        Vector3.new(-534, 3, -70), Vector3.new(-549, 3, -71)
    }
    for _, p in ipairs(path) do LocalPlayer.Character:MoveTo(p) wait(1) end
end)

-- ⚙️ SETTING TAB
local setting = ui:CreateTab("MORE SETTING")
setting:CreateSlider("WalkSpeed", 16, 100, function(v)
    LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
setting:CreateSlider("JumpPower", 50, 200, function(v)
    LocalPlayer.Character.Humanoid.JumpPower = v
end)
setting:CreateButton("Unlocked Fun Zone", function()
    LocalPlayer.Character:MoveTo(Vector3.new(990, 3, 210))
end)

-- 📜 CREDIT
local credit = ui:CreateTab("CREDIT")
credit:CreateLabel("Owner :> Luminaprojects")
credit:CreateLabel("YouTube :> Luminaprojects")
