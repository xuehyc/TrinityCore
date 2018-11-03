-- Various fixes by Monad

-- NPC - quests given by wrong npc fix
DELETE FROM `creature_queststarter` WHERE `id`=1416 AND `quest`=1097;
DELETE FROM `creature_queststarter` WHERE `id`=16144 AND `quest`=9067;
DELETE FROM `creature_queststarter` WHERE `id`=16187 AND `quest`=9130;
DELETE FROM `creature_queststarter` WHERE `id`=44036 AND `quest`=9130;

-- fix- adding spells for npc trainer 16367 
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=2366;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 2366, 10, 0, 0, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=2368;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 2368, 500, 182, 50, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=3570;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 3570, 5000, 182, 125, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=11993;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 11993, 50000, 182, 200, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=28695;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 28695, 100000, 182, 275, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=50300;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 50300, 350000, 182, 350, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=74519;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 74519, 500000, 182, 425, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=110413;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 110413, 600000, 182, 500, 0, 0);

-- fix - make quest 8488 finishable
UPDATE creature_template SET npcflag=2 WHERE entry=15958;

-- fix - remove quest starters for wrong quest 6344
DELETE FROM `creature_queststarter` WHERE `id`=4241 AND `quest`=6344;
DELETE FROM `creature_queststarter` WHERE `id`=40553 AND `quest`=6344;
-- fix - remove quest enders for wrong quest 6344
DELETE FROM `creature_questender` WHERE `id`=10118 AND `quest`=6344;
-- fix - remove quest starters for wrong quest 6341
DELETE FROM `creature_queststarter` WHERE `id`=10118 AND `quest`=6341;
-- fix - remove quest enders for wrong quest 6341
DELETE FROM `creature_questender` WHERE `id`=3838 AND `quest`=6341;
-- fix - remove quest starters for wrong quest 6342
DELETE FROM `creature_queststarter` WHERE `id`=3838 AND `quest`=6342;
DELETE FROM `creature_queststarter` WHERE `id`=40552 AND `quest`=6342;
-- fix - remove quest enders for wrong quest 6342
DELETE FROM `creature_questender` WHERE `id`=4200 AND `quest`=6342;
-- fix - remove quest starters for wrong quest 6343
DELETE FROM `creature_queststarter` WHERE `id`=4200 AND `quest`=6343;
DELETE FROM `creature_queststarter` WHERE `id`=4265 AND `quest`=6343;
-- fix -remove quest enders for wrong quest 6343
DELETE FROM `creature_questender` WHERE `id`=10118 AND `quest`=6343;

-- fix - delete wrong quest ender for furlbrow's deed quest 184
DELETE FROM `creature_questender` WHERE `id`=237 AND `quest`=184;

-- fix - corect texts for the furlbrow's deed quest 184
DELETE FROM `quest_request_items` WHERE `ID`=184;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) 
VALUES (184, 1, 0, 0, 0, 'We don\'t need any civilian vigilante types getting involved, kid. Leave this one to the professionals.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=184;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (184, 1,0, 0, 0, 0, 0, 0, 0, 'This is useless. Look at the date on this letter. The Furlbrows have been squatting on the Jansen Steed for five years. They never could quite get their wagon... fixed.', 0);

-- fix - corect answers for quest heros call westfall 
DELETE FROM `quest_offer_reward` WHERE `ID`=26378;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26378, 1, 0, 0, 0, 0, 0, 0, 0, 'Murder, rookie. That\'s what you\'re looking at on the ground in front of us.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=28562;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (28562, 1, 0, 0, 0, 0, 0, 0, 0, 'Murder, rookie. That\'s what you\'re looking at on the ground in front of us.', 0);

-- fix - emotes on gnome survivors gnome starting area
DELETE FROM `creature_addon` WHERE `guid` in (167778, 168303, 168353, 168354, 168378, 168379, 168380, 168399, 168400, 168414, 168415, 168416, 168417, 168837, 168838, 168839, 168841, 168842, 168843, 168898, 168900, 168901, 168928, 168937, 168939);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
 (167778, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168303, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168353, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168354, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168378, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168379, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168380, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168399, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168400, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168414, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168415, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168416, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168417, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168837, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168838, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168839, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168841, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168842, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168843, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168898, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168900, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168901, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168928, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168937, 0, 0, 0, 0, 431, 0, 0, 0, 0),
 (168939, 0, 0, 0, 0, 431, 0, 0, 0, 0);

 -- fix - pinned down quest completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=27670;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (27670, 1, 0, 0, 0, 0, 0, 0, 0, 'Well done, $n. My men can take it from here. Let\'s focus on getting the other survivors out now.', 0);

-- fix - pinned down quest completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=28167;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (28167, 1, 0, 0, 0, 0, 0, 0, 0, 'Did Nevin send you ahead? That means he\'s getting ready to end the mission, but there are still survivors to be rescued. We have to help them!', 0);

-- fix - see to the survivors completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=27671;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (27671, 1, 0, 0, 0, 0, 0, 0, 0, 'I know Nevin will be pleased with all the survivors you managed to help. I still can\'t believe you managed to stay so strong down here in the radiation. You\'ve seen the shape the other survivors are in. Let\'s get you to the loading room for decontamination.', 0);

-- fix - widraw to the loading room completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=28169;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (28169, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $c. We rarely come across survivors as strong and capable as you are. I can help get you decontaminated and on your way out of here.', 0);

-- fix - decontamination completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=27635;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (27635, 1, 0, 0, 0, 0, 0, 0, 0, 'There, now you\'re fit to head off to the surface and start your new life. The High Tinker will be delighted to hear of your arrival.', 0);

-- fix - to the surface completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=27674;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (27674, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to see you again, $n. Without your help, we wouldn\'t have been able to get so many survivors out of Gnomeregan this time. Everyone is going to be thrilled to meet you and hear your story.', 0);

-- fix - the future of gnomeregan completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=26197;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26197, 1, 0, 0, 0, 0, 0, 0, 0, '$n, isn\'t it? It\'s a pleasure to finally meet you. While you were getting cleaned up, Nevin\'s team told me about your escape from Gnomeregan.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26199;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26199, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. I\'m sure your time in Gnomeregan afforded you ample opportunity to practice your arts. Things are somewhat safer here, but your talents will never go to waste.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26202;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26202, 1, 0, 0, 0, 0, 0, 0, 0, 'So, another one of Nevin\'s "rescued" survivors, eh? More than likely, you saved his life from the troggs down there. Did he stumble over his words when he mentioned me? The man has a healthy respect for the demonic powers we channel.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26203;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26203, 1, 0, 0, 0, 0, 0, 0, 0, 'For a $r who has spent so much time inside Gnomeregan, you look positively fit and healthy, $n. That\'s good. Before we can complete what Operation: Gnomeregan began, we\'re going to need more warriors like you.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26206;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26206, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. Nevin tells me that you managed to survive the dangers in Gnomeregan by using your wits. That\'s exactly what we need up here. Clever minds and quick blades.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=31135;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (31135, 1, 0, 0, 0, 0, 0, 0, 0, 'Why, you look great! I\'ve heard bad things about what happens down there. Well, are you ready to start your training in the ways of the $c?', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=41217;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (41217, 1, 0, 0, 0, 0, 0, 0, 0, 'For a $r who has spent so much time inside Gnomeregan, you look positively fit and healthy, $n. That\'s good. Before we can complete what Operation: Gnomeregan began, we\'re going to need more hunters like you.', 0);

-- fix - meet the high tinker quest completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=26421;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26421, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26422;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26422, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26423;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26423, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26424;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26424, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26425;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26425, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=31137;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (31137, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=41218;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (41218, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);

-- fix - the fight continues quest completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=26208;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26208, 1, 0, 0, 0, 0, 0, 0, 0, 'Even now, only the S.A.F.E. teams dare to venture far into the city to search for survivors. Meanwhile, Thermaplugg has sent one of his followers, Crushcog, to distract us and buy time for him to dig in.', 0);


-- fix - the fight continues quest completion text
DELETE FROM `quest_request_items` WHERE `ID`=26222;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) 
VALUES (26222, 1, 0, 0, 0, 'Did you get those parts?', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26222;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26222, 1, 0, 0, 0, 0, 0, 0, 0, 'These are fantastic! Let\'s see what we can put together. Would you be interested in testing out the prototype once I\'m done?', 0);


DELETE FROM `quest_offer_reward` WHERE `ID`=26205;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26205, 1, 0, 0, 0, 0, 0, 0, 0, 'Wow, I never expected it to work on the first trial! Uh, I mean, we\'ve succeeded! I wonder what other uses I we can find for this handy little guy.', 0);


-- by AZGART
-- fix - repaired mechano tank - by azgart
DELETE FROM `smart_scripts` WHERE `entryorguid`=42224 AND `id`=0 AND `source_type`=0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) 
VALUES (42224,0,0,0,8,0,100,0,79751,0,0,0,33,42224,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'npc die');

-- fix - npc die from spellhit - by azgart
DELETE FROM `smart_scripts` WHERE `entryorguid`=42563 AND `id`=2 AND `source_type`=0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) 
VALUES (42563,0,2,0,8,0,100,0,79424,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'npc die from spellhit');

-- fix - GS-9x Multi-Bot - by azgart
DELETE FROM `smart_scripts` WHERE `entryorguid`=42598 AND `id`=0 AND `source_type`=0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) 
VALUES (42598,0,0,1,31,0,100,0,79424,0,15000,17000,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'GS-9x Multi-Bot');

-- fix - Credit quest 26205 - by azgart
DELETE FROM `smart_scripts` WHERE `entryorguid`=42563 AND `id`=1 AND `source_type`=0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) 
VALUES (42563,0,1,0,8,0,100,0,79424,0,0,0,33,42563,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'Credit quest 26205');

-- fix - Cast Cleanup Toxic Pool - by azgart
DELETE FROM `smart_scripts` WHERE `entryorguid`=42598 AND `id`=1 AND `source_type`=0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) 
VALUES (42598,0,1,2,10,0,100,0,1,2,0,0,11,79424,0,0,0,0,0,19,42563,0,0,0.0,0.0,0.0,0.0,'Cast Cleanup Toxic Pool');

-- backup - backup to "fixes" made by azgart
DELETE FROM `smart_scripts` WHERE `entryorguid`=42563 AND `source_type`=0 AND `id`=1 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES (42563, 0, 1, 0, 1, 0, 100, 0, 0, 0, 0, 0, '', 11, 79422, 2, 18, 35, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Credit quest 26205');
DELETE FROM `smart_scripts` WHERE `entryorguid`=42598 AND `source_type`=0 AND `id`=0 AND `link`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES (42598, 0, 0, 1, 8, 0, 100, 0, 79416, 0, 15000, 17000, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Dummy Spell hit Talk');
DELETE FROM `smart_scripts` WHERE `entryorguid`=42598 AND `source_type`=0 AND `id`=1 AND `link`=2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES (42598, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, '', 11, 79424, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Cleanup Toxic Pool');
DELETE FROM `smart_scripts` WHERE `entryorguid`=42598 AND `source_type`=0 AND `id`=2 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES (42598, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, '', 11, 79422, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Toxic Pool Credit to Master');
