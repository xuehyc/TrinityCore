

-- http://db.vanillagaming.org/?quest=2941	The Borrower
-- http://db.vanillagaming.org/?npc=7907	Daryn Lightwind <Cenarion Lore Keeper>
-- http://db.vanillagaming.org/?npc=7763	Curgle Cranklehop
-- http://db.vanillagaming.org/?item=9329	A Short Note

set @QUEST = 2941;
set @QS = 7907;
set @QE = 7763;

delete from creature_queststarter where id=@QS and quest=@QUEST;
insert into creature_queststarter value (@QS,@QUEST);

delete from creature_questender where id=@QE and quest=@QUEST;
insert into creature_questender value (@QE,@QUEST);

UPDATE quest_template SET Flags=0 WHERE Id=@QUEST;





