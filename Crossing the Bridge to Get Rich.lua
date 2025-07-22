-- 🌈 Crossing the Bridge to Get Rich UI (Rayfield Version)
-- Owner: Luminaprojects | YouTube: Luminaprojects

-- Load Rayfield Library
loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Player = game.Players.LocalPlayer
repeat wait() until Player.Character and Player:FindFirstChild("PlayerGui")
local Humanoid = Player.Character:WaitForChild("Humanoid")

-- Create UI
local Window = Rayfield:CreateWindow({
	Name = "🌉 Crossing the Bridge to Get Rich",
	LoadingTitle = "Loading Luminaprojects UI",
	LoadingSubtitle = "Script by Luminaprojects",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "LuminaConfig"
	},
	Discord = {Enabled = false},
	KeySystem = false
})

-- 📦 TREASURE CHEST TAB
local TreasureTab = Window:CreateTab("💰 TREASURE CHEST", 4483362458)
TreasureTab:CreateButton({Name = "1K CASH", Callback = function() Player.Character:MoveTo(Vector3.new(-1, 50, -1138)) end})
TreasureTab:CreateButton({Name = "2.5K CASH", Callback = function() Player.Character:MoveTo(Vector3.new(500, 52, -2636)) end})
TreasureTab:CreateButton({Name = "5K CASH", Callback = function() Player.Character:MoveTo(Vector3.new(999, 55, -5125)) end})
TreasureTab:CreateButton({Name = "10K CASH", Callback = function() Player.Character:MoveTo(Vector3.new(1499, 56, -10135)) end})
TreasureTab:CreateButton({Name = "25K CASH", Callback = function() Player.Character:MoveTo(Vector3.new(1999, 52, -25139)) end})

-- 🗺️ TELEPORT TAB
local TeleportTab = Window:CreateTab("🗺️ TELEPORT", 4483362458)
TeleportTab:CreateButton({Name = "World 5", Callback = function() Player.Character:MoveTo(Vector3.new(2000, 3, 11)) end})
TeleportTab:CreateButton({Name = "World 4", Callback = function() Player.Character:MoveTo(Vector3.new(1498, 3, 13)) end})
TeleportTab:CreateButton({Name = "World 3", Callback = function() Player.Character:MoveTo(Vector3.new(999, 3, 12)) end})
TeleportTab:CreateButton({Name = "World 2", Callback = function() Player.Character:MoveTo(Vector3.new(499, 3, 11)) end})
TeleportTab:CreateButton({Name = "World 1", Callback = function() Player.Character:MoveTo(Vector3.new(0, 3, 10)) end})
TeleportTab:CreateButton({Name = "Obby Maps", Callback = function() Player.Character:MoveTo(Vector3.new(-199, 3, 11)) end})

-- 🧗‍♂️ OBBY TAB
local ObbyTab = Window:CreateTab("🧗‍♂️ OBBY", 4483362458)

ObbyTab:CreateButton({
	Name = "Easy Obby",
	Callback = function()
		local path = {
			Vector3.new(-328, 3, 90), Vector3.new(-367, 13, 89), Vector3.new(-392, 3, 90),
			Vector3.new(-428, 3, 89), Vector3.new(-447, 3, 90), Vector3.new(-466, 3, 88)
		}
		for _, p in ipairs(path) do
			Player.Character:MoveTo(p)
			wait(1)
		end
	end
})

ObbyTab:CreateButton({
	Name = "Medium Obby",
	Callback = function()
		local path = {
			Vector3.new(-308, 4, 10), Vector3.new(-325, 3, 9), Vector3.new(-342, 3, 10),
			Vector3.new(-349, 3, 10), Vector3.new(-367, 8, 14), Vector3.new(-419, 3, 10),
			Vector3.new(-447, 3, 9), Vector3.new(-470, 3, 10), Vector3.new(-494, 3, 9),
			Vector3.new(-506, 3, 8)
		}
		for _, p in ipairs(path) do
			Player.Character:MoveTo(p)
			wait(1)
		end
	end
})

ObbyTab:CreateButton({
	Name = "Hard Obby",
	Callback = function()
		local path = {
			Vector3.new(-304, 3, -71), Vector3.new(-330, 3, -70), Vector3.new(-340, 3, -70),
			Vector3.new(-351, 3, -70), Vector3.new(-359, 3, -70), Vector3.new(-379, 6, -71),
			Vector3.new(-403, 3, -66), Vector3.new(-424, 3, -74), Vector3.new(-434, 3, -70),
			Vector3.new(-453, 3, -70), Vector3.new(-475, 3, -70), Vector3.new(-481, 9, -76),
			Vector3.new(-486, 15, -70), Vector3.new(-499, 3, -70), Vector3.new(-517, 3, -69),
			Vector3.new(-534, 3, -70), Vector3.new(-549, 3, -71)
		}
		for _, p in ipairs(path) do
			Player.Character:MoveTo(p)
			wait(1)
		end
	end
})

-- ⚙️ MORE SETTINGS
local SettingsTab = Window:CreateTab("⚙️ SETTINGS", 4483362458)

SettingsTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {16, 100},
	Increment = 1,
	Default = 16,
	ValueName = "Speed",
	Callback = function(value)
		if Humanoid then Humanoid.WalkSpeed = value end
	end
})

SettingsTab:CreateSlider({
	Name = "JumpPower",
	Range = {50, 200},
	Increment = 1,
	Default = 50,
	ValueName = "Power",
	Callback = function(value)
		if Humanoid then Humanoid.JumpPower = value end
	end
})

SettingsTab:CreateButton({
	Name = "🔓 Unlocked Fun Zone",
	Callback = function()
		Player.Character:MoveTo(Vector3.new(990, 3, 210))
	end
})

-- 📜 CREDIT TAB
local CreditTab = Window:CreateTab("📜 CREDITS", 4483362458)
CreditTab:CreateParagraph({
	Title = "Owner :> Luminaprojects",
	Content = "YouTube :> Luminaprojects"
})
