-- ✅ Game Lock: Memory Murder only
if game.PlaceId ~= 9638489687 then
    return warn("🚫 This script only works in Memory Murder.")
end

-- ✅ Key UI by @Luminaprojects
local userKey = "LUMINAKEY_pxs0up8r2bh2j19"
local getKeyURL = "https://get-key-luminakey.vercel.app/"
local mainScript = "https://raw.githubusercontent.com/Luminaxhub/Games/refs/heads/main/Memory%20Murder.lua"

local function createUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LUMINA_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 170)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -85)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundTransparency = 1
    title.Text = "🧠 Murder Memory Key System"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Parent = mainFrame

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.9, 0, 0, 35)
    keyBox.Position = UDim2.new(0.05, 0, 0, 45)
    keyBox.PlaceholderText = "Enter your key here..."
    keyBox.Text = ""
    keyBox.ClearTextOnFocus = false
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 14
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    keyBox.Parent = mainFrame

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 6)
    keyCorner.Parent = keyBox

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0.42, 0, 0, 30)
    getKeyBtn.Position = UDim2.new(0.05, 0, 0, 90)
    getKeyBtn.Text = "🌐 Get Key"
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 14
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard(getKeyURL)
    end)
    getKeyBtn.Parent = mainFrame

    local verifyBtn = Instance.new("TextButton")
    verifyBtn.Size = UDim2.new(0.42, 0, 0, 30)
    verifyBtn.Position = UDim2.new(0.53, 0, 0, 90)
    verifyBtn.Text = "✅ Verify"
    verifyBtn.Font = Enum.Font.GothamBold
    verifyBtn.TextSize = 14
    verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
    verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    verifyBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == userKey then
            mainFrame:TweenPosition(UDim2.new(0.5, -150, 2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.7, true)
            wait(0.7)
            ScreenGui:Destroy()
            loadstring(game:HttpGet(mainScript))()
        else
            keyBox.Text = ""
            keyBox.PlaceholderText = "❌ Invalid key. Try again!"
        end
    end)
    verifyBtn.Parent = mainFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -28, 0, 4)
    closeBtn.Text = "✕"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    closeBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    closeBtn.Parent = mainFrame

    local RGBLabel = Instance.new("TextLabel")
    RGBLabel.Size = UDim2.new(1, 0, 0, 20)
    RGBLabel.Position = UDim2.new(0, 0, 1, -22)
    RGBLabel.BackgroundTransparency = 1
    RGBLabel.Font = Enum.Font.GothamBold
    RGBLabel.TextSize = 12
    RGBLabel.Text = "🔎 Script by - @Luminaprojects"
    RGBLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    RGBLabel.Parent = mainFrame

    coroutine.wrap(function()
        while task.wait() do
            for i = 0, 1, 0.01 do
                local r = math.sin(i * math.pi * 2) * 127 + 128
                local g = math.sin((i + 1/3) * math.pi * 2) * 127 + 128
                local b = math.sin((i + 2/3) * math.pi * 2) * 127 + 128
                RGBLabel.TextColor3 = Color3.fromRGB(r, g, b)
                task.wait(0.03)
            end
        end
    end)()
end

createUI()
