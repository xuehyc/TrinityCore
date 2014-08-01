

-- http://www.wowhead.com/npc=52224 Jungle Serpent:  is in wrong phase 2
update creature set phaseMask=1 where id=52224;

-- http://www.wowhead.com/npc=48797  Gim'hila  wrong faction
update creature_template set faction=2160 where entry=48797;

-- http://www.wowhead.com/quest=25147 
-- http://de.wowhead.com/npc=44175 the requirement is not to kill the dummy, but to practice spell!!!!!! 
update quest_template set RequiredNpcOrGo1=44175 where Id in (25147,25139,24141);
UPDATE quest_template SET RequiredNpcOrGo1=44175,RequiredNpcOrGo2=0,RequiredNpcOrGoCount1=3,RequiredNpcOrGoCount2=0 WHERE Id=14010;
UPDATE quest_template SET RequiredNpcOrGo1=44175,RequiredNpcOrGo2=0,RequiredNpcOrGoCount1=3,RequiredNpcOrGoCount2=0 WHERE Id=14009;
UPDATE quest_template SET RequiredNpcOrGo2=0,RequiredNpcOrGoCount2=0,RequiredSpell=0 WHERE Id=27023;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=24766;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=26274;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=24752;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=26200;
UPDATE quest_template SET RequiredNpcOrGo2=0,RequiredNpcOrGoCount2=0,RequiredSpell=0 WHERE Id=24528;
UPDATE quest_template SET RequiredNpcOrGo2=0,RequiredNpcOrGoCount2=0 WHERE Id=26918;
UPDATE quest_template SET RequiredNpcOrGo2=0,RequiredNpcOrGoCount2=0 WHERE Id=26966;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=26201;
UPDATE quest_template SET RequiredNpcOrGo2=0,RequiredNpcOrGoCount2=0 WHERE Id=10069;
UPDATE quest_template SET RequiredNpcOrGo1=44175,RequiredSpell=0 WHERE Id=24968;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=10068;
UPDATE quest_template SET RequiredNpcOrGo1=44175,RequiredNpcOrGo2=0,RequiredNpcOrGoCount1=2,RequiredNpcOrGoCount2=0 WHERE Id=14008;
UPDATE quest_template SET RequiredNpcOrGo1=44175 WHERE Id=25149;
UPDATE quest_template SET RequiredNpcOrGo1=44175 WHERE Id=24969;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=26948;
UPDATE quest_template SET RequiredNpcOrGo1=44175 WHERE Id=27067;
UPDATE quest_template SET RequiredNpcOrGo1=44175,RequiredNpcOrGo2=0,RequiredNpcOrGoCount1=1,RequiredNpcOrGoCount2=0 WHERE Id=14013;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=14274;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=10073;
UPDATE quest_template SET RequiredNpcOrGo1=44175,RequiredNpcOrGo2=0,RequiredNpcOrGoCount1=3,RequiredNpcOrGoCount2=0,RequiredSpell=0 WHERE Id=14012;
UPDATE quest_template SET RequiredNpcOrGo1=44175,RequiredSpell=0 WHERE Id=25145;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=26904;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=26914;
UPDATE quest_template SET RequiredNpcOrGo2=0,RequiredNpcOrGoCount2=0,RequiredSpell=0 WHERE Id=26966;
UPDATE quest_template SET RequiredSpell=0 WHERE Id=24533;
UPDATE quest_template SET RequiredNpcOrGo1=44175 WHERE Id=25139;
UPDATE quest_template SET RequiredSpell=0 WHERE Id in (10072,14009,14279,24784,24966,26919,26949,26970,27066);
update quest_template set Method=2,RequiredRaces=8 where Id=14279;

-- take care for wronq quest spell and wrong quest description/goal 
update creature_template set AIName="",ScriptName="npc_wounded_sentinel" where entry=44617;
update creature_template set AIName="",ScriptName="npc_trainings_dummy" where entry=44389;

-- infantrie has no sword in fight
delete from creature_equip_template where entry=49869 and id=1;
insert into creature_equip_template values (49869,1,1899,143,2551,18019);

-- infantrie and word are not pacifistic
update creature_template set unit_flags=0 where entry in (49869,49871);
update creature set unit_flags=0 where id in (49869,49871);

-- broadcastid for paxton
update creature_text set BroadcastTextId=49890 where entry=951 and groupid=0 and id=0;
update creature_text set BroadcastTextId=49889 where entry=951 and groupid=0 and id=1;
update creature_text set BroadcastTextId=49892 where entry=951 and groupid=0 and id=2;
update creature_text set BroadcastTextId=49893 where entry=951 and groupid=0 and id=3;
update creature_text set BroadcastTextId=49891 where entry=951 and groupid=0 and id=4;

-- http://www.wowhead.com/npc=50378  remove invisible id
update creature_template set modelid2=0 where entry=50378;

-- http://www.wowhead.com/npc=50039  Goblin Assassin  he snakes
update creature_template_addon set auras=93046 where entry=50039;



