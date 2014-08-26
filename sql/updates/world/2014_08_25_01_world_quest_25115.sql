
-- http://www.wowhead.com/quest=25115	Blisterpaw Butchery
-- http://www.wowhead.com/npc=5426		Blisterpaw Hyena
-- http://www.wowhead.com/npc=40509		Hyena 01 Blisterpaw Kill Credit Bunny

UPDATE quest_template SET Flags=1048576,QuestGiverPortrait=1536,RequiredNpcOrGo1=40509,QuestGiverTextWindow="Blisterpaw Hyena",QuestGiverTargetName="Blisterpaw Hyena" WHERE Id=25115;
UPDATE creature_template SET lootid=5426 WHERE entry=5426;

update creature_template set AIName="", ScriptName="npc_blisterpaw_hyena" where entry=5426;
