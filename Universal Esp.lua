-- Script by @luminaprojects

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "HollowESP_UI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 280)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.ClipsDescendants = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Universal - Esp ⚙️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local credit = Instance.new("TextLabel", Frame)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Text = "Script by - @luminaprojects"
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(255, 255, 255)
credit.Font = Enum.Font.GothamSemibold
credit.TextSize = 14

-- Minimize Button
local Minimize = Instance.new("TextButton", Frame)
Minimize.Size = UDim2.new(0, 20, 0, 20)
Minimize.Position = UDim2.new(1, -25, 0, 5)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 14
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Minimize.BorderSizePixel = 0

local Minimized = false
Minimize.MouseButton1Click:Connect(function()
	Minimized = not Minimized
	for _, v in pairs(Frame:GetChildren()) do
		if v ~= Minimize and v ~= Title and v ~= credit then
			v.Visible = not Minimized
		end
	end
end)

-- Color Picker Dropdown (15 warna unik Roblox)
local Colors = {
	["Crimson"] = Color3.fromRGB(220, 20, 60),
	["Emerald"] = Color3.fromRGB(80, 200, 120),
	["Sapphire"] = Color3.fromRGB(15, 82, 186),
	["Sunset"] = Color3.fromRGB(255, 94, 77),
	["Sky"] = Color3.fromRGB(135, 206, 250),
	["Royal Purple"] = Color3.fromRGB(120, 81, 169),
	["Lime"] = Color3.fromRGB(191, 255, 0),
	["Amber"] = Color3.fromRGB(255, 191, 0),
	["Cyan"] = Color3.fromRGB(0, 255, 255),
	["Rose"] = Color3.fromRGB(255, 102, 204),
	["Charcoal"] = Color3.fromRGB(54, 69, 79),
	["Mint"] = Color3.fromRGB(152, 255, 152),
	["Gold"] = Color3.fromRGB(255, 215, 0),
	["White"] = Color3.fromRGB(255, 255, 255),
	["Neon Blue"] = Color3.fromRGB(0, 174, 255),
}

local selectedColor = Color3.fromRGB(255, 255, 255)

-- Dropdown
local Dropdown = Instance.new("TextButton", Frame)
Dropdown.Size = UDim2.new(1, -20, 0, 30)
Dropdown.Position = UDim2.new(0, 10, 0, 40)
Dropdown.Text = "Select ESP Color"
Dropdown.BackgroundColor3 = Color3.fromRGB(30,30,30)
Dropdown.TextColor3 = Color3.new(1,1,1)
Dropdown.TextSize = 14
Dropdown.Font = Enum.Font.Gotham

local dropdownOpen = false
local colorButtons = {}

Dropdown.MouseButton1Click:Connect(function()
	dropdownOpen = not dropdownOpen
	for _, btn in pairs(colorButtons) do
		btn.Visible = dropdownOpen
	end
end)

local y = 80
for name, color in pairs(Colors) do
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1, -20, 0, 20)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.Text = name
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 12
	btn.Visible = false
	btn.MouseButton1Click:Connect(function()
		selectedColor = color
		Dropdown.Text = "Color: "..name
		for _, b in pairs(colorButtons) do
			b.Visible = false
		end
		dropdownOpen = false
	end)
	y += 25
	table.insert(colorButtons, btn)
end

-- ESP System
function CreateESP(plr)
	local box = Drawing.new("Square")
	box.Thickness = 2
	box.Transparency = 1
	box.Filled = false
	box.Color = selectedColor

	local healthBar = Drawing.new("Line")
	healthBar.Thickness = 2
	healthBar.Transparency = 1
	healthBar.Color = Color3.fromRGB(0, 255, 0)

	RunService.RenderStepped:Connect(function()
		if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr ~= localPlayer then
			local pos, onscreen = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
			if onscreen then
				local humanoid = plr.Character:FindFirstChild("Humanoid")
				local scale = 1 / (pos.Z + 1) * 100
				local width, height = 50 * scale, 100 * scale
				box.Size = Vector2.new(width, height)
				box.Position = Vector2.new(pos.X - width / 2, pos.Y - height / 2)
				box.Color = selectedColor
				box.Visible = true

				-- Health bar
				if humanoid then
					local hp = humanoid.Health / humanoid.MaxHealth
					healthBar.From = Vector2.new(pos.X - width / 2 - 5, pos.Y + height / 2)
					healthBar.To = Vector2.new(pos.X - width / 2 - 5, pos.Y + height / 2 - (height * hp))
					healthBar.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 0)
					healthBar.Visible = true
				end
			else
				box.Visible = false
				healthBar.Visible = false
			end
		else
			box.Visible = false
			healthBar.Visible = false
		end
	end)
end

-- Apply to all players
for _, plr in pairs(Players:GetPlayers()) do
	if plr ~= localPlayer then
		CreateESP(plr)
	end
end

Players.PlayerAdded:Connect(function(plr)
	if plr ~= localPlayer then
		plr.CharacterAdded:Connect(function()
			wait(1)
			CreateESP(plr)
		end)
	end
end)
