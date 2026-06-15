-- ====================================================================
-- 1. DÁN LINK RAW FILE 1 CỦA BẠN VÀO ĐÂY ĐỂ TỰ ĐỘNG DỰNG GUI MENU
-- ====================================================================
local linkFile1 = "https://raw.githubusercontent.com/Volyminhchau/kyyuuunopro-script/refs/heads/main/main.lua" -- Thay bằng link Raw File 1 của bạn
local myLibrary = loadstring(game:HttpGet(linkFile1))()

-- ====================================================================
-- 2. ĐOẠN CODE TÍNH NĂNG CỦA FILE 2 (CHẠY TRỰC TIẾP TRÊN EXECUTOR)
-- ====================================================================
-- Khởi tạo cửa sổ menu từ File 1 kéo về
local Window = myLibrary:CreateWindow({
    Name = "Kyyuuunopro Private ⚔️",
    LoadingTitle = "Đang cấu hình hệ thống...",
    LoadingUser = "Chào mừng người dùng"
})

-- Tạo Tab chức năng trên Menu
local FarmTab = Window:CreateTab("Auto Farm")

-- Cấu hình hệ thống mặc định
local _G = _G or {}
_G.AutoFarm = false

-- Danh sách chính xác các NPC bạn muốn farm trên toàn map
local targetNPCs = {
    "Bandit",
    "Thug",
    "Angry bob",
    "Angry Freddy",
    "Thief",
    "Gunslinger"
}

-- Hàm kiểm tra xem tên của đối tượng có chứa bất kỳ tên quái nào trong danh sách không
local function isTargetNPC(name)
    local lowerName = string.lower(name)
    for _, target in pairs(targetNPCs) do
        if string.find(lowerName, string.lower(target)) then
            return true
        end
    end
    return false
end

-- ====================================================================
-- 3. TẠO NÚT BẬT/TẮT VÀ LOGIC AUTO FARM TRÊN TOÀN MAP
-- ====================================================================
FarmTab:CreateToggle({
    Name = "Auto Farm Custom Mobs (Toàn Map)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        if _G.AutoFarm then
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.05) -- Tốc độ vòng lặp quét tối ưu
                    
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        
                        if rootPart and humanoid and humanoid.Health > 0 then
                            local targetNPC = nil
                            
                            -- Quét toàn bộ map (workspace) không giới hạn khoảng cách
                            for _, obj in pairs(workspace:GetDescendants()) do
                                -- Kiểm tra nếu đúng loại quái trong danh sách, có Humanoid và còn sống
                                if isTargetNPC(obj.Name) and obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChildOfClass("Humanoid").Health > 0 then
                                    if obj:FindFirstChild("HumanoidRootPart") then
                                        targetNPC = obj
                                        break -- Nhắm mục tiêu con quái đầu tiên tìm thấy trên map
                                    end
                                end
                            end
                            
                            -- HÀNH ĐỘNG DỊCH CHUYỂN VÀ TẤN CÔNG
                            if targetNPC then
                                local npcRoot = targetNPC.HumanoidRootPart
                                
                                -- Dịch chuyển ra sau lưng cách quái 2.5 studs và quay mặt vào quái
                                rootPart.CFrame = npcRoot.CFrame * CFrame.new(0, 0, 2.5) * CFrame.Angles(0, math.rad(180), 0)
                                
                                -- Tự động vung vũ khí tấn công
                                local tool = character:FindFirstChildOfClass("Tool")
                                if tool then 
                                    tool:Activate() 
                                else
                                    -- Nếu chưa cầm sẵn vũ khí, tự động trang bị từ Backpack
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
