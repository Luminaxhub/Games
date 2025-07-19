local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LuminaScrollUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 330, 0, 360)
main.Position = UDim2.new(0.5, -165, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BackgroundTransparency = 0.2
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
		stroke.Color = Color3.fromHSV(hue / 360, 1, 1)
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

-- Scrolling Area
local scrolling = Instance.new("ScrollingFrame", main)
scrolling.Size = UDim2.new(1, 0, 1, -60)
scrolling.Position = UDim2.new(0, 0, 0, 40)
scrolling.CanvasSize = UDim2.new(0, 0, 0, 400)
scrolling.ScrollBarThickness = 5
scrolling.BackgroundTransparency = 1

-- Template Function for Toggle Button
function createToggleButton(text, yPos, callback)
	local btn = Instance.new("TextButton", scrolling)
	btn.Size = UDim2.new(0, 290, 0, 35)
	btn.Position = UDim2.new(0, 20, 0, yPos)
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

-- Feature 1: ESP
local function setupESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("LuminaESP") then
			local BillboardGui = Instance.new("BillboardGui")
			BillboardGui.Name = "LuminaESP"
			BillboardGui.Adornee = p.Character:WaitForChild("Head")
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

			BillboardGui.Parent = p.Character

			local Tracer = Drawing.new("Line")
			Tracer.Color = Color3.fromRGB(255, 0, 0)
			Tracer.Thickness = 1

			RunService.RenderStepped:Connect(function()
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					local pos, visible = workspace.CurrentCamera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
					Tracer.Visible = visible
					if visible then
						Tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
						Tracer.To = Vector2.new(pos.X, pos.Y)
					end
				else
					Tracer.Visible = false
				end
			end)
		end
	end
end
createToggleButton("ESP", 0, function(state)
	if state then setupESP() end
end)

-- Feature 2: Hitbox
_G.HeadSize = 2
_G.Disabled = true
local hitboxBtn = Instance.new("TextButton", scrolling)
hitboxBtn.Size = UDim2.new(0, 290, 0, 35)
hitboxBtn.Position = UDim2.new(0, 20, 0, 50)
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

-- Feature 3: Noclip
local noclip = false
RunService.Stepped:Connect(function()
	if noclip and LocalPlayer.Character then
		for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
end)
createToggleButton("Noclip", 100, function(state)
	noclip = state
end)

-- Feature 4: Auto Spin
createToggleButton("Auto Spin", 150, function(state)
	if state then
		_G.autoSpin = true
		task.spawn(function()
			while _G.autoSpin do
				pcall(function()
					ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Spin"):InvokeServer()
				end)
				task.wait(1)
			end
		end)
	else
		_G.autoSpin = false
	end
end)

-- Feature 5: Mini Mode
createToggleButton("Mini Mode 39R$", 200, function(state)
	-- Dummy function, bisa ditambahkan efek kecil jika ada
end)

-- Feature 6: Big Mode
createToggleButton("Big Mode", 250, function(state)
	if state then
		local args = {
			{{"Grow"}, "\004"}
		}
		ReplicatedStorage:WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
	end
end)

-- RGB Credit
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
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
