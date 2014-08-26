
-- on 403 is this quest active
-- http://db.vanillagaming.org/?quest=3022 
-- http://db.vanillagaming.org/?npc=7763  -- starter
-- http://db.vanillagaming.org/?npc=7916  -- ender
-- http://db.vanillagaming.org/?item=9507 -- A Carefully-packed Crate

set @QUEST = 3022;
set @QS = 7763;
set @QE = 7916;

delete from creature_queststarter where id=@QS and quest=@QUEST;
insert into creature_queststarter value (@QS,@QUEST);

delete from creature_questender where id=@QE and quest=@QUEST;
insert into creature_questender value (@QE,@QUEST);
