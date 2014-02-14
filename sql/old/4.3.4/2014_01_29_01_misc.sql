
-- quest  13945  -- npc 2010
update creature_template set KillCredit1=2010 where entry=2011;
update creature_template set KillCredit1=2010 where entry=2009;

-- move creature
UPDATE creature SET position_x=9857.169,position_y=1565.682,position_z=1329.167 WHERE guid=142338;

-- quest 13560 autocomplete
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=13560;

-- quest 26383 wrong queststarter and questender
delete from creature_questender where id=49478 and quest=26383;
delete from creature_queststarter where id=49478 and quest=26383;
delete from gameobject_queststarter where id=207321 and quest=26383;
UPDATE quest_template SET RequestItemsText="", EndText="Travel to Dentaria Silverglade in Lor'danel" WHERE Id=26383;

-- npc 32972, 32973  are invisible
update creature_template_addon set auras="" where entry in (32972,32973);
update creature_addon set auras="" where guid in (78306,78768);

-- quest 13521  autocomplete
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=13521;

-- more npc invisible 33093,32911,33095,33094,32973
update creature_template_addon set auras="" where entry in (33093,32911,33095,33094);
-- she should also look death
update creature_template set npcflag=1,unit_flags2=2049,dynamicflags=0 where entry in (33093,32911,33095,33094);

update creature_template set AIName="", ScriptName="npc_cerellean_whiteclaw" where entry=33093;
update creature_template set AIName="", ScriptName="npc_gershala_nightwhisper" where entry=32911;
update creature_template set AIName="", ScriptName="npc_shaldyn" where entry=33095;
update creature_template set AIName="", ScriptName="npc_volcor" where entry=33094;

set @entry=33093;
delete from creature_text where entry=@entry and groupid=0 and id in(0,1);
insert into creature_text values(@entry,0,0,"How, my love? How will I find the strength to face the ages of the world without you by my side...",12,0,100,0,0,0,"");
insert into creature_text values(@entry,0,1,"That the fates should be so cruel as to permit us only this after a thousand years apart...",12,0,100,0,0,0,"");

-- npc is in cage, no move
update creature set spawndist=0, MovementType=0 where id=33024;










