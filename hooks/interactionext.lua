local original_func = BaseInteractionExt._get_timer

function BaseInteractionExt:_get_timer()
	local local_peer_id = managers.network:session() and managers.network:session():local_peer():id()
	local timer = original_func(self)
	local pm = managers.player

	if not local_peer_id or not pm:has_category_upgrade("player", "cocaine_stacking") then
		return timer
	end

    if self.tweak_data ~= "corpse_alarm_pager" and pm:has_category_upgrade("player", "cocaine_stacks_interaction_speed") then
        local cocaine_stack = pm:get_synced_cocaine_stacks(local_peer_id)
        local amount = cocaine_stack and cocaine_stack.amount or 0
        local multiplier = amount >= 300 and pm:upgrade_value("player", "cocaine_stacks_interaction_speed") or 1
        timer = timer * multiplier
        return timer
    end
    return timer
end