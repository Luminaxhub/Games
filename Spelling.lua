local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

-- Toggle variable
local autoSpellEnabled = false

-- UI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "AutoSpellerUI"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 60)
frame.Position = UDim2.new(0, 20, 0.5, -30)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🐝 Auto Speller"
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Parent = frame

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0, 140, 0, 25)
toggle.Position = UDim2.new(0.5, -70, 0, 30)
toggle.Text = "Status: OFF"
toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 13
toggle.AutoButtonColor = true

local toggleCorner = Instance.new("UICorner", toggle)
toggleCorner.CornerRadius = UDim.new(0, 6)

toggle.MouseButton1Click:Connect(function()
	autoSpellEnabled = not autoSpellEnabled
	toggle.Text = autoSpellEnabled and "Status: ON ✅" or "Status: OFF"
	toggle.BackgroundColor3 = autoSpellEnabled and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(60, 60, 60)
end)

-- RGB credit (opsional)
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 15)
credit.Position = UDim2.new(0, 0, 1, -15)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.Gotham
credit.TextSize = 12
credit.Text = "Script by - @Luminaprojects"
credit.TextColor3 = Color3.new(1, 1, 1)
credit.Parent = frame

local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 1) % 360
	credit.TextColor3 = Color3.fromHSV(hue / 360, 1, 1)
end)

-- Ambil GUI Keyboard
local function getKeyboardGui()
	for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
		if gui:IsA("TextButton") or gui:IsA("ImageButton") then
			if gui.Name == "Q" or gui.Name == "A" then
				return gui.Parent
			end
		end
	end
	return nil
end

-- Fungsi ngetik huruf + tekan Submit
local function typeWord(word)
	local keyboard = getKeyboardGui()
	if not keyboard then
		warn("Keyboard not found")
		return
	end

	for i = 1, #word do
		local letter = word:sub(i, i):upper()
		local btn = keyboard:FindFirstChild(letter, true)
		if btn and (btn:IsA("TextButton") or btn:IsA("ImageButton")) then
			pcall(function() btn:Activate() end)
		end
		task.wait(0.25)
	end

	-- Cari tombol submit
	for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
		if gui:IsA("TextButton") and gui.Name:lower():find("submit") then
			task.wait(0.3)
			pcall(function() gui:Activate() end)
			break
		end
	end
end

-- Saat suara muncul → Ambil kata → Ketik
game.DescendantAdded:Connect(function(obj)
	if obj:IsA("Sound") and autoSpellEnabled then
		task.defer(function()
			local soundId = obj.SoundId:match("%d+")
			if soundId then
				local success, info = pcall(function()
					return MarketplaceService:GetProductInfo(tonumber(soundId))
				end)

				if success and info and info.Name then
					local word = info.Name
					word = word:match("^(.-)%s*%(%d+%)$") or word
					word = word:lower():gsub("%s+", "") -- bersih
					typeWord(word)
				end
			end
		end)
	end
end)
