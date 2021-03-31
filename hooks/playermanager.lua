Hooks:PostHook(PlayerManager, "update", "PDR PlayerManager update", function(self)
	--Yakuza---------------------------------------------------------------------------------------
	self:upd_shallow_grave()
	--Yakuza---------------------------------------------------------------------------------------
end)

function PlayerManager:check_skills()
	self:send_message_now("check_skills")
	self._coroutine_mgr:clear()

	self._saw_panic_when_kill = self:has_category_upgrade("saw", "panic_when_kill")
	self._unseen_strike = self:has_category_upgrade("player", "unseen_increased_crit_chance")

	if self:has_category_upgrade("pistol", "stacked_accuracy_bonus") then
		self._message_system:register(Message.OnEnemyShot, self, callback(self, self, "_on_expert_handling_event"))
	else
		self._message_system:unregister(Message.OnEnemyShot, self)
	end

	if self:has_category_upgrade("pistol", "stacking_hit_damage_multiplier") then
		self._message_system:register(Message.OnEnemyShot, "trigger_happy", callback(self, self, "_on_enter_trigger_happy_event"))
	else
		self._message_system:unregister(Message.OnEnemyShot, "trigger_happy")
	end

	if self:has_category_upgrade("player", "melee_damage_stacking") then
		local function start_bloodthirst_base(weapon_unit, variant)
			if variant ~= "melee" and not self._coroutine_mgr:is_running(PlayerAction.BloodthirstBase) then
				local data = self:upgrade_value("player", "melee_damage_stacking", nil)

				if data and type(data) ~= "number" then
					self._coroutine_mgr:add_coroutine(PlayerAction.BloodthirstBase, PlayerAction.BloodthirstBase, self, data.melee_multiplier, data.max_multiplier)
				end
			end
		end

		self._message_system:register(Message.OnEnemyKilled, "bloodthirst_base", start_bloodthirst_base)
	else
		self._message_system:unregister(Message.OnEnemyKilled, "bloodthirst_base")
	end

	if self:has_category_upgrade("player", "messiah_revive_from_bleed_out") then
		self._messiah_charges = self:upgrade_value("player", "messiah_revive_from_bleed_out", 0)
		self._max_messiah_charges = self._messiah_charges

		self._message_system:register(Message.OnEnemyKilled, "messiah_revive_from_bleed_out", callback(self, self, "_on_messiah_event"))
	else
		self._messiah_charges = 0
		self._max_messiah_charges = self._messiah_charges

		self._message_system:unregister(Message.OnEnemyKilled, "messiah_revive_from_bleed_out")
	end

	if self:has_category_upgrade("player", "recharge_messiah") then
		self._message_system:register(Message.OnDoctorBagUsed, "recharge_messiah", callback(self, self, "_on_messiah_recharge_event"))
	else
		self._message_system:unregister(Message.OnDoctorBagUsed, "recharge_messiah")
	end

	if self:has_category_upgrade("player", "double_drop") then
		self._target_kills = self:upgrade_value("player", "double_drop", 0)

		self._message_system:register(Message.OnEnemyKilled, "double_ammo_drop", callback(self, self, "_on_spawn_extra_ammo_event"))
	else
		self._target_kills = 0

		self._message_system:unregister(Message.OnEnemyKilled, "double_ammo_drop")
	end

	if self:has_category_upgrade("temporary", "single_shot_fast_reload") then
		self._message_system:register(Message.OnLethalHeadShot, "activate_aggressive_reload", callback(self, self, "_on_activate_aggressive_reload_event"))
	else
		self._message_system:unregister(Message.OnLethalHeadShot, "activate_aggressive_reload")
	end

	if self:has_category_upgrade("player", "head_shot_ammo_return") then
		self._ammo_efficiency = self:upgrade_value("player", "head_shot_ammo_return", nil)

		self._message_system:register(Message.OnHeadShot, "ammo_efficiency", callback(self, self, "_on_enter_ammo_efficiency_event"))
	else
		self._ammo_efficiency = nil

		self._message_system:unregister(Message.OnHeadShot, "ammo_efficiency")
	end

	if self:has_category_upgrade("player", "melee_kill_increase_reload_speed") then
		self._message_system:register(Message.OnEnemyKilled, "bloodthirst_reload_speed", callback(self, self, "_on_enemy_killed_bloodthirst"))
	else
		self._message_system:unregister(Message.OnEnemyKilled, "bloodthirst_reload_speed")
	end

	if self:has_category_upgrade("player", "super_syndrome") then
		self._super_syndrome_count = self:upgrade_value("player", "super_syndrome")
	else
		self._super_syndrome_count = 0
	end


	--Sicario--------------------------------------------------------------------------------------
	if self:has_category_upgrade("player", "dodge_shot_gain") then
		local last_dodge_time = 0
		local dodge_gain = self:upgrade_value("player", "dodge_shot_gain")[1]
		local cooldown = self:upgrade_value("player", "dodge_shot_gain")[2]

		local function on_player_damage(attack_data)
			if attack_data.variant == "bullet" then
				managers.player:_dodge_shot_gain(managers.player:_dodge_shot_gain() + dodge_gain)
			end
		end

		self:register_message(Message.OnPlayerDodge, "dodge_shot_gain_dodge", callback(self, self, "_dodge_shot_gain", 0))
		self:register_message(Message.OnPlayerDamage, "dodge_shot_gain_damage", on_player_damage)
	else
		self:unregister_message(Message.OnPlayerDodge, "dodge_shot_gain_dodge")
		self:unregister_message(Message.OnPlayerDamage, "dodge_shot_gain_damage")
	end

	if self:has_category_upgrade("player", "dodge_replenish_armor") then
		self:register_message(Message.OnPlayerDodge, "dodge_replenish_armor", callback(self, self, "_dodge_replenish_armor"))
	else
		self:unregister_message(Message.OnPlayerDodge, "dodge_replenish_armor")
	end

	if managers.blackmarket:equipped_grenade() == "smoke_screen_grenade" then
		local function speed_up_on_kill()
			managers.player:speed_up_grenade_cooldown(1)
		end

		self:register_message(Message.OnEnemyKilled, "speed_up_smoke_grenade", speed_up_on_kill)
	else
		self:unregister_message(Message.OnEnemyKilled, "speed_up_smoke_grenade")
	end
	--Sicario--------------------------------------------------------------------------------------



	self:add_coroutine("damage_control", PlayerAction.DamageControl)

	if self:has_category_upgrade("snp", "graze_damage") then
		self:register_message(Message.OnWeaponFired, "graze_damage", callback(SniperGrazeDamage, SniperGrazeDamage, "on_weapon_fired"))
	else
		self:unregister_message(Message.OnWeaponFired, "graze_damage")
	end
end

original_function = PlayerManager.critical_hit_chance
function PlayerManager:critical_hit_chance(detection_risk)
	local multiplier = original_function(self, detection_risk)

	--Gambler--------------------------------------------------------------------------------------
	if self:has_category_upgrade("temporary", "loose_ammo_crit_bonus") then
		multiplier = multiplier + managers.player:get_gambler_crit_bonus()
	end
	--Gambler--------------------------------------------------------------------------------------

	return multiplier
end

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

function PlayerManager:health_regen()
	local health_regen = tweak_data.player.damage.HEALTH_REGEN


	--Crew Chief-----------------------------------------------------------------------------------
	health_regen = health_regen + self:get_crew_chief_addend()
	--Crew Chief-----------------------------------------------------------------------------------

	health_regen = health_regen + self:temporary_upgrade_value("temporary", "wolverine_health_regen", 0)
	health_regen = health_regen + self:get_hostage_bonus_addend("health_regen")
	health_regen = health_regen + self:upgrade_value("player", "passive_health_regen", 0)

	return health_regen
end

function PlayerManager:damage_reduction_skill_multiplier(damage_type)
	local multiplier = 1


	--Muscle---------------------------------------------------------------------------------------
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "meat_shield_dmg_dampener", 1)
	--Muscle---------------------------------------------------------------------------------------


	multiplier = multiplier * self:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered_strong", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "dmg_dampener_close_contact", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "revived_damage_resist", 1)
	multiplier = multiplier * self:upgrade_value("player", "damage_dampener", 1)
	multiplier = multiplier * self:upgrade_value("player", "health_damage_reduction", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "first_aid_damage_reduction", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "revive_damage_reduction", 1)
	multiplier = multiplier * self:get_hostage_bonus_multiplier("damage_dampener")
	multiplier = multiplier * self._properties:get_property("revive_damage_reduction", 1)
	multiplier = multiplier * self._temporary_properties:get_property("revived_damage_reduction", 1)
	local dmg_red_mul = self:team_upgrade_value("damage_dampener", "team_damage_reduction", 1)

	if self:has_category_upgrade("player", "passive_damage_reduction") then
		local health_ratio = self:player_unit():character_damage():health_ratio()
		local min_ratio = self:upgrade_value("player", "passive_damage_reduction")

		if health_ratio < min_ratio then
			dmg_red_mul = dmg_red_mul - (1 - dmg_red_mul)
		end
	end

	multiplier = multiplier * dmg_red_mul

	if damage_type == "melee" then
		multiplier = multiplier * managers.player:upgrade_value("player", "melee_damage_dampener", 1)
	end

	local current_state = self:get_current_state()

	if current_state and current_state:_interacting() then
		multiplier = multiplier * managers.player:upgrade_value("player", "interacting_damage_multiplier", 1)
	end

	return multiplier
end

function PlayerManager:skill_dodge_chance(running, crouching, on_zipline, override_armor, detection_risk)
	local chance = self:upgrade_value("player", "passive_dodge_chance", 0)
	local dodge_shot_gain = self:_dodge_shot_gain()

	for _, smoke_screen in ipairs(self._smoke_screen_effects or {}) do
		if smoke_screen:is_in_smoke(self:player_unit()) then
			if smoke_screen:mine() then
				chance = chance * self:upgrade_value("player", "sicario_multiplier", 1)
				dodge_shot_gain = dodge_shot_gain * self:upgrade_value("player", "sicario_multiplier", 1)
			else
				chance = chance + smoke_screen:dodge_bonus()
			end
		end
	end

	chance = chance + dodge_shot_gain
	chance = chance + self:upgrade_value("player", "tier_dodge_chance", 0)


	--Ex-President---------------------------------------------------------------------------------
	chance = chance + self:upgrade_value("player", "president_dodge_chance", 0)
	--Ex-President---------------------------------------------------------------------------------



	if running then
		chance = chance + self:upgrade_value("player", "run_dodge_chance", 0)
	end

	if crouching then
		chance = chance + self:upgrade_value("player", "crouch_dodge_chance", 0)
	end

	if on_zipline then
		chance = chance + self:upgrade_value("player", "on_zipline_dodge_chance", 0)
	end

	local detection_risk_add_dodge_chance = managers.player:upgrade_value("player", "detection_risk_add_dodge_chance")
	chance = chance + self:get_value_from_risk_upgrade(detection_risk_add_dodge_chance, detection_risk)
	chance = chance + self:upgrade_value("player", tostring(override_armor or managers.blackmarket:equipped_armor(true, true)) .. "_dodge_addend", 0)
	chance = chance + self:upgrade_value("team", "crew_add_dodge", 0)
	chance = chance + self:temporary_upgrade_value("temporary", "pocket_ecm_kill_dodge", 0)

	return chance
end

--Crew Chief---------------------------------------------------------------------------------------
function PlayerManager:get_crew_chief_addend()
	local health_regen = 0
	local hostages = managers.groupai and managers.groupai:state():hostage_count() or 0
	local minions = self:num_local_minions() or 0
	hostages = math.min(hostages + minions, 4)
	local addend = self:team_upgrade_value("health_regen", "hsituation_health_regen")

	health_regen = health_regen + (addend * (1 + hostages))

	return health_regen
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
	return self._shallow_grave
end

function PlayerManager:activate_shallow_grave()
	local player = self:player_unit()
	player:sound():play("perkdeck_activate")
	player:character_damage():set_health(0.1)
	-- player:character_damage():set_invulnerable(true)
	self._shallow_grave = true
	self.shallow_grave_activate_t = TimerManager:game():time()
	self._shallow_grave_revive = false
	local icon = {"guis/textures/pd2/specialization/icons_atlas", {128, 448, 64, 64}--[[ {16, 464, 33, 33} ]]}
	managers.hud:pdr_activate_teammate_ability_radial(HUDManager.PLAYER_PANEL, icon, 3.5)

	return 3.5
end

function PlayerManager:deactivate_shallow_grave()
	self._shallow_grave = nil
	self.shallow_grave_activate_t = nil
	managers.hud:activate_teammate_ability_radial(HUDManager.PLAYER_PANEL, 0)
end

function PlayerManager:shallow_grave_revive()
	if self._shallow_grave_revive then
		self:deactivate_shallow_grave()
	else
		local player = self:player_unit()
		if not player:character_damage():is_downed() then
			self:player_unit():character_damage():force_into_bleedout(true)
		end
		self:deactivate_shallow_grave()
	end
end

function PlayerManager:activate_shallow_grave_revive()
	self._shallow_grave_revive = true
end

function PlayerManager:upd_shallow_grave()
	local player = self:player_unit()
	if player and player:character_damage():is_downed() then
		self:deactivate_shallow_grave()
		return
	end
	if self._shallow_grave and self.shallow_grave_activate_t and (TimerManager:game():time() - self.shallow_grave_activate_t > 3.5) then
		-- self:player_unit():character_damage():set_invulnerable(false)
		self:shallow_grave_revive()
	end
end


--Sicario-------------------------------------------------------------------------------------------
function PlayerManager:_dodge_shot_gain(gain_value)
	self.last_dodge_time = self.last_dodge_time or 0
	local cooldown = self:upgrade_value("player", "dodge_shot_gain")[2]
	local t = TimerManager:game():time()

	if gain_value and gain_value == 0 then
		self._dodge_shot_gain_value = 0
		self.last_dodge_time = t
	elseif gain_value and t > self.last_dodge_time + cooldown then
		self._dodge_shot_gain_value = gain_value
	else
		return self._dodge_shot_gain_value or 0
	end
end