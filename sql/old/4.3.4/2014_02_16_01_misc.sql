
-- un'goro Crater

-- npc has zero values
update creature_template set faction_A=7,faction_H=7,minlevel=90,maxlevel=90,mindmg=643.2,maxdmg=838.8,attackpower=992,minrangedmg=477.6,maxrangedmg=682.8,rangedattackpower=159 where entry=51525;

-- quest's are autocomplete
UPDATE quest_template SET Method=2 WHERE Id=24742;
UPDATE quest_template SET Method=2 WHERE Id=24697;
UPDATE quest_template SET Method=2 WHERE Id=24724;
UPDATE quest_template SET Method=2 WHERE Id=24725;

-- wrong queststarter
delete from creature_queststarter where id=9117 and quest=24722;
delete from creature_queststarter where id=9270 and quest=24865;
delete from creature_queststarter where id=9270 and quest=24911;
delete from creature_queststarter where id=9271 and quest=24866;


-- missing quest target
UPDATE quest_template SET RequiredNpcOrGo1=-164955,RequiredNpcOrGoCount1=1 WHERE Id=24722;
-- insert script
update gameobject_template set AIName="",ScriptName="go_northern_crystal_pylon" where entry=164955;

-- double old unused quest 
delete from gameobject_queststarter where id=164955 and quest=4381;
delete from gameobject_queststarter where id=164955 and quest=4385;

-- missing quest description
UPDATE quest_template SET Details="The Pylon table allows you to combine green power crystals with yellow power crystals.$B$BAccording to J.D.'s manual, this combination can be used to heal yourself or your allies." WHERE Id=24724;
UPDATE quest_template SET Details="The Pylon table allows you to combine red power crystals with yellow power crystals.$B$BAccording to J.D.'s manual, this combination can be used to create a large explosion that can inflict damage on your enemies." WHERE Id=24725;
UPDATE quest_template SET Objectives="Collect 8 green and 6 yellow Power Crystals." WHERE Id=24724;
UPDATE quest_template SET Objectives="Collect 6 red and 8 yellow Power Crystals." WHERE Id=24725;
UPDATE quest_template SET PrevQuestId=24724 WHERE Id=24725;

-- quest only for alliance
UPDATE quest_template SET RequiredRaces=1101 WHERE Id=28525;
-- quest only for horde
UPDATE quest_template SET RequiredRaces=946 WHERE Id=28526;

-- insert script
update creature_template set AIName="",ScriptName="npc_ungoro_pit_bunny" where entry=38354;

-- move a dino out of camp
UPDATE creature SET position_x=-7425.685,position_y=-1505.944,position_z=-270.3277 WHERE guid=74373;
UPDATE creature SET position_x=-7495.525,position_y=-1426.859,position_z=-267.1799 WHERE guid=74347;

-- wrong portrait
UPDATE quest_template SET QuestGiverPortrait=7841 WHERE Id=24742;

-- wrong position
UPDATE creature SET position_x=-7546.367,position_y=-1502.348,position_z=-267.013 WHERE guid=105802;
UPDATE creature SET position_x=-7537.812,position_y=-1409.131,position_z=-271.9866 WHERE guid=74346;
UPDATE creature SET position_x=-7557.994,position_y=-1471.29,position_z=-269.1265 WHERE guid=74250;

-- set random movement
update creature set spawndist=10,MovementType=1 where id in (6499,6510,6557,9162,9163,9600);
 
-- double spawns
-- sorry, bether is a work with pool tables

-- wrong questchance
update creature_loot_template set ChanceOrQuestChance=-100 where entry=6510 and item=11316;

 
 
