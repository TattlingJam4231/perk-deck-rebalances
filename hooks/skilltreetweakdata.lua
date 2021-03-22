local original_init = SkillTreeTweakData.init

function SkillTreeTweakData:init(...)
	original_init(self, ...)
	
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
	
	--Gambler
	table.insert(self.specializations[12][9].upgrades, "temporary_shallow_grave")
	
	--Maniac
	table.insert(self.specializations[14][1].upgrades, "player_cocaine_stacks_damaged_1")
	table.insert(self.specializations[14][3].upgrades, "player_cocaine_stacks_damage_reduction_1")
	table.remove(self.specializations[14][5].upgrades, 1)
	table.insert(self.specializations[14][5].upgrades, "player_cocaine_stacks_damaged_2")
	table.insert(self.specializations[14][7].upgrades, "player_cocaine_stacks_damage_reduction_2")
end