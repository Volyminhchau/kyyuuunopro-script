-- 1. Khởi chạy thư viện giao diện TỪ LINK CỦA BẠN
local library = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Volyminhchau/kyyuuunopro-script/refs/heads/main/main.lua")))()
-- 2. Khởi tạo Cửa sổ chính theo đúng cấu trúc hàm của thư viện bạn
local Window = library:CreateWindow({
    Name = "Kyyuuunopro Premium Hub 🚀",
    LoadingTitle = "Đang tải hệ thống...",
    LoadingUser = "Chào mừng người dùng"
})

-- 3. Tạo Tab Chức Năng
local FarmTab = Window:CreateTab("Auto Farm ⚔️") 

-- Cấu hình mặc định hệ thống
local _G = _G or {}
_G.AutoFarm = false
local npcName = "Tên_NPC_Ở_Đây" -- ⚠️ Hãy ĐỔI chữ này thành tên chính xác của NPC trong game của bạn

-- 4. Tạo Nút bật/tắt (Toggle) đồng bộ với thư viện của bạn
FarmTab:CreateToggle({
    Name = "Kích hoạt Auto Farm NPC",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        if _G.AutoFarm then
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.05) -- Tốc độ vòng lặp quét quái cực nhanh
                    
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        
                        if rootPart and humanoid and humanoid.Health > 0 then
                            -- Quét tìm mục tiêu quái vật trong game
                            local targetNPC = nil
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if obj.Name == npcName and obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChildOfClass("Humanoid").Health > 0 then
                                    if obj:FindFirstChild("HumanoidRootPart") then
                                        targetNPC = obj
                                        break
                                    end
                                end
                            end
                            
                            -- Hành động khi định vị được NPC mục tiêu
                            if targetNPC then
                                local npcRoot = targetNPC.HumanoidRootPart
                                
                                -- Dịch chuyển ra sau lưng cách quái 2.5 studs và quay mặt vào quái
                                rootPart.CFrame = npcRoot.CFrame * CFrame.new(0, 0, 2.5) * CFrame.Angles(0, math.rad(180), 0)
                                
                                -- Tự động kích hoạt vũ khí trên tay
                                local tool = character:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool:Activate()
                                else
                                    -- Tự động lấy vũ khí từ balo (Backpack) ra nếu chưa cầm sẵn
                                    local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
                                    if backpackTool then
                                        backpackTool.Parent = character
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})
