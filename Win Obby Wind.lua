-- Made by @Luminaprojects
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 60, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "⚙️"
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BorderSizePixel = 0

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 350)
Main.Position = UDim2.new(0.5, -150, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 4

-- Border RGB
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local color = Color3.fromHSV(i, 1, 1)
			Main.BorderColor3 = color
			wait()
		end
	end
end)

Main.Visible = false

ToggleButton.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

-- Drag
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

RunService.Heartbeat:Connect(function()
	if dragging and dragInput then
		update(dragInput)
	end
end)

-- Title RGB
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🏆 Win Obby Land"
Title.BackgroundTransparency = 1
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold

spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local c = Color3.fromHSV(i, 1, 1)
			Title.TextColor3 = c
			wait()
		end
	end
end)

local spacing = 40
local function createButton(name, func)
	local btn = Instance.new("TextButton", Main)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, 0, spacing)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	spacing += 35
	btn.MouseButton1Click:Connect(func)
end

local autoTP = false
createButton("Inf Wins 🏆", function()
	autoTP = not autoTP
	if autoTP then
		while autoTP do
			task.wait(2)
			LocalPlayer.Character:PivotTo(CFrame.new(10, 276, -277))
		end
	end
end)

createButton("Finish Path 🕊️", function()
	task.wait(2)
	LocalPlayer.Character:PivotTo(CFrame.new(12, 197, -239))
end)

createButton("Give Squid Pet", function()
	local args = { "Squid Pet" }
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PET_Equip"):FireServer(unpack(args))
end)

-- Fly toggle
local flying = false
local flyVel, flyGyro
createButton("Toggle Fly 🪶", function()
	flying = not flying
	local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if flying then
		flyVel = Instance.new("BodyVelocity", root)
		flyVel.Velocity = Vector3.zero
		flyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)

		flyGyro = Instance.new("BodyGyro", root)
		flyGyro.CFrame = root.CFrame
		flyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)

		RunService.RenderStepped:Connect(function()
			if flying then
				local camCF = workspace.CurrentCamera.CFrame
				local move = Vector3.zero
				if UIS:IsKeyDown(Enum.KeyCode.W) then move += camCF.LookVector end
				if UIS:IsKeyDown(Enum.KeyCode.S) then move -= camCF.LookVector end
				if UIS:IsKeyDown(Enum.KeyCode.A) then move -= camCF.RightVector end
				if UIS:IsKeyDown(Enum.KeyCode.D) then move += camCF.RightVector end
				move = Vector3.new(move.X, 0, move.Z)
				flyVel.Velocity = move.Unit * 100
				flyGyro.CFrame = camCF
			end
		end)
	else
		if flyVel then flyVel:Destroy() end
		if flyGyro then flyGyro:Destroy() end
	end
end)

-- Walkspeed & Jumppower input
local wsBox = Instance.new("TextBox", Main)
wsBox.PlaceholderText = "WalkSpeed (Default 16)"
wsBox.Size = UDim2.new(0.9, 0, 0, 30)
wsBox.Position = UDim2.new(0.05, 0, 0, spacing)
wsBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
wsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
wsBox.BorderSizePixel = 0
spacing += 35

wsBox.FocusLost:Connect(function()
	local num = tonumber(wsBox.Text)
	if num then
		LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = num
	end
end)

local jpBox = Instance.new("TextBox", Main)
jpBox.PlaceholderText = "JumpPower (Default 50)"
jpBox.Size = UDim2.new(0.9, 0, 0, 30)
jpBox.Position = UDim2.new(0.05, 0, 0, spacing)
jpBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jpBox.BorderSizePixel = 0
spacing += 35

jpBox.FocusLost:Connect(function()
	local num = tonumber(jpBox.Text)
	if num then
		LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = num
	end
end)

-- RGB Credit
local credit = Instance.new("TextLabel", Main)
credit.Size = UDim2.new(1, 0, 0, 25)
credit.Position = UDim2.new(0, 0, 1, -25)
credit.BackgroundTransparency = 1
credit.Text = "Script by - luminaprojects"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 14

spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local c = Color3.fromHSV(i, 1, 1)
			credit.TextColor3 = c
			wait()
		end
	end
end)
