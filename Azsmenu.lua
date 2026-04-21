-- // SERVICES
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- // VARIABLES
local Mouse = Players.LocalPlayer:GetMouse()
local Library = {}
Library.Window = {}

-- // COLORS
local Theme = {
    Primary = Color3.fromRGB(0, 255, 200),
    Secondary = Color3.fromRGB(17, 18, 20),
    Background = Color3.fromRGB(10, 10, 12),
    TextColor = Color3.fromRGB(255, 255, 255),
    Outline = Color3.fromRGB(26, 29, 37)
}

-- // CREATE MAIN WINDOW
local AZSMenu = Instance.new("ScreenGui")
AZSMenu.Name = "AZS_Menu"
AZSMenu.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = AZSMenu
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 600, 0, 450)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Primary
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- // TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
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
TitleText.TextSize = 28

-- // CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "Close"
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.BorderSizePixel = 0
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0, 10)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseBtn

-- // CONTAINER DOS BOTÕES DE JOGOS
local GamesContainer = Instance.new("Frame")
GamesContainer.Name = "Games"
GamesContainer.Parent = MainFrame
GamesContainer.BackgroundTransparency = 1
GamesContainer.Position = UDim2.new(0, 20, 0, 80)
GamesContainer.Size = UDim2.new(0, 560, 0, 80)

local Layout = Instance.new("UIListLayout")
Layout.Parent = GamesContainer
Layout.FillDirection = Enum.FillDirection.Horizontal
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
Layout.Padding = UDim.new(0, 15)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.VerticalAlignment = Enum.VerticalAlignment.Center

-- // FUNÇÃO DE CRIAR BOTÃO DE JOGO
local SelectedGame = nil

local function CreateGameButton(Name, Order)
    local Button = Instance.new("TextButton")
    Button.Name = Name.."_Btn"
    Button.LayoutOrder = Order
    Button.Parent = GamesContainer
    Button.BackgroundColor3 = Theme.Secondary
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 120, 0, 70)
    Button.Font = Enum.Font.GothamBold
    Button.Text = Name
    Button.TextColor3 = Theme.TextColor
    Button.TextSize = 18
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 15)
    BtnCorner.Parent = Button
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Name = "Stroke"
    BtnStroke.Color = Theme.Outline
    BtnStroke.Thickness = 2
    BtnStroke.Parent = Button
    
    return Button
end

-- // CRIANDO OS BOTÕES
local RivalsBtn = CreateGameButton("Rivals", 1)
local ArsenalBtn = CreateGameButton("Arsenal", 2)
local CBloxBtn = CreateGameButton("CounterBlox", 3)
local OtherBtn = CreateGameButton("Outros", 4)

-- // SEÇÃO DE CONFIGS (VAI APARECER QUANDO CLICA)
local ConfigSection = Instance.new("Frame")
ConfigSection.Name = "Configs"
ConfigSection.Parent = MainFrame
ConfigSection.BackgroundColor3 = Theme.Secondary
ConfigSection.BorderSizePixel = 0
ConfigSection.Position = UDim2.new(0, 20, 0, 170)
ConfigSection.Size = UDim2.new(0, 560, 0, 200)
ConfigSection.Visible = false

local ConfigCorner = Instance.new("UICorner")
ConfigCorner.CornerRadius = UDim.new(0, 15)
ConfigCorner.Parent = ConfigSection

local ConfigStroke = Instance.new("UIStroke")
ConfigStroke.Color = Theme.Outline
ConfigStroke.Thickness = 2
ConfigStroke.Parent = ConfigSection

-- // TOGGLES DENTRO DA CONFIG
local AutoLoadToggle = Instance.new("Frame")
AutoLoadToggle.Name = "AutoLoad"
AutoLoadToggle.Parent = ConfigSection
AutoLoadToggle.BackgroundColor3 = Theme.Background
AutoLoadToggle.BorderSizePixel = 0
AutoLoadToggle.Position = UDim2.new(0, 20, 0, 20)
AutoLoadToggle.Size = UDim2.new(0, 200, 0, 50)

local ALCorner = Instance.new("UICorner")
ALCorner.CornerRadius = UDim.new(0, 12)
ALCorner.Parent = AutoLoadToggle

local ALText = Instance.new("TextLabel")
ALText.Parent = AutoLoadToggle
ALText.BackgroundTransparency = 1
ALText.Position = UDim2.new(0, 15, 0, 0)
ALText.Size = UDim2.new(1, -80, 1, 0)
ALText.Text = "Auto Load"
ALText.TextColor3 = Theme.TextColor
ALText.TextSize = 16
ALText.Font = Enum.Font.Gotham

local ALButton = Instance.new("TextButton")
ALButton.Name = "Btn"
ALButton.Parent = AutoLoadToggle
ALButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
ALButton.BorderSizePixel = 0
ALButton.Position = UDim2.new(1, -60, 0, 10)
ALButton.Size = UDim2.new(0, 40, 0, 30)
ALButton.Text = "ON"
ALButton.TextColor3 = Color3.fromRGB(0,0,0)
ALButton.TextSize = 14

local ALBtnCorner = Instance.new("UICorner")
ALBtnCorner.CornerRadius = UDim.new(0, 8)
ALBtnCorner.Parent = ALButton

-- // BOTÃO DE EXECUTAR
local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Name = "Execute"
ExecuteBtn.Parent = MainFrame
ExecuteBtn.BackgroundColor3 = Theme.Primary
ExecuteBtn.BorderSizePixel = 0
ExecuteBtn.Position = UDim2.new(0, 20, 0, 390)
ExecuteBtn.Size = UDim2.new(0, 560, 0, 50)
ExecuteBtn.Text = "▶️ EXECUTAR SCRIPT"
ExecuteBtn.TextColor3 = Color3.fromRGB(0,0,0)
ExecuteBtn.TextSize = 20
ExecuteBtn.Font = Enum.Font.GothamBold

local ExeCorner = Instance.new("UICorner")
ExeCorner.CornerRadius = UDim.new(0, 12)
ExeCorner.Parent = ExecuteBtn

-- ==============================================
-- // SCRIPTS LINKS
-- ==============================================
local Scripts = {
    ["Rivals"] = "https://raw.githubusercontent.com/davimascz2012-gif/Azsmenu/main/Azsmenu.lua",
    
}

-- ==============================================
-- // FUNCTIONS
-- ==============================================
local AutoLoad = true
local function UpdateToggle()
    if AutoLoad then
        ALButton.BackgroundColor3 = Color3.fromRGB(0,255,100)
        ALButton.Text = "ON"
    else
        ALButton.BackgroundColor3 = Color3.fromRGB(255,70,70)
        ALButton.Text = "OFF"
    end
end

local function SelectGame(Button, Name)
    -- Resetar todos
    for _, v in pairs(GamesContainer:GetChildren()) do
        if v:IsA("TextButton") then
            v.Stroke.Color = Theme.Outline
        end
    end
    
    -- Selecionar o atual
    Button.Stroke.Color = Theme.Primary
    SelectedGame = Name
    ConfigSection.Visible = true
    UpdateToggle()
end

-- // EVENTOS
RivalsBtn.MouseButton1Click:Connect(function()
    SelectGame(RivalsBtn, "Rivals")
end)

ArsenalBtn.MouseButton1Click:Connect(function()
    SelectGame(ArsenalBtn, "Arsenal")
end)

CBloxBtn.MouseButton1Click:Connect(function()
    SelectGame(CBloxBtn, "CounterBlox")
end)

ALButton.MouseButton1Click:Connect(function()
    AutoLoad = not AutoLoad
    UpdateToggle()
end)

ExecuteBtn.MouseButton1Click:Connect(function()
    if SelectedGame and Scripts[SelectedGame] then
        loadstring(game:HttpGet(Scripts[SelectedGame]))()
    else
        print("SELECIONE UM JOGO!")
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    AZSMenu:Destroy()
end)

-- ==============================================
-- // 🔥 TECLA F1 PARA ABRIR E FECHAR
-- ==============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F1 then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- // DRAG SYSTEM (PARA MOVER A JANELA)
local Dragging, DragStart, StartPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

print("✅ AZS MENU CARREGADO!")
