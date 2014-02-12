-- Fix for the icy-moonwell, the thankies goes to Paul in the Arkania Forums...
-- this changes the display-id of the object #19260 to 0!
-- no more ice floes in the openworld, YAY!


-- fix for the wrong display-id at object #19260
UPDATE `gameobject_template` SET `displayid`=0 WHERE entry=19260;


-- alternative-version. to use this: only remove the "--" in front of these lines and batch
-- them on your world-database!


-- DELETE FROM `gameobject_template`
-- WHERE `entry`=19260;




--
-- ARKANIANS ARE THE BEST! :)
--
