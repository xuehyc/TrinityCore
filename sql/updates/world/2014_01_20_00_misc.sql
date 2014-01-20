
-- quest 9452
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=9452;

-- quest 9565
UPDATE quest_template SET Flags=0 WHERE Id=9565;

-- wrong queststarter
delete from creature_queststarter where id=17440 and quest=9622;

-- quest 9531 autocomplete
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=9531;

-- http://www.wowhead.com/npc=17243  Engineer "Spark" Overgrind <Envoy of Mekkatorque>
-- http://www.youtube.com/watch?v=mp6dCb75duI&list=PLWqSsdqz6BYFtH3NIwNkaIiKJKD9ERxg2
set @ENTRY=17243;
delete from creature_text where groupid>7;
insert into creature_text values (@ENTRY,8,0,"Does it frighten you to know that there are those that would serve the Legion with such devotion as to remain unwavering citizens of your pointless civilizations until called upon?",12,0,100,0,0,0,"spark text on fight");
insert into creature_text values (@ENTRY,9,0,"Live in fear, die by the will of Kael'thas... It's all the same.",12,0,100,0,0,0,"spark text on fight");
insert into creature_text values (@ENTRY,10,0,"And now, I cut you!",12,0,100,0,0,0,"spark text on fight");
insert into creature_text values (@ENTRY,11,0,"DIE!",12,0,100,0,0,0,"spark text on fight");
insert into creature_text values (@ENTRY,12,0,"I wonder if you can really hear the ocean in these things.",12,0,100,0,0,0,"spark text on emote shell");

-- quest 9565
UPDATE quest_template SET Method=2 WHERE Id=9565;

-- wrong random waypoint, maybe path is bether
update creature set spawndist=0, MovementType=0 where guid in (162019,192003);































