Hooks:Add("LocalizationManagerPostInit", "PDR Localization", function(loc)
	LocalizationManager:add_localized_strings({

        --Crew Chief-------------------------------------------------------------------------------
        ["menu_deck1_9_desc"] =     "You and your crew will gain ##6%## max health and ##12%## stamina for each hostage up to ##4## times.\n\n" ..
                                    "You and your crew will gain ##8%## damage reduction for having one or more hostages.\n\n" ..
                                    "You and your crew regenerate ##0.5%## health every ##5## seconds. You and your crew will regenerate an additional ##0.5%## health for each hostage up to ##4## times.\n\n" ..
                                    "Note: Crew perks do not stack.\n\n" ..
                                    "Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##.",


        --Muscle-----------------------------------------------------------------------------------
        ["menu_deck2_3_desc"] =     "You are ##35%## more likely to be targeted when you are close to your crew members.\n\n" ..
                                    "When you are within ##10## meters of a crew memeber, you recieve a ##35%## damage reduction that lasts ##7## seconds.\n\n" ..
                                    "You gain an additional ##10%## more health.",


        --Armorer----------------------------------------------------------------------------------
        ["menu_deck3_3_desc"] =     "You gain an additional ##10%## more armor.\n\n" ..
                                    "Damage you take exceeding ##60## is reduced by ##20%##. Damage exceeding ##300## is not reduced.",

        ["menu_deck3_5_desc"] =     "You gain an additional ##10%## more armor.\n\n" ..
                                    "Damage you take exceeding ##120## is reduced by an additional ##30%##. Damage exceeding ##300## is not reduced.",

        ["menu_deck3_9_desc"] =     "You gain an additional ##5%## more armor.\n\n" ..
                                    "Reduces the armor recovery time for you and your crew by ##10%##.\n\n" ..
                                    "Damage you take exceeding ##180## is reduced by an additional ##35%##. Damage exceeding ##300## is not reduced.\n\n" ..
                                    "Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##.",


        --Hitman-----------------------------------------------------------------------------------
        ["menu_deck5_1_desc"] =     "Your armor recovery rate is increased by ##10%##.",

        ["menu_deck5_5_desc"] =     "Your armor recovery rate is increased by ##10%##.\n\n" ..
                                    "Increases weapon swapping speed by ##80%##.",

        ["menu_deck5_7_desc"] =     "Your armor recovery rate is increased by ##10%##.\n\n" ..
                                    "You gain a ##25%## increased rate of fire with Akimbo weapons.",


        --Crook------------------------------------------------------------------------------------
        ["menu_deck6_3_desc"] =     "Your chance to dodge is increased by ##10%## for ballistic vests.\n\n" ..
                                    "Your armor is increased by ##20%## for ballistic vests.",

        ["menu_deck6_5_desc"] =     "Your chance to dodge is increased by an additional ##10%## for ballistic vests.\n\n" ..
                                    "Your armor is increased by an additional ##20%## for ballistic vests.",

        ["menu_deck6_7_desc"] =     "Your chance to dodge is increased by an additional ##10%## for ballistic vests.\n\n" ..
                                    "Your armor is increased by an additional ##25%## for ballistic vests.",


        --Burglar----------------------------------------------------------------------------------
        ["menu_deck7_1_desc"] =     "Your chance to dodge is increased by ##15%##.",

        ["menu_deck7_5_desc"] =     "Your chance to dodge is increased by an additional ##10%##.\n\n" ..
                                    "Your chance to be targeted while standing still and crouching is decreased by an additional ##5%##.\n\n" ..
                                    "You pick locks ##20%## faster.",

        ["menu_deck7_7_desc"] =     "Your chance to dodge is increased by an additional ##10%##.\n\n" ..
                                    "Your chance to be targeted while standing still and crouching is decreased by an additional ##5%##.\n\n" ..
                                    "You answer pagers ##10%## faster.",


        --Infiltrator------------------------------------------------------------------------------
        --[[ ["menu_deck8_3_desc"] =    "When you are within medium range of an enemy, you receive an additional ##8%## less damage from enemies.\n\n" ..
                                    "The OVERDOG melee buff duration is increased by ##6## seconds.", ]]


        --Gambler----------------------------------------------------------------------------------
        ["menu_deck10_1_desc"] = 	"Ammo packs you pick up also yield Medical Supplies.\n\n" ..
									"Medical Supplies:\n" ..
									"You are healed for ##16## to ##32## health when you pick up Medical Supplies. " ..
									"This is increased by ##20%## on the Gambler for every player that has more health than the Gambler. " ..
									"You cannot pick up Medical Supplies more than once every ##2.5## seconds.",

		["menu_deck10_3_desc"] = 	"Medical Supplies have ##25%## chance to trigger an ammo pickup for other players in your team.\n\n" ..
									"You gain ##20%## more health.",

        ["menu_deck10_5_desc"] = 	"Medical Supplies heal your teammates for ##50%## of the ammount.\n\n" ..
									"You gain ##20%## more health.",

		["menu_deck10_7"] = 		"More Healing",
		["menu_deck10_7_desc"] = 	"When Medical Supplies is on cooldown, picking up ammo heals you and your teammates for ##4## health.\n\n" ..
									"Picking up ammo grants you ##5## armor.",

        ["menu_deck10_9"] = 		"Just Lucky",
		["menu_deck10_9_desc"] = 	"Medical Supplies grant you ##1%## to ##7%## critical hit chance for ##7.5## seconds. " ..
									"This effect stacks. Getting three ##7%## critical bonuses in a row triggers Lucky.\n\n" ..
									"Lucky:\n" ..
									"You gain ##30%## critical hit chance for ##60## seconds. This effect overrides all other critical bonuses from Gambler.\n\n" ..
									"Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##.",


        --Yakuza-----------------------------------------------------------------------------------
		
		["menu_deck12_1_desc"] = 	"The lower your health, the more armor recovery rate you have. when your helth is below ##25%##, you will gain up to ##20%## armor recovery rate.\n\n" ..
                                    "Note: Entering this state negates third party regeneration effects.",

        ["menu_deck12_9_desc"] =    "All berserker state effects in this perk deck will start at ##50%## health instead of ##25%##.\n\n" ..
                                    "Shallow Grave:\n" ..
                                    "When you take lethal damage, you are instead left at ##1## health and are immune to damage for ##3.5## seconds. You are downed after the damage immunity ends unless your armor recovers. " ..
                                    "Shallow Grave only triggers while wearing a ballistic vest.\n\n" ..
                                    "Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##.",

        --Ex-President-----------------------------------------------------------------------------
        ["menu_deck13_5_desc"] =    "Increases the maximum health that can be stored by ##50%##.\n\n" ..
                                    "You gain ##10%## more health.\n\nYour chance to dodge is increased by ##25%##.",


        --Maniac-----------------------------------------------------------------------------------
        ["menu_deck14_1_desc"] =    "##100%## of damage you deal is converted into hysteria stacks, up to ##180## every ##3## seconds. Max amount of stacks is ##600##.\n\n" ..
                                    "Hysteria Stacks:\n" ..
                                    "You gain ##1## damage absorption for every ##30## stacks of Hysteria. Taking damage reduces Hysteria Stacks by ##7%## - this can only occur once every ##0.5## seconds. " ..
                                    "Hysteria Stacks decays ##50%## every ##3## seconds if you haven't dealt damage for ##6## seconds.\n\n" ..
                                    "Note: Damage from dots and sentry guns does not prevent decay.",

        ["menu_deck14_3_desc"] =    "Damage absorption from Hysteria Stacks on you is increased by ##50%##.\n\n" ..
                                    "Members of your crew gain the damage absorption effect of your Hysteria Stacks.\n\n" ..
                                    "Hysteria Stacks from multiple crew members do not stack and only the stacks that gives the highest damage absorption will have an affect.",

        ["menu_deck14_5_desc"] =    "While you have ##300## or more Hysteria Stacks, you interact ##33%## faster.\n\n" ..
                                    "Reduce the amount of Hysteria Stacks lost when taking damage to ##5%##.",

        ["menu_deck14_7_desc"] =    "Change the damage absorption of your Hysteria Stacks on you and your crew to ##1## absorption for every ##25## stacks of Hysteria.",

        ["menu_deck14_9_desc"] =    "While you have ##450## or more Hysteria Stacks, damage you take is reduced by ##25%## before absorption.\n\n" ..
                                    "Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##.",


        --Anarchist--------------------------------------------------------------------------------
        ["menu_deck15_9_desc"] =    "Dealing damage will grant you ##30## armor - this can only occur once every ##1.5## seconds.\n\n" ..
                                    "Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##.",


        --Biker------------------------------------------------------------------------------------
        ["menu_deck16_5_desc"] =    "Every ##10%## health missing will reduce the 4 second cooldown to kill regen by ##0.2## second.",

        ["menu_deck16_9_desc"] =    "Every ##10%## armor missing will reduce the 4 second cooldown to kill regen by ##0.2## second.\n\n" ..
                                    "Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##.",


        --Kingpin----------------------------------------------------------------------------------
        ["menu_deck17_1_desc"] =    "Unlocks and equips the Kingpin Injector.\n\n" ..
                                    "While in game you can use the throwable key to activate the Injector. Activating the Injector will heal you with ##75%## of all damage taken for ##6## seconds.\n\n" ..
                                    "You can still take damage during the effect. The Injector can only be used once every ##30## seconds. The cooldown is reduced by ##1## second per enemy killed.",

        --[[ ["menu_deck17_9_desc"] =   "You gain ##40%## more health.\n\n" ..
                                    "For every ##50## points of health gained during the Injector effect while at maximum health, the recharge time of the injector is reduced by ##1## second.\n\n" ..
                                    "Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##.", ]]


        --Sicario----------------------------------------------------------------------------------
        ["menu_deck18_1_desc"] =    "Unlocks and equips the thowable Smoke Bomb.\n\n" ..
                                    "When deployed, the smoke bomb createa a smoke screen that lasts ##10## seconds. " ..
                                    "While standing inside the smoke screen, you and any of your allies automatically avoid ##50%## of all bullets. " ..
                                    "Any enemies that stand in the smoke will see their accuracy reduced by ##50%##.\n\n" ..
                                    "You can carry up to ##2## smoke bombs. You replenish ##1## smoke bomb every ##45## seconds, this is lessened by ##1## second per enemy killed.",


        --Stoic------------------------------------------------------------------------------------
        ["menu_deck19_1_desc"] =    "Unlocks and equips the Stoic's Hip Flask.\n\n" ..
                                    "Damage is now reduced by ##75%##. The remaining damage will be applied directly.\n\n" ..
                                    "The ##75%## reduced damage will be applied over-time (##12## seconds) instead.\n\n" ..
                                    "You can use the throwable key to activate the Stoic Hip Flask and immediately negate any pending damage. " ..
                                    "The flask has a ##10## second cooldown but time remaining will be lessened by ##1## second per enemy killed.\n\n" ..
                                    "Note: Regeneration effects on you are reduced by ##25%##.",


        --Tag Team---------------------------------------------------------------------------------
        ["menu_deck20_1_desc"] =    "Unlocks and equips the Gas Dispenser.\n\n" ..
                                    "To activate the Gas Dispenser you need to look at another allied unit within a ##18## meter radius with clear line of sight and press the throwable key to tag them.\n\n" ..
                                    "Each enemy you or the tagged unit kills will now heal you for ##15## health and the tagged unit for ##7.5## health.\n\n" ..
                                    "Each enemy you kill will now extend the duration by ##1.3## seconds and reduce the cooldown timer by ##2## seconds.\n\n" ..
                                    "The effect will last for a duration of ##12## seconds and has a cooldown of ##60## seconds.",


        --Hacker-----------------------------------------------------------------------------------
        ["menu_deck21_1_desc"] =    "Unlocks and equips the Pocket ECM.\n\n" ..
                                    "While in game you can use the throwable key to activate the Pocket ECM Device.\n\n" ..
                                    "Activating the Pocket ECM Device before the alarm is raised will trigger the jamming effect, disabling all electronics and pagers for a ##6## second duration.\n\n" ..
                                    "Activating the Pocket ECM Device after the alarm is raised will trigger the feedback effect, granting a chance to stun enemies on the map every second for a ##6## second duration.\n\n" ..
                                    "The Pocket ECM Device has ##2## charges with a ##100## second cooldown timer, but each kill you perform will shorten the cooldown timer by ##6## seconds.",

		["menu_deck21_5_desc"] =    "Killing an enemy while the feedback effect is active will regenerate ##20## health.\n\n" ..
                                    "Your chance to dodge is increased by ##15%##.",

		["menu_deck21_9_desc"] =    "Crew members killing enemies while the feedback effect is active will regenerate ##10## health.\n\n" ..
                                    "Your chance to dodge is increased by an additional ##15%##.\n\n" ..
                                    "Deck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##."
    })
end)
