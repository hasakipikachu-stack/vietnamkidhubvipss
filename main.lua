-- =================================================
-- VIETNAM KID HUB | UPDATE 30 NO-KEY EDITION
-- =================================================

local LP = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local function EquipWeapon(ToolType)
    pcall(function()
        for _, v in pairs(LP.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                if ToolType == "Melee" and v.ToolTip == "Melee" then
                    LP.Character.Humanoid:EquipTool(v)
                elseif ToolType == "Sword" and v.ToolTip == "Sword" then
                    LP.Character.Humanoid:EquipTool(v)
                elseif ToolType == "Blox Fruit" and v.ToolTip == "Blox Fruit" then
                    LP.Character.Humanoid:EquipTool(v)
                end
            end
        end
    end)
end

local function TP(cframe)
    pcall(function()
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = cframe
        end
    end)
end

local function ServerHop()
    pcall(function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local body = HttpService:JSONDecode(req)
        if body and body.data then
            for _, s in pairs(body.data) do
                if type(s) == "table" and s.maxPlayers and s.playing and s.playing < s.maxPlayers and s.id ~= game.JobId then
                    table.insert(servers, s.id)
                end
            end
        end
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LP)
        else
            TeleportService:Teleport(game.PlaceId, LP)
        end
    end)
end

local function SendDiscordWebhook(url, message)
    pcall(function()
        local data = {["content"] = message}
        local body = HttpService:JSONEncode(data)
        local headers = {["content-type"] = "application/json"}
        if syn and syn.request then
            syn.request({Url = url, Method = "POST", Headers = headers, Body = body})
        elseif http_request then
            http_request({Url = url, Method = "POST", Headers = headers, Body = body})
        elseif request then
            request({Url = url, Method = "POST", Headers = headers, Body = body})
        end
    end)
end

-- MỐC CẤP ĐỘ LÊN 3000 (UPDATE 30)
local QuestData = {
    {Level = 1, Mob = {"Bandit [Level 5]"}, QuestName = "BanditQuest1", CFrameQuest = CFrame.new(1059, 16, 1549), CFrameMob = CFrame.new(1154, 17, 1619)},
    {Level = 10, Mob = {"Monkey [Level 14]"}, QuestName = "JungleQuest", CFrameQuest = CFrame.new(-1598, 36, 153), CFrameMob = CFrame.new(-1445, 51, 75)},
    {Level = 700, Mob = {"Raider [Level 700]"}, QuestName = "Area1Quest", CFrameQuest = CFrame.new(-424, 72, 1837), CFrameMob = CFrame.new(-740, 39, 2380)},
    {Level = 1500, Mob = {"Snow Lurker [Level 1500]"}, QuestName = "FrostQuest", CFrameQuest = CFrame.new(5667, 27, -6486), CFrameMob = CFrame.new(5453, 60, -5725)},
    {Level = 2200, Mob = {"Peanut Scout [Level 2200]"}, QuestName = "NutsIslandQuest", CFrameQuest = CFrame.new(-2104, 44, -10152), CFrameMob = CFrame.new(-2050, 50, -10450)},
    {Level = 2800, Mob = {"Tiki Officer [Level 2800]"}, QuestName = "TikiQuest1", CFrameQuest = CFrame.new(-16238, 9, 513), CFrameMob = CFrame.new(-16800, 20, 600)},
    {Level = 2900, Mob = {"Update 30 Guardian [Level 2900]"}, QuestName = "Update30Quest1", CFrameQuest = CFrame.new(-18000, 50, 1200), CFrameMob = CFrame.new(-18300, 60, 1400)}
}

local function GetCurrentQuest()
    local myLevel = LP.Data.Level.Value
    local currentQuest = QuestData[1]
    for _, v in ipairs(QuestData) do
        if myLevel >= v.Level then
            currentQuest = v
        else
            break
        end
    end
    return currentQuest
end

-- LOAD FLUENT UI TRỰC TIẾP KHÔNG CẦN KEY
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "VietNam Kid Hub",
    SubTitle = "Update 30 No-Key Edition",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 400),
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Sea = Window:AddTab({ Title = "Sea Events", Icon = "waves" }),
    Update30 = Window:AddTab({ Title = "Update 30 (Mới)", Icon = "zap" }),
    Boss = Window:AddTab({ Title = "Săn Boss & Hop", Icon = "crosshair" }),
    Raid = Window:AddTab({ Title = "Dungeon Raid", Icon = "shield" }),
    Exclusive = Window:AddTab({ Title = "Độc Quyền", Icon = "star" }),
    Misc = Window:AddTab({ Title = "Cài Đặt", Icon = "settings" })
}

_G.SelectWeapon = "Melee"
_G.AutoFarmLevel = false
_G.FastAttack = true
_G.AutoSeaEvent = false
_G.AutoMagnet = false
_G.AutoSecretPuzzle = false
_G.AutoPullLeviathanHeart = false
_G.AutoBoss = false
_G.AutoRaid = false
_G.SafeSpot = true
_G.WebhookURL = ""
_G.FixLagActive = false

-- 1. AUTO FARM LEVEL
task.spawn(function()
    while task.wait() do
        if _G.AutoFarmLevel then
            pcall(function()
                local character = LP.Character
                if not character or not character:FindFirstChild("Humanoid") then return end
                
                if _G.SafeSpot and character.Humanoid.Health < (character.Humanoid.MaxHealth * 0.35) then
                    TP(character.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0))
                    task.wait(3)
                    return
                end

                local questInfo = GetCurrentQuest()
                local questTitle = LP.PlayerGui.Main.Quest.Visible and LP.PlayerGui.Main.Quest.Container.QuestTitle.Text or ""
                
                if not questTitle:find(questInfo.Mob[1]:sub(1, 5)) then
                    TP(questInfo.CFrameQuest)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", questInfo.QuestName, 1)
                else
                    local targetMob = nil
                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        for _, mobName in ipairs(questInfo.Mob) do
                            if enemy.Name == mobName and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                targetMob = enemy
                                break
                            end
                        end
                        if targetMob then break end
                    end

                    if targetMob then
                        EquipWeapon(_G.SelectWeapon)
                        TP(targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(math.rad(-90), 0, 0))
                        if _G.FastAttack then
                            local VirtualUser = game:GetService("VirtualUser")
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new(0,0))
                        end
                    else
                        TP(questInfo.CFrameMob)
                    end
                end
            end)
        end
    end
end)

-- 2. AUTO SEA EVENT
task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoSeaEvent then
            pcall(function()
                local target = nil
                if workspace:FindFirstChild("SeaBeasts") then
                    target = workspace.SeaBeasts:FindFirstChildOfClass("Model")
                end
                if not target and workspace:FindFirstChild("Enemies") then
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name:find("Terrorshark") or v.Name:find("Sea Beast") or v.Name:find("Ship") then
                            target = v
                            break
                        end
                    end
                end

                if target and target:FindFirstChild("HumanoidRootPart") then
                    EquipWeapon(_G.SelectWeapon)
                    TP(target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                    if _G.FastAttack then
                        local VirtualUser = game:GetService("VirtualUser")
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new(0,0))
                    end
                end
            end)
        end
    end
end)

-- 3. AUTO MAGNET
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoMagnet then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:find("MagnetItem") or v.Name:find("ScrapMetal") or v.Name:find("MagnetFruit") then
                        if v:IsA("BasePart") or v:FindFirstChild("Handle") then
                            TP(v.CFrame or v.Handle.CFrame)
                        end
                    end
                end
            end)
        end
    end
end)

-- 4. AUTO SECRET PUZZLE
task.spawn(function()
    while task.wait(2) do
        if _G.AutoSecretPuzzle then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartSecretPuzzleUpdate30")
            end)
        end
    end
end)

-- 5. AUTO PULL LEVIATHAN HEART
task.spawn(function()
    while task.wait(0.3) do
        if _G.AutoPullLeviathanHeart then
            pcall(function()
                local character = LP.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end

                local heartTarget = nil
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:find("LeviathanHeart") or v.Name:find("Heart") then
                        if v:IsA("BasePart") or v:FindFirstChild("Handle") then
                            heartTarget = v
                            break
                        end
                    end
                end

                if heartTarget then
                    local harpoonTool = nil
                    for _, tool in pairs(LP.Backpack:GetChildren()) do
                        if tool.Name:find("Harpoon") or tool.Name:find("Beast Hunter") then
                            LP.Character.Humanoid:EquipTool(tool)
                            harpoonTool = tool
                            break
                        end
                    end
                    
                    if not harpoonTool and character:FindFirstChildOfClass("Tool") then
                        local activeTool = character:FindFirstChildOfClass("Tool")
                        if activeTool.Name:find("Harpoon") or activeTool.Name:find("Beast Hunter") then
                            harpoonTool = activeTool
                        end
                    end

                    local targetPos = heartTarget.Position or heartTarget.Handle.Position
                    character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 15, 0))
                    
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes", true)
                    if remote then
                        pcall(function()
                            remote:InvokeServer("ShootHarpoon", targetPos)
                        end)
                    end
                end
            end)
        end
    end
end)

-- 6. AUTO BOSS & SERVER HOP
task.spawn(function()
    while task.wait(1) do
        if _G.AutoBoss then
            pcall(function()
                local foundBoss = false
                if workspace:FindFirstChild("Enemies") then
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and (v.Name:find("Boss") or v.Name:find("King") or v.Name:find("Darkbeard") or v.Name:find("Update 30")) then
                            foundBoss = true
                            EquipWeapon(_G.SelectWeapon)
                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                            if _G.FastAttack then
                                local VirtualUser = game:GetService("VirtualUser")
                                VirtualUser:CaptureController()
                                VirtualUser:ClickButton1(Vector2.new(0,0))
                            end
                        end
                    end
                end
                if not foundBoss then
                    task.wait(5)
                    ServerHop()
                end
            end)
        end
    end
end)

-- 7. AUTO RAID
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoRaid then
            pcall(function()
                local enemyFolder = workspace:FindFirstChild("Enemies")
                if enemyFolder then
                    for _, v in pairs(enemyFolder:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            EquipWeapon(_G.SelectWeapon)
                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(math.rad(-90), 0, 0))
                            if _G.FastAttack then
                                local VirtualUser = game:GetService("VirtualUser")
                                VirtualUser:CaptureController()
                                VirtualUser:ClickButton1(Vector2.new(0,0))
                            end
                            break
                        end
                    end
                end
            end)
        end
    end
end)

-- 8. FIX LAG & FPS BOOST
task.spawn(function()
    while task.wait(1) do
        if _G.FixLagActive then
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                        v.Material = Enum.Material.SmoothPlastic
                        v.CastShadow = false
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then
                        v.Enabled = false
                    end
                end
                local lighting = game:GetService("Lighting")
                lighting.GlobalShadows = false
                lighting.FogEnd = 9e9
                for _, v in pairs(lighting:GetChildren()) do
                    if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
                        v:Destroy()
                    end
                end
            end)
        end
    end
end)

-- TABS CONTROLS & UI MAPPING
Tabs.Main:AddDropdown("WeaponSelect", { Title = "Chọn Vũ Khí", Values = {"Melee", "Sword", "Blox Fruit"}, Default = "Melee", Callback = function(v) _G.SelectWeapon = v end })
Tabs.Main:AddToggle("AutoFarm", { Title = "Auto Farm Level (1 - 3000+)", Default = false, Callback = function(v) _G.AutoFarmLevel = v end })
Tabs.Main:AddToggle("FastAttack", { Title = "Fast Attack (Đánh Siêu Tốc)", Default = true, Callback = function(v) _G.FastAttack = v end })

Tabs.Sea:AddToggle("AutoSea", { Title = "Auto Săn Quái Biển / Sea Event", Default = false, Callback = function(v) _G.AutoSeaEvent = v end })

Tabs.Update30:AddToggle("AutoMagnetToggle", { Title = "Auto Farm Magnet & Nhặt Vật Phẩm Sự Kiện", Default = false, Callback = function(v) _G.AutoMagnet = v end })
Tabs.Update30:AddToggle("AutoSecretPuzzleToggle", { Title = "Auto Quét Nhiệm Vụ Ẩn (Secret Puzzles)", Default = false, Callback = function(v) _G.AutoSecretPuzzle = v end })
Tabs.Update30:AddToggle("AutoPullHeartToggle", { Title = "Auto Kéo Tim Leviathan (Harpoon)", Default = false, Callback = function(v) _G.AutoPullLeviathanHeart = v end })

Tabs.Boss:AddToggle("AutoBossToggle", { Title = "Auto Săn Boss & Tự Động Hop Server", Default = false, Callback = function(v) _G.AutoBoss = v end })
Tabs.Boss:AddButton({
    Title = "Đổi Server Ngay Lập Tức (Server Hop)",
    Callback = function()
        ServerHop()
    end
})

Tabs.Raid:AddToggle("AutoRaidToggle", { Title = "Auto Dungeon Raid (Đánh Đảo)", Default = false, Callback = function(v) _G.AutoRaid = v end })

Tabs.Exclusive:AddToggle("SafeSpotToggle", { Title = "Smart Safe-Spot (Né đòn khi yếu máu)", Default = true, Callback = function(v) _G.SafeSpot = v end })
Tabs.Exclusive:AddInput("WebhookInput", { Title = "Discord Webhook URL", Default = "", Placeholder = "Dán link webhook...", Callback = function(v) _G.WebhookURL = v end })
Tabs.Exclusive:AddButton({
    Title = "Gửi Báo Cáo Tiến Độ Discord",
    Callback = function()
        if _G.WebhookURL ~= "" then
            local msg = "🚀 **VIETNAM KID HUB REPORT**\n👤 User: " .. LP.Name .. "\n⭐ Level: " .. LP.Data.Level.Value .. "\n💰 Beli: " .. LP.Data.Beli.Value
            SendDiscordWebhook(_G.WebhookURL, msg)
            Fluent:Notify({Title = "Thành công", Content = "Đã gửi thông báo!", Duration = 3})
        else
            Fluent:Notify({Title = "Lỗi", Content = "Chưa nhập Webhook URL!", Duration = 3})
        end
    end
})

Tabs.Misc:AddToggle("FixLagToggle", { Title = "Bật Fix Lag / Tăng FPS (Treo máy mượt)", Default = false, Callback = function(v) _G.FixLagActive = v end })

-- NÚT BẤM DI ĐỘNG (TOGGLE MENU)
local LogoGui = Instance.new("ScreenGui")
LogoGui.Name = "VietNamKidLogoGui"
LogoGui.Parent = game:GetService("CoreGui") or LP:WaitForChild("PlayerGui")

local LogoBtn = Instance.new("ImageButton")
LogoBtn.Parent = LogoGui
LogoBtn.Size = UDim2.new(0, 50, 0, 50)
LogoBtn.Position = UDim2.new(0.9, -10, 0.4, 0)
LogoBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LogoBtn.BackgroundTransparency = 0.3
LogoBtn.Image = "rbxassetid://10723346959"
LogoBtn.Active = true
LogoBtn.Draggable = true

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = LogoBtn

LogoBtn.MouseButton1Click:Connect(function()
    Window:Minimize()
end)

Fluent:Notify({
    Title = "VietNam Kid Hub",
    Content = "Đã bật bản No-Key thành công!",
    Duration = 5
})
