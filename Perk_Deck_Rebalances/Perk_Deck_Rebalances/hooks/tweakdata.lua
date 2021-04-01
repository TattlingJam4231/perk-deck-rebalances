if not pdr_tweakstats then
	if not tweak_data then return end

    tweak_data.blackmarket.projectiles.smoke_screen_grenade = {
		name_id = "bm_grenade_smoke_screen_grenade",
		desc_id = "bm_grenade_smoke_screen_grenade_desc",
		unit = "units/pd2_dlc_max/weapons/wpn_fps_smoke_screen_grenade/wpn_third_smoke_screen_grenade",
		unit_dummy = "units/pd2_dlc_max/weapons/wpn_fps_smoke_screen_grenade/wpn_fps_smoke_screen_grenade_husk",
		sprint_unit = "units/pd2_dlc_max/weapons/wpn_fps_smoke_screen_grenade/wpn_third_smoke_screen_grenade_sprint",
		icon = "smoke_screen_grenade",
		texture_bundle_folder = "max",
		base_cooldown = 45,
		max_amount = 2,
		is_a_grenade = true,
		throwable = true,
		animation = "throw_grenade_com",
		anim_global_param = "projectile_frag_com",
		no_shouting = true
	}

	pdr_tweakstats = true
end