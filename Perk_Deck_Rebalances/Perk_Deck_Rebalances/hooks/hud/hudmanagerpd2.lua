function HUDManager:pdr_activate_teammate_ability_radial(i, icon, time_left, time_total)
	self._teammate_panels[i]:activate_ability_radial(time_left, time_total)
    self._teammate_panels[i]:pdr_set_ability_icon(icon[1], icon[2])
end