
-- npc 49340
set @ENTRY=49340;
update creature_template set npcflag=1,AIName="",ScriptName="npc_scarlet_corpse" where entry=@ENTRY;
delete from smart_scripts where entryorguid=@ENTRY;

-- quest 24964
update quest_template set RequiredNpcOrGo1=44175 where ID=24964;

-- npc 44794
update  creature_template set AIName="", KillCredit1=44175 where entry=44794;

-- npc 38910
set @ENTRY=38910;
update creature_template set npcflag=1,AIName="",ScriptName="npc_lilian_voss" where entry=@ENTRY;
delete from creature_text where entry=@ENTRY;
insert into creature_text values(@ENTRY,0,0,"You don't understand... I CAN'T be undead! Not me, not now...",12,0,100,0,0,0,"");
delete from waypoint_data where id=@ENTRY;
insert into waypoint_data values (@ENTRY,0,1860.566,1557.157,94.786,0,0,0,0,100,0);
insert into waypoint_data values (@ENTRY,1,1860.619,1606.896,95.162,0,0,0,0,100,0);
update creature_addon set path_id=@ENTRY where guid=50783;
delete from smart_scripts where entryorguid=@ENTRY;

-- npc 49230 marshal redpath
set @ENTRY=49230;
update creature_template set npcflag=1,AIName="",ScriptName="npc_marshal_redpath" where entry=@ENTRY;
delete from smart_scripts where entryorguid=@ENTRY;

-- npc 49231 Valdred Moray
set @ENTRY=49231;
update creature_template set npcflag=1,AIName="",ScriptName="npc_valdred_moray" where entry=@ENTRY;
delete from smart_scripts where entryorguid=@ENTRY;

-- npc 38895 lilian voss
set @ENTRY=38895;
update creature_template set npcflag=1,AIName="",ScriptName="npc_lilian_voss" where entry=@ENTRY;
delete from smart_scripts where entryorguid=@ENTRY;

-- npc=49129  banshee
set @GUID=36655;
update creature set spawndist=15,MovementType=1 where guid=@GUID;

-- npc=50372  banshee aradne
set @GUID=37194;
set @ENTRY=50372; 
update creature set position_x=1685.8,position_y=1684.4,spawndist=10,MovementType=1 where guid=@GUID;

delete from creature_text where entry=@ENTRY;
insert into creature_text values (@ENTRY,0,0,"You are returned to life. The Banshee Queen asks for your service.",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,1,"Rise from the grave and serve the Dark Lady!",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,2,"Waken, sleeper. Your new life awaits.",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,3,"Waken, sleeper.",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,4,"Rise from Death's slumber and join your brothers!",12,0,100,0,0,0,"");
					
-- npc 50374  NPC_RISEN_DEAD
set @ENTRY=50374; 
delete from creature_text where entry=@ENTRY;
insert into creature_text values (@ENTRY,0,0,"I never asked for this! Leave me alone!",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,1,"What...what's happening to me? Why have you done this to me?",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,2,"I should be dead and to death I will return!",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,1,0,"If the Banshee Queen has offered me this chance, I will gladly serve.",12,0,100,0,0,0,"");

-- npc 49422 Rotbrain Berserker
set @ENTRY=49422;
update creature_template set npcflag=0,unit_flags=0,AIName="",ScriptName="npc_rotbrain_berserker" where entry=@ENTRY;
delete from smart_scripts where entryorguid=@ENTRY;
delete from creature_text where entry=@ENTRY;
insert into creature_text values (@ENTRY,0,0,"I'll kill you!",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,1,"Look what they've done to me!",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,2,"Who am I?",12,0,100,0,0,0,"");

-- npc 49423  Rotbrain Magus
set @ENTRY=49423;
update creature_template set faction_A=7,faction_H=7,npcflag=0,unit_flags=512,AIName="",ScriptName="npc_rotbrain_magus" where entry=@ENTRY;
delete from smart_scripts where entryorguid=@ENTRY;
delete from creature_text where entry=@ENTRY;
insert into creature_text values (@ENTRY,0,0,"I'll kill you!",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,1,"Look what they've done to me!",12,0,100,0,0,0,"");
insert into creature_text values (@ENTRY,0,2,"Who am I?",12,0,100,0,0,0,"");

-- npc 49424 Marshal Redpath
set @ENTRY=49424;
update creature_template set npcflag=0,unit_flags=32768,AIName="",ScriptName="npc_marshal_redpath" where entry=@ENTRY;
delete from smart_scripts where entryorguid=@ENTRY;
delete from creature_text where entry=@ENTRY;
insert into creature_text values (@ENTRY,0,0,"BLEEAAAGGHHH! I'm a monster, don't look at me!",12,0,100,0,0,0,"");

-- npc 49428  Deathguard Protector
set @ENTRY=49428;
update creature_template set npcflag=0,unit_flags=512,AIName="",ScriptName="npc_deathguard_protector" where entry=@ENTRY;
delete from smart_scripts where entryorguid=@ENTRY;

-- quest 24965 magic training
UPDATE quest_template SET RequiredNpcOrGo1=44175 WHERE Id=24965;

-- 24967 stab!
UPDATE quest_template SET Method=2,RequiredNpcOrGo1=44175 WHERE Id=24967;

-- 24972 Vital Intelligence
UPDATE quest_template SET Flags=524288,SpecialFlags=4 WHERE Id=24972;
-- 25033 blocks the quest 24972
UPDATE quest_template SET NextQuestId=0 WHERE Id=25033;



