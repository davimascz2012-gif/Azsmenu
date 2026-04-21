-- // SERVICES
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- // VARIABLES
local Mouse = Players.LocalPlayer:GetMouse()

-- // THEME AZS MENU
local Theme = {
    Primary = Color3.fromRGB(0, 255, 200),
    Secondary = Color3.fromRGB(17, 18, 20),
    Background = Color3.fromRGB(10, 10, 12),
    TextColor = Color3.fromRGB(255, 255, 255),
    Outline = Color3.fromRGB(26, 29, 37)
}

-- // CREATE MAIN GUI
local AZSLoader = Instance.new("ScreenGui")
AZSLoader.Name = "AZS_Menu"
AZSLoader.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Parent = AZSLoader
frame.BackgroundColor3 = Theme.Background
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.15, 0, 0.15, 0)
frame.Size = UDim2.new(0, 550, 0, 420)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = frame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Primary
MainStroke.Thickness = 2
MainStroke.Parent = frame

-- // TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = frame
TitleBar.BackgroundColor3 = Theme.Secondary
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 60)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Name = "Title"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, -20, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "⚡ AZS MENU ⚡"
TitleText.TextColor3 = Theme.Primary
TitleText.TextSize = 26

-- // CLOSE BUTTON
local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Parent = TitleBar
closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeButton.BorderSizePixel = 0
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -50, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255,255,255)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = closeButton

-- // BOTAO RIVALS
local rivals = Instance.new("Frame")
rivals.Name = "Rivals"
rivals.Parent = frame
rivals.BackgroundColor3 = Theme.Secondary
rivals.BackgroundTransparency = 0.9
rivals.BorderColor3 = Color3.fromRGB(0, 0, 0)
rivals.BorderSizePixel = 0
rivals.Position = UDim2.new(0.05, 0, 0.20, 0)
rivals.Size = UDim2.new(0, 440, 0, 70)

local rivalsStroke = Instance.new("UIStroke")
rivalsStroke.Name = "UIStroke"
rivalsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
rivalsStroke.Color = Theme.Outline
rivalsStroke.Thickness = 2
rivalsStroke.Parent = rivals

local uICorner7 = Instance.new("UICorner")
uICorner7.Name = "UICorner"
uICorner7.CornerRadius = UDim.new(0, 18)
uICorner7.Parent = rivals

local textLabel11 = Instance.new("TextLabel")
textLabel11.Name = "TextLabel"
textLabel11.Parent = rivals
textLabel11.BackgroundTransparency = 1
textLabel11.Size = UDim2.new(1, -20, 1, 0)
textLabel11.Position = UDim2.new(0, 10, 0, 0)
textLabel11.Font = Enum.Font.GothamBold
textLabel11.Text = "🔫 RIVALS"
textLabel11.TextColor3 = Theme.TextColor
textLabel11.TextSize = 24

-- // PANEL DE AVISO
local blackidk = Instance.new("Frame")
blackidk.Name = "blackidk"
blackidk.Parent = frame
blackidk.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackidk.BackgroundTransparency = 0.3
blackidk.BorderSizePixel = 0
blackidk.Size = UDim2.new(1, 0, 1, 0)
blackidk.ZIndex = 8
blackidk.Visible = false

local uICorner111 = Instance.new("UICorner")
uICorner111.Name = "UICorner"
uICorner111.CornerRadius = UDim.new(0, 20)
uICorner111.Parent = blackidk

local confipanel = Instance.new("Frame")
confipanel.Name = "confipanel"
confipanel.Parent = frame
confipanel.BackgroundColor3 = Theme.Secondary
confipanel.BackgroundTransparency = 0
confipanel.BorderColor3 = Color3.fromRGB(0, 0, 0)
confipanel.BorderSizePixel = 0
confipanel.Position = UDim2.new(0.5, -200, 0.5, -75)
confipanel.Size = UDim2.new(0, 400, 0, 150)
confipanel.Visible = false
confipanel.ZIndex = 10

local confirmCorner = Instance.new("UICorner")
confirmCorner.CornerRadius = UDim.new(0, 12)
confirmCorner.Parent = confipanel

local confirmStroke = Instance.new("UIStroke")
confirmStroke.Color = Theme.Outline
confirmStroke.Thickness = 2
confirmStroke.Parent = confipanel

local confirmText = Instance.new("TextLabel")
confirmText.Name = "ConfirmText"
confirmText.Parent = confipanel
confirmText.BackgroundTransparency = 1
confirmText.Size = UDim2.new(1, -20, 0, 70)
confirmText.Position = UDim2.new(0, 10, 0, 10)
confirmText.Font = Enum.Font.Gotham
confirmText.Text = "WARNING: This script may not be undetected! Running it could result in a ban.\nDo you still want to select it?"
confirmText.TextColor3 = Theme.TextColor
confirmText.TextSize = 16
confirmText.TextWrapped = true
confirmText.TextXAlignment = Enum.TextXAlignment.Center

local confirmYes = Instance.new("TextButton")
confirmYes.Name = "ConfirmYes"
confirmYes.Parent = confipanel
confirmYes.BackgroundColor3 = Theme.Primary
confirmYes.Size = UDim2.new(0, 100, 0, 35)
confirmYes.Position = UDim2.new(0.5, -110, 1, -45)
confirmYes.Font = Enum.Font.GothamBold
confirmYes.Text = "Yes"
confirmYes.TextColor3 = Color3.fromRGB(0,0,0)
confirmYes.TextSize = 16
local yesCorner = Instance.new("UICorner")
yesCorner.CornerRadius = UDim.new(0, 8)
yesCorner.Parent = confirmYes

local confirmNo = Instance.new("TextButton")
confirmNo.Name = "ConfirmNo"
confirmNo.Parent = confipanel
confirmNo.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
confirmNo.Size = UDim2.new(0, 100, 0, 35)
confirmNo.Position = UDim2.new(0.5, 10, 1, -45)
confirmNo.Font = Enum.Font.GothamBold
confirmNo.Text = "No"
confirmNo.TextColor3 = Theme.TextColor
confirmNo.TextSize = 16
local noCorner = Instance.new("UICorner")
noCorner.CornerRadius = UDim.new(0, 8)
noCorner.Parent = confirmNo

-- // CONTAINER DE OPCOES
local rivalsToggleContainer = Instance.new("Frame")
rivalsToggleContainer.Name = "RivalsToggleContainer"
rivalsToggleContainer.Parent = frame
rivalsToggleContainer.BackgroundColor3 = Theme.Secondary
rivalsToggleContainer.BackgroundTransparency = 0.9
rivalsToggleContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
rivalsToggleContainer.BorderSizePixel = 0
rivalsToggleContainer.Position = UDim2.new(0.05, 0, 0.42, 0)
rivalsToggleContainer.Size = UDim2.new(0, 440, 0, 70)
rivalsToggleContainer.Visible = false

local containerStroke = Instance.new("UIStroke")
containerStroke.Parent = rivalsToggleContainer
containerStroke.Color = Theme.Outline
containerStroke.Thickness = 2
containerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local uICornerContainer = Instance.new("UICorner")
uICornerContainer.CornerRadius = UDim.new(0, 18)
uICornerContainer.Parent = rivalsToggleContainer

-- // AUTOLOAD
local autoloadToggle = Instance.new("Frame")
autoloadToggle.Name = "AutoloadToggle"
autoloadToggle.Parent = rivalsToggleContainer
autoloadToggle.BackgroundColor3 = Theme.Background
autoloadToggle.BackgroundTransparency = 0.9
autoloadToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
autoloadToggle.BorderSizePixel = 0
autoloadToggle.Position = UDim2.new(0.05, 0, 0.15, 0)
autoloadToggle.Size = UDim2.new(0, 180, 0, 45)

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Parent = autoloadToggle
toggleStroke.Color = Theme.Outline
toggleStroke.Thickness = 2
toggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local uICornerToggle = Instance.new("UICorner")
uICornerToggle.CornerRadius = UDim.new(0, 15)
uICornerToggle.Parent = autoloadToggle

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Name = "ToggleLabel"
toggleLabel.Parent = autoloadToggle
toggleLabel.BackgroundTransparency = 1
toggleLabel.Size = UDim2.new(0, 100, 1, 0)
toggleLabel.Position = UDim2.new(0.05, 0, 0, 0)
toggleLabel.Font = Enum.Font.Gotham
toggleLabel.Text = "Auto Load:"
toggleLabel.TextColor3 = Theme.TextColor
toggleLabel.TextSize = 16
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = autoloadToggle
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
toggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.BorderSizePixel = 0
toggleButton.Position = UDim2.new(0.65, 0, 0.15, 0)
toggleButton.Size = UDim2.new(0, 50, 0, 30)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "ON"
toggleButton.TextColor3 = Color3.fromRGB(0,0,0)
toggleButton.TextSize = 14

local uICornerToggleBtn = Instance.new("UICorner")
uICornerToggleBtn.CornerRadius = UDim.new(0, 10)
uICornerToggleBtn.Parent = toggleButton

-- // SILENTLOAD
local silentloadToggle = Instance.new("Frame")
silentloadToggle.Name = "SilentloadToggle"
silentloadToggle.Parent = rivalsToggleContainer
silentloadToggle.BackgroundColor3 = Theme.Background
silentloadToggle.BackgroundTransparency = 0.9
silentloadToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
silentloadToggle.BorderSizePixel = 0
silentloadToggle.Position = UDim2.new(0.55, 0, 0.15, 0)
silentloadToggle.Size = UDim2.new(0, 180, 0, 45)

local silentloadStroke = Instance.new("UIStroke")
silentloadStroke.Parent = silentloadToggle
silentloadStroke.Color = Theme.Outline
silentloadStroke.Thickness = 2
silentloadStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local uICornerSilentload = Instance.new("UICorner")
uICornerSilentload.CornerRadius = UDim.new(0, 15)
uICornerSilentload.Parent = silentloadToggle

local silentloadLabel = Instance.new("TextLabel")
silentloadLabel.Name = "SilentloadLabel"
silentloadLabel.Parent = silentloadToggle
silentloadLabel.BackgroundTransparency = 1
silentloadLabel.Size = UDim2.new(0, 110, 1, 0)
silentloadLabel.Position = UDim2.new(0.05, 0, 0, 0)
silentloadLabel.Font = Enum.Font.Gotham
silentloadLabel.Text = "Silent Load:"
silentloadLabel.TextColor3 = Theme.TextColor
silentloadLabel.TextSize = 16
silentloadLabel.TextXAlignment = Enum.TextXAlignment.Left

local silentloadButton = Instance.new("TextButton")
silentloadButton.Name = "SilentloadButton"
silentloadButton.Parent = silentloadToggle
silentloadButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
silentloadButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
silentloadButton.BorderSizePixel = 0
silentloadButton.Position = UDim2.new(0.65, 0, 0.15, 0)
silentloadButton.Size = UDim2.new(0, 50, 0, 30)
silentloadButton.Font = Enum.Font.GothamBold
silentloadButton.Text = "OFF"
silentloadButton.TextColor3 = Color3.fromRGB(255,255,255)
silentloadButton.TextSize = 14

local uICornerSilentloadBtn = Instance.new("UICorner")
uICornerSilentloadBtn.CornerRadius = UDim.new(0, 10)
uICornerSilentloadBtn.Parent = silentloadButton

-- // BOTAO CARREGAR
local loadbtn = Instance.new("TextButton")
loadbtn.Name = "LoadBtn"
loadbtn.Parent = frame
loadbtn.BackgroundColor3 = Theme.Primary
loadbtn.BorderSizePixel = 0
loadbtn.Position = UDim2.new(0.05, 0, 0.65, 0)
loadbtn.Size = UDim2.new(0, 440, 0, 55)
loadbtn.Font = Enum.Font.GothamBold
loadbtn.Text = "▶️ EXECUTAR SCRIPT"
loadbtn.TextColor3 = Color3.fromRGB(0,0,0)
loadbtn.TextSize = 20

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 12)
LoadCorner.Parent = loadbtn

-- // TEXTO SELECAO
local textLabel6 = Instance.new("Text
    
