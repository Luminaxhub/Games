-- 🔎 Flow's Prop Hunt | ESP UI + GetKey + Credit
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "FlowESPUI"
local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.05, 0, 0.1, 0)
Frame.Size = UDim2.new(0, 220, 0, 180)
Frame.Active = true
Frame.Draggable = true
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Text = "🔎 Flow's Prop Hunt"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Credit RGB
local Credit = Instance.new("TextLabel", Frame)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.BackgroundTransparency = 1
Credit.Text = "Script by - @Luminaprojects"
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 14

local function updateRGB()
	local t = tick()
	while Credit and Credit.Parent do
		local r = math.sin(tick()) * 0.5 + 0.5
		local g = math.sin(tick() + 2) * 0.5 + 0.5
		local b = math.sin(tick() + 4) * 0.5 + 0.5
		Credit.TextColor3 = Color3.new(r, g, b)
		RunService.RenderStepped:Wait()
	end
end
coroutine.wrap(updateRGB)()

-- Minimize Button
local MinBtn = Instance.new("TextButton", Frame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -30, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18

local Minimized = false
MinBtn.MouseButton1Click:Connect(function()
	Minimized = not Minimized
	for _, child in pairs(Frame:GetChildren()) do
		if child:IsA("TextButton") or child:IsA("TextLabel") then
			if child ~= Title and child ~= MinBtn and child ~= Credit then
				child.Visible = not Minimized
			end
		end
	end
end)

-- GetKey + Verification
local Key = ""
local Verified = false

local KeyBox = Instance.new("TextBox", Frame)
KeyBox.PlaceholderText = "Enter Key Here"
KeyBox.Size = UDim2.new(1, -20, 0, 30)
KeyBox.Position = UDim2.new(0, 10, 0, 40)
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14

local VerifyBtn = Instance.new("TextButton", Frame)
VerifyBtn.Text = "Verify Key"
VerifyBtn.Size = UDim2.new(1, -20, 0, 25)
VerifyBtn.Position = UDim2.new(0, 10, 0, 75)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
VerifyBtn.TextColor3 = Color3.new(1,1,1)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 14

local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1, -20, 0, 20)
Status.Position = UDim2.new(0, 10, 0, 105)
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.new(1,0,0)
Status.Font = Enum.Font.Gotham
Status.TextSize = 14
Status.Text = ""

VerifyBtn.MouseButton1Click:Connect(function()
	local inputKey = KeyBox.Text
	local success, response = pcall(function()
		return game:HttpGet("https://get-key-luminakey.vercel.app/api/verify?key="..inputKey)
	end)
	if success and response:lower():find("success") then
		Verified = true
		Status.Text = "✅ Verified!"
		Status.TextColor3 = Color3.fromRGB(0,255,0)
	else
		Status.Text = "❌ Invalid Key"
		Status.TextColor3 = Color3.fromRGB(255,0,0)
	end
end)

-- ESP Feature
local ToggleESP = Instance.new("TextButton", Frame)
ToggleESP.Text = "ESP [OFF]"
ToggleESP.Size = UDim2.new(1, -20, 0, 30)
ToggleESP.Position = UDim2.new(0, 10, 0, 135)
ToggleESP.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleESP.TextColor3 = Color3.new(1,1,1)
ToggleESP.Font = Enum.Font.GothamBold
ToggleESP.TextSize = 16

local ESP_Enabled = false
ToggleESP.MouseButton1Click:Connect(function()
	if Verified then
		ESP_Enabled = not ESP_Enabled
		ToggleESP.Text = "ESP ["..(ESP_Enabled and "ON" or "OFF").."]"
	end
end)

-- Drawing ESP
local function createESP(plr)
	local box = Drawing.new("Square")
	box.Color = Color3.fromRGB(255, 255, 255)
	box.Thickness = 1.5
	box.Transparency = 1
	box.Filled = false

	local healthBar = Drawing.new("Square")
	healthBar.Filled = true
	healthBar.Thickness = 0
	healthBar.Transparency = 1
	healthBar.Color = Color3.fromRGB(0,255,0)

	local function update()
		RunService.RenderStepped:Connect(function()
			if not ESP_Enabled or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or not plr.Character:FindFirstChild("Humanoid") or plr.Character.Humanoid.Health <= 0 then
				box.Visible = false
				healthBar.Visible = false
				return
			end
			local pos, onscreen = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
			if onscreen then
				local scale = 3
				local size = Vector2.new(45, 60)
				local topLeft = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
				box.Size = size
				box.Position = topLeft
				box.Visible = true

				-- Health bar
				local hp = plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth
				healthBar.Size = Vector2.new(4, size.Y * hp)
				healthBar.Position = Vector2.new(topLeft.X - 6, topLeft.Y + (size.Y * (1 - hp)))
				healthBar.Color = Color3.fromRGB(255 - hp*255, hp*255, 0)
				healthBar.Visible = true
			else
				box.Visible = false
				healthBar.Visible = false
			end
		end)
	end
	coroutine.wrap(update)()
end

for _, plr in pairs(Players:GetPlayers()) do
	if plr ~= LocalPlayer then
		createESP(plr)
	end
end

Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		wait(1)
		createESP(plr)
	end)
end)
