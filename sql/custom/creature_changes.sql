-- stream
UPDATE `creature` SET `spawntimesecs`= 60 where `id` = 17954;
Delete from `creature_onkill_reputation` where `creature_id` = 17954;
update creature_template set mechanic_immune_mask = 113983323 where entry in (17797,17796,17798);

-- botanika
update creature_template set faction_A = 14, faction_H = 14 where entry = 20078;
update creature_template set faction_A = 14, faction_H = 14 where entry = 20083;
update creature_template set faction_A = 14, faction_H = 14, speed = 0.30 where entry = 19949;
update creature_template set faction_A = 14 , faction_H = 14 where entry = 19919;
update creature_template set faction_A = 14 , faction_H = 14 where entry = 19920;
update creature_template set mechanic_immune_mask = 113983323 where entry in (17976,17975,17978,17980,17977);

-- shattred halls
insert into spell_proc_event 
(entry, SchoolMask, Category, SkillID, SpellFamilyName, SpellFamilyMask, procFlags, ppmRate)
values
(30598, 0, 0, 0, 0, 0, 1, 0);
update creature_template set faction_A = 14, faction_H = 14 where entry in (17357, 17356);
update creature_template set mechanic_immune_mask = 113983323 where entry in (16809,16807,16808);

-- shadowlaby
insert into spell_script_target (entry, type, targetEntry) values (33783, 1, 18732);
delete from creature_template_addon where entry = 18731;

-- mechanar
update creature_template set speed = 0.7, resistance1 = 1000,resistance2 = 1000,resistance3 = 1000,resistance4 = 1000,resistance5 = 1000,resistance6 = 1000, armor = 50000,dmgschool = 2 where entry = 20481;
update creature_template set mechanic_immune_mask = 113983323 where entry in (19219,19221,19220);

-- arcatraz
update creature_template set faction_h = 16 , faction_A = 16, flags = 2, civilian = 0, flag1 = 0, mechanic_immune_mask = -1 where entry  in (21101);
update creature_template set faction_h = 35 , faction_A = 35 where entry = 20904;
update creature_template set minhealth = 12000, maxhealth = 12000  where entry in (21466,21467);
update creature_template set flags = 0,flag1 = 0, mechanic_immune_mask = 113983323 where entry  in (21466,21467,20912);

-- sunwell plateau
update creature_template set minlevel=73,maxlevel=73,armor=4000,mindmg= 10000,maxdmg= 13000,minhealth=3200299,maxhealth=3200299,attackpower = round((maxdmg + mindmg) / 4 * 7),mindmg=round(mindmg - attackpower / 7),maxdmg=round(maxdmg - attackpower / 7) where entry=25165;
update creature_template set minlevel=73,maxlevel=73,armor=3900,mindmg= 6000,maxdmg= 8200,minhealth=3000299,maxhealth=3000299,attackpower = round((maxdmg + mindmg) / 4 * 7),mindmg=round(mindmg - attackpower / 7),maxdmg=round(maxdmg - attackpower / 7) where entry=25166;
update creature_template set faction_A = 14,faction_H = 14,minlevel=73,maxlevel=73,mindmg= 1000,maxdmg= 1300,minhealth=3900,maxhealth=3900,attackpower = round((maxdmg + mindmg) / 4 * 7),mindmg=round(mindmg - attackpower / 7),maxdmg=round(maxdmg - attackpower / 7) where entry=25214;

-- Onyxia
update `creature_template` set mechanic_immune_mask = 113983323 where `entry` = 10184;
update creature set spawntimesecs = 72000 where guid = 47572;

-- quest Phasenverschieben
DELETE FROM `creature_template_addon` WHERE (`entry`=24917);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (24917, 0, 0, 0, 0, 0, 0, 44855);

-- Dragonmaw Peons
delete from creature_template_addon where entry = 22252;

-- insel
update creature_template set flags = 0 where entry in (25002,25001,24999);

