
-- darkshore

-- npc's to near the camp. the kill all the questtaker and giver
UPDATE creature SET position_x=7442.825,position_y=-815.0374,position_z=12.52759 WHERE guid=130771;
UPDATE creature SET position_x=7384.054,position_y=-849.795,position_z=18.08809 WHERE guid=130731;
DELETE FROM creature WHERE guid IN (78429,130770,79026,130763,79100);
DELETE FROM creature_addon WHERE guid IN (78429,130770,79026,130763,79100);

-- 13558 autocomplete
UPDATE quest_template SET Method=2,RequiredItemId1=44929,RequiredItemId2=0,RequiredItemCount1=1,RequiredItemCount2=0 WHERE Id=13558;

-- npc 34331 spawned with zero values
update creature_template set minlevel=20,maxlevel=20,faction_A=2153,faction_H=2153,mindmg=55.1,maxdmg=74.1,attackpower=133,dmg_multiplier=1,minrangedmg=38,maxrangedmg=57 where entry = 34331;

-- ToDo: quest 13891 item 46370 uses for 'destroy the devouring artifact.' 

--
-- quest 13515 Ending the Threat
--
-- npc 33178 Huntress Sandrya Moonfall
set @entry=33178;
delete from creature_text where entry=@entry and groupid=0 and id=0;
delete from creature_text where entry=@entry and groupid=1 and id=0;
delete from creature_text where entry=@entry and groupid=2 and id=0;
insert into creature_text values (@entry,0,0,"I've shattered the shield protecting their leader! Quickly, kill him!",14,0,100,0,0,0,"");
insert into creature_text values (@entry,1,0,"Let me know when you are ready to begin the attack.",12,0,100,0,0,0,"");
insert into creature_text values (@entry,2,0,"Let us put an end to this Shatterspear threat for good. Sentinels, attack now!",12,0,100,0,0,0,"");

update creature_template set npcflag=3,gossip_menu_id=0,AIName="",ScriptName="npc_huntress_sandrya_moonfall" where entry=@entry; 
delete from gossip_menu where entry in (50786,50787);
insert into gossip_menu values (50786,50001);
insert into gossip_menu values (50787,50002);
delete from npc_text where ID in (50001,50002);
insert into npc_text set ID=50001, text0_0="Let me know when you are ready to begin the attack.";
insert into npc_text set ID=50002, text0_0="We must waiting until Jor'kil the Soulripper is back again.";
delete from gossip_menu_option where menu_id=50786;
insert into gossip_menu_option values (50786,0,0,"I am ready. Begin the attack.",1,1,0,0,0,0,"");

--
-- quest 13907 Sweeping Clean the Ruins
--
UPDATE quest_template SET Method=2 WHERE Id=13907;
update creature_template set KillCredit1=34344 where entry in (2207,34339);	

--
-- quest 13912 Sweeping Clean the Ruins
--
UPDATE quest_template SET Method=2 WHERE Id=13912;
update gameobject_template set data1=195054,data8=13907 where entry=195054;
delete from gameobject_loot_template where entry=195054 and item=46386;
insert into gameobject_loot_template values (195054,46386,-100,1,0,1,1);

--
-- quest 13911 The Absent-Minded Prospector
--
-- wrong queststarter
delete from creature_queststarter where id=34342 and quest=13911;
-- ToDo: the quest itself is maybe a escord quest, i don't the target..

--
-- quest 13909 Got Some Flotsam?
--
-- autocomplete
UPDATE quest_template SET Method=2 WHERE Id=13909;

--
-- quest 13910 A New Home
--
-- only spawned from script
delete from gameobject where guid in (183268,183269,183270,216194);
-- spell needed to build 
delete from spell_script_names where spell_id=65273;
insert into spell_script_names values (65273,"spell_constructing");

--
-- quest 13526
--
-- autocomplete
UPDATE quest_template SET Method=2 WHERE Id=13526;
update gameobject_template set data8=13526 where entry=194100;
update gameobject_loot_template set ChanceOrQuestChance=-100 where entry=194100 and item=44850;

--
-- quest 13572
--
-- autocomplete and no target
UPDATE quest_template SET Method=2,RequiredNpcOrGo1=-194150,RequiredNpcOrGoCount1=8 WHERE Id=13572;

--
-- quest 13544
--
-- you need item Fleetfoot's Tailfeathers as reagent
delete from creature_loot_template where entry=32997 and item=44886;
insert into creature_loot_template values(32997,44886,-100,1,0,1,1);

--
-- quest 13545
--
-- npc 33000 Spirit of Corruption is spawned by spell 
delete from creature where id=33000;
update creature_template set minlevel=19,maxlevel=19,faction_A=82,faction_H=82,mindmg=31.2,maxdmg=40.8,attackpower=72,minrangedmg=21.6,maxrangedmg=31.2,rangedattackpower=5 where entry=33000;
set @entry=33044;
delete from creature_text where entry=@entry and groupid=1 and id=0;
insert into creature_text values (@entry,1,0,"Thank you for saving me, stranger.",12,0,100,0,0,0,"");
-- the npc 33044 you're heal should be a short time frendly after spell 62092..
update creature_template set AIName="",ScriptName="npc_corrupted_blackwood" where entry=@entry;

-- ToDo: core bug: the spell 62092 works allways, not only on 33044, and 33044 is not friendly after spellhit

--
-- quest 13899
--
-- npc 34423 has aura death
set @entry=34423;
update creature_addon set auras="" where guid=78163;
update creature_template_addon set auras="" where entry=@entry;
-- Warlord Wrathspine dies and goes freindly at 1% life left.
update creature_template set AIName="",ScriptName="npc_warlord_wrathspine" where entry=@entry;

--
-- quest 13900
--
-- malfurion 34422 is spawned from script
delete from creature where guid=134826;
set @entry=34422;
delete from creature_text where entry=@entry and groupid=1 and id=0;
insert into creature_text values (@entry,1,0,"It's over Azshara! You and your naga will return to the bottom of the seas where you belong!",14,0,100,0,0,0,"");
delete from creature_text where entry=@entry and groupid=2 and id=0;
insert into creature_text values (@entry,2,0,"She's not lying. Nordrassil is in danger. I must make haste and prepare for Hyjal's defense.",12,0,100,0,0,0,"");
delete from creature_text where entry=@entry and groupid=3 and id=0;
insert into creature_text values (@entry,3,0,"It will be up to you to use the Horn of the Ancients and stop Soggoth's return.",12,0,100,0,0,0,"");

-- npc 34416 Queen Azshara 
set @entry=34416;
delete from creature_text where entry=@entry and groupid=1 and id=0;
insert into creature_text values (@entry,1,0,"Who dares oppose Queen Azshara? You will soon beg for a swift death!",14,0,100,0,0,0,"");
delete from creature_text where entry=@entry and groupid=2 and id=0;
insert into creature_text values (@entry,2,0,"Ah... Malfurion Stormrage. I'd hoped to keep you occupied for a little longer. It was my goal to keep you away from Hyjal while my allies attacked. It would seem I have succeeded.",12,0,100,0,0,0,"");
delete from creature_text where entry=@entry and groupid=3 and id=0;
insert into creature_text values (@entry,3,0,"I've no need to fight you, for it appears I've already won. You cannot stop our attack on Darkshore and save Hyjal at the same time!",12,0,100,0,0,0,"");





