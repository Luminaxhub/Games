-- 🔎 Flow's Prop Hunt - ESP & More Setting UI
-- Script by - @Luminaprojects (RGB Credit)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowUI"

-- Drag Function
local function MakeDraggable(frame)
	local dragging, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
	end)
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- Main UI
local MainUI = Instance.new("Frame", ScreenGui)
MainUI.Size = UDim2.new(0, 250, 0, 330)
MainUI.Position = UDim2.new(0.05, 0, 0.2, 0)
MainUI.BackgroundTransparency = 0.3
MainUI.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainUI.BorderSizePixel = 0

MakeDraggable(MainUI)

-- Title
local Title = Instance.new("TextLabel", MainUI)
Title.Text = "🔎 Flow's Prop Hunt"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Minimize Button
local MinBtn = Instance.new("TextButton", MainUI)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 0)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinBtn.Font = Enum.Font.Gotham
MinBtn.TextSize = 20

-- MoreSetting UI
local MoreUI = MainUI:Clone()
MoreUI.Parent = ScreenGui
MoreUI.Position = UDim2.new(0.3, 0, 0.2, 0)
MoreUI:FindFirstChild("TextLabel").Text = "🎄 More Setting"

local MoreMin = MoreUI:FindFirstChildOfClass("TextButton")
MoreMin.MouseButton1Click:Connect(function()
	local min = MainUI.Visible
	MainUI.Visible = not min
	MoreUI.Visible = not min
end)

MinBtn.MouseButton1Click:Connect(function()
	local min = MainUI.Visible
	MainUI.Visible = not min
	MoreUI.Visible = not min
end)

-- Credit RGB
local Credit = Instance.new("TextLabel", ScreenGui)
Credit.Position = UDim2.new(0.5, -100, 0.95, 0)
Credit.Size = UDim2.new(0, 200, 0, 30)
Credit.BackgroundTransparency = 1
Credit.Text = "Script by - @Luminaprojects"
Credit.TextScaled = true
Credit.Font = Enum.Font.GothamBold

-- Animate RGB
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			Credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait(0.05)
		end
	end
end)

-- ESP Settings
local ESP = {}
local function CreateESP(plr)
	if plr == LocalPlayer then return end
	local box = Drawing.new("Square")
	box.Visible = false
	box.Color = Color3.fromRGB(255, 255, 255)
	box.Thickness = 1
	box.Filled = false

	local tracer = Drawing.new("Line")
	tracer.Visible = false
	tracer.Thickness = 1
	tracer.Color = Color3.new(1, 1, 1)

	local nameTag = Drawing.new("Text")
	nameTag.Visible = false
	nameTag.Size = 14
	nameTag.Color = Color3.new(1, 1, 1)
	nameTag.Center = true
	nameTag.Outline = true

	local healthBar = Drawing.new("Line")
	healthBar.Visible = false
	healthBar.Color = Color3.fromRGB(0, 255, 0)
	healthBar.Thickness = 2

	ESP[plr] = {Box = box, Tracer = tracer, Name = nameTag, Health = healthBar}
end

for _, p in ipairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(p)
	if ESP[p] then
		for _, obj in pairs(ESP[p]) do obj:Remove() end
		ESP[p] = nil
	end
end)

RunService.RenderStepped:Connect(function()
	for plr, info in pairs(ESP) do
		local char = plr.Character
		if char and char:FindFirstChild("HumanoidRootPart") and plr.Team ~= LocalPlayer.Team then
			local hrp = char.HumanoidRootPart
			local hum = char:FindFirstChild("Humanoid")
			local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
			if onScreen then
				local sizeY = math.clamp(3000 / (hrp.Position - Camera.CFrame.Position).Magnitude, 2, 50)
				info.Box.Size = Vector2.new(sizeY * 0.6, sizeY)
				info.Box.Position = Vector2.new(pos.X - sizeY * 0.3, pos.Y - sizeY / 2)
				info.Box.Visible = true

				info.Tracer.From = Vector2.new(pos.X, pos.Y)
				info.Tracer.To = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
				info.Tracer.Visible = true

				info.Name.Position = Vector2.new(pos.X, pos.Y - sizeY / 2 - 15)
				info.Name.Text = plr.Name .. " [" .. math.floor((hrp.Position - Camera.CFrame.Position).Magnitude) .. "m]"
				info.Name.Visible = true

				info.Health.From = Vector2.new(pos.X - sizeY * 0.35, pos.Y - sizeY / 2)
				info.Health.To = Vector2.new(pos.X - sizeY * 0.35, pos.Y - sizeY / 2 + (hum.Health / hum.MaxHealth) * sizeY)
				info.Health.Visible = true
			else
				for _, obj in pairs(info) do obj.Visible = false end
			end
		else
			for _, obj in pairs(info) do obj.Visible = false end
		end
	end
end)

-- More Setting Feature
local function AddToggle(ui, text, callback)
	local button = Instance.new("TextButton", ui)
	button.Size = UDim2.new(1, -10, 0, 35)
	button.Position = UDim2.new(0, 5, 0, #ui:GetChildren() * 40)
	button.Text = text
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	local toggled = false
	button.MouseButton1Click:Connect(function()
		toggled = not toggled
		callback(toggled)
		button.Text = text .. (toggled and " [ON]" or " [OFF]")
	end)
end

AddToggle(MoreUI, "Custom Speed", function(on)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = on and 50 or 16
end)

AddToggle(MoreUI, "Custom Jump", function(on)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = on and 80 or 50
end)

AddToggle(MoreUI, "Noclip", function(on)
	if on then
		RunService.Stepped:Connect(function()
			for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide == true then
					v.CanCollide = false
				end
			end
		end)
	else
		for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = true
			end
		end
	end
end)
