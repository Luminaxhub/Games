-- FlowESP UI Full with Hollow Box, Tracer, Health Bar, Name + Distance, Team Check, RGB Credit
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local localPlayer = players.LocalPlayer

local espEnabled = false
local espFolder = Instance.new("Folder", game.CoreGui)
espFolder.Name = "FlowESP_Objects"

-- UI Setup (minimal, retain your style)
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.ResetOnSpawn = false

-- Minimize Button
local toggleFrame = Instance.new("Frame", screenGui)
toggleFrame.Size = UDim2.new(0, 200, 0, 30)
toggleFrame.Position = UDim2.new(0.5, -100, 0, 0)
toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
toggleFrame.BorderSizePixel = 0

local minimize = Instance.new("TextButton", toggleFrame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -30, 0, 0)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local espToggle = Instance.new("TextButton", toggleFrame)
espToggle.Size = UDim2.new(0, 100, 0, 30)
espToggle.Position = UDim2.new(0, 5, 0, 0)
espToggle.Text = "ESP: OFF"
espToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- RGB credit text
local credit = Instance.new("TextLabel", screenGui)
credit.Size = UDim2.new(0, 400, 0, 30)
credit.Position = UDim2.new(0.5, -200, 1, -40)
credit.Text = "Script by - @Luminaprojects"
credit.TextScaled = true
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.SourceSansBold
credit.TextColor3 = Color3.new(1,0,0)

-- Animate RGB text
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait(0.05)
		end
	end
end)

-- Clear ESP
local function clearESP()
	for _, v in pairs(espFolder:GetChildren()) do
		v:Destroy()
	end
end

-- Create ESP for a player
local function createESP(plr)
	if plr == localPlayer then return end
	if plr.Team == localPlayer.Team then return end
	local char = plr.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Transparency = 1
	box.Color = Color3.fromRGB(255, 255, 255)
	box.Filled = false

	local tracer = Drawing.new("Line")
	tracer.Thickness = 1
	tracer.Transparency = 1
	tracer.Color = Color3.fromRGB(255, 255, 255)

	local nameTag = Drawing.new("Text")
	nameTag.Size = 16
	nameTag.Color = Color3.fromRGB(255, 255, 255)
	nameTag.Center = true
	nameTag.Outline = true

	local healthBar = Drawing.new("Line")
	healthBar.Thickness = 2
	healthBar.Color = Color3.fromRGB(0, 255, 0)

	local con
	con = runService.RenderStepped:Connect(function()
		if not char or not char:FindFirstChild("HumanoidRootPart") then
			box.Visible = false
			tracer.Visible = false
			nameTag.Visible = false
			healthBar.Visible = false
			return
		end

		local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(char.HumanoidRootPart.Position)
		if not onScreen then
			box.Visible = false
			tracer.Visible = false
			nameTag.Visible = false
			healthBar.Visible = false
			return
		end

		local size = 4
		local head = char:FindFirstChild("Head")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not head or not hum then return end

		local headPos = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
		local footPos = workspace.CurrentCamera:WorldToViewportPoint(char.HumanoidRootPart.Position - Vector3.new(0,3,0))
		local height = headPos.Y - footPos.Y
		local width = height / 2

		box.Size = Vector2.new(width, height)
		box.Position = Vector2.new(pos.X - width / 2, pos.Y - height / 2)
		box.Visible = true

		tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
		tracer.To = Vector2.new(pos.X, pos.Y + height/2)
		tracer.Visible = true

		nameTag.Text = plr.Name .. " [" .. math.floor((localPlayer:DistanceFromCharacter(char.HumanoidRootPart.Position))) .. "m]"
		nameTag.Position = Vector2.new(pos.X, pos.Y - height / 2 - 15)
		nameTag.Visible = true

		local hpRatio = hum.Health / hum.MaxHealth
		healthBar.From = Vector2.new(pos.X - width / 2 - 5, pos.Y + height / 2)
		healthBar.To = Vector2.new(pos.X - width / 2 - 5, pos.Y + height / 2 - height * hpRatio)
		healthBar.Visible = true
	end)

	local cleanup = Instance.new("ObjectValue")
	cleanup.Value = plr
	cleanup.Name = "ESP_"..plr.Name
	cleanup.Parent = espFolder
	cleanup.AncestryChanged:Connect(function()
		box:Remove()
		tracer:Remove()
		nameTag:Remove()
		healthBar:Remove()
		con:Disconnect()
	end)
end

-- Toggle ESP
espToggle.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
	clearESP()
	if espEnabled then
		for _, plr in pairs(players:GetPlayers()) do
			createESP(plr)
		end
	end
end)

players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		wait(1)
		if espEnabled then
			createESP(plr)
		end
	end)
end)

-- Minimize toggle
local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	toggleFrame.Visible = not minimized
end)
