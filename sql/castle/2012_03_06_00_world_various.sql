-- fix looting Sample of Rockflesh from Ravaged Crystalline Ice Giant, closes #206
SET @npc := 26809; -- Ravaged Crystalline Ice Giant
SET @item := 36765; -- Sample of Rockflesh

UPDATE `creature_template` SET `npcflag` = `npcflag`|1, `AIName`='SmartAI' WHERE `entry`=@npc;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 26809 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@npc, 0, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 56, @item, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravaged Crystalline Ice Giant - On Gossip Hello create Sample of Rockflesh'),
(@npc, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ravaged Crystalline Ice Giant - On Gossip Hello Instant Kill');

-- remove erroneous item drops from Twilight Apostle (AhnKahet)
DELETE FROM `creature_loot_template` WHERE `entry` = 31471 AND `item` IN (44686, 44663);

-- fix emote castback for send them packing, closes #531
SET @npc := 23977; -- Abandoned Pack Mules
SET @spell := 42721; -- Send Them Packing: On Successful Dummy Spell Kill Credit

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@npc;

DELETE FROM `smart_scripts` WHERE `entryorguid` = @npc AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@npc, 0, 0, 1, 22, 0, 100, 1, 125, 0, 0, 0, 11, @spell, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Abandoned Pack Mules - On /Raise Quest Credit Send The Packing'),
(@npc, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Abandoned Pack Mules - Despawn after Quest Credit');

-- fix kill credit cast back on spellhit for mission: eternal flame, closes #526, #529
SET @spell := 42564; -- Ever-burning Torches

SET @credit1 := 42632;
SET @credit2 := 42633;
SET @credit3 := 42634;
SET @credit4 := 42635;

SET @bunny1 := 23921;
SET @bunny2 := 23922;
SET @bunny3 := 23923;
SET @bunny4 := 23924;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@bunny1, @bunny2, @bunny3, @bunny4);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@bunny1, @bunny2, @bunny3, @bunny4) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@bunny1, 0, 0, 0, 8, 0, 100, 0, @spell, 0, 0, 0, 11, @credit1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mission: Eternal Flame - On Spell Hit Credit 1'),
(@bunny2, 0, 0, 0, 8, 0, 100, 0, @spell, 0, 0, 0, 11, @credit2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mission: Eternal Flame - On Spell Hit Credit 2'),
(@bunny3, 0, 0, 0, 8, 0, 100, 0, @spell, 0, 0, 0, 11, @credit3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mission: Eternal Flame - On Spell Hit Credit 3'),
(@bunny4, 0, 0, 0, 8, 0, 100, 0, @spell, 0, 0, 0, 11, @credit4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mission: Eternal Flame - On Spell Hit Credit 4');

-- fix quest drop for All Things in Good Time (Daily HC) in Ahnkahet
DELETE FROM `creature_loot_template` WHERE entry = 31104 AND item = 43494;
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(31104, 43494, -100, 1, 0, 1, 1); -- Ahn'kahar Watcher's Corpse
