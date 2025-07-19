local keySystem = {}

keySystem.UI = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
keySystem.UI.Name = "LUMINAKeyUI"
keySystem.UI.ResetOnSpawn = false

local frame = Instance.new("Frame", keySystem.UI)
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔑 GetKey System"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local keyBox = Instance.new("TextBox", frame)
keyBox.PlaceholderText = "Enter your key here..."
keyBox.Size = UDim2.new(1, -40, 0, 30)
keyBox.Position = UDim2.new(0, 20, 0, 60)
keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 6)

local getKeyButton = Instance.new("TextButton", frame)
getKeyButton.Size = UDim2.new(1, -40, 0, 30)
getKeyButton.Position = UDim2.new(0, 20, 0, 100)
getKeyButton.Text = "🌐 Get Key"
getKeyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 180)
getKeyButton.TextColor3 = Color3.new(1, 1, 1)
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.TextSize = 14
Instance.new("UICorner", getKeyButton).CornerRadius = UDim.new(0, 6)

local checkKeyButton = Instance.new("TextButton", frame)
checkKeyButton.Size = UDim2.new(1, -40, 0, 30)
checkKeyButton.Position = UDim2.new(0, 20, 0, 140)
checkKeyButton.Text = "✅ Verify Key"
checkKeyButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
checkKeyButton.TextColor3 = Color3.new(1, 1, 1)
checkKeyButton.Font = Enum.Font.GothamBold
checkKeyButton.TextSize = 14
Instance.new("UICorner", checkKeyButton).CornerRadius = UDim.new(0, 6)

-- Key Checking Logic
local VALID_KEY = "LUMINAKEY_pxs0up8r2bh2j19"

checkKeyButton.MouseButton1Click:Connect(function()
	local inputKey = keyBox.Text
	if inputKey == VALID_KEY then
		checkKeyButton.Text = "🔓 Access Granted!"
		checkKeyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		wait(1)
		keySystem.UI:Destroy()
		-- EXECUTE MAIN SCRIPT
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminaxhub/Games/refs/heads/main/1%2B%20punch%20every%20second.lua"))()
	else
		checkKeyButton.Text = "❌ Invalid Key!"
		checkKeyButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		wait(1.5)
		checkKeyButton.Text = "✅ Verify Key"
		checkKeyButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
	end
end)

getKeyButton.MouseButton1Click:Connect(function()
	setclipboard("https://get-key-luminakey.vercel.app/")
	getKeyButton.Text = "📋 Link Copied!"
	wait(1.5)
	getKeyButton.Text = "🌐 Get Key"
end)
