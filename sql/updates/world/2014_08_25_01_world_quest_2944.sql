
-- http://db.vanillagaming.org/?quest=2944	The Super Snapper FX
-- http://db.vanillagaming.org/?npc=7763	Curgle Cranklehop
-- http://db.vanillagaming.org/?npc=7907	Daryn Lightwind <Cenarion Lore Keeper>
-- http://db.vanillagaming.org/?item=9330	Snapshot of Gammerita
-- http://db.vanillagaming.org/?item=9328	Super Snapper FX

set @QUEST = 2944;
set @QS = 7763;
set @QE = 7907;

delete from creature_queststarter where id=@QS and quest=@QUEST;
insert into creature_queststarter value (@QS,@QUEST);

delete from creature_questender where id=@QE and quest=@QUEST;
insert into creature_questender value (@QE,@QUEST);

UPDATE quest_template SET Flags=0 WHERE Id=@QUEST;

