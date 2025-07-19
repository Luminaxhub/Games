if game.PlaceId ~= 96384896875593 then
	return warn("Script ini hanya untuk Memory Murder!")
end

-- UI Setup
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI Instance
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "LuminakeyUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 370, 0, 180)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true

-- UICorner
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🔐 Key system"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Input
local Input = Instance.new("TextBox", Frame)
Input.PlaceholderText = "Enter your key..."
Input.Size = UDim2.new(0.85, 0, 0, 35)
Input.Position = UDim2.new(0.075, 0, 0.45, 0)
Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.Font = Enum.Font.Gotham
Input.TextSize = 16
Input.ClearTextOnFocus = false
Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 6)

-- Button
local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0.85, 0, 0, 35)
Button.Position = UDim2.new(0.075, 0, 0.75, 0)
Button.Text = "✅ Verify"
Button.Font = Enum.Font.GothamBold
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextSize = 16
Button.BackgroundColor3 = Color3.fromRGB(40, 130, 255)
Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

-- GetKey Text
local GetKeyText = Instance.new("TextLabel", Frame)
GetKeyText.Text = "🔗 Get Key: https://get-key-luminakey.vercel.app/"
GetKeyText.Position = UDim2.new(0.05, 0, 0.88, 0)
GetKeyText.Size = UDim2.new(0.9, 0, 0, 20)
GetKeyText.BackgroundTransparency = 1
GetKeyText.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyText.Font = Enum.Font.Gotham
GetKeyText.TextScaled = true
GetKeyText.TextWrapped = true

-- Animation (tween masuk)
TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play()

-- KEY
local ValidKey = "LUMINAKEY_pxs0up8r2bh2j19"

Button.MouseButton1Click:Connect(function()
	if Input.Text == ValidKey then
		Button.Text = "✅ Verified!"
		wait(0.5)
		ScreenGui:Destroy()
		-- Load main script after verify
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminaxhub/Games/refs/heads/main/Memory%20Murder.lua"))()
	else
		Button.Text = "❌ Invalid Key!"
		wait(1)
		Button.Text = "✅ Verify"
	end
end)
