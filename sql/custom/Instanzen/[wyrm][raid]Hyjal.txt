-- Wrong HP Amount ... Banshee
UPDATE creature_template SET minhealth = 83835 , maxhealth = 83835 WHERE entry = 17905;
-- Immunetiys
UPDATE `creature_template` SET `mechanic_immune_mask` = 131073 WHERE `entry` = 17818;
UPDATE creature_template SET `mechanic_immune_mask` = 650854235 WHERE entry in (17767,17808,17888,17842,17968);
-- Doomfire too fast
UPDATE creature_template SET speed = 0.3 WHERE entry = 18095;

-- Hyjal Doors ... Faction 14 (not clickable)
update gameobject_template set faction = 14 where entry in (182060,182061);

insert into `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) 
values('534001','182061','534','1','4205.31','-4114.39','877.59','1.82067','0','0','0.789709','0.613482','25','0','1');
insert into `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) 
values('534002','182060','534','1','4270.31','-4144.08','870.091','0.01198','0','0','0.00598994','0.999982','25','0','1');


-- 4398	8969  	Rage Winterchill
-- 4888 9966	Anetheron
-- 8309 16942	Azgalor
-- 4888 9966	Kaz'rogal
-- 8064 16443	Archimonde

 UPDATE creature_template SET
 mindmg = mindmg + (attackpower / 7),
 maxdmg = maxdmg + (attackpower / 7)
-- attackpower = attackpower * 1.5
 where entry in (17767,17808,17888,17842,17968)


-- Einige Anpassungen
UPDATE creature_template SET `mechanic_immune_mask` = 42467344 WHERE entry in (17906,17907);

UPDATE `creature_template` SET `mechanic_immune_mask` = 650854399, attackpower = 96887 WHERE `entry` = 17968;
-- UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, attackpower = 85776 WHERE `entry` = 17968;


-- Archimonde
-- update creature_template set mindmg = 8064, maxdmg = 16443, attackpower = 85776 where entry = 17968;
update creature_template set mindmg = 17064, maxdmg = 25443, attackpower = 94776 where entry = 17968;
