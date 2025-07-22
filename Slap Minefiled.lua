local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "SlapMinefieldUI"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 220, 0, 90)
Main.Position = UDim2.new(0.05, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 2
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 0, 0)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

task.spawn(function()
	while true do
		for i = 0, 255, 5 do
			UIStroke.Color = Color3.fromHSV(i / 255, 1, 1)
			Title.TextColor3 = UIStroke.Color
			Credit.TextColor3 = UIStroke.Color
			task.wait()
		end
	end
end)

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.Text = "⚙️"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.AutoButtonColor = true
ToggleBtn.Font = Enum.Font.Gotham
ToggleBtn.TextSize = 20

ToggleBtn.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Text = "🤚 Slap Minefield"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local ToggleScript = Instance.new("TextButton", Main)
ToggleScript.Size = UDim2.new(0, 180, 0, 30)
ToggleScript.Position = UDim2.new(0.5, -90, 0.5, -5)
ToggleScript.Text = "Get Wins"
ToggleScript.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ToggleScript.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleScript.Font = Enum.Font.Gotham
ToggleScript.TextSize = 16

local active = false
ToggleScript.MouseButton1Click:Connect(function()
	active = not active
	if active then
		ToggleScript.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		
		LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(1, 4, 749)
	else
		ToggleScript.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	end
end)

local Credit = Instance.new("TextLabel", Main)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -22)
Credit.Text = "script by - luminaprojects"
Credit.BackgroundTransparency = 1
Credit.TextColor3 = Color3.fromRGB(255, 255, 255)
Credit.Font = Enum.Font.Code
Credit.TextSize = 14
Credit.TextStrokeTransparency = 0.8
