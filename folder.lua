-- 🔎 Flow's Prop Hunt UI - ESP & Settings
-- Script by - @Luminaprojects (RGB Credit)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowESP_UI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 310)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local TitleBar = Instance.new("TextLabel", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Text = "🔎 Flow's Prop Hunt"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 16

local MinimizeButton = Instance.new("TextButton", TitleBar)
MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
MinimizeButton.Position = UDim2.new(1, -30, 0, 0)
MinimizeButton.Text = "-"
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.BackgroundTransparency = 1

local Body = Instance.new("Frame", MainFrame)
Body.Size = UDim2.new(1, 0, 1, -30)
Body.Position = UDim2.new(0, 0, 0, 30)
Body.BackgroundTransparency = 1

-- Toggle ESP Box
local ESPEnabled = false
local function CreateToggle(name, callback)
	local btn = Instance.new("TextButton", Body)
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, #Body:GetChildren()*35 - 35)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = "🔘 "..name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = (state and "✅ " or "🔘 ")..name
		callback(state)
	end)
end

CreateToggle("ESP Box", function(on)
	ESPEnabled = on
end)

-- Noclip
local Noclip = false
CreateToggle("Noclip", function(state)
	Noclip = state
end)

RunService.Stepped:Connect(function()
	if Noclip then
		for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

-- Slider Helper
local function CreateSlider(name, min, max, default, callback)
	local label = Instance.new("TextLabel", Body)
	label.Size = UDim2.new(1, -20, 0, 20)
	label.Position = UDim2.new(0, 10, 0, #Body:GetChildren()*35 - 30)
	label.Text = name..": "..default
	label.Font = Enum.Font.Gotham
	label.TextColor3 = Color3.new(1,1,1)
	label.TextSize = 14
	label.BackgroundTransparency = 1

	local slider = Instance.new("Frame", Body)
	slider.Size = UDim2.new(1, -20, 0, 10)
	slider.Position = UDim2.new(0, 10, 0, #Body:GetChildren()*35 - 20)
	slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	local fill = Instance.new("Frame", slider)
	fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)

	local dragging = false
	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
		end
	end)
	slider.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.Position then
			local pos = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
			pos = math.clamp(pos, 0, 1)
			fill.Size = UDim2.new(pos, 0, 1, 0)
			local val = math.floor(min + (max - min) * pos)
			label.Text = name..": "..val
			callback(val)
		end
	end)
end

-- Walkspeed & JumpPower
CreateSlider("Walkspeed", 16, 150, 16, function(val)
	if LocalPlayer.Character then
		LocalPlayer.Character.Humanoid.WalkSpeed = val
	end
end)

CreateSlider("JumpPower", 50, 200, 50, function(val)
	if LocalPlayer.Character then
		LocalPlayer.Character.Humanoid.JumpPower = val
	end
end)

-- Minimize Logic
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	Body.Visible = not minimized
	MainFrame.Size = minimized and UDim2.new(0, 250, 0, 30) or UDim2.new(0, 250, 0, 310)
end)

-- ESP Drawing
RunService.RenderStepped:Connect(function()
	if not ESPEnabled then return end
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = plr.Character.HumanoidRootPart
			local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)
			if onscreen then
				local name = Drawing.new("Text")
				name.Text = plr.Name
				name.Size = 16
				name.Center = true
				name.Outline = true
				name.Color = Color3.new(1,1,1)
				name.Position = Vector2.new(pos.X, pos.Y - 30)
				name.Visible = true
				game:GetService("Debris"):AddItem(name, 0.03)

				local box = Drawing.new("Square")
				box.Size = Vector2.new(50, 100)
				box.Position = Vector2.new(pos.X - 25, pos.Y - 50)
				box.Color = Color3.fromRGB(255, 255, 255)
				box.Thickness = 1
				box.Visible = true
				game:GetService("Debris"):AddItem(box, 0.03)
			end
		end
	end
end)

-- Credit
local credit = Instance.new("TextLabel", ScreenGui)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.Text = "Script by - @Luminaprojects"
credit.TextColor3 = Color3.fromRGB(255,0,0)
credit.BackgroundTransparency = 1
credit.TextSize = 14
credit.Font = Enum.Font.GothamBold

-- RGB Credit Animation
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait(0.05)
		end
	end
end)
