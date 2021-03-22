local original_player_definitions = UpgradesTweakData._player_definitions

function UpgradesTweakData:_player_definitions(...)
	original_player_definitions(self, ...)
	
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
			0,
			7
		},
		7.5,
		30,
		15
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

	
	--Maniac---------------------------------------------------------------------------------------
	self.cocaine_stacks_convert_levels = {30, 25}
	self.cocaine_stacks_tick_t = 3
	self.max_cocaine_stacks_per_tick = 240
	self.max_cocaine_damage_per_tick = 240
	self.cocaine_stacks_decay_percentage_per_tick = 0.6
	self.cocaine_stacks_decay_amount_per_tick = 90
	self.cocaine_stacks_decay_t = 3
	self.cocaine_stacks_decay_trigger_t = 6
	self.max_total_cocaine_stacks = 600
	
	
	self.definitions.player_cocaine_stacks_damage_reduction_1 = {
		name_id = "menu_player_cocaine_stacks_damage_reduction_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "cocaine_stacks_damage_reduction_1",
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
	
	self.definitions.player_cocaine_stacks_damage_reduction_2 = {
		name_id = "menu_player_cocaine_stacks_damage_reduction_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "cocaine_stacks_damage_reduction_2",
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
	self.values.player.cocaine_stack_absorption_multiplier = {1.5}
	self.values.player.cocaine_stacks_damage_reduction_1 = {0.75}
	self.values.player.cocaine_stacks_damaged_1 = {80}
	self.values.player.cocaine_stacks_damage_reduction_2 = {0.65}
	self.values.player.cocaine_stacks_damaged_2 = {60}


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
end
