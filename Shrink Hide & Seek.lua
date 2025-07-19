local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- UI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LuminaModernUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 330, 0, 360)
main.Position = UDim2.new(0.5, -165, 0.5, -180)
main.BackgroundTransparency = 0.2
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- RGB Border
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function()
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		stroke.Color = Color3.fromHSV(hue/360, 1, 1)
		task.wait(0.03)
	end
end)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "⛺ Shrink Hide & Seek"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Toggle UI
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 120, 0, 35)
toggleBtn.Position = UDim2.new(0, 15, 0, 20)
toggleBtn.Text = "⚙️ Show UI"
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextScaled = true

local shown = true
toggleBtn.MouseButton1Click:Connect(function()
	shown = not shown
	main.Visible = shown
	toggleBtn.Text = shown and "⚙️ Hide UI" or "⚙️ Show UI"
end)

-- UI Button Template
function createToggleButton(text, position, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(0, 290, 0, 35)
	btn.Position = UDim2.new(0, 20, 0, position)
	btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	btn.Text = text .. ": OFF"
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = text .. ": " .. (state and "ON" or "OFF")
		btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
		callback(state)
	end)
end

-- ESP Feature
local function setupESP()
	local function createESP(plr)
		local BillboardGui = Instance.new("BillboardGui")
		BillboardGui.Name = "LuminaESP"
		BillboardGui.Adornee = plr.Character:WaitForChild("Head")
		BillboardGui.Size = UDim2.new(0, 100, 0, 40)
		BillboardGui.AlwaysOnTop = true

		local TextLabel = Instance.new("TextLabel", BillboardGui)
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = "👀 HIDERS"
		TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		TextLabel.TextStrokeTransparency = 0
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.TextScaled = true

		BillboardGui.Parent = plr.Character

		local Tracer = Drawing.new("Line")
		Tracer.Color = Color3.fromRGB(255, 0, 0)
		Tracer.Thickness = 1

		RunService.RenderStepped:Connect(function()
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local pos, visible = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
				Tracer.Visible = visible
				if visible then
					Tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
					Tracer.To = Vector2.new(pos.X, pos.Y)
				end
			end
		end)
	end

	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("LuminaESP") then
			createESP(p)
		end
	end
end

createToggleButton("ESP", 60, function(state)
	if state then setupESP() end
end)

-- Noclip
local noclip = false
RunService.Stepped:Connect(function()
	if noclip and LocalPlayer.Character then
		for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
end)
createToggleButton("Noclip", 110, function(state)
	noclip = state
end)

-- Hitbox Slider
_G.HeadSize = 2
_G.Disabled = true

local hitboxBtn = Instance.new("TextButton", main)
hitboxBtn.Size = UDim2.new(0, 290, 0, 35)
hitboxBtn.Position = UDim2.new(0, 20, 0, 160)
hitboxBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hitboxBtn.TextColor3 = Color3.new(1, 1, 1)
hitboxBtn.Font = Enum.Font.GothamBold
hitboxBtn.TextScaled = true
hitboxBtn.Text = "Hitbox Size: 2"

hitboxBtn.MouseButton1Click:Connect(function()
	_G.HeadSize = (_G.HeadSize + 1) % 21
	if _G.HeadSize == 0 then _G.HeadSize = 1 end
	hitboxBtn.Text = "Hitbox Size: " .. tostring(_G.HeadSize)
end)

RunService.RenderStepped:Connect(function()
	if _G.Disabled then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				pcall(function()
					local part = plr.Character.HumanoidRootPart
					part.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
					part.Transparency = 0.7
					part.BrickColor = BrickColor.new("Really blue")
					part.Material = "Neon"
					part.CanCollide = false
				end)
			end
		end
	end
end)

-- RGB Credit
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, 0, 0, 25)
credit.Position = UDim2.new(0, 0, 1, -25)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.GothamBold
credit.Text = "🔎 Script by - @Luminaprojects"
credit.TextScaled = true

task.spawn(function()
	while true do
		local hue = tick() % 5 / 5
		credit.TextColor3 = Color3.fromHSV(hue, 1, 1)
		task.wait(0.1)
	end
end)
