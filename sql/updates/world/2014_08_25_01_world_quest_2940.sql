
-- http://db.vanillagaming.org/?quest=2940	    Feralas: A History
-- http://db.vanillagaming.org/?object=142958	Feralas: A History    -- a book
-- http://db.vanillagaming.org/?npc=7907		Daryn Lightwind <Cenarion Lore Keeper>

set @QUEST = 2940;
set @QS = 142958;
set @QE = 7907;

delete from gameobject_queststarter where id=@QS and quest=@QUEST;
insert into gameobject_queststarter value (@QS,@QUEST);

delete from creature_questender where id=@QE and quest=@QUEST;
insert into creature_questender value (@QE,@QUEST);

UPDATE quest_template SET Flags=8200 WHERE Id=2940;





