Hooks:PostHook(SkillTreeTweakData, "init", "PDR SkillTreeTweakData itit", function(self)

	--Crew Chief
	table.insert(self.specializations[1][9].upgrades, "team_hsituation_health_regen")

	--Muscle
	table.insert(self.specializations[2][3].upgrades, "player_meat_shield_dmg_dampener")
	
	--Armorer
	table.insert(self.specializations[3][3].upgrades, "player_armorer_damage_reduction_1")
	table.insert(self.specializations[3][5].upgrades, "player_armorer_damage_reduction_2")
	table.insert(self.specializations[3][9].upgrades, "player_armorer_damage_reduction_3")
	
	table.insert(self.specializations[3][3].upgrades, "player_armorer_damage_reduction_threshold_1")
	table.insert(self.specializations[3][5].upgrades, "player_armorer_damage_reduction_threshold_2")
	table.insert(self.specializations[3][9].upgrades, "player_armorer_damage_reduction_threshold_3")
	
	--Gambler
	table.remove(self.specializations[10][7].upgrades, 1)
	table.insert(self.specializations[10][7].upgrades, "player_loose_ammo_restore_health_alt")
	table.insert(self.specializations[10][7].upgrades, "player_loose_ammo_restore_armor")
	table.remove(self.specializations[10][9].upgrades, 1)
	table.insert(self.specializations[10][9].upgrades, "temporary_loose_ammo_crit_bonus")
	
	--Yakuza
	table.insert(self.specializations[12][9].upgrades, "temporary_shallow_grave")
	
	--Ex-President
	table.remove(self.specializations[13][5].upgrades, 3)
	table.insert(self.specializations[13][5].upgrades, "player_president_dodge_chance")
	
	--Maniac
	table.insert(self.specializations[14][1].upgrades, "player_cocaine_stacks_damaged_1")
	table.insert(self.specializations[14][3].upgrades, "player_cocaine_stacks_damage_reduction_1")
	table.remove(self.specializations[14][5].upgrades, 1)
	table.insert(self.specializations[14][5].upgrades, "player_cocaine_stacks_damaged_2")
	table.insert(self.specializations[14][7].upgrades, "player_cocaine_stacks_damage_reduction_2")
	
	--Stoic
	table.insert(self.specializations[19][1].upgrades, "player_damage_control_reduced_regen")
end)