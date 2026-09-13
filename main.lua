epeat wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Cấu hình chạy ngầm tích hợp sẵn cho Banana Hub
getgenv().Team = "Pirates" -- Đổi thành "Marines" nếu thích phe Hải Quân
getgenv().Hide_Menu = false

-- Kích hoạt mã nguồn chính chủ Banana Hub (Full Option)
loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"))()
