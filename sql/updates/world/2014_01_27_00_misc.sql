
-- quest 13527
update creature_template set npcflag=1,AIName="",ScriptName="npc_decomposing_thistle_bear" where entry=32975;

-- double spawns
DELETE FROM creature WHERE guid IN (78700,130817,79509,79499,79257,96623,131045,78910);
DELETE FROM creature_addon WHERE guid IN (78700,130817,79509,79499,79257,96623,131045,78910);
DELETE FROM creature WHERE guid=15455264;
DELETE FROM creature_addon WHERE guid=15455264;

-- npc not death
update creature_template set unit_flags2=0 where entry=32973;

-- quest 13560 set KillCredit for 2 member
update creature_template set KillCredit1=32852,Health_mod=1 where entry in (33262,33277);

-- insert text from forum
delete from creature_text where entry=34207 and groupid=0;
insert into creature_text values(34207,0,0,"Detonation imminent.",12,0,100,0,0,0,"");
insert into creature_text values(34207,0,1,"Murloc pests, I have come to steal your treasure! Attempt to stop me! Quickly! ",12,0,100,0,0,0,"");
insert into creature_text values(34207,0,2,"I loved that the clockwork robot's name was Foolhardy Adventurer. It would appear that Murlocs are somewhat dense.",12,0,100,0,0,0,"");

-- npc 34207 Foolhardy Adventurer: set values to finish the quest.
update creature_template set VehicleID=79,Spell1=69367,AIName="", ScriptName="" where entry=34207 ;







