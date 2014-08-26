
-- http://db.vanillagaming.org/?quest=2943	Return to Troyas
-- http://db.vanillagaming.org/?npc=7907	Daryn Lightwind <Cenarion Lore Keeper>
-- http://db.vanillagaming.org/?npc=7764	Troyas Moonbreeze

set @QUEST = 2943;
set @QS = 7907;
set @QE = 7764;

delete from creature_queststarter where id=@QS and quest=@QUEST;
insert into creature_queststarter value (@QS,@QUEST);

delete from creature_questender where id=@QE and quest=@QUEST;
insert into creature_questender value (@QE,@QUEST);

UPDATE quest_template SET PrevQuestId=2944,Flags=0 WHERE Id=@QUEST;









