
-- quests autocomplete
UPDATE quest_template SET Flags=262152 WHERE Id=13892;
UPDATE quest_template SET RequiredSourceItemId1=46696,RequiredSourceItemId2=0,RequiredSourceItemCount1=1 WHERE Id=13892;
UPDATE quest_template SET Method=2 WHERE Id=13526;
UPDATE quest_template SET Method=2 WHERE Id=13572;
UPDATE quest_template SET Method=2,Flags=0,RequiredSourceItemId1=46696,RequiredSourceItemId2=0,RequiredSourceItemCount1=1 WHERE Id=13948;
UPDATE quest_template SET Method=2 WHERE Id=13912;
UPDATE quest_template SET Method=2 WHERE Id=13907;

-- text npc 34405 from wowhead
delete from creature_text where entry=34405 and groupid=1 and id between 0 and 8;
insert into creature_text values (34405,1,0,"I can smell your fear, $C!",12,0,100,0,0,0,"");
insert into creature_text values (34405,1,1,"Masters, I  pledge this $R to you!",12,0,100,0,0,0,"");
insert into creature_text values (34405,1,2,"Carnage! May I spill blood in His name!",12,0,100,0,0,0,"");
insert into creature_text values (34405,1,3,"Death comes! Rejoice!",12,0,100,0,0,0,"");
insert into creature_text values (34405,1,4,"Embrace the end!",12,0,100,0,0,0,"");
insert into creature_text values (34405,1,5,"For our Masters!",12,0,100,0,0,0,"");
insert into creature_text values (34405,1,6,"Intruders! Good, I was getting bored...",12,0,100,0,0,0,"");
insert into creature_text values (34405,1,7,"Intruders! Slay them!",12,0,100,0,0,0,"");
delete from creature_text where entry=34405 and groupid=2 and id=0;
insert into creature_text values (34405,2,0,"Why are we digging this thing up anyway, boss?",12,0,100,0,0,0,"");

-- text npc 34485 from wowhead
delete from creature_text where entry=34485 and groupid=0 and id=0;
insert into creature_text values (34485,0,0,"I will devour your souls, insolent mortals!",14,0,100,0,0,0,"");
 
 -- npc has zero values
update creature_template set minlevel=20,maxlevel=20,faction_A=74,faction_H=74,rank=1,mindmg=55.4,maxdmg=74.1,attackpower=133,dmg_multiplier=1,minrangedmg=38,maxrangedmg=57,rangedattackpower=5 where entry=34485;
 
-- text npc 34406 from wowhead
delete from creature_text where entry=34406 and groupid=0 and id=0;
insert into creature_text values (34406,0,0,"Watch your tongue, worm. You will not refer to Soggoth the Slitherer as 'that thing' or you'll find yourself eating your own heart for dinner.",14,0,100,0,0,0,"");
delete from creature_text where entry=34406 and groupid=1 and id=0;
insert into creature_text values (34406,1,0,"Now, back to work! Your superiors are watching from the outlook above and they do not take kindly to idleness!",14,0,100,0,0,0,"");

-- text npc 34427 from wowhead
delete from creature_text where entry=34427 and groupid=0 and id=0;
insert into creature_text values (34427,0,0,"Not quite. We shall need a great many offerings of sacrifice before the Herald of the Old Gods roams the land again.",14,0,100,0,0,0,"");

-- insert scriptname for quest 13892: npc 34406 and  34405
update creature_template set AIName="",ScriptName="npc_twilight_worker" where entry=34405;
update creature_template set AIName="",ScriptName="npc_foreman_balsoth" where entry=34406;

-- insert scriptname for quest 13948: npc 34427 
update creature_template set AIName="",ScriptName="npc_thalya_the_voidcaller" where entry=34427;

-- wrong queststarter
delete from creature_queststarter where id=34402 and quest=13953;

-- npc 3616 onu, ther is no test and no gossip text for him
update creature_template set npcflag=3,AIName="",ScriptName="npc_onu" where entry=3616;

-- npc 2237 no random move
update creature set SpawnDist=10,MovementType=1 where id=2237;

-- npc 34331 has zero values
update creature_template set minlevel=20,maxlevel=20,faction_A=2135,faction_H=2135,rank=0,mindmg=55.4,maxdmg=74.1,attackpower=133,dmg_multiplier=1,minrangedmg=38,maxrangedmg=57,rangedattackpower=5 where entry=34331;

-- quest 13882 disabled
UPDATE quest_template SET SourceSpellId=65125,RequiredSpell=65125 WHERE Id=13882;

-- npc 34306 no gossip flag and smartscript
update creature_template set npcflag=1,AIName="",ScriptName="npc_darkshore_wisp" where entry=34306;

-- quest 13911 wrong queststarter
delete from creature_queststarter where id=34342 and quest=13911;

-- quest 13897
UPDATE quest_template SET RequiredSourceItemId1=58365,RequiredSourceItemId2=0,RequiredSourceItemCount1=1 WHERE Id=13897; 

-- quest 13897..  spell 80230 bug in core.. 












