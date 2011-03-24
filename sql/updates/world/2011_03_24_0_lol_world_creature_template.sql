-- Workaround for Quest 10722 Meeting at the Blackwing Coven
UPDATE creature_template SET gossip_menu_id = 22019 WHERE entry = 22019;
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = 22019;
DELETE FROM npc_text WHERE ID = 22019;
INSERT INTO npc_text VALUES
(22019,'Welcome to the Blackwing Coven $c.', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
DELETE FROM gossip_menu WHERE entry = 22019;
INSERT INTO gossip_menu VALUES
(22019,22019);
DELETE FROM gossip_menu_option WHERE menu_id = 22019;
INSERT INTO gossip_menu_option VALUES
(22019,0,0,'It´s over now!',1,1,0,0,0,0,0,'');
DELETE FROM smart_scripts WHERE entryorguid IN (22019,2201900);
INSERT INTO smart_scripts VALUES
(22019, 0, 0, 0, 62, 0, 100, 0, 22019, 0, 0, 0, 80, 2201900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'run script on select gossip'),
(22019, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on aggro cast enrage'),
(22019, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 37704, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'on aggro cast whirlwind'),
(2201900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'close gossip menu'),
(2201900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 15, 10722, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'give quest credit'),
(2201900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 38157, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'remove Overseer Disguise from player');
