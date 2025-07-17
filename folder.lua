-- 🔎 Flow's ESP UI Script v1.0
-- Script by - @Luminaprojects (RGB Credit)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local EspEnabled = false
local TracerEnabled = false
local BoxEnabled = false
local HealthBarEnabled = false
local NameTagEnabled = false
local TeamCheck = true

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowESP_UI"

-- Frame
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 220)
Frame.Position = UDim2.new(0.02, 0, 0.2, 0)
Frame.BackgroundTransparency = 0.25
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🔎 Flow's ESP UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

-- Toggle Button Generator
local function createToggle(name, position, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, position)
	btn.Text = name .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(function()
		local state = callback()
		btn.Text = name .. ": " .. (state and "ON" or "OFF")
	end)
end

-- Minimize Button
local minimize = Instance.new("TextButton", Frame)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 0)
minimize.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.BorderSizePixel = 0

local contentVisible = true
minimize.MouseButton1Click:Connect(function()
	contentVisible = not contentVisible
	for _, child in ipairs(Frame:GetChildren()) do
		if child:IsA("TextButton") and child ~= minimize then
			child.Visible = contentVisible
		end
	end
end)

-- Toggles
createToggle("ESP Box", 40, function()
	BoxEnabled = not BoxEnabled
	return BoxEnabled
end)
createToggle("Tracer", 75, function()
	TracerEnabled = not TracerEnabled
	return TracerEnabled
end)
createToggle("Health Bar", 110, function()
	HealthBarEnabled = not HealthBarEnabled
	return HealthBarEnabled
end)
createToggle("Name + Distance", 145, function()
	NameTagEnabled = not NameTagEnabled
	return NameTagEnabled
end)
createToggle("Team Check", 180, function()
	TeamCheck = not TeamCheck
	return TeamCheck
end)

-- RGB Credit
local credit = Instance.new("TextLabel", ScreenGui)
credit.Text = "Script by - @Luminaprojects"
credit.Position = UDim2.new(0.5, -100, 1, -30)
credit.Size = UDim2.new(0, 200, 0, 20)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.new(1, 0, 0)
credit.Font = Enum.Font.GothamBold
credit.TextSize = 14

-- RGB Effect
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			task.wait(0.03)
		end
	end
end)

-- ESP Drawing
local function DrawESP(player)
	local espBox = Drawing.new("Square")
	local tracer = Drawing.new("Line")
	local nameTag = Drawing.new("Text")
	local healthBar = Drawing.new("Line")

	espBox.Thickness = 2
	espBox.Color = Color3.fromRGB(255, 255, 255)
	espBox.Transparency = 1
	espBox.Visible = false
	espBox.Filled = false

	tracer.Thickness = 1
	tracer.Color = Color3.fromRGB(255, 255, 255)
	tracer.Transparency = 1
	tracer.Visible = false

	nameTag.Size = 13
	nameTag.Center = true
	nameTag.Outline = true
	nameTag.Font = 2
	nameTag.Color = Color3.fromRGB(255, 255, 255)
	nameTag.Visible = false

	healthBar.Thickness = 2
	healthBar.Color = Color3.fromRGB(0, 255, 0)
	healthBar.Visible = false

	RunService.RenderStepped:Connect(function()
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or not player.Character:FindFirstChild("Humanoid") then
			espBox.Visible = false
			tracer.Visible = false
			nameTag.Visible = false
			healthBar.Visible = false
			return
		end

		if TeamCheck and player.Team == LocalPlayer.Team then
			espBox.Visible = false
			tracer.Visible = false
			nameTag.Visible = false
			healthBar.Visible = false
			return
		end

		local hrp = player.Character.HumanoidRootPart
		local humanoid = player.Character.Humanoid
		local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

		if onScreen then
			local size = Vector2.new(40, 60)
			local topLeft = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)

			espBox.Position = topLeft
			espBox.Size = size
			espBox.Visible = BoxEnabled

			tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
			tracer.To = Vector2.new(pos.X, pos.Y)
			tracer.Visible = TracerEnabled

			nameTag.Position = Vector2.new(pos.X, pos.Y - 40)
			nameTag.Text = player.Name .. " | " .. math.floor((hrp.Position - Camera.CFrame.Position).Magnitude) .. "m"
			nameTag.Visible = NameTagEnabled

			local healthRatio = humanoid.Health / humanoid.MaxHealth
			healthBar.From = Vector2.new(topLeft.X - 5, topLeft.Y + size.Y)
			healthBar.To = Vector2.new(topLeft.X - 5, topLeft.Y + size.Y * (1 - healthRatio))
			healthBar.Visible = HealthBarEnabled
		else
			espBox.Visible = false
			tracer.Visible = false
			nameTag.Visible = false
			healthBar.Visible = false
		end
	end)
end

-- Apply ESP to players
for _, player in pairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		DrawESP(player)
	end
end

Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		DrawESP(player)
	end
end)
