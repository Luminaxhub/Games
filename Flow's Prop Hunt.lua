--// 🔎 Flow's Prop Hunt UI with GETKEY System
--// Script by - @Luminaprojects

-- USER CONFIG
local GETKEY_URL = "https://get-key-luminakey.vercel.app/"
local VALID_KEY = "LUMINAKEY_pxs0up8r2bh2j19"

-- UI LIBRARY
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowPropHuntUI"
ScreenGui.ResetOnSpawn = false

-- DRAG FUNCTION
local function makeDraggable(frame)
	local dragging, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- UI FRAME
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Name = "MainFrame"
makeDraggable(MainFrame)

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🔎 Flow's Prop Hunt"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Featured Text
local Featured = Instance.new("TextLabel", MainFrame)
Featured.Position = UDim2.new(0, 0, 0, 28)
Featured.Size = UDim2.new(1, 0, 0, 20)
Featured.BackgroundTransparency = 1
Featured.Text = "Featured ⚙️"
Featured.TextColor3 = Color3.fromRGB(180, 180, 180)
Featured.Font = Enum.Font.SourceSans
Featured.TextSize = 16

-- KEY INPUT BOX
local KeyBox = Instance.new("TextBox", MainFrame)
KeyBox.PlaceholderText = "Enter Key Here"
KeyBox.Text = ""
KeyBox.Position = UDim2.new(0.05, 0, 0, 55)
KeyBox.Size = UDim2.new(0.9, 0, 0, 30)
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Font = Enum.Font.SourceSans
KeyBox.TextSize = 16

-- VERIFY BUTTON
local VerifyBtn = Instance.new("TextButton", MainFrame)
VerifyBtn.Text = "✅ Verify Key"
VerifyBtn.Position = UDim2.new(0.05, 0, 0, 95)
VerifyBtn.Size = UDim2.new(0.9, 0, 0, 30)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
VerifyBtn.TextColor3 = Color3.new(1, 1, 1)
VerifyBtn.Font = Enum.Font.SourceSansBold
VerifyBtn.TextSize = 16

-- Credit Label (RGB)
local Credit = Instance.new("TextLabel", MainFrame)
Credit.Text = "Script by - @Luminaprojects"
Credit.Position = UDim2.new(0, 0, 1, -25)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.SourceSans
Credit.TextSize = 15

-- RGB Animation
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local hue = i
			local color = Color3.fromHSV(hue, 1, 1)
			Credit.TextColor3 = color
			wait(0.02)
		end
	end
end)

-- VERIFY LOGIC
VerifyBtn.MouseButton1Click:Connect(function()
	if KeyBox.Text == VALID_KEY then
		VerifyBtn.Text = "✅ Verified!"
		wait(1)
		ScreenGui:Destroy()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminaxhub/Games/refs/heads/main/folder.lua"))()
	else
		VerifyBtn.Text = "❌ Invalid Key"
		wait(1)
		VerifyBtn.Text = "✅ Verify Key"
	end
end)
