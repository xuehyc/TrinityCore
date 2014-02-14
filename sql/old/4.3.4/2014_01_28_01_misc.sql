
-- darkshire quest 13596

-- quest's 13567,13568,13597
UPDATE quest_template SET NextQuestId=13569 WHERE Id=13566;
UPDATE quest_template SET PrevQuestId=0,Method=2,RewardSpellCast=62803 WHERE Id=13567;
UPDATE quest_template SET PrevQuestId=0,Method=2,RewardSpellCast=62803 WHERE Id=13568;
UPDATE quest_template SET PrevQuestId=0,Method=2,RewardSpellCast=62803 WHERE Id=13597;

update creature_template set npcflag=2,AIName="",ScriptName="npc_great_moonstalker_spirit" where entry=33131;
update creature_template set npcflag=2,AIName="",ScriptName="npc_great_thistle_bear_spirit" where entry=33132;
update creature_template set npcflag=2,AIName="",ScriptName="npc_great_stag_spirit" where entry=33133;
update creature set phasemask=2 where guid in (117338,117339,117340);
update creature_template set AIName="",ScriptName="" where entry=33048;

delete from creature_queststarter where id=33131 and quest=13568;
insert into creature_queststarter values(33131,13568);

update gameobject_template set data1=13569,AIName="",ScriptName="go_grovekeepers_incense" where entry=194771;





