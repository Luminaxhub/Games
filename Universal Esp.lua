-- SERVICE SETUP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- UI SETUP
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AdvancedESP_UI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 280, 0, 340)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🎯 Advanced ESP Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Minimize
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
		if v:IsA("GuiObject") and v ~= Minimize and v ~= Title and v.Name ~= "Credit" then
			v.Visible = not Minimized
		end
	end
end)

-- RGB CREDIT
local Credit = Instance.new("TextLabel", Frame)
Credit.Name = "Credit"
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.GothamSemibold
Credit.TextSize = 14
Credit.Text = "Script by - @luminaprojects"
Credit.TextColor3 = Color3.fromRGB(255, 0, 0)

-- RGB Loop
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local r = math.sin(i * math.pi * 2) * 127 + 128
			local g = math.sin(i * math.pi * 2 + 2) * 127 + 128
			local b = math.sin(i * math.pi * 2 + 4) * 127 + 128
			Credit.TextColor3 = Color3.fromRGB(r, g, b)
			task.wait(0.03)
		end
	end
end)

-- Toggle ESP ON/OFF
local espEnabled = true
local ESPToggle = Instance.new("TextButton", Frame)
ESPToggle.Size = UDim2.new(1, -20, 0, 30)
ESPToggle.Position = UDim2.new(0, 10, 0, 40)
ESPToggle.Text = "✅ ESP ON"
ESPToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ESPToggle.TextColor3 = Color3.new(1, 1, 1)
ESPToggle.Font = Enum.Font.Gotham
ESPToggle.TextSize = 14
ESPToggle.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	ESPToggle.Text = espEnabled and "✅ ESP ON" or "❌ ESP OFF"
end)

-- Team Check Toggle
local teamCheck = true
local TeamCheckButton = Instance.new("TextButton", Frame)
TeamCheckButton.Size = UDim2.new(1, -20, 0, 30)
TeamCheckButton.Position = UDim2.new(0, 10, 0, 80)
TeamCheckButton.Text = "✅ Team Check ON"
TeamCheckButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TeamCheckButton.TextColor3 = Color3.new(1, 1, 1)
TeamCheckButton.Font = Enum.Font.Gotham
TeamCheckButton.TextSize = 14
TeamCheckButton.MouseButton1Click:Connect(function()
	teamCheck = not teamCheck
	TeamCheckButton.Text = teamCheck and "✅ Team Check ON" or "❌ Team Check OFF"
end)

-- ESP Drawing Function
function CreateESP(plr)
	local box = Drawing.new("Square")
	box.Thickness = 2
	box.Filled = false
	box.Color = Color3.fromRGB(255, 255, 255)
	box.Visible = false

	local tracer = Drawing.new("Line")
	tracer.Thickness = 1.5
	tracer.Color = Color3.fromRGB(255, 255, 255)
	tracer.Visible = false

	local nameText = Drawing.new("Text")
	nameText.Size = 13
	nameText.Outline = true
	nameText.Center = true
	nameText.Color = Color3.fromRGB(255, 255, 255)
	nameText.Visible = false

	local healthLine = Drawing.new("Line")
	healthLine.Thickness = 2
	healthLine.Color = Color3.fromRGB(0, 255, 0)
	healthLine.Visible = false

	RunService.RenderStepped:Connect(function()
		if not espEnabled then
			box.Visible = false
			tracer.Visible = false
			nameText.Visible = false
			healthLine.Visible = false
			return
		end
		if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr ~= localPlayer then
			local humanoid = plr.Character:FindFirstChild("Humanoid")
			if humanoid and humanoid.Health > 0 then
				if teamCheck and plr.Team == localPlayer.Team then
					box.Visible = false
					tracer.Visible = false
					nameText.Visible = false
					healthLine.Visible = false
					return
				end

				local pos, onscreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
				local head = plr.Character:FindFirstChild("Head")
				if onscreen and head then
					local headPos = camera:WorldToViewportPoint(head.Position)
					local height = (headPos - pos).Y
					local width = height / 2

					box.Size = Vector2.new(width, height)
					box.Position = Vector2.new(pos.X - width / 2, pos.Y - height / 2)
					box.Visible = true

					tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
					tracer.To = Vector2.new(pos.X, pos.Y + height / 2)
					tracer.Visible = true

					nameText.Text = plr.Name .. " [".. math.floor((plr.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude).."m]"
					nameText.Position = Vector2.new(pos.X, pos.Y - height / 2 - 15)
					nameText.Visible = true

					local hp = humanoid.Health / humanoid.MaxHealth
					healthLine.From = Vector2.new(pos.X - width / 2 - 5, pos.Y + height / 2)
					healthLine.To = Vector2.new(pos.X - width / 2 - 5, pos.Y + height / 2 - (height * hp))
					healthLine.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 0)
					healthLine.Visible = true
				else
					box.Visible = false
					tracer.Visible = false
					nameText.Visible = false
					healthLine.Visible = false
				end
			end
		else
			box.Visible = false
			tracer.Visible = false
			nameText.Visible = false
			healthLine.Visible = false
		end
	end)
end

-- ESP Untuk Semua Pemain
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
