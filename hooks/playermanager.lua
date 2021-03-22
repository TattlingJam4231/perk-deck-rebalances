Hooks:PostHook(PlayerManager, "update", "PDR pm update", function(self)
	--Yakuza---------------------------------------------------------------------------------------
	self:upd_shallow_grave()
	--Yakuza---------------------------------------------------------------------------------------
end)

function PlayerManager:_update_timers(t)
	local timers_copy = table.map_copy(self._timers)

	for key, timer in pairs(timers_copy) do
		if not timer.t or timer.t <= t then
			self._timers[key] = nil

			if timer.func then
				timer.func(key, timer.t)
			end
		end
	end
	

	--Gambler--------------------------------------------------------------------------------------
	if self:has_category_upgrade("temporary", "loose_ammo_crit_bonus") then
		PlayerManager:update_gambler_crit_bonus(t)
	end
	--Gambler--------------------------------------------------------------------------------------
end


--Armorer------------------------------------------------------------------------------------------
function PlayerManager:armorer_damage_reduction(damage)
	local dmg = damage
	local damage_reduction_1 = self:upgrade_value("player", "armorer_damage_reduction_1", 0)
	local damage_threshold_1 = self:upgrade_value("player", "armorer_damage_reduction_threshold_1", 0)
	local damage_reduction_2 = self:upgrade_value("player", "armorer_damage_reduction_2", 0)
	local damage_threshold_2 = self:upgrade_value("player", "armorer_damage_reduction_threshold_2", 0)
	local damage_reduction_3 = self:upgrade_value("player", "armorer_damage_reduction_3", 0)
	local damage_threshold_3 = self:upgrade_value("player", "armorer_damage_reduction_threshold_3", 0)
	local damage_threshold_4 = 300
	
	if damage_reduction_3 ~= 0 then
		dmg = math.max(dmg - damage_threshold_4, 0) 
			  + (math.max(math.min(damage_threshold_4 - damage_threshold_3, dmg - damage_threshold_3), 0) * damage_reduction_3)
			  + (math.max(math.min(damage_threshold_3 - damage_threshold_2, dmg - damage_threshold_2), 0) * damage_reduction_2)
			  + (math.max(math.min(damage_threshold_2 - damage_threshold_1, dmg - damage_threshold_1), 0) * damage_reduction_1)
			  + math.min(damage_threshold_1, dmg)
		
	elseif damage_reduction_2 ~= 0 then
		dmg = math.max(dmg - damage_threshold_4, 0) 
			  + (math.max(math.min(damage_threshold_4 - damage_threshold_2, dmg - damage_threshold_2), 0) * damage_reduction_2)
			  + (math.max(math.min(damage_threshold_2 - damage_threshold_1, dmg - damage_threshold_1), 0) * damage_reduction_1)
			  + math.min(damage_threshold_1, dmg)
		
	elseif damage_reduction_1 ~= 0 then
		dmg = math.max(dmg - damage_threshold_4, 0)
			  + (math.max(math.min(damage_threshold_4 - damage_threshold_1, dmg - damage_threshold_1), 0) * damage_reduction_1)
			  + math.min(damage_threshold_1, dmg)
	end
	
	return dmg
end


--Gambler------------------------------------------------------------------------------------------
function PlayerManager:update_gambler_crit_bonus(t)
	self.gambler_crit_stacks = self.gambler_crit_stacks or {}
	self.gambler_jackpot = self.gambler_jackpot or 0
	self.jackpot_expire_time = self.jackpot_expire_time or 0
	
	if self.gambler_crit_stacks[1] and self.gambler_crit_stacks[1][2] < t then
		table.remove(self.gambler_crit_stacks, 1)
	end
	
	if self.gambler_jackpot == 7 and self.jackpot_expire_time < t then
		self.gambler_jackpot = 0
		self.jackpot_expire_time = 0
	end
end

function PlayerManager:add_gambler_crit_stack()
	self.gambler_crit_stacks = self.gambler_crit_stacks or {}
	self.just_lucky = self.just_lucky or 0
	self.gambler_jackpot = self.gambler_jackpot or 0
	
	local value_range = PlayerManager:upgrade_value_by_level("temporary", "loose_ammo_crit_bonus", 1, {0,0})
	local crit_value = math.random(value_range[1], value_range[2])
	local expire_time = Application:time() + PlayerManager:upgrade_value_by_level("temporary", "loose_ammo_crit_bonus", 2, 5)
	
	self.just_lucky = (crit_value == 7) and self.just_lucky + 1 or 0
	self.gambler_jackpot = (self.just_lucky >= 3) and 7 or 0
	if self.gambler_jackpot == 7 then
		self.jackpot_expire_time = Application:time() + PlayerManager:upgrade_value_by_level("temporary", "loose_ammo_crit_bonus", 4, 5)
	end
	
	table.insert(self.gambler_crit_stacks, {crit_value, expire_time})
 
end

function PlayerManager:get_gambler_crit_bonus()
	self.gambler_crit_stacks = self.gambler_crit_stacks or {}
	
	if self.gambler_jackpot == 7 then
		return PlayerManager:upgrade_value_by_level("temporary", "loose_ammo_crit_bonus", 2, 0) * 0.01
	end
	
	local crit_bonus = 0
	for k, v in pairs(self.gambler_crit_stacks) do
		crit_bonus = crit_bonus + v[1]
	end
	
	return crit_bonus * 0.01
end


--Maniac-------------------------------------------------------------------------------------------
function PlayerManager:_update_damage_dealt(t, dt)
	local local_peer_id = managers.network:session() and managers.network:session():local_peer():id()

	if not local_peer_id or not self:has_category_upgrade("player", "cocaine_stacking") then
		return
	end

	self._damage_dealt_to_cops_t = self._damage_dealt_to_cops_t or t + (tweak_data.upgrades.cocaine_stacks_tick_t or 1)
	
	self._damage_dealt_to_cops_decay_trigger_t = self._damage_dealt_to_cops_decay_trigger_t or t + (tweak_data.upgrades.cocaine_stacks_decay_trigger_t or 6)
	
	local cocaine_stack = self:get_synced_cocaine_stacks(local_peer_id)
	local amount = cocaine_stack and cocaine_stack.amount or 0
	local new_amount = amount
	
	self._damage_dealt_to_cops_prev = self._damage_dealt_to_cops_prev or 0
	if self._damage_dealt_to_cops_prev < tweak_data.upgrades.max_cocaine_stacks_per_tick/10 then
		local new_stacks = (math.min((self._damage_dealt_to_cops or 0), tweak_data.upgrades.max_cocaine_stacks_per_tick/10) - self._damage_dealt_to_cops_prev) * (tweak_data.gui.stats_present_multiplier or 10) * self:upgrade_value("player", "cocaine_stacking", 0)
		new_amount = new_amount + math.min(new_stacks, tweak_data.upgrades.max_cocaine_stacks_per_tick or 20)
		self._damage_dealt_to_cops_prev = math.min((self._damage_dealt_to_cops or 0), 24)
	end
	
	if self._damage_dealt_to_cops_t <= t then
		self._damage_dealt_to_cops_t = t + (tweak_data.upgrades.cocaine_stacks_tick_t or 1)
		self._damage_dealt_to_cops = 0
		self._damage_dealt_to_cops_prev = 0
		self._damage_dealt_by_cops_prev = 0
	end
	
	if self._damage_dealt_to_cops_decay_trigger_t <= t then
		self._damage_dealt_to_cops_decay_t = self._damage_dealt_to_cops_decay_t or t + (tweak_data.upgrades.cocaine_stacks_decay_t or 5)
		
		if self._damage_dealt_to_cops_decay_t <= t then
			self._damage_dealt_to_cops_decay_t = t + (tweak_data.upgrades.cocaine_stacks_decay_t or 5)
			local decay = amount * (tweak_data.upgrades.cocaine_stacks_decay_percentage_per_tick or 0)
			decay = decay + tweak_data.upgrades.cocaine_stacks_decay_amount_per_tick or 20
			new_amount = new_amount - decay
		end
	end

	new_amount = math.clamp(math.floor(new_amount), 0, tweak_data.upgrades.max_total_cocaine_stacks or 2047)
	if new_amount > tweak_data.upgrades.max_total_cocaine_stacks then
		self._damage_dealt_to_cops = self._damage_dealt_to_cops - (new_amount - tweak_data.upgrades.max_total_cocaine_stacks)
		self._damage_dealt_to_cops_prev = self._damage_dealt_to_cops_prev - (new_amount - tweak_data.upgrades.max_total_cocaine_stacks)
	end
	
	self.cocaine_stack_amount_prev = new_amount
	
	if new_amount ~= amount then
		self:update_synced_cocaine_stacks_to_peers(new_amount, self:upgrade_value("player", "sync_cocaine_upgrade_level", 1), self:upgrade_level("player", "cocaine_stack_absorption_multiplier", 0))
	end
end


function PlayerManager:_check_damage_to_cops(t, unit, damage_info)
	local player_unit = self:player_unit()

	if alive(player_unit) and not player_unit:character_damage():need_revive() and player_unit:character_damage():dead() then
		-- Nothing
	end

	if not alive(unit) or not unit:base() or not damage_info then
		return
	end

	if damage_info.is_fire_dot_damage then
		return
	end

	if CopDamage.is_civilian(unit:base()._tweak_table) then
		return
	end
	
	if damage_info.variant ~= "fire" and damage_info.variant ~= "poison" and not damage_info.attacker_unit:base().sentry_gun then
		self._damage_dealt_to_cops_decay_trigger_t = t + (tweak_data.upgrades.cocaine_stacks_decay_trigger_t or 6)
		self._damage_dealt_to_cops_decay_t = t + (tweak_data.upgrades.cocaine_stacks_decay_t or 5)
	end
	
	self._damage_dealt_to_cops = self._damage_dealt_to_cops or 0
	self._damage_dealt_to_cops = self._damage_dealt_to_cops + (damage_info.damage or 0)
end


function PlayerManager:cocaine_stack_damage_reduction(damage)
	local local_peer_id = managers.network:session() and managers.network:session():local_peer():id()

	if not local_peer_id or not self:has_category_upgrade("player", "cocaine_stacking") then
		return damage
	end
	
	local dmg = damage
	local cocaine_stack = self:get_synced_cocaine_stacks(local_peer_id)
	local amount = cocaine_stack and cocaine_stack.amount or 0
	self._damage_dealt_by_cops_prev = self._damage_dealt_by_cops_prev or 0
	local amount_prev = amount
	
	local damage_reduction = 1
	local stack_damage = self:upgrade_value_by_level("player", "cocaine_stacks_damaged_1", 1, 0)
	if self:has_category_upgrade("player", "cocaine_stacks_damaged_2") then
		stack_damage = self:upgrade_value_by_level("player", "cocaine_stacks_damaged_2", 1, 0)
	end
	if self:has_category_upgrade("player", "cocaine_stacks_damage_reduction_2") then
		damage_reduction = self:upgrade_value_by_level("player", "cocaine_stacks_damage_reduction_2", 1, 0)
		stack_damage = self:upgrade_value_by_level("player", "cocaine_stacks_damaged_2", 1, 0)
	elseif self:has_category_upgrade("player", "cocaine_stacks_damage_reduction_1") then
		damage_reduction = self:upgrade_value("player", "cocaine_stacks_damage_reduction_1", 0)
	end
	
	if amount > 0 then
		if self._damage_dealt_by_cops_prev < tweak_data.upgrades.max_cocaine_damage_per_tick then
			if self._damage_dealt_by_cops_prev + stack_damage > tweak_data.upgrades.max_cocaine_damage_per_tick then
				stack_damage = tweak_data.upgrades.max_cocaine_damage_per_tick - self._damage_dealt_by_cops_prev
			end
			amount = amount - stack_damage
			self._damage_dealt_by_cops_prev = self._damage_dealt_by_cops_prev + stack_damage
		end
		
		dmg = dmg * damage_reduction
		
		self:update_synced_cocaine_stacks_to_peers(amount, self:upgrade_value("player", "sync_cocaine_upgrade_level", 1), self:upgrade_level("player", "cocaine_stack_absorption_multiplier", 0))
	end
	return dmg
end

--Yakuza-------------------------------------------------------------------------------------------
function PlayerManager:active_shallow_grave()
	return self.shallow_grave
end

function PlayerManager:activate_shallow_grave()
	self:player_unit():sound():play("perkdeck_activate")
	self.shallow_grave = true
	self.shallow_grave_activate_t = TimerManager:game():time()
	self.shallow_grave_revive = false
	return 3.5
end

function PlayerManager:upd_shallow_grave()
	self.can_be_downed = self.can_be_downed or 1
	local is_downed = game_state_machine:verify_game_state(GameStateFilters.downed)
	local swan_song_active = managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier")
	local player = self:player_unit()
	
	if self.shallow_grave then
		if player then
			if player:character_damage():armor_ratio() == 1 then
				self.shallow_grave_revive = true
				self.shallow_grave = nil
				self.can_be_downed = 1
			end
			
			if self.shallow_grave_activate_t and (TimerManager:game():time() - self.shallow_grave_activate_t > 3.5) then
				if self.shallow_grave_revive then
					self.shallow_grave_revive = 0
				elseif is_downed or swan_song_active then
					--nothing
				elseif self.can_be_downed == 1 then
					player:character_damage():force_into_bleedout(true)
					self.can_be_downed = 0
				end
			end
		end
	end
end