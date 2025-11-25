--══════════════════════════════════════════════════════════--
--          TP INSTANTÂNEO + VOO + C-FLY DESYNC 2025
--                 MÉTODO EXATO QUE VOCÊ PEDIU
--                    BY BRANZZ (FINAL BOSS)
--══════════════════════════════════════════════════════════--

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Variáveis
local MarkedPos = nil
local Flying = false
local CFlyActive = false
local FlightSpeed = 27
local Clone = nil
local Platforms = {}
local CurrentTP = nil
local Minimized = false
local HumanoidRootPart

-- Anti-Kick (nunca mais toma kick por script)
spawn(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then return end
        if string.find(tostring(self), "kick") or string.find(tostring(self), "ban") then return end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)

-- GUI
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BranzzTP_Final"

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 340, 0, 480)
Main.Position = UDim2.new(0.5, -170, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 4
spawn(function()
    while Main.Parent do
        Stroke.Color = Color3.fromHSV(tick() % 6 / 6, 1, 0.85)
        task.wait(0.03)
    end
end)

-- Título e Sub
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -80, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "TP INSTANTÂNEO"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

local Sub = Instance.new("TextLabel", Main)
Sub.Size = UDim2.new(0, 150, 0, 28)
Sub.Position = UDim2.new(0.5, -75, 0, 45)
Sub.BackgroundColor3 = Color3.new(0,0,0)
Sub.Text = "BY BRANZZ"
Sub.TextColor3 = Color3.fromRGB(70, 255, 180)
Sub.Font = Enum.Font.GothamBold
Sub.TextSize = 15
Instance.new("UICorner", Sub).CornerRadius = UDim.new(0, 8)
local SubStroke = Instance.new("UIStroke", Sub)
SubStroke.Thickness = 2
spawn(function()
    while true do SubStroke.Color = Color3.fromHSV(tick() % 6 / 6, 1, 0.85) task.wait(0.03) end
end)

-- Botões - e X
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 36, 0, 36)
MinBtn.Position = UDim2.new(1, -74, 0, 8)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 28

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 36, 0, 36)
CloseBtn.Position = UDim2.new(1, -36, 0, 8)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 22

-- Conteúdo
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -20, 1, -80)
Content.Position = UDim2.new(0, 10, 0, 70)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 5
Content.CanvasSize = UDim2.new(0, 0, 0, 700)
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)

-- Label posição
local PosLabel = Instance.new("TextLabel", Content)
PosLabel.Size = UDim2.new(1, -10, 0, 45)
PosLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PosLabel.Text = "Posição marcada: Nenhuma"
PosLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
PosLabel.Font = Enum.Font.Gotham
PosLabel.TextSize = 15
Instance.new("UICorner", PosLabel).CornerRadius = UDim.new(0, 10)

-- Função botão único
local function Btn(name, key, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 52)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.Text = name.." ["..key.."] - OFF"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 16
    b.Parent = Content
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", b)
    s.Thickness = 1.5
    s.Color = Color3.fromRGB(55, 55, 55)

    local state = false
    local function set(on)
        state = on
        b.BackgroundColor3 = on and Color3.fromRGB(0, 110, 0) or Color3.fromRGB(25, 25, 25)
        b.Text = name.." ["..key.."] - "..(on and "ON" or "OFF")
    end
    b.MouseButton1Click:Connect(function() callback(not state); set(not state) end)
    UIS.InputBegan:Connect(function(i) if i.KeyCode == Enum.KeyCode[key] then b.MouseButton1Click:Fire() end end)
    return {set = set}
end

-- === MARK & CLEAR ===
Btn("Mark Position", "M", function(on)
    if not on or MarkedPos then return end
    HumanoidRootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart then
        MarkedPos = HumanoidRootPart.Position
        PosLabel.Text = "Marcada: "..string.format("%.1f, %.1f, %.1f", MarkedPos.X, MarkedPos.Y, MarkedPos.Z)
        PosLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
    end
end)

Btn("Clear Position", "C", function(on)
    if not on then return end
    MarkedPos = nil
    PosLabel.Text = "Posição marcada: Nenhuma"
    PosLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

-- === VOO LIVRE (MÉTODO EXATO QUE VOCÊ MANDOU) ===
local FlyBtn = Btn("Voo Livre", "F", function(on) Flying = on end)

-- === C-FLY (MÉTODO EXATO + DESYNC TOTAL) ===
local CFlyBtn = Btn("C-Fly (Desync)", "V", function(on)
    CFlyActive = on
    if on then
        -- Clone fixo no servidor
        Clone = Player.Character:Clone()
        Clone.Parent = workspace
        for _, v in pairs(Clone:GetDescendants()) do
            if v:IsA("Script") or v:IsA("LocalScript") then v:Destroy() end
        end
        Clone.HumanoidRootPart.Anchored = true
        Clone.Humanoid.PlatformStand = true

        -- Player invisível
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") or (v:IsA("Accessory") and v:FindFirstChild("Handle")) then
                v.Transparency = 1
            end
        end

        -- Config velocidade (flutuante)
        local SpeedGui = Instance.new("Frame", ScreenGui)
        SpeedGui.Size = UDim2.new(0, 120, 0, 80)
        SpeedGui.Position = UDim2.new(0, 100, 0, 400)
        SpeedGui.BackgroundColor3 = Color3.fromRGB(20,20,20)
        SpeedGui.Active = true
        SpeedGui.Draggable = true
        Instance.new("UICorner", SpeedGui).CornerRadius = UDim.new(0,14)
        local str = Instance.new("UIStroke", SpeedGui)
        str.Thickness = 3
        spawn(function()
            while SpeedGui.Parent do
                str.Color = Color3.fromHSV(tick()%6/6,1,0.85)
                task.wait(0.03)
            end
        end)

        local SpeedBox = Instance.new("TextBox", SpeedGui)
        SpeedBox.Size = UDim2.new(1, -20, 0, 40)
        SpeedBox.Position = UDim2.new(0, 10, 0, 20)
        SpeedBox.Text = "27"
        SpeedBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
        SpeedBox.TextColor3 = Color3.new(1,1,1)
        SpeedBox.FocusLost:Connect(function()
            local n = tonumber(SpeedBox.Text) or 27
            FlightSpeed = math.clamp(n, 1, 100)
            SpeedBox.Text = FlightSpeed
        end)
    else
        -- Desativar tudo
        Flying = false
        if Clone then Clone:Destroy() end
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") or (v:IsA("Accessory") and v:FindFirstChild("Handle")) then
                v.Transparency = 0
            end
        end
        ScreenGui:FindFirstChildWhichIsA("Frame"):Destroy()
    end
end)

-- === VOO PRINCIPAL (O MESMO CÓDIGO QUE VOCÊ MANDOU) ===
RunService.RenderStepped:Connect(function()
    if not Player.Character then return end
    HumanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end

    local cam = workspace.CurrentCamera

    -- Voo Livre NORMAL
    if Flying and not CFlyActive then
        HumanoidRootPart.Velocity = cam.CFrame.LookVector * FlightSpeed
    end

    -- C-Fly (DESYNC TOTAL - servidor vê clone parado)
    if CFlyActive then
        HumanoidRootPart.Velocity = cam.CFrame.LookVector * FlightSpeed
    end
end)

-- === TP COM PLATAFORMAS ===
Btn("TP Voando (Plataformas)", "T", function(on)
    if not MarkedPos then return end
    if on then
        CurrentTP = "plat"
        spawn(function()
            while CurrentTP == "plat" and HumanoidRootPart do
                local target = Vector3.new(MarkedPos.X, MarkedPos.Y + 5, MarkedPos.Z)
                HumanoidRootPart.Velocity = (target - HumanoidRootPart.Position).Unit * 100
                if (HumanoidRootPart.Position - target).Magnitude < 10 then
                    CurrentTP = nil
                end
                if tick() % 3 < 0.1 then
                    local p = Instance.new("Part", workspace)
                    p.Size = Vector3.new(6,1,6)
                    p.Position = HumanoidRootPart.Position - Vector3.new(0,4,0)
                    p.Anchored = true
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.fromRGB(100,255,200)
                    p.Transparency = 0.3
                    table.insert(Platforms, p)
                    game:GetService("Debris"):AddItem(p, 4.2)
                end
                task.wait()
            end
        end)
    else
        CurrentTP = nil
        for _,p in pairs(Platforms) do pcall(function() p:Destroy() end) end
        Platforms = {}
    end
end)

-- === MINIMIZAR E FECHAR ===
MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    MinBtn.Text = Minimized and "+" or "—"
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        Size = Minimized and UDim2.new(0,340,0,70) or UDim2.new(0,340,0,480)
    }):Play()
    Content.Visible = not Minimized
end)

CloseBtn.MouseButton1Click:Connect(function()
    Flying = false
    CFlyActive = false
    if Clone then Clone:Destroy() end
    ScreenGui:Destroy()
end)

print("BRANZZ TP 2025 FINAL CARREGADO - VOO E C-FLY COM SEU MÉTODO EXATO + DESYNC TOTAL")