-- Blacklist'te bulunan silahlar
local blacklist = {
    "WEAPON_PISTOL",
    "WEAPON_SMG",
}

function IsPlayerInVehicle(player)
    if IsPedInAnyVehicle(player, false) then
        return true
    else
        return false
    end
end

CreateThread(function()
    while true do
        Wait(100)

        local player = PlayerId()

        if IsPlayerInVehicle(player) then
            local currentWeapon = GetSelectedPedWeapon(player)

            if currentWeapon ~= nil and IsControlJustReleased(0, 25) then -- 25 sağ tık
                local weaponHash = GetHashKey(currentWeapon)

                for _, blacklistedWeapon in pairs(blacklist) do
                    if GetHashKey(blacklistedWeapon) == weaponHash then
                        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Araç içerisindeyken silah kullanamazsın!', length = 3500})
                        SetCurrentPedWeapon(player, "WEAPON_UNARMED", true)
                        break
                    end
                end
            end
        end
    end
end)
