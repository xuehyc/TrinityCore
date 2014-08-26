
-- http://www.wowhead.com/quest=25111	Scavengers Scavenged
-- http://www.wowhead.com/npc=5429		Fire Roc
-- http://www.wowhead.com/npc=40507		Tanaris Fire Roc Kill Credit Bunny

UPDATE quest_template SET QuestGiverPortrait=7348,RequiredNpcOrGo1=40507,QuestGiverTextWindow="Fire Roc",QuestGiverTargetName="Fire Roc" WHERE Id=25111;

update creature_template set AIName="", ScriptName="npc_fire_rock" where entry=5429;



	