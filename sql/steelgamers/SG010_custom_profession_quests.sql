DELETE FROM `quest_template` WHERE `Id` IN (50004, 50005, 50006);
INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50004,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
164,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23276,
-- RewardChoiceItemId2
23314,              
-- RewardChoiceItemId3
23275,
-- RewardChoiceItemId4
23287,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Casco, botas',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
3859,
-- RequiredItemId2
3860,
-- RequiredItemId3
3577,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
20,
-- RequiredItemCount2
10,
-- RequiredItemCount3
2,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50005,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
164,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23277,
-- RewardChoiceItemId2
23315,              
-- RewardChoiceItemId3
23274,
-- RewardChoiceItemId4
23286,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Hombreras, guanteletes',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
3859,
-- RequiredItemId2
3860,
-- RequiredItemId3
3577,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
15,
-- RequiredItemCount2
8,
-- RequiredItemCount3
1,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50006,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
164,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23272,
-- RewardChoiceItemId2
23300,              
-- RewardChoiceItemId3
23273,
-- RewardChoiceItemId4
23301,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Pechera, grebas',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
3859,
-- RequiredItemId2
3860,
-- RequiredItemId3
3577,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
25,
-- RequiredItemCount2
15,
-- RequiredItemCount3
3,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

DELETE FROM `creature_queststarter` WHERE `quest` IN (50004, 50005, 50006);
DELETE FROM `creature_questender` WHERE `quest` IN (50004, 50005, 50006);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5511, 50004);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5511, 50004);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5511, 50005);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5511, 50005);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5511, 50006);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5511, 50006);
UPDATE `creature_template` SET `npcflag` = `npcflag` + 2 WHERE entry = 5511;

DELETE FROM `quest_template` WHERE `Id` IN (50007, 50008, 50009, 50010, 50011, 50012);
INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50007,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
165,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23308,
-- RewardChoiceItemId2
23312,              
-- RewardChoiceItemId3
23281,
-- RewardChoiceItemId4
23285,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Casco, botas (Cuero)',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
4304,
-- RequiredItemId2
8170,
-- RequiredItemId3
15407,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
20,
-- RequiredItemCount2
10,
-- RequiredItemCount3
2,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50008,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
165,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23309,
-- RewardChoiceItemId2
23313,              
-- RewardChoiceItemId3
23280,
-- RewardChoiceItemId4
23284,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Hombreras, guantes (Cuero)',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
4304,
-- RequiredItemId2
8170,
-- RequiredItemId3
15407,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
15,
-- RequiredItemCount2
8,
-- RequiredItemCount3
1,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50009,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
165,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23294,
-- RewardChoiceItemId2
23298,              
-- RewardChoiceItemId3
23295,
-- RewardChoiceItemId4
23299,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Pechera, piernas (Cuero)',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
4304,
-- RequiredItemId2
8170,
-- RequiredItemId3
15407,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
25,
-- RequiredItemCount2
15,
-- RequiredItemCount3
3,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50010,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
165,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23306,
-- RewardChoiceItemId2
29598,              
-- RewardChoiceItemId3
23278,
-- RewardChoiceItemId4
29594,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Casco, botas (Malla)',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
4304,
-- RequiredItemId2
3860,
-- RequiredItemId3
3577,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
20,
-- RequiredItemCount2
10,
-- RequiredItemCount3
2,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50011,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
165,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23307,
-- RewardChoiceItemId2
29599,              
-- RewardChoiceItemId3
23279,
-- RewardChoiceItemId4
29595,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Hombreras, guanteletes (Malla)',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
4304,
-- RequiredItemId2
3860,
-- RequiredItemId3
3577,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
15,
-- RequiredItemCount2
8,
-- RequiredItemCount3
1,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID
50012,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId
165,
-- RequiredSkillPoints
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1
23292,
-- RewardChoiceItemId2
29596,              
-- RewardChoiceItemId3
23293,
-- RewardChoiceItemId4
29597,
-- RewardChoiceItemId5
0,
-- RewardChoiceItemId6
0,
-- RewardChoiceItemCount1
1,
-- RewardChoiceItemCount2
1,
-- RewardChoiceItemCount3
1,
-- RewardChoiceItemCount4
1,
-- RewardChoiceItemCount5
0,
-- RewardChoiceItemCount6
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Pechera, grebas (Malla)',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1
4304,
-- RequiredItemId2
3860,
-- RequiredItemId3
3577,
-- RequiredItemId4
0,
-- RequiredItemId5
0,
-- RequiredItemId6
0,
-- RequiredItemCount1
25,
-- RequiredItemCount2
15,
-- RequiredItemCount3
3,
-- RequiredItemCount4
0,
-- RequiredItemCount5
0,
-- RequiredItemCount6
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

DELETE FROM `creature_queststarter` WHERE `quest` IN (50007, 50008, 50009, 50010, 50011, 50012);
DELETE FROM `creature_questender` WHERE `quest` IN (50007, 50008, 50009, 50010, 50011, 50012);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5564, 50007);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5564, 50007);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5564, 50008);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5564, 50008);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5564, 50009);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5564, 50009);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5564, 50010);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5564, 50010);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5564, 50011);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5564, 50011);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (5564, 50012);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (5564, 50012);
UPDATE `creature_template` SET `npcflag` = `npcflag` + 2 WHERE entry = 5564;

DELETE FROM `quest_template` WHERE `Id` IN (50013, 50014, 50015);
INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID 
50013,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort 
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId 
197,
-- RequiredSkillPoints 
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1 
23310,
-- RewardChoiceItemId2 
23316,              
-- RewardChoiceItemId3 
23318,
-- RewardChoiceItemId4 
23283,
-- RewardChoiceItemId5 
23289,
-- RewardChoiceItemId6 
23291,
-- RewardChoiceItemCount1 
1,
-- RewardChoiceItemCount2 
1,
-- RewardChoiceItemCount3 
1,
-- RewardChoiceItemCount4 
1,
-- RewardChoiceItemCount5 
1,
-- RewardChoiceItemCount6 
1,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Cabeza, botas',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1 
4305,
-- RequiredItemId2 
14047,
-- RequiredItemId3 
14048,
-- RequiredItemId4 
0,
-- RequiredItemId5 
0,
-- RequiredItemId6 
0,
-- RequiredItemCount1 
20,
-- RequiredItemCount2 
10,
-- RequiredItemCount3 
2,
-- RequiredItemCount4 
0,
-- RequiredItemCount5 
0,
-- RequiredItemCount6 
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID 
50014,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort 
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId 
197,
-- RequiredSkillPoints 
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1 
23311,
-- RewardChoiceItemId2 
23317,              
-- RewardChoiceItemId3 
23319,
-- RewardChoiceItemId4 
23282,
-- RewardChoiceItemId5 
23288,
-- RewardChoiceItemId6 
23290,
-- RewardChoiceItemCount1 
1,
-- RewardChoiceItemCount2 
1,
-- RewardChoiceItemCount3 
1,
-- RewardChoiceItemCount4 
1,
-- RewardChoiceItemCount5 
1,
-- RewardChoiceItemCount6 
1,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title 
'Equipamiento PvP - Hombreras, guantes',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1 
4305,
-- RequiredItemId2 
14047,
-- RequiredItemId3 
14048,
-- RequiredItemId4 
0,
-- RequiredItemId5 
0,
-- RequiredItemId6 
0,
-- RequiredItemCount1 
15,
-- RequiredItemCount2 
8,
-- RequiredItemCount3 
1,
-- RequiredItemCount4 
0,
-- RequiredItemCount5 
0,
-- RequiredItemCount6 
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

INSERT INTO `quest_template` (
`Id`, `Method`, `Level`, `MinLevel`, `MaxLevel`, `ZoneOrSort`, `Type`, `SuggestedPlayers`,
`LimitTime`, `RequiredClasses`, `RequiredRaces`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredFactionId1`, `RequiredFactionId2`,
`RequiredFactionValue1`, `RequiredFactionValue2`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`,
`RequiredMaxRepValue`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestIdChain`, `RewardXPId`, `RewardOrRequiredMoney`,
`RewardMoneyMaxLevel`, `RewardSpell`, `RewardSpellCast`, `RewardHonor`, `RewardHonorMultiplier`, `RewardMailTemplateId`,
`RewardMailDelay`, `SourceItemId`, `SourceItemCount`, `SourceSpellId`, `Flags`, `SpecialFlags`, `RewardTitleId`, `RequiredPlayerKills`,
`RewardTalents`, `RewardArenaPoints`, `RewardItemId1`, `RewardItemId2`, `RewardItemId3`, `RewardItemId4`, `RewardItemCount1`,
`RewardItemCount2`, `RewardItemCount3`, `RewardItemCount4`, `RewardChoiceItemId1`, `RewardChoiceItemId2`, `RewardChoiceItemId3`,
`RewardChoiceItemId4`, `RewardChoiceItemId5`, `RewardChoiceItemId6`, `RewardChoiceItemCount1`, `RewardChoiceItemCount2`, `RewardChoiceItemCount3`,
`RewardChoiceItemCount4`, `RewardChoiceItemCount5`, `RewardChoiceItemCount6`, `RewardFactionId1`, `RewardFactionId2`,
`RewardFactionId3`, `RewardFactionId4`, `RewardFactionId5`, `RewardFactionValueId1`, `RewardFactionValueId2`, `RewardFactionValueId3`,
`RewardFactionValueId4`, `RewardFactionValueId5`, `RewardFactionValueIdOverride1`, `RewardFactionValueIdOverride2`,
`RewardFactionValueIdOverride3`, `RewardFactionValueIdOverride4`, `RewardFactionValueIdOverride5`, `PointMapId`,
`PointX`, `PointY`, `PointOption`, `Title`, `Objectives`, `Details`, `EndText`, `OfferRewardText`, `RequestItemsText`,
`CompletedText`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`,
`RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredSourceItemId1`, `RequiredSourceItemId2`,
`RequiredSourceItemId3`, `RequiredSourceItemId4`, `RequiredSourceItemCount1`, `RequiredSourceItemCount2`, `RequiredSourceItemCount3`,
`RequiredSourceItemCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`,
`RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`,
`RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `DetailsEmote1`,
`DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`,
`EmoteOnIncomplete`, `EmoteOnComplete`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`,
`OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `VerifiedBuild`
) VALUES (
-- ID 
50015,
-- Method
2,
-- Level
40,
-- MinLevel
40,
-- Maxlevel
0,
-- ZoneOrSort 
1519,
-- Type
0,
-- SuggestedPlayers
0,
-- LimitTime
0,
-- RequiredClasses
0,
-- RequiredRaces
0,
-- RequiredSkillId 
197,
-- RequiredSkillPoints 
225,
-- RequiredFactionId1
0,
-- RequiredFactionId2
0,
-- RequiredFactionValue1
0,
-- RequiredFactionValue2
0,
-- RequiredMinRepFaction
0,
-- RequiredMaxRepFaction
0,
-- RequiredMinRepValue
0,
-- RequiredMaxRepValue
0,
-- PrevQuestId
0,
-- NextQuestId
0,
-- ExclusiveGroup
0,
-- NextQuestIdChain
0,
-- RewardXPId
0,
-- RewardOrRequiredMoney
0,
-- RewardMoneyMaxLevel
0,
-- RewardSpell
0,
-- RewardSpellCast
0,
-- RewardHonor
0,
-- RewardHonorMultiplier
0,
-- RewardMailTemplateId
0,
-- RewardMailDelay
0,
-- SourceItemId
0,
-- SourceItemCount
0,
-- SourceSpellId
0,
-- Flags
0,
-- SpecialFlags
1,
-- RewardTitleId
0,
-- RequiredPlayerKills
0,
-- RewardTalents
0,
-- RewardArenaPoints
0,
-- RewardItemId1
0,
-- RewardItemId2
0,
-- RewardItemId3
0,
-- RewardItemId4
0,
-- RewardItemCount1
0,
-- RewardItemCount2
0,
-- RewardItemCount3
0,
-- RewardItemCount4
0,
-- RewardChoiceItemId1 
23297,
-- RewardChoiceItemId2 
23303,              
-- RewardChoiceItemId3 
23305,
-- RewardChoiceItemId4 
23296,
-- RewardChoiceItemId5 
23302,
-- RewardChoiceItemId6 
23304,
-- RewardChoiceItemCount1 
1,
-- RewardChoiceItemCount2 
1,
-- RewardChoiceItemCount3 
1,
-- RewardChoiceItemCount4 
1,
-- RewardChoiceItemCount5 
0,
-- RewardChoiceItemCount6 
0,
-- RewardFactionId1
0,
-- RewardFactionId2
0,                     
-- RewardFactionId3
0,
-- RewardFactionId4
0,
-- RewardFactionId5
0,
-- RewardFactionValueId1
0,
-- RewardFactionValueId2
0,
-- RewardFactionValueId3
0,
-- RewardFactionValueId4
0,
-- RewardFactionValueId5
0,
-- RewardFactionValueIdOverride1
0,
-- RewardFactionValueIdOverride2
0,
-- RewardFactionValueIdOverride3
0,
-- RewardFactionValueIdOverride4
0,
-- RewardFactionValueIdOverride5
0,
-- PointMapId
0,
-- PointX
0,
-- PointY
0,
-- PointOption
0,
-- Title
'Equipamiento PvP - Pecho, pantalones',
-- Objectives
'Entrega los materiales necesarios al instructor para que te ayude a fabricar el objeto.',
-- Details
'Si consigues los materiales, puedo ayudarte a fabricar el mejor equipo, $C',
-- EndText
'',
-- OfferRewardText
'',
-- RequestItemsText
NULL,
-- CompletedText
'',
-- RequiredNpcOrGo1
0,
-- RequiredNpcOrGo2
0,
-- RequiredNpcOrGo3
0,
-- RequiredNpcOrGo4
0,
-- RequiredNpcOrGoCount1
0,
-- RequiredNpcOrGoCount2
0,
-- RequiredNpcOrGoCount3
0,
-- RequiredNpcOrGoCount4
0,
-- RequiredSourceItemId1
0,
-- RequiredSourceItemId2
0,
-- RequiredSourceItemId3
0,
-- RequiredSourceItemId4
0,
-- RequiredSourceItemCount1
0,
-- RequiredSourceItemCount2
0,
-- RequiredSourceItemCount3
0,
-- RequiredSourceItemCount4
0, 
-- RequiredItemId1 
4305,
-- RequiredItemId2 
14047,
-- RequiredItemId3 
14048,
-- RequiredItemId4 
0,
-- RequiredItemId5 
0,
-- RequiredItemId6 
0,
-- RequiredItemCount1 
25,
-- RequiredItemCount2 
15,
-- RequiredItemCount3 
3,
-- RequiredItemCount4 
0,
-- RequiredItemCount5 
0,
-- RequiredItemCount6 
0,
-- Unknown0
0,
-- ObjectiveText1
'',
-- ObjectiveText2
NULL,
-- ObjectiveText3
NULL,
-- ObjectiveText4
NULL,         
-- DetailsEmote1
0,
-- DetailsEmote2
0,
-- DetailsEmote3
0,
-- DetailsEmote4
0,
-- DetailsEmoteDelay1
0,
-- DetailsEmoteDelay2
0,
-- DetailsEmoteDelay3
0,
-- DetailsEmoteDelay4
0,
-- EmoteOnIncomplete
0,
-- EmoteOnComplete
62,
-- OfferRewardEmote1
0,
-- OfferRewardEmote2
0,
-- OfferRewardEmote3
0,
-- OfferRewardEmote4
0,
-- OfferRewardEmoteDelay1
0,
-- OfferRewardEmoteDelay2
0,
-- OfferRewardEmoteDelay3
0,
-- OfferRewardEmoteDelay4
0,
-- VerifiedBuild
12340
);

DELETE FROM `creature_queststarter` WHERE `quest` IN (50013, 50014, 50015);
DELETE FROM `creature_questender` WHERE `quest` IN (50013, 50014, 50015);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (1346, 50013);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (1346, 50013);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (1346, 50014);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (1346, 50014);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (1346, 50015);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (1346, 50015);
UPDATE `creature_template` SET `npcflag` = `npcflag` + 2 WHERE entry = 1346;
