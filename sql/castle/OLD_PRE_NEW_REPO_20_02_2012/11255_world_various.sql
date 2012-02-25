-- Updates creature_loot_template
	-- Formula: Enchant 2H Weapon - Savagery
	-- See http://old.wowhead.com/item=22554
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 10 WHERE `item` = 22554;

	-- Formula: Enchant 2H Weapon - Major Intellect
	-- See http://old.wowhead.com/item=16249
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 8 WHERE `item` = 16249;

	-- Raging Skeleton
	-- fix incomplete loot-table for nh+hc
	-- Droprate taken from http://old.wowhead.com/npc=18521#drops
	SET @nh := 18521;
	SET @hc := 20315;

	DELETE FROM `creature_loot_template` WHERE `entry` IN (@nh, @hc);
	INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
	-- non heroic
	(@nh, 21877,  50, 1, 0, 1, 3), -- Netherweave Cloth
	(@nh, 22544,   8, 1, 0, 1, 1), -- Formula: Enchant Boots - Dexterity
	(@nh, 27859,   6, 1, 0, 1, 1), -- Zangar Caps
	(@nh, 27860,   3, 1, 0, 1, 1), -- Purified Draenic Water
	(@nh, 14047,   5, 1, 0, 1, 3), -- Runecloth
	(@nh, 25373, 1.4, 1, 0, 1, 1), -- Corroded Mail Armor
	-- heroic 
	(@hc, 21877, 41, 1, 0, 1, 3),
	(@hc, 22544, 16, 1, 0, 1, 1),
	(@hc, 27859,  7, 1, 0, 1, 1),
	(@hc, 27860,  3, 1, 0, 1, 1);

-- Updates creature_template
	-- allow diseases (MECHANIC_INFECTED = 2097152) for burning crusade raids
	UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 2097152 WHERE `entry` IN
	( 
		(SELECT DISTINCT id FROM `creature` WHERE map IN
			(544, -- magtherion (t4)
			 565, -- gruul (t4)
			 532, -- karazhan (t4)
			 548, -- ssc (t5)
			 550, -- the eye (t5)
			 534, -- hyjal (t6)
			 564, -- bt (t6)
			 580 -- sunwell (t6) for the troll *_* 
			)
		)
	);
	UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 2097152 WHERE `entry` IN (17808,17842,17888,17767,17898,17905,17897,17916,17907,17906,17895,17908,17864,17899,17902,17903,17818); -- hyjal summit

-- Updates creature
	-- Move Malygos (EoE) to his original position, corresponding to TDB46.
	DELETE FROM `creature` WHERE `id` = 28859 AND `map`=616;
	INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (132313, 28859, 616, 3, 1, 26752, 0, 808.535, 1213.55, 295.972, 3.22503, 604800, 5, 0, 6972500, 212900, 1, 0, 0, 0);

-- Updates achievement_criteria_data
	-- Maiden of Grief (Halls of Stone)
	-- Add missing criteria data, corresponding with the script and similar achievements from other bosses (like Patchwork).
	-- The time-event is handled by the core, thus, we do not need to handle it manually.

	-- Delete, if still present (seems to be not).
	DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 7143;
	-- Add criteria data.
	INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (7143, 12, 1, 0, '');

-- Updates disable
	-- Remove disable, see achievement above.
	DELETE FROM `disables` WHERE `sourceType` = 4 AND `entry` = 7143;
	
-- Updates spell_group
	-- Vigilance (50720)
	-- Renewed Hope (57470, 57472) spell_rank exists!
	-- Blessing of Sanctuary (20911, 25899) [in itself exclusive]
	SET @group := 1117;
	DELETE FROM `spell_group` WHERE `id` = @group;
	INSERT INTO `spell_group` (`id`, `spell_id`) VALUES 
	(@group, 50720), -- vigilance
	(@group, 57470), -- renewed hope
	(@group, -1007); -- blessing of sanctuary

-- Updates spell_group_stack_rules
	DELETE FROM `spell_group_stack_rules` WHERE `group_id` = @group;
	INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
	(@group, 3);