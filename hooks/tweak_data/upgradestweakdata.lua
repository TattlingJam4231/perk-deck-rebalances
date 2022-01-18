Hooks:PostHook(UpgradesTweakData, "init", "PDR UpgradesTweakData init", function(self)

	--Crew Chief-----------------------------------------------------------------------------------
	self.definitions.team_hsituation_health_regen = {
		name_id = "menu_team_hsituation_health_regen",
		category = "team",
		upgrade = {
			value = 1,
			upgrade = "hsituation_health_regen",
			category = "health_regen"
		}
	}
	self.values.team.health_regen = self.values.team.health_regen or {}
	self.values.team.health_regen.hsituation_health_regen = {0.005}

	--Muscle---------------------------------------------------------------------------------------
	self.definitions.player_meat_shield_dmg_dampener = {
		name_id = "menu_player_meat_shield_dmg_dampener",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "meat_shield_dmg_dampener",
			category = "temporary"
		}
	}
	self.values.temporary.meat_shield_dmg_dampener = {
		{
			0.65,
			7
		}
	}
	self.values.player.uncover_multiplier = {1.35}

	--Armorer--------------------------------------------------------------------------------------
	self.definitions.player_armorer_damage_reduction_1 = {
		name_id = "menu_player_armorer_damage_reduction_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "armorer_damage_reduction_1",
			category = "player"
		}
	}
	self.definitions.player_armorer_damage_reduction_2 = {
		name_id = "menu_player_armorer_damage_reduction_2",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "armorer_damage_reduction_2",
			category = "player"
		}
	}
	self.definitions.player_armorer_damage_reduction_3 = {
		name_id = "menu_player_armorer_damage_reduction_3",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "armorer_damage_reduction_3",
			category = "player"
		}
	}
	self.values.player.armorer_damage_reduction_1 = {0.8}
	self.values.player.armorer_damage_reduction_2 = {0.5}
	self.values.player.armorer_damage_reduction_3 = {0.15}
	
	self.definitions.player_armorer_damage_reduction_threshold_1 = {
		name_id = "menu_player_armorer_damage_reduction_threshold_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "armorer_damage_reduction_threshold_1",
			category = "player"
		}
	}
	self.definitions.player_armorer_damage_reduction_threshold_2 = {
		name_id = "menu_player_armorer_damage_reduction_threshold_2",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "armorer_damage_reduction_threshold_2",
			category = "player"
		}
	}
	self.definitions.player_armorer_damage_reduction_threshold_3 = {
		name_id = "menu_player_armorer_damage_reduction_threshold_3",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "armorer_damage_reduction_threshold_3",
			category = "player"
		}
	}
	self.values.player.armorer_damage_reduction_threshold_1 = {5.0}
	self.values.player.armorer_damage_reduction_threshold_2 = {10.0}
	self.values.player.armorer_damage_reduction_threshold_3 = {15.0}
	
	
	--Crook----------------------------------------------------------------------------------------
	self.values.player.level_2_dodge_addend = {
		0.1,
		0.20,
		0.30
	}
	self.values.player.level_3_dodge_addend = {
		0.1,
		0.20,
		0.30
	}
	self.values.player.level_4_dodge_addend = {
		0.1,
		0.20,
		0.30
	}
	
	
	--Hitman----------------------------------------------------------------------------------------
	self.values.player.perk_armor_regen_timer_multiplier = {
		0.90,
		0.80,
		0.70,
		0.60,
		0.50
	}
	
	self.definitions.akimbo_fire_rate_multiplier = {
		name_id = "menu_akimbo_fire_rate_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "fire_rate_multiplier",
			category = "akimbo"
		}
	}
	self.values.akimbo.fire_rate_multiplier = {1.25}


	--Burglar--------------------------------------------------------------------------------------
	self.values.player.tier_dodge_chance = {
		0.15,
		0.25,
		0.35
	}


	--Gambler--------------------------------------------------------------------------------------
	self.definitions.player_loose_ammo_restore_health_alt = {
		name_id = "menu_player_loose_ammo_restore_health_alt",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "loose_ammo_restore_health_alt",
			category = "player"
		}
	}
	self.definitions.player_loose_ammo_restore_armor = {
		name_id = "menu_player_loose_ammo_restore_armor",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "loose_ammo_restore_armor",
			category = "player"
		}
	}
	self.definitions.temporary_loose_ammo_crit_bonus = {
		name_id = "menu_temporary_loose_ammo_crit_bonus",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "loose_ammo_crit_bonus",
			category = "temporary"
		}
	}
	
	self.loose_ammo_restore_health_values = {
		{
			0,
			4
		},
		{
			4,
			8
		},
		{
			8,
			12
		},
		multiplier = 0.1,
		cd = 2.5,
		base = 8
	}
	self.values.temporary.loose_ammo_restore_health = {}
	for i, data in ipairs(self.loose_ammo_restore_health_values) do
		local base = self.loose_ammo_restore_health_values.base

		table.insert(self.values.temporary.loose_ammo_restore_health, {
			{
				8,
				16
			},
			self.loose_ammo_restore_health_values.cd
		})
	end
		
	self.loose_ammo_give_team_health_ratio = 1
	self.loose_ammo_give_team_ratio = 0.25
	self.values.temporary.loose_ammo_give_team = {
		{
			true,
			2.5
		}
	}
	self.values.player.loose_ammo_restore_health_alt = {4}
	self.values.player.loose_ammo_restore_armor = {5}
	self.values.temporary.loose_ammo_crit_bonus = {
		{
			1,
			7
		},
		7.5,
		30,
		60
	}


	--Yakuza--------------------------------------------------------------------------------------
	self.definitions.temporary_shallow_grave = {
		name_id = "menu_temporary_shallow_grave",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "shallow_grave",
			category = "temporary"
		}
	}
	self.values.temporary.shallow_grave = {}


	--Ex-President---------------------------------------------------------------------------------
	self.definitions.player_president_dodge_chance = {
		name_id = "menu_player_president_dodge_chance",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "president_dodge_chance",
			category = "player"
		}
	}
	self.values.player.president_dodge_chance = {0.25}

	
	--Maniac---------------------------------------------------------------------------------------
	self.cocaine_stacks_convert_levels = {30, 25}
	self.cocaine_stacks_tick_t = 3
	self.max_cocaine_stacks_per_tick = 180
	self.cocaine_stacks_decay_percentage_per_tick = 0.5
	self.cocaine_stacks_decay_amount_per_tick = 0
	self.cocaine_stacks_decay_t = 3
	self.cocaine_stacks_decay_trigger_t = 9
	self.max_total_cocaine_stacks = 600
	
	
	self.definitions.player_cocaine_stacks_damage_reduction = {
		name_id = "menu_player_cocaine_stacks_damage_reduction",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "cocaine_stacks_damage_reduction",
			category = "player"
		}
	}
	self.definitions.player_cocaine_stacks_damaged_1 = {
		name_id = "menu_player_cocaine_stacks_damaged_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "cocaine_stacks_damaged_1",
			category = "player"
		}
	}
	self.definitions.player_cocaine_stacks_damaged_2 = {
		name_id = "menu_player_cocaine_stacks_damaged_2",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "cocaine_stacks_damaged_2",
			category = "player"
		}
	}
	self.definitions.player_cocaine_stacks_interaction_speed = {
		name_id = "menu_player_cocaine_stacks_interaction_speed",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "cocaine_stacks_interaction_speed",
			category = "player"
		}
	}
	self.values.player.cocaine_stack_absorption_multiplier = {1.5}
	self.values.player.cocaine_stacks_damage_reduction = {0.65}
	self.values.player.cocaine_stacks_dr_threshold = {450}
	self.values.player.cocaine_stacks_damaged_1 = {0.07}
	self.values.player.cocaine_stacks_damaged_2 = {0.05}
	self.values.player.cocaine_stacks_damaged_cooldown = {0.5}
	self.values.player.cocaine_stacks_interaction_speed = {0.67}


	--Biker----------------------------------------------------------------------------------------
	self.values.player.less_health_wild_cooldown = {
		{
			0.1,
			0.2
		}
	}
	self.values.player.less_armor_cooldown = {
		{
			0.1,
			0.2
		}
	}


	--Kingpin--------------------------------------------------------------------------------------
	self.values.player.chico_injector_health_to_speed = {
		{
			0.5,
			1
		}
	}


	--Sicario--------------------------------------------------------------------------------------
	self.values.player.dodge_shot_gain = {
		{
			0.2,
			4
		}
	}


	--Stoic--------------------------------------------------------------------------------------
	self.definitions.player_damage_control_reduced_regen = {
		name_id = "menu_player_damage_control_reduced_regen",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "damage_control_reduced_regen",
			category = "player"
		}
	}
	self.values.player.damage_control_reduced_regen = {0.75}
end)