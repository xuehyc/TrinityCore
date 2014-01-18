
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

-- new spell spell_hun_steady_shot_focus (generates fokus on steady shoot)
set @ENTRY=77443;
delete from spell_script_names where spell_id=@ENTRY;
insert into spell_script_names values (@ENTRY,"spell_hun_steady_shot_focus");

-- new spell spell_hun_generic_energize_focus (generates energie)
set @ENTRY=91954;
delete from spell_script_names where spell_id=@ENTRY;
insert into spell_script_names values (@ENTRY,"spell_hun_generic_energize_focus");

-- new spell Primal Strike 
set @ENTRY=73899;
delete from spell_script_names where spell_id=@ENTRY;
insert into spell_script_names values (@ENTRY,"spell_sha_primal_strike");

-- fix update and insert spell immolate
-- double name 
set @ENTRY=348;
delete from spell_script_names where spell_id=@ENTRY;
insert into spell_script_names values (@ENTRY,"spell_warl_immolate_348");

-- fix spell immolate 
set @ENTRY=118297;
delete from spell_script_names where spell_id=@ENTRY;
insert into spell_script_names values (@ENTRY,"spell_warl_immolate_118297");

-- wrong queststarter
delete from creature_queststarter where id=37514 and quest=218;

-- wrong quest chain
UPDATE quest_template SET NextQuestId=218 WHERE Id=182;
UPDATE quest_template SET PrevQuestId=182 WHERE Id=218;
UPDATE quest_template SET NextQuestId=24491 WHERE Id=24490;
UPDATE quest_template SET PrevQuestId=24490 WHERE Id=24491;

-- quest 3110
UPDATE quest_template SET RequiredRaces=0,SpecialFlags=4 WHERE Id=3110;










