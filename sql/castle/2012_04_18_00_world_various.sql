-- Achievement: WSG / Supreme Defender
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (3698, 3699);
INSERT INTO `achievement_criteria_data` VALUES
(3698,6,3277,0,''),
(3698,7,23335,0,''), -- Alliance target should have Alliance Flag buff
(3699,6,3277,0,''),
(3699,7,23333,0,''); -- Horde target should have Horde Flag buff

-- various merges from https://github.com/TrinityCore/TrinityCore/commit/c1ba60d68cdb1f3acf97a2b94fe336b35cf4c777
-- fix head of onyxia's loot closes by kandera #3851
UPDATE `item_template` SET `flags` = flags|4096 WHERE `entry` IN (18422,18423,49644,49643);

-- Update proper modelid for Celestial Steed (31957 is wrong)
UPDATE `creature_template` SET `modelid1`=31958,`modelid2`=0 WHERE `entry`=40625;

-- fix procs by warpten closes #4467 for Needle-Encrusted Scorpion
DELETE FROM `spell_proc_event` WHERE `entry`=71404;
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(71404,0,0,0,0,0,0,2,0,0,50);

-- Fix wrong spell power scaling (merge: https://github.com/TrinityCore/TrinityCore/commit/40309110acae2e621db67dc221fb03a145cf84a0)
-- Druid
UPDATE `spell_bonus_data` SET `direct_bonus`=0,`dot_bonus`=0 WHERE `entry` IN (779,1822,60089);
DELETE FROM `spell_bonus_data` WHERE `entry` IN (1079,9007,22568);
INSERT INTO `spell_bonus_data` VALUES
(1079,0,0,-1,-1, 'Druid - Rip'),
(9007,0,0,-1,-1, 'Druid - Pounce Bleed'),
(22568,0,0,-1,-1, 'Druid - Ferocious Bite');

-- Hunter
UPDATE `spell_bonus_data` SET `direct_bonus`=0,`dot_bonus`=0 WHERE `entry` IN (3044,3674,53352,13812,13797,1978,42243);
UPDATE `spell_bonus_data` SET `ap_dot_bonus`=0.1 WHERE `entry`=13812;
DELETE FROM `spell_bonus_data` WHERE `entry` IN (24131,53353);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(24131,0,0,-1,-1, 'Hunter - Wyvern Sting (triggered)'),
(53353,0,0,-1,-1, 'Hunter - Chimera Shot (Serpent)');
DELETE FROM `spell_ranks` WHERE `first_spell_id`=24131;
INSERT INTO `spell_ranks` VALUES
(24131,24131,1),
(24131,24134,2),
(24131,24135,3),
(24131,27069,4),
(24131,49009,5),
(24131,49010,6);

-- Rogue
UPDATE `spell_bonus_data` SET `direct_bonus`=0,`dot_bonus`=0 WHERE `entry` IN (2818,2819,11353,11354,25349,26968,27187,57969,57970);

-- Howling blast
UPDATE `spell_bonus_data` SET `ap_bonus`=0.2 WHERE `entry`=49184;

-- Fix vigilance / blessing of sanctuary / renewd hope stacking
-- due to wrong spell id for renewed hope 3% effect
UPDATE `spell_group` SET `spell_id`=63944 WHERE `id`='1117' and`spell_id`='57470';

