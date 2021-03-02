DELETE FROM `gameobject_template_addon` WHERE `entry` IN (244950 /*Dusty Rug*/, 246524 /*Small Treasure Chest*/, 252806 /*Small Treasure Chest*/, 253144 /*Teleportation Nexus*/, 252819 /*Small Treasure Chest*/, 252198 /*Teleportation Nexus*/, 242644 /*Treasure Chest*/, 241127 /*Unguarded Thistleleaf Treasure*/, 240519 /*Small Treasure Chest*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(244950, 0, 0, 2100), -- Dusty Rug
(246524, 0, 0, 2437), -- Small Treasure Chest
(252806, 0, 0, 2437), -- Small Treasure Chest
(253144, 0, 0, 0), -- Teleportation Nexus
(252819, 0, 0, 2437), -- Small Treasure Chest
(252198, 0, 0, 0), -- Teleportation Nexus
(242644, 0, 0, 2437), -- Treasure Chest
(241127, 0, 0, 2437), -- Unguarded Thistleleaf Treasure
(240519, 0, 0, 2437); -- Small Treasure Chest

UPDATE `gameobject_template_addon` SET `WorldEffectID`=6658 WHERE `entry`=260494; -- Twice-Fortified Arcwine
UPDATE `gameobject_template_addon` SET `WorldEffectID`=6658 WHERE `entry`=252774; -- Ancient Mana Crystal
UPDATE `gameobject_template_addon` SET `WorldEffectID`=6658 WHERE `entry`=252408; -- Ancient Mana Shard
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242666; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240614; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242662; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242663; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242660; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242665; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242670; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242646; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=254141; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240605; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242959; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240651; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241772; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242645; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242643; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242642; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242446; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240609; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240612; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=2113540 WHERE `entry`=248931; -- Smolderhide Firewater
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242328; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=254128; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240653; -- Small Treasure Chest

DELETE FROM `quest_poi` WHERE (`QuestID`=38718 AND `BlobIndex`=0 AND `Idx1`=1);
INSERT INTO `quest_poi` (`QuestID`, `BlobIndex`, `Idx1`, `ObjectiveIndex`, `QuestObjectiveID`, `QuestObjectID`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `WorldEffectID`, `PlayerConditionID`, `SpawnTrackingID`, `AlwaysAllowMergingBlobs`, `VerifiedBuild`) VALUES
(38718, 0, 1, 0, 278327, 94551, 1220, 1018, 0, 0, 0, 0, 0, 1028967, 0, 23420); -- Kur'talos Ravencrest

UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=110621; -- 110621 (Erika Page)
UPDATE `creature_template_addon` SET `aiAnimKit`=913 WHERE `entry`=110623; -- 110623 (Sunny)
UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=113900; -- 113900 (Liyana)
UPDATE `creature_template_addon` SET `aiAnimKit`=11654 WHERE `entry`=112456; -- 112456 (Rachele)
UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=113901; -- 113901 (Crixa)
UPDATE `creature_template_addon` SET `aiAnimKit`=11654 WHERE `entry`=112437; -- 112437 (Roscoe)
UPDATE `creature_template_addon` SET `aiAnimKit`=4175 WHERE `entry`=105904; -- 105904 (Raven)
UPDATE `creature_template_addon` SET `aiAnimKit`=2560 WHERE `entry`=100742; -- 100742 (Legion Scouting Beacon)
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=104235; -- 104235 (Val'Sharah Refugee)
UPDATE `creature_template_addon` SET `bytes1`=3 WHERE `entry`=103497; -- 103497 (Feathermane Hunter)
UPDATE `creature_template_addon` SET `bytes1`=3 WHERE `entry`=103711; -- 103711 (Feathermane Kitten)
UPDATE `creature_template_addon` SET `bytes1`=3 WHERE `entry`=103511; -- 103511 (Lost Feathermane Kitten)
UPDATE `creature_template_addon` SET `aiAnimKit`=8995 WHERE `entry`=113967; -- 113967 (Training Dummy)
UPDATE `creature_template_addon` SET `aiAnimKit`=10419 WHERE `entry`=102206; -- 102206 (Xavius)
UPDATE `creature_template_addon` SET `aiAnimKit`=9745 WHERE `entry`=102202; -- 102202 (Malfurion Stormrage)
UPDATE `creature_template_addon` SET `auras`='162908' WHERE `entry`=92332; -- 92332 (Hulking Gnarlvine)
UPDATE `creature_template_addon` SET `aiAnimKit`=1878 WHERE `entry`=94110; -- 94110 (Druid of the Moon)
UPDATE `creature_template_addon` SET `aiAnimKit`=1427 WHERE `entry`=100211; -- 100211 (Cenarius)
UPDATE `creature_template_addon` SET `aiAnimKit`=703 WHERE `entry`=100498; -- 100498 (Jabrul)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=93602; -- 93602 (Marnor Lorleaf)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=91149; -- 91149 (Acolyte of Elothir)
UPDATE `creature_template_addon` SET `aiAnimKit`=1626 WHERE `entry`=96932; -- 96932 (Hatching Harpy Egg)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=93644; -- 93644 (Del'thanar Sagewood)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=91150; -- 91150 (Acolyte of Elothir)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=92874; -- 92874 (Acolyte of Elothir)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=93640; -- 93640 (Erwind Mistfen)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=91153; -- 91153 (Acolyte of Elothir)
UPDATE `creature_template_addon` SET `aiAnimKit`=1427 WHERE `entry`=100210; -- 100210 (Cenarius)

UPDATE `creature_equip_template` SET `ItemID1`=18610 WHERE (`CreatureID`=92617 AND `ID`=4); -- Bradensbrook Villager
UPDATE `creature_equip_template` SET `ItemID1`=85663 WHERE (`CreatureID`=92617 AND `ID`=3); -- Bradensbrook Villager

UPDATE `creature_template` SET `speed_run`=1.139999985694885253 WHERE `entry`=109959; -- Darkfiend Defiler
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=92321; -- Mature Deathblossom

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (251129 /*Frostrune Scroll*/, 251144 /*Scorchrune Scroll*/, 240635 /*Treasure Chest*/, 252183 /*Teleportation Nexus*/, 240353 /*Seemingly Unguarded Treasure*/, 250867 /*Keg of Spicy Grog*/, 250092 /*Treasure Chest*/, 250433 /*Felforge*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(251129, 0, 0, 569), -- Frostrune Scroll
(251144, 0, 0, 569), -- Scorchrune Scroll
(240635, 0, 0, 2437), -- Treasure Chest
(252183, 0, 0, 0), -- Teleportation Nexus
(240353, 0, 0, 2437), -- Seemingly Unguarded Treasure
(250867, 0, 0, 569), -- Keg of Spicy Grog
(250092, 0, 0, 2437), -- Treasure Chest
(250433, 0, 0, 569); -- Felforge

UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=258690; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240634; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=246037; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=254027; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250091; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240690; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=254025; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251552; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=246205; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=246206; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250081; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250080; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=249997; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240638; -- Disputed Treasure
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240629; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240641; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250098; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=2113540 WHERE `entry`=245221; -- Crate of Mail Armor
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240645; -- Glimmering Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250097; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250088; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250090; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240639; -- Glimmering Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250085; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250084; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240643; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240644; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240630; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240631; -- Treasure Chest

UPDATE `creature_template_addon` SET `aiAnimKit`=11051 WHERE `entry`=91131; -- 91131 (Runas the Shamed)
UPDATE `creature_template_addon` SET `aiAnimKit`=1034 WHERE `entry`=107963; -- 107963 (Kharmeera)
UPDATE `creature_template_addon` SET `aiAnimKit`=1034 WHERE `entry`=107961; -- 107961 (Emmigosa)
UPDATE `creature_template_addon` SET `aiAnimKit`=1034 WHERE `entry`=107962; -- 107962 (Cedonu)
UPDATE `creature_template_addon` SET `aiAnimKit`=1034 WHERE `entry`=107964; -- 107964 (Berazus)
UPDATE `creature_template_addon` SET `auras`='214594' WHERE `entry`=91643; -- 91643 (Azurewing Scalewarden)
UPDATE `creature_template_addon` SET `aiAnimKit`=2156 WHERE `entry`=108036; -- 108036 (Orbyth)
UPDATE `creature_template_addon` SET `aiAnimKit`=7750 WHERE `entry`=90065; -- 90065 (Stellagosa)
UPDATE `creature_template_addon` SET `bytes1`=0, `auras`='127498 109525' WHERE `entry`=106920; -- 106920 (Feathered Prowler)
UPDATE `creature_template_addon` SET `auras`='212682' WHERE `entry`=106356; -- 106356 (Empyrean Conjuror)
UPDATE `creature_template_addon` SET `aiAnimKit`=10630 WHERE `entry`=106689; -- 106689 (Inactive Construct)
UPDATE `creature_template_addon` SET `aiAnimKit`=947 WHERE `entry`=89286; -- 89286 (Mak'rana Elder)
UPDATE `creature_template_addon` SET `aiAnimKit`=947 WHERE `entry`=89048; -- 89048 (Sternfathom)
UPDATE `creature_template_addon` SET `bytes1`=0, `auras`='152209' WHERE `entry`=89385; -- 89385 (Azsuna Fox)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=55370; -- 55370 (General Purpose Bunny ZTO)
UPDATE `creature_template_addon` SET `aiAnimKit`=7547 WHERE `entry`=88850; -- 88850 (Nightwatcher Ayelle)
UPDATE `creature_template_addon` SET `aiAnimKit`=7624 WHERE `entry`=88797; -- 88797 (Elder Aldryth)
UPDATE `creature_template_addon` SET `aiAnimKit`=7733 WHERE `entry`=89975; -- 89975 (Senegos)
UPDATE `creature_template_addon` SET `aiAnimKit`=7702 WHERE `entry`=89341; -- 89341 (Magister Garuhod)
UPDATE `creature_template_addon` SET `aiAnimKit`=1078 WHERE `entry`=90487; -- 90487 (Demon Hunter)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=41200; -- 41200 (Generic Bunny - PRK)

DELETE FROM `creature_model_info` WHERE `DisplayID` IN (63467, 68319);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES
(63467, 2.671328067779541015, 3, 0, 23420),
(68319, 2.849416732788085937, 3.20000004768371582, 0, 23420);

UPDATE `creature_template` SET `unit_flags`=33280 WHERE `entry`=91643; -- Azurewing Scalewarden
UPDATE `creature_template` SET `unit_flags`=294912 WHERE `entry`=106920; -- Feathered Prowler
UPDATE `creature_template` SET `speed_run`=1.142857193946838378 WHERE `entry`=91528; -- Southsea Smuggler
UPDATE `creature_template` SET `unit_flags`=33587200 WHERE `entry`=17213; -- Broom

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (244577 /*Felspike 1.5*/, 253994 /*Seemingly Unguarded Treasure*/, 251153 /*Ancient Highborn Scroll of Escape*/, 243565 /*Drogbar Weight*/, 245532 /*Treasure Chest*/, 255828 /*Small Treasure Chest*/, 245536 /*Glimmering Treasure Chest*/, 245548 /*Treasure Chest*/, 251154 /*Ancient Highborn Scroll of Escape*/, 244494 /*Treasure Chest*/, 245602 /*Treasure Chest*/, 243798 /*A Steamy Jewelry Box*/, 244667 /*Abandoned Fishing Pole*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(244577, 0, 0, 0), -- Felspike 1.5
(253994, 0, 0, 2437), -- Seemingly Unguarded Treasure
(251153, 0, 0, 2100), -- Ancient Highborn Scroll of Escape
(243565, 0, 0, 0), -- Drogbar Weight
(245532, 0, 0, 2437), -- Treasure Chest
(255828, 0, 0, 2437), -- Small Treasure Chest
(245536, 0, 0, 2437), -- Glimmering Treasure Chest
(245548, 0, 0, 2437), -- Treasure Chest
(251154, 0, 0, 2100), -- Ancient Highborn Scroll of Escape
(244494, 0, 0, 2437), -- Treasure Chest
(245602, 0, 0, 2437), -- Treasure Chest
(243798, 0, 0, 2437), -- A Steamy Jewelry Box
(244667, 0, 0, 2437); -- Abandoned Fishing Pole

UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245541; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245479; -- Battered Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250541; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245581; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245554; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245555; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245538; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245579; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245553; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245551; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=243688; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245550; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245580; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245535; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245531; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245533; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245534; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251124; -- Glimmering Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251125; -- Highmountain Brazier
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245601; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245603; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245547; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=243698; -- Glimmering Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=569 WHERE `entry`=245620; -- Mu'sha's Tears
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245543; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245530; -- Glimmering Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=8196 WHERE `entry`=243639; -- Siphoning Crystal
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=245525; -- Small Treasure Chest

UPDATE `creature_template_addon` SET `aiAnimKit`=4782 WHERE `entry`=103592; -- 103592 (Bonebeak Hawk)
UPDATE `creature_template_addon` SET `bytes1`=1 WHERE `entry`=108521; -- 108521 (Sea Skrog)
UPDATE `creature_template_addon` SET `aiAnimKit`=8610 WHERE `entry`=97341; -- 97341 (Poorly Set Trap)
UPDATE `creature_template_addon` SET `aiAnimKit`=9211 WHERE `entry`=97407; -- 97407 (Lasan Skyhorn)
UPDATE `creature_template_addon` SET `aiAnimKit`=1393 WHERE `entry`=98747; -- 98747 (Captive Great Eagle)
UPDATE `creature_template_addon` SET `auras`='188914' WHERE `entry`=95261; -- 95261 (Fire Stalker)
UPDATE `creature_template_addon` SET `aiAnimKit`=8723 WHERE `entry`=98025; -- 98025 (Egg)
UPDATE `creature_template_addon` SET `aiAnimKit`=8385 WHERE `entry`=95760; -- 95760 (Liftbrul)
UPDATE `creature_template_addon` SET `aiAnimKit`=8533 WHERE `entry`=95799; -- 95799 (Damrul the Stronk)
UPDATE `creature_template_addon` SET `aiAnimKit`=8535 WHERE `entry`=95421; -- 95421 (Navarrogg)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=32639; -- 32639 (Gnimo)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=32638; -- 32638 (Hakmud of Argus)
UPDATE `creature_template_addon` SET `aiAnimKit`=4173 WHERE `entry`=97667; -- 97667 (Navarrogg)
UPDATE `creature_template_addon` SET `aiAnimKit`=5081 WHERE `entry`=97095; -- 97095 (Soulkeeper Uriah)
UPDATE `creature_template_addon` SET `bytes1`=262144, `auras`='162084' WHERE `entry`=94460; -- 94460 (Brown Squirrel)
UPDATE `creature_template_addon` SET `aiAnimKit`=2312 WHERE `entry`=100238; -- 100238 (Mara Swiftmane)
UPDATE `creature_template_addon` SET `aiAnimKit`=8626 WHERE `entry`=96242; -- 96242 (Obsidian Reclaimer)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=55370; -- 55370 (General Purpose Bunny ZTO)
UPDATE `creature_template_addon` SET `aiAnimKit`=972 WHERE `entry`=104563; -- 104563 (The Grey One)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=97796; -- 97796 (Felguard Legionnaire)
UPDATE `creature_template_addon` SET `aiAnimKit`=9216 WHERE `entry`=100418; -- 100418 (Darkshard Crystal)
UPDATE `creature_template_addon` SET `aiAnimKit`=8832 WHERE `entry`=97901; -- 97901 (Warbrave Oro)
UPDATE `creature_template_addon` SET `aiAnimKit`=8800 WHERE `entry`=97648; -- 97648 (Grasp of Dargrul)
UPDATE `creature_template_addon` SET `auras`='155893 190182' WHERE `entry`=95866; -- 95866 (Drogbar Manathirster)
UPDATE `creature_template_addon` SET `aiAnimKit`=9054 WHERE `entry`=99406; -- 99406 (Rivermane Tauren)
UPDATE `creature_template_addon` SET `aiAnimKit`=8614 WHERE `entry`=96083; -- 96083 (Rordan Waterwise)
UPDATE `creature_template_addon` SET `aiAnimKit`=1551 WHERE `entry`=95148; -- 95148 (Whitewater Carp)
UPDATE `creature_template_addon` SET `aiAnimKit`=6467 WHERE `entry`=100437; -- 100437 (Lanna Skyspark)

UPDATE `creature_equip_template` SET `ItemID3`=57240 WHERE (`CreatureID`=102929 AND `ID`=2); -- Pinerock Hunter
UPDATE `creature_equip_template` SET `ItemID3`=25269 WHERE (`CreatureID`=102929 AND `ID`=1); -- Pinerock Hunter

UPDATE `creature_template` SET `unit_flags`=32784 WHERE `entry`=97920; -- Swamprock Reedweaver
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=6491; -- Spirit Healer
UPDATE `creature_template` SET `unit_flags`=570687488, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=94460; -- Brown Squirrel
UPDATE `creature_template` SET `speed_run`=1 WHERE `entry`=98020; -- Felguard Legionnaire
UPDATE `creature_template` SET `speed_run`=1.220000028610229492 WHERE `entry`=97803; -- Plague Imp
UPDATE `creature_template` SET `speed_run`=1.149999976158142089 WHERE `entry`=97796; -- Felguard Legionnaire
UPDATE `creature_template` SET `speed_run`=1.10000002384185791 WHERE `entry`=94846; -- Bitestone Rockcrusher
UPDATE `creature_template` SET `npcflag`=0, `dynamicflags`=128 WHERE `entry`=99406; -- Rivermane Tauren

DELETE FROM `gameobject_template_addon` WHERE `entry`=241721;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(241721, 0, 0, 2437); -- Glimmering Treasure Chest

UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250985; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250987; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251772; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251762; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251792; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=0, `WorldEffectID`=2100 WHERE `entry`=247421; -- Powder Keg
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251820; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=244903; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=244904; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=244902; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251714; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=5 WHERE `entry`=244565; -- Kvaldir Spoils
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241272; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241267; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241216; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240649; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251856; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251723; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=244899; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251854; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=244901; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241518; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251761; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=250984; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251713; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=233107; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241154; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241152; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251780; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241148; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=245671; -- Whelp Cage
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=245669; -- Whelp Cage
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241207; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241147; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=245668; -- Whelp Cage
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=245667; -- Whelp Cage
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241146; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241149; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241564; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241665; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241153; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251782; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241206; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=243840; -- Mightstone Banner
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251776; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251716; -- Glimmering Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241558; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=251764; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241562; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241212; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241180; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241213; -- Small Treasure Chest

UPDATE `quest_offer_reward` SET `RewardText`='The verses of the poem unfold the tale of Ashildir founding the shieldmaidens and bringing them to Skold-Ashil.$B$BIf these shieldmaidens revere the Valkyra queen as this would suggest, your dealings with her in Helheim may prove advantageous.' WHERE `ID`=39405; -- Stories of Battle
UPDATE `quest_offer_reward` SET `RewardText`='It\'s unfortunate that the God-King escaped, but his defeat has stemmed the flow of the Legion into Stormheim.$B$BNow, the Halls of Valor await you.' WHERE `ID`=40005; -- Stormheim's Salvation
UPDATE `quest_offer_reward` SET `RewardText`='I do not understand, the portals are closed and yet Skovald\'s demonic forces still assault the gates! $B$BWe must find where they are coming from!' WHERE `ID`=40003; -- Stem the Tide
UPDATE `quest_offer_reward` SET `RewardText`='With their fel leaders slain, the God-King\'s forces will scatter. $B$BStill, we are not finished here. So long as the demons continue to assault the gates, Stormheim will not be safe.' WHERE `ID`=40004; -- Break the Spine
UPDATE `quest_offer_reward` SET `RewardText`='You still manage to surprise me, outsider. Your trials are complete, and yet you still have challenges to face. $B$BThe God-King\'s forces are many, but in your weapon you possess the powers of Stormheim herself! Approach the gates, and these powers will lay low the enemies of this land!$B$BNow, let us take the fight to the God-King, and cleanse the Gates of Valor of his fel taint!' WHERE `ID`=40002; -- A Familiar Fate
UPDATE `quest_offer_reward` SET `RewardText`='What is this... I see? $B$BA friendly face... in a sea of foes?' WHERE `ID`=40001; -- Knocking on Valor's Door
UPDATE `quest_offer_reward` SET `RewardText`='It is clear that your cooking prowess is only matched by your might in combat. $B$BNow, on full bellies, we ride to Valhallas!' WHERE `ID`=40078; -- A Heavy Burden
UPDATE `quest_offer_reward` SET `RewardText`='So the dead return from Helheim and back? An impressive feat. $B$BYour worth has been judged and the trial passed. $B$BNow, to your destiny. To the Halls of Valor!' WHERE `ID`=39855; -- Paid in Lifeblood
UPDATE `quest_offer_reward` SET `RewardText`='The day is won. Now, we must collect our reward. $B$BLet us hope that Helya keeps her side of the bargain.' WHERE `ID`=39853; -- Victory is Eternal
UPDATE `quest_offer_reward` SET `RewardText`='Yes, I can feel your power returned. $B$BHelya will regret the day she challenged one such as you.' WHERE `ID`=39850; -- Sundered
UPDATE `quest_offer_reward` SET `RewardText`='It is good to have my shieldmaidens returned to my side. $B$BYou have gained allies today, but know you have also gained my gratitude.' WHERE `ID`=39851; -- Allies in Death
UPDATE `quest_offer_reward` SET `RewardText`='This appears to be what we need. $B$BNow, we can prepare for the battle ahead.' WHERE `ID`=39849; -- To Light the Way
UPDATE `quest_offer_reward` SET `RewardText`='You do not look good. $B$BI take it Helya did not prove lenient?' WHERE `ID`=39857; -- The Eternal Nemesis
UPDATE `quest_offer_reward` SET `RewardText`='<Helya\'s voice fills the air as you stand>$B$BNobody leaves Helheim without my approval! Entertain me, and I may let you pass.' WHERE `ID`=39848; -- A Desperate Bargain
UPDATE `quest_offer_reward` SET `RewardText`='That was a truly revolting, outsider. Even in death I\'ve never witnessed such a disgusting smell.' WHERE `ID`=38347; -- Stealth by Seaweed
UPDATE `quest_offer_reward` SET `RewardText`='Wait... ye killed how many kvaldir? Yer braver than I thought, outsider!$B$BI\'m sure Helya will see that neither ye nor I belong here once we get past that dog of hers.' WHERE `ID`=38339; -- A Little Kelp From My Foes
UPDATE `quest_offer_reward` SET `RewardText`='Ah yes, these will do. $B$BNow lets see what we can make to fool old Guarm, eh?' WHERE `ID`=38324; -- Accessories of the Cursed
UPDATE `quest_offer_reward` SET `RewardText`='Free at last! $B$BThe kvaldir caught me while I was tryin\' to put together a plan to sneak past that foul dog, Guarm, and have had me locked up ever since! $B$BI thought surely my fate was sealed.' WHERE `ID`=39837; -- An Unworthy Task
UPDATE `quest_offer_reward` SET `RewardText`='Free at last! $B$BThe kvaldir caught me while I was tryin\' to put together a plan to sneak past that foul dog, Guarm, and have had me locked up ever since! $B$BI thought surely my fate was sealed.' WHERE `ID`=39837; -- An Unworthy Task
UPDATE `quest_offer_reward` SET `RewardText`='A cannot believe this fate... $B$BI am sorry, outsider, for I had underestimated Faljar\'s power.$B$BThat he could banish us here... is unthinkable.' WHERE `ID`=38818; -- The Final Judgment
UPDATE `quest_offer_reward` SET `RewardText`='Where... where am I now? $B$BI... know you...' WHERE `ID`=38815; -- Waking the Shieldmaiden
UPDATE `quest_offer_reward` SET `RewardText`='These mystics have gone to great lengths to weaken Ashildir. $B$BWe must hope that her spirit is strong enough for the wakening.' WHERE `ID`=38823; -- The Runes that Bind
UPDATE `quest_offer_reward` SET `RewardText`='The treachery of the Bonespeakers knows no limit. $B$BTheir rituals seek to sunder the very essence of our queen, but we will use their own magic to return her to us!' WHERE `ID`=38817; -- Regal Remains
UPDATE `quest_offer_reward` SET `RewardText`='Your glorious battle honors the Valkyra queen.' WHERE `ID`=38816; -- Breaking the Bonespeakers
UPDATE `quest_offer_reward` SET `RewardText`='Ashildir\'s grave has been disturbed, outsider. $B$BDo you know something of this?' WHERE `ID`=38811; -- Judgment Day
UPDATE `quest_offer_reward` SET `RewardText`='I see you carry a branch of the Runewood. Then it was you who laid the spirits to rest? $B$BThough I do not know your purpose, outsider, I appreciate what you have done for our people.' WHERE `ID`=39791; -- Lay Them to Rest
UPDATE `quest_offer_reward` SET `RewardText`='These hearts are fat and bloody. $B$BThe slumbering rulers will not refuse an offering of Bjornharta.' WHERE `ID`=38808; -- Bjornharta
UPDATE `quest_offer_reward` SET `RewardText`='Yes, these Soulcaps should be adequate for your ritual. $B$BSpeak with me once you are ready to proceed and I will guide you further.' WHERE `ID`=38810; -- The Dreaming Fungus
UPDATE `quest_offer_reward` SET `RewardText`='So it was your footsteps I felt upon my woods as the runestones released their grip? $B$BYou have my thanks, outsider.' WHERE `ID`=38778; -- Turn the Keys
UPDATE `quest_offer_reward` SET `RewardText`='The Runewood will know peace once more with these Bonespeakers removed from the land. $B$BIt is a good beginning.' WHERE `ID`=39788; -- The Runewood's Revenge
UPDATE `quest_offer_reward` SET `RewardText`='Bound... twisted... $B$BThe Bonespeakers...' WHERE `ID`=39796; -- To Haustvald
UPDATE `quest_offer_reward` SET `RewardText`='A fine cut, I must say. $B$BYes, you will do well against the Bonespeakers, I think.' WHERE `ID`=39804; -- Speaking of Bones
UPDATE `quest_offer_reward` SET `RewardText`='Ah, the hero of the hour! We must waste no time! $B$BOur business at hand is most important if you wish to succeed in your trials!' WHERE `ID`=39803; -- The Trials Continue
UPDATE `quest_offer_reward` SET `RewardText`='Oh, hey! You must be lookin for them tauren was camped here. They just stepped out for a bit, but Snaggle here and I - we can take care of ya!$B$BYou say they were gonna pay you for killin\' some worgs, huh? No prob, bub!$B$BI ain\'t got a lot of gold, but these goods are pretty valuable. Take your pick!' WHERE `ID`=39789; -- Eating Into Our Business
UPDATE `quest_offer_reward` SET `RewardText`='<The raven squawks, and Havi\'s voice fills your head>$B$BYou are indeed mighty, as the trial shows. $B$BBut valor is a different animal - one you think to tame?' WHERE `ID`=38624; -- Cry Thunder!
UPDATE `quest_offer_reward` SET `RewardText`='You are truly a hero to my brood.  $B$BYou have gained a powerful ally today, outsider. The God-King has reason to fear you.' WHERE `ID`=39652; -- Where Dragons Rule
UPDATE `quest_offer_reward` SET `RewardText`='I am truly indebted to you for this act. My siblings were not able to defend themselves against the Felskorn, and would have ended up their slaves. $B$BYou are a true friend of the Thorignir.' WHERE `ID`=38413; -- Wings of Liberty
UPDATE `quest_offer_reward` SET `RewardText`='The Felskorn have witnessed true strength today. $B$BThey will think twice before raising their blades to you again.' WHERE `ID`=40568; -- Fury of the Storm
UPDATE `quest_offer_reward` SET `RewardText`='I am relieved to hear that our mother is safe. $B$BI am sure she will wish to thank you herself.' WHERE `ID`=38414; -- Heart of a Dragon
UPDATE `quest_offer_reward` SET `RewardText`='The trial is done and you yet live. This land is full of wonders, yes?$B$BBut it looks like the God-King intends to give you trials on top of trials. Still you must hurry, for even now, the next awaits!' WHERE `ID`=39597; -- The Blessing of the Watchers
UPDATE `quest_offer_reward` SET `RewardText`='The trial is done, and you emerge victorious! $B$BIt is a great feat you have done here, but you are not through yet. Many great challenges await you on your path to the Aegis.' WHERE `ID`=39594; -- A Trial of Might
UPDATE `quest_offer_reward` SET `RewardText`='The knowledge you\'ve gained is a powerful tool to use against your foes. $B$BDo not forget this.' WHERE `ID`=39592; -- A Trial of Will
UPDATE `quest_offer_reward` SET `RewardText`='The knowledge you\'ve gained is a powerful tool to use against your foes. $B$BDo not forget this.' WHERE `ID`=39592; -- A Trial of Will
UPDATE `quest_offer_reward` SET `RewardText`='Wonderful! $B$BIt is good to be whole again!' WHERE `ID`=39593; -- The Shattered Watcher
UPDATE `quest_offer_reward` SET `RewardText`='You have learned of the obstacles you must face. $B$BDo you still wish to continue?' WHERE `ID`=39591; -- A Trial of Valor
UPDATE `quest_offer_reward` SET `RewardText`='It is a shame to see the first worthy challenger for the Aegis treating the trials with such disrespect. Such hubris cannot win the Aegis, for the gods will surely strike him down for his arrogance.\n\nYou, however, seem different. You have shown that you are a worthy challenger. $B$BI will allow you to begin the trials.' WHERE `ID`=39590; -- Ahead of the Game
UPDATE `quest_offer_reward` SET `RewardText`='I appreciate your gifts, outsider. You show great respect to the trials. $B$BYou do well to honor our ways.' WHERE `ID`=39595; -- Blood and Gold
UPDATE `quest_offer_reward` SET `RewardText`='Hah, you throw like a shieldmaiden!$B$BWhat? That\'s a good thing! $B$BTry the stew, young champion, and savor the taste of a task well done.' WHERE `ID`=38331; -- Havi's Test
UPDATE `quest_offer_reward` SET `RewardText`='This looks like one of the grapple launchers the local vrykul use to scale the steep ridges in Stormheim.$B$BThis could come in handy.' WHERE `ID`=39775; -- Stormforged Grapple Launcher


UPDATE `quest_greeting` SET `Greeting`='We face a formidable foe, but we must not let Helya win.' WHERE (`ID`=97480 AND `Type`=0); -- 97480
UPDATE `quest_greeting` SET `Greeting`='We face a formidable foe, but we must not let Helya win.' WHERE (`ID`=97480 AND `Type`=0); -- 97480
UPDATE `quest_greeting` SET `Greeting`='I\'m sure ye don\'t belong here in Helheim, just like me.  $B$BI just hope Helya agrees with us.' WHERE (`ID`=91531 AND `Type`=0); -- 91531
UPDATE `quest_greeting` SET `Greeting`='I\'m sure ye don\'t belong here in Helheim, just like me.  $B$BI just hope Helya agrees with us.' WHERE (`ID`=91531 AND `Type`=0); -- 91531
UPDATE `quest_greeting` SET `Greeting`='What have you uncovered in Haustvald, outsider?' WHERE (`ID`=97270 AND `Type`=0); -- 97270
UPDATE `quest_greeting` SET `Greeting`='What have you uncovered in Haustvald, outsider?' WHERE (`ID`=97270 AND `Type`=0); -- 97270
UPDATE `quest_greeting` SET `Greeting`='The Mystics have committed an unforgivable heresy here. The Valkyra will not forget this trespass.' WHERE (`ID`=93446 AND `Type`=0); -- 93446
UPDATE `quest_greeting` SET `Greeting`='You... $B$BYou are not like the others.' WHERE (`ID`=91249 AND `Type`=0); -- 91249
UPDATE `quest_greeting` SET `Greeting`='This cannot be! What kind of gall does this Skovald have to disregard these ancient rites! $B$BThis must not stand!' WHERE (`ID`=243836 AND `Type`=1); -- 243836
UPDATE `quest_greeting` SET `Greeting`='This cannot be! What kind of gall does this Skovald have to disregard these ancient rites! $B$BThis must not stand!' WHERE (`ID`=243836 AND `Type`=1); -- 243836
UPDATE `quest_greeting` SET `Greeting`='This cannot be! What kind of gall does this Skovald have to disregard these ancient rites! $B$BThis must not stand!' WHERE (`ID`=243836 AND `Type`=1); -- 243836
UPDATE `quest_greeting` SET `Greeting`='This cannot be! What kind of gall does this Skovald have to disregard these ancient rites! $B$BThis must not stand!' WHERE (`ID`=243836 AND `Type`=1); -- 243836
UPDATE `quest_greeting` SET `Greeting`='This cannot be! What kind of gall does this Skovald have to disregard these ancient rites! $B$BThis must not stand!' WHERE (`ID`=243836 AND `Type`=1); -- 243836

UPDATE `quest_request_items` SET `VerifiedBuild`=23420 WHERE `ID`=42446; -- Singed Feathers
UPDATE `quest_request_items` SET `CompletionText`='This appears to be the last verse.' WHERE `ID`=39405; -- Stories of Battle
UPDATE `quest_request_items` SET `CompletionText`='The jailer has... the key...', `VerifiedBuild`=23420 WHERE `ID`=40002; -- A Familiar Fate
UPDATE `quest_request_items` SET `CompletionText`='Were you able to secure the lantern?' WHERE `ID`=39849; -- To Light the Way
UPDATE `quest_request_items` SET `CompletionText`='<The air hangs silent as you approach.>', `VerifiedBuild`=23420 WHERE `ID`=39848; -- A Desperate Bargain
UPDATE `quest_request_items` SET `VerifiedBuild`=23420 WHERE `ID`=38347; -- Stealth by Seaweed
UPDATE `quest_request_items` SET `CompletionText`='Do ye have enough for a proper disguise?' WHERE `ID`=38339; -- A Little Kelp From My Foes
UPDATE `quest_request_items` SET `CompletionText`='Make sure ye\'ve got enough bones before we move on.' WHERE `ID`=38324; -- Accessories of the Cursed
UPDATE `quest_request_items` SET `CompletionText`='Were you able to recover her remains?' WHERE `ID`=38817; -- Regal Remains
UPDATE `quest_request_items` SET `CompletionText`='How went the hunt, outsider?' WHERE `ID`=38808; -- Bjornharta
UPDATE `quest_request_items` SET `CompletionText`='What do you bring?' WHERE `ID`=38810; -- The Dreaming Fungus
UPDATE `quest_request_items` SET `CompletionText`='What news do you bring of my brothers and sisters?', `VerifiedBuild`=23420 WHERE `ID`=38413; -- Wings of Liberty
UPDATE `quest_request_items` SET `CompletionText`='Have you managed to find them all?' WHERE `ID`=39593; -- The Shattered Watcher
UPDATE `quest_request_items` SET `CompletionText`='An ironic gift you bring me, challenger.' WHERE `ID`=39590; -- Ahead of the Game
UPDATE `quest_request_items` SET `CompletionText`='What is this you bring?$B$BYou honor me, outsider.' WHERE `ID`=39595; -- Blood and Gold


UPDATE `creature_template_addon` SET `bytes1`=1 WHERE `entry`=97809; -- 97809 (Coastal Seagull)
UPDATE `creature_template_addon` SET `bytes2`=0 WHERE `entry`=109639; -- 109639 (Dread-Rider Stalker)
UPDATE `creature_template_addon` SET `bytes2`=2 WHERE `entry`=109640; -- 109640 (Dread-Rider Plaguebringer)
UPDATE `creature_template_addon` SET `auras`='204227 215919' WHERE `entry`=109083; -- 109083 (Houndmaster Payne)
UPDATE `creature_template_addon` SET `auras`='214213 221011' WHERE `entry`=107926; -- 107926 (Hannval the Butcher)
UPDATE `creature_template_addon` SET `movementAnimKit`=5174 WHERE `entry`=92613; -- 92613 (Priestess Liza)
UPDATE `creature_template_addon` SET `movementAnimKit`=5174 WHERE `entry`=92609; -- 92609 (Tracker Jack)
UPDATE `creature_template_addon` SET `movementAnimKit`=5174 WHERE `entry`=92611; -- 92611 (Ambusher Daggerfang)
UPDATE `creature_template_addon` SET `movementAnimKit`=5174 WHERE `entry`=92604; -- 92604 (Champion Elodie)
UPDATE `creature_template_addon` SET `bytes1`=0, `aiAnimKit`=644 WHERE `entry`=106565; -- 106565 (Blackfeather Gatherer)
UPDATE `creature_template_addon` SET `aiAnimKit`=11868 WHERE `entry`=93628; -- 93628 (Eyir)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=94856; -- 94856 (Priestess of Eyir)
UPDATE `creature_template_addon` SET `bytes1`=50593792, `auras`='159474' WHERE `entry`=95073; -- 95073 (Forsaken Dreadwing)
UPDATE `creature_template_addon` SET `auras`='189107 194267' WHERE `entry`=109635; -- 109635 (Greywatch Saboteur)
UPDATE `creature_template_addon` SET `aiAnimKit`=1588 WHERE `entry`=95436; -- 95436 (Greywatch Cannoneer)
UPDATE `creature_template_addon` SET `bytes1`=0, `bytes2`=0, `auras`='' WHERE `entry`=109452; -- 109452 (Dreadwake Deathguard)
UPDATE `creature_template_addon` SET `bytes1`=1, `bytes2`=0, `auras`='' WHERE `entry`=93612; -- 93612 (Dreadwake Deathguard)
UPDATE `creature_template_addon` SET `bytes2`=0 WHERE `entry`=93584; -- 93584 (Tideskorn Shieldmaiden)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=32641; -- 32641 (Drix Blackwrench)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=32642; -- 32642 (Mojodishu)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=94338; -- 94338 (Dread-Rider Stalker)
UPDATE `creature_template_addon` SET `auras`='191192' WHERE `entry`=97821; -- 97821 (Felskorn Oathbinder)
UPDATE `creature_template_addon` SET `auras`='218325' WHERE `entry`=97906; -- 97906 (Runebound Wretch)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=97851; -- 97851 (Felskorn Chosen)
UPDATE `creature_template_addon` SET `mount`=70361 WHERE `entry`=92307; -- 92307 (God-King Skovald)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=97825; -- 97825 (Felskorn Cleaver)
UPDATE `creature_template_addon` SET `auras`='174714' WHERE `entry`=95620; -- 95620 (Servant of Skovald)
UPDATE `creature_template_addon` SET `auras`='186529' WHERE `entry`=91657; -- 91657 (Bloodbeard)
UPDATE `creature_template_addon` SET `auras`='145953' WHERE `entry`=91384; -- 91384 (Helhound)
UPDATE `creature_template_addon` SET `aiAnimKit`=7876 WHERE `entry`=91454; -- 91454 (Helya's Tentacle)
UPDATE `creature_template_addon` SET `bytes1`=50331648 WHERE `entry`=91527; -- 91527 (Dread Falke)
UPDATE `creature_template_addon` SET `aiAnimKit`=0, `auras`='211179' WHERE `entry`=91818; -- 91818 (Unworthy Soul)
UPDATE `creature_template_addon` SET `auras`='216856' WHERE `entry`=93071; -- 93071 (Bonespeaker Mystic)
UPDATE `creature_template_addon` SET `bytes2`=0 WHERE `entry`=108939; -- 108939 (Bonespeaker Cleaver)
UPDATE `creature_template_addon` SET `bytes1`=3, `bytes2`=0, `auras`='' WHERE `entry`=108940; -- 108940 (Ancient Boneservant)
UPDATE `creature_template_addon` SET `bytes1`=50331648, `auras`='184840 221829' WHERE `entry`=93094; -- 93094 (Restless Ancestor)
UPDATE `creature_template_addon` SET `aiAnimKit`=9627 WHERE `entry`=107588; -- 107588 (Blood-Thane Lucard)
UPDATE `creature_template_addon` SET `aiAnimKit`=5583 WHERE `entry`=108150; -- 108150 (Drained Corsair)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=108030; -- 108030 (Blood-Crazed Swashbuckler)
UPDATE `creature_template_addon` SET `bytes2`=0 WHERE `entry`=112481; -- 112481 (Felskorn Zealot)
UPDATE `creature_template_addon` SET `auras`='198479' WHERE `entry`=112480; -- 112480 (Servant of Skovald)
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=97890; -- 97890 (Dravax)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=108856; -- 108856 (Agitated Stonewarden)
UPDATE `creature_template_addon` SET `bytes1`=0, `auras`='123169' WHERE `entry`=108890; -- 108890 (Runewood Greatstag)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=93070; -- 93070 (Bonespeaker Carver)
UPDATE `creature_template_addon` SET `aiAnimKit`=11760, `auras`='221016' WHERE `entry`=93401; -- 93401 (Urgev the Flayer)
UPDATE `creature_template_addon` SET `bytes2`=1, `auras`='' WHERE `entry`=93066; -- 93066 (Bonespeaker Runeaxe)
UPDATE `creature_template_addon` SET `auras`='122729' WHERE `entry`=62821; -- 62821 (Mystic Birdhat)
UPDATE `creature_template_addon` SET `auras`='122729' WHERE `entry`=62822; -- 62822 (Cousin Slowhands)
UPDATE `creature_template_addon` SET `auras`='213834' WHERE `entry`=107689; -- 107689 (Mook Laborer)
UPDATE `creature_template_addon` SET `aiAnimKit`=8081 WHERE `entry`=92962; -- 92962 (Saboteur Aronson)
UPDATE `creature_template_addon` SET `auras`='46598' WHERE `entry`=92374; -- 92374 (Drekirjar Galeborn)
UPDATE `creature_template_addon` SET `aiAnimKit`=7763 WHERE `entry`=91767; -- 91767 (Vethir)
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=106648; -- 106648 (Stormwing Drake)
UPDATE `creature_template_addon` SET `auras`='174127' WHERE `entry`=91244; -- 91244 (Felskorn Trapper)
UPDATE `creature_template_addon` SET `bytes1`=1, `auras`='' WHERE `entry`=91566; -- 91566 (Felskorn Executioner)
UPDATE `creature_template_addon` SET `bytes2`=0 WHERE `entry`=91205; -- 91205 (Drekirjar Galeborn)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=107965; -- 107965 (Canyon Rockeater)
UPDATE `creature_template_addon` SET `auras`='186480' WHERE `entry`=91204; -- 91204 (Tideskorn Longaxe)
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=108526; -- 108526 (Tideskorn Worker)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=91417; -- 91417 (Tideskorn Worker)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=100446; -- 100446 (Tideskorn Huntress)
UPDATE `creature_template_addon` SET `auras`='81173' WHERE `entry`=111291; -- 111291 (Stonescar River-Thresher)
UPDATE `creature_template_addon` SET `aiAnimKit`=8181 WHERE `entry`=107954; -- 107954 (Stoned Vrykul)
UPDATE `creature_template_addon` SET `aiAnimKit`=7811 WHERE `entry`=107957; -- 107957 (Stoned Bird)
UPDATE `creature_template_addon` SET `aiAnimKit`=2619 WHERE `entry`=96282; -- 96282 (Vault Guardian)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=108263; -- 108263 (Felskorn Warmonger)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=100838; -- 100838 (Thunderhorn)
UPDATE `creature_template_addon` SET `auras`='190664' WHERE `entry`=35845; -- 35845 (Dave's Industrial Light and Magic Bunny (Small)(Sessile))
UPDATE `creature_template_addon` SET `auras`='190746' WHERE `entry`=34527; -- 34527 (Dave's Industrial Light and Magic Bunny (Small))
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=55370; -- 55370 (General Purpose Bunny ZTO)
UPDATE `creature_template_addon` SET `auras`='195388' WHERE `entry`=90747; -- 90747 (Slash Gutspill)
UPDATE `creature_template_addon` SET `aiAnimKit`=2619 WHERE `entry`=89817; -- 89817 (Vault Guardian)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=96135; -- 96135 (Felskorn Warmonger)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=96129; -- 96129 (Felskorn Raider)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=96236; -- 96236 (Mightstone Savage)
UPDATE `creature_template_addon` SET `bytes1`=50331648 WHERE `entry`=97755; -- 97755 (Galecrested Eagle)
UPDATE `creature_template_addon` SET `bytes1`=1 WHERE `entry`=108322; -- 108322 (Ferngrazer Stag)
UPDATE `creature_template_addon` SET `bytes1`=1 WHERE `entry`=108927; -- 108927 (Gluttonous Raven)
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry`=91468; -- 91468 (Spymaster Illandris)
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=97305; -- 97305 (Huginn)
UPDATE `creature_template_addon` SET `bytes1`=262144, `auras`='123169 159474' WHERE `entry`=97828; -- 97828 (Silvertail Mountain Goat)
UPDATE `creature_template_addon` SET `bytes1`=262144, `auras`='123978 159474' WHERE `entry`=91824; -- 91824 (Bluffwalker Goat)
UPDATE `creature_template_addon` SET `bytes1`=1 WHERE `entry`=111206; -- 111206 (Saberfang Worg)
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=110534; -- 110534 (Provisioner Sheldon)
UPDATE `creature_template_addon` SET `bytes1`=8 WHERE `entry`=91885; -- 91885 (Forsaken Crewman)

DELETE FROM `creature_model_info` WHERE `DisplayID`=25202;
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES
(25202, 0.574999988079071044, 2.529999971389770507, 0, 23420);

UPDATE `creature_equip_template` SET `ItemID1`=120406 WHERE (`CreatureID`=107926 AND `ID`=2); -- Hannval the Butcher
UPDATE `creature_equip_template` SET `ItemID1`=0 WHERE (`CreatureID`=107926 AND `ID`=1); -- Hannval the Butcher


UPDATE `gossip_menu_option` SET `OptionText`='What do you have for sale?' WHERE (`MenuId`=19808 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='Why are you moving the taurens\' goods over to your zeppelin?', `OptionBroadcastTextId`=113024 WHERE (`MenuId`=19808 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='What do you have for sale?' WHERE (`MenuId`=19808 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='Why are you moving the taurens\' goods over to your zeppelin?', `OptionBroadcastTextId`=113024 WHERE (`MenuId`=19808 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='What do you have for sale?' WHERE (`MenuId`=19808 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='Why are you moving the taurens\' goods over to your zeppelin?', `OptionBroadcastTextId`=113024 WHERE (`MenuId`=19808 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='What do you have for sale?' WHERE (`MenuId`=19808 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='Why are you moving the taurens\' goods over to your zeppelin?', `OptionBroadcastTextId`=113024 WHERE (`MenuId`=19808 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=23420 WHERE (`MenuId`=19774 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=23420 WHERE (`MenuId`=19774 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=23420 WHERE (`MenuId`=20708 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=23420 WHERE (`MenuId`=20708 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='Attempt to commune with the statue.', `OptionBroadcastTextId`=96207 WHERE (`MenuId`=18543 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=23420 WHERE (`MenuId`=20270 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=23420 WHERE (`MenuId`=20270 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='Take me back to the Gates of Valor.', `OptionBroadcastTextId`=99988 WHERE (`MenuId`=18852 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='Take me to the top, Vethir!', `OptionBroadcastTextId`=99941 WHERE (`MenuId`=18843 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='Use the Jailer\'s Shard to break Vethir\'s prison.', `OptionBroadcastTextId`=99850 WHERE (`MenuId`=18828 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='Use the Jailer\'s Shard to break Vethir\'s prison.', `OptionBroadcastTextId`=99850 WHERE (`MenuId`=18828 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='We have defeated your champion. Now, release us from Helheim!', `OptionBroadcastTextId`=99516 WHERE (`MenuId`=18790 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='I do not belong here! I wish to leave Helheim!', `OptionBroadcastTextId`=99443 WHERE (`MenuId`=18790 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='Let me browse your goods.' WHERE (`MenuId`=20232 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='Make this inn your home.', `OptionBroadcastTextId`=2822 WHERE (`MenuId`=20232 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='Show me your wares.' WHERE (`MenuId`=19781 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='What do you have for sale?' WHERE (`MenuId`=19808 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='Why are you moving the taurens\' goods over to your zeppelin?', `OptionBroadcastTextId`=113024 WHERE (`MenuId`=19808 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='What do you have for sale?' WHERE (`MenuId`=19808 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='Why are you moving the taurens\' goods over to your zeppelin?', `OptionBroadcastTextId`=113024 WHERE (`MenuId`=19808 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='What do you have for sale?' WHERE (`MenuId`=19808 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionText`='Why are you moving the taurens\' goods over to your zeppelin?', `OptionBroadcastTextId`=113024 WHERE (`MenuId`=19808 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='I am prepared to receive your gift.', `OptionBroadcastTextId`=98776 WHERE (`MenuId`=18741 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='Fly me to the summit, Vethir.', `OptionBroadcastTextId`=98282 WHERE (`MenuId`=18693 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionText`='I am ready to receive your gift, Yotnar.', `OptionBroadcastTextId`=97814 WHERE (`MenuId`=18672 AND `OptionIndex`=0);




UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=109639; -- Dread-Rider Stalker
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=1 WHERE `entry`=92764; -- Valkyra Aspirant
UPDATE `creature_template` SET `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=95073; -- Forsaken Dreadwing
UPDATE `creature_template` SET `unit_flags`=32768, `unit_flags2`=2048, `dynamicflags`=0 WHERE `entry`=109452; -- Dreadwake Deathguard
UPDATE `creature_template` SET `unit_flags`=32768, `unit_flags2`=2048, `dynamicflags`=0 WHERE `entry`=93612; -- Dreadwake Deathguard
UPDATE `creature_template` SET `speed_walk`=0.5, `speed_run`=0.571428596973419189 WHERE `entry`=97944; -- Muorg
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=97821; -- Felskorn Oathbinder
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=97906; -- Runebound Wretch
UPDATE `creature_template` SET `HoverHeight`=20 WHERE `entry`=92307; -- God-King Skovald
UPDATE `creature_template` SET `unit_flags2`=35653632 WHERE `entry`=97825; -- Felskorn Cleaver
UPDATE `creature_template` SET `unit_flags`=33587200 WHERE `entry`=98953; -- Tideskorn Shieldmaiden
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=98955; -- Tideskorn Warbear
UPDATE `creature_template` SET `unit_flags`=33024 WHERE `entry`=97665; -- Valkyra Guardian
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=91974; -- Bones of the Defeated
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=91818; -- Unworthy Soul
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=105680; -- Bonespeaker Drudge
UPDATE `creature_template` SET `unit_flags`=32848 WHERE `entry`=108939; -- Bonespeaker Cleaver
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=93094; -- Restless Ancestor
UPDATE `creature_template` SET `unit_flags`=32784 WHERE `entry`=108030; -- Blood-Crazed Swashbuckler
UPDATE `creature_template` SET `unit_flags`=32768, `unit_flags2`=2048, `dynamicflags`=0 WHERE `entry`=108890; -- Runewood Greatstag
UPDATE `creature_template` SET `gossip_menu_id`=19809 WHERE `entry`=107675; -- Rax Sixtrigger
UPDATE `creature_template` SET `unit_flags`=33024 WHERE `entry`=97143; -- Juvenile Thorignir
UPDATE `creature_template` SET `unit_flags`=32832 WHERE `entry`=91759; -- Felskorn Subduer
UPDATE `creature_template` SET `unit_flags`=32768, `unit_flags2`=2048, `dynamicflags`=0 WHERE `entry`=91566; -- Felskorn Executioner
UPDATE `creature_template` SET `unit_flags`=67141632 WHERE `entry`=107965; -- Canyon Rockeater
UPDATE `creature_template` SET `unit_flags`=32784 WHERE `entry`=111291; -- Stonescar River-Thresher
UPDATE `creature_template` SET `unit_flags`=32784 WHERE `entry`=97091; -- Duskpelt Snarler
UPDATE `creature_template` SET `unit_flags`=32848 WHERE `entry`=93166; -- Tiptog the Lost
UPDATE `creature_template` SET `unit_flags2`=2048 WHERE `entry`=108289; -- Bloodtotem Skirmisher
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.992062866687774658 WHERE `entry`=98417; -- Enamored Ravenbear
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.992062866687774658 WHERE `entry`=91468; -- Spymaster Illandris
UPDATE `creature_template` SET `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=97828; -- Silvertail Mountain Goat
UPDATE `creature_template` SET `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=91824; -- Bluffwalker Goat
UPDATE `creature_template` SET `unit_flags2`=2048 WHERE `entry`=110534; -- Provisioner Sheldon

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (246297 /*Arcane Coil*/, 266432 /*Arcfence Post*/, 246328 /*Arcane Coil*/, 266787 /*Candles*/, 266785 /*Candles*/, 266827 /*Web*/, 266795 /*Book*/, 251618 /*Teleporter*/, 266791 /*Scrolls*/, 266776 /*Bookshelf*/, 266778 /*Bookshelf*/, 266773 /*Book*/, 266772 /*Book*/, 266771 /*Book*/, 266783 /*Crate*/, 266805 /*Web*/, 245950 /*Fountain*/, 246225 /*Weathered Telemancy Beacon*/, 245947 /*Telemetry Lab*/, 245948 /*Breakfast Nook*/, 245942 /*Garden*/, 245928 /*Workshop*/, 245927 /*Warp Lab*/, 245926 /*Library*/, 266789 /*Table*/, 266784 /*Crate*/, 266793 /*Table*/, 245954 /*Fountain*/, 266777 /*Bookshelf*/, 266779 /*Bookshelf*/, 251617 /*Gate*/, 266775 /*Table*/, 266774 /*Table*/, 266781 /*Pylon*/, 266780 /*Books*/, 246229 /*Cracked Warpsleeve*/, 245925 /*Garden*/, 246237 /*Test Chamber*/, 266126 /*"Your Ancestors"*/, 251190 /*Containment Field*/, 252779 /*Arcway Outlet*/, 254069 /*Spilled Arcwine*/, 266055 /*Stasis Pad*/, 266433 /*Arcshaper Rune*/, 253136 /*Teleporter*/, 253135 /*Teleporter*/, 252850 /*Small Treasure Chest*/, 266103 /*Courier Bag*/, 247050 /*Mornath's Curio Chest*/, 252860 /*Small Treasure Chest*/, 250991 /*Spell Barrier*/, 253286 /*Nightborne Basket Stack 01*/, 260247 /*Ancient Mana Chunk*/, 247694 /*Kel'danath's Knapsack*/, 248407 /*Kel'danath's Manaflask*/, 252263 /*Leyline Feed*/, 252810 /*Small Treasure Chest*/, 252809 /*Treasure Chest*/, 251489 /*Cage*/, 252262 /*Leyline Feed*/, 251416 /*Ancient Mana Chunk*/, 260248 /*Ancient Mana Shard*/, 260249 /*Ancient Mana Shard*/, 245126 /*Crystallized Ancient Mana*/, 253930 /*Portal to Exodar*/, 242038 /*Wall Lamp*/, 257291 /*Nightborne Treasure Chest*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(246297, 0, 262144, 0), -- Arcane Coil
(266432, 0, 16, 0), -- Arcfence Post
(246328, 0, 262144, 0), -- Arcane Coil
(266787, 1375, 0, 0), -- Candles
(266785, 1375, 0, 0), -- Candles
(266827, 1375, 0, 0), -- Web
(266795, 1375, 0, 0), -- Book
(251618, 114, 0, 0), -- Teleporter
(266791, 1375, 0, 0), -- Scrolls
(266776, 1375, 0, 0), -- Bookshelf
(266778, 1375, 0, 0), -- Bookshelf
(266773, 1375, 0, 0), -- Book
(266772, 1375, 0, 0), -- Book
(266771, 1375, 0, 0), -- Book
(266783, 1375, 8192, 0), -- Crate
(266805, 1375, 0, 0), -- Web
(245950, 0, 262145, 0), -- Fountain
(246225, 0, 2113540, 0), -- Weathered Telemancy Beacon
(245947, 0, 262145, 0), -- Telemetry Lab
(245948, 0, 262144, 0), -- Breakfast Nook
(245942, 0, 262144, 0), -- Garden
(245928, 0, 262144, 0), -- Workshop
(245927, 0, 262145, 0), -- Warp Lab
(245926, 0, 262145, 0), -- Library
(266789, 1375, 8192, 0), -- Table
(266784, 1375, 8192, 0), -- Crate
(266793, 1375, 8192, 0), -- Table
(245954, 0, 262144, 0), -- Fountain
(266777, 1375, 8192, 0), -- Bookshelf
(266779, 1375, 8192, 0), -- Bookshelf
(251617, 114, 32, 0), -- Gate
(266775, 1375, 8192, 0), -- Table
(266774, 1375, 8192, 0), -- Table
(266781, 1375, 8192, 0), -- Pylon
(266780, 1375, 8192, 0), -- Books
(246229, 0, 2113540, 0), -- Cracked Warpsleeve
(245925, 0, 262145, 0), -- Garden
(246237, 0, 262144, 0), -- Test Chamber
(266126, 0, 262144, 0), -- "Your Ancestors"
(251190, 0, 0, 5279), -- Containment Field
(252779, 0, 262144, 0), -- Arcway Outlet
(254069, 0, 0, 0), -- Spilled Arcwine
(266055, 0, 16, 0), -- Stasis Pad
(266433, 0, 16, 0), -- Arcshaper Rune
(253136, 114, 0, 0), -- Teleporter
(253135, 114, 0, 0), -- Teleporter
(252850, 0, 2113536, 2437), -- Small Treasure Chest
(266103, 0, 4, 0), -- Courier Bag
(247050, 0, 2113540, 0), -- Mornath's Curio Chest
(252860, 0, 2113536, 2437), -- Small Treasure Chest
(250991, 0, 262144, 0), -- Spell Barrier
(253286, 1375, 8192, 0), -- Nightborne Basket Stack 01
(260247, 0, 2113536, 6658), -- Ancient Mana Chunk
(247694, 0, 4, 0), -- Kel'danath's Knapsack
(248407, 0, 2121728, 3597), -- Kel'danath's Manaflask
(252263, 0, 4, 0), -- Leyline Feed
(252810, 0, 2113536, 2437), -- Small Treasure Chest
(252809, 0, 0, 2437), -- Treasure Chest
(251489, 0, 8192, 0), -- Cage
(252262, 0, 4, 0), -- Leyline Feed
(251416, 0, 2113536, 5546), -- Ancient Mana Chunk
(260248, 0, 2113536, 6658), -- Ancient Mana Shard
(260249, 0, 2113536, 6658), -- Ancient Mana Shard
(245126, 0, 2113540, 0), -- Crystallized Ancient Mana
(253930, 35, 0, 0), -- Portal to Exodar
(242038, 1375, 0, 0), -- Wall Lamp
(257291, 0, 0, 2437); -- Nightborne Treasure Chest

UPDATE `gameobject_template_addon` SET `faction`=114, `flags`=32 WHERE `entry`=221482; -- PA Mug Bamboo 06
UPDATE `gameobject_template_addon` SET `flags`=16 WHERE `entry`=215168; -- Large Treasure Pile
UPDATE `gameobject_template_addon` SET `flags`=16 WHERE `entry`=215170; -- Large Treasure Pile

DELETE FROM `quest_offer_reward` WHERE `ID` IN (44691 /*Hungry Work*/, 43106 /*Feed Oculeth*/, 42147 /*First Contact*/, 40830 /*Close Enough*/, 40748 /*Network Security*/, 40747 /*The Delicate Art of Telemancy*/, 40011 /*Oculeth's Workshop*/, 42079 /*Masquerade*/, 41989 /*Blood of My Blood*/, 41834 /*The Masks We Wear*/, 41762 /*Sympathizers Among the Shal'dorei*/, 41760 /*Kel'danath's Legacy*/, 41704 /*Subject 16*/, 40796 /*Lingering on the Edge*/, 41702 /*Written in Stone*/, 40326 /*Scattered Memories*/, 41149 /*A Re-Warding Effort*/, 40012 /*An Old Ally*/, 44672 /*Ancient Mana*/, 42229 /*Shal'Aran*/, 40009 /*Arcane Thirst*/, 40123 /*The Nightborne Pact*/, 40008 /*The Only Way Out is Through*/, 39987 /*Trail of Echoes*/, 39986 /*Magic Message*/, 39985 /*Khadgar's Discovery*/, 44009 /*A Falling Star*/);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(44691, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, I am feeling much better. Thank you!$B$BNow let us get to work.', 23420), -- Hungry Work
(43106, 0, 0, 0, 0, 0, 0, 0, 0, '<As you offer the mana crystals, they blink out of your hand one by one.>', 23420), -- Feed Oculeth
(42147, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lunastre family is well-connected. They will be of great help to us when the time comes.', 23420), -- First Contact
(40830, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you for recovering Oculeth. He will be an invaluable asset to our cause.', 23420), -- Close Enough
(40748, 0, 0, 0, 0, 0, 0, 0, 0, 'Did we... make it?', 23420), -- Network Security
(40747, 0, 0, 0, 0, 0, 0, 0, 0, 'These are in rough shape, but they will suffice.', 23420), -- The Delicate Art of Telemancy
(40011, 0, 0, 0, 0, 0, 0, 0, 0, 'You may deliver me to Thalyssra once my work here is complete.', 23420), -- Oculeth's Workshop
(42079, 0, 0, 0, 0, 0, 0, 0, 0, 'My little $Gbrother:sister; is about to turn over a new leaf, whether $Ghe:she; likes it or not.', 23420), -- Masquerade
(41989, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you. Now our work can begin.', 23420), -- Blood of My Blood
(41834, 0, 0, 0, 0, 0, 0, 0, 0, 'That mask suits you.$B$BIn Suramar, it can be quite advantageous to be someone else for a time...', 23420), -- The Masks We Wear
(41762, 0, 0, 0, 0, 0, 0, 0, 0, 'We should be safe to speak here for a moment.', 23420), -- Sympathizers Among the Shal'dorei
(41760, 0, 0, 0, 0, 0, 0, 0, 0, 'Fascinating.$B$BLet us hope the spell holds.', 23420), -- Kel'danath's Legacy
(41704, 0, 0, 0, 0, 0, 0, 0, 0, 'So, Kel\'danath turned in the end...$B$BHe deserved better. Thank you for giving him peace.', 23420), -- Subject 16
(40796, 7, 0, 0, 0, 0, 0, 0, 0, '<Absolon immediately consumes the Ancient Mana and seems incapable of speech for a short while.>', 23420), -- Lingering on the Edge
(41702, 0, 0, 0, 0, 0, 0, 0, 0, '<A small tag hanging from his sleeve reads \"16 - Theryn.\">', 23420), -- Written in Stone
(40326, 0, 0, 0, 0, 0, 0, 0, 0, '<A bag containing countless pages of technical notes. Flipping through them, you find Kel\'danath\'s last journal entry.>', 23420), -- Scattered Memories
(41149, 0, 0, 0, 0, 0, 0, 0, 0, '<The ward snaps to life, giving you a slight pinch. Kel\'danath must have put great care into developing a spell that would scare the withered away without harming them.>', 23420), -- A Re-Warding Effort
(40012, 0, 0, 0, 0, 0, 0, 0, 0, '<Somebody has been living here recently. This scroll bears strange lettering that glows warmly, beckoning your hand.>', 23420), -- An Old Ally
(44672, 0, 0, 0, 0, 0, 0, 0, 0, 'Keep a lookout for those crystal formations all over Suramar. We will need them.', 23420), -- Ancient Mana
(42229, 1, 0, 0, 0, 0, 0, 0, 0, 'Such a temporary home will serve us well.', 23420), -- Shal'Aran
(40009, 0, 0, 0, 0, 0, 0, 0, 0, '<Thalyssra takes the crystals with a trembling hand.>', 23420), -- Arcane Thirst
(40123, 0, 0, 0, 0, 0, 0, 0, 0, 'We must find a way to reclaim Suramar City.', 23420), -- The Nightborne Pact
(40008, 0, 0, 0, 0, 0, 0, 0, 0, 'You fight well.$B$BPerhaps it is time for a proper introduction.', 23420), -- The Only Way Out is Through
(39987, 0, 0, 0, 0, 0, 0, 0, 0, 'An outlander...$B$BYou received my message?', 23420), -- Trail of Echoes
(39986, 0, 0, 0, 0, 0, 0, 0, 0, 'A magical message in a bottle, slipped right beneath the Legion\'s nose... Clever.', 23420), -- Magic Message
(39985, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you for coming, $p.', 23420), -- Khadgar's Discovery
(44009, 0, 0, 0, 0, 0, 0, 0, 0, 'Most curious indeed! This is no object of the Legion\'s making. Let me have a closer look.', 23420); -- A Falling Star


DELETE FROM `quest_details` WHERE `ID` IN (40798 /*Cling to Hope*/, 40956 /*Survey Says...*/, 44691 /*Hungry Work*/, 40830 /*Close Enough*/, 40748 /*Network Security*/, 40747 /*The Delicate Art of Telemancy*/, 42147 /*First Contact*/, 42079 /*Masquerade*/, 41989 /*Blood of My Blood*/, 41834 /*The Masks We Wear*/, 41762 /*Sympathizers Among the Shal'dorei*/, 41760 /*Kel'danath's Legacy*/, 40796 /*Lingering on the Edge*/, 41704 /*Subject 16*/, 41702 /*Written in Stone*/, 41149 /*A Re-Warding Effort*/, 40326 /*Scattered Memories*/, 40012 /*An Old Ally*/, 40011 /*Oculeth's Workshop*/, 44672 /*Ancient Mana*/, 42229 /*Shal'Aran*/, 40009 /*Arcane Thirst*/, 40123 /*The Nightborne Pact*/, 40008 /*The Only Way Out is Through*/, 39987 /*Trail of Echoes*/, 39986 /*Magic Message*/, 45422 /*Edict of the God-King*/);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(40798, 1, 0, 0, 0, 0, 0, 0, 0, 23420), -- Cling to Hope
(40956, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Survey Says...
(44691, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Hungry Work
(40830, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Close Enough
(40748, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Network Security
(40747, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- The Delicate Art of Telemancy
(42147, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- First Contact
(42079, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Masquerade
(41989, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Blood of My Blood
(41834, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- The Masks We Wear
(41762, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Sympathizers Among the Shal'dorei
(41760, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Kel'danath's Legacy
(40796, 1, 18, 0, 0, 0, 1500, 0, 0, 23420), -- Lingering on the Edge
(41704, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Subject 16
(41702, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Written in Stone
(41149, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- A Re-Warding Effort
(40326, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Scattered Memories
(40012, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- An Old Ally
(40011, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Oculeth's Workshop
(44672, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Ancient Mana
(42229, 1, 0, 0, 0, 0, 0, 0, 0, 23420), -- Shal'Aran
(40009, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Arcane Thirst
(40123, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- The Nightborne Pact
(40008, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- The Only Way Out is Through
(39987, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Trail of Echoes
(39986, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Magic Message
(45422, 1, 1, 0, 0, 0, 0, 0, 0, 23420); -- Edict of the God-King

DELETE FROM `quest_request_items` WHERE `ID` IN (43106 /*Feed Oculeth*/, 42147 /*First Contact*/, 40747 /*The Delicate Art of Telemancy*/, 41989 /*Blood of My Blood*/, 41834 /*The Masks We Wear*/, 40796 /*Lingering on the Edge*/, 41702 /*Written in Stone*/, 40009 /*Arcane Thirst*/, 44009 /*A Falling Star*/);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(43106, 0, 0, 0, 0, '<Oculeth mumbles incoherently under his breath.>', 0), -- Feed Oculeth
(42147, 0, 0, 0, 0, 'Have you made contact with our sympathizers?', 0), -- First Contact
(40747, 0, 0, 0, 0, 'Salvaging the equipment here is necessary if I am to develop a teleporter network for Thalyssra.', 0), -- The Delicate Art of Telemancy
(41989, 0, 0, 0, 0, 'Anarys could halt our efforts before they begin.', 23420), -- Blood of My Blood
(41834, 0, 0, 0, 0, 'Pleased to make your acquaintance.', 0), -- The Masks We Wear
(40796, 0, 0, 0, 0, 'Can you help me? Is there nothing you can do?', 0), -- Lingering on the Edge
(41702, 0, 0, 0, 0, '<This withered seems entranced by the spellstone. He is completely pacified.>', 0), -- Written in Stone
(40009, 0, 0, 0, 0, '<Thalyssra\'s eyes have dulled and her body is shaking uncontrollably.>', 0), -- Arcane Thirst
(44009, 0, 0, 0, 0, 'Show me what you\'ve found.', 0); -- A Falling Star


DELETE FROM `creature_template_addon` WHERE `entry` IN (98548 /*98548 (Chief Telemancer Oculeth) - Oculeth Hunger State*/, 102017 /*102017 (Chief Telemancer Oculeth)*/, 102142 /*102142 (Chief Telemancer Oculeth)*/, 101782 /*101782 (Chief Telemancer Oculeth)*/, 101116 /*101116 (Warpcaster Thwen) - Warp Armor*/, 111921 /*111921 (Buried Exile) - Permanent Feign Death (Arcane Burned v2)*/, 116069 /*116069 (Beam Target Stalker)*/, 116622 /*116622 (Unstable Rift) - Warp Rift Visual, Warp Rift*/, 116623 /*116623 (Warp Spark)*/, 116626 /*116626 (Warp Aberration)*/, 101110 /*101110 (Warp Ray)*/, 101580 /*101580 (Tanzanite Skitterer)*/, 101581 /*101581 (Tanzanite Borer)*/, 101577 /*101577 (Tanzanite Shatterer)*/, 102413 /*102413 (Warp Dagger) - Warp Dagger*/, 116421 /*116421 (Ley Line Channeler) - Arcane Channeling*/, 108528 /*108528 (Vile Lurker)*/, 112370 /*112370 (Ruins Recluse)*/, 113420 /*113420 (Writhing Egg Sac)*/, 101499 /*101499 (Chief Telemancer Oculeth)*/, 112948 /*112948 (Glitterpool Snapper)*/, 114995 /*114995 (Silver Covenant Warmage)*/, 112825 /*112825 (Shieldscar Stag)*/, 112827 /*112827 (Shieldscar Doe)*/, 114866 /*114866 (Silver Covenant Guardian Mage)*/, 115926 /*115926 (Darnassus Sentinel) - Masquerade*/, 115924 /*115924 (Dawnguard Magus) - Masquerade*/, 111318 /*111318 (Noressa)*/, 115517 /*115517 (Magus Sendath)*/, 113629 /*113629 (Exasperated Child)*/, 108068 /*108068 (Accused Suramar Citizen)*/, 115079 /*115079 (Victoire)*/, 115608 /*115608 (Silgryn)*/, 115607 /*115607 (Thoramir)*/, 115078 /*115078 (Arluelle)*/, 109562 /*109562 (Sundries Merchant)*/, 111620 /*111620 (Duskwatch Executor) - Invisibility and Stealth Detection*/, 113630 /*113630 (Exasperated Child)*/, 108622 /*108622 (Withering Suramar Citizen)*/, 111446 /*111446 (Duskwatch Battlemaster)*/, 114549 /*114549 (Withering Suramar Citizen)*/, 105480 /*105480 (Olmoore)*/, 108070 /*108070 (Accused Suramar Citizen)*/, 115606 /*115606 (Spell-Fencer Adept)*/, 108096 /*108096 (Duskwatch Scion)*/, 108623 /*108623 (Withered Suramar Citizen)*/, 106032 /*106032 (Duskwatch Battlemaster)*/, 111622 /*111622 (Arcane Chronomaton) - Detector, Invisibility and Stealth Detection*/, 115691 /*115691 (Felborne Magus)*/, 113675 /*113675 (Wyrmtongue Scribe)*/, 116360 /*116360 (Duskwatch Scryer) - Detector, Invisibility and Stealth Detection*/, 105481 /*105481 (Oll'ison)*/, 108943 /*108943 (Vineyard Attendant) - Serving Platter Female*/, 107296 /*107296 (Suramar Aristocrat)*/, 111749 /*111749 (Felborne Collaborator) - Detector, Invisibility and Stealth Detection*/, 109461 /*109461 (Vineyard Porter)*/, 109463 /*109463 (Magisterial Escort)*/, 109509 /*109509 (Spellsinger Quiris) - Detector, Invisibility and Stealth Detection*/, 105652 /*105652 (Confined Wind Serpent) - Collar of Domination*/, 105646 /*105646 (Captive Basilisk) - Collar of Domination*/, 109056 /*109056 (Luxurious Palanquin)*/, 109058 /*109058 (Palanquin Bearer) - Ride Vehicle Hardcoded*/, 113485 /*113485 (Menagerie Shopkeeper)*/, 113487 /*113487 (Menagerie Shopkeeper)*/, 108875 /*108875 (Vineyard Enforcer)*/, 107600 /*107600 (Shal'dorei Civilian)*/, 107603 /*107603 (Shal'dorei Civilian)*/, 104844 /*104844 ("Old Wise" Ewaye) - Allow Ground Slam Aura*/, 99638 /*99638 (Caged Polar Bear) - Collar of Domination*/, 105654 /*105654 (Captive Penguin) - Collar of Domination*/, 102303 /*102303 (Lieutenant Strathmar) - Mod Scale 115-120%, Lieutenant Strathmar - Level 3*/, 103131 /*103131 (Keelay Moongrow)*/, 103677 /*103677 (Graedis Oenthar) - Menagerie Finale Cosmetic Phase*/, 103634 /*103634 (Su'esh) - Sleeping Sleep, Menagerie Finale Cosmetic Phase*/, 108871 /*108871 (Vineyard Warden) - Detector, Invisibility and Stealth Detection*/, 105656 /*105656 (Bound Makrura) - Collar of Domination*/, 112059 /*112059 (Sasunne Dameuse)*/, 112064 /*112064 (Dolse Shimmersong)*/, 112331 /*112331 (Skittering Riverbug)*/, 103631 /*103631 (Confined Lion) - Collar of Domination*/, 113843 /*113843 (Kieule)*/, 104810 /*104810 (Penned Murloc) - Collar of Domination*/, 105644 /*105644 (Penned 'Monohorn') - Collar of Domination*/, 104837 /*104837 (Caged Tiger) - Collar of Domination*/, 105655 /*105655 (Bound Vulture) - Collar of Domination*/, 105653 /*105653 (Captive Lion Seal) - Collar of Domination*/, 112190 /*112190 (Curious Sabercub)*/, 111770 /*111770 (Menagerie Shopkeeper)*/, 113483 /*113483 (Menagerie Shopkeeper)*/, 105650 /*105650 (Confined Raptor) - Collar of Domination*/, 113772 /*113772 (Rope Bunny)*/, 105640 /*105640 (Bound Goat) - Collar of Domination, Chain Beam*/, 105645 /*105645 (Penned Turtle) - Collar of Domination*/, 104845 /*104845 (Caged Macaw) - Collar of Domination*/, 114897 /*114897 (Darnassus Sentinel)*/, 113936 /*113936 (Rudaux) - DNT - Rudaux's Dance Floor*/, 116063 /*116063 (Animated Spellbook)*/, 115430 /*115430 (Charged Arcshaper Staff) - Nightborne Weaponry - Spellbreaker*/, 114926 /*114926 (Arcane Sentinel) - Detector, Invisibility and Stealth Detection*/, 115526 /*115526 (Arcshaper Thorendis) - Fortified Arcshield*/, 116050 /*116050 (Duskwatch Conjurer)*/, 105232 /*105232 (Oldus)*/, 110870 /*110870 (Apothecary Faldren) - Apothecary Faldren - Level 3*/, 115684 /*115684 (Kirin Tor Peacekeeper) - Frost Armor*/, 114879 /*114879 (Animus Golem)*/, 114849 /*114849 (Ancient Defender)*/, 106495 /*106495 (Vanthir)*/, 104544 /*104544 (Naltethis)*/, 104394 /*104394 (Lady Anastae)*/, 100192 /*100192 (Astoril)*/, 115594 /*115594 (Duskwatch Adjudicator)*/, 103807 /*103807 (Daelar Swiftmeadow)*/, 115595 /*115595 (Duskwatch Executor)*/, 111621 /*111621 (Duskwatch Executor) - Detector, Invisibility and Stealth Detection*/, 111618 /*111618 (Duskwatch Enforcer)*/, 113597 /*113597 (Duskwatch Adjudicator)*/, 101688 /*101688 (Duskwatch Enforcer)*/, 106420 /*106420 (Anarys Lunastre) - Arcane Shackles*/, 112259 /*112259 (Palace Sweeper)*/, 113679 /*113679 (Wrathguard Soulsplitter)*/, 113840 /*113840 (Shal'dorei Harpist)*/, 107450 /*107450 (Inquisitor Eye) - Detector, Invisibility and Stealth Detection*/, 113455 /*113455 (Nightborne Wretch)*/, 107449 /*107449 (Observant Inquisitor)*/, 105342 /*105342 (Ly'leth Lunastre)*/, 115535 /*115535 (Skulking Assassin) - Stealth, Poisoned Blades*/, 112009 /*112009 (Palace Minder)*/, 112017 /*112017 (Enchanted Pen) - Ride Vehicle Hardcoded*/, 112014 /*112014 (Palace Minder) - Ride Vehicle Hardcoded*/, 111612 /*111612 (Duskwatch Moonscythe)*/, 113773 /*113773 (Stonespine Gazer)*/, 113789 /*113789 (Quest - 7.0 Suramar - Artisan's Esplanade - Meat 01 - JSB)*/, 113790 /*113790 (Quest - 7.0 Suramar - Artisan's Esplanade - Meat 02 - JSB)*/, 113767 /*113767 (7.0 Suramar - Will it Felfire Bunny (JSB))*/, 113738 /*113738 (Duskwatch Moonmage) - Detector, Invisibility and Stealth Detection*/, 110415 /*110415 (Auditor Yvenne)*/, 110418 /*110418 (Duskwatch Inquisitor)*/, 113765 /*113765 (Doomguard Felbreather) - Demonic Vision, Invisibility and Stealth Detection*/, 106654 /*106654 (Duskwatch Moonscythe)*/, 113619 /*113619 (Suramar Loyalist)*/, 99755 /*99755 (Arcane Sentinel) - Detector, Invisibility and Stealth Detection*/, 113618 /*113618 (Suramar Loyalist)*/, 112150 /*112150 (Totally Generic Bunny (JSB))*/, 109409 /*109409 (Nightborne Wretch)*/, 114924 /*114924 (Duskwatch Saberguard) - Rally*/, 113633 /*113633 (Doomguard Executioner) - Demonic Vision, Invisibility and Stealth Detection*/, 104369 /*104369 (Mornath)*/, 106617 /*106617 (Nightborne Child)*/, 105589 /*105589 (Jellyfish) - Party Costume Vertex*/, 105401 /*105401 (Warden Owl) - Party Costume Vertex*/, 105388 /*105388 (Manasaber) - Party Costume Vertex*/, 105395 /*105395 (Goldfish) - Party Costume Vertex*/, 105595 /*105595 (Water Bubble) - Party Costume Vertex*/, 113634 /*113634 (Felguard Oppressor) - Dual Wield, Bloodied Blade*/, 105837 /*105837 (Nightborne Lush) - Holding Wine Glass*/, 105397 /*105397 (Cloud Serpent) - Party Costume Vertex*/, 105835 /*105835 (Lunastre Attendant) - Serving Platter Female, Servant Mask*/, 115534 /*115534 (Vanthir's Memory Stalker)*/, 105059 /*105059 (Kal)*/, 105071 /*105071 (Silgryn)*/, 103181 /*103181 (Apprentice Ardrias)*/, 103175 /*103175 (Lespin Silverleaf)*/, 107217 /*107217 (Ploiarchos) - Fel Channeling*/, 105292 /*105292 (Venlis Swiftsea) - Detector, Invisibility and Stealth Detection*/, 115521 /*115521 (Sentinel Moonshade) - Stealth*/, 103005 /*103005 (Bowl of Fruit)*/, 114927 /*114927 (Fist of the Duskwatch)*/, 113707 /*113707 (Duskwatch Astralite) - Detector, Invisibility and Stealth Detection*/, 102495 /*102495 (Or'ell)*/, 114865 /*114865 (Dawnguard Magus)*/, 114880 /*114880 (Dawnguard Bloodknight)*/, 101848 /*101848 (Absolon)*/, 104618 /*104618 (Theryn)*/, 109803 /*109803 (Leyscar Scuttler)*/, 113189 /*113189 (Coastal Snapper)*/, 100058 /*100058 (Arcanist Kel'danath)*/, 113127 /*113127 (Cliffwing Skytalon)*/, 107974 /*107974 (Kill Credit Orathiss Scene 1)*/, 113110 /*113110 (Spellwing Strix)*/, 113122 /*113122 (Suramar Cliffquill) - Sleeping Sleep*/, 101825 /*101825 (Nightborne Enforcer) - Permanent Feign Death (Stun, Untrackable, Uninteractible, Immune)*/, 101821 /*101821 (Nightborne Warpcaster) - Permanent Feign Death (Stun, Untrackable, Uninteractible, Immune)*/, 105625 /*105625 (Fal'dorei Weaver)*/, 105884 /*105884 (Spellwyrm)*/, 105785 /*105785 (Fal'dorei Conjurer)*/, 109188 /*109188 (Withered Test Subject)*/, 113532 /*113532 (Arcward)*/, 105623 /*105623 (Fal'dorei Slicer)*/, 99792 /*99792 (Elfbane)*/, 114793 /*114793 (Fal'dorei Slicer) - Web Beam*/, 105486 /*105486 (Withered Droll)*/, 105885 /*105885 (Hungering Husk)*/, 105753 /*105753 (Fal'dorei Devourer)*/, 105752 /*105752 (Fal'dorei Silkwitch)*/, 110577 /*110577 (Oreth the Vile) - Oreth the Vile - Level 3*/, 110576 /*110576 (Oreth's Victim) - Spawn Feign Death*/, 99779 /*99779 (Stonespine Gazer) - Cosmetic - Sleep Zzz Breakable*/, 99791 /*99791 (Koralune Ettin) - Ettin Custom Walk, Petrified*/, 105686 /*105686 (Fal'dorei Webspinner)*/, 106276 /*106276 (Fal'dorei Web Target Stalker)*/, 105756 /*105756 (Leyline Spiderling) - Spiderling Venom*/, 105685 /*105685 (Fal'dorei Broodlord) - Web Beam*/, 99653 /*99653 (Crystalline Broodling)*/, 105676 /*105676 (Webbed Victim)*/, 109054 /*109054 (Shal'an) - Nether Affinity, Shal'an - Level 3*/, 105632 /*105632 (Broodmother Shu'malis) - Broodmother Shu'malis - Level 3, Magical Mastery*/, 116943 /*116943 (Nighthuntress Syrenne)*/, 111513 /*111513 (Leyweaver Ke'lorin)*/, 110904 /*110904 (Archmage Nielthende)*/, 113126 /*113126 (Meredil Lockjaw) - Arcane Infused, Sleeping Sleep*/, 106869 /*106869 (Snarler Pup)*/, 111712 /*111712 (Withered WQ Turn In Bunny)*/, 97140 /*97140 (First Arcanist Thalyssra) - Thalyssra Hunger State*/, 99539 /*99539 (Eternal Tether) - Eternal Tether Periodic*/, 99524 /*99524 (Keeper Selentia)*/, 99088 /*99088 (Ancient Keeper)*/, 114657 /*114657 (Ley Line Node) - Ley Line Node*/, 99482 /*99482 (First Arcanist Thalyssra)*/, 116011 /*116011 (Barrels o' Fun)*/, 98967 /*98967 (Barrier Bunny) - Mana Siphon Controller*/, 98946 /*98946 (Withered Thirster)*/, 98312 /*98312 (First Arcanist Thalyssra) - Arcane Barrier*/, 98943 /*98943 (Withered)*/, 99213 /*99213 (Erasmus Moonblade) - Time Stop*/, 114071 /*114071 (Pulsing Arcane Echo) - Pulsing Arcane Echo Visual*/, 114070 /*114070 (Blinking Arcane Echo) - Blinking Arcane Echo Visual*/, 100169 /*100169 (Faint Arcane Echo) - Faint Arcane Echo Visual*/, 98209 /*98209 (Echo of First Arcanist Thalyssra)*/, 99267 /*99267 (Nightborne Scion)*/, 110903 /*110903 (Mana Saber)*/, 115381 /*115381 (Nightborne Rebel)*/, 114931 /*114931 (Nightfallen Rebel)*/, 96972 /*96972 (Arcanist Ginsberg)*/, 96971 /*96971 (Alchemist Burroughs)*/, 97024 /*97024 (Baroness Zildjia)*/, 105332 /*105332 (Desmond Gravesorrow) - Permanent Feign Death (NO Stun, Untrackable, Immune)*/, 97457 /*97457 (Mardigan)*/, 96969 /*96969 (Alfred Copperworth)*/, 96970 /*96970 (Revil Kost)*/, 105339 /*105339 (Shadowgore Darkcaster) - Shadowform*/, 96770 /*96770 (Warmage Mumplina) - Invisibility and Stealth Detection, Frost Armor*/, 97023 /*97023 (Kat Sunflower)*/, 96771 /*96771 (Warmage Lukems) - Frost Armor, Invisibility and Stealth Detection*/, 112441 /*112441 (Robert Newhearth)*/, 107968 /*107968 (Archmage Lan'dalock) - Read Scroll*/, 93524 /*93524 (Lalla Brightweave) - Teleport*/, 93542 /*93542 (Tanithria)*/, 105081 /*105081 (Archmage Kalec)*/, 90463 /*90463 (Archmage Karlain)*/, 90417 /*90417 (Archmage Khadgar)*/, 98266 /*98266 (Arcane Anomaly) - Arcane Shield Visual*/, 90431 /*90431 (Archmage Ansirem Runeweaver)*/, 90418 /*90418 (Archmage Modera)*/, 93525 /*93525 (Ainderu Summerleaf)*/, 105723 /*105723 (Vicktor Ebonfall) - Aquatic Lounge*/, 113873 /*113873 (Archivist Elysiana)*/, 93529 /*93529 (Olisarra the Kind)*/, 110738 /*110738 (Kaela Grimlocket)*/, 105564 /*105564 (Injured Kirin Tor Guardian)*/, 113784 /*113784 (Classic Larry)*/, 96772 /*96772 (Warmage Kath'leen)*/, 93528 /*93528 (Angelique Butler)*/, 97501 /*97501 (Linzi Redgrin)*/, 97489 /*97489 (Garl Grimgrizzle)*/, 93543 /*93543 (Sminx Glasseye)*/, 93527 /*93527 (Timothy Jones) - Cosmetic - Right Hand Sparkle*/, 93526 /*93526 (Tiffany Cartier) - [DND] Dalaran - Shop Keeper Greeting, Working*/, 92456 /*92456 (Linzy Blackbolt)*/, 92458 /*92458 (Deucus Valdera)*/, 112130 /*112130 (Archmage Khadgar) - Read Scroll*/, 112227 /*112227 (Atiesh) - Atiesh Visual*/, 97492 /*97492 (Dak'hal the Black)*/, 97514 /*97514 (Danric the Bold)*/, 104091 /*104091 (Kirin Tor Guardian)*/, 97532 /*97532 (Violetta)*/, 111387 /*111387 (Deep Water Clacker)*/, 111409 /*111409 (Isle Lion Seal)*/, 112477 /*112477 (Yorg Murkmouth) - Murkmouth Holds Light's Heart*/, 112424 /*112424 (Murkmouth Poop-Handler)*/, 112423 /*112423 (Murkmouth Garbagemancer) - Lightning Shield*/, 110343 /*110343 (Invisible Stalker) - Lightbound Object Crash Visual*/, 103827 /*103827 (King Morgalash)*/, 103932 /*103932 (Elder Trenchwalker)*/, 103931 /*103931 (Sashj'tar Wave Caller)*/, 103930 /*103930 (Sashj'tar Wave Crusher)*/, 103929 /*103929 (Sashj'tar Wave Breaker)*/, 103933 /*103933 (King Morgalash)*/, 112352 /*112352 (Falling Star Target)*/, 103866 /*103866 (Abandoned Ballista)*/, 103859 /*103859 (Jandvik Banner) - Quest - Default Interact Objective Placement Visual State*/, 112436 /*112436 (Falling Star Trigger)*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(98548, 0, 0, 0, 1, 0, 0, 0, 0, '201446'), -- 98548 (Chief Telemancer Oculeth) - Oculeth Hunger State
(102017, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 102017 (Chief Telemancer Oculeth)
(102142, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 102142 (Chief Telemancer Oculeth)
(101782, 0, 0, 50331648, 1, 0, 2230, 0, 0, ''), -- 101782 (Chief Telemancer Oculeth)
(101116, 0, 0, 50331648, 1, 0, 2230, 0, 0, '201011'), -- 101116 (Warpcaster Thwen) - Warp Armor
(111921, 0, 0, 262144, 1, 0, 0, 0, 0, '231918'), -- 111921 (Buried Exile) - Permanent Feign Death (Arcane Burned v2)
(116069, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 116069 (Beam Target Stalker)
(116622, 0, 0, 0, 1, 0, 0, 0, 0, '211880 211884'), -- 116622 (Unstable Rift) - Warp Rift Visual, Warp Rift
(116623, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 116623 (Warp Spark)
(116626, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 116626 (Warp Aberration)
(101110, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 101110 (Warp Ray)
(101580, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 101580 (Tanzanite Skitterer)
(101581, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 101581 (Tanzanite Borer)
(101577, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 101577 (Tanzanite Shatterer)
(102413, 0, 0, 50331648, 1, 0, 0, 0, 0, '202260'), -- 102413 (Warp Dagger) - Warp Dagger
(116421, 0, 0, 0, 1, 0, 0, 0, 0, '39550'), -- 116421 (Ley Line Channeler) - Arcane Channeling
(108528, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 108528 (Vile Lurker)
(112370, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112370 (Ruins Recluse)
(113420, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113420 (Writhing Egg Sac)
(101499, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 101499 (Chief Telemancer Oculeth)
(112948, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112948 (Glitterpool Snapper)
(114995, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114995 (Silver Covenant Warmage)
(112825, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112825 (Shieldscar Stag)
(112827, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112827 (Shieldscar Doe)
(114866, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114866 (Silver Covenant Guardian Mage)
(115926, 0, 0, 8, 1, 0, 0, 0, 0, '230370'), -- 115926 (Darnassus Sentinel) - Masquerade
(115924, 0, 0, 0, 1, 0, 0, 0, 0, '230370'), -- 115924 (Dawnguard Magus) - Masquerade
(111318, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 111318 (Noressa)
(115517, 0, 0, 8, 1, 0, 0, 0, 0, ''), -- 115517 (Magus Sendath)
(113629, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113629 (Exasperated Child)
(108068, 0, 0, 0, 1, 0, 12008, 0, 0, ''), -- 108068 (Accused Suramar Citizen)
(115079, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115079 (Victoire)
(115608, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115608 (Silgryn)
(115607, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115607 (Thoramir)
(115078, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115078 (Arluelle)
(109562, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 109562 (Sundries Merchant)
(111620, 0, 0, 0, 1, 0, 0, 0, 0, '67236'), -- 111620 (Duskwatch Executor) - Invisibility and Stealth Detection
(113630, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113630 (Exasperated Child)
(108622, 0, 0, 0, 1, 0, 12004, 0, 0, ''), -- 108622 (Withering Suramar Citizen)
(111446, 0, 69468, 0, 1, 0, 0, 0, 0, ''), -- 111446 (Duskwatch Battlemaster)
(114549, 0, 0, 0, 1, 0, 12004, 0, 0, ''), -- 114549 (Withering Suramar Citizen)
(105480, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105480 (Olmoore)
(108070, 0, 0, 0, 1, 0, 12009, 0, 0, ''), -- 108070 (Accused Suramar Citizen)
(115606, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115606 (Spell-Fencer Adept)
(108096, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 108096 (Duskwatch Scion)
(108623, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 108623 (Withered Suramar Citizen)
(106032, 0, 69468, 0, 1, 0, 0, 0, 0, ''), -- 106032 (Duskwatch Battlemaster)
(111622, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 111622 (Arcane Chronomaton) - Detector, Invisibility and Stealth Detection
(115691, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115691 (Felborne Magus)
(113675, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113675 (Wyrmtongue Scribe)
(116360, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 116360 (Duskwatch Scryer) - Detector, Invisibility and Stealth Detection
(105481, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105481 (Oll'ison)
(108943, 0, 0, 0, 1, 0, 10516, 0, 0, '216450'), -- 108943 (Vineyard Attendant) - Serving Platter Female
(107296, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 107296 (Suramar Aristocrat)
(111749, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 111749 (Felborne Collaborator) - Detector, Invisibility and Stealth Detection
(109461, 0, 0, 0, 1, 0, 2312, 0, 0, ''), -- 109461 (Vineyard Porter)
(109463, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 109463 (Magisterial Escort)
(109509, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 109509 (Spellsinger Quiris) - Detector, Invisibility and Stealth Detection
(105652, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 105652 (Confined Wind Serpent) - Collar of Domination
(105646, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 105646 (Captive Basilisk) - Collar of Domination
(109056, 0, 0, 33554432, 1, 0, 0, 0, 0, ''), -- 109056 (Luxurious Palanquin)
(109058, 0, 0, 0, 1, 0, 0, 0, 0, '46598'), -- 109058 (Palanquin Bearer) - Ride Vehicle Hardcoded
(113485, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113485 (Menagerie Shopkeeper)
(113487, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113487 (Menagerie Shopkeeper)
(108875, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 108875 (Vineyard Enforcer)
(107600, 0, 0, 0, 1, 0, 1244, 0, 0, ''), -- 107600 (Shal'dorei Civilian)
(107603, 0, 0, 0, 1, 0, 1244, 0, 0, ''), -- 107603 (Shal'dorei Civilian)
(104844, 0, 0, 0, 1, 0, 0, 0, 0, '226086'), -- 104844 ("Old Wise" Ewaye) - Allow Ground Slam Aura
(99638, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 99638 (Caged Polar Bear) - Collar of Domination
(105654, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 105654 (Captive Penguin) - Collar of Domination
(102303, 0, 0, 0, 1, 0, 0, 0, 0, '123168 223532'), -- 102303 (Lieutenant Strathmar) - Mod Scale 115-120%, Lieutenant Strathmar - Level 3
(103131, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103131 (Keelay Moongrow)
(103677, 0, 0, 0, 1, 0, 0, 0, 0, '221099'), -- 103677 (Graedis Oenthar) - Menagerie Finale Cosmetic Phase
(103634, 0, 0, 0, 1, 0, 730, 0, 0, '221098 221099'), -- 103634 (Su'esh) - Sleeping Sleep, Menagerie Finale Cosmetic Phase
(108871, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 108871 (Vineyard Warden) - Detector, Invisibility and Stealth Detection
(105656, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 105656 (Bound Makrura) - Collar of Domination
(112059, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112059 (Sasunne Dameuse)
(112064, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112064 (Dolse Shimmersong)
(112331, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112331 (Skittering Riverbug)
(103631, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 103631 (Confined Lion) - Collar of Domination
(113843, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113843 (Kieule)
(104810, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 104810 (Penned Murloc) - Collar of Domination
(105644, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 105644 (Penned 'Monohorn') - Collar of Domination
(104837, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 104837 (Caged Tiger) - Collar of Domination
(105655, 0, 0, 50331648, 1, 0, 0, 0, 0, '205061'), -- 105655 (Bound Vulture) - Collar of Domination
(105653, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 105653 (Captive Lion Seal) - Collar of Domination
(112190, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112190 (Curious Sabercub)
(111770, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 111770 (Menagerie Shopkeeper)
(113483, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113483 (Menagerie Shopkeeper)
(105650, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 105650 (Confined Raptor) - Collar of Domination
(113772, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 113772 (Rope Bunny)
(105640, 0, 0, 0, 1, 0, 0, 0, 0, '205061 226422'), -- 105640 (Bound Goat) - Collar of Domination, Chain Beam
(105645, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 105645 (Penned Turtle) - Collar of Domination
(104845, 0, 0, 0, 1, 0, 0, 0, 0, '205061'), -- 104845 (Caged Macaw) - Collar of Domination
(114897, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114897 (Darnassus Sentinel)
(113936, 0, 0, 0, 1, 0, 0, 0, 0, '227309'), -- 113936 (Rudaux) - DNT - Rudaux's Dance Floor
(116063, 0, 0, 33554432, 1, 0, 0, 0, 0, ''), -- 116063 (Animated Spellbook)
(115430, 0, 0, 0, 1, 0, 970, 0, 0, '229543'), -- 115430 (Charged Arcshaper Staff) - Nightborne Weaponry - Spellbreaker
(114926, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 114926 (Arcane Sentinel) - Detector, Invisibility and Stealth Detection
(115526, 0, 0, 33554432, 1, 0, 0, 0, 0, '229750'), -- 115526 (Arcshaper Thorendis) - Fortified Arcshield
(116050, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 116050 (Duskwatch Conjurer)
(105232, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105232 (Oldus)
(110870, 0, 0, 0, 1, 0, 0, 0, 0, '223530'), -- 110870 (Apothecary Faldren) - Apothecary Faldren - Level 3
(115684, 0, 0, 0, 257, 0, 0, 0, 0, '183111'), -- 115684 (Kirin Tor Peacekeeper) - Frost Armor
(114879, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114879 (Animus Golem)
(114849, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114849 (Ancient Defender)
(106495, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 106495 (Vanthir)
(104544, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 104544 (Naltethis)
(104394, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 104394 (Lady Anastae)
(100192, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 100192 (Astoril)
(115594, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115594 (Duskwatch Adjudicator)
(103807, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103807 (Daelar Swiftmeadow)
(115595, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115595 (Duskwatch Executor)
(111621, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 111621 (Duskwatch Executor) - Detector, Invisibility and Stealth Detection
(111618, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 111618 (Duskwatch Enforcer)
(113597, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113597 (Duskwatch Adjudicator)
(101688, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 101688 (Duskwatch Enforcer)
(106420, 0, 0, 0, 0, 0, 0, 0, 0, '210603'), -- 106420 (Anarys Lunastre) - Arcane Shackles
(112259, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112259 (Palace Sweeper)
(113679, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113679 (Wrathguard Soulsplitter)
(113840, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113840 (Shal'dorei Harpist)
(107450, 0, 0, 50331648, 1, 0, 0, 0, 0, '203761 67236'), -- 107450 (Inquisitor Eye) - Detector, Invisibility and Stealth Detection
(113455, 0, 0, 0, 1, 0, 2188, 0, 0, ''), -- 113455 (Nightborne Wretch)
(107449, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 107449 (Observant Inquisitor)
(105342, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105342 (Ly'leth Lunastre)
(115535, 0, 0, 131072, 1, 0, 8062, 0, 0, '118969 212061'), -- 115535 (Skulking Assassin) - Stealth, Poisoned Blades
(112009, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112009 (Palace Minder)
(112017, 0, 0, 50331648, 1, 0, 0, 0, 0, '46598'), -- 112017 (Enchanted Pen) - Ride Vehicle Hardcoded
(112014, 0, 0, 0, 1, 0, 10464, 0, 0, '46598'), -- 112014 (Palace Minder) - Ride Vehicle Hardcoded
(111612, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 111612 (Duskwatch Moonscythe)
(113773, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113773 (Stonespine Gazer)
(113789, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113789 (Quest - 7.0 Suramar - Artisan's Esplanade - Meat 01 - JSB)
(113790, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113790 (Quest - 7.0 Suramar - Artisan's Esplanade - Meat 02 - JSB)
(113767, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113767 (7.0 Suramar - Will it Felfire Bunny (JSB))
(113738, 0, 0, 0, 0, 0, 0, 0, 0, '203761 67236'), -- 113738 (Duskwatch Moonmage) - Detector, Invisibility and Stealth Detection
(110415, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 110415 (Auditor Yvenne)
(110418, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 110418 (Duskwatch Inquisitor)
(113765, 0, 0, 0, 1, 0, 0, 0, 0, '213486 67236'), -- 113765 (Doomguard Felbreather) - Demonic Vision, Invisibility and Stealth Detection
(106654, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 106654 (Duskwatch Moonscythe)
(113619, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113619 (Suramar Loyalist)
(99755, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 99755 (Arcane Sentinel) - Detector, Invisibility and Stealth Detection
(113618, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113618 (Suramar Loyalist)
(112150, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112150 (Totally Generic Bunny (JSB))
(109409, 0, 0, 0, 1, 0, 10816, 0, 0, ''), -- 109409 (Nightborne Wretch)
(114924, 0, 69468, 0, 1, 0, 0, 0, 0, '226071'), -- 114924 (Duskwatch Saberguard) - Rally
(113633, 0, 0, 0, 1, 0, 0, 0, 0, '213486 67236'), -- 113633 (Doomguard Executioner) - Demonic Vision, Invisibility and Stealth Detection
(104369, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 104369 (Mornath)
(106617, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 106617 (Nightborne Child)
(105589, 0, 0, 50331648, 1, 0, 0, 0, 0, '209175'), -- 105589 (Jellyfish) - Party Costume Vertex
(105401, 0, 0, 1, 1, 0, 0, 0, 0, '209175'), -- 105401 (Warden Owl) - Party Costume Vertex
(105388, 0, 0, 1, 1, 0, 0, 0, 0, '209175'), -- 105388 (Manasaber) - Party Costume Vertex
(105395, 0, 0, 50331648, 1, 0, 0, 0, 0, '209175'), -- 105395 (Goldfish) - Party Costume Vertex
(105595, 0, 0, 50331648, 1, 0, 0, 0, 0, '209175'), -- 105595 (Water Bubble) - Party Costume Vertex
(113634, 0, 0, 0, 1, 0, 0, 0, 0, '42459 204227'), -- 113634 (Felguard Oppressor) - Dual Wield, Bloodied Blade
(105837, 0, 0, 0, 1, 0, 0, 0, 0, '209976'), -- 105837 (Nightborne Lush) - Holding Wine Glass
(105397, 0, 0, 50331648, 1, 0, 0, 0, 0, '209175'), -- 105397 (Cloud Serpent) - Party Costume Vertex
(105835, 0, 0, 0, 1, 0, 0, 0, 0, '209901 209898'), -- 105835 (Lunastre Attendant) - Serving Platter Female, Servant Mask
(115534, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 115534 (Vanthir's Memory Stalker)
(105059, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 105059 (Kal)
(105071, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105071 (Silgryn)
(103181, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103181 (Apprentice Ardrias)
(103175, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103175 (Lespin Silverleaf)
(107217, 0, 0, 0, 1, 0, 0, 0, 0, '215282'), -- 107217 (Ploiarchos) - Fel Channeling
(105292, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 105292 (Venlis Swiftsea) - Detector, Invisibility and Stealth Detection
(115521, 0, 0, 0, 1, 0, 0, 0, 0, '86603'), -- 115521 (Sentinel Moonshade) - Stealth
(103005, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103005 (Bowl of Fruit)
(114927, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114927 (Fist of the Duskwatch)
(113707, 0, 0, 0, 1, 0, 0, 0, 0, '203761 67236'), -- 113707 (Duskwatch Astralite) - Detector, Invisibility and Stealth Detection
(102495, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 102495 (Or'ell)
(114865, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114865 (Dawnguard Magus)
(114880, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114880 (Dawnguard Bloodknight)
(101848, 0, 0, 0, 1, 0, 1244, 0, 0, ''), -- 101848 (Absolon)
(104618, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 104618 (Theryn)
(109803, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 109803 (Leyscar Scuttler)
(113189, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113189 (Coastal Snapper)
(100058, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 100058 (Arcanist Kel'danath)
(113127, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 113127 (Cliffwing Skytalon)
(107974, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 107974 (Kill Credit Orathiss Scene 1)
(113110, 0, 0, 1, 1, 0, 0, 0, 0, ''), -- 113110 (Spellwing Strix)
(113122, 0, 0, 0, 1, 0, 0, 0, 0, '152209'), -- 113122 (Suramar Cliffquill) - Sleeping Sleep
(101825, 0, 0, 262144, 1, 0, 0, 0, 0, '145362'), -- 101825 (Nightborne Enforcer) - Permanent Feign Death (Stun, Untrackable, Uninteractible, Immune)
(101821, 0, 0, 262144, 1, 0, 0, 0, 0, '145362'), -- 101821 (Nightborne Warpcaster) - Permanent Feign Death (Stun, Untrackable, Uninteractible, Immune)
(105625, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105625 (Fal'dorei Weaver)
(105884, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105884 (Spellwyrm)
(105785, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105785 (Fal'dorei Conjurer)
(109188, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 109188 (Withered Test Subject)
(113532, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113532 (Arcward)
(105623, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105623 (Fal'dorei Slicer)
(99792, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 99792 (Elfbane)
(114793, 0, 0, 0, 1, 0, 0, 0, 0, '210550'), -- 114793 (Fal'dorei Slicer) - Web Beam
(105486, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105486 (Withered Droll)
(105885, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105885 (Hungering Husk)
(105753, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105753 (Fal'dorei Devourer)
(105752, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105752 (Fal'dorei Silkwitch)
(110577, 0, 0, 0, 1, 0, 0, 0, 0, '223524'), -- 110577 (Oreth the Vile) - Oreth the Vile - Level 3
(110576, 0, 0, 0, 1, 0, 0, 0, 0, '35356'), -- 110576 (Oreth's Victim) - Spawn Feign Death
(99779, 0, 0, 0, 1, 0, 0, 0, 0, '133131'), -- 99779 (Stonespine Gazer) - Cosmetic - Sleep Zzz Breakable
(99791, 0, 0, 0, 1, 0, 0, 0, 0, '205174 204844'), -- 99791 (Koralune Ettin) - Ettin Custom Walk, Petrified
(105686, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105686 (Fal'dorei Webspinner)
(106276, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 106276 (Fal'dorei Web Target Stalker)
(105756, 0, 0, 0, 1, 0, 0, 0, 0, '213741'), -- 105756 (Leyline Spiderling) - Spiderling Venom
(105685, 0, 0, 50331648, 1, 0, 0, 0, 0, '210550'), -- 105685 (Fal'dorei Broodlord) - Web Beam
(99653, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 99653 (Crystalline Broodling)
(105676, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105676 (Webbed Victim)
(109054, 0, 0, 0, 1, 0, 0, 0, 0, '223372 223534'), -- 109054 (Shal'an) - Nether Affinity, Shal'an - Level 3
(105632, 0, 0, 0, 1, 0, 0, 0, 0, '221017 221564'), -- 105632 (Broodmother Shu'malis) - Broodmother Shu'malis - Level 3, Magical Mastery
(116943, 0, 62148, 0, 1, 0, 0, 0, 0, ''), -- 116943 (Nighthuntress Syrenne)
(111513, 0, 0, 0, 1, 0, 2188, 0, 0, ''), -- 111513 (Leyweaver Ke'lorin)
(110904, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 110904 (Archmage Nielthende)
(113126, 0, 0, 0, 1, 0, 0, 0, 0, '225291 152209'), -- 113126 (Meredil Lockjaw) - Arcane Infused, Sleeping Sleep
(106869, 0, 0, 3, 1, 0, 0, 0, 0, ''), -- 106869 (Snarler Pup)
(111712, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 111712 (Withered WQ Turn In Bunny)
(97140, 0, 0, 0, 1, 0, 0, 0, 0, '191825'), -- 97140 (First Arcanist Thalyssra) - Thalyssra Hunger State
(99539, 0, 0, 0, 1, 0, 0, 0, 0, '216370'), -- 99539 (Eternal Tether) - Eternal Tether Periodic
(99524, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 99524 (Keeper Selentia)
(99088, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 99088 (Ancient Keeper)
(114657, 0, 0, 50331648, 1, 0, 0, 0, 0, '218817'), -- 114657 (Ley Line Node) - Ley Line Node
(99482, 0, 0, 8, 1, 0, 0, 0, 0, ''), -- 99482 (First Arcanist Thalyssra)
(116011, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 116011 (Barrels o' Fun)
(98967, 0, 0, 0, 1, 0, 0, 0, 0, '194869'), -- 98967 (Barrier Bunny) - Mana Siphon Controller
(98946, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 98946 (Withered Thirster)
(98312, 0, 0, 0, 1, 0, 0, 0, 0, '194124'), -- 98312 (First Arcanist Thalyssra) - Arcane Barrier
(98943, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 98943 (Withered)
(99213, 0, 0, 0, 1, 0, 0, 0, 0, '195289'), -- 99213 (Erasmus Moonblade) - Time Stop
(114071, 0, 0, 0, 1, 0, 0, 0, 0, '227111'), -- 114071 (Pulsing Arcane Echo) - Pulsing Arcane Echo Visual
(114070, 0, 0, 0, 1, 0, 0, 0, 0, '227110'), -- 114070 (Blinking Arcane Echo) - Blinking Arcane Echo Visual
(100169, 0, 0, 0, 1, 0, 0, 0, 0, '227109'), -- 100169 (Faint Arcane Echo) - Faint Arcane Echo Visual
(98209, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 98209 (Echo of First Arcanist Thalyssra)
(99267, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 99267 (Nightborne Scion)
(110903, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 110903 (Mana Saber)
(115381, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 115381 (Nightborne Rebel)
(114931, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 114931 (Nightfallen Rebel)
(96972, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 96972 (Arcanist Ginsberg)
(96971, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 96971 (Alchemist Burroughs)
(97024, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 97024 (Baroness Zildjia)
(105332, 0, 0, 262144, 1, 0, 0, 0, 0, '159474'), -- 105332 (Desmond Gravesorrow) - Permanent Feign Death (NO Stun, Untrackable, Immune)
(97457, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 97457 (Mardigan)
(96969, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 96969 (Alfred Copperworth)
(96970, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 96970 (Revil Kost)
(105339, 0, 0, 0, 1, 0, 8062, 0, 0, '207424'), -- 105339 (Shadowgore Darkcaster) - Shadowform
(96770, 0, 0, 0, 1, 0, 0, 0, 0, '18950 12544'), -- 96770 (Warmage Mumplina) - Invisibility and Stealth Detection, Frost Armor
(97023, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 97023 (Kat Sunflower)
(96771, 0, 0, 0, 1, 0, 0, 0, 0, '12544 18950'), -- 96771 (Warmage Lukems) - Frost Armor, Invisibility and Stealth Detection
(112441, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112441 (Robert Newhearth)
(107968, 0, 0, 0, 0, 0, 0, 0, 0, '212171'), -- 107968 (Archmage Lan'dalock) - Read Scroll
(93524, 0, 0, 0, 257, 0, 0, 0, 0, '190913'), -- 93524 (Lalla Brightweave) - Teleport
(93542, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 93542 (Tanithria)
(105081, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 105081 (Archmage Kalec)
(90463, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 90463 (Archmage Karlain)
(90417, 0, 0, 0, 0, 0, 0, 0, 0, ''); -- 90417 (Archmage Khadgar)

INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(98266, 0, 0, 0, 1, 0, 0, 0, 0, '193606'), -- 98266 (Arcane Anomaly) - Arcane Shield Visual
(90431, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 90431 (Archmage Ansirem Runeweaver)
(90418, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 90418 (Archmage Modera)
(93525, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 93525 (Ainderu Summerleaf)
(105723, 0, 0, 0, 1, 0, 0, 0, 0, '209479'), -- 105723 (Vicktor Ebonfall) - Aquatic Lounge
(113873, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 113873 (Archivist Elysiana)
(93529, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 93529 (Olisarra the Kind)
(110738, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 110738 (Kaela Grimlocket)
(105564, 0, 0, 0, 1, 0, 10389, 0, 0, ''), -- 105564 (Injured Kirin Tor Guardian)
(113784, 0, 0, 1, 1, 0, 0, 0, 0, ''), -- 113784 (Classic Larry)
(96772, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 96772 (Warmage Kath'leen)
(93528, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 93528 (Angelique Butler)
(97501, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 97501 (Linzi Redgrin)
(97489, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 97489 (Garl Grimgrizzle)
(93543, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 93543 (Sminx Glasseye)
(93527, 0, 0, 0, 257, 0, 0, 0, 0, '50200'), -- 93527 (Timothy Jones) - Cosmetic - Right Hand Sparkle
(93526, 0, 0, 0, 257, 0, 0, 0, 0, '60913 186310'), -- 93526 (Tiffany Cartier) - [DND] Dalaran - Shop Keeper Greeting, Working
(92456, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 92456 (Linzy Blackbolt)
(92458, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 92458 (Deucus Valdera)
(112130, 0, 0, 0, 1, 0, 0, 0, 0, '212171'), -- 112130 (Archmage Khadgar) - Read Scroll
(112227, 0, 0, 33554432, 1, 0, 0, 0, 0, '223476'), -- 112227 (Atiesh) - Atiesh Visual
(97492, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 97492 (Dak'hal the Black)
(97514, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 97514 (Danric the Bold)
(104091, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- 104091 (Kirin Tor Guardian)
(97532, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 97532 (Violetta)
(111387, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 111387 (Deep Water Clacker)
(111409, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 111409 (Isle Lion Seal)
(112477, 0, 0, 0, 1, 0, 0, 0, 0, '223942'), -- 112477 (Yorg Murkmouth) - Murkmouth Holds Light's Heart
(112424, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112424 (Murkmouth Poop-Handler)
(112423, 0, 0, 0, 1, 0, 0, 0, 0, '12550'), -- 112423 (Murkmouth Garbagemancer) - Lightning Shield
(110343, 0, 0, 0, 1, 0, 0, 0, 0, '223638'), -- 110343 (Invisible Stalker) - Lightbound Object Crash Visual
(103827, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103827 (King Morgalash)
(103932, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103932 (Elder Trenchwalker)
(103931, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103931 (Sashj'tar Wave Caller)
(103930, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103930 (Sashj'tar Wave Crusher)
(103929, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103929 (Sashj'tar Wave Breaker)
(103933, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103933 (King Morgalash)
(112352, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 112352 (Falling Star Target)
(103866, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103866 (Abandoned Ballista)
(103859, 0, 0, 0, 1, 0, 0, 0, 0, '144373'), -- 103859 (Jandvik Banner) - Quest - Default Interact Objective Placement Visual State
(112436, 0, 0, 0, 1, 0, 0, 0, 0, ''); -- 112436 (Falling Star Trigger)

UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=106609; -- 106609 (Adolescent Stormwing)
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=106648; -- 106648 (Stormwing Drake)
UPDATE `creature_template_addon` SET `auras`='155893' WHERE `entry`=115272; -- 115272 (Felsworn Overseer)
UPDATE `creature_template_addon` SET `aiAnimKit`=2560 WHERE `entry`=100742; -- 100742 (Legion Scouting Beacon)
UPDATE `creature_template_addon` SET `auras`='210868' WHERE `entry`=114929; -- 114929 (Duskwatch Defender)
UPDATE `creature_template_addon` SET `bytes1`=0, `auras`='' WHERE `entry`=113818; -- 113818 (Glitterpool Chick)
UPDATE `creature_template_addon` SET `auras`='217434' WHERE `entry`=107567; -- 107567 (Suramar Shieldguard)
UPDATE `creature_template_addon` SET `auras`='87228' WHERE `entry`=113190; -- 113190 (Meredil Thrashmaw)
UPDATE `creature_template_addon` SET `bytes1`=0, `aiAnimKit`=11737 WHERE `entry`=112336; -- 112336 (Meredil Glider)
UPDATE `creature_template_addon` SET `auras`='152209' WHERE `entry`=99749; -- 99749 (Moonlight Hunter)
UPDATE `creature_template_addon` SET `bytes1`=262144, `auras`='145362' WHERE `entry`=98555; -- 98555 (Withered Shambler)
UPDATE `creature_template_addon` SET `auras`='187063' WHERE `entry`=41200; -- 41200 (Generic Bunny - PRK)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=106655; -- 106655 (Arcanomancer Vridiel)
UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=110621; -- 110621 (Erika Page)
UPDATE `creature_template_addon` SET `aiAnimKit`=11654 WHERE `entry`=112456; -- 112456 (Rachele)
UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=113901; -- 113901 (Crixa)
UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=113900; -- 113900 (Liyana)
UPDATE `creature_template_addon` SET `aiAnimKit`=11654 WHERE `entry`=112437; -- 112437 (Roscoe)
UPDATE `creature_template_addon` SET `aiAnimKit`=4175 WHERE `entry`=105904; -- 105904 (Raven)
UPDATE `creature_template_addon` SET `bytes1`=3 WHERE `entry`=34330; -- 34330 (Jones)
UPDATE `creature_template_addon` SET `auras`='60913' WHERE `entry`=96778; -- 96778 (Aemara)
UPDATE `creature_template_addon` SET `auras`='60913' WHERE `entry`=96479; -- 96479 (Breanni)

DELETE FROM `creature_equip_template` WHERE (`ID`=1 AND `CreatureID` IN (101116,102413,116421,114995,114866,115926,115079,115608,115607,115078,111620,111446,115606,108096,106032,115691,116360,111749,109463,109509,108875,102303,103677,108871,114897,114926,115526,116050,114931,110870,115684,115381,115594,115595,111621,111618,113597,101688,106420,113679,115535,111612,113738,106654,99755,114924,113633,113634,105071,105292,115521,114927,113707,114880,101825,99792,99791,116943,97140,99482,98312,99213,99267,96971,96970,97532,112477,112424,112423,103929));
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`) VALUES
(101116, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Warpcaster Thwen
(102413, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Warp Dagger
(116421, 1, 133175, 0, 0, 0, 0, 0, 0, 0, 0), -- Ley Line Channeler
(114995, 1, 43619, 0, 0, 0, 0, 0, 0, 0, 0), -- Silver Covenant Warmage
(114866, 1, 43619, 0, 0, 0, 0, 0, 0, 0, 0), -- Silver Covenant Guardian Mage
(115926, 1, 91793, 0, 0, 0, 0, 0, 13147, 0, 0), -- Darnassus Sentinel
(115079, 1, 137254, 0, 0, 0, 0, 0, 0, 0, 0), -- Victoire
(115608, 1, 132170, 0, 0, 132170, 0, 0, 0, 0, 0), -- Silgryn
(115607, 1, 137256, 0, 0, 0, 0, 0, 0, 0, 0), -- Thoramir
(115078, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Arluelle
(111620, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Executor
(111446, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Battlemaster
(115606, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Spell-Fencer Adept
(108096, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Scion
(106032, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Battlemaster
(115691, 1, 140089, 0, 0, 0, 0, 0, 0, 0, 0), -- Felborne Magus
(116360, 1, 133174, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Scryer
(111749, 1, 140089, 0, 0, 0, 0, 0, 0, 0, 0), -- Felborne Collaborator
(109463, 1, 137254, 0, 0, 0, 0, 0, 0, 0, 0), -- Magisterial Escort
(109509, 1, 137256, 0, 0, 0, 0, 0, 0, 0, 0), -- Spellsinger Quiris
(108875, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Vineyard Enforcer
(102303, 1, 133176, 0, 0, 132249, 0, 0, 0, 0, 0), -- Lieutenant Strathmar
(103677, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Graedis Oenthar
(108871, 1, 133177, 0, 0, 0, 0, 0, 0, 0, 0), -- Vineyard Warden
(114897, 1, 91793, 0, 0, 0, 0, 0, 13147, 0, 0), -- Darnassus Sentinel
(114926, 1, 40497, 0, 0, 0, 0, 0, 0, 0, 0), -- Arcane Sentinel
(115526, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Arcshaper Thorendis
(116050, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Conjurer
(114931, 1, 34284, 0, 0, 27496, 0, 0, 0, 0, 0), -- Nightfallen Rebel
(110870, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Apothecary Faldren
(115684, 1, 43617, 0, 0, 0, 0, 0, 0, 0, 0), -- Kirin Tor Peacekeeper
(115381, 1, 6976, 0, 0, 0, 0, 0, 0, 0, 0), -- Nightborne Rebel
(115594, 1, 137256, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Adjudicator
(115595, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Executor
(111621, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Executor
(111618, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Enforcer
(113597, 1, 137256, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Adjudicator
(101688, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Enforcer
(106420, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Anarys Lunastre
(113679, 1, 79734, 0, 0, 0, 0, 0, 0, 0, 0), -- Wrathguard Soulsplitter
(115535, 1, 132170, 0, 0, 132170, 0, 0, 0, 0, 0), -- Skulking Assassin
(111612, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Moonscythe
(113738, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Moonmage
(106654, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Moonscythe
(99755, 1, 40497, 0, 0, 0, 0, 0, 0, 0, 0), -- Arcane Sentinel
(114924, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Saberguard
(113633, 1, 125955, 0, 0, 0, 0, 0, 0, 0, 0), -- Doomguard Executioner
(113634, 1, 82810, 0, 0, 0, 0, 0, 0, 0, 0), -- Felguard Oppressor
(105071, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Silgryn
(105292, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Venlis Swiftsea
(115521, 1, 91793, 0, 0, 0, 0, 0, 13147, 0, 0), -- Sentinel Moonshade
(114927, 1, 132170, 0, 0, 132249, 0, 0, 0, 0, 0), -- Fist of the Duskwatch
(113707, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Duskwatch Astralite
(114880, 1, 27405, 0, 0, 27406, 0, 0, 0, 0, 0), -- Dawnguard Bloodknight
(101825, 1, 133177, 0, 0, 0, 0, 0, 0, 0, 0), -- Nightborne Enforcer
(99792, 1, 62907, 0, 0, 0, 0, 0, 0, 0, 0), -- Elfbane
(99791, 1, 62907, 0, 0, 0, 0, 0, 0, 0, 0), -- Koralune Ettin
(116943, 1, 137254, 0, 0, 0, 0, 0, 0, 0, 0), -- Nighthuntress Syrenne
(97140, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- First Arcanist Thalyssra
(99482, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- First Arcanist Thalyssra
(98312, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- First Arcanist Thalyssra
(99213, 1, 132170, 0, 0, 0, 0, 0, 0, 0, 0), -- Erasmus Moonblade
(99267, 1, 132171, 0, 0, 0, 0, 0, 0, 0, 0), -- Nightborne Scion
(96971, 1, 2198, 0, 0, 0, 0, 0, 0, 0, 0), -- Alchemist Burroughs
(96970, 1, 7721, 0, 0, 0, 0, 0, 0, 0, 0), -- Revil Kost
(97532, 1, 124381, 0, 0, 0, 0, 0, 0, 0, 0), -- Violetta
(112477, 1, 33213, 0, 0, 0, 0, 0, 0, 0, 0), -- Yorg Murkmouth
(112424, 1, 83071, 0, 0, 0, 0, 0, 0, 0, 0), -- Murkmouth Poop-Handler
(112423, 1, 83071, 0, 0, 0, 0, 0, 0, 0, 0), -- Murkmouth Garbagemancer
(103929, 1, 54541, 0, 0, 0, 0, 0, 0, 0, 0); -- Sashj'tar Wave Breaker

UPDATE `creature_template` SET `gossip_menu_id`=19960, `minlevel`=110, `maxlevel`=110, `faction`=2799, `npcflag`=4227, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=34816 WHERE `entry`=98548; -- Chief Telemancer Oculeth
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `npcflag`=16777216, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=102017; -- Chief Telemancer Oculeth
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=102142; -- Chief Telemancer Oculeth
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101782; -- Chief Telemancer Oculeth
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048, `unit_flags3`=1 WHERE `entry`=101116; -- Warpcaster Thwen
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1692, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=570720256, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=111921; -- Buried Exile
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587456, `unit_flags2`=2048 WHERE `entry`=116069; -- Beam Target Stalker
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=67143680 WHERE `entry`=116622; -- Unstable Rift
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=116623; -- Warp Spark
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=116626; -- Warp Aberration
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101110; -- Warp Ray
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101580; -- Tanzanite Skitterer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101581; -- Tanzanite Borer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=1.111111402511596679, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101577; -- Tanzanite Shatterer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=2, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=102413; -- Warp Dagger
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2820, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=116421; -- Ley Line Channeler
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=108528; -- Vile Lurker
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=1.190475702285766601, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=112370; -- Ruins Recluse
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=1, `BaseAttackTime`=6000, `RangeAttackTime`=2000 WHERE `entry`=113420; -- Writhing Egg Sac
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101499; -- Chief Telemancer Oculeth
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=112948; -- Glitterpool Snapper
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2362, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33040, `unit_flags2`=33556480 WHERE `entry`=114995; -- Silver Covenant Warmage
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=112825; -- Shieldscar Stag
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2576, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=112827; -- Shieldscar Doe
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2362, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=33556480, `unit_flags3`=1 WHERE `entry`=114866; -- Silver Covenant Guardian Mage
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2713, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024 WHERE `entry`=115926; -- Darnassus Sentinel
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2361, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33024, `unit_flags2`=33556480 WHERE `entry`=115924; -- Dawnguard Magus
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=111318; -- Noressa
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2361, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33024, `unit_flags2`=33572864 WHERE `entry`=115517; -- Magus Sendath
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2820, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=113629; -- Exasperated Child
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=34816 WHERE `entry`=108068; -- Accused Suramar Citizen
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2885, `npcflag`=2, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=115079; -- Victoire
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `npcflag`=2, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=115608; -- Silgryn
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2823, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=115607; -- Thoramir
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2885, `npcflag`=2, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=115078; -- Arluelle
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=128, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=109562; -- Sundries Merchant
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=111620; -- Duskwatch Executor
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=113630; -- Exasperated Child
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=34816 WHERE `entry`=108622; -- Withering Suramar Citizen
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=111446; -- Duskwatch Battlemaster
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=34816 WHERE `entry`=114549; -- Withering Suramar Citizen
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=105480; -- Olmoore
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=51200 WHERE `entry`=108070; -- Accused Suramar Citizen
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2823, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=115606; -- Spell-Fencer Adept
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2823, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=108096; -- Duskwatch Scion
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2822, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=34816, `unit_flags3`=1 WHERE `entry`=108623; -- Withered Suramar Citizen
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=106032; -- Duskwatch Battlemaster
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=111622; -- Arcane Chronomaton
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=115691; -- Felborne Magus
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2851, `speed_walk`=0.66666799783706665, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113675; -- Wyrmtongue Scribe
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=116360; -- Duskwatch Scryer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=105481; -- Oll'ison
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=108943; -- Vineyard Attendant
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=107296; -- Suramar Aristocrat
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=111749; -- Felborne Collaborator
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=109461; -- Vineyard Porter
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=109463; -- Magisterial Escort
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=109509; -- Spellsinger Quiris
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105652; -- Confined Wind Serpent
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_walk`=1.111111998558044433, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105646; -- Captive Basilisk
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=67110912, `VehicleId`=4846, `HoverHeight`=2.15000009536743164 WHERE `entry`=109056; -- Luxurious Palanquin
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=109058; -- Palanquin Bearer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=640, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=113485; -- Menagerie Shopkeeper
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=640, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=113487; -- Menagerie Shopkeeper
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2823, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=108875; -- Vineyard Enforcer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=107600; -- Shal'dorei Civilian
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=107603; -- Shal'dorei Civilian
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `speed_run`=1.111111402511596679, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32784, `unit_flags2`=2048 WHERE `entry`=104844; -- "Old Wise" Ewaye
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=99638; -- Caged Polar Bear
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105654; -- Captive Penguin
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=102303; -- Lieutenant Strathmar
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=643, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=103131; -- Keelay Moongrow
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=103677; -- Graedis Oenthar
UPDATE `creature_template` SET `minlevel`=112, `maxlevel`=112, `faction`=190, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=103634; -- Su'esh
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=108871; -- Vineyard Warden
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105656; -- Bound Makrura
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=128, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=112059; -- Sasunne Dameuse
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=128, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=112064; -- Dolse Shimmersong
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=112331; -- Skittering Riverbug
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1.285714268684387207, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=103631; -- Confined Lion
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=128, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=113843; -- Kieule
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=104810; -- Penned Murloc
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1.289682745933532714, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105644; -- Penned 'Monohorn'
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=104837; -- Caged Tiger
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105655; -- Bound Vulture
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105653; -- Captive Lion Seal
UPDATE `creature_template` SET `faction`=188, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048 WHERE `entry`=112190; -- Curious Sabercub
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=640, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=111770; -- Menagerie Shopkeeper
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=640, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=113483; -- Menagerie Shopkeeper
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105650; -- Confined Raptor
UPDATE `creature_template` SET `faction`=190, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=2048 WHERE `entry`=113772; -- Rope Bunny
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1.385714292526245117, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105640; -- Bound Goat
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `speed_run`=1.285714268684387207, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=105645; -- Penned Turtle
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2052 WHERE `entry`=104845; -- Caged Macaw
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2713, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33040 WHERE `entry`=114897; -- Darnassus Sentinel
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=113936; -- Rudaux
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_walk`=1.60000002384185791, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048, `HoverHeight`=2 WHERE `entry`=116063; -- Animated Spellbook
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=67110912, `dynamicflags`=128 WHERE `entry`=115430; -- Charged Arcshaper Staff
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=114926; -- Arcane Sentinel
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480, `HoverHeight`=3 WHERE `entry`=115526; -- Arcshaper Thorendis
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=116050; -- Duskwatch Conjurer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=105232; -- Oldus
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=110870; -- Apothecary Faldren
UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0, `faction`=2008, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2048 WHERE `entry`=115684; -- Kirin Tor Peacekeeper
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1933, `speed_walk`=0.577776014804840087, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=320, `unit_flags2`=2048, `unit_flags3`=1 WHERE `entry`=114879; -- Animus Golem
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2713, `speed_walk`=1.111111998558044433, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33024, `unit_flags2`=2131968 WHERE `entry`=114849; -- Ancient Defender
UPDATE `creature_template` SET `gossip_menu_id`=19585, `minlevel`=110, `maxlevel`=110, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=106495; -- Vanthir
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=104544; -- Naltethis
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=104394; -- Lady Anastae
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=100192; -- Astoril
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=115594; -- Duskwatch Adjudicator
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=103807; -- Daelar Swiftmeadow
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=115595; -- Duskwatch Executor
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=111621; -- Duskwatch Executor
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2823, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=111618; -- Duskwatch Enforcer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113597; -- Duskwatch Adjudicator
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2823, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101688; -- Duskwatch Enforcer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=106420; -- Anarys Lunastre
UPDATE `creature_template` SET `faction`=188, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587968, `unit_flags2`=67110912 WHERE `entry`=112259; -- Palace Sweeper
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2851, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113679; -- Wrathguard Soulsplitter
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=113840; -- Shal'dorei Harpist
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2851, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=107450; -- Inquisitor Eye
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=34816 WHERE `entry`=113455; -- Nightborne Wretch
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2851, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=107449; -- Observant Inquisitor
UPDATE `creature_template` SET `gossip_menu_id`=19567, `minlevel`=110, `maxlevel`=110, `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105342; -- Ly'leth Lunastre
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_walk`=0.5, `speed_run`=0.496031433343887329, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=115535; -- Skulking Assassin
UPDATE `creature_template` SET `minlevel`=85, `maxlevel`=85, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554688, `unit_flags2`=2048, `VehicleId`=4919 WHERE `entry`=112009; -- Palace Minder
UPDATE `creature_template` SET `faction`=188, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587200, `unit_flags2`=2048 WHERE `entry`=112017; -- Enchanted Pen
UPDATE `creature_template` SET `faction`=188, `speed_walk`=1.60000002384185791, `speed_run`=1.428571462631225585, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048, `HoverHeight`=2 WHERE `entry`=112014; -- Palace Minder
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2823, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=111612; -- Duskwatch Moonscythe
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `speed_run`=0.857142865657806396, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=113773; -- Stonespine Gazer
UPDATE `creature_template` SET `minlevel`=85, `maxlevel`=85, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554688, `unit_flags2`=2048 WHERE `entry`=113789; -- Quest - 7.0 Suramar - Artisan's Esplanade - Meat 01 - JSB
UPDATE `creature_template` SET `minlevel`=85, `maxlevel`=85, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554688, `unit_flags2`=2048 WHERE `entry`=113790; -- Quest - 7.0 Suramar - Artisan's Esplanade - Meat 02 - JSB
UPDATE `creature_template` SET `minlevel`=85, `maxlevel`=85, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554688, `unit_flags2`=2048 WHERE `entry`=113767; -- 7.0 Suramar - Will it Felfire Bunny (JSB)
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=113738; -- Duskwatch Moonmage
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=110415; -- Auditor Yvenne
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=110418; -- Duskwatch Inquisitor
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2851, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113765; -- Doomguard Felbreather
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2823, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=106654; -- Duskwatch Moonscythe
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2820, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113619; -- Suramar Loyalist
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=99755; -- Arcane Sentinel
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113618; -- Suramar Loyalist
UPDATE `creature_template` SET `minlevel`=85, `maxlevel`=85, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554688, `unit_flags2`=2048 WHERE `entry`=112150; -- Totally Generic Bunny (JSB)
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=109409; -- Nightborne Wretch
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2821, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32784, `unit_flags2`=33556480 WHERE `entry`=114924; -- Duskwatch Saberguard
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2851, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113633; -- Doomguard Executioner
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=104369; -- Mornath
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=106617; -- Nightborne Child
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `speed_walk`=2.799999952316284179, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587968, `unit_flags2`=2048 WHERE `entry`=105589; -- Jellyfish
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `speed_run`=0.857142865657806396, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587968, `unit_flags2`=2048, `HoverHeight`=2 WHERE `entry`=105401; -- Warden Owl
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33587968, `unit_flags2`=2048 WHERE `entry`=105388; -- Manasaber
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2000, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587968, `unit_flags2`=2048 WHERE `entry`=105395; -- Goldfish
UPDATE `creature_template` SET `maxlevel`=2, `speed_run`=1.385714292526245117, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=2048 WHERE `entry`=105595; -- Water Bubble
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2851, `speed_run`=1, `BaseAttackTime`=2500, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113634; -- Felguard Oppressor
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2855, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=105837; -- Nightborne Lush
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_walk`=1.444443941116333007, `speed_run`=1.587300062179565429, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587968, `unit_flags2`=2048, `HoverHeight`=7.5 WHERE `entry`=105397; -- Cloud Serpent
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105835; -- Lunastre Attendant
UPDATE `creature_template` SET `gossip_menu_id`=19501 WHERE `entry`=105351; -- Masqued Reveler
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33587968, `unit_flags2`=2048 WHERE `entry`=115534; -- Vanthir's Memory Stalker
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `speed_run`=0.857142865657806396, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105059; -- Kal
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105071; -- Silgryn
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=256, `unit_flags2`=2048 WHERE `entry`=103181; -- Apprentice Ardrias
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2847, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=256, `unit_flags2`=2048 WHERE `entry`=103175; -- Lespin Silverleaf
UPDATE `creature_template` SET `gossip_menu_id`=19431 WHERE `entry`=104998; -- Silgryn
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2851, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=107217; -- Ploiarchos
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105292; -- Venlis Swiftsea
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2713, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=33572864 WHERE `entry`=115521; -- Sentinel Moonshade
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=67143680 WHERE `entry`=103005; -- Bowl of Fruit
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2886, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=114927; -- Fist of the Duskwatch
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2886, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=113707; -- Duskwatch Astralite
UPDATE `creature_template` SET `unit_flags`=32768, `unit_flags2`=2048, `dynamicflags`=0 WHERE `entry`=113818; -- Glitterpool Chick
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=88989; -- Violet Firefly
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2824, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=102495; -- Or'ell
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2361, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33024, `unit_flags2`=33556480 WHERE `entry`=114865; -- Dawnguard Magus
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2714, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=114880; -- Dawnguard Bloodknight
UPDATE `creature_template` SET `unit_flags`=32784 WHERE `entry`=107567; -- Suramar Shieldguard
UPDATE `creature_template` SET `minlevel`=113, `maxlevel`=113, `faction`=2802, `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=34816 WHERE `entry`=101848; -- Absolon
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=1 WHERE `entry`=104618; -- Theryn
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=109803; -- Leyscar Scuttler
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `speed_run`=1.285714268684387207, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113189; -- Coastal Snapper
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1692, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=100058; -- Arcanist Kel'danath
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2030, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=113127; -- Cliffwing Skytalon
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=67143680, `unit_flags3`=1 WHERE `entry`=107974; -- Kill Credit Orathiss Scene 1
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `speed_walk`=2.40000009536743164, `speed_run`=1.571428537368774414, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113110; -- Spellwing Strix
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=31, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113122; -- Suramar Cliffquill
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1693, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=570721024, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=101825; -- Nightborne Enforcer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1693, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=570721024, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=101821; -- Nightborne Warpcaster
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `speed_walk`=0.888888001441955566, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105625; -- Fal'dorei Weaver
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105884; -- Spellwyrm
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `speed_walk`=0.888888001441955566, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105785; -- Fal'dorei Conjurer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1965, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=109188; -- Withered Test Subject
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=34816 WHERE `entry`=113532; -- Arcward
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105623; -- Fal'dorei Slicer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2099200, `VehicleId`=4982 WHERE `entry`=99792; -- Elfbane
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=114793; -- Fal'dorei Slicer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2822, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105486; -- Withered Droll
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2822, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105885; -- Hungering Husk
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105753; -- Fal'dorei Devourer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `speed_walk`=0.888888001441955566, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105752; -- Fal'dorei Silkwitch
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2822, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=110577; -- Oreth the Vile
UPDATE `creature_template` SET `faction`=2000, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=570425600, `unit_flags2`=34817, `dynamicflags`=32 WHERE `entry`=110576; -- Oreth's Victim
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=99779; -- Stonespine Gazer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1814, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587968, `unit_flags2`=2099200, `VehicleId`=4629 WHERE `entry`=99791; -- Koralune Ettin
UPDATE `creature_template` SET `unit_flags`=67141632 WHERE `entry`=106837; -- Sablehorn Stag
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `speed_walk`=0.888888001441955566, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105686; -- Fal'dorei Webspinner
UPDATE `creature_template` SET `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554688, `unit_flags2`=2048, `unit_flags3`=1 WHERE `entry`=106276; -- Fal'dorei Web Target Stalker
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105756; -- Leyline Spiderling
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2848, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105685; -- Fal'dorei Broodlord
UPDATE `creature_template` SET `faction`=190, `speed_run`=0.857142865657806396, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33280, `unit_flags2`=2048 WHERE `entry`=99653; -- Crystalline Broodling
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=1, `BaseAttackTime`=6000, `RangeAttackTime`=2000 WHERE `entry`=105676; -- Webbed Victim
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1965, `speed_run`=1, `BaseAttackTime`=1000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=109054; -- Shal'an
UPDATE `creature_template` SET `minlevel`=111, `maxlevel`=111, `faction`=16, `speed_walk`=1.60000002384185791, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=105632; -- Broodmother Shu'malis
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2820, `speed_run`=1, `BaseAttackTime`=1000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=116943; -- Nighthuntress Syrenne
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=768, `unit_flags2`=34816, `unit_flags3`=1 WHERE `entry`=111513; -- Leyweaver Ke'lorin
UPDATE `creature_template` SET `minlevel`=112, `maxlevel`=112, `speed_walk`=1.60000002384185791, `speed_run`=0.714285731315612792, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=64, `unit_flags2`=18432, `unit_flags3`=1 WHERE `entry`=110904; -- Archmage Nielthende
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113126; -- Meredil Lockjaw
UPDATE `creature_template` SET `gossip_menu_id`=6944 WHERE `entry`=111675; -- Ancient Cloudwing
UPDATE `creature_template` SET `unit_flags`=67141632 WHERE `entry`=113190; -- Meredil Thrashmaw
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=188, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=106869; -- Snarler Pup
UPDATE `creature_template` SET `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=2048, `unit_flags3`=1 WHERE `entry`=111712; -- Withered WQ Turn In Bunny
UPDATE `creature_template` SET `gossip_menu_id`=18748, `minlevel`=110, `maxlevel`=110, `faction`=2799, `npcflag`=65667, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=97140; -- First Arcanist Thalyssra
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags3`=1 WHERE `entry`=99539; -- Eternal Tether
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=99524; -- Keeper Selentia
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=99088; -- Ancient Keeper
UPDATE `creature_template` SET `minlevel`=112, `maxlevel`=112, `speed_walk`=1.60000002384185791, `speed_run`=0.714285731315612792, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=64, `unit_flags2`=67127296, `unit_flags3`=1 WHERE `entry`=114657; -- Ley Line Node
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `npcflag`=16777216, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=18432, `unit_flags3`=1 WHERE `entry`=99482; -- First Arcanist Thalyssra
UPDATE `creature_template` SET `minlevel`=112, `maxlevel`=112, `speed_walk`=1.60000002384185791, `speed_run`=0.714285731315612792, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=64, `unit_flags2`=67127296, `unit_flags3`=1 WHERE `entry`=116011; -- Barrels o' Fun
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=67110912, `unit_flags3`=1 WHERE `entry`=98967; -- Barrier Bunny
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=98946; -- Withered Thirster
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `npcflag`=3, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=51200, `unit_flags3`=1, `VehicleId`=915 WHERE `entry`=98312; -- First Arcanist Thalyssra
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768 WHERE `entry`=98943; -- Withered
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768 WHERE `entry`=99213; -- Erasmus Moonblade
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33280, `unit_flags2`=67143680, `unit_flags3`=1 WHERE `entry`=114071; -- Pulsing Arcane Echo
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33280, `unit_flags2`=67143680, `unit_flags3`=1 WHERE `entry`=114070; -- Blinking Arcane Echo
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33280, `unit_flags2`=67143680, `unit_flags3`=1 WHERE `entry`=100169; -- Faint Arcane Echo
UPDATE `creature_template` SET `unit_flags`=570721024, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=98555; -- Withered Shambler
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2799, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=67110912 WHERE `entry`=98209; -- Echo of First Arcanist Thalyssra
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=1693, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=99267; -- Nightborne Scion
UPDATE `creature_template` SET `minlevel`=112, `maxlevel`=112, `speed_run`=0.992062866687774658, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=16448, `unit_flags2`=1073743872 WHERE `entry`=110903; -- Mana Saber
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2884, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=115381; -- Nightborne Rebel
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2802, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768 WHERE `entry`=114931; -- Nightfallen Rebel
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=96972; -- Arcanist Ginsberg
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=96971; -- Alchemist Burroughs
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=97024; -- Baroness Zildjia
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=536904448, `unit_flags2`=34817, `dynamicflags`=32 WHERE `entry`=105332; -- Desmond Gravesorrow
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=97457; -- Mardigan
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=640, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=96969; -- Alfred Copperworth
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=96970; -- Revil Kost
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=105339; -- Shadowgore Darkcaster
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2009, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=96770; -- Warmage Mumplina
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=97023; -- Kat Sunflower
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2009, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=96771; -- Warmage Lukems
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=112441; -- Robert Newhearth
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=107968; -- Archmage Lan'dalock
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=129, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=93524; -- Lalla Brightweave
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=19, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=93542; -- Tanithria
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=105081; -- Archmage Kalec
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=534, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=90463; -- Archmage Karlain
UPDATE `creature_template` SET `gossip_menu_id`=18558, `minlevel`=110, `maxlevel`=110, `npcflag`=3, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=90417; -- Archmage Khadgar
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33280, `unit_flags2`=67110912 WHERE `entry`=98266; -- Arcane Anomaly
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=534, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=90431; -- Archmage Ansirem Runeweaver
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=534, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=90418; -- Archmage Modera
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=93525; -- Ainderu Summerleaf
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=1, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=34816 WHERE `entry`=105723; -- Vicktor Ebonfall
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=2007, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags2`=2048 WHERE `entry`=113873; -- Archivist Elysiana
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=82, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=93529; -- Olisarra the Kind
UPDATE `creature_template` SET `minlevel`=99, `maxlevel`=99, `npcflag`=2, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=110738; -- Kaela Grimlocket
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2007, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33280, `unit_flags3`=1 WHERE `entry`=105564; -- Injured Kirin Tor Guardian
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=113784; -- Classic Larry
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2006, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=96772; -- Warmage Kath'leen
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=129, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=93528; -- Angelique Butler
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=1732, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=4, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=97501; -- Linzi Redgrin
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=1732, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=97489; -- Garl Grimgrizzle
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `npcflag`=131, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=93543; -- Sminx Glasseye
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=19, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=93527; -- Timothy Jones
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=131, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=93526; -- Tiffany Cartier
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=81, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=92456; -- Linzy Blackbolt
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=2007, `npcflag`=19, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=92458; -- Deucus Valdera
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=51200, `VehicleId`=4927 WHERE `entry`=112130; -- Archmage Khadgar
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=2048, `HoverHeight`=1.5 WHERE `entry`=112227; -- Atiesh
UPDATE `creature_template` SET `minlevel`=99, `maxlevel`=104 WHERE `entry`=112079; -- Crimson Pilgrim
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=1735, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=97492; -- Dak'hal the Black
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=1732, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=97514; -- Danric the Bold
UPDATE `creature_template` SET `minlevel`=103 WHERE `entry`=105904; -- Raven
UPDATE `creature_template` SET `minlevel`=109, `maxlevel`=109 WHERE `entry`=96636; -- Stabled Hunter Pet
UPDATE `creature_template` SET `minlevel`=107, `maxlevel`=107, `speed_run`=1.142857193946838378 WHERE `entry`=96641; -- Stabled Hunter Pet
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105 WHERE `entry`=96639; -- Stabled Hunter Pet
UPDATE `creature_template` SET `minlevel`=107, `maxlevel`=107 WHERE `entry`=96635; -- Stabled Hunter Pet
UPDATE `creature_template` SET `speed_run`=1.142857193946838378 WHERE `entry`=96592; -- Stabled Hunter Pet
UPDATE `creature_template` SET `minlevel`=104, `maxlevel`=104, `speed_run`=1.142857193946838378 WHERE `entry`=96643; -- Stabled Hunter Pet
UPDATE `creature_template` SET `minlevel`=0, `maxlevel`=0, `faction`=2008, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2048 WHERE `entry`=104091; -- Kirin Tor Guardian
UPDATE `creature_template` SET `minlevel`=105, `maxlevel`=105, `faction`=1732, `npcflag`=17179869184, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=2048, `unit_flags3`=32 WHERE `entry`=97532; -- Violetta
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=111387; -- Deep Water Clacker
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=111409; -- Isle Lion Seal
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2048 WHERE `entry`=112477; -- Yorg Murkmouth
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=112424; -- Murkmouth Poop-Handler
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=33556480 WHERE `entry`=112423; -- Murkmouth Garbagemancer
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=67110912 WHERE `entry`=110343; -- Invisible Stalker
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=74, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=16779264 WHERE `entry`=103827; -- King Morgalash
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=74, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=16779264 WHERE `entry`=103932; -- Elder Trenchwalker
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=74, `speed_run`=0.992062866687774658, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=16779264 WHERE `entry`=103931; -- Sashj'tar Wave Caller
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=74, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=16779264 WHERE `entry`=103930; -- Sashj'tar Wave Crusher
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=74, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=16779264 WHERE `entry`=103929; -- Sashj'tar Wave Breaker
UPDATE `creature_template` SET `faction`=74, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=67110912 WHERE `entry`=103933; -- King Morgalash
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=1073743872 WHERE `entry`=112352; -- Falling Star Target
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=2181, `npcflag`=16777216, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048, `VehicleId`=4640 WHERE `entry`=103866; -- Abandoned Ballista
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=190, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=67110912 WHERE `entry`=103859; -- Jandvik Banner
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=1073743872 WHERE `entry`=112436; -- Falling Star Trigger

DELETE FROM `gameobject_template` WHERE `entry` IN (265417 /*Night Elf Single Tent 2*/, 266145 /*Kirin Tor Banner*/, 265482 /*Flagpole*/, 265480 /*Night Elf Banner 3*/, 266126 /*"Your Ancestors"*/, 266147 /*High Elf Banner 2*/, 265422 /*Night Elf Banner 2*/, 266146 /*High Elf Banner 1*/, 266055 /*Stasis Pad*/, 266433 /*Arcshaper Rune*/);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(265417, 5, 9176, 'Night Elf Single Tent 2', '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Night Elf Single Tent 2
(266145, 5, 39024, 'Kirin Tor Banner', '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Kirin Tor Banner
(265482, 5, 6394, 'Flagpole', '', '', '', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Flagpole
(265480, 5, 6390, 'Night Elf Banner 3', '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Night Elf Banner 3
(266126, 10, 39016, '\"Your Ancestors\"', 'questinteract', '', 'Removing', 0.25, 43, 0, 0, 1, 0, 0, 0, 0, 0, 0, 229765, 0, 0, 0, 0, 22741, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- "Your Ancestors"
(266147, 5, 9050, 'High Elf Banner 2', '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- High Elf Banner 2
(265422, 5, 8616, 'Night Elf Banner 2', '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Night Elf Banner 2
(266146, 5, 9049, 'High Elf Banner 1', '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- High Elf Banner 1
(266055, 10, 36343, 'Stasis Pad', '', '', '', 0.300000011920928955, 0, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Stasis Pad
(266433, 10, 39123, 'Arcshaper Rune', '', '', '', 1, 0, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420); -- Arcshaper Rune

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (244950 /*Dusty Rug*/, 246524 /*Small Treasure Chest*/, 252806 /*Small Treasure Chest*/, 253144 /*Teleportation Nexus*/, 252819 /*Small Treasure Chest*/, 252198 /*Teleportation Nexus*/, 242644 /*Treasure Chest*/, 241127 /*Unguarded Thistleleaf Treasure*/, 240519 /*Small Treasure Chest*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `WorldEffectID`) VALUES
(244950, 0, 0, 2100), -- Dusty Rug
(246524, 0, 0, 2437), -- Small Treasure Chest
(252806, 0, 0, 2437), -- Small Treasure Chest
(253144, 0, 0, 0), -- Teleportation Nexus
(252819, 0, 0, 2437), -- Small Treasure Chest
(252198, 0, 0, 0), -- Teleportation Nexus
(242644, 0, 0, 2437), -- Treasure Chest
(241127, 0, 0, 2437), -- Unguarded Thistleleaf Treasure
(240519, 0, 0, 2437); -- Small Treasure Chest

UPDATE `gameobject_template_addon` SET `WorldEffectID`=6658 WHERE `entry`=260494; -- Twice-Fortified Arcwine
UPDATE `gameobject_template_addon` SET `WorldEffectID`=6658 WHERE `entry`=252774; -- Ancient Mana Crystal
UPDATE `gameobject_template_addon` SET `WorldEffectID`=6658 WHERE `entry`=252408; -- Ancient Mana Shard
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242666; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240614; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242662; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242663; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242660; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242665; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242670; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242646; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=254141; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240605; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242959; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240651; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=241772; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242645; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242643; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242642; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242446; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240609; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240612; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `flags`=2113540 WHERE `entry`=248931; -- Smolderhide Firewater
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=242328; -- Small Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=254128; -- Treasure Chest
UPDATE `gameobject_template_addon` SET `WorldEffectID`=2437 WHERE `entry`=240653; -- Small Treasure Chest

DELETE FROM `quest_poi` WHERE (`QuestID`=38718 AND `BlobIndex`=0 AND `Idx1`=1);
INSERT INTO `quest_poi` (`QuestID`, `BlobIndex`, `Idx1`, `ObjectiveIndex`, `QuestObjectiveID`, `QuestObjectID`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `WorldEffectID`, `PlayerConditionID`, `SpawnTrackingID`, `AlwaysAllowMergingBlobs`, `VerifiedBuild`) VALUES
(38718, 0, 1, 0, 278327, 94551, 1220, 1018, 0, 0, 0, 0, 0, 1028967, 0, 23420); -- Kur'talos Ravencrest

UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=110621; -- 110621 (Erika Page)
UPDATE `creature_template_addon` SET `aiAnimKit`=913 WHERE `entry`=110623; -- 110623 (Sunny)
UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=113900; -- 113900 (Liyana)
UPDATE `creature_template_addon` SET `aiAnimKit`=11654 WHERE `entry`=112456; -- 112456 (Rachele)
UPDATE `creature_template_addon` SET `aiAnimKit`=3228 WHERE `entry`=113901; -- 113901 (Crixa)
UPDATE `creature_template_addon` SET `aiAnimKit`=11654 WHERE `entry`=112437; -- 112437 (Roscoe)
UPDATE `creature_template_addon` SET `aiAnimKit`=4175 WHERE `entry`=105904; -- 105904 (Raven)
UPDATE `creature_template_addon` SET `aiAnimKit`=2560 WHERE `entry`=100742; -- 100742 (Legion Scouting Beacon)
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=104235; -- 104235 (Val'Sharah Refugee)
UPDATE `creature_template_addon` SET `bytes1`=3 WHERE `entry`=103497; -- 103497 (Feathermane Hunter)
UPDATE `creature_template_addon` SET `bytes1`=3 WHERE `entry`=103711; -- 103711 (Feathermane Kitten)
UPDATE `creature_template_addon` SET `bytes1`=3 WHERE `entry`=103511; -- 103511 (Lost Feathermane Kitten)
UPDATE `creature_template_addon` SET `aiAnimKit`=8995 WHERE `entry`=113967; -- 113967 (Training Dummy)
UPDATE `creature_template_addon` SET `aiAnimKit`=10419 WHERE `entry`=102206; -- 102206 (Xavius)
UPDATE `creature_template_addon` SET `aiAnimKit`=9745 WHERE `entry`=102202; -- 102202 (Malfurion Stormrage)
UPDATE `creature_template_addon` SET `auras`='162908' WHERE `entry`=92332; -- 92332 (Hulking Gnarlvine)
UPDATE `creature_template_addon` SET `aiAnimKit`=1878 WHERE `entry`=94110; -- 94110 (Druid of the Moon)
UPDATE `creature_template_addon` SET `aiAnimKit`=1427 WHERE `entry`=100211; -- 100211 (Cenarius)
UPDATE `creature_template_addon` SET `aiAnimKit`=703 WHERE `entry`=100498; -- 100498 (Jabrul)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=93602; -- 93602 (Marnor Lorleaf)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=91149; -- 91149 (Acolyte of Elothir)
UPDATE `creature_template_addon` SET `aiAnimKit`=1626 WHERE `entry`=96932; -- 96932 (Hatching Harpy Egg)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=93644; -- 93644 (Del'thanar Sagewood)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=91150; -- 91150 (Acolyte of Elothir)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=92874; -- 92874 (Acolyte of Elothir)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=93640; -- 93640 (Erwind Mistfen)
UPDATE `creature_template_addon` SET `aiAnimKit`=3569 WHERE `entry`=91153; -- 91153 (Acolyte of Elothir)
UPDATE `creature_template_addon` SET `aiAnimKit`=1427 WHERE `entry`=100210; -- 100210 (Cenarius)

UPDATE `creature_equip_template` SET `ItemID1`=18610 WHERE (`CreatureID`=92617 AND `ID`=4); -- Bradensbrook Villager
UPDATE `creature_equip_template` SET `ItemID1`=85663 WHERE (`CreatureID`=92617 AND `ID`=3); -- Bradensbrook Villager

UPDATE `creature_template` SET `speed_run`=1.139999985694885253 WHERE `entry`=109959; -- Darkfiend Defiler
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=92321; -- Mature Deathblossom
