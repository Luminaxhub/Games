-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI Holder
local mainUI = Instance.new("ScreenGui", game.CoreGui)
mainUI.Name = "FlowESP_UI"
mainUI.ResetOnSpawn = false

-- Credit RGB
local function RGBColor()
	local r, g, b = math.random(), math.random(), math.random()
	return Color3.fromRGB(r * 255, g * 255, b * 255)
end

-- UI FRAME
local function createUIFrame(titleText, pos)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 240, 0, 250)
	frame.Position = pos
	frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	frame.BorderSizePixel = 0
	frame.BackgroundTransparency = 0.3
	frame.Active = true
	frame.Draggable = true

	local title = Instance.new("TextLabel", frame)
	title.Size = UDim2.new(1, 0, 0, 30)
	title.BackgroundTransparency = 1
	title.Text = 🔎 Flow's Prop Hunt
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16

	return frame
end

-- Minimize System
local function addMinimize(frame)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 25, 0, 25)
	btn.Position = UDim2.new(1, -30, 0, 5)
	btn.Text = "-"
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	btn.ZIndex = 2

	local minimized = false
	btn.MouseButton1Click:Connect(function()
		minimized = not minimized
		for _, child in pairs(frame:GetChildren()) do
			if child:IsA("TextButton") or child:IsA("TextBox") or child:IsA("Frame") then
				child.Visible = not minimized
			end
		end
		btn.Text = minimized and "+" or "-"
	end)
end

-- ESP SETTINGS
local espEnabled = false
local teamCheck = true

-- ESP Drawing Table
local drawings = {}

-- Clear Old Drawings
local function clearESP()
	for _, v in pairs(drawings) do
		for _, obj in pairs(v) do
			obj:Remove()
		end
	end
	drawings = {}
end

-- ESP Drawing Function
local function drawESP()
	clearESP()

	RunService:UnbindFromRenderStep("ESPUpdate")
	RunService:BindToRenderStep("ESPUpdate", Enum.RenderPriority.Camera.Value + 1, function()
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
				if teamCheck and player.Team == LocalPlayer.Team then continue end
				local hrp = player.Character.HumanoidRootPart
				local pos, onscreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)

				if not drawings[player] then
					drawings[player] = {
						box = Drawing.new("Square"),
						tracer = Drawing.new("Line"),
						health = Drawing.new("Square"),
						name = Drawing.new("Text"),
					}
				end

				local box = drawings[player].box
				local tracer = drawings[player].tracer
				local health = drawings[player].health
				local name = drawings[player].name

				if onscreen then
					local size = Vector2.new(40, 80)
					box.Visible = true
					box.Size = size
					box.Position = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
					box.Color = Color3.new(1, 1, 1)
					box.Thickness = 1
					box.Transparency = 1
					box.Filled = false

					tracer.Visible = true
					tracer.From = Vector2.new(pos.X, pos.Y + size.Y / 2)
					tracer.To = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
					tracer.Color = Color3.new(1, 1, 1)
					tracer.Thickness = 1

					health.Visible = true
					health.Size = Vector2.new(3, (player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth) * size.Y)
					health.Position = Vector2.new(pos.X - size.X/2 - 5, pos.Y + size.Y/2 - health.Size.Y)
					health.Color = Color3.new(0, 1, 0)
					health.Filled = true
					health.Transparency = 1

					name.Visible = true
					name.Text = player.Name .. " [" .. math.floor((hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "m]"
					name.Position = Vector2.new(pos.X - size.X / 2, pos.Y - size.Y/2 - 15)
					name.Size = 14
					name.Color = Color3.new(1,1,1)
					name.Center = false
					name.Outline = true
				else
					for _, obj in pairs(drawings[player]) do
						obj.Visible = false
					end
				end
			end
		end
	end)
end

-- Toggle ESP
local function toggleESP()
	espEnabled = not espEnabled
	if espEnabled then
		drawESP()
	else
		clearESP()
		RunService:UnbindFromRenderStep("ESPUpdate")
	end
end

-- FRAME UI
local mainFrame = createUIFrame("🔎 Flow's ESP", UDim2.new(0, 100, 0, 100))
mainFrame.Parent = mainUI
addMinimize(mainFrame)

-- ESP Toggle
local espToggle = Instance.new("TextButton", mainFrame)
espToggle.Size = UDim2.new(0, 200, 0, 30)
espToggle.Position = UDim2.new(0, 20, 0, 40)
espToggle.Text = "Toggle ESP"
espToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espToggle.TextColor3 = Color3.new(1, 1, 1)
espToggle.Font = Enum.Font.Gotham
espToggle.TextSize = 14
espToggle.MouseButton1Click:Connect(toggleESP)

-- Team Check Toggle
local teamToggle = Instance.new("TextButton", mainFrame)
teamToggle.Size = UDim2.new(0, 200, 0, 30)
teamToggle.Position = UDim2.new(0, 20, 0, 80)
teamToggle.Text = "Team Check: ON"
teamToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
teamToggle.TextColor3 = Color3.new(1, 1, 1)
teamToggle.Font = Enum.Font.Gotham
teamToggle.TextSize = 14
teamToggle.MouseButton1Click:Connect(function()
	teamCheck = not teamCheck
	teamToggle.Text = "Team Check: " .. (teamCheck and "ON" or "OFF")
end)

-- Credit Label
local credit = Instance.new("TextLabel", mainUI)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.Text = "Script by - @Luminaprojects"
credit.TextColor3 = Color3.fromRGB(255, 255, 255)
credit.Font = Enum.Font.GothamBold
credit.TextSize = 14

-- Animate RGB Credit
task.spawn(function()
	while true do
		credit.TextColor3 = RGBColor()
		task.wait(0.1)
	end
end)

-- More Setting UI
local moreUI = createUIFrame("🎄 More Setting", UDim2.new(0, 370, 0, 100))
moreUI.Parent = mainUI
addMinimize(moreUI)

-- WalkSpeed & JumpPower Toggle
local speedOn = false
local wsButton = Instance.new("TextButton", moreUI)
wsButton.Size = UDim2.new(0, 200, 0, 30)
wsButton.Position = UDim2.new(0, 20, 0, 40)
wsButton.Text = "Custom WalkSpeed: OFF"
wsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
wsButton.TextColor3 = Color3.new(1, 1, 1)
wsButton.Font = Enum.Font.Gotham
wsButton.TextSize = 14
wsButton.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	wsButton.Text = "Custom WalkSpeed: " .. (speedOn and "ON" or "OFF")
	if speedOn then
		LocalPlayer.Character.Humanoid.WalkSpeed = 100
	else
		LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
end)

local jumpOn = false
local jpButton = Instance.new("TextButton", moreUI)
jpButton.Size = UDim2.new(0, 200, 0, 30)
jpButton.Position = UDim2.new(0, 20, 0, 80)
jpButton.Text = "Custom JumpPower: OFF"
jpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
jpButton.TextColor3 = Color3.new(1, 1, 1)
jpButton.Font = Enum.Font.Gotham
jpButton.TextSize = 14
jpButton.MouseButton1Click:Connect(function()
	jumpOn = not jumpOn
	jpButton.Text = "Custom JumpPower: " .. (jumpOn and "ON" or "OFF")
	if jumpOn then
		LocalPlayer.Character.Humanoid.JumpPower = 120
	else
		LocalPlayer.Character.Humanoid.JumpPower = 50
	end
end)

-- Noclip Toggle
local noclip = false
local ncButton = Instance.new("TextButton", moreUI)
ncButton.Size = UDim2.new(0, 200, 0, 30)
ncButton.Position = UDim2.new(0, 20, 0, 120)
ncButton.Text = "Noclip: OFF"
ncButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ncButton.TextColor3 = Color3.new(1, 1, 1)
ncButton.Font = Enum.Font.Gotham
ncButton.TextSize = 14
ncButton.MouseButton1Click:Connect(function()
	noclip = not noclip
	ncButton.Text = "Noclip: " .. (noclip and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
	if noclip and LocalPlayer.Character then
		for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
	end
end)
