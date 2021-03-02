
UPDATE `gameobject_template_addon` SET `faction`=114 WHERE `entry`=210548; -- Doodad_G_LeverMetal01
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=214296; -- Blade of the Anointed

DELETE FROM `creature_template_addon` WHERE `entry` IN (114441 /*114441 (Travel to Scarlet Monestary)*/, 61905 /*61905 (Lost of Lordaeron)*/, 64838 /*64838 (Hooded Crusader)*/, 59789 /*59789 (Thalnos the Soulrender)*/, 60106 /*60106 (Commander Durand) - Ride Vehicle Hardcoded*/, 60107 /*60107 (Dashing Strike Back Stalker) - Ride Vehicle Hardcoded*/, 58783 /*58783 (Scarlet Initiate)*/, 60040 /*60040 (Commander Durand) - Permanent Feign Death*/, 64446 /*64446 (Training Dummy) - Training Dummy Marker*/, 64855 /*64855 (Blade of the Anointed)*/, 59223 /*59223 (Brother Korloff) - Rising Flame*/, 60197 /*60197 (Training Dummy) - Training Dummy Marker*/, 58605 /*58605 (Scarlet Judicator) - Drunk*/, 58555 /*58555 (Scarlet Fanatic)*/, 58590 /*58590 (Scarlet Zealot)*/, 58569 /*58569 (Scarlet Purifier)*/, 60033 /*60033 (Frenzied Spirit) - Frenzied Spirit*/, 59706 /*59706 (Fuel Tank) - Ride Vehicle Hardcoded*/, 59722 /*59722 (Pile of Corpses) - Pile of Corpses*/, 59705 /*59705 (Scarlet Flamethrower)*/, 59746 /*59746 (Scarlet Centurion)*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(114441, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114441 (Travel to Scarlet Monestary)
(61905, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61905 (Lost of Lordaeron)
(64838, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64838 (Hooded Crusader)
(59789, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59789 (Thalnos the Soulrender)
(60106, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 60106 (Commander Durand) - Ride Vehicle Hardcoded
(60107, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 60107 (Dashing Strike Back Stalker) - Ride Vehicle Hardcoded
(58783, 0, 0, 8, 1, 0, 0, 0, 0, ''), -- 58783 (Scarlet Initiate)
(60040, 0, 0, 7, 1, 0, 0, 0, 0, '29266'), -- 60040 (Commander Durand) - Permanent Feign Death
(64446, 0, 0, 0, 1, 0, 0, 0, 0, '98892'), -- 64446 (Training Dummy) - Training Dummy Marker
(64855, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64855 (Blade of the Anointed)
(59223, 0, 0, 0, 1, 0, 0, 0, 0, '114410'), -- 59223 (Brother Korloff) - Rising Flame
(60197, 0, 0, 0, 1, 0, 0, 0, 0, '98892'), -- 60197 (Training Dummy) - Training Dummy Marker
(58605, 0, 0, 0, 1, 0, 0, 0, 0, '128800'), -- 58605 (Scarlet Judicator) - Drunk
(58555, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58555 (Scarlet Fanatic)
(58590, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58590 (Scarlet Zealot)
(58569, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58569 (Scarlet Purifier)
(60033, 0, 0, 50331648, 1, 0, 0, 0, 0, '115523'), -- 60033 (Frenzied Spirit) - Frenzied Spirit
(59706, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 59706 (Fuel Tank) - Ride Vehicle Hardcoded
(59722, 0, 0, 0, 1, 0, 0, 0, 0, '114951'), -- 59722 (Pile of Corpses) - Pile of Corpses
(59705, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59705 (Scarlet Flamethrower)
(59746, 0, 0, 0, 1, 0, 0, 0, 0, ''); -- 59746 (Scarlet Centurion)

UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4281; -- 4281 (Scarlet Scout)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4285; -- 4285 (Scarlet Disciple)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4280; -- 4280 (Scarlet Preserver)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4284; -- 4284 (Scarlet Augur)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4282; -- 4282 (Scarlet Magician)
UPDATE `creature_template_addon` SET `bytes1`=0, `bytes2`=1, `auras`='111672 96733 8278' WHERE `entry`=4542; -- 4542 (High Inquisitor Fairbanks)
UPDATE `creature_template_addon` SET `bytes2`=1, `auras`='127399' WHERE `entry`=3977; -- 3977 (High Inquisitor Whitemane)


UPDATE `creature_template` SET `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=2048 WHERE `entry`=114441; -- Travel to Scarlet Monestary
UPDATE `creature_template` SET `minlevel`=30 WHERE `entry`=4281; -- Scarlet Scout
UPDATE `creature_template` SET `minlevel`=31 WHERE `entry`=4284; -- Scarlet Augur
UPDATE `creature_template` SET `minlevel`=30 WHERE `entry`=4282; -- Scarlet Magician
UPDATE `creature_template` SET `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=64838; -- Hooded Crusader
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_run`=1.428571462631225585 WHERE `entry`=59789; -- Thalnos the Soulrender
UPDATE `creature_template` SET `unit_flags3`=1, `dynamicflags`=32 WHERE `entry`=4542; -- High Inquisitor Fairbanks
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58783; -- Scarlet Initiate
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `unit_flags`=576 WHERE `entry`=3977; -- High Inquisitor Whitemane
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `unit_flags`=33344 WHERE `entry`=60040; -- Commander Durand
UPDATE `creature_template` SET `speed_run`=1, `unit_flags3`=1 WHERE `entry`=64446; -- Training Dummy
UPDATE `creature_template` SET `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048 WHERE `entry`=64855; -- Blade of the Anointed
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_walk`=2.799999952316284179, `speed_run`=2 WHERE `entry`=59223; -- Brother Korloff
UPDATE `creature_template` SET `speed_run`=1, `unit_flags3`=1 WHERE `entry`=60197; -- Training Dummy
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=2156 WHERE `entry`=58605; -- Scarlet Judicator
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58555; -- Scarlet Fanatic
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58590; -- Scarlet Zealot
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58569; -- Scarlet Purifier
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=1.111111998558044433, `speed_run`=0.857142865657806396 WHERE `entry`=60033; -- Frenzied Spirit
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `npcflag`=16777216, `speed_run`=1, `unit_flags`=32768, `unit_flags3`=1 WHERE `entry`=59706; -- Fuel Tank
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=0.595238566398620605 WHERE `entry`=59722; -- Pile of Corpses
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59705; -- Scarlet Flamethrower
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59746; -- Scarlet Centurion
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data11`=1, `Data14`=19676, `VerifiedBuild`=23360 WHERE `entry`=214296; -- Blade of the Anointed

DELETE FROM `gameobject_questitem` WHERE (`GameObjectEntry`=214296 AND `Idx`=0);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(214296, 0, 87389, 23360); -- Blade of the Anointed

DELETE FROM `gameobject_template_addon` WHERE `entry`=252867;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(252867, 0, 4, 0); -- The Day the Horde Came

UPDATE `gameobject_template_addon` SET `flags`=2097152 WHERE `entry`=210894; -- Gold Coins
UPDATE `gameobject_template_addon` SET `faction`=1375 WHERE `entry`=210479; -- Lever

DELETE FROM `creature_template_addon` WHERE `entry` IN (114441 /*114441 (Travel to Scarlet Monestary)*/, 61905 /*61905 (Lost of Lordaeron)*/, 60908 /*60908 (Archery Target Base)*/, 64764 /*64764 (Hooded Crusader)*/, 59372 /*59372 (Scarlet Scholar)*/, 59373 /*59373 (Scarlet Pupil) - Studying*/, 66091 /*66091 (Referee)*/, 59150 /*59150 (Flameweaver Koegler)*/, 59240 /*59240 (Scarlet Hall Guardian)*/, 59155 /*59155 (Book Case)*/, 59209 /*59209 (Books)*/, 59198 /*59198 (Dragon Breath Target)*/, 59241 /*59241 (Scarlet Treasurer) - Carrying Treasure*/, 58725 /*58725 (Scarlet Cannons)*/, 58726 /*58726 (Scarlet Cannon)*/, 58756 /*58756 (Scarlet Evoker)*/, 58632 /*58632 (Armsmaster Harlan)*/, 58685 /*58685 (Scarlet Evangelist)*/, 58676 /*58676 (Scarlet Defender) - Heavy Armor, Shield Barrier*/, 58684 /*58684 (Scarlet Scourge Hewer)*/, 58683 /*58683 (Scarlet Myrmidon)*/, 59302 /*59302 (Sergeant Verdone) - Phalanx Defense*/, 59299 /*59299 (Scarlet Guardian) - Phalanx Defense*/, 59309 /*59309 (Obedient Hound)*/, 59303 /*59303 (Houndmaster Braun) - Houndmaster Controller Aura*/, 58701 /*58701 (Stake) - Stake Checker*/, 65379 /*65379 (Bucket of Meaty Dog Food) - Bucket of Meaty Dog Food, Cosmetic - Loot Sparkles (2.00)*/, 58674 /*58674 (Angry Hound) - Zero Energy + Zero Regen, Chained, Speedy*/, 58727 /*58727 (Chained Dog Target) - Ride Vehicle Hardcoded*/, 59191 /*59191 (Commander Lindon) - Slaughter the Weak*/, 54030 /*54030 (Invisible Stalker)*/, 59175 /*59175 (Master Archer) - Perfect Shot, Invisibility and Stealth Detection*/, 58876 /*58876 (Starving Hound) - Pack Instincts, Pack Member*/, 58898 /*58898 (Vigilant Watchman)*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(114441, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114441 (Travel to Scarlet Monestary)
(61905, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61905 (Lost of Lordaeron)
(60908, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 60908 (Archery Target Base)
(64764, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64764 (Hooded Crusader)
(59372, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59372 (Scarlet Scholar)
(59373, 0, 0, 0, 1, 0, 0, 0, 0, '114159'), -- 59373 (Scarlet Pupil) - Studying
(66091, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 66091 (Referee)
(59150, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59150 (Flameweaver Koegler)
(59240, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59240 (Scarlet Hall Guardian)
(59155, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59155 (Book Case)
(59209, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 59209 (Books)
(59198, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 59198 (Dragon Breath Target)
(59241, 0, 0, 0, 1, 0, 0, 0, 0, '113876'), -- 59241 (Scarlet Treasurer) - Carrying Treasure
(58725, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58725 (Scarlet Cannons)
(58726, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58726 (Scarlet Cannon)
(58756, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58756 (Scarlet Evoker)
(58632, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58632 (Armsmaster Harlan)
(58685, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58685 (Scarlet Evangelist)
(58676, 0, 0, 0, 1, 0, 0, 0, 0, '111323 111324'), -- 58676 (Scarlet Defender) - Heavy Armor, Shield Barrier
(58684, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58684 (Scarlet Scourge Hewer)
(58683, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58683 (Scarlet Myrmidon)
(59302, 0, 0, 0, 1, 0, 0, 0, 0, '127352'), -- 59302 (Sergeant Verdone) - Phalanx Defense
(59299, 0, 0, 0, 1, 0, 0, 0, 0, '127352'), -- 59299 (Scarlet Guardian) - Phalanx Defense
(59309, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59309 (Obedient Hound)
(59303, 0, 0, 0, 1, 0, 0, 0, 0, '114027'), -- 59303 (Houndmaster Braun) - Houndmaster Controller Aura
(58701, 0, 0, 0, 1, 0, 0, 0, 0, '111703'), -- 58701 (Stake) - Stake Checker
(65379, 0, 0, 0, 1, 0, 0, 0, 0, '128176 113994'), -- 65379 (Bucket of Meaty Dog Food) - Bucket of Meaty Dog Food, Cosmetic - Loot Sparkles (2.00)
(58674, 0, 0, 0, 1, 0, 0, 0, 0, '72242 111641 111634'), -- 58674 (Angry Hound) - Zero Energy + Zero Regen, Chained, Speedy
(58727, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 58727 (Chained Dog Target) - Ride Vehicle Hardcoded
(59191, 0, 0, 0, 1, 0, 0, 0, 0, '113847'), -- 59191 (Commander Lindon) - Slaughter the Weak
(54030, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 54030 (Invisible Stalker)
(59175, 0, 0, 0, 1, 0, 0, 0, 0, '113845 18950'), -- 59175 (Master Archer) - Perfect Shot, Invisibility and Stealth Detection
(58876, 0, 0, 0, 1, 0, 0, 0, 0, '111837 111838'), -- 58876 (Starving Hound) - Pack Instincts, Pack Member
(58898, 0, 0, 0, 1, 0, 0, 0, 0, ''); -- 58898 (Vigilant Watchman)

UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4281; -- 4281 (Scarlet Scout)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4282; -- 4282 (Scarlet Magician)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4280; -- 4280 (Scarlet Preserver)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4284; -- 4284 (Scarlet Augur)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=4285; -- 4285 (Scarlet Disciple)

DELETE FROM `creature_model_info` WHERE `DisplayID`=40300;
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES
(40300, 0.800000011920928955, 0, 0, 23360);

UPDATE `creature_template` SET `maxlevel`=29 WHERE `entry`=4281; -- Scarlet Scout
UPDATE `creature_template` SET `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=2048 WHERE `entry`=114441; -- Travel to Scarlet Monestary
UPDATE `creature_template` SET `minlevel`=30 WHERE `entry`=4282; -- Scarlet Magician
UPDATE `creature_template` SET `minlevel`=30 WHERE `entry`=4280; -- Scarlet Preserver
UPDATE `creature_template` SET `minlevel`=31 WHERE `entry`=4284; -- Scarlet Augur
UPDATE `creature_template` SET `npcflag`=16777216, `unit_flags3`=1 WHERE `entry`=60908; -- Archery Target Base
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59372; -- Scarlet Scholar
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59373; -- Scarlet Pupil
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92 WHERE `entry`=59150; -- Flameweaver Koegler
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59240; -- Scarlet Hall Guardian
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59155; -- Book Case
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59209; -- Books
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59198; -- Dragon Breath Target
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59241; -- Scarlet Treasurer
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `unit_flags3`=1 WHERE `entry`=58725; -- Scarlet Cannons
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58726; -- Scarlet Cannon
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58756; -- Scarlet Evoker
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92 WHERE `entry`=58632; -- Armsmaster Harlan
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58685; -- Scarlet Evangelist
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58676; -- Scarlet Defender
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58684; -- Scarlet Scourge Hewer
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58683; -- Scarlet Myrmidon
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59302; -- Sergeant Verdone
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59299; -- Scarlet Guardian
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59309; -- Obedient Hound
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=2191 WHERE `entry`=59303; -- Houndmaster Braun
UPDATE `creature_template` SET `npcflag`=16777216, `unit_flags3`=1 WHERE `entry`=65379; -- Bucket of Meaty Dog Food
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58674; -- Angry Hound
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=58727; -- Chained Dog Target
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=59191; -- Commander Lindon
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59175; -- Master Archer
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58876; -- Starving Hound
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58898; -- Vigilant Watchman

DELETE FROM `gameobject_template` WHERE `entry`=252867;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(252867, 3, 20144, 'The Day the Horde Came', 'openhandglow', 'Retrieving', '', 1.5, 1691, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 23645, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67956, 1, 0, 0, 23360); -- The Day the Horde Came

DELETE FROM `gameobject_questitem` WHERE (`GameObjectEntry`=252867 AND `Idx`=0);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(252867, 0, 140118, 23360); -- The Day the Horde Came

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (227593 /*Garrison Building Leatherworking Level 3*/, 230993 /*Fishing Shack*/, 234190 /*Deadly Iron Trap*/, 238761 /*Barn Work Order*/, 239171 /*Glass of Warm Milk*/, 225577 /*Garrison Building Stable 1*/, 244476 /*Tiny Wickerman*/, 244475 /*6TD S Table Set*/, 233186 /*Garrison Building Barn V3*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(227593, 0, 1048608, 0), -- Garrison Building Leatherworking Level 3
(230993, 0, 1048608, 0), -- Fishing Shack
(234190, 94, 0, 569), -- Deadly Iron Trap
(238761, 0, 262144, 0), -- Barn Work Order
(239171, 94, 0, 0), -- Glass of Warm Milk
(225577, 0, 1048608, 0), -- Garrison Building Stable 1
(244476, 1375, 0, 0), -- Tiny Wickerman
(244475, 1375, 0, 0), -- 6TD S Table Set
(233186, 0, 1048608, 0); -- Garrison Building Barn V3

UPDATE `gameobject_template_addon` SET `flags`=1048608 WHERE `entry`=235990; -- Garrison Building Farm V2
UPDATE `gameobject_template_addon` SET `flags`=1048608 WHERE `entry`=230475; -- Garrison Building Alliance Salvage Tent V2
UPDATE `gameobject_template_addon` SET `faction`=94, `WorldEffectID`=2100 WHERE `entry`=237722; -- Full Garrison Cache
UPDATE `gameobject_template_addon` SET `flags`=1048608 WHERE `entry`=224806; -- Garrison Building Inn V2
UPDATE `gameobject_template_addon` SET `flags`=1048608 WHERE `entry`=224854; -- Garrison Building Alliance Storehouse V1
UPDATE `gameobject_template_addon` SET `WorldEffectID`=3702 WHERE `entry`=232544; -- True Iron Deposit
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2100 WHERE `entry`=232541; -- Mine Cart
UPDATE `gameobject_template_addon` SET `flags`=1048608 WHERE `entry`=225540; -- Garrison Building Mine 3
UPDATE `gameobject_template_addon` SET `faction`=1732, `WorldEffectID`=2690 WHERE `entry`=236165; -- War Planning Map
UPDATE `gameobject_template_addon` SET `flags`=1048608 WHERE `entry`=224798; -- Garrison Building Barracks V2
UPDATE `gameobject_template_addon` SET `faction`=114 WHERE `entry`=239186; -- Architect Table Collision
UPDATE `gameobject_template_addon` SET `faction`=114 WHERE `entry`=239180; -- Command Table Collision
UPDATE `gameobject_template_addon` SET `flags`=1048608 WHERE `entry`=224813; -- Garrison Building Alliance Pet Stable V1
UPDATE `gameobject_template_addon` SET `faction`=1375 WHERE `entry`=211670; -- Polyformic Acid Potion Highlight
UPDATE `gameobject_template_addon` SET `faction`=35 WHERE `entry`=211669; -- Polyformic Acid Potion
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=210792; -- Doodad_UndeadCampFire30

DELETE FROM `creature_template_addon` WHERE `entry` IN (82177 /*82177 (Pippers)*/, 82865 /*82865 (Bruma Swiftstone) - Dual Wield*/, 81569 /*81569 (Daleera Moonfang)*/, 82479 /*82479 (Artificer Romuul)*/, 81947 /*81947 (Garrison Creature)*/, 89075 /*89075 (Delvar Ironfist)*/, 86887 /*86887 (Leorajh)*/, 87050 /*87050 (Young Icehoof)*/, 87055 /*87055 (Young Silverpelt)*/, 87856 /*87856 (Reshad)*/, 87859 /*87859 (Percy)*/, 77376 /*77376 (Lunarfall Woodcutter)*/, 79603 /*79603 (Emote Bunny)*/, 90675 /*90675 (Erris the Collector)*/, 88598 /*88598 (Chronicler Zataara)*/, 82466 /*82466 (Aenir)*/, 87871 /*87871 (Birchus)*/, 83858 /*83858 (Khadgar's Servant)*/, 85737 /*85737 (Lunarfall Rifleman)*/, 85561 /*85561 (Brutus)*/, 85622 /*85622 (Challenge Post) - Pet Trainer*/, 89259 /*89259 (Lunarfall Laborer)*/, 85655 /*85655 (Rukus)*/, 91025 /*91025 (Dorothy "Two")*/, 89298 /*89298 (Lunarfall Rifleman) - Garrison Combat Throttle*/, 83491 /*83491 (Eileese Shadowsong)*/, 77617 /*77617 (Lunarfall Worker)*/, 77361 /*77361 (Miner)*/, 81103 /*81103 (Dungar Longdrink)*/, 84184 /*84184 (Painter Phaeren)*/, 77379 /*77379 (Jonathan Stephens)*/, 86470 /*86470 (Pepe)*/, 80163 /*80163 (Ken Loggin)*/, 82586 /*82586 (Porter)*/, 88126 /*88126 (Maybell Maclure-Stonefield) - Garrison - Has Mug*/, 78564 /*78564 (Sergeant Crowler) - Garrison Combat Throttle*/, 81492 /*81492 (Bodrick Grey)*/, 81491 /*81491 (Amber Kearnen)*/, 80026 /*80026 (Debug - Garrison - Bunny - Boss Emotes)*/, 96362 /*96362 (Izzy Hollyfizzle)*/, 85312 /*85312 (Lunarfall Rifleman) - Garrison Combat Throttle*/, 84979 /*84979 (Lunarfall Stablehand)*/, 86973 /*86973 (Keegan Firebeard)*/, 84524 /*84524 (Homer Stonefield)*/, 84796 /*84796 (Ma Stonefield)*/, 86975 /*86975 (Sky'reen)*/, 86974 /*86974 (Fanny Firebeard)*/, 81346 /*81346 (Provisioner Hanfa)*/, 84795 /*84795 (Tommy Joe Stonefield)*/, 87054 /*87054 (Young Rocktusk)*/, 77381 /*77381 (Raven)*/, 77370 /*77370 (Lunarfall Footman) - Garrison Combat Throttle*/, 84246 /*84246 (Ashley Zerep)*/, 84776 /*84776 (Aerun)*/, 91589 /*91589 (Fix "Smallie" Biggswrench)*/, 93142 /*93142 (Lost Netherpup)*/, 85857 /*85857 (Jeff Miller)*/, 84285 /*84285 (Jarrod Hamby) - Shadowy Ghost Visual*/, 88633 /*88633 (Deluwin Whisperfield)*/, 94870 /*94870 (Seer Kazal)*/, 94512 /*94512 (Tiffy Trapspring)*/, 82776 /*82776 (Deedree)*/, 90381 /*90381 (Tune-O-Tron 5000)*/, 85418 /*85418 (Lio the Lioness)*/, 81152 /*81152 (Scout Valdez) - Read Scroll*/, 84698 /*84698 (Command Table)*/, 95470 /*95470 (Trader Araanda)*/, 84455 /*84455 (Assistant Brightstone)*/, 77209 /*77209 (Baros Alexston)*/, 79953 /*79953 (Lieutenant Thorn)*/, 85839 /*85839 (Sparz Boltwist)*/, 86018 /*86018 (Architect Table)*/, 59167 /*59167 (Teleport Location)*/, 59099 /*59099 (Fresh Test Subject) - Explosive Pain*/, 59100 /*59100 (Expired Test Subject)*/, 30298 /*30298 (Invisible Stalker (Float, Uninteractible, LargeAOI)) - Cosmetic Flames*/, 59982 /*59982 (Meat Graft) - Ride Vehicle, Meat Graft*/, 58722 /*58722 (Lilian Voss) - Dual Wield*/, 58875 /*58875 (Darkmaster Gandling) - Improved Bone Shield*/, 59316 /*59316 (Soulflame) - Soulflame*/, 59153 /*59153 (Rattlegore) - Rusting*/, 59304 /*59304 (Bone Pile) - CLICK ME!*/, 59394 /*59394 (General Purpose Bunny JMF (Ground)) - Coffer of Forgotten Souls*/, 59360 /*59360 (Meat Graft) - Ride Vehicle, Meat Graft*/, 59359 /*59359 (Flesh Horror) - Clotting, Invisibility and Stealth Detection*/, 59980 /*59980 (Meat Graft) - Ride Vehicle, Meat Graft*/, 64563 /*64563 (Talking Skull) - Talking Skull: Skull State Visual*/, 59193 /*59193 (Boneweaver) - Boneweaving*/, 59614 /*59614 (Bored Student)*/, 59368 /*59368 (Krastinovian Carver) - Boiling Bloodthirst, Surgical Alterations*/, 59375 /*59375 (Cosmetic Meat Pile)*/, 59080 /*59080 (Darkmaster Gandling) - Cosmetic Flames*/, 59501 /*59501 (Reanimated Corpse)*/, 58823 /*58823 (Scholomance Neophyte) - Shadowy*/, 59467 /*59467 (Candlestick Mage) - Flameborn*/, 58917 /*58917 (Book Spawn Target)*/, 58757 /*58757 (Scholomance Acolyte)*/, 62731 /*62731 (Ice Wall) - Ice Wall*/, 58822 /*58822 (Risen Guard)*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(82177, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 82177 (Pippers)
(82865, 0, 0, 0, 1, 0, 0, 0, 0, '42459'), -- 82865 (Bruma Swiftstone) - Dual Wield
(81569, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 81569 (Daleera Moonfang)
(82479, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 82479 (Artificer Romuul)
(81947, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 81947 (Garrison Creature)
(89075, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 89075 (Delvar Ironfist)
(86887, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 86887 (Leorajh)
(87050, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87050 (Young Icehoof)
(87055, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87055 (Young Silverpelt)
(87856, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87856 (Reshad)
(87859, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 87859 (Percy)
(77376, 0, 0, 5, 1, 0, 0, 0, 0, ''), -- 77376 (Lunarfall Woodcutter)
(79603, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 79603 (Emote Bunny)
(90675, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 90675 (Erris the Collector)
(88598, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 88598 (Chronicler Zataara)
(82466, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 82466 (Aenir)
(87871, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 87871 (Birchus)
(83858, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 83858 (Khadgar's Servant)
(85737, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85737 (Lunarfall Rifleman)
(85561, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85561 (Brutus)
(85622, 0, 0, 0, 1, 0, 0, 0, 0, '170758'), -- 85622 (Challenge Post) - Pet Trainer
(89259, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 89259 (Lunarfall Laborer)
(85655, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85655 (Rukus)
(91025, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 91025 (Dorothy "Two")
(89298, 0, 0, 0, 0, 0, 0, 0, 0, '178343'), -- 89298 (Lunarfall Rifleman) - Garrison Combat Throttle
(83491, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 83491 (Eileese Shadowsong)
(77617, 0, 0, 5, 257, 0, 0, 0, 0, ''), -- 77617 (Lunarfall Worker)
(77361, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 77361 (Miner)
(81103, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 81103 (Dungar Longdrink)
(84184, 0, 0, 5, 1, 0, 0, 0, 0, ''), -- 84184 (Painter Phaeren)
(77379, 0, 0, 4, 257, 0, 0, 0, 0, ''), -- 77379 (Jonathan Stephens)
(86470, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 86470 (Pepe)
(80163, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 80163 (Ken Loggin)
(82586, 0, 0, 5, 1, 0, 0, 0, 0, ''), -- 82586 (Porter)
(88126, 0, 0, 0, 1, 0, 0, 0, 0, '165159'), -- 88126 (Maybell Maclure-Stonefield) - Garrison - Has Mug
(78564, 0, 0, 0, 0, 0, 0, 0, 0, '178343'), -- 78564 (Sergeant Crowler) - Garrison Combat Throttle
(81492, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 81492 (Bodrick Grey)
(81491, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 81491 (Amber Kearnen)
(80026, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 80026 (Debug - Garrison - Bunny - Boss Emotes)
(96362, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 96362 (Izzy Hollyfizzle)
(85312, 0, 0, 0, 0, 0, 0, 0, 0, '178343'), -- 85312 (Lunarfall Rifleman) - Garrison Combat Throttle
(84979, 0, 0, 5, 257, 0, 0, 0, 0, ''), -- 84979 (Lunarfall Stablehand)
(86973, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 86973 (Keegan Firebeard)
(84524, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 84524 (Homer Stonefield)
(84796, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 84796 (Ma Stonefield)
(86975, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 86975 (Sky'reen)
(86974, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 86974 (Fanny Firebeard)
(81346, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 81346 (Provisioner Hanfa)
(84795, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 84795 (Tommy Joe Stonefield)
(87054, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87054 (Young Rocktusk)
(77381, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 77381 (Raven)
(77370, 0, 0, 0, 1, 0, 0, 0, 0, '178343'), -- 77370 (Lunarfall Footman) - Garrison Combat Throttle
(84246, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 84246 (Ashley Zerep)
(84776, 0, 0, 1, 1, 0, 0, 0, 0, ''), -- 84776 (Aerun)
(91589, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 91589 (Fix "Smallie" Biggswrench)
(93142, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 93142 (Lost Netherpup)
(85857, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85857 (Jeff Miller)
(84285, 0, 0, 0, 1, 0, 0, 0, 0, '165114'), -- 84285 (Jarrod Hamby) - Shadowy Ghost Visual
(88633, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 88633 (Deluwin Whisperfield)
(94870, 0, 0, 1, 1, 0, 0, 0, 0, ''), -- 94870 (Seer Kazal)
(94512, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 94512 (Tiffy Trapspring)
(82776, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 82776 (Deedree)
(90381, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 90381 (Tune-O-Tron 5000)
(85418, 0, 0, 8, 257, 0, 0, 0, 0, ''), -- 85418 (Lio the Lioness)
(81152, 0, 0, 0, 1, 0, 0, 0, 0, '133464'), -- 81152 (Scout Valdez) - Read Scroll
(84698, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 84698 (Command Table)
(95470, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 95470 (Trader Araanda)
(84455, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 84455 (Assistant Brightstone)
(77209, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 77209 (Baros Alexston)
(79953, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 79953 (Lieutenant Thorn)
(85839, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85839 (Sparz Boltwist)
(86018, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 86018 (Architect Table)
(59167, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59167 (Teleport Location)
(59099, 0, 0, 0, 1, 0, 0, 0, 0, '113280'), -- 59099 (Fresh Test Subject) - Explosive Pain
(59100, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59100 (Expired Test Subject)
(30298, 0, 0, 0, 1, 0, 0, 0, 0, '114904'), -- 30298 (Invisible Stalker (Float, Uninteractible, LargeAOI)) - Cosmetic Flames
(59982, 0, 0, 0, 1, 0, 0, 0, 0, '61791 114178'), -- 59982 (Meat Graft) - Ride Vehicle, Meat Graft
(58722, 0, 0, 8, 1, 0, 0, 0, 0, '42459'), -- 58722 (Lilian Voss) - Dual Wield
(58875, 0, 0, 0, 1, 0, 0, 0, 0, '113865'), -- 58875 (Darkmaster Gandling) - Improved Bone Shield
(59316, 0, 0, 0, 1, 0, 0, 0, 0, '114007'), -- 59316 (Soulflame) - Soulflame
(59153, 0, 0, 0, 1, 0, 0, 0, 0, '113763'), -- 59153 (Rattlegore) - Rusting
(59304, 0, 0, 0, 1, 0, 0, 0, 0, '113995'), -- 59304 (Bone Pile) - CLICK ME!
(59394, 0, 0, 0, 1, 0, 0, 0, 0, '115272'), -- 59394 (General Purpose Bunny JMF (Ground)) - Coffer of Forgotten Souls
(59360, 0, 0, 0, 1, 0, 0, 0, 0, '61791 114178'), -- 59360 (Meat Graft) - Ride Vehicle, Meat Graft
(59359, 0, 0, 0, 1, 0, 0, 0, 0, '114176 18950'), -- 59359 (Flesh Horror) - Clotting, Invisibility and Stealth Detection
(59980, 0, 0, 0, 1, 0, 0, 0, 0, '61791 114178'), -- 59980 (Meat Graft) - Ride Vehicle, Meat Graft
(64563, 0, 0, 0, 0, 0, 0, 0, 0, '126155'), -- 64563 (Talking Skull) - Talking Skull: Skull State Visual
(59193, 0, 0, 0, 1, 0, 0, 0, 0, '113647'), -- 59193 (Boneweaver) - Boneweaving
(59614, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59614 (Bored Student)
(59368, 0, 0, 0, 1, 0, 0, 0, 0, '114141 128122'), -- 59368 (Krastinovian Carver) - Boiling Bloodthirst, Surgical Alterations
(59375, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59375 (Cosmetic Meat Pile)
(59080, 0, 0, 0, 1, 0, 0, 0, 0, '114910'), -- 59080 (Darkmaster Gandling) - Cosmetic Flames
(59501, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59501 (Reanimated Corpse)
(58823, 0, 0, 0, 1, 0, 0, 0, 0, '111705'), -- 58823 (Scholomance Neophyte) - Shadowy
(59467, 0, 0, 0, 1, 0, 0, 0, 0, '114384'), -- 59467 (Candlestick Mage) - Flameborn
(58917, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58917 (Book Spawn Target)
(58757, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58757 (Scholomance Acolyte)
(62731, 0, 0, 0, 1, 0, 0, 0, 0, '122443'), -- 62731 (Ice Wall) - Ice Wall
(58822, 0, 0, 0, 1, 0, 0, 0, 0, ''); -- 58822 (Risen Guard)

UPDATE `creature_template_addon` SET `auras`='114076' WHERE `entry`=45979; -- 45979 (General Purpose Bunny JMF)
DELETE FROM `creature_equip_template` WHERE (`ID`=1 AND `CreatureID` IN (82865,81569,82479,89075,77376,88598,85737,89298,83491,77361,80163,78564,85312,86973,84524,77370,94512,81152,95470,84455,77209,85839));
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`) VALUES
(82865, 1, 11922, 0, 0, 44217, 0, 0, 0, 0, 0), -- Bruma Swiftstone
(81569, 1, 61526, 0, 0, 0, 0, 0, 0, 0, 0), -- Daleera Moonfang
(82479, 1, 12776, 0, 0, 0, 0, 0, 0, 0, 0), -- Artificer Romuul
(89075, 1, 45528, 0, 0, 0, 0, 0, 0, 0, 0), -- Delvar Ironfist
(77376, 1, 109579, 0, 0, 0, 0, 0, 0, 0, 0), -- Lunarfall Woodcutter
(88598, 1, 12742, 0, 0, 0, 0, 0, 0, 0, 0), -- Chronicler Zataara
(85737, 1, 0, 0, 0, 0, 0, 0, 110314, 0, 0), -- Lunarfall Rifleman
(89298, 1, 1899, 0, 0, 0, 0, 0, 110314, 0, 0), -- Lunarfall Rifleman
(83491, 1, 108773, 0, 0, 107116, 0, 0, 0, 0, 0), -- Eileese Shadowsong
(77361, 1, 1910, 0, 0, 0, 0, 0, 0, 0, 0), -- Miner
(80163, 1, 109579, 0, 0, 0, 0, 0, 0, 0, 0), -- Ken Loggin
(78564, 1, 108921, 0, 0, 0, 0, 0, 0, 0, 0), -- Sergeant Crowler
(85312, 1, 1899, 0, 0, 0, 0, 0, 110314, 0, 0), -- Lunarfall Rifleman
(86973, 1, 10591, 0, 0, 58938, 0, 0, 0, 0, 0), -- Keegan Firebeard
(84524, 1, 3367, 0, 0, 0, 0, 0, 0, 0, 0), -- Homer Stonefield
(77370, 1, 1899, 0, 0, 143, 0, 0, 0, 0, 0), -- Lunarfall Footman
(94512, 1, 2714, 0, 0, 0, 0, 0, 0, 0, 0), -- Tiffy Trapspring
(81152, 1, 1899, 0, 0, 143, 0, 0, 0, 0, 0), -- Scout Valdez
(95470, 1, 0, 0, 0, 28187, 0, 0, 0, 0, 0), -- Trader Araanda
(84455, 1, 33022, 0, 0, 0, 0, 0, 0, 0, 0), -- Assistant Brightstone
(77209, 1, 12742, 0, 0, 0, 0, 0, 0, 0, 0), -- Baros Alexston
(85839, 1, 1911, 0, 0, 0, 0, 0, 0, 0, 0); -- Sparz Boltwist



UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=12, `npcflag`=17179869184, `speed_walk`=0.555555999279022216, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=82177; -- Pippers
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2110, `npcflag`=17179869185, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=82865; -- Bruma Swiftstone
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2110, `npcflag`=17179869185, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=81569; -- Daleera Moonfang
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2110, `npcflag`=17179869185, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=82479; -- Artificer Romuul
UPDATE `creature_template` SET `maxlevel`=90, `speed_run`=2.285714387893676757, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048, `unit_flags3`=8 WHERE `entry`=81947; -- Garrison Creature
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2110, `npcflag`=17179869185, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=4196352, `unit_flags3`=32 WHERE `entry`=89075; -- Delvar Ironfist
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2110, `npcflag`=17179869185, `speed_walk`=0.919999957084655761, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=86887; -- Leorajh
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=87050; -- Young Icehoof
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=87055; -- Young Silverpelt
UPDATE `creature_template` SET `minlevel`=96, `maxlevel`=96, `faction`=2700, `npcflag`=17179869184, `speed_walk`=2, `speed_run`=1.428571462631225585, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=87856; -- Reshad
UPDATE `creature_template` SET `minlevel`=96, `maxlevel`=96, `faction`=2700, `npcflag`=17179869312, `speed_walk`=1.399999976158142089, `speed_run`=1.428571462631225585, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=87859; -- Percy
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=4196352, `unit_flags3`=32 WHERE `entry`=77376; -- Lunarfall Woodcutter
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=3.20000004768371582, `speed_run`=2, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33570816, `unit_flags2`=4196352, `unit_flags3`=1 WHERE `entry`=79603; -- Emote Bunny
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=90675; -- Erris the Collector
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1732, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=88598; -- Chronicler Zataara
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=2263, `npcflag`=17179869186, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=82466; -- Aenir
UPDATE `creature_template` SET `minlevel`=93, `maxlevel`=93, `faction`=2110, `npcflag`=17179869312, `speed_walk`=1.111111998558044433, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=18432, `unit_flags3`=32 WHERE `entry`=87871; -- Birchus
UPDATE `creature_template` SET `minlevel`=95, `maxlevel`=95, `npcflag`=3, `speed_walk`=1.799999952316284179, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=83858; -- Khadgar's Servant
UPDATE `creature_template` SET `minlevel`=95, `maxlevel`=95, `faction`=1732, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=85737; -- Lunarfall Rifleman
UPDATE `creature_template` SET `minlevel`=25, `maxlevel`=25, `faction`=190, `speed_run`=1.190475702285766601, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=85561; -- Brutus
UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0, `faction`=2156, `npcflag`=16777216, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=67110912 WHERE `entry`=85622; -- Challenge Post
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=1732, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=89259; -- Lunarfall Laborer
UPDATE `creature_template` SET `minlevel`=25, `maxlevel`=25, `faction`=190, `speed_run`=1.190475702285766601, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=85655; -- Rukus
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `npcflag`=131, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=91025; -- Dorothy "Two"
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1802, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=33556480, `unit_flags3`=32 WHERE `entry`=89298; -- Lunarfall Rifleman
UPDATE `creature_template` SET `minlevel`=95, `maxlevel`=95, `faction`=84, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags2`=2048 WHERE `entry`=83491; -- Eileese Shadowsong
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=210, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=4196352, `unit_flags3`=32 WHERE `entry`=77617; -- Lunarfall Worker
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=210, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=4196352, `unit_flags3`=32 WHERE `entry`=77361; -- Miner
UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0, `faction`=84, `npcflag`=17179877377, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=81103; -- Dungar Longdrink
UPDATE `creature_template` SET `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=84184; -- Painter Phaeren
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=1802, `npcflag`=17179869312, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=77379; -- Jonathan Stephens
UPDATE `creature_template` SET `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=86470; -- Pepe
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=5, `faction`=12, `npcflag`=17179869186, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=80163; -- Ken Loggin
UPDATE `creature_template` SET `maxlevel`=2, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=82586; -- Porter
UPDATE `creature_template` SET `minlevel`=2, `maxlevel`=2, `faction`=84, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=88126; -- Maybell Maclure-Stonefield
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1802, `npcflag`=17179869315, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=78564; -- Sergeant Crowler
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=1078, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2099200 WHERE `entry`=81492; -- Bodrick Grey
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=1078, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=81491; -- Amber Kearnen
UPDATE `creature_template` SET `speed_run`=0.857142865657806396, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=1073743872, `unit_flags3`=1 WHERE `entry`=80026; -- Debug - Garrison - Bunny - Boss Emotes
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `npcflag`=131, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=96362; -- Izzy Hollyfizzle
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1802, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=37750784, `unit_flags3`=32 WHERE `entry`=85312; -- Lunarfall Rifleman
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=1733, `npcflag`=17179869185, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=84979; -- Lunarfall Stablehand
UPDATE `creature_template` SET `minlevel`=85, `maxlevel`=85, `faction`=2110, `npcflag`=17179869187, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=86973; -- Keegan Firebeard
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=5, `faction`=2110, `npcflag`=17179869187, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=84524; -- Homer Stonefield
UPDATE `creature_template` SET `minlevel`=3, `maxlevel`=3, `faction`=84, `npcflag`=17179869185, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=84796; -- Ma Stonefield
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=5, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048 WHERE `entry`=86975; -- Sky'reen
UPDATE `creature_template` SET `minlevel`=84, `maxlevel`=84, `faction`=2110, `npcflag`=17179869187, `speed_run`=1.357142806053161621, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=86974; -- Fanny Firebeard
UPDATE `creature_template` SET `minlevel`=93, `maxlevel`=93, `faction`=1732, `npcflag`=17179873408, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=81346; -- Provisioner Hanfa
UPDATE `creature_template` SET `minlevel`=2, `maxlevel`=2, `faction`=84, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=84795; -- Tommy Joe Stonefield
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_run`=1.190475702285766601, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=87054; -- Young Rocktusk
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=1733, `npcflag`=17184063617, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=77381; -- Raven
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1802, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=37750784, `unit_flags3`=32 WHERE `entry`=77370; -- Lunarfall Footman
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=1733, `npcflag`=17179869312, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=84246; -- Ashley Zerep
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=1733, `npcflag`=17179869187, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=84776; -- Aerun
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=91589; -- Fix "Smallie" Biggswrench
UPDATE `creature_template` SET `faction`=188, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048 WHERE `entry`=93142; -- Lost Netherpup
UPDATE `creature_template` SET `minlevel`=45, `maxlevel`=45, `faction`=1732, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=85857; -- Jeff Miller
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=84285; -- Jarrod Hamby
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=2362, `npcflag`=17179869313, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=88633; -- Deluwin Whisperfield
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2706, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=94870; -- Seer Kazal
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=875, `npcflag`=128, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=512, `unit_flags2`=2048 WHERE `entry`=94512; -- Tiffy Trapspring
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=1732, `npcflag`=17179869315, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33280, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=82776; -- Deedree
UPDATE `creature_template` SET `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=34816, `unit_flags3`=1 WHERE `entry`=90381; -- Tune-O-Tron 5000
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=98, `faction`=80, `npcflag`=17179869315, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=512, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=85418; -- Lio the Lioness
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `npcflag`=17179869187, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=81152; -- Scout Valdez
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=190, `npcflag`=137438953473, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=67143680 WHERE `entry`=84698; -- Command Table
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2110, `npcflag`=128, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=512, `unit_flags2`=2048 WHERE `entry`=95470; -- Trader Araanda
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `faction`=2703, `npcflag`=17179869185, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=84455; -- Assistant Brightstone
UPDATE `creature_template` SET `minlevel`=30, `maxlevel`=30, `faction`=12, `npcflag`=17179869187, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=512, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=77209; -- Baros Alexston
UPDATE `creature_template` SET `minlevel`=94, `maxlevel`=94, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=34816 WHERE `entry`=79953; -- Lieutenant Thorn
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=1732, `npcflag`=129, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=512, `unit_flags2`=2048 WHERE `entry`=85839; -- Sparz Boltwist
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=190, `npcflag`=8589934592, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=67143680 WHERE `entry`=86018; -- Architect Table
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59167; -- Teleport Location
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `unit_flags3`=1 WHERE `entry`=59099; -- Fresh Test Subject
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=0.357142865657806396 WHERE `entry`=59100; -- Expired Test Subject
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59982; -- Meat Graft
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=1665, `unit_flags`=32848 WHERE `entry`=58722; -- Lilian Voss
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `unit_flags3`=1 WHERE `entry`=58875; -- Darkmaster Gandling
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_walk`=2, `speed_run`=1.714285731315612792, `unit_flags3`=1 WHERE `entry`=59316; -- Soulflame
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_run`=1.190475702285766601 WHERE `entry`=59153; -- Rattlegore
UPDATE `creature_template` SET `npcflag`=16777216, `speed_run`=1, `unit_flags3`=1 WHERE `entry`=59304; -- Bone Pile
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `unit_flags`=33554448, `unit_flags3`=1 WHERE `entry`=59360; -- Meat Graft
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_walk`=1.20000004768371582, `speed_run`=0.428571432828903198 WHERE `entry`=59359; -- Flesh Horror
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `unit_flags`=33554448, `unit_flags3`=1 WHERE `entry`=59980; -- Meat Graft
UPDATE `creature_template` SET `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33600, `unit_flags2`=2048 WHERE `entry`=64563; -- Talking Skull
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=59193; -- Boneweaver
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59614; -- Bored Student
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59368; -- Krastinovian Carver
UPDATE `creature_template` SET `speed_run`=1 WHERE `entry`=59375; -- Cosmetic Meat Pile
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92 WHERE `entry`=59080; -- Darkmaster Gandling
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=0.428571432828903198 WHERE `entry`=59501; -- Reanimated Corpse
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58823; -- Scholomance Neophyte
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59467; -- Candlestick Mage
UPDATE `creature_template` SET `speed_walk`=6, `speed_run`=2.142857074737548828, `unit_flags3`=1 WHERE `entry`=58917; -- Book Spawn Target
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58757; -- Scholomance Acolyte
UPDATE `creature_template` SET `speed_walk`=5.199999809265136718, `speed_run`=1.857142806053161621, `unit_flags3`=1 WHERE `entry`=62731; -- Ice Wall
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=58822; -- Risen Guard

DELETE FROM `gameobject_template` WHERE `entry` IN (230993 /*Fishing Shack*/, 227593 /*Garrison Building Leatherworking Level 3*/, 239171 /*Glass of Warm Milk*/, 234190 /*Deadly Iron Trap*/, 225577 /*Garrison Building Stable 1*/, 233186 /*Garrison Building Barn V3*/);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(230993, 39, 16437, 'Fishing Shack', '', '', '', 1, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23360), -- Fishing Shack
(227593, 38, 15140, 'Garrison Building Leatherworking Level 3', '', '', '', 1, 1385, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23360), -- Garrison Building Leatherworking Level 3
(239171, 3, 24402, 'Glass of Warm Milk', '', '', '', 0.85000002384185791, 1634, 58263, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 31389, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23360), -- Glass of Warm Milk
(234190, 3, 14212, 'Deadly Iron Trap', '', '', '', 0.200000002980232238, 57, 55128, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23360), -- Deadly Iron Trap
(225577, 38, 14625, 'Garrison Building Stable 1', '', '', '', 1, 1224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23360), -- Garrison Building Stable 1
(233186, 38, 18234, 'Garrison Building Barn V3', '', '', '', 1, 1399, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23360); -- Garrison Building Barn V3

UPDATE `gameobject_template` SET `type`=3, `Data3`=1, `Data4`=0, `Data5`=0, `Data6`=0, `Data11`=0, `Data12`=0, `Data13`=0, `Data14`=0, `Data17`=26967, `Data18`=91, `Data19`=1, `Data23`=650, `Data24`=700, `VerifiedBuild`=23360 WHERE `entry`=232544; -- True Iron Deposit

UPDATE `gameobject_template_addon` SET `faction`=94, `flags`=2097152 WHERE `entry`=213889; -- Taran Zhu's Personal Stash
UPDATE `gameobject_template_addon` SET `faction`=94, `flags`=2097152 WHERE `entry`=214518; -- Snowdrift's Possessions
UPDATE `gameobject_template_addon` SET `faction`=114 WHERE `entry`=212908; -- Shadowpan Hideout - Weaponmaster Gauntlet - Collision

DELETE FROM `quest_details` WHERE `ID`=30757;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(30757, 0, 0, 0, 0, 0, 0, 0, 0, 23360); -- Lord of the Shado-Pan


DELETE FROM `creature_template_addon` WHERE `entry` IN (64790 /*64790 (Alpine Foxling)*/, 60866 /*60866 (Upland Eagle)*/, 64795 /*64795 (Tolai Hare)*/, 68846 /*68846 (Kun-Lai Runt)*/, 60491 /*60491 (Sha of Anger) - Sha of Anger Skybox, Energize 2/s*/, 63645 /*63645 (Unmelting Icicle)*/, 63648 /*63648 (Mushan Pie)*/, 63650 /*63650 (Dejected Grummle Trader)*/, 63646 /*63646 (Hawktail)*/, 60937 /*60937 (Shado-Pan Guardian)*/, 63644 /*63644 (Golden Snow)*/, 61848 /*61848 (Wild Onyx Serpent)*/, 60946 /*60946 (Chillwater Carp)*/, 63612 /*63612 (Snowshoe) - Cosmetic - Snowshoe on Foot*/, 63643 /*63643 (Shado-Pan Monastery Guard)*/, 64387 /*64387 (Master Snowdrift) - Kneel*/, 62236 /*62236 (Ban Bearheart) - Stealth, Stealth*/, 59811 /*59811 (Unstable Energy) - Unstable Energy Cosmetic, Unstable Energy Idle Cosmetic*/, 59808 /*59808 (Shado-Pan Stormbringer) - Charged Touch, Sha Corruption*/, 58198 /*58198 (Shado-Pan Disciple)*/, 65257 /*65257 (Unleashed Sha)*/, 56926 /*56926 (Arc Lightning Stalker)*/, 56884 /*56884 (Taran Zhu) - Sha Corruption*/, 58803 /*58803 (Residual Hatred) - Ancestral Brewmaster Cosmetic*/, 58812 /*58812 (Hateful Essence) - Pool of Shadows*/, 58810 /*58810 (Fragment of Hatred) - Ancestral Brewmaster Cosmetic (Male Pandaren)*/, 58794 /*58794 (Slain Shado-Pan Defender) - Permanent Feign Death (Drowned Anim Kit + Stun)*/, 58807 /*58807 (Vestige of Hatred) - Ancestral Brewmaster Cosmetic (Male Pandaren)*/, 59036 /*59036 (Slain Shado-pan Initiate) - Permanent Feign Death*/, 56747 /*56747 (Gu Cloudstrike)*/, 58201 /*58201 (Sha Manifestation)*/, 56767 /*56767 (Shado-Pan Fire Archer) - Fire Arrow*/, 56541 /*56541 (Master Snowdrift)*/, 63717 /*63717 (Shado-Pan Disciple)*/, 67229 /*67229 (Master Snowdrift)*/, 56472 /*56472 (Fragrant Lotus)*/, 56678 /*56678 (Jade Staff) - Ride Vehicle Hardcoded*/, 56473 /*56473 (Flying Snow) - Slice and Dice*/, 65414 /*65414 (Ethereal Sha) - Mod Scale 95-120%*/, 56395 /*56395 (Shado-Pan Novice) - Mod Scale 95-120%*/, 56870 /*56870 (Master Snowdrift) - Jump to Boss Fight Position [DNT]*/, 56765 /*56765 (Destroying Sha) - Shadowform*/, 56763 /*56763 (Regenerating Sha)*/, 56764 /*56764 (Consuming Sha)*/, 56766 /*56766 (Volatile Energy) - Explosive*/, 59895 /*59895 (Shado-Pan Monk) - Permanent Feign Death (Stun, Untrackable)*/, 56505 /*56505 (Shado-pan Referee) - Ping Aura*/, 64549 /*64549 (Shado-Pan Ice Archer) - Ice Arrow*/, 56397 /*56397 (Position)*/, 56719 /*56719 (Sha of Violence) - Ignore Combat Until Hit by Player or Pet, Reduce Critical Strike Chance -100%*/, 60162 /*60162 (Training Target)*/, 65407 /*65407 (Shado-Pan Novice) - Mod Scale 95-120%*/, 64550 /*64550 (Ice Arrow Target)*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(64790, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64790 (Alpine Foxling)
(60866, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 60866 (Upland Eagle)
(64795, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64795 (Tolai Hare)
(68846, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 68846 (Kun-Lai Runt)
(60491, 0, 0, 0, 1, 0, 0, 0, 0, '127592 119545'), -- 60491 (Sha of Anger) - Sha of Anger Skybox, Energize 2/s
(63645, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63645 (Unmelting Icicle)
(63648, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63648 (Mushan Pie)
(63650, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63650 (Dejected Grummle Trader)
(63646, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63646 (Hawktail)
(60937, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 60937 (Shado-Pan Guardian)
(63644, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63644 (Golden Snow)
(61848, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 61848 (Wild Onyx Serpent)
(60946, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 60946 (Chillwater Carp)
(63612, 0, 0, 0, 1, 0, 0, 0, 0, '124148'), -- 63612 (Snowshoe) - Cosmetic - Snowshoe on Foot
(63643, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63643 (Shado-Pan Monastery Guard)
(64387, 0, 0, 0, 1, 0, 0, 0, 0, '125920'), -- 64387 (Master Snowdrift) - Kneel
(62236, 0, 0, 0, 1, 0, 0, 0, 0, '114943 58506'), -- 62236 (Ban Bearheart) - Stealth, Stealth
(59811, 0, 0, 50331648, 1, 0, 0, 0, 0, '115637 128234'), -- 59811 (Unstable Energy) - Unstable Energy Cosmetic, Unstable Energy Idle Cosmetic
(59808, 0, 0, 0, 1, 0, 0, 0, 0, '115020 124337'), -- 59808 (Shado-Pan Stormbringer) - Charged Touch, Sha Corruption
(58198, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58198 (Shado-Pan Disciple)
(65257, 0, 0, 7, 1, 0, 0, 0, 0, ''), -- 65257 (Unleashed Sha)
(56926, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56926 (Arc Lightning Stalker)
(56884, 0, 0, 0, 1, 0, 0, 0, 0, '131530'), -- 56884 (Taran Zhu) - Sha Corruption
(58803, 0, 0, 0, 1, 0, 0, 0, 0, '114955'), -- 58803 (Residual Hatred) - Ancestral Brewmaster Cosmetic
(58812, 0, 0, 0, 1, 0, 0, 0, 0, '112929'), -- 58812 (Hateful Essence) - Pool of Shadows
(58810, 0, 0, 0, 1, 0, 0, 0, 0, '127600'), -- 58810 (Fragment of Hatred) - Ancestral Brewmaster Cosmetic (Male Pandaren)
(58794, 0, 0, 0, 1, 0, 0, 0, 0, '115162'), -- 58794 (Slain Shado-Pan Defender) - Permanent Feign Death (Drowned Anim Kit + Stun)
(58807, 0, 0, 0, 1, 0, 0, 0, 0, '127600'), -- 58807 (Vestige of Hatred) - Ancestral Brewmaster Cosmetic (Male Pandaren)
(59036, 0, 0, 0, 1, 0, 0, 0, 0, '29266'), -- 59036 (Slain Shado-pan Initiate) - Permanent Feign Death
(56747, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56747 (Gu Cloudstrike)
(58201, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58201 (Sha Manifestation)
(56767, 0, 0, 0, 0, 0, 0, 0, 0, '106992'), -- 56767 (Shado-Pan Fire Archer) - Fire Arrow
(56541, 0, 0, 8, 1, 0, 0, 0, 0, ''), -- 56541 (Master Snowdrift)
(63717, 0, 0, 7, 1, 0, 0, 0, 0, ''), -- 63717 (Shado-Pan Disciple)
(67229, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 67229 (Master Snowdrift)
(56472, 0, 0, 8, 1, 0, 0, 0, 0, ''), -- 56472 (Fragrant Lotus)
(56678, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 56678 (Jade Staff) - Ride Vehicle Hardcoded
(56473, 0, 0, 8, 1, 0, 0, 0, 0, '106652'), -- 56473 (Flying Snow) - Slice and Dice
(65414, 0, 0, 0, 1, 0, 0, 0, 0, '123978'), -- 65414 (Ethereal Sha) - Mod Scale 95-120%
(56395, 0, 0, 8, 1, 0, 0, 0, 0, '123978'), -- 56395 (Shado-Pan Novice) - Mod Scale 95-120%
(56870, 0, 0, 0, 1, 0, 0, 0, 0, '127761'), -- 56870 (Master Snowdrift) - Jump to Boss Fight Position [DNT]
(56765, 0, 0, 0, 1, 0, 0, 0, 0, '54357'), -- 56765 (Destroying Sha) - Shadowform
(56763, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56763 (Regenerating Sha)
(56764, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56764 (Consuming Sha)
(56766, 0, 0, 0, 1, 0, 0, 0, 0, '115055'), -- 56766 (Volatile Energy) - Explosive
(59895, 0, 0, 262144, 1, 0, 0, 0, 0, '119073'), -- 59895 (Shado-Pan Monk) - Permanent Feign Death (Stun, Untrackable)
(56505, 0, 0, 0, 1, 0, 0, 0, 0, '121256'), -- 56505 (Shado-pan Referee) - Ping Aura
(64549, 0, 0, 0, 0, 0, 0, 0, 0, '126111'), -- 64549 (Shado-Pan Ice Archer) - Ice Arrow
(56397, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56397 (Position)
(56719, 0, 0, 0, 1, 0, 0, 0, 0, '124418 64481'), -- 56719 (Sha of Violence) - Ignore Combat Until Hit by Player or Pet, Reduce Critical Strike Chance -100%
(60162, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 60162 (Training Target)
(65407, 0, 0, 0, 1, 0, 0, 0, 0, '123978'), -- 65407 (Shado-Pan Novice) - Mod Scale 95-120%
(64550, 0, 0, 0, 1, 0, 0, 0, 0, ''); -- 64550 (Ice Arrow Target)

UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `unit_flags`=295744 WHERE `entry`=64387; -- Master Snowdrift
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59811; -- Unstable Energy
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=59808; -- Shado-Pan Stormbringer
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=58198; -- Shado-Pan Disciple
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `unit_flags3`=1 WHERE `entry`=65257; -- Unleashed Sha
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56926; -- Arc Lightning Stalker
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=35, `unit_flags`=294992, `unit_flags3`=1 WHERE `entry`=56884; -- Taran Zhu
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=58803; -- Residual Hatred
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `unit_flags3`=1 WHERE `entry`=58812; -- Hateful Essence
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=58810; -- Fragment of Hatred
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `npcflag`=16777216, `unit_flags3`=1, `dynamicflags`=32 WHERE `entry`=58794; -- Slain Shado-Pan Defender
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=58807; -- Vestige of Hatred
UPDATE `creature_template` SET `unit_flags3`=1, `dynamicflags`=32 WHERE `entry`=59036; -- Slain Shado-pan Initiate
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `unit_flags`=32832 WHERE `entry`=56747; -- Gu Cloudstrike
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `unit_flags3`=1 WHERE `entry`=58201; -- Sha Manifestation
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `unit_flags3`=1 WHERE `entry`=56767; -- Shado-Pan Fire Archer
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=2244, `unit_flags`=32848 WHERE `entry`=56541; -- Master Snowdrift
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `unit_flags`=33554688, `unit_flags3`=1 WHERE `entry`=63717; -- Shado-Pan Disciple
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92 WHERE `entry`=67229; -- Master Snowdrift
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `faction`=2263, `unit_flags`=16 WHERE `entry`=56472; -- Fragrant Lotus
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=56678; -- Jade Staff
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `faction`=2263, `BaseAttackTime`=1333, `unit_flags`=16 WHERE `entry`=56473; -- Flying Snow
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=65414; -- Ethereal Sha
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `faction`=2244, `unit_flags`=32784 WHERE `entry`=56395; -- Shado-Pan Novice
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=2244, `unit_flags3`=1 WHERE `entry`=56870; -- Master Snowdrift
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=56765; -- Destroying Sha
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=56763; -- Regenerating Sha
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91 WHERE `entry`=56764; -- Consuming Sha
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=56766; -- Volatile Energy
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `dynamicflags`=32 WHERE `entry`=59895; -- Shado-Pan Monk
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56505; -- Shado-pan Referee
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `unit_flags3`=1 WHERE `entry`=64549; -- Shado-Pan Ice Archer
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56397; -- Position
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92 WHERE `entry`=56719; -- Sha of Violence
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=60162; -- Training Target
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=64550; -- Ice Arrow Target

UPDATE `gameobject_template` SET `Data6`=0, `VerifiedBuild`=23360 WHERE `entry`=213889; -- Taran Zhu's Personal Stash
UPDATE `gameobject_template` SET `Data6`=0, `VerifiedBuild`=23360 WHERE `entry`=214518; -- Snowdrift's Possessions
UPDATE `gameobject_template` SET `Data8`=0, `VerifiedBuild`=23360 WHERE `entry`=212908; -- Shadowpan Hideout - Weaponmaster Gauntlet - Collision

UPDATE `gameobject_template_addon` SET `faction`=1375 WHERE `entry`=214548; -- Wind Wall
UPDATE `gameobject_template_addon` SET `faction`=1375, `flags`=32 WHERE `entry`=212120; -- Mantid Siege Tank

DELETE FROM `creature_template_addon` WHERE `entry` IN (66479 /*66479 (Reef Thresher)*/, 69815 /*69815 (Silentstrike Pterrorwing)*/, 66476 /*66476 (Reef Pincher)*/, 62205 /*62205 (Wing Leader Ner'onok) - Mantid Wings*/, 61483 /*61483 (Reinforcements Summoner) - Summon Mantid Soldier*/, 62633 /*62633 (Sik'thik Builder)*/, 62632 /*62632 (Sik'thik Engineer)*/, 67093 /*67093 (Sik'thik Battle-Mender)*/, 63565 /*63565 (Mantid Catapult)*/, 61436 /*61436 (Sik'thik Bladedancer)*/, 61434 /*61434 (Sik'thik Vanguard)*/, 61485 /*61485 (General Pa'valak)*/, 62348 /*62348 (Sik'thik Soldier) - Catapult Channel*/, 61629 /*61629 (Sappling Summon Dest)*/, 61967 /*61967 (Resin Stalker)*/, 61928 /*61928 (Sik'thik Guardian)*/, 64520 /*64520 (Shado-Pan Prisoner)*/, 61929 /*61929 (Sik'thik Amber-Weaver)*/, 61965 /*61965 (Sap Puddle) - Sap Puddle*/, 61964 /*61964 (Sap Spray) - Sap Spray*/, 61910 /*61910 (Resin Flake)*/, 61699 /*61699 (Sik'thik Amberwing) - Green Mantid Wings, Mantid Wings*/, 61634 /*61634 (Commander Vo'jak) - Frantic Fighter*/, 61701 /*61701 (Sik'thik Warrior)*/, 62684 /*62684 (Barrel Target)*/, 66699 /*66699 (Invisible Stalker) - Gongable*/, 57478 /*57478 (Invisible Stalker)*/, 61817 /*61817 (Mantid Tar Keg) - Mantid Barrel Inactive*/, 61670 /*61670 (Sik'thik Demolisher) - Carrying Explosives*/, 63106 /*63106 (Sik'thik Swarmer) - Slowed*/, 64517 /*64517 (Shado-Master Chum Kiu) - Stealth*/, 61567 /*61567 (Vizier Jin'bak)*/, 61613 /*61613 (Sap Puddle) - Sap Puddle*/, 62091 /*62091 (Sik'thik Flyer) - Mantid Wings, Mantid Wings*/, 62795 /*62795 (Sik'thik Warden)*/, 61620 /*61620 (Yang Ironclaw)*/, 62794 /*62794 (Lo Chu)*/, 61812 /*61812 (Li Chu)*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(66479, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 66479 (Reef Thresher)
(69815, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 69815 (Silentstrike Pterrorwing)
(66476, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 66476 (Reef Pincher)
(62205, 0, 0, 0, 1, 0, 0, 0, 0, '126303'), -- 62205 (Wing Leader Ner'onok) - Mantid Wings
(61483, 0, 0, 0, 1, 0, 0, 0, 0, '119781'), -- 61483 (Reinforcements Summoner) - Summon Mantid Soldier
(62633, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 62633 (Sik'thik Builder)
(62632, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 62632 (Sik'thik Engineer)
(67093, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 67093 (Sik'thik Battle-Mender)
(63565, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63565 (Mantid Catapult)
(61436, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61436 (Sik'thik Bladedancer)
(61434, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61434 (Sik'thik Vanguard)
(61485, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61485 (General Pa'valak)
(62348, 0, 0, 0, 1, 0, 0, 0, 0, '124067'), -- 62348 (Sik'thik Soldier) - Catapult Channel
(61629, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 61629 (Sappling Summon Dest)
(61967, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 61967 (Resin Stalker)
(61928, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61928 (Sik'thik Guardian)
(64520, 0, 0, 1, 1, 0, 0, 0, 0, ''), -- 64520 (Shado-Pan Prisoner)
(61929, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61929 (Sik'thik Amber-Weaver)
(61965, 0, 0, 50331648, 1, 0, 0, 0, 0, '120591'), -- 61965 (Sap Puddle) - Sap Puddle
(61964, 0, 0, 50331648, 1, 0, 0, 0, 0, '120586'), -- 61964 (Sap Spray) - Sap Spray
(61910, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61910 (Resin Flake)
(61699, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316 132441'), -- 61699 (Sik'thik Amberwing) - Green Mantid Wings, Mantid Wings
(61634, 0, 0, 0, 1, 0, 0, 0, 0, '120757'), -- 61634 (Commander Vo'jak) - Frantic Fighter
(61701, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61701 (Sik'thik Warrior)
(62684, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 62684 (Barrel Target)
(66699, 0, 0, 0, 1, 0, 0, 0, 0, '131049'), -- 66699 (Invisible Stalker) - Gongable
(57478, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 57478 (Invisible Stalker)
(61817, 0, 0, 0, 1, 0, 0, 0, 0, '123218'), -- 61817 (Mantid Tar Keg) - Mantid Barrel Inactive
(61670, 0, 0, 0, 1, 0, 0, 0, 0, '121986'), -- 61670 (Sik'thik Demolisher) - Carrying Explosives
(63106, 0, 0, 0, 1, 0, 0, 0, 0, '120270'), -- 63106 (Sik'thik Swarmer) - Slowed
(64517, 0, 0, 0, 1, 0, 0, 0, 0, '86603'), -- 64517 (Shado-Master Chum Kiu) - Stealth
(61567, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61567 (Vizier Jin'bak)
(61613, 0, 0, 50331648, 1, 0, 0, 0, 0, '119939'), -- 61613 (Sap Puddle) - Sap Puddle
(62091, 0, 0, 50331648, 1, 0, 0, 0, 0, '126320 132441'), -- 62091 (Sik'thik Flyer) - Mantid Wings, Mantid Wings
(62795, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 62795 (Sik'thik Warden)
(61620, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61620 (Yang Ironclaw)
(62794, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 62794 (Lo Chu)
(61812, 0, 0, 0, 1, 0, 0, 0, 0, ''); -- 61812 (Li Chu)

UPDATE `creature_template_addon` SET `auras`='122729' WHERE `entry`=62821; -- 62821 (Mystic Birdhat)
UPDATE `creature_template_addon` SET `auras`='122729' WHERE `entry`=62822; -- 62822 (Cousin Slowhands)


UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61483; -- Reinforcements Summoner
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=63565; -- Mantid Catapult
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61629; -- Sappling Summon Dest
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61967; -- Resin Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61965; -- Sap Puddle
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61964; -- Sap Spray
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61699; -- Sik'thik Amberwing
UPDATE `creature_template` SET `unit_flags`=32832 WHERE `entry`=61634; -- Commander Vo'jak
UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry`=61701; -- Sik'thik Warrior
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=66699; -- Invisible Stalker
UPDATE `creature_template` SET `npcflag`=16777216, `unit_flags`=0, `unit_flags3`=1 WHERE `entry`=61817; -- Mantid Tar Keg
UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry`=61670; -- Sik'thik Demolisher
UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry`=63106; -- Sik'thik Swarmer
UPDATE `creature_template` SET `unit_flags`=32832 WHERE `entry`=61567; -- Vizier Jin'bak
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61613; -- Sap Puddle
UPDATE `creature_template` SET `speed_walk`=0.5, `speed_run`=0.496031433343887329 WHERE `entry`=62795; -- Sik'thik Warden
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61620; -- Yang Ironclaw
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=62794; -- Lo Chu
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=61812; -- Li Chu

UPDATE `gameobject_template` SET `Data8`=0, `VerifiedBuild`=23360 WHERE `entry`=214838; -- Ner'onok Extra Collision
UPDATE `gameobject_template` SET `VerifiedBuild`=23360 WHERE `entry`=213251; -- Tiger Temple Invisible Wall
UPDATE `gameobject_template` SET `Data8`=0, `VerifiedBuild`=23360 WHERE `entry`=214548; -- Wind Wall
UPDATE `gameobject_template` SET `VerifiedBuild`=23360 WHERE `entry`=212120; -- Mantid Siege Tank

UPDATE `gameobject_template_addon` SET `faction`=114, `flags`=32 WHERE `entry`=211127; -- Barrel Door

DELETE FROM `creature_template_addon` WHERE `entry` IN (59641 /*59641 (Monstrous Plainshawk)*/, 64787 /*64787 (Sifang Otter)*/, 62346 /*62346 (Galleon)*/, 62355 /*62355 (Galleon Cannon) - Ride Vehicle, Invisibility and Stealth Detection*/, 63094 /*63094 (Malayan Quillrat)*/, 59005 /*59005 (Stormstout Brewer)*/, 64789 /*64789 (Softshell Snapling)*/, 64361 /*64361 (Chen Stormstout)*/, 59479 /*59479 (Yan-Zhu the Uncasked) - Sudsy Brew*/, 66413 /*66413 (Yeasty Brew Alemental)*/, 59518 /*59518 (Bloated Brew Alemental) - Bloating Brew*/, 56731 /*56731 (Habanero Brew) - Habanero-Infused*/, 56927 /*56927 (Hozen Party Animal) - Hozu Party Hat 4*/, 56867 /*56867 (Fiery Trickster)*/, 65392 /*65392 (Nibbler) - Nibbler Cosmetic*/, 56717 /*56717 (Hoptallus)*/, 59464 /*59464 (Hopper) - Hopper Anim Replacement Set*/, 59429 /*59429 (Explosive Brew Barrel) - Ride Vehicle Hardcoded, Blinking Explosion Cosmetic*/, 59075 /*59075 (Ancestral Brewmaster) - Ancestral Brewmaster Cosmetic, Wasted*/, 59522 /*59522 (Sudsy Brew Alemental) - Sudsy Brew*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(59641, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 59641 (Monstrous Plainshawk)
(64787, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64787 (Sifang Otter)
(62346, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 62346 (Galleon)
(62355, 0, 0, 0, 1, 0, 0, 0, 0, '70640 18950'), -- 62355 (Galleon Cannon) - Ride Vehicle, Invisibility and Stealth Detection
(63094, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63094 (Malayan Quillrat)
(59005, 0, 0, 1, 1, 0, 0, 0, 0, ''), -- 59005 (Stormstout Brewer)
(64789, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64789 (Softshell Snapling)
(64361, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64361 (Chen Stormstout)
(59479, 0, 0, 50331648, 1, 0, 0, 0, 0, '114933'), -- 59479 (Yan-Zhu the Uncasked) - Sudsy Brew
(66413, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 66413 (Yeasty Brew Alemental)
(59518, 0, 0, 0, 1, 0, 0, 0, 0, '114929'), -- 59518 (Bloated Brew Alemental) - Bloating Brew
(56731, 0, 0, 0, 1, 0, 0, 0, 0, '106787'), -- 56731 (Habanero Brew) - Habanero-Infused
(56927, 0, 0, 0, 1, 0, 0, 0, 0, '127854'), -- 56927 (Hozen Party Animal) - Hozu Party Hat 4
(56867, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 56867 (Fiery Trickster)
(65392, 0, 0, 0, 1, 0, 0, 0, 0, '128188'), -- 65392 (Nibbler) - Nibbler Cosmetic
(56717, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56717 (Hoptallus)
(59464, 0, 0, 0, 1, 0, 0, 0, 0, '114284'), -- 59464 (Hopper) - Hopper Anim Replacement Set
(59429, 0, 0, 0, 1, 0, 0, 0, 0, '46598 114287'), -- 59429 (Explosive Brew Barrel) - Ride Vehicle Hardcoded, Blinking Explosion Cosmetic
(59075, 0, 0, 3, 1, 0, 0, 0, 0, '113124 114370'), -- 59075 (Ancestral Brewmaster) - Ancestral Brewmaster Cosmetic, Wasted
(59522, 0, 0, 0, 1, 0, 0, 0, 0, '119418'); -- 59522 (Sudsy Brew Alemental) - Sudsy Brew

UPDATE `creature_template_addon` SET `auras`='114353' WHERE `entry`=55091; -- 55091 (General Purpose Bunny JMF (Look 2 - Flying, Infinite AOI))

UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=62355; -- Galleon Cannon
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=64361; -- Chen Stormstout
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_walk`=1.555556058883666992, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2099200, `VehicleId`=584 WHERE `entry`=59479; -- Yan-Zhu the Uncasked
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=1.555556058883666992, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2048 WHERE `entry`=66413; -- Yeasty Brew Alemental
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_walk`=1.555556058883666992, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2048 WHERE `entry`=59518; -- Bloated Brew Alemental
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=1.20000004768371582, `speed_run`=0.428571432828903198, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=32768, `unit_flags3`=1, `HoverHeight`=6 WHERE `entry`=56731; -- Habanero Brew
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768 WHERE `entry`=56927; -- Hozen Party Animal
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=1.20000004768371582, `speed_run`=0.428571432828903198, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=56867; -- Fiery Trickster
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=1.190475702285766601, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags3`=1, `VehicleId`=2414 WHERE `entry`=65392; -- Nibbler
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_run`=1.428571462631225585, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2099200, `unit_flags3`=1 WHERE `entry`=56717; -- Hoptallus
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=1.60000002384185791, `speed_run`=0.571428596973419189, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `VehicleId`=2059 WHERE `entry`=59464; -- Hopper
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554432, `unit_flags2`=67110912, `unit_flags3`=1, `HoverHeight`=2.799999952316284179 WHERE `entry`=59429; -- Explosive Brew Barrel
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32832, `unit_flags2`=2048 WHERE `entry`=59075; -- Ancestral Brewmaster
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_walk`=1.555556058883666992, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2048 WHERE `entry`=59522; -- Sudsy Brew Alemental


UPDATE `gameobject_template` SET `Data8`=0, `Data10`=1, `VerifiedBuild`=23360 WHERE `entry`=211127; -- Barrel Door

DELETE FROM `creature_template_addon` WHERE `entry` IN (57242 /*57242 (Elder Sage Wind-Yi)*/, 57326 /*57326 (Yu'lon Guardian)*/, 62999 /*62999 (Temple Snake)*/, 58698 /*58698 (Temple Snake)*/, 56812 /*56812 (Yu'lon Priest)*/, 56439 /*56439 (Sha of Doubt)*/, 56586 /*56586 (Fountain Stalker)*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(57242, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 57242 (Elder Sage Wind-Yi)
(57326, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 57326 (Yu'lon Guardian)
(62999, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 62999 (Temple Snake)
(58698, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58698 (Temple Snake)
(56812, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56812 (Yu'lon Priest)
(56439, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56439 (Sha of Doubt)
(56586, 0, 0, 0, 1, 0, 0, 0, 0, ''); -- 56586 (Fountain Stalker)

UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_walk`=2.799999952316284179, `speed_run`=1.428571462631225585, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32832, `unit_flags2`=2097152 WHERE `entry`=56439; -- Sha of Doubt
UPDATE `creature_template` SET `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554432, `unit_flags2`=2048, `unit_flags3`=1 WHERE `entry`=56586; -- Fountain Stalker

UPDATE `gameobject_template_addon` SET `faction`=114, `flags`=32 WHERE `entry`=214252; -- Rope
UPDATE `gameobject_template_addon` SET `faction`=35 WHERE `entry`=211284; -- Lever
UPDATE `gameobject_template_addon` SET `faction`=114, `flags`=32 WHERE `entry`=213507; -- Signal Fire
UPDATE `gameobject_template_addon` SET `flags`=48 WHERE `entry`=211129; -- Signal Flame

DELETE FROM `creature_template_addon` WHERE `entry` IN (63976 /*63976 (Krik'thik Needler) - Blue Mantid Wings*/, 57444 /*57444 (Serpent Rider) - Ride Vehicle Hardcoded, HMC Dummy Effect Periodic Aura A*/, 65336 /*65336 (War Serpent)*/, 58994 /*58994 (Battle Ring Controller)*/, 50356 /*50356 (Krol the Blade)*/, 58505 /*58505 (Golden Lotus Defender)*/, 65335 /*65335 (War Serpent)*/, 60931 /*60931 (Training Target)*/, 58731 /*58731 (Aspiring Trainee)*/, 58743 /*58743 (Yumi Goldenpaw)*/, 67004 /*67004 (Aspiring Trainee)*/, 53714 /*53714 (Training Target)*/, 63973 /*63973 (Krik'thik Swarmer)*/, 58065 /*58065 (General Purpose Bunny (DLA))*/, 62112 /*62112 (Bowmistress Li) - Pandaren Arrows 01 Stack*/, 61968 /*61968 (Shado-Pan Marksman)*/, 58449 /*58449 (Wooly Yak)*/, 63497 /*63497 (Mai of the Wall)*/, 65172 /*65172 (Len at Arms)*/, 58992 /*58992 (Shado-Pan Trainee)*/, 58448 /*58448 (Black Bengal Goat)*/, 61981 /*61981 (Dreadspinner Tender) - Permanent Feign Death*/, 62143 /*62143 (Dreadspinner Hatchling)*/, 62000 /*62000 (Dreadspinner) - Ride Vehicle*/, 62077 /*62077 (Dreadspinner Egg)*/, 65206 /*65206 (Golden Civet)*/, 56906 /*56906 (Saboteur Kip'tilak) - Green Mantid Wings*/, 58109 /*58109 (Mantid Infiltrator Rope Stalker)*/, 56877 /*56877 (Raigonn) - Impervious Carapace*/, 59836 /*59836 (Panda Seat) - Ride Vehicle Hardcoded*/, 64710 /*64710 (Rope) - Rope Visual*/, 56895 /*56895 (Weak Spot) - Vulnerability Visual*/, 64740 /*64740 (Rope Seat)*/, 66905 /*66905 (Pandaren Cannoneer)*/, 61213 /*61213 (Krik'thik Conscript)*/, 60502 /*60502 (Pandaren Disciple)*/, 64467 /*64467 (Bowmistress Li) - Pandaren Arrows 01 Stack*/, 63192 /*63192 (Cosmetic Client Stalker) - Mantid Army*/, 59886 /*59886 (Great Wall Panda Archer Target Spawner)*/, 63992 /*63992 (Great Wall Explosion Target Stalker 1)*/, 61177 /*61177 (Raigonn)*/, 56799 /*56799 (Krik'thik Bombadier) - Green Mantid Wings, Mantid Wings*/, 56502 /*56502 (Panda Archer Target Gate Stalker) - Ride Vehicle Hardcoded*/, 58844 /*58844 (Panda Tar Tosser)*/, 66904 /*66904 (Artillery) - Sparkles Visual*/, 59820 /*59820 (Pandaren Cannoneer)*/, 59819 /*59819 (Artillery) - Sparkles Visual*/, 59723 /*59723 (Great Wall Explosion Caster Stalker)*/, 59721 /*59721 (Great Wall Explosion Target Stalker 2)*/, 58824 /*58824 (Courtyard Defender)*/, 63991 /*63991 (Great Wall Explosion Target Stalker 3)*/, 56636 /*56636 (Commander Ri'mok)*/, 60415 /*60415 (Flak Cannon) - Cosmetic - Loot Sparkles (3.00)*/, 59794 /*59794 (Krik'thik Disruptor) - Green Mantid Wings*/, 64553 /*64553 ("Lighting the Way" Kill Credit)*/, 65555 /*65555 (Bonfire Teleport Stalker)*/, 59955 /*59955 (Krik'thik Glider) - Green Mantid Wings*/, 59954 /*59954 (Krik'thik Glider) - Green Mantid Wings*/, 59800 /*59800 (Krik'thik Rager) - Ride Vehicle Hardcoded*/, 59834 /*59834 (Boss 3 Encounter Add Generator) - Great Wall Boss 3 Add Spawn Periodic Trigger*/, 56709 /*56709 (Flying Mantid Bombing Stalker) - Fire Bomb*/, 56822 /*56822 (Boss 2 North Stalker)*/, 56825 /*56825 (Boss 2 East Stalker)*/, 56745 /*56745 (Serpent's Spine Trainee)*/, 56742 /*56742 (Serpent's Spine Defender)*/, 56743 /*56743 (Serpent's Spine Defender)*/, 59750 /*59750 (Serpent's Spine Cannoneer)*/, 56823 /*56823 (Boss 2 West Stalker)*/, 56913 /*56913 (Boss 2 West/East Strafe Stalkers)*/, 60421 /*60421 (Flak Cannon Target Stalker)*/, 56824 /*56824 (Boss 2 South Stalker)*/, 56932 /*56932 (Boss 2 North/South Strafe Stalkers)*/, 56589 /*56589 (Striker Ga'dok) - Green Mantid Wings, Mantid Wings, Only Hover Idle [DNT]*/, 65537 /*65537 (Serpent's Spine Cannoneer) - Ride Vehicle Hardcoded*/, 58146 /*58146 (Serpent's Spine Defender)*/, 59801 /*59801 (Krik'thik Wind Shaper)*/, 58108 /*58108 (Krik'thik Infiltrator)*/, 63848 /*63848 (Great Wall Bonfire Target Stalker 2) - Great Wall Bonfire Dummy Flame*/, 59792 /*59792 (Great Wall Bonfire Caster Stalker)*/, 59793 /*59793 (Great Wall Bonfire Target Stalker 1)*/, 66419 /*66419 (Serpent's Spine Marksman) - Resurrect Requirement, Permanent Feign Death (Stun)*/, 56501 /*56501 (Panda Archer Target Stalker)*/, 56484 /*56484 (Serpent's Spine Marksman)*/, 56875 /*56875 (Krik'thik Demolisher) - Mod Scale 95-120%*/, 56876 /*56876 (Krik'thik Sapper) - Mod Scale 105-110%*/, 56880 /*56880 (Krik'thik Glider) - Green Mantid Wings*/, 56879 /*56879 (Krik'thik Glider) - Green Mantid Wings*/, 65400 /*65400 (Krik'thik Glider) - Green Mantid Wings*/, 65401 /*65401 (Krik'thik Glider) - Green Mantid Wings*/, 59892 /*59892 (Krik'thik Invader) - Ride Vehicle Hardcoded*/, 56706 /*56706 (Krik'thik Bombardier) - Green Mantid Wings, Mantid Wings*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(63976, 0, 0, 0, 1, 0, 0, 0, 0, '138393'), -- 63976 (Krik'thik Needler) - Blue Mantid Wings
(57444, 0, 0, 0, 1, 0, 0, 0, 0, '46598 130792'), -- 57444 (Serpent Rider) - Ride Vehicle Hardcoded, HMC Dummy Effect Periodic Aura A
(65336, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 65336 (War Serpent)
(58994, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58994 (Battle Ring Controller)
(50356, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 50356 (Krol the Blade)
(58505, 0, 0, 0, 256, 0, 0, 0, 0, ''), -- 58505 (Golden Lotus Defender)
(65335, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 65335 (War Serpent)
(60931, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 60931 (Training Target)
(58731, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58731 (Aspiring Trainee)
(58743, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58743 (Yumi Goldenpaw)
(67004, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 67004 (Aspiring Trainee)
(53714, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 53714 (Training Target)
(63973, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 63973 (Krik'thik Swarmer)
(58065, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58065 (General Purpose Bunny (DLA))
(62112, 0, 0, 0, 2, 0, 0, 0, 0, '120856'), -- 62112 (Bowmistress Li) - Pandaren Arrows 01 Stack
(61968, 0, 0, 0, 2, 0, 0, 0, 0, ''), -- 61968 (Shado-Pan Marksman)
(58449, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58449 (Wooly Yak)
(63497, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63497 (Mai of the Wall)
(65172, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 65172 (Len at Arms)
(58992, 0, 0, 8, 1, 0, 0, 0, 0, ''), -- 58992 (Shado-Pan Trainee)
(58448, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58448 (Black Bengal Goat)
(61981, 0, 0, 0, 1, 0, 0, 0, 0, '70628'), -- 61981 (Dreadspinner Tender) - Permanent Feign Death
(62143, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 62143 (Dreadspinner Hatchling)
(62000, 0, 0, 0, 1, 0, 0, 0, 0, '52391'), -- 62000 (Dreadspinner) - Ride Vehicle
(62077, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 62077 (Dreadspinner Egg)
(65206, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 65206 (Golden Civet)
(56906, 0, 0, 0, 1, 0, 0, 0, 0, '126316'), -- 56906 (Saboteur Kip'tilak) - Green Mantid Wings
(58109, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 58109 (Mantid Infiltrator Rope Stalker)
(56877, 0, 0, 0, 1, 0, 0, 0, 0, '107118'), -- 56877 (Raigonn) - Impervious Carapace
(59836, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 59836 (Panda Seat) - Ride Vehicle Hardcoded
(64710, 0, 0, 0, 1, 0, 0, 0, 0, '126493'), -- 64710 (Rope) - Rope Visual
(56895, 0, 0, 0, 1, 0, 0, 0, 0, '111682'), -- 56895 (Weak Spot) - Vulnerability Visual
(64740, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 64740 (Rope Seat)
(66905, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 66905 (Pandaren Cannoneer)
(61213, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61213 (Krik'thik Conscript)
(60502, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 60502 (Pandaren Disciple)
(64467, 0, 0, 0, 2, 0, 0, 0, 0, '120856'), -- 64467 (Bowmistress Li) - Pandaren Arrows 01 Stack
(63192, 0, 0, 0, 1, 0, 0, 0, 0, '123463'), -- 63192 (Cosmetic Client Stalker) - Mantid Army
(59886, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59886 (Great Wall Panda Archer Target Spawner)
(63992, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63992 (Great Wall Explosion Target Stalker 1)
(61177, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61177 (Raigonn)
(56799, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316 132441'), -- 56799 (Krik'thik Bombadier) - Green Mantid Wings, Mantid Wings
(56502, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 56502 (Panda Archer Target Gate Stalker) - Ride Vehicle Hardcoded
(58844, 0, 0, 0, 2, 0, 0, 0, 0, ''), -- 58844 (Panda Tar Tosser)
(66904, 0, 0, 0, 1, 0, 0, 0, 0, '115088'), -- 66904 (Artillery) - Sparkles Visual
(59820, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59820 (Pandaren Cannoneer)
(59819, 0, 0, 0, 1, 0, 0, 0, 0, '115088'), -- 59819 (Artillery) - Sparkles Visual
(59723, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59723 (Great Wall Explosion Caster Stalker)
(59721, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59721 (Great Wall Explosion Target Stalker 2)
(58824, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58824 (Courtyard Defender)
(63991, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63991 (Great Wall Explosion Target Stalker 3)
(56636, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56636 (Commander Ri'mok)
(60415, 0, 0, 0, 1, 0, 0, 0, 0, '92406'), -- 60415 (Flak Cannon) - Cosmetic - Loot Sparkles (3.00)
(59794, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316'), -- 59794 (Krik'thik Disruptor) - Green Mantid Wings
(64553, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 64553 ("Lighting the Way" Kill Credit)
(65555, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 65555 (Bonfire Teleport Stalker)
(59955, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316'), -- 59955 (Krik'thik Glider) - Green Mantid Wings
(59954, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316'), -- 59954 (Krik'thik Glider) - Green Mantid Wings
(59800, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 59800 (Krik'thik Rager) - Ride Vehicle Hardcoded
(59834, 0, 0, 0, 1, 0, 0, 0, 0, '115052'), -- 59834 (Boss 3 Encounter Add Generator) - Great Wall Boss 3 Add Spawn Periodic Trigger
(56709, 0, 0, 0, 1, 0, 0, 0, 0, '106875'), -- 56709 (Flying Mantid Bombing Stalker) - Fire Bomb
(56822, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56822 (Boss 2 North Stalker)
(56825, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56825 (Boss 2 East Stalker)
(56745, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56745 (Serpent's Spine Trainee)
(56742, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56742 (Serpent's Spine Defender)
(56743, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56743 (Serpent's Spine Defender)
(59750, 0, 0, 8, 1, 0, 0, 0, 0, ''), -- 59750 (Serpent's Spine Cannoneer)
(56823, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56823 (Boss 2 West Stalker)
(56913, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56913 (Boss 2 West/East Strafe Stalkers)
(60421, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 60421 (Flak Cannon Target Stalker)
(56824, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56824 (Boss 2 South Stalker)
(56932, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56932 (Boss 2 North/South Strafe Stalkers)
(56589, 0, 0, 0, 1, 0, 2873, 0, 0, '126316 132441 127603'), -- 56589 (Striker Ga'dok) - Green Mantid Wings, Mantid Wings, Only Hover Idle [DNT]
(65537, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 65537 (Serpent's Spine Cannoneer) - Ride Vehicle Hardcoded
(58146, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58146 (Serpent's Spine Defender)
(59801, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59801 (Krik'thik Wind Shaper)
(58108, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 58108 (Krik'thik Infiltrator)
(63848, 0, 0, 50331648, 1, 0, 0, 0, 0, '124677'), -- 63848 (Great Wall Bonfire Target Stalker 2) - Great Wall Bonfire Dummy Flame
(59792, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59792 (Great Wall Bonfire Caster Stalker)
(59793, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 59793 (Great Wall Bonfire Target Stalker 1)
(66419, 0, 0, 0, 1, 0, 0, 0, 0, '111672 96733'), -- 66419 (Serpent's Spine Marksman) - Resurrect Requirement, Permanent Feign Death (Stun)
(56501, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56501 (Panda Archer Target Stalker)
(56484, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 56484 (Serpent's Spine Marksman)
(56875, 0, 0, 0, 1, 0, 0, 0, 0, '123978'), -- 56875 (Krik'thik Demolisher) - Mod Scale 95-120%
(56876, 0, 0, 0, 1, 0, 0, 0, 0, '127498'), -- 56876 (Krik'thik Sapper) - Mod Scale 105-110%
(56880, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316'), -- 56880 (Krik'thik Glider) - Green Mantid Wings
(56879, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316'), -- 56879 (Krik'thik Glider) - Green Mantid Wings
(65400, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316'), -- 65400 (Krik'thik Glider) - Green Mantid Wings
(65401, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316'), -- 65401 (Krik'thik Glider) - Green Mantid Wings
(59892, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 59892 (Krik'thik Invader) - Ride Vehicle Hardcoded
(56706, 0, 0, 50331648, 1, 0, 0, 0, 0, '126316 132441'); -- 56706 (Krik'thik Bombardier) - Green Mantid Wings; Mantid Wings

DELETE FROM `creature_equip_template` WHERE (`CreatureID`=58731 AND `ID`=1);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`) VALUES
(58731, 1, 73208, 0, 0, 73212, 0, 0, 0, 0, 0); -- Aspiring Trainee

UPDATE `creature_equip_template` SET `ItemID1`=0 WHERE (`CreatureID`=66905 AND `ID`=1); -- Pandaren Cannoneer
UPDATE `creature_equip_template` SET `ItemID1`=0 WHERE (`CreatureID`=59820 AND `ID`=1); -- Pandaren Cannoneer

DELETE FROM `gossip_menu` WHERE (`MenuId`=14559 AND `TextId`=20581);
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(14559, 20581, 23360); -- 64467 (Bowmistress Li)

UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0 WHERE `entry`=58505; -- Golden Lotus Defender
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=60931; -- Training Target
UPDATE `creature_template` SET `unit_flags`=0, `unit_flags2`=32768, `unit_flags3`=16 WHERE `entry`=53714; -- Training Target
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=63497; -- Mai of the Wall
UPDATE `creature_template` SET `unit_flags`=570720256, `unit_flags2`=2049, `unit_flags3`=1, `dynamicflags`=32 WHERE `entry`=61981; -- Dreadspinner Tender
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=62077; -- Dreadspinner Egg
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_run`=0.992062866687774658 WHERE `entry`=56906; -- Saboteur Kip'tilak
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=58109; -- Mantid Infiltrator Rope Stalker
UPDATE `creature_template` SET `speed_run`=1.714285731315612792 WHERE `entry`=56877; -- Raigonn
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags3`=1 WHERE `entry`=59836; -- Panda Seat
UPDATE `creature_template` SET `npcflag`=16777216, `speed_walk`=2, `speed_run`=0.714285731315612792, `unit_flags3`=1 WHERE `entry`=64710; -- Rope
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags`=32768, `unit_flags3`=1 WHERE `entry`=56895; -- Weak Spot
UPDATE `creature_template` SET `speed_run`=1.428571462631225585, `unit_flags3`=1 WHERE `entry`=64740; -- Rope Seat
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=66905; -- Pandaren Cannoneer
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_run`=0.992062866687774658 WHERE `entry`=61213; -- Krik'thik Conscript
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=64467; -- Bowmistress Li
UPDATE `creature_template` SET `speed_walk`=2, `speed_run`=0.714285731315612792, `unit_flags3`=1 WHERE `entry`=63192; -- Cosmetic Client Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59886; -- Great Wall Panda Archer Target Spawner
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=63992; -- Great Wall Explosion Target Stalker 1
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_run`=1.714285731315612792, `unit_flags3`=1 WHERE `entry`=61177; -- Raigonn
UPDATE `creature_template` SET `speed_run`=2 WHERE `entry`=56799; -- Krik'thik Bombadier
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56502; -- Panda Archer Target Gate Stalker
UPDATE `creature_template` SET `npcflag`=16777216, `speed_run`=1, `unit_flags`=33554432, `unit_flags3`=1 WHERE `entry`=66904; -- Artillery
UPDATE `creature_template` SET `unit_flags`=33554432, `unit_flags3`=1 WHERE `entry`=59820; -- Pandaren Cannoneer
UPDATE `creature_template` SET `npcflag`=16777216, `speed_run`=1, `unit_flags3`=1 WHERE `entry`=59819; -- Artillery
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59723; -- Great Wall Explosion Caster Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59721; -- Great Wall Explosion Target Stalker 2
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=63991; -- Great Wall Explosion Target Stalker 3
UPDATE `creature_template` SET `speed_run`=2 WHERE `entry`=56636; -- Commander Ri'mok
UPDATE `creature_template` SET `npcflag`=16777216, `speed_run`=1, `unit_flags`=0 WHERE `entry`=60415; -- Flak Cannon
UPDATE `creature_template` SET `minlevel`=89, `maxlevel`=89, `speed_run`=2 WHERE `entry`=59794; -- Krik'thik Disruptor
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=65555; -- Bonfire Teleport Stalker
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags3`=1 WHERE `entry`=59955; -- Krik'thik Glider
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags3`=1 WHERE `entry`=59954; -- Krik'thik Glider
UPDATE `creature_template` SET `speed_run`=0.992062866687774658 WHERE `entry`=59800; -- Krik'thik Rager
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59834; -- Boss 3 Encounter Add Generator
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56709; -- Flying Mantid Bombing Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56822; -- Boss 2 North Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56825; -- Boss 2 East Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56823; -- Boss 2 West Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56913; -- Boss 2 West/East Strafe Stalkers
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=60421; -- Flak Cannon Target Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56824; -- Boss 2 South Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56932; -- Boss 2 North/South Strafe Stalkers
UPDATE `creature_template` SET `speed_run`=2 WHERE `entry`=56589; -- Striker Ga'dok
UPDATE `creature_template` SET `speed_run`=0.992062866687774658 WHERE `entry`=59801; -- Krik'thik Wind Shaper
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags`=0 WHERE `entry`=58108; -- Krik'thik Infiltrator
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=63848; -- Great Wall Bonfire Target Stalker 2
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59792; -- Great Wall Bonfire Caster Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=59793; -- Great Wall Bonfire Target Stalker 1
UPDATE `creature_template` SET `unit_flags3`=1, `dynamicflags`=32 WHERE `entry`=66419; -- Serpent's Spine Marksman
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56501; -- Panda Archer Target Stalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=56484; -- Serpent's Spine Marksman
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=0.992062866687774658 WHERE `entry`=56875; -- Krik'thik Demolisher
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=0.992062866687774658 WHERE `entry`=56876; -- Krik'thik Sapper
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags3`=1 WHERE `entry`=56880; -- Krik'thik Glider
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags3`=1 WHERE `entry`=56879; -- Krik'thik Glider
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags3`=1 WHERE `entry`=65400; -- Krik'thik Glider
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags3`=1 WHERE `entry`=65401; -- Krik'thik Glider
UPDATE `creature_template` SET `speed_run`=0.992062866687774658, `unit_flags`=0 WHERE `entry`=59892; -- Krik'thik Invader
UPDATE `creature_template` SET `speed_run`=2 WHERE `entry`=56706; -- Krik'thik Bombardier

UPDATE `gameobject_template` SET `IconName`='interact', `VerifiedBuild`=23360 WHERE `entry`=214252; -- Rope
UPDATE `gameobject_template` SET `IconName`='interact', `VerifiedBuild`=23360 WHERE `entry`=211284; -- Lever
UPDATE `gameobject_template` SET `IconName`='interact', `Data8`=0, `Data9`=1, `VerifiedBuild`=23360 WHERE `entry`=211129; -- Signal Flame
UPDATE `gameobject_template` SET `Data8`=0, `Data9`=1, `VerifiedBuild`=23360 WHERE `entry`=213507; -- Signal Fire

DELETE FROM `npc_text` WHERE `ID`=20581;
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextId0`, `BroadcastTextId1`, `BroadcastTextId2`, `BroadcastTextId3`, `BroadcastTextId4`, `BroadcastTextId5`, `BroadcastTextId6`, `BroadcastTextId7`, `VerifiedBuild`) VALUES
(20581, 1, 0, 0, 0, 0, 0, 0, 0, 64858, 0, 0, 0, 0, 0, 0, 0, 23360); -- 20581

DELETE FROM `gameobject_template_addon` WHERE `entry`=239902;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(239902, 1732, 0, 3255); -- Tanaan Planning Map

UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=240388; -- Apexis Vault
UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=236409; -- Prison Door
UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=236408; -- Prison Door
UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=237737; -- Prison Door
UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=237736; -- Prison Door
UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=237735; -- Prison Door
UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=237734; -- Prison Door
UPDATE `gameobject_template_addon` SET `flags`=8192 WHERE `entry`=232558; -- Goblin Lamppost
UPDATE `gameobject_template_addon` SET `faction`=114, `flags`=32 WHERE `entry`=231957; -- Gate
UPDATE `gameobject_template_addon` SET `faction`=114, `flags`=32 WHERE `entry`=231958; -- Gate
UPDATE `gameobject_template_addon` SET `faction`=114, `flags`=32 WHERE `entry`=233197; -- Iron Cage Door
UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=243762; -- Deactivated Ogre Waygate
UPDATE `gameobject_template_addon` SET `flags`=8192 WHERE `entry`=236629; -- Skeleton
UPDATE `gameobject_template_addon` SET `flags`=32 WHERE `entry`=241642; -- Tanaan Blood Orange
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=214827; -- Ancient Mogu Chest
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=214826; -- Ancient Mogu Chest
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=214825; -- Ancient Mogu Chest
UPDATE `gameobject_template_addon` SET `faction`=35, `flags`=2097152 WHERE `entry`=214794; -- Ancient Mogu Treasure
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=214824; -- Ancient Mogu Chest
UPDATE `gameobject_template_addon` SET `faction`=35, `flags`=16 WHERE `entry`=214813; -- Mogu Treasure
UPDATE `gameobject_template_addon` SET `faction`=94, `flags`=2097152 WHERE `entry`=214521; -- Legacy of the Clan Leaders
UPDATE `gameobject_template_addon` SET `faction`=1375 WHERE `entry`=213810; -- Doodad_PA_SecretSteps002

DELETE FROM `creature_template_addon` WHERE `entry` IN (87277 /*87277 (Glenn Ramtoss)*/, 87269 /*87269 (Ryan Quinn)*/, 87271 /*87271 (Danel Hornbark)*/, 87270 /*87270 (James Crowson)*/, 86433 /*86433 (Stormshield Officer)*/, 88076 /*88076 (Sand Scavenger)*/, 87048 /*87048 (Katherine Joplin)*/, 85905 /*85905 (Jaiden Trask)*/, 87763 /*87763 (Golden King Statue)*/, 87663 /*87663 (Officer Mirenda) - Invisibility and Stealth Detection*/, 87255 /*87255 (Cardenaas)*/, 85950 /*85950 (Trader Caerel)*/, 85955 /*85955 (Jaromir Gladetender)*/, 87657 /*87657 (Stormshield Guard) - Invisibility and Stealth Detection*/, 85921 /*85921 (Jie Wildblossom)*/, 87285 /*87285 (Allan Darksteel)*/, 86065 /*86065 (Private Tristan)*/, 87276 /*87276 (Aruajo Neto)*/, 85849 /*85849 (Kinkade Jakobs)*/, 86110 /*86110 (Daana Leafwhisper)*/, 85963 /*85963 (Orville Manfred)*/, 85959 /*85959 (Ernst ten Bosch)*/, 86408 /*86408 (Stormshield Guard) - Invisibility and Stealth Detection*/, 88194 /*88194 (Horse)*/, 86413 /*86413 (Stormshield Guard) - Invisibility and Stealth Detection*/, 86087 /*86087 (Stormshield Peasant)*/, 92823 /*92823 (Lion's Watch Cannoneer)*/, 95327 /*95327 (Doomwing Rylak)*/, 99180 /*99180 (Kluk'kluk)*/, 90972 /*90972 (Jaslyn Moongazer)*/, 91077 /*91077 (Apprentice Gharenda)*/, 92835 /*92835 (Watchman Darkfury)*/, 91201 /*91201 (Cloaked Shadowraider) - Cloaked Shadowraider Visual, Stealth*/, 99183 /*99183 (Renegade Ironworker)*/, 90965 /*90965 (Rangari Bodyguard)*/, 96147 /*96147 (Parvink)*/, 90309 /*90309 (Exarch Yrel) - Yrel's Shield*/, 92340 /*92340 (Gnomish Flying Machine)*/, 96130 /*96130 (Ravenspeaker Thelnaas)*/, 90971 /*90971 (Shima Islebreeze)*/, 90955 /*90955 (Lion's Watch Rifleman)*/, 90960 /*90960 (Skyguard Thann)*/, 90963 /*90963 (Angar Steelbellow)*/, 90962 /*90962 (Lion's Watch Engineer)*/, 95424 /*95424 (Dawn-Seeker Krisek)*/, 91089 /*91089 (Iron Cannon)*/, 79665 /*79665 (Laborer)*/, 90957 /*90957 (Lion's Watch Footman)*/, 90975 /*90975 (Lion's Watch Paladin)*/, 90977 /*90977 (Thaesus)*/, 90954 /*90954 (Laborer)*/, 92768 /*92768 (Hellfire Siege Tank)*/, 90967 /*90967 (Kirin Tor Magus) - Garrison Magus*/, 90973 /*90973 (Private Robert Anthony)*/, 90961 /*90961 (Mortar Specialist) - Fireworks Barrel*/, 92545 /*92545 (Norman Powerspark)*/, 90974 /*90974 (Vindicator Krethos)*/, 64432 /*64432 (Sinan the Dreamer) - Meditate*/, 61398 /*61398 (Xin the Weaponmaster)*/, 61387 /*61387 (Quilen Guardian)*/, 61338 /*61338 (Glintrok Skulker) - Glintrok Anim Replacement Set, Stealth*/, 61239 /*61239 (Glintrok Oracle) - Glintrok Anim Replacement Set*/, 63808 /*63808 (Faintly Glowing Gem)*/, 61679 /*61679 (Crossbow)*/, 61433 /*61433 (Animated Staff) - Permanent Feign Death*/, 61451 /*61451 (Animated Axe)*/, 61340 /*61340 (Glintrok Hexxer) - Glintrok Anim Replacement Set*/, 61337 /*61337 (Glintrok Ironhide) - Glintrok Anim Replacement Set, Iron Protector*/, 61216 /*61216 (Glintrok Hexxer) - Glintrok Anim Replacement Set*/, 61339 /*61339 (Glintrok Oracle) - Glintrok Anim Replacement Set*/, 59394 /*59394 (General Purpose Bunny JMF (Ground)) - Cosmetic - Loot Sparkles (5.00)*/, 63739 /*63739 (Quilen Statue) - Freeze Anim*/, 61240 /*61240 (Glintrok Skulker) - Glintrok Anim Replacement Set*/, 61242 /*61242 (Glintrok Ironhide) - Glintrok Anim Replacement Set, Iron Protector*/, 61399 /*61399 (Glintrok Scout) - Glintrok Anim Replacement Set*/, 64250 /*64250 (Beacon) - Mogu'shan Palace - Spotlight*/, 64243 /*64243 (Glintrok Scout) - Glintrok Anim Replacement Set*/, 65402 /*65402 (Gurthan Swiftblade)*/, 61243 /*61243 (Gekkan) - Glintrok Anim Replacement Set*/, 61550 /*61550 (Harthak Adept) - Grunt Aura - Periodically Check for Players, Mod Scale 115-120%*/, 61389 /*61389 (Kargesh Highguard)*/, 61449 /*61449 (Harthak Adept) - Grunt Aura - Periodically Check for Players*/, 61247 /*61247 (Glintrok Greenhorn) - Glintrok Anim Replacement Set*/, 61392 /*61392 (Harthak Flameseeker)*/, 61478 /*61478 (Referee) - Referee Spawn Spell*/, 67231 /*67231 (Trial of the King)*/, 61450 /*61450 (Kargesh Grunt) - Grunt Aura - Periodically Check for Players, Mod Scale 95-100%*/, 61447 /*61447 (Gurthan Scrapper) - Grunt Aura - Periodically Check for Players, Mod Scale 95-100%*/, 61551 /*61551 (Kargesh Grunt) - Grunt Aura - Periodically Check for Players, Mod Scale 115-120%*/, 61415 /*61415 (Giant Cave Bat) - Giant Cave Bat Cosmetic*/, 61444 /*61444 (Ming the Cunning) - Combat Sound Loop*/, 61549 /*61549 (Gurthan Scrapper) - Grunt Aura - Periodically Check for Players, Mod Scale 115-120%*/, 63091 /*63091 (Jade Quilen)*/, 64548 /*64548 (Kargesh Grunt) - Mod Scale 115-120%*/, 64547 /*64547 (Gurthan Scrapper) - Mod Scale 115-120%*/, 61445 /*61445 (Haiyan the Unstoppable) - Kargesh Clan Leader*/, 61442 /*61442 (Kuai the Brute) - Combat Sound Loop*/, 61884 /*61884 (Xin the Weaponmaster) - Ping Aura*/, 63093 /*63093 (Jade Quilen Referee)*/, 61431 /*61431 (Glintrok Scout) - Glintrok Anim Replacement Set, Invisibility and Stealth Detection*/, 61947 /*61947 (Kargesh Ribcrusher) - Mod Scale 115-120%*/, 61946 /*61946 (Harthak Stormcaller) - Mod Scale 105-110%*/, 61945 /*61945 (Gurthan Iron Maw) - Mod Scale 95-100%, Invisibility and Stealth Detection*/, 61432 /*61432 (Glintrok Pillager) - Glintrok Anim Replacement Set, Glintrok Treasure - Sack, Invisibility and Stealth Detection*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(87277, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87277 (Glenn Ramtoss)
(87269, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87269 (Ryan Quinn)
(87271, 0, 0, 0, 1, 0, 6474, 0, 0, ''), -- 87271 (Danel Hornbark)
(87270, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87270 (James Crowson)
(86433, 0, 28917, 0, 257, 0, 0, 0, 0, ''), -- 86433 (Stormshield Officer)
(88076, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 88076 (Sand Scavenger)
(87048, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87048 (Katherine Joplin)
(85905, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85905 (Jaiden Trask)
(87763, 0, 0, 0, 1, 0, 7398, 0, 0, ''), -- 87763 (Golden King Statue)
(87663, 0, 0, 0, 257, 0, 0, 0, 0, '18950'), -- 87663 (Officer Mirenda) - Invisibility and Stealth Detection
(87255, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87255 (Cardenaas)
(85950, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85950 (Trader Caerel)
(85955, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85955 (Jaromir Gladetender)
(87657, 0, 0, 0, 257, 0, 0, 0, 0, '18950'), -- 87657 (Stormshield Guard) - Invisibility and Stealth Detection
(85921, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85921 (Jie Wildblossom)
(87285, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87285 (Allan Darksteel)
(86065, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 86065 (Private Tristan)
(87276, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 87276 (Aruajo Neto)
(85849, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85849 (Kinkade Jakobs)
(86110, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 86110 (Daana Leafwhisper)
(85963, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85963 (Orville Manfred)
(85959, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 85959 (Ernst ten Bosch)
(86408, 0, 0, 0, 256, 0, 0, 0, 0, '18950'), -- 86408 (Stormshield Guard) - Invisibility and Stealth Detection
(88194, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 88194 (Horse)
(86413, 0, 0, 0, 256, 0, 0, 0, 0, '18950'), -- 86413 (Stormshield Guard) - Invisibility and Stealth Detection
(86087, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 86087 (Stormshield Peasant)
(92823, 0, 0, 0, 258, 0, 0, 0, 0, ''), -- 92823 (Lion's Watch Cannoneer)
(95327, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 95327 (Doomwing Rylak)
(99180, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 99180 (Kluk'kluk)
(90972, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90972 (Jaslyn Moongazer)
(91077, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 91077 (Apprentice Gharenda)
(92835, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 92835 (Watchman Darkfury)
(91201, 0, 0, 131072, 1, 0, 0, 0, 0, '181064 188439'), -- 91201 (Cloaked Shadowraider) - Cloaked Shadowraider Visual, Stealth
(99183, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 99183 (Renegade Ironworker)
(90965, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90965 (Rangari Bodyguard)
(96147, 0, 0, 8, 256, 0, 0, 0, 0, ''), -- 96147 (Parvink)
(90309, 0, 0, 0, 257, 0, 0, 0, 0, '160955'), -- 90309 (Exarch Yrel) - Yrel's Shield
(92340, 0, 0, 0, 1, 0, 3063, 0, 0, ''), -- 92340 (Gnomish Flying Machine)
(96130, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 96130 (Ravenspeaker Thelnaas)
(90971, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90971 (Shima Islebreeze)
(90955, 0, 0, 0, 258, 0, 0, 0, 0, ''), -- 90955 (Lion's Watch Rifleman)
(90960, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90960 (Skyguard Thann)
(90963, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90963 (Angar Steelbellow)
(90962, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90962 (Lion's Watch Engineer)
(95424, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 95424 (Dawn-Seeker Krisek)
(91089, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 91089 (Iron Cannon)
(79665, 0, 0, 0, 257, 0, 6465, 0, 0, ''), -- 79665 (Laborer)
(90957, 0, 28917, 0, 257, 0, 0, 0, 0, ''), -- 90957 (Lion's Watch Footman)
(90975, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90975 (Lion's Watch Paladin)
(90977, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90977 (Thaesus)
(90954, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90954 (Laborer)
(92768, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 92768 (Hellfire Siege Tank)
(90967, 0, 0, 0, 1, 0, 0, 0, 0, '174827'), -- 90967 (Kirin Tor Magus) - Garrison Magus
(90973, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90973 (Private Robert Anthony)
(90961, 0, 0, 0, 257, 0, 0, 0, 0, '180802'), -- 90961 (Mortar Specialist) - Fireworks Barrel
(92545, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 92545 (Norman Powerspark)
(90974, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 90974 (Vindicator Krethos)
(64432, 0, 0, 0, 1, 0, 0, 0, 0, '124416'), -- 64432 (Sinan the Dreamer) - Meditate
(61398, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61398 (Xin the Weaponmaster)
(61387, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61387 (Quilen Guardian)
(61338, 0, 0, 0, 1, 0, 0, 0, 0, '118967 118969'), -- 61338 (Glintrok Skulker) - Glintrok Anim Replacement Set, Stealth
(61239, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 61239 (Glintrok Oracle) - Glintrok Anim Replacement Set
(63808, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 63808 (Faintly Glowing Gem)
(61679, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61679 (Crossbow)
(61433, 0, 0, 0, 1, 0, 0, 0, 0, '29266'), -- 61433 (Animated Staff) - Permanent Feign Death
(61451, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61451 (Animated Axe)
(61340, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 61340 (Glintrok Hexxer) - Glintrok Anim Replacement Set
(61337, 0, 0, 0, 1, 0, 0, 0, 0, '118967 118958'), -- 61337 (Glintrok Ironhide) - Glintrok Anim Replacement Set, Iron Protector
(61216, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 61216 (Glintrok Hexxer) - Glintrok Anim Replacement Set
(61339, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 61339 (Glintrok Oracle) - Glintrok Anim Replacement Set
(59394, 0, 0, 0, 1, 0, 0, 0, 0, '128571'), -- 59394 (General Purpose Bunny JMF (Ground)) - Cosmetic - Loot Sparkles (5.00)
(63739, 0, 0, 0, 1, 0, 0, 0, 0, '127634'), -- 63739 (Quilen Statue) - Freeze Anim
(61240, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 61240 (Glintrok Skulker) - Glintrok Anim Replacement Set
(61242, 0, 0, 0, 1, 0, 0, 0, 0, '118967 118958'), -- 61242 (Glintrok Ironhide) - Glintrok Anim Replacement Set, Iron Protector
(61399, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 61399 (Glintrok Scout) - Glintrok Anim Replacement Set
(64250, 0, 0, 50331648, 1, 0, 0, 0, 0, '125313'), -- 64250 (Beacon) - Mogu'shan Palace - Spotlight
(64243, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 64243 (Glintrok Scout) - Glintrok Anim Replacement Set
(65402, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 65402 (Gurthan Swiftblade)
(61243, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 61243 (Gekkan) - Glintrok Anim Replacement Set
(61550, 0, 0, 0, 1, 0, 0, 0, 0, '121746 120375'), -- 61550 (Harthak Adept) - Grunt Aura - Periodically Check for Players, Mod Scale 115-120%
(61389, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61389 (Kargesh Highguard)
(61449, 0, 0, 0, 1, 0, 0, 0, 0, '121746'), -- 61449 (Harthak Adept) - Grunt Aura - Periodically Check for Players
(61247, 0, 0, 0, 1, 0, 0, 0, 0, '118967'), -- 61247 (Glintrok Greenhorn) - Glintrok Anim Replacement Set
(61392, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61392 (Harthak Flameseeker)
(61478, 0, 0, 50331648, 1, 0, 0, 0, 0, '124313'), -- 61478 (Referee) - Referee Spawn Spell
(67231, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 67231 (Trial of the King)
(61450, 0, 0, 0, 1, 0, 0, 0, 0, '121746 120379'), -- 61450 (Kargesh Grunt) - Grunt Aura - Periodically Check for Players, Mod Scale 95-100%
(61447, 0, 0, 0, 1, 0, 0, 0, 0, '121746 120379'), -- 61447 (Gurthan Scrapper) - Grunt Aura - Periodically Check for Players, Mod Scale 95-100%
(61551, 0, 0, 0, 1, 0, 0, 0, 0, '121746 120375'), -- 61551 (Kargesh Grunt) - Grunt Aura - Periodically Check for Players, Mod Scale 115-120%
(61415, 0, 0, 50331648, 1, 0, 0, 0, 0, '119319'), -- 61415 (Giant Cave Bat) - Giant Cave Bat Cosmetic
(61444, 0, 0, 0, 1, 0, 0, 0, 0, '126252'), -- 61444 (Ming the Cunning) - Combat Sound Loop
(61549, 0, 0, 0, 1, 0, 0, 0, 0, '121746 120375'), -- 61549 (Gurthan Scrapper) - Grunt Aura - Periodically Check for Players, Mod Scale 115-120%
(63091, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 63091 (Jade Quilen)
(64548, 0, 0, 0, 1, 0, 0, 0, 0, '120375'), -- 64548 (Kargesh Grunt) - Mod Scale 115-120%
(64547, 0, 0, 0, 1, 0, 0, 0, 0, '120375'), -- 64547 (Gurthan Scrapper) - Mod Scale 115-120%
(61445, 0, 0, 0, 1, 0, 0, 0, 0, '124311'), -- 61445 (Haiyan the Unstoppable) - Kargesh Clan Leader
(61442, 0, 0, 0, 1, 0, 0, 0, 0, '126252'), -- 61442 (Kuai the Brute) - Combat Sound Loop
(61884, 0, 0, 0, 1, 0, 0, 0, 0, '120915'), -- 61884 (Xin the Weaponmaster) - Ping Aura
(63093, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 63093 (Jade Quilen Referee)
(61431, 0, 0, 0, 1, 0, 0, 0, 0, '118967 18950'), -- 61431 (Glintrok Scout) - Glintrok Anim Replacement Set, Invisibility and Stealth Detection
(61947, 0, 0, 0, 1, 0, 0, 0, 0, '120375'), -- 61947 (Kargesh Ribcrusher) - Mod Scale 115-120%
(61946, 0, 0, 0, 1, 0, 0, 0, 0, '120374'), -- 61946 (Harthak Stormcaller) - Mod Scale 105-110%
(61945, 0, 0, 0, 1, 0, 0, 0, 0, '120379 18950'), -- 61945 (Gurthan Iron Maw) - Mod Scale 95-100%, Invisibility and Stealth Detection
(61432, 0, 0, 0, 1, 0, 0, 0, 0, '118967 119350 18950'); -- 61432 (Glintrok Pillager) - Glintrok Anim Replacement Set, Glintrok Treasure - Sack; Invisibility and Stealth Detection

UPDATE `creature_template_addon` SET `bytes1`=50331648 WHERE `entry`=59481; -- 59481 (World Trigger)

DELETE FROM `creature_equip_template` WHERE (`ID`=2 AND `CreatureID` IN (86408,90954)) OR (`ID`=1 AND `CreatureID` IN (87657,92823,99180,92835,99183,96147,90309,90955,90962,79665,90957,90954,90961));
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`) VALUES
(86408, 2, 0, 0, 0, 0, 0, 0, 62400, 0, 0), -- Stormshield Guard
(87657, 1, 0, 0, 0, 0, 0, 0, 62400, 0, 0), -- Stormshield Guard
(92823, 1, 1906, 0, 0, 0, 0, 0, 120060, 0, 0), -- Lion's Watch Cannoneer
(99180, 1, 111743, 0, 0, 0, 0, 0, 0, 0, 0), -- Kluk'kluk
(92835, 1, 1906, 0, 0, 0, 0, 0, 0, 0, 0), -- Watchman Darkfury
(99183, 1, 106275, 0, 0, 0, 0, 0, 0, 0, 0), -- Renegade Ironworker
(96147, 1, 13708, 0, 0, 0, 0, 0, 0, 0, 0), -- Parvink
(90309, 1, 111523, 0, 0, 0, 0, 0, 0, 0, 0), -- Exarch Yrel
(90955, 1, 0, 0, 0, 0, 0, 0, 110314, 0, 0), -- Lion's Watch Rifleman
(90954, 2, 1903, 0, 0, 0, 0, 0, 0, 0, 0), -- Laborer
(90962, 1, 1910, 0, 0, 0, 0, 0, 0, 0, 0), -- Lion's Watch Engineer
(79665, 1, 33022, 0, 0, 0, 0, 0, 0, 0, 0), -- Laborer
(90957, 1, 1899, 0, 0, 143, 0, 0, 0, 0, 0), -- Lion's Watch Footman
(90954, 1, 1910, 0, 0, 0, 0, 0, 0, 0, 0), -- Laborer
(90961, 1, 0, 0, 0, 0, 0, 0, 116600, 0, 0); -- Mortar Specialist

UPDATE `creature_equip_template` SET `ItemID2`=110155, `ItemID3`=62400 WHERE (`CreatureID`=86433 AND `ID`=1); -- Stormshield Officer
UPDATE `creature_equip_template` SET `ItemID2`=111717, `ItemID3`=62400 WHERE (`CreatureID`=86408 AND `ID`=1); -- Stormshield Guard
UPDATE `creature_equip_template` SET `ItemID2`=111717, `ItemID3`=62400 WHERE (`CreatureID`=86413 AND `ID`=1); -- Stormshield Guard


UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0 WHERE `entry`=86433; -- Stormshield Officer
UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0 WHERE `entry`=88076; -- Sand Scavenger
UPDATE `creature_template` SET `npcflag`=80 WHERE `entry`=85905; -- Jaiden Trask
UPDATE `creature_template` SET `npcflag`=80 WHERE `entry`=85921; -- Jie Wildblossom
UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0 WHERE `entry`=85849; -- Kinkade Jakobs
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1575, `npcflag`=8193, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=85959; -- Ernst ten Bosch
UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0, `faction`=2321 WHERE `entry`=86408; -- Stormshield Guard
UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0, `faction`=2321, `npcflag`=1 WHERE `entry`=86413; -- Stormshield Guard
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=11, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=92823; -- Lion's Watch Cannoneer
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1711, `speed_walk`=1.279999971389770507, `speed_run`=1.587142825126647949, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=95327; -- Doomwing Rylak
UPDATE `creature_template` SET `minlevel`=102, `maxlevel`=102, `npcflag`=3, `speed_walk`=5.599999904632568359, `speed_run`=2, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=99180; -- Kluk'kluk
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1733, `npcflag`=128, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90972; -- Jaslyn Moongazer
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1733, `npcflag`=2176, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=91077; -- Apprentice Gharenda
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1732, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=92835; -- Watchman Darkfury
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=7, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=33587200, `unit_flags2`=2048 WHERE `entry`=91201; -- Cloaked Shadowraider
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `npcflag`=3, `speed_run`=1.714285731315612792, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=99183; -- Renegade Ironworker
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2762, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90965; -- Rangari Bodyguard
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2765, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=512, `unit_flags2`=2048 WHERE `entry`=96147; -- Parvink
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1732, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=90309; -- Exarch Yrel
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `npcflag`=1, `speed_run`=4.285714149475097656, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=34816 WHERE `entry`=92340; -- Gnomish Flying Machine
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2794, `npcflag`=128, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=96130; -- Ravenspeaker Thelnaas
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1733, `npcflag`=65665, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90971; -- Shima Islebreeze
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=57, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=90955; -- Lion's Watch Rifleman
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1078, `npcflag`=8193, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90960; -- Skyguard Thann
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2155, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90963; -- Angar Steelbellow
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1732, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90962; -- Lion's Watch Engineer
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2794, `npcflag`=131, `speed_walk`=0.919999957084655761, `speed_run`=0.992857098579406738, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=95424; -- Dawn-Seeker Krisek
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=14, `speed_walk`=0.444444000720977783, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554944, `unit_flags2`=71305216, `unit_flags3`=1 WHERE `entry`=91089; -- Iron Cannon
UPDATE `creature_template` SET `minlevel`=96, `maxlevel`=96, `faction`=1078, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=79665; -- Laborer
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=11, `speed_run`=1.289682745933532714, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90957; -- Lion's Watch Footman
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2762, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90975; -- Lion's Watch Paladin
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2762, `npcflag`=4224, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90977; -- Thaesus
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=1078, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90954; -- Laborer
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=16, `speed_walk`=3.20000004768371582, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=4196352 WHERE `entry`=92768; -- Hellfire Siege Tank
UPDATE `creature_template` SET `npcflag`=1 WHERE `entry`=90967; -- Kirin Tor Magus
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=12, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90973; -- Private Robert Anthony
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2155, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90961; -- Mortar Specialist
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=64, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=92545; -- Norman Powerspark
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2796, `npcflag`=131, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=90974; -- Vindicator Krethos
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_walk`=0.800000011920928955, `speed_run`=2 WHERE `entry`=61398; -- Xin the Weaponmaster
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=61387; -- Quilen Guardian
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_walk`=0.5, `speed_run`=0.714285731315612792 WHERE `entry`=61338; -- Glintrok Skulker
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_run`=1.428571462631225585 WHERE `entry`=61239; -- Glintrok Oracle
UPDATE `creature_template` SET `npcflag`=16777216, `speed_walk`=2.20000004768371582, `speed_run`=0.785714268684387207, `unit_flags3`=1 WHERE `entry`=63808; -- Faintly Glowing Gem
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=38463; -- Empowering Orb Visual Stalker
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.400000005960464477, `unit_flags3`=1 WHERE `entry`=61679; -- Crossbow
UPDATE `creature_template` SET `speed_walk`=1.60000002384185791, `speed_run`=0.571428596973419189, `unit_flags`=570687552, `unit_flags2`=2131969, `unit_flags3`=1, `dynamicflags`=32 WHERE `entry`=61433; -- Animated Staff
UPDATE `creature_template` SET `speed_walk`=1.60000002384185791, `speed_run`=0.571428596973419189, `unit_flags3`=1 WHERE `entry`=61451; -- Animated Axe
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_run`=1.428571462631225585 WHERE `entry`=61340; -- Glintrok Hexxer
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_run`=1.428571462631225585 WHERE `entry`=61337; -- Glintrok Ironhide
UPDATE `creature_template` SET `unit_flags2`=2099200, `unit_flags3`=1 WHERE `entry`=59481; -- World Trigger
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_run`=1.428571462631225585 WHERE `entry`=61216; -- Glintrok Hexxer
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_run`=1.428571462631225585 WHERE `entry`=61339; -- Glintrok Oracle
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `unit_flags3`=1 WHERE `entry`=63739; -- Quilen Statue
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_run`=1.428571462631225585 WHERE `entry`=61240; -- Glintrok Skulker
UPDATE `creature_template` SET `minlevel`=91, `maxlevel`=91, `speed_run`=1.428571462631225585 WHERE `entry`=61242; -- Glintrok Ironhide
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=1.428571462631225585, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=61399; -- Glintrok Scout
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=64250; -- Beacon
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=1.428571462631225585 WHERE `entry`=64243; -- Glintrok Scout
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=65402; -- Gurthan Swiftblade
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_run`=1.428571462631225585 WHERE `entry`=61243; -- Gekkan
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61550; -- Harthak Adept
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61389; -- Kargesh Highguard
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61449; -- Harthak Adept
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=1.428571462631225585 WHERE `entry`=61247; -- Glintrok Greenhorn
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61392; -- Harthak Flameseeker
UPDATE `creature_template` SET `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=67110912 WHERE `entry`=61478; -- Referee
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92 WHERE `entry`=67231; -- Trial of the King
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=33556480 WHERE `entry`=61450; -- Kargesh Grunt
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61447; -- Gurthan Scrapper
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001, `unit_flags3`=1 WHERE `entry`=61551; -- Kargesh Grunt
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=61415; -- Giant Cave Bat
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=1683, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61444; -- Ming the Cunning
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001, `unit_flags3`=1 WHERE `entry`=61549; -- Gurthan Scrapper
UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=63091; -- Jade Quilen
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=33556480, `unit_flags3`=1 WHERE `entry`=64548; -- Kargesh Grunt
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=33556480, `unit_flags3`=1 WHERE `entry`=64547; -- Gurthan Scrapper
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=1683, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61445; -- Haiyan the Unstoppable
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `faction`=1683, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61442; -- Kuai the Brute
UPDATE `creature_template` SET `minlevel`=92, `maxlevel`=92, `speed_walk`=0.800000011920928955, `speed_run`=2, `unit_flags3`=1 WHERE `entry`=61884; -- Xin the Weaponmaster
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=63093; -- Jade Quilen Referee
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=1.428571462631225585 WHERE `entry`=61431; -- Glintrok Scout
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61947; -- Kargesh Ribcrusher
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_walk`=0.888888001441955566, `speed_run`=0.952381432056427001 WHERE `entry`=61946; -- Harthak Stormcaller
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90 WHERE `entry`=61945; -- Gurthan Iron Maw
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `speed_run`=1.428571462631225585 WHERE `entry`=61432; -- Glintrok Pillager

DELETE FROM `gameobject_template` WHERE `entry`=239902;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(239902, 10, 16956, 'Tanaan Planning Map', 'quest', '', '', 1, 2152, 0, 0, 3000, 0, 0, 1, 0, 0, 0, 179687, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 32181, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23360); -- Tanaan Planning Map

UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data14`=21400, `VerifiedBuild`=23360 WHERE `entry`=214827; -- Ancient Mogu Chest
UPDATE `gameobject_template` SET `Data6`=6000, `Data10`=128884, `Data23`=1, `VerifiedBuild`=23360 WHERE `entry`=212095; -- Scrying Orb
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data14`=21400, `VerifiedBuild`=23360 WHERE `entry`=214826; -- Ancient Mogu Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data14`=21400, `VerifiedBuild`=23360 WHERE `entry`=214825; -- Ancient Mogu Chest
UPDATE `gameobject_template` SET `Data11`=1, `Data13`=1, `Data15`=1, `Data20`=90, `Data25`=1510, `VerifiedBuild`=23360 WHERE `entry`=214794; -- Ancient Mogu Treasure
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data14`=21400, `VerifiedBuild`=23360 WHERE `entry`=214824; -- Ancient Mogu Chest
UPDATE `gameobject_template` SET `Data11`=1, `Data13`=1, `Data15`=1, `Data20`=90, `Data25`=1442, `VerifiedBuild`=23360 WHERE `entry`=214521; -- Legacy of the Clan Leaders

DELETE FROM `gameobject_questitem` WHERE (`Idx`=0 AND `GameObjectEntry` IN (214827,214826,214825,214824));
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(214827, 0, 86479, 23360), -- Ancient Mogu Chest
(214826, 0, 86478, 23360), -- Ancient Mogu Chest
(214825, 0, 86477, 23360), -- Ancient Mogu Chest
(214824, 0, 86476, 23360); -- Ancient Mogu Chest

