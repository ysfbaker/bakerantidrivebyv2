-- Blacklist'te bulunan silahlar
local blacklist = {
    "WEAPON_PISTOL",
    "WEAPON_SMG",
}

-- Oyuncunun araç içinde olup olmadığının kontrolü
function IsPlayerInVehicle(player)
    if IsPedInAnyVehicle(player, false) then
        return true
    else
        return false
    end
end

-- Silah kullanımı olayı
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local player = PlayerId()

        -- Oyuncu araç içindeyse
        if IsPlayerInVehicle(player) then
            local currentWeapon = GetSelectedPedWeapon(player)

            -- Eğer silah blacklist'te ise
            if currentWeapon ~= nil and IsControlJustReleased(0, 24) then -- 24, sol fare tuşu, değişebilirsiniz
                local weaponHash = GetHashKey(currentWeapon)

                for _, blacklistedWeapon in pairs(blacklist) do
                    if GetHashKey(blacklistedWeapon) == weaponHash then
                        -- Silah kullanımını engelle
                        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Araç içerisindeyken silah kullanamazsın!', length = 3500})
                        SetCurrentPedWeapon(player, "WEAPON_UNARMED", true)
                        break
                    end
                end
            end
        end
    end
end)
