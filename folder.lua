-- Flow's Prop Hunt UI with ESP, Key, Walkspeed, JumpPower
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

local HttpService = game:GetService("HttpService")
local keyValid = false
local key = "LUMINAKEY_pxs0up8r2bh2j19" -- Key otomatis

-- UI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "FlowESPUI"
screenGui.ResetOnSpawn = false

local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 270, 0, 320)
main.Position = UDim2.new(0.5, -135, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Text = "🔎 Flow's Prop Hunt"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local credit = Instance.new("TextLabel", main)
credit.Text = "Script by - @Luminaprojects"
credit.Position = UDim2.new(0, 0, 1, -20)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.GothamSemibold
credit.TextSize = 14

-- RGB Credit
spawn(function()
	while true do
		for hue = 0, 255, 4 do
			credit.TextColor3 = Color3.fromHSV(hue / 255, 1, 1)
			wait(0.03)
		end
	end
end)

-- Minimize Button
local min = Instance.new("TextButton", title)
min.Text = "-"
min.Font = Enum.Font.GothamBold
min.TextSize = 18
min.Size = UDim2.new(0, 30, 0, 30)
min.Position = UDim2.new(1, -30, 0, 0)
min.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
min.TextColor3 = Color3.fromRGB(255, 255, 255)

local contentVisible = true
min.MouseButton1Click:Connect(function()
	contentVisible = not contentVisible
	for _, v in ipairs(main:GetChildren()) do
		if v:IsA("TextButton") or v:IsA("TextLabel") then
			if v ~= title and v ~= min and v ~= credit then
				v.Visible = contentVisible
			end
		end
	end
end)

-- Toggle UI Elements
local y = 35
function addToggle(name, callback)
	local toggle = Instance.new("TextButton", main)
	toggle.Text = "OFF - " .. name
	toggle.Size = UDim2.new(1, 0, 0, 30)
	toggle.Position = UDim2.new(0, 0, 0, y)
	toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggle.Font = Enum.Font.Gotham
	toggle.TextSize = 14
	y = y + 35

	local state = false
	toggle.MouseButton1Click:Connect(function()
		state = not state
		toggle.Text = (state and "ON" or "OFF") .. " - " .. name
		callback(state)
	end)
end

-- Sliders
function addSlider(name, min, max, default, callback)
	local label = Instance.new("TextLabel", main)
	label.Text = name .. ": " .. tostring(default)
	label.Size = UDim2.new(1, 0, 0, 20)
	label.Position = UDim2.new(0, 0, 0, y)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.Gotham
	label.TextSize = 14

	y = y + 20

	local slider = Instance.new("TextButton", main)
	slider.Size = UDim2.new(1, 0, 0, 20)
	slider.Position = UDim2.new(0, 0, 0, y)
	slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	slider.Text = ""
	y = y + 25

	local fill = Instance.new("Frame", slider)
	fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BorderSizePixel = 0

	local dragging = false

	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
		end
	end)

	uis.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	uis.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local rel = input.Position.X - slider.AbsolutePosition.X
			local percent = math.clamp(rel / slider.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(percent, 0, 1, 0)
			local value = math.floor(min + (max - min) * percent)
			label.Text = name .. ": " .. tostring(value)
			callback(value)
		end
	end)
end

-- Walkspeed & Jumppower
addSlider("Walkspeed", 16, 100, 16, function(val)
	localPlayer.Character.Humanoid.WalkSpeed = val
end)

addSlider("JumpPower", 50, 100, 50, function(val)
	localPlayer.Character.Humanoid.JumpPower = val
end)

-- ESP System
local espEnabled = false
local teamCheck = false
local tracerEnabled = false
local healthEnabled = false

function createESP(plr)
	if plr == localPlayer then return end
	local char = plr.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local box = Drawing.new("Square")
	box.Color = Color3.fromRGB(255, 255, 255)
	box.Thickness = 1
	box.Transparency = 1
	box.Filled = false

	local tracer = Drawing.new("Line")
	tracer.Color = Color3.fromRGB(255, 255, 255)
	tracer.Thickness = 1

	local healthbar = Drawing.new("Line")
	healthbar.Color = Color3.fromRGB(0, 255, 0)
	healthbar.Thickness = 2

	runService.RenderStepped:Connect(function()
		local char = plr.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") or not espEnabled then
			box.Visible = false
			tracer.Visible = false
			healthbar.Visible = false
			return
		end

		if teamCheck and plr.Team == localPlayer.Team then
			box.Visible = false
			tracer.Visible = false
			healthbar.Visible = false
			return
		end

		local root = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if root and hum and hum.Health > 0 then
			local pos, visible = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
			if visible then
				local sizeY = 100
				local sizeX = 50
				box.Size = Vector2.new(sizeX, sizeY)
				box.Position = Vector2.new(pos.X - sizeX / 2, pos.Y - sizeY / 1.5)
				box.Visible = true

				if tracerEnabled then
					tracer.From = Vector2.new(pos.X, pos.Y)
					tracer.To = Vector2.new(pos.X, workspace.CurrentCamera.ViewportSize.Y)
					tracer.Visible = true
				else
					tracer.Visible = false
				end

				if healthEnabled then
					local health = hum.Health / hum.MaxHealth
					healthbar.From = Vector2.new(pos.X - 30, pos.Y - 50)
					healthbar.To = Vector2.new(pos.X - 30, pos.Y - 50 + (1 - health) * 100)
					healthbar.Visible = true
				else
					healthbar.Visible = false
				end
			else
				box.Visible = false
				tracer.Visible = false
				healthbar.Visible = false
			end
		else
			box.Visible = false
			tracer.Visible = false
			healthbar.Visible = false
		end
	end)
end

players.PlayerAdded:Connect(createESP)
for _, plr in pairs(players:GetPlayers()) do
	createESP(plr)
end

-- Add toggles
addToggle("ESP", function(v) espEnabled = v end)
addToggle("Tracer", function(v) tracerEnabled = v end)
addToggle("Health Bar", function(v) healthEnabled = v end)
addToggle("Team Check", function(v) teamCheck = v end)
