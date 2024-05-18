-- Aim Assist Feature
local aimAssistEnabled = false

-- Noclip Feature
local noclipEnabled = false

-- Player ESP Feature
local playerESPEnabled = false
local playerOutlines = {} -- Store outline GUIs for each player

-- Function to create outline GUI for a player
local function createPlayerOutline(player)
    local outline = Instance.new("Frame")
    outline.Size = UDim2.new(0, 50, 0, 50)
    outline.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red outline color
    outline.BorderSizePixel = 2
    outline.Parent = game.Players.LocalPlayer.PlayerGui
    playerOutlines[player] = outline
end

-- Function to update outline position for a player
local function updatePlayerOutline(player, position)
    local outline = playerOutlines[player]
    if outline then
        local screenPosition, visible = game:GetService("Workspace"):CurrentCamera():WorldToViewportPoint(position)
        if visible then
            outline.Position = UDim2.new(0, screenPosition.X, 0, screenPosition.Y)
            outline.Visible = true
        else
            outline.Visible = false
        end
    end
end

-- Function to remove outline GUI for a player
local function removePlayerOutline(player)
    local outline = playerOutlines[player]
    if outline then
        outline:Destroy()
        playerOutlines[player] = nil
    end
end

-- Function to toggle Aim Assist
local function toggleAimAssist()
    aimAssistEnabled = not aimAssistEnabled
    aimAssistToggle.Text = aimAssistEnabled and "On" or "Off"
end

-- Function to toggle Noclip
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    noclipToggle.Text = noclipEnabled and "On" or "Off"
end

-- Function to toggle Player ESP
local function togglePlayerESP()
    playerESPEnabled = not playerESPEnabled
    if playerESPEnabled then
        -- Enable Player ESP
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                createPlayerOutline(player)
            end
        end
    else
        -- Disable Player ESP
        for player, _ in pairs(playerOutlines) do
            removePlayerOutline(player)
        end
    end
end

-- Create Screen GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer.PlayerGui

-- Create Frame for Options
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.25, 0, 0.5, 0)
frame.Position = UDim2.new(0.75, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
frame.BorderSizePixel = 0
frame.Active = true -- Allows dragging
frame.Draggable = true -- Enables dragging
frame.Visible = false -- Start with menu hidden
frame.Parent = gui

-- Create Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Nexus Scripts"
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.Parent = frame

-- Create Labels and Toggle Buttons for Options
local aimAssistLabel = Instance.new("TextLabel")
aimAssistLabel.Text = "Aim Assist"
aimAssistLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
aimAssistLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
aimAssistLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
aimAssistLabel.BackgroundTransparency = 1
aimAssistLabel.Font = Enum.Font.Gotham
aimAssistLabel.TextSize = 16
aimAssistLabel.Parent = frame

local aimAssistToggle = Instance.new("TextButton")
aimAssistToggle.Text = "Off"
aimAssistToggle.Size = UDim2.new(0.2, 0, 0.1, 0)
aimAssistToggle.Position = UDim2.new(0.75, 0, 0.15, 0)
aimAssistToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
aimAssistToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
aimAssistToggle.Font = Enum.Font.Gotham
aimAssistToggle.TextSize = 16
aimAssistToggle.Parent = frame

local noclipLabel = Instance.new("TextLabel")
noclipLabel.Text = "Noclip"
noclipLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
noclipLabel.Position = UDim2.new(0.1, 0, 0.3, 0)
noclipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipLabel.BackgroundTransparency = 1
noclipLabel.Font = Enum.Font.Gotham
noclipLabel.TextSize = 16
noclipLabel.Parent = frame

local noclipToggle = Instance.new("TextButton")
noclipToggle.Text = "Off"
noclipToggle.Size = UDim2.new(0.2, 0, 0.1, 0)
noclipToggle.Position = UDim2.new(0.75, 0, 0.3, 0)
noclipToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
noclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipToggle.Font = Enum.Font.Gotham
noclipToggle.TextSize = 16
noclipToggle.Parent = frame

local playerESPLabel = Instance.new("TextLabel")
playerESPLabel.Text = "Player ESP"
playerESPLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
playerESPLabel.Position = UDim2.new(0.1, 0, 0.45, 0)
playerESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerESPLabel.BackgroundTransparency = 1
playerESPLabel.Font = Enum.Font.Gotham
playerESPLabel.TextSize = 16
playerESPLabel.Parent = frame

local playerESPToggle = Instance.new("TextButton")
playerESPToggle.Text = "Off"
playerESPToggle.Size = UDim2.new(0.2, 0, 0.1, 0)
playerESPToggle.Position = UDim2.new(0.75, 0, 0.45, 0)
playerESPToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
playerESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
playerESPToggle.Font = Enum.Font.Gotham
playerESPToggle.TextSize = 16
playerESPToggle.Parent = frame

-- Connect Toggle Buttons to Functions
aimAssistToggle.MouseButton1Click:Connect(toggleAimAssist)
noclipToggle.MouseButton1Click:Connect(toggleNoclip)
playerESPToggle.MouseButton1Click:Connect(togglePlayerESP)

-- Function to toggle GUI visibility when Insert key is pressed
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        frame.Visible = not frame.Visible
    end
end)

-- Function to handle player added event
game.Players.PlayerAdded:Connect(function(player)
    if playerESPEnabled and player ~= game.Players.LocalPlayer then
        createPlayerOutline(player)
    end
end)

-- Function to handle player removing event
game.Players.PlayerRemoving:Connect(function(player)
    removePlayerOutline(player)
end)

-- Function to update player outlines every frame
game:GetService("RunService").RenderStepped:Connect(function()
    if playerESPEnabled then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                updatePlayerOutline(player, player.Character and player.Character.PrimaryPart.Position or Vector3.new(0, -10000, 0)) -- Use PrimaryPart position if available, otherwise use a position far below the map
            end
        end
    end
end)
