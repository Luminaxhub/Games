-- UI Script: Crossing the Bridge to Get Rich (Updated UI Layout)
-- Owner: Luminaprojects
-- YouTube: Luminaprojects

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3"))()
local ui = library:CreateWindow("🌈 Crossing the Bridge to Get Rich")

-- 🧱 Toggle Button
local Toggle = Instance.new("TextButton")
Toggle.Parent = game.CoreGui
Toggle.Size = UDim2.new(0, 150, 0, 40)
Toggle.Position = UDim2.new(0, 10, 0, 100)
Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Toggle.Text = "🧱 Toggle UI"
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.MouseButton1Click:Connect(function()
	library:ToggleUI()
end)

-- ⛏️ TREASURE CHEST TAB
local treasureTab = ui:CreateTab("TREASURE CHEST")
treasureTab:CreateButton("1K CASH", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-1, 50, -1138))
end)
treasureTab:CreateButton("2.5K CASH", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(500, 52, -2636))
end)
treasureTab:CreateButton("5K CASH", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(999, 55, -5125))
end)
treasureTab:CreateButton("10K CASH", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(1499, 56, -10135))
end)
treasureTab:CreateButton("25K CASH", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(1999, 52, -25139))
end)

-- 🗺️ TELEPORT TAB
local teleportTab = ui:CreateTab("TELEPORT")
teleportTab:CreateButton("World 5", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(2000, 3, 11))
end)
teleportTab:CreateButton("World 4", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(1498, 3, 13))
end)
teleportTab:CreateButton("World 3", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(999, 3, 12))
end)
teleportTab:CreateButton("World 2", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(499, 3, 11))
end)
teleportTab:CreateButton("World 1", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(0, 3, 10))
end)
teleportTab:CreateButton("Obby Maps", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-199, 3, 11))
end)

-- 🧗‍♂️ OBBY TAB
local obbyTab = ui:CreateTab("OBBY")

obbyTab:CreateButton("Easy Obby", function()
	local coords = {
		Vector3.new(-328, 3, 90), Vector3.new(-367, 13, 89), Vector3.new(-392, 3, 90),
		Vector3.new(-428, 3, 89), Vector3.new(-447, 3, 90), Vector3.new(-466, 3, 88)
	}
	for _, pos in ipairs(coords) do
		game.Players.LocalPlayer.Character:MoveTo(pos)
		wait(1)
	end
end)

obbyTab:CreateButton("Medium Obby", function()
	local coords = {
		Vector3.new(-308, 4, 10), Vector3.new(-325, 3, 9), Vector3.new(-342, 3, 10),
		Vector3.new(-349, 3, 10), Vector3.new(-367, 8, 14), Vector3.new(-419, 3, 10),
		Vector3.new(-447, 3, 9), Vector3.new(-470, 3, 10), Vector3.new(-494, 3, 9),
		Vector3.new(-506, 3, 8)
	}
	for _, pos in ipairs(coords) do
		game.Players.LocalPlayer.Character:MoveTo(pos)
		wait(1)
	end
end)

obbyTab:CreateButton("Hard Obby", function()
	local coords = {
		Vector3.new(-304, 3, -71), Vector3.new(-330, 3, -70), Vector3.new(-340, 3, -70),
		Vector3.new(-351, 3, -70), Vector3.new(-359, 3, -70), Vector3.new(-379, 6, -71),
		Vector3.new(-403, 3, -66), Vector3.new(-424, 3, -74), Vector3.new(-434, 3, -70),
		Vector3.new(-453, 3, -70), Vector3.new(-475, 3, -70), Vector3.new(-481, 9, -76),
		Vector3.new(-486, 15, -70), Vector3.new(-499, 3, -70), Vector3.new(-517, 3, -69),
		Vector3.new(-534, 3, -70), Vector3.new(-549, 3, -71)
	}
	for _, pos in ipairs(coords) do
		game.Players.LocalPlayer.Character:MoveTo(pos)
		wait(1)
	end
end)

-- ⚙️ MORE SETTING TAB
local settingTab = ui:CreateTab("MORE SETTING")

settingTab:CreateSlider("WalkSpeed", 16, 100, function(v)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

settingTab:CreateSlider("JumpPower", 50, 200, function(v)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

settingTab:CreateButton("Unlocked Fun Zone", function()
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(990, 3, 210)) -- contoh koordinat
end)

-- 👑 CREDIT TAB
local creditTab = ui:CreateTab("CREDIT")
creditTab:CreateLabel("Owner :> Luminaprojects")
creditTab:CreateLabel("YouTube :> Luminaprojects")
