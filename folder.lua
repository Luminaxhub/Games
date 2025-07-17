-- // 🔎 Flow's Prop Hunt UI with ESP + HealthBar + Tracer + WalkSpeed/JumpPower + Key System
-- // Script by - @Luminaprojects (RGB credit)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- SETTINGS
local KEY_URL = "https://get-key-luminakey.vercel.app/api/validate?key="
local VALID_KEY = false
local USER_KEY = "LUMINAKEY_pxs0up8r2bh2j19"

-- CREATE UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowESP_UI"
ScreenGui.ResetOnSpawn = false

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.3, 0, 0.2, 0)
Main.Size = UDim2.new(0, 250, 0, 310)
Main.Visible = false
Main.Active = true
Main.Draggable = true

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🔎 Flow's Prop Hunt"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextScaled = true

-- Credit RGB
local Credit = Instance.new("TextLabel", Main)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.BackgroundTransparency = 1
Credit.Text = "Script by - @Luminaprojects"
Credit.Font = Enum.Font.Gotham
Credit.TextScaled = true

-- RGB effect
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local hue = i
			Credit.TextColor3 = Color3.fromHSV(hue, 1, 1)
			task.wait()
		end
	end
end)

-- Button Template Function
local function CreateToggle(text, y, callback)
	local btn = Instance.new("TextButton", Main)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, 0, y)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		btn.Text = text .. ": " .. (state and "ON" or "OFF")
	end)
end

-- Slider Template
local function CreateSlider(text, y, callback)
	local label = Instance.new("TextLabel", Main)
	label.Size = UDim2.new(0.9, 0, 0, 20)
	label.Position = UDim2.new(0.05, 0, 0, y)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextScaled = true

	local slider = Instance.new("TextButton", Main)
	slider.Size = UDim2.new(0.9, 0, 0, 20)
	slider.Position = UDim2.new(0.05, 0, 0, y + 25)
	slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	slider.Text = "50"
	slider.TextScaled = true
	slider.Font = Enum.Font.Gotham
	slider.TextColor3 = Color3.fromRGB(255, 255, 255)

	slider.MouseButton1Click:Connect(function()
		local input = tonumber(game:GetService("Players").LocalPlayer:PromptInput("Enter " .. text .. " (1-100)"))
		if input then
			local clamped = math.clamp(input, 1, 100)
			slider.Text = tostring(clamped)
			callback(clamped)
		end
	end)
end

-- ESP Function
local function CreateESP(player)
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Transparency = 1
	box.Color = Color3.new(1, 1, 1)
	box.Filled = false

	local tracer = Drawing.new("Line")
	tracer.Color = Color3.new(1,1,1)
	tracer.Thickness = 1
	tracer.Transparency = 1

	local healthbar = Drawing.new("Line")
	healthbar.Color = Color3.fromRGB(0,255,0)
	healthbar.Thickness = 2
	healthbar.Transparency = 1

	RunService.RenderStepped:Connect(function()
		if player.Team == LocalPlayer.Team and teamCheck then
			box.Visible = false
			tracer.Visible = false
			healthbar.Visible = false
			return
		end

		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp and char:FindFirstChild("Humanoid") and char:FindFirstChild("Head") and char.Humanoid.Health > 0 then
			local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
			if onScreen then
				local size = 100 / (hrp.Position - workspace.CurrentCamera.CFrame.Position).Magnitude * 3
				box.Size = Vector2.new(size, size * 1.5)
				box.Position = Vector2.new(pos.X - size/2, pos.Y - size * 1.5 / 2)
				box.Visible = true

				tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
				tracer.To = Vector2.new(pos.X, pos.Y)
				tracer.Visible = true

				local healthPercent = math.clamp(char.Humanoid.Health / char.Humanoid.MaxHealth, 0, 1)
				healthbar.From = Vector2.new(pos.X - size/2 - 5, pos.Y + size * 0.75)
				healthbar.To = Vector2.new(pos.X - size/2 - 5, pos.Y + size * 0.75 - size * healthPercent)
				healthbar.Visible = true
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

-- Triggers
local espEnabled = false
local teamCheck = false

CreateToggle("ESP", 40, function(state)
	espEnabled = state
	if state then
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then
				CreateESP(p)
			end
		end
	end
end)

CreateToggle("TEAM CHECK", 80, function(state)
	teamCheck = state
end)

CreateSlider("Walkspeed", 120, function(val)
	LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

CreateSlider("JumpPower", 180, function(val)
	LocalPlayer.Character.Humanoid.JumpPower = val
end)

-- GET KEY UI
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyFrame.Active = true
KeyFrame.Draggable = true

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
KeyBox.PlaceholderText = "Enter your key here"
KeyBox.TextScaled = true
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)

local Submit = Instance.new("TextButton", KeyFrame)
Submit.Size = UDim2.new(0.6, 0, 0, 40)
Submit.Position = UDim2.new(0.2, 0, 0.6, 0)
Submit.Text = "Submit Key"
Submit.TextScaled = true
Submit.Font = Enum.Font.GothamBold
Submit.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)

Submit.MouseButton1Click:Connect(function()
	local key = KeyBox.Text
	if key ~= "" then
		pcall(function()
			local res = game:HttpGet(KEY_URL..key)
			local data = HttpService:JSONDecode(res)
			if data.success then
				VALID_KEY = true
				KeyFrame.Visible = false
				Main.Visible = true
			else
				KeyBox.Text = "Invalid!"
			end
		end)
	end
end)
