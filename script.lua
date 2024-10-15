-- Ensure compatibility with Delta Executor by using getgenv() for global access
getgenv().DexScript = {}

-- Themes, Command Hub, and Modular Design
local service = setmetatable({}, {
    __index = function(self, name)
        local serv = game:GetService(name)
        self[name] = serv
        return serv
    end
})

local function applyTheme(theme)
    if theme == "dark" then
        return {background = Color3.fromRGB(30, 30, 30), text = Color3.fromRGB(255, 255, 255)}
    elseif theme == "light" then
        return {background = Color3.fromRGB(255, 255, 255), text = Color3.fromRGB(0, 0, 0)}
    else
        return {background = Color3.fromRGB(50, 50, 50), text = Color3.fromRGB(200, 200, 200)} -- Custom
    end
end

local themeColors = applyTheme("dark") -- Default theme

-- UI creation compatible with Delta Executor
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(0.9, 0, 0.9, 0)
frame.BackgroundColor3 = themeColors.background
frame.Parent = screenGui

local label = Instance.new("TextLabel")
label.Text = "Delta Exploit Hub"
label.TextColor3 = themeColors.text
label.Position = UDim2.new(0.5, -50, 0.1, 0)
label.Size = UDim2.new(0.2, 0, 0.1, 0)
label.Parent = frame

-- Command Hub
local function createCommandHub()
    local commandFrame = Instance.new("Frame")
    commandFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
    commandFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
    commandFrame.BackgroundColor3 = themeColors.background
    commandFrame.Parent = frame

    local teleportButton = Instance.new("TextButton")
    teleportButton.Text = "Teleport"
    teleportButton.Size = UDim2.new(1, 0, 0.2, 0)
    teleportButton.TextColor3 = themeColors.text
    teleportButton.MouseButton1Click:Connect(function()
        local plr = game.Players.LocalPlayer
        plr.Character:SetPrimaryPartCFrame(CFrame.new(0, 50, 0))
    end)
    teleportButton.Parent = commandFrame

    local godModeButton = Instance.new("TextButton")
    godModeButton.Text = "God Mode"
    godModeButton.Size = UDim2.new(1, 0, 0.2, 0)
    godModeButton.TextColor3 = themeColors.text
    godModeButton.Position = UDim2.new(0, 0, 0.2, 0)
    godModeButton.MouseButton1Click:Connect(function()
        local plr = game.Players.LocalPlayer
        plr.Character.Humanoid.MaxHealth = math.huge
        plr.Character.Humanoid.Health = math.huge
    end)
    godModeButton.Parent = commandFrame
end

createCommandHub()

-- FilteringEnabled detection (for server/client exploits)
local feLabel = Instance.new("TextLabel")
feLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
feLabel.Position = UDim2.new(0.7, 0, 0.1, 0)
feLabel.TextColor3 = themeColors.text
feLabel.Text = "FE: " .. (game:GetService("Workspace").FilteringEnabled and "Enabled" or "Disabled")
feLabel.Parent = frame 
end
