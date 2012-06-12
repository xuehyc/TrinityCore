-- @DorianGrey: 
-- Fix for Q11626: The Emissary.
-- I've added a scripts for the spell triggered by S47170, which is used by Trident of Naz'jan (I35580).
-- Also, S47170 had to be restricted to a single target, Leviroth.

-- Add spell-script to self-impale triggered spell.
DELETE FROM `spell_script_names` WHERE `spell_id`=49882;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (49882, 'spell_gen_leviroth_self_impale');

-- Enforce the spell to be only castable on Leviroth.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=47170;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 0, 47170, 0, 0, 18, 0, 1, 26452, 0, 0, 0, '', 'Impale Leviroth - Target limitation');

-- Add script to Leviroth - for enforcing kill credit a.s.o.
UPDATE `creature_template` SET `ScriptName`='npc_leviroth' WHERE `entry`=26452;