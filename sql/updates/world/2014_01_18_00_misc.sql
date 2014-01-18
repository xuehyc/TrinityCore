
-- new spell spell_pal_seal_of_righteousness
set @ENTRY=20154;
delete from spell_script_names where spell_id=@ENTRY;
insert into spell_script_names values (@ENTRY,"spell_pal_seal_of_righteousness");

-- http://www.wowhead.com/npc=37087  Jona Ironstock quest chain
UPDATE quest_template SET PrevQuestId=24473 WHERE Id=24474;
UPDATE quest_template SET NextQuestId=24487 WHERE Id=24475;
UPDATE quest_template SET PrevQuestId=24475,NextQuestId=182 WHERE Id=24487;

-- http://www.wowhead.com/npc=37514  Grik'nir's Servant  no loot
update creature_template set lootid=37514 where entry=37514;

-- paladin dwarf quest 24528 using Seal of Righteousness
UPDATE quest_template SET ObjectiveText2="Learn Spell: Seal of Righteousness" WHERE Id=24528;

-- paladin human quest 26918 using Seal of Righteousness
UPDATE quest_template SET RequiredNpcOrGo2=44420,RequiredNpcOrGoCount2=1,ObjectiveText2="Learn Spell: Seal of Righteousness" WHERE Id=26918;



