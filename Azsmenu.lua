local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Config = {
    CameraAimbotEnabled = false,
    SilentAimEnabled = false,
    AimKey = Enum.UserInputType.MouseButton2,
    SilentHitChance = 100,
    PredictionEnabled = true,
    PredictionAmount = 0.13,
    TargetPart = "Head",
    Smoothness = 0.25,
    FOVEnabled = true,
    FOVRadius = 150,
    FOVColor = Color3.fromRGB(0, 255, 200),
    ESPEnabled = true,
    ShowBox = true,
    ShowName = true,
    ShowDistance = true,
    ShowTracers = true,
    ShowHealthBar = true,
    ShowSkeleton = true,
    ShowSnaplines = true,
    ShowWallhack = true,
    TeamCheck = true,
    BoxColor = Color3.fromRGB(255, 50, 50),
    TextColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(255, 100, 100),
    SkeletonColor = Color3.fromRGB(0, 255, 255),
    SnaplinesColor = Color3.fromRGB(255, 200, 0),
    WallhackFillColor = Color3.fromRGB(180, 0, 255),
    WallhackOutlineColor = Color3.fromRGB(255, 255, 255),
    WallhackFillTransparency = 0.6,
    WallhackOutlineTransparency = 0,
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Transparency = 0.75
FOVCircle.NumSides = 100
FOVCircle.Color = Config.FOVColor
FOVCircle.Visible = false

local ESPCache = {}

local function CreateESP(player)
    if ESPCache[player] or player == LocalPlayer then return end
    local d = {}
    d.Box = Drawing.new("Square"); d.Box.Thickness = 2; d.Box.Filled = false; d.Box.Color = Config.BoxColor; d.Box.Transparency = 1; d.Box.Visible = false
    d.Text = Drawing.new("Text"); d.Text.Size = 14; d.Text.Color = Config.TextColor; d.Text.Outline = true; d.Text.Center = true; d.Text.Font = 2; d.Text.Visible = false
    d.Tracer = Drawing.new("Line"); d.Tracer.Thickness = 1.5; d.Tracer.Color = Config.TracerColor; d.Tracer.Transparency = 0.8; d.Tracer.Visible = false
    d.HealthBG = Drawing.new("Square"); d.HealthBG.Thickness = 1; d.HealthBG.Filled = true; d.HealthBG.Color = Color3.fromRGB(30,30,30); d.HealthBG.Transparency = 0.9; d.HealthBG.Visible = false
    d.HealthBar = Drawing.new("Square"); d.HealthBar.Thickness = 1; d.HealthBar.Filled = true; d.HealthBar.Transparency = 1; d.HealthBar.Visible = false
    d.Skeleton = {}
    local bones = {{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
    for _, p in ipairs(bones) do local line = Drawing.new("Line"); line.Thickness = 1.5; line.Color = Config.SkeletonColor; line.Transparency = 0.9; line.Visible = false; table.insert(d.Skeleton, {From = p[1], To = p[2], Line = line}) end
    d.Snapline = Drawing.new("Line"); d.Snapline.Thickness = 1.5; d.Snapline.Color = Config.SnaplinesColor; d.Snapline.Transparency = 0.8; d.Snapline.Visible = false
    d.Wallhack = Instance.new("Highlight")
    d.Wallhack.FillColor = Config.WallhackFillColor
    d.Wallhack.OutlineColor = Config.WallhackOutlineColor
    d.Wallhack.FillTransparency = Config.WallhackFillTransparency
    d.Wallhack.OutlineTransparency = Config.WallhackOutlineTransparency
    d.Wallhack.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    d.Wallhack.Enabled = false
    ESPCache[player] = d
end

local function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if not ESPCache[player] then CreateESP(player) end
        local data = ESPCache[player]
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
            local hum = player.Character.Humanoid
            local root = player.Character.HumanoidRootPart
            local pos, vis = Camera:WorldToViewportPoint(root.Position)
            local isTeammate = LocalPlayer.Team == player.Team
            if Config.ESPEnabled and vis and not isTeammate then
                if Config.ShowBox then local vec = Camera:WorldToViewportPoint(root.Position + Vector3.new(0,2.5,0)); data.Box.Size = Vector2.new(30, 50); data.Box.Position = Vector2.new(vec.X - 15, vec.Y - 25); data.Box.Visible = true end
                if Config.ShowName then data.Text.Text = player.Name .. " ["..math.floor((root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude).."m]"; data.Text.Position = Vector2.new(data.Box.Position.X + 15, data.Box.Position.Y - 20); data.Text.Visible = true end
                if Config.ShowTracers then data.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y); data.Tracer.To = Vector2.new(pos.X, pos.Y); data.Tracer.Visible = true end
                data.Wallhack.Enabled = Config.ShowWallhack
                data.Wallhack.Adornee = root.Parent
            else
                data.Box.Visible = false; data.Text.Visible = false; data.Tracer.Visible = false; data.Wallhack.Enabled = false
            end
        else
            if data then data.Box.Visible = false; data.Text.Visible = false; data.Tracer.Visible = false; data.Wallhack.Enabled = false end
        end
    end
end

local function GetClosestWithPrediction()
    local closestDistance = math.huge
    local closestPlayer = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Config.TargetPart) then
            local rootPart = player.Character.PrimaryPart
            local vel = rootPart.Velocity * Config.PredictionAmount
            local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position + vel)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)).Magnitude
                if dist < closestDistance and dist < Config.FOVRadius then
                    closestDistance = dist
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer
end

local oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FindPartOnRay" or method == "Raycast" then
        if Config.SilentAimEnabled and math.random(1,100) <= Config.SilentHitChance then
            local target = GetClosestWithPrediction()
            if target and target.Character and target.Character:FindFirstChild(Config.TargetPart) then
                return target.Character[Config.TargetPart]
            end
        end
    end
    return oldNamecall(self, ...)
end))

local Menu = {Open = true, Dragging = false, Position = Vector2.new(100, 80)}
local Drawings = {}

local function AddToggle(name, text, yPos)
    Drawings[name.."Text"] = Drawing.new("Text")
    Drawings[name.."Text"].Text = text
    Drawings[name.."Text"].Size = 16
    Drawings[name.."Text"].Color = Color3.fromRGB(220, 220, 220)
    Drawings[name.."Text"].Position = Menu.Position + Vector2.new(25, yPos)
    Drawings[name.."Button"] = Drawing.new("Square")
    Drawings[name.."Button"].Size = Vector2.new(26, 26)
    Drawings[name.."Button"].Position = Menu.Position + Vector2.new(290, yPos - 3)
    Drawings[name.."Button"].Color = Color3.fromRGB(40, 40, 45)
    Drawings[name.."Button"].Transparency = 0.9
    Drawings[name.."Button"].Filled = true
    Drawings[name.."Inner"] = Drawing.new("Square")
    Drawings[name.."Inner"].Size = Vector2.new(18, 18)
    Drawings[name.."Inner"].Position = Menu.Position + Vector2.new(294, yPos + 1)
end

local function CreateMenuElements()
    Drawings.Background = Drawing.new("Square")
    Drawings.Background.Size = Vector2.new(360, 580)
    Drawings.Background.Position = Menu.Position
    Drawings.Background.Color = Color3.fromRGB(20, 20, 25)
    Drawings.Background.Transparency = 0.92
    Drawings.Background.Filled = true
    Drawings.Border = Drawing.new("Square")
    Drawings.Border.Size = Vector2.new(362, 582)
    Drawings.Border.Position = Menu.Position - Vector2.new(1,1)
    Drawings.Border.Color = Color3.fromRGB(0, 255, 200)
    Drawings.Border.Thickness = 2
    Drawings.Border.Filled = false
    Drawings.TitleBG = Drawing.new("Square")
    Drawings.TitleBG.Size = Vector2.new(360, 50)
    Drawings.TitleBG.Position = Menu.Position
    Drawings.TitleBG.Color = Color3.fromRGB(15, 15, 20)
    Drawings.TitleBG.Transparency = 0.8
    Drawings.TitleBG.Filled = true
    Drawings.Title = Drawing.new("Text")
    Drawings.Title.Text = "⚡ AZS MENU ⚡"
    Drawings.Title.Size = 22
    Drawings.Title.Color = Color3.fromRGB(0, 255, 200)
    Drawings.Title.Outline = true
    Drawings.Title.Center = true
    Drawings.Title.Position = Menu.Position + Vector2.new(180, 12)

    local y = 70
    AddToggle("Camera", "🎯 AIMBOT", y); y += 40
    AddToggle("Silent", "🔫 SILENT AIM", y); y += 40
    AddToggle("Prediction", "🔮 PREDICTION", y); y += 40
    AddToggle("FOV", "🔍 FOV CIRCLE", y); y += 40
    AddToggle("ESP", "👁️ ESP", y); y += 40
    AddToggle("Wallhack", "🧱 WALLHACK", y)

    Drawings.HitChanceText = Drawing.new("Text"); Drawings.HitChanceText.Text = "Hit Chance: 100%"; Drawings.HitChanceText.Size = 16; Drawings.HitChanceText.Position = Menu.Position + Vector2.new(25, y + 10)
    Drawings.HitChanceBar = Drawing.new("Square"); Drawings.HitChanceBar.Size = Vector2.new(220, 10); Drawings.HitChanceBar.Position = Menu.Position + Vector2.new(25, y + 30); Drawings.HitChanceBar.Color = Color3.fromRGB(50,50,55); Drawings.HitChanceBar.Filled = true
    Drawings.HitChanceKnob = Drawing.new("Square"); Drawings.HitChanceKnob.Size = Vector2.new(16, 18); Drawings.HitChanceKnob.Color = Color3.fromRGB(0, 255, 200); Drawings.HitChanceKnob.Filled = true

    Drawings.Instructions = Drawing.new("Text")
    Drawings.Instructions.Text = "F1 - Abrir/Fechar | Botão Direito - Mirar"
    Drawings.Instructions.Size = 14
    Drawings.Instructions.Color = Color3.fromRGB(160, 160, 160)
    Drawings.Instructions.Position = Menu.Position + Vector2.new(25, 520)
end

CreateMenuElements()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        Menu.Open = not Menu.Open
        Drawings.Background.Visible = Menu.Open
        Drawings.Border.Visible = Menu.Open
        Drawings.TitleBG.Visible = Menu.Open
        Drawings.Title.Visible = Menu.Open
        Drawings.CameraText.Visible = Menu.Open
        Drawings.CameraButton.Visible = Menu.Open
        Drawings.CameraInner.Visible = Menu.Open
        Drawings.SilentText.Visible = Menu.Open
        Drawings.SilentButton.Visible = Menu.Open
        Drawings.SilentInner.Visible = Menu.Open
        Drawings.PredictionText.Visible = Menu.Open
        Drawings.PredictionButton.Visible = Menu.Open
        Drawings.PredictionInner.Visible = Menu.Open
        Drawings.FOVText.Visible = Menu.Open
        Drawings.FOVButton.Visible = Menu.Open
        Drawings.FOVInner.Visible = Menu.Open
        Drawings.ESPText.Visible = Menu.Open
        Drawings.ESPButton.Visible = Menu.Open
        Drawings.ESPInner.Visible = Menu.Open
        Drawings.WallhackText.Visible = Menu.Open
        Drawings.WallhackButton.Visible = Menu.Open
        Drawings.WallhackInner.Visible = Menu.Open
        Drawings.HitChanceText.Visible = Menu.Open
        Drawings.HitChanceBar.Visible = Menu.Open
        Drawings.HitChanceKnob.Visible = Menu.Open
        Drawings.Instructions.Visible = Menu.Open
    end
end)

RunService.Heartbeat:Connect(function()
    UpdateESP()
    if Config.CameraAimbotEnabled and UserInputService:IsMouseButtonDown(Config.AimKey) then
        local target = GetClosestWithPrediction()
        if target and target.Character then
            local part = target.Character:FindFirstChild(Config.TargetPart)
            if part then local cf = CFrame.new(Camera.CFrame.Position, part.Position); Camera.CFrame = Camera.CFrame:Lerp(cf, Config.Smoothness) end
        end
    end
end)
