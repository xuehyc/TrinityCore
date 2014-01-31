 
-- darkshore

-- npc 34328 zero values
update creature_template set minlevel=20,maxlevel=20,faction_A=7,faction_H=7,mindmg=55.1,maxdmg=74.1,attackpower=133,minrangedmg=38,maxrangedmg=57 where entry=34328;

-- quest 13899 disabled and no target 34423
UPDATE quest_template SET Method=2,RequiredNpcOrGo1=34423,RequiredNpcOrGoCount1=1 WHERE Id=13899;

-- insert text from wowhead
delete from creature_text where entry=34423 and groupid=0 and id=0;
insert into creature_text values(34423,0,0,"You are too late... the relic is being offered to Azshara above us as we speak!",12,0,100,0,0,0,"");

-- quest 13885 In Defense of Darkshore
-- flight quest.. no info about vehicle and spell.. autocomplete
UPDATE quest_template SET Method=0,Flags=65536 WHERE Id=13885;

-- quest 4725 Beached Sea Turtle object=176198
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=4725;
delete from gameobject_queststarter where id=176198 and quest=4725;
insert into gameobject_queststarter values (176198,4725);
delete from creature_questender where id=10219 and quest=4725;
insert into creature_questender values (10219,4725);

-- quest 
delete from spell_script_names where spell_id=62624;
insert into spell_script_names values (62624,"spell_torch_shatterspear_supplies");

-- quest and  wrong queststarter
delete from creature_queststarter where id=33178 and quest=13590;
delete from creature_queststarter where id=32963 and quest=13589;
delete from creature_queststarter where id=32963 and quest=13506;

-- npc 32861 32863,32858 wrong dead aura ToDO: bug in core? he is emote mining (233) on aggro to
update creature_template_addon set auras="" where entry in (32861,32863,32858);
update creature_addon set auras="" where guid in (SELECT guid FROM creature WHERE id in (32861,32863,32858));

-- insert text from wowhead
delete from creature_text where entry=32861 and groupid=1;
insert into creature_text values(32861,1,0,"Ah, I be needin' a new shrunken head....",12,0,100,0,0,0,"");
insert into creature_text values(32861,1,1,"De Shatterspears own dese lands, and ya not be welcome!",12,0,100,0,0,0,"");
insert into creature_text values(32861,1,2,"I be movin' to de groove; ya be movin' to de grave!",12,0,100,0,0,0,"");
insert into creature_text values(32861,1,3,"I be stabbin' first and askin' later!",12,0,100,0,0,0,"");
insert into creature_text values(32861,1,4,"Killin' time!",12,0,100,0,0,0,"");
insert into creature_text values(32861,1,5,"Relax, mon, I be makin' dis quick.",12,0,100,0,0,0,"");
insert into creature_text values(32861,1,6,"We gonna be dancin' on ya grave tonight, mon!",12,0,100,0,0,0,"");
insert into creature_text values(32861,1,7,"Ya be trespassin' on our land now, mon.",12,0,100,0,0,0,"");

-- quest loot not set
update gameobject_template set data0=57,data1=194089 where entry=194089;
update gameobject_template set data0=57,data1=194090 where entry=194090;
delete from gameobject_loot_template where entry in (194089,194090);
insert into gameobject_loot_template values (194089,44830,-100,1,0,1,1);
insert into gameobject_loot_template values (194090,44830,-100,1,0,1,1);

-- quest loot id data1 wrong
update gameobject_template set data1=194787,data8=13844 where entry=194787;

-- npc 11196 and 10919 spawned in wrong place/phase 
update creature set phaseMask=2 where id in (11196,10919);

-- npc 33071 looks dead, elite values
update creature_template set mindmg=17.6,maxdmg=24.2,attackpower=24, unit_flags=32768,unit_flags2=2048, dynamicflags=2048,minrangedmg=16.5,maxrangedmg=23.1 where entry=33071;

-- npc 32862 is level 15 elite but has elite boss values
update creature_template set mindmg=17.6,maxdmg=24.2,attackpower=24, unit_flags=32768,unit_flags2=2048, dynamicflags=2048,minrangedmg=16.5,maxrangedmg=23.1 where entry=32862;


