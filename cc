-- ====================================================================
-- PHẦN 4: HỆ THỐNG AUTO FISHING V3 - ONE PIECE FINAL (SOURCE SYNC EDITION)
-- ====================================================================
local _G = _G or {}
_G.AutoFishing = false
_G.SelectedRod = "Wood Rod"

local tab4 = MainMenu:CreateTab("Fishing 🎣")

tab4:CreateDropdown({
    Name = "Chọn loại Cần Câu (Select Rod)",
    Options = {"Wood Rod", "Sturdy Rod", "Super Rod"},
    CurrentOption = "Wood Rod",
    Callback = function(Option)
        _G.SelectedRod = Option
        warn("🎣 Đã chuyển sang sử dụng loại cần: " .. tostring(_G.SelectedRod))
    end,
})

tab4:CreateToggle({
    Name = "Tự động Câu Cá (Auto Fishing V3)",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoFishing = v
        
        if _G.AutoFishing then
            local pObj = game:GetService("Players").LocalPlayer
            
            -- Lấy ModuleScript mã hóa của game dựa theo dòng code gốc [v1:FindFirstChildOfClass("ModuleScript")]
            local ReplicatedFirst = game:GetService("ReplicatedFirst")
            local GameModuleScript = ReplicatedFirst:FindFirstChildOfClass("ModuleScript")
            local GameRequire = GameModuleScript and require(GameModuleScript)
            
            task.spawn(function()
                while _G.AutoFishing do
                    task.wait(0.1) -- Vòng lặp tuần hoàn an toàn chống lag
                    
                    local char = pObj.Character
                    local mr = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    
                    if mr and hum and hum.Health > 0 and GameRequire then
                        local pGui = pObj:FindFirstChild("PlayerGui")
                        
                        -- 🌟 BƯỚC 1: THANH TRA VÀ BẺ KHÓA MINIGAME (AUTO WIN CHẮC CHẮN 100%)
                        local fishingMinigameGui = pGui:FindFirstChild("FishingMinigame")
                        if fishingMinigameGui and fishingMinigameGui.Enabled == true then
                            pcall(function()
                                -- Khi bảng "PULL IT!" hiện ra, ép Server trả thưởng cá ngay lập tức mà không cần tự click 15 lần
                                GameRequire["\t"]("FishingEvent", { "Caught" })
                                fishingMinigameGui.Enabled = false -- Đóng giao diện bảng minigame
                                warn("⚡ Đã tự động kích hoạt Auto-Win Minigame thành công!")
                            end)
                            task.wait(1.5) -- Đợi server đồng bộ dữ liệu nhận cá
                        
                        -- 🌟 BƯỚC 2: LOGIC TỰ ĐỘNG THẢ CẦN VÀ CHỜ CÁ CẮN
                        else
                            -- Tự động kiểm tra và lấy đúng loại cần câu bạn đã chọn ra tay
                            local holdingRod = char:FindFirstChildOfClass("Tool")
                            if not holdingRod or string.lower(holdingRod.Name) ~= string.lower(_G.SelectedRod) then
                                if holdingRod then holdingRod.Parent = pObj.Backpack end
                                local targetRodInBackpack = pObj.Backpack:FindFirstChild(_G.SelectedRod)
                                if targetRodInBackpack then
                                    hum:EquipTool(targetRodInBackpack)
                                    task.wait(0.4)
                                end
                            end
                            
                            holdingRod = char:FindFirstChildOfClass("Tool")
                            if holdingRod and string.lower(holdingRod.Name) == string.lower(_G.SelectedRod) then
                                -- Quét tìm thực thể Phao câu ẩn của bạn trong Workspace
                                local myBobber = nil
                                for _, b in pairs(workspace:GetDescendants()) do
                                    if b:IsA("BasePart") and (string.find(string.lower(b.Name), "bobber") or string.find(string.lower(b.Name), "phao") or string.find(string.lower(b.Name), "hook") or string.find(string.lower(b.Name), "lure") or string.find(string.lower(b.Name), "fishing")) then
                                        if (mr.Position - b.Position).Magnitude < 80 then
                                            myBobber = b break
                                        end
                                    end
                                end
                                
                                -- TRƯỜNG HỢP A: ĐÃ THẢ DÂY CÂU -> Đợi hiệu ứng đốm xanh lá bùng lên để giật cần
                                if myBobber then
                                    local fishBiting = false
                                    for _, obj in pairs(workspace:GetDescendants()) do
                                        if (obj:IsA("ParticleEmitter") or obj:IsA("Sparkles")) and (obj:IsDescendantOf(myBobber) or (obj.Parent:IsA("BasePart") and (obj.Parent.Position - myBobber.Position).Magnitude < 10)) then
                                            -- Thuật toán phân tích dải màu của hệ thống hạt, lọc đúng màu xanh lá (G > 0.65)
                                            if obj:IsA("ParticleEmitter") and (obj.Color.Keypoints.Value.G > 0.65 and obj.Color.Keypoints.Value.R < 0.45) then
                                                fishBiting = true break
                                            elseif obj:IsA("Sparkles") and (obj.SparkleColor.G > 0.65 and obj.SparkleColor.R < 0.45) then
                                                fishBiting = true break
                                            end
                                        end
                                    end
                                    
                                    -- Dự phòng thêm cơ chế vật lý phao chìm khi cá đớp mồi
                                    if not fishBiting and (myBobber.AssemblyLinearVelocity.Y < -2.2 or myBobber:GetAttribute("Biting") == true) then
                                        fishBiting = true
                                    end
                                    
                                    -- Phát hiện cá cắn câu -> Gọi mã hóa giật dây câu lên Server
                                    if fishBiting then
                                        pcall(function()
                                            GameRequire["\t"]("FishingEvent", { "Reel" })
                                        end)
                                        task.wait(1.2) -- Chờ bảng minigame mở ra để vòng lặp sau xử lý Auto-Win
                                    end
                                    
                                -- TRƯỜNG HỢP B: CHƯA THẢ DÂY CÂU -> Gọi mã hóa quăng dây câu xuống biển
                                else
                                    pcall(function()
                                        GameRequire["\t"]("FishingEvent", { "Cast" })
                                    end)
                                    task.wait(2.2) -- Thời gian trễ an toàn để phao rơi xuống nước ổn định
                                end
                            end
                        end
                        
                    end
                end
            end)
        end
    end
})
