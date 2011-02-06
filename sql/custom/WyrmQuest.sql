update quest_template set ReqSpellCast1 = 0 where entry = 11515;
update quest_template set ReqSpellCast1 = 0 where entry in (11538,11537);
update creature_loot_template set lootcondition = 9, condition_value1 = 11515 where item = 34259;




INSERT IGNORE INTO
`creature_template`
(`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `subname`, `IconName`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) 
VALUES
(1000103, 0, 20540, 0, 20540, 0, 'Salva', 'Bote der Netherschwingen', '', 70, 70, 10000, 10000, 7000, 7000, 6000, 1824, 1824, 1, 1.2, 1, 0, 88, 178, 0, 927, 1391, 1634, 2, 0, 0, 0, 0, 0, 0, 314.609, 438.592, 100, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 1, 0, 0, 0, 'npc_dragonmaw_illusion');


-- Champion of Naaru ID 20000

update quest_template set NextQuestId = 20000, ExclusiveGroup = -20000 where entry in (10901,10888);
delete from quest_template where entry = 20000;
insert into quest_template 
(entry, Method, ZoneOrSort,	SkillOrClass,	MinLevel, QuestLevel, Type, RequiredRaces, RequiredSkillValue, RepObjectiveFaction, RepObjectiveValue, RequiredMinRepFaction, 
RequiredMinRepValue, RequiredMaxRepFaction, RequiredMaxRepValue, SuggestedPlayers, LimitTime, QuestFlags, SpecialFlags, CharTitleId, PrevQuestId, NextQuestId, 
ExclusiveGroup, NextQuestInChain, SrcItemId, SrcItemCount, SrcSpell, Title, Details, Objectives, OfferRewardText, RequestItemsText, EndText, ObjectiveText1, 
ObjectiveText2, ObjectiveText3, ObjectiveText4, ReqItemId1, ReqItemId2, ReqItemId3, ReqItemId4, ReqItemCount1, ReqItemCount2, ReqItemCount3, 
ReqItemCount4, ReqSourceId1, ReqSourceId2, ReqSourceId3, ReqSourceId4, ReqSourceCount1, ReqSourceCount2, ReqSourceCount3, ReqSourceCount4, 
ReqSourceRef1, ReqSourceRef2, ReqSourceRef3, ReqSourceRef4, ReqCreatureOrGOId1, ReqCreatureOrGOId2, ReqCreatureOrGOId3, ReqCreatureOrGOId4, 
ReqCreatureOrGOCount1, ReqCreatureOrGOCount2, ReqCreatureOrGOCount3, ReqCreatureOrGOCount4, ReqSpellCast1, ReqSpellCast2, ReqSpellCast3, ReqSpellCast4, RewChoiceItemId1,
RewChoiceItemId2, RewChoiceItemId3, RewChoiceItemId4, RewChoiceItemId5, RewChoiceItemId6, RewChoiceItemCount1, RewChoiceItemCount2, RewChoiceItemCount3, 
RewChoiceItemCount4, RewChoiceItemCount5, RewChoiceItemCount6, RewItemId1, RewItemId2, RewItemId3, RewItemId4, RewItemCount1, RewItemCount2, RewItemCount3, 
RewItemCount4, RewRepFaction1, RewRepFaction2, RewRepFaction3, RewRepFaction4, RewRepFaction5, RewRepValue1, RewRepValue2, RewRepValue3, RewRepValue4, 
RewRepValue5, RewHonorableKills, RewOrReqMoney, RewMoneyMaxLevel, RewSpell, RewSpellCast, RewMailTemplateId, RewMailDelaySecs, PointMapId,
PointX, PointY, PointOpt, DetailsEmote1, DetailsEmote2, DetailsEmote3, DetailsEmote4, IncompleteEmote, CompleteEmote, OfferRewardEmote1, 
OfferRewardEmote2, OfferRewardEmote3, OfferRewardEmote4, StartScript, CompleteScript)
values
(20000, 0, 3703, 0, 70, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 53, 0, 0, 0, 0, 0, 0, 0, 'Durch und durch würdig.', 
'', '---', 	'Mit diesen Schlüssel könnt ihr die Festung der Stürme betreten.', 	'Ihr seit nun von A\'dal als würdig befunden im Namen aller Naaru am Kampf gegen Keal\'Thas persönlich teilzunehmen.$B$B$N, Ihr seit nun ein Champion der Naaru.', 
'', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 31704, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
insert ignore into creature_questrelation values (18166,20000);
insert ignore into creature_involvedrelation values (18166,20000);