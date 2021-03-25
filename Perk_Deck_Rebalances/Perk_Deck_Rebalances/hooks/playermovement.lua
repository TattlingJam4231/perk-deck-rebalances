Hooks:PostHook(PlayerMovement, "update", "PDR PlayerMovement update", function(self)
    self:upd_meat_shield()
end)

--Muscle-------------------------------------------------------------------------------------------
function PlayerMovement:upd_meat_shield()
    if not managers.player:has_category_upgrade("temporary", "meat_shield_dmg_dampener") then return end

    local my_pos = self._m_pos
    local player_mask = managers.slot:get_mask("players")
    local radius = 1000
    
    local players_near = World:find_units("intersect", "sphere", my_pos, radius, player_mask)

    if #players_near >= 1 then
        managers.player:activate_temporary_upgrade("temporary", "meat_shield_dmg_dampener")
    end
end