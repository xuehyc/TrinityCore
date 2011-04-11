-- FiX: get lost quest items on gossip with conditions
-- +-----------------+
-- |creature_template|
-- +-----------------+
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry IN (21772,21774,21769,21773,28518,26117,24186,24273,22127,28138,29937,29650);
UPDATE creature_template SET gossip_menu_id = 21772, npcflag = npcflag | 1 WHERE entry = 21772;       -- Chief Apothecary Hildagard
UPDATE creature_template SET gossip_menu_id = 21774, npcflag = npcflag | 1 WHERE entry = 21774;       -- Zorus the Judicator
UPDATE creature_template SET gossip_menu_id = 21769, npcflag = npcflag | 1 WHERE entry = 21769;       -- Overlord Or'barokh
UPDATE creature_template SET gossip_menu_id = 21773, npcflag = npcflag | 1 WHERE entry = 21773;       -- Thane Yoregar
UPDATE creature_template SET gossip_menu_id =  9709, npcflag = npcflag | 1 WHERE entry = 28518;       -- Stefan Vadu
UPDATE creature_template SET gossip_menu_id =  9253, npcflag = npcflag | 1 WHERE entry = 26117;       -- Raelorasz
UPDATE creature_template SET gossip_menu_id =  8908, npcflag = npcflag | 1 WHERE entry = 24186;       -- Sage Mistwalker
UPDATE creature_template SET gossip_menu_id =  8918, npcflag = npcflag | 1 WHERE entry = 24273;       -- Watcher Moonleaf
UPDATE creature_template SET gossip_menu_id = 22127, npcflag = npcflag | 1 WHERE entry = 22127;       -- Wildlord Antelarion
UPDATE creature_template SET gossip_menu_id = 28138, npcflag = npcflag | 1 WHERE entry = 28138;       -- Elder Harkek
UPDATE creature_template SET gossip_menu_id = 29937, npcflag = npcflag | 1 WHERE entry = 29937;       -- Moteha Windkind
UPDATE creature_template SET gossip_menu_id = 9929, npcflag = npcflag | 1 WHERE entry = 29650;        -- Archaeologist Andorin 
-- +-----------+
-- |gossip_menu|
-- +-----------+
DELETE FROM gossip_menu WHERE entry IN (21772,21774,21769,21773,9709,9253,8908,8918,22127,28138,29937,9929);
INSERT INTO gossip_menu VALUES
(21772,1),      -- Chief Apothecary Hildagard
(21774,1),      -- Zorus the Judicator
(21769,1),      -- Overlord Or'barokh
(21773,1),      -- Thane Yoregar
(9709,13270),   -- Stefan Vadu
(9253,12592),   -- Raelorasz
(8908,11756),   -- Sage Mistwalker
(8918,11858),   -- Watcher Moonleaf
(22127,1),      -- Wildlord Anterarion
(28138,1),      -- Elder Harkek
(29937,1),      -- Moteha Windkind
(9929,1);       -- Archaeologist Andorin
-- +------------------+
-- |gossip_menu_option|
-- +------------------+
DELETE FROM gossip_menu_option WHERE menu_id IN (21772,21774,21769,21773,9709,9253,8908,8918,22127,28138,29937,9929);
INSERT INTO gossip_menu_option VALUES
-- Chief Apothecary Hildagard
(21772,0,0,'Please, give me a new Spectrecles.',1,1,0,0,0,0,0,''),
-- Zorus the Judicator
(21774,0,0,'Please, give me a new Spectrecles.',1,1,0,0,0,0,0,''),
-- Overlord Or'barokh
(21769,0,0,'Please, give me a new Kor큝ron Flare Gun.',1,1,0,0,0,0,0,''),
-- Thane Yoregar
(21773,0,0,'Please, give me a new Wildhammer Flare Gun.',1,1,0,0,0,0,0,''),
-- Stefan Vadu
(9709,0,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
(9709,1,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
(9709,2,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
(9709,3,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
(9709,4,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
-- Raelorasz
(9253,0,0,'What is the cause of this conflict?',1,1,9283,0,0,0,0,''),
(9253,1,0,'Please, give me a new Augmented Arcane Prison.',1,1,0,0,0,0,0,''),
-- Sage Mistwalker (H)
(8908,0,0,'Please, give me a new Worg Disguise.',1,1,0,0,0,0,0,''),
(8908,1,0,'Please, give me a new Worg Disguise.',1,1,0,0,0,0,0,''),
-- Watcher Moonleaf (A)
(8918,0,0,'Please, give me a new Worg Disguise.',1,1,0,0,0,0,0,''),
(8918,1,0,'Please, give me a new Worg Disguise.',1,1,0,0,0,0,0,''),
-- Wildlord Anterarion
(22127,0,0,'Please, give me a new Felsworn Gas Mask.',1,1,0,0,0,0,0,''),
(22127,1,0,'Please, give me a new Felsworn Gas Mask.',1,1,0,0,0,0,0,''),
-- Elder Harkek
(28138,0,0,'Please, give me a new Goregek큦 Shackles.',1,1,0,0,0,0,0,''),
-- Brann's Communicator
(29937,0,0,'Please, give me a new Brann큦 Communicator.',1,1,0,0,0,0,0,''),
(9929,0,0,'Please, give me a new Brann큦 Communicator.',1,1,0,0,0,0,0,'');
-- +---------+
-- | SmartAI |
-- +---------+
DELETE FROM smart_scripts WHERE entryorguid IN (21772,21774,21769,21773,28518,26117,24186,24273,22127,28138,29937,29650);
INSERT INTO smart_scripts VALUES
-- Spectrecles (H)
(21772,0,0,1,62,0,100,0,21772,0,0,0,11,37700,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Spectrecles to invoker'),
(21772,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Spectrecles (A)
(21774,0,0,1,62,0,100,0,21774,0,0,0,11,37700,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Spectrecles to invoker'),
(21774,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Kor큝ron Flare Gun
(21769,0,0,1,62,0,100,0,21769,0,0,0,56,31108,1,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - add Kor큝ron Flare Gun to invoker'),
(21769,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Wildhammer Flare Gun
(21773,0,0,1,62,0,100,0,21773,0,0,0,56,31310,1,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - add Wildhammer Flare Gun to invoker'),
(21773,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Ensorcelled Choker
(28518,0,0,1,62,0,100,0,9709,0,0,0,56,38699,1,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - add Ensorcelled Choker to invoker'),
(28518,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Augmented Arcane Prison
(26117,0,0,1,62,0,100,0,9253,1,0,0,11,46764,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Augmented Arcane Prison to invoker'),
(26117,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Worg Disguise (H)
(24186,0,0,1,62,0,100,0,8908,0,0,0,11,43379,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Worg Disguise to invoker'),
(24186,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Worg Disguise (A)
(24273,0,0,1,62,0,100,0,8918,0,0,0,11,43379,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Worg Disguise to invoker'),
(24273,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Felsworn Gas Mask
(22127,0,0,1,62,0,100,0,22127,0,0,0,11,39101,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Felsworn Gas Mask to invoker'),
(22127,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Goregek's Shackles
(28138,0,0,1,62,0,100,0,28138,0,0,0,11,52542,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Goregek큦 Shackles to invoker'),
(28138,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Brann's Communicator(H)
(29937,0,0,1,62,0,100,0,29937,0,0,0,56,40971,1,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - add Brann큦 Communicator to invoker'),
(29937,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Brann's Communicator(A)
(29650,0,0,1,62,0,100,0,9929,0,0,0,56,40971,1,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - add Brann큦 Communicator to invoker'),
(29650,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip');
-- +----------+
-- |Conditions|
-- +----------+
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 15 AND SourceGroup IN (21772,21774,21769,21773,9709,9253,8918,8908,22127,28138,29937,9929);
INSERT INTO conditions VALUES
-- Augmented Arcane Prison
(15,9253,1,0,8,11943,0,0,0,'','show gossip menu option if player has quest 11943 rewarded'),
-- Kor큝ron Flare Gun
(15,21769,0,0,8,10750,0,0,0,'','show gossip menu option if player has quest 10750 rewarded'),
-- Spectrecles (Horde)
(15,21772,0,0,8,10625,0,0,0,'','show gossip menu option if player has quest 10625 rewarded'),
-- Spectrecles (Alliance)
(15,21774,0,0,8,10643,0,0,0,'','show gossip menu option if player has quest 10643 rewarded'),
-- Wildhammer Flare Gun
(15,21773,0,0,8,10772,0,0,0,'','show gossip menu option if player has quest 10772 rewarded'),
-- Ensorcelled Choker
(15,9709,0,0,9,12661,0,0,0,'','show gossip menu option if player has quest 12661'),
(15,9709,1,0,9,12669,0,0,0,'','show gossip menu option if player has quest 12669'),
(15,9709,2,0,9,12677,0,0,0,'','show gossip menu option if player has quest 12677'),
(15,9709,3,0,9,12676,0,0,0,'','show gossip menu option if player has quest 12676'),
(15,9709,4,0,9,12713,0,0,0,'','show gossip menu option if player has quest 12713'),
-- Worg Disguise (A)
(15,8918,0,0,28,11325,0,0,0,'','show gossip menu option if player has quest 11325'),
(15,8918,1,0,8,11325,0,0,0,'','show gossip menu option if player has quest 11325 rewarded'),
-- Worg Disguise (H)
(15,8908,0,0,28,11323,0,0,0,'','show gossip menu option if player has quest completed 11323'),
(15,8908,1,0,8,11323,0,0,0,'','show gossip menu option if player has quest 11323 rewarded'),
-- Felsworn Gas Mask
(15,22127,0,0,28,10819,0,0,0,'','show gossip menu option if player has quest completed 10819'),
(15,22127,1,0,8,10819,0,0,0,'','show gossip menu option if player has quest 10819 rewarded'),
-- Goregek큦 Shackles
(15,28138,0,0,8,12528,0,0,0,'','show gossip menu option if player has quest 12528 rewarded'),
-- Brann's Communicator
(15,29937,0,0,8,12910,0,0,0,'','show gossip menu option if player has quest 12910 rewarded'),
(15,9929,0,0,8,12855,0,0,0,'','show gossip menu option if player has quest 12855 rewarded');