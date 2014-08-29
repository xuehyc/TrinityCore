
-- http://www.wowhead.com/npc=3734	Orc Overseer
-- missing random move

update creature set spawndist=10, MovementType=1 where id=3734;

update creature_text set BroadcastTextId=33316 where entry=3734 and groupid=0 and id=0;
update creature_text set BroadcastTextId=33322 where entry=3734 and groupid=0 and id=1;
update creature_text set BroadcastTextId=33317 where entry=3734 and groupid=0 and id=2;
update creature_text set BroadcastTextId=33320 where entry=3734 and groupid=0 and id=3;
update creature_text set BroadcastTextId=33321 where entry=3734 and groupid=0 and id=4;
update creature_text set BroadcastTextId=33332 where entry=3734 and groupid=1 and id=0;




