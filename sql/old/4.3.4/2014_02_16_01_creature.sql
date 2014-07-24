-- This fixes some wrong spawn positions for the Love Is In The Air NPC's

-- Orgrimmar
UPDATE `creature` SET `position_x`='1591.91', `position_y`='-4429.13', `position_z`='15.9042', `orientation`='1.62223' WHERE guid=126475;
UPDATE `creature` SET `position_x`='1593.51', `position_y`='-4429.03', `position_z`='15.8463', `orientation`='1.25907' WHERE guid=126461;
UPDATE `creature` SET `position_x`='1588.74', `position_y`='-4426.96', `position_z`='14.491', `orientation`='0.6947' WHERE guid=126464;

-- Stormwind
UPDATE `creature` SET `position_x`='-8868.9', `position_y`='638.812', `position_z`='97.2971', `orientation`='0.952711' WHERE guid=69;
UPDATE `creature` SET `position_x`='-8867.35', `position_y`='637.152', `position_z`='97.2971', `orientation`='0.696211' WHERE guid=67;
