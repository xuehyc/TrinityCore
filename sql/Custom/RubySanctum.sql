DELETE FROM `script_texts` WHERE `entry` <= -1752008 AND `entry` >= -1752016;
DELETE FROM `script_texts` WHERE `entry` <= -1752001 AND `entry` >= -1752006;
DELETE FROM `script_texts` WHERE `entry` <= -1752017 AND `entry` >= -1752036;

INSERT INTO `script_texts` (`entry`, `content_default`, `npc_entry`, `content_loc3`, `sound`, `type`, `language`) VALUES
('-1752008', 'Help! I am trapped within this tree! I require aid!', '0', '', '17490', '1', '0'),         
('-1752009', 'Thank you! I could not have held out for much longer.... A terrible thing has happened here.', '0', '', '17491', '1', '0'),         
('-1752010', 'We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.', '0', '', '17492', '0', '0'),         
('-1752011', 'The Black dragonkin materialized from thin air, and set upon us before we could react.', '0', '', '17493', '0', '0'),     
('-1752012', 'We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.', '0', '', '17494', '0', '0'),     
('-1752013', 'They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.', '0', '', '17495', '0', '0'),    
('-1752014', 'The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.', '0', '', '17496', '0', '0'),    
('-1752015', 'In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.', '0', '', '17497', '0', '0'),    
('-1752016', 'I know not the extent of their plans, heroes, but I know this: They cannot be allowed to succeed!', '0', '', '17498', '0', '0'),

( -1752001, "Ah, the entertainment has arrived.", 0, "", 17520, 1, 0),
( -1752002, "Baltharus leaves no survivors!", 0, "", 17521, 1, 0),
( -1752003, "This world has enough heroes.", 0, "", 17522, 1, 0),
( -1752004, "I..Didn''t saw...that coming...", 0, "", 17523, 1, 0),
( -1752005, "Twice the pain and half the fun.", 0, "", 17524, 1, 0),
( -1752006, "Your power wanes, ancient one.... Soon you will join your friends.", 0, "", 17525, 1, 0),
( -1752017, "Alexstrasza has chosen capable allies... A pity that I must END YOU!", 0, "", 17512, 1, 0),
( -1752018, "You thought you stood a chance?", 0, "", 17513, 1, 0),
( -1752019, "It''s for the best.", 0, "", 17514, 1, 0),
( -1752020, "HALION! I...", 0, "", 17515, 1, 0),
( -1752021, "Turn them to ashes, minions!", 0, "", 17516, 1, 0),
( -1752022, "You will sssuffer for this intrusion!", 0, "", 17528, 1, 0),
( -1752023, "As it should be...", 0, "", 17529, 1, 0),
( -1752024, "Halion will be pleased", 0, "", 17530, 1, 0),
( -1752025, "Hhrr...Grr..", 0, "", 17531, 1, 0),
( -1752026, "Burn in the master's flame!", 0, "", 17532, 1, 0),
( -1752027, 'Insects! You''re too late. The Ruby Sanctum is lost.',NULL,NULL,17499,0,0),
( -1752028, 'Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!',NULL,NULL,17500,0,0),
( -1752029, 'Another hero falls.',NULL,NULL,17501,0,0),
( -1752030, 'Hahahahaha.',NULL,NULL,17502,0,0),
( -1752031, 'Relish this victory, mortals, for it will be your last! This world will burn with the master''s return!',NULL,NULL,17503,0,0),
( -1752032, 'Not good enough.',NULL,NULL,17504,0,0),
( -1752033, 'The heavens burn!',NULL,NULL,17505,0,0),
( -1752034, 'Beware the shadow!',NULL,NULL,17506,0,0),
( -1752035, 'You will find only suffering within the realm of twilight! Enter if you dare!',NULL,NULL,17507,0,0),
( -1752036, 'I am the light and the darkness! Cower, mortals, before the herald of Deathwing!',NULL,NULL,17508,0,0);

DELETE FROM creature_template WHERE entry IN
(40419, 40420, 4041902, 4041903, 40423, 40424, 4042302, 4042303, 40421, 40422, 4042102, 4042103, 40417, 40418, 4041702, 4041703);

INSERT INTO `creature_template` VALUES (4041903, 0, 0, 0, 0, 0, 14308, 0, 0, 0, 'Charscale Assaulter (3)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 4041903, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 175, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2031, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (4041902, 0, 0, 0, 0, 0, 14308, 0, 0, 0, 'Charscale Assaulter (2)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 4041902, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 175, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2031, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (4042103, 0, 0, 0, 0, 0, 12891, 0, 0, 0, 'Charscale Elite (3)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 4042103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 280, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 10068, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (4042303, 0, 0, 0, 0, 0, 27226, 0, 0, 0, 'Charscale Commander (3)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 4042303, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 280, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2420, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (4041703, 0, 0, 0, 0, 0, 27227, 0, 0, 0, 'Charscale Invoker (3)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 4041703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 175, 12, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2419, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (4042102, 0, 0, 0, 0, 0, 12891, 0, 0, 0, 'Charscale Elite (2)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 4042102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 280, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 10068, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (4042302, 0, 0, 0, 0, 0, 27226, 0, 0, 0, 'Charscale Commander (2)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 4042302, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 280, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2420, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (4041702, 0, 0, 0, 0, 0, 27227, 0, 0, 0, 'Charscale Invoker (2)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 4041702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 175, 12, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2419, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40417, 40418, 4041702, 4041703, 0, 0, 27227, 0, 0, 0, 'Charscale Invoker', '', '', 0, 82, 82, 0, 103, 103, 0, 1.6, 1.42857, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 40417, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 119, 12, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2419, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40419, 40420, 4041902, 4041903, 0, 0, 14308, 0, 0, 0, 'Charscale Assaulter', '', '', 0, 82, 82, 0, 103, 103, 0, 1.6, 1.42857, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 40419, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 119, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2031, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40421, 40422, 4042102, 4042103, 0, 0, 12891, 0, 0, 0, 'Charscale Elite', '', '', 0, 82, 82, 0, 103, 103, 0, 1.6, 1.42857, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 40421, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 191, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 10068, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40423, 40424, 4042302, 4042303, 0, 0, 27226, 0, 0, 0, 'Charscale Commander', '', '', 0, 82, 82, 0, 103, 103, 0, 1.6, 1.42857, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 40423, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 191, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2420, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40418, 0, 0, 0, 0, 0, 27227, 0, 0, 0, 'Charscale Invoker (1)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 40418, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 175, 12, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2419, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40420, 0, 0, 0, 0, 0, 14308, 0, 0, 0, 'Charscale Assaulter (1)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 40420, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 175, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2031, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40422, 0, 0, 0, 0, 0, 12891, 0, 0, 0, 'Charscale Elite (1)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 40422, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 280, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 10068, 0, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40424, 0, 0, 0, 0, 0, 27226, 0, 0, 0, 'Charscale Commander (1)', '', '', 0, 82, 82, 0, 103, 103, 0, 1, 1.14286, 1, 1, 25450, 27450, 0, 5000, 1, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 40424, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 280, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 2420, 0, 0, '', 12340);

DELETE FROM creature_template WHERE entry IN
(39751, 39899, 39920, 39922, 3992202, 3975102, 3975103, 3992203, 39746, 39805, 3974602, 3974603, 39863, 40142, 39864, 40143, 39944, 40144, 39945, 40145, 39747, 39823, 3974702, 3974703);

INSERT INTO `creature_template` VALUES (39751, 39920, 3975102, 3975103, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn', '', '', 0, 83, 83, 0, 103, 103, 0, 2.8, 1.71429, 1.5, 1, 39150, 58730, 0, 0, 1, 2000, 0, 1, 1088, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 39751, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 606, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 634339327, 1, 'boss_baltharus', 12340);
INSERT INTO `creature_template` VALUES (39899, 39922, 3992202, 3992203, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn', '', '', 0, 83, 83, 0, 103, 103, 0, 2.8, 1.71429, 1.28, 1, 39150, 58730, 0, 0, 1, 2400, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 606, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 634339327, 0, 'boss_baltharus_summon', 12340);
INSERT INTO `creature_template` VALUES (39920, 0, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn (1)', '', '', 0, 83, 83, 0, 103, 103, 0, 1, 1.14286, 1, 1, 58730, 78310, 0, 0, 1, 2000, 0, 1, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 39920, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (39922, 0, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn (1)', '', '', 0, 83, 83, 2, 103, 103, 0, 2.8, 1.71429, 1.28, 1, 58730, 78310, 0, 0, 1, 2400, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (3992202, 0, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn (2)', '', '', 0, 83, 83, 2, 103, 103, 0, 2.8, 1.71429, 1.28, 1, 46984, 66561, 0, 0, 1, 2400, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (3975102, 0, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn (2)', '', '', 0, 83, 83, 0, 103, 103, 0, 1, 1.14286, 1, 1, 46984, 66561, 0, 0, 1, 2000, 0, 1, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 3975102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (3975103, 0, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn (3)', '', '', 0, 83, 83, 0, 103, 103, 0, 1, 1.14286, 1, 1, 78308, 97885, 0, 0, 1, 2000, 0, 1, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 3975103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (3992203, 0, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn (3)', '', '', 0, 83, 83, 2, 103, 103, 0, 2.8, 1.71429, 1.28, 1, 78308, 97885, 0, 0, 1, 2400, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (39746, 39805, 3974602, 3974603, 0, 0, 32179, 0, 0, 0, 'General Zarithrian', '', '', 0, 83, 83, 0, 16, 16, 0, 0.888888, 1.42857, 1, 1, 10000, 15000, 0, 0, 1, 1500, 0, 1, 320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 39746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 723, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 1764, 634339327, 1, 'boss_zarithrian', 12340);
INSERT INTO `creature_template` VALUES (39805, 0, 0, 0, 0, 0, 32179, 0, 0, 0, 'General Zarithrian (1)', '', '', 0, 83, 83, 0, 16, 16, 0, 1, 1.14286, 1, 1, 17000, 22000, 0, 0, 1, 1500, 0, 1, 320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 39805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2416, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 1764, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (3974602, 0, 0, 0, 0, 0, 32179, 0, 0, 0, 'General Zarithrian (2)', '', '', 0, 83, 83, 0, 16, 16, 0, 1, 1.14286, 1, 1, 18000, 23000, 0, 0, 1, 1500, 0, 1, 320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 3974602, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2416, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 1764, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (3974603, 0, 0, 0, 0, 0, 32179, 0, 0, 0, 'General Zarithrian (3)', '', '', 0, 83, 83, 0, 16, 16, 0, 1, 1.14286, 1, 1, 19000, 24000, 0, 0, 1, 1500, 0, 1, 320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 3974603, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2416, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 1764, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (39863, 39864, 39944, 39945, 0, 0, 31952, 0, 0, 0, 'Halion', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1.6, 1.42857, 1, 1, 58500, 78000, 0, 0, 1, 1800, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 108, 39863, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 634339327, 1, 'boss_halion', 12340);
INSERT INTO `creature_template` VALUES (40142, 40143, 40144, 40145, 0, 0, 31952, 0, 0, 0, 'Halion', 'The Twilight Destroyer', '', 0, 83, 83, 0, 14, 14, 0, 1.6, 1.42857, 1, 1, 58500, 78000, 0, 0, 1, 1800, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 634339327, 0, 'boss_twilight_halion', 12340);
INSERT INTO `creature_template` VALUES (39864, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (1)', 'The Twilight Destroyer', '', 0, 83, 83, 0, 14, 14, 0, 1, 1.14286, 1, 1, 78000, 97500, 0, 0, 1, 1800, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 108, 39864, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 7509, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40143, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (1)', 'The Twilight Destroyer', '', 0, 1, 1, 0, 35, 35, 0, 1, 1.14286, 1, 1, 78000, 97500, 0, 0, 1, 1800, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2900, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (39944, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (2)', 'The Twilight Destroyer', '', 0, 83, 83, 0, 14, 14, 0, 1, 1.14286, 1, 1, 66300, 85800, 0, 0, 1, 1800, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 108, 39944, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2636, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40144, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (2)', 'The Twilight Destroyer', '', 0, 1, 1, 0, 35, 35, 0, 1, 1.14286, 1, 1, 66300, 85800, 0, 0, 1, 1800, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1100, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (39945, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (3)', 'The Twilight Destroyer', '', 0, 83, 83, 0, 14, 14, 0, 1, 1.14286, 1, 1, 89700, 109200, 0, 0, 1, 1800, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 108, 39945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 10087, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (40145, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (3)', 'The Twilight Destroyer', '', 0, 1, 1, 0, 35, 35, 0, 1, 1.14286, 1, 1, 89700, 109200, 0, 0, 1, 1800, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 4200, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (39747, 39823, 3974702, 3974703, 0, 0, 31577, 0, 0, 0, 'Saviana Ragefire', '', '', 0, 83, 83, 0, 103, 103, 0, 2, 2.14286, 1.2, 1, 39150, 58730, 0, 0, 1, 2000, 0, 1, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 39747, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 738, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 0, 634339327, 1, 'boss_ragefire', 12340);
INSERT INTO `creature_template` VALUES (39823, 0, 0, 0, 0, 0, 31577, 0, 0, 0, 'Saviana Ragefire (1)', '', '', 0, 83, 83, 0, 103, 103, 0, 1, 1.14286, 1, 1, 58730, 78310, 0, 0, 1, 2000, 0, 1, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 39823, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2404, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 0, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (3974702, 0, 0, 0, 0, 0, 31577, 0, 0, 0, 'Saviana Ragefire (2)', '', '', 0, 83, 83, 0, 103, 103, 0, 1, 1.14286, 1, 1, 46984, 66561, 0, 0, 1, 2000, 0, 1, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 3974702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 0, 634339327, 0, '', 12340);
INSERT INTO `creature_template` VALUES (3974703, 0, 0, 0, 0, 0, 31577, 0, 0, 0, 'Saviana Ragefire (3)', '', '', 0, 83, 83, 0, 103, 103, 0, 1, 1.14286, 1, 1, 78308, 97885, 0, 0, 1, 1800, 0, 1, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 76, 3974703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2404, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 0, 634339327, 0, '', 12340);


UPDATE `instance_template` SET `script` = 'instance_ruby_sanctum' WHERE `map` = '724';
UPDATE `creature_template` SET `ScriptName` = 'boss_baltharus' WHERE `entry` = '39751';
UPDATE `creature_template` SET `ScriptName` = 'boss_baltharus_summon' WHERE `entry` = '39899';
UPDATE `creature_template` SET `ScriptName` = 'npc_xerestrasza' WHERE `entry` = '40429';
UPDATE `creature_template` SET `ScriptName` = 'boss_zarithrian' WHERE `entry` = '39746';
UPDATE `creature_template` SET `ScriptName` = 'boss_ragefire' WHERE `entry` = '39747';
UPDATE `creature_template` SET `ScriptName` = 'boss_halion' WHERE `entry` =  '39863';
UPDATE `creature_template` SET `ScriptName` = 'boss_twilight_halion' WHERE `entry` = '40142';
UPDATE `creature_template` SET `ScriptName` = 'npc_onyx_flamecaller' WHERE `entry` = '39814';
UPDATE `creature_template` SET `ScriptName` = 'npc_meteor_strike', `flags_extra` = 128 WHERE `entry` = '40041';
UPDATE `creature_template` SET `ScriptName` = 'npc_meteor_flame', `flags_extra` = 128 WHERE `entry` = '40042';
UPDATE `creature_template` SET `ScriptName` = 'npc_spell_meteor_strike', `flags_extra` = 128 WHERE `entry` = '40029';
UPDATE `creature_template` SET `name` = 'summon halion', `ScriptName` = 'npc_summon_halion', `flags_extra` = 128 WHERE `entry` = '40044';

UPDATE `gameobject_template` SET `data10` = 74807 WHERE `entry` = 202794;
UPDATE `gameobject_template` SET `data10` = 74812 WHERE `entry` = 202796;

DELETE FROM `spell_script_names` WHERE `spell_id` = 74812;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
('74812','spell_halion_portal');

DELETE FROM `spell_linked_spell` WHERE (`spell_trigger` = '-74562') AND (`spell_effect` = '74610');
DELETE FROM `spell_linked_spell` WHERE (`spell_trigger` = '-74792') AND (`spell_effect` = '74800');
INSERT INTO `spell_linked_spell` VALUES (-74562, 74610, 0, 'Fiery Combustion removed -> Combustion');
INSERT INTO `spell_linked_spell` VALUES (-74792, 74800, 0, 'Soul Consumption removed -> Consumption');

DELETE FROM `creature` WHERE `id` = 39863 AND `map` = 724;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`)
VALUES (39863,724,15,1,0,0,3144.93,527.233,72.8887,0.110395,300,0,0,11156000,0,0,0);

/*---- Charscale Invoker*/
DELETE FROM creature_ai_scripts WHERE creature_id=40417;
UPDATE creature_template SET AIName='EventAI' WHERE entry=40417;
UPDATE creature_template SET ScriptName='' WHERE entry=40417;
INSERT INTO creature_ai_scripts VALUES (NULL, '40417', '0', '0', '100', '3', '28000', '39000', '29000', '37000', '11', '75412', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Invoker - DTDB scirpts');
INSERT INTO creature_ai_scripts VALUES (NULL, '40417', '0', '0', '100', '5', '28000', '39000', '29000', '37000', '11', '75419', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Invoker - DTDB scirpts');
INSERT INTO creature_ai_scripts VALUES (NULL, '40417', '0', '0', '100', '7', '15000', '15000', '15000', '15000', '11', '75413', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Invoker - DTDB scirpts');

/*---- Charscale Assaulter*/
DELETE FROM creature_ai_scripts WHERE creature_id=40419;
UPDATE creature_template SET AIName='EventAI' WHERE entry=40419;
UPDATE creature_template SET ScriptName='' WHERE entry=40419;
INSERT INTO creature_ai_scripts VALUES (NULL, '40419', '0', '0', '100', '7', '15000', '15000', '15000', '15000', '11', '15284', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Charscale Assaulter - DTDB Scripts');
INSERT INTO creature_ai_scripts VALUES (NULL, '40419', '0', '0', '100', '3', '30000', '30000', '30000', '30000', '11', '75417', '1', '4', '39', '200', '0', '0', '0', '0', '0', '0', 'Charscale Assaulter - DTDB Scripts');
INSERT INTO creature_ai_scripts VALUES (NULL, '40419', '0', '0', '100', '5', '20000', '20000', '30000', '30000', '11', '75418', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Charscale Assaulter - DTDB Scripts');

/*---- Onyx Flamecaller*/
DELETE FROM creature_ai_scripts WHERE creature_id=39814;
UPDATE creature_template SET AIName='EventAI' WHERE entry=39814;
UPDATE creature_template SET ScriptName='' WHERE entry=39814;
INSERT INTO creature_ai_scripts VALUES (NULL, '39814', '0', '0', '100', '3', '20000', '20000', '30000', '30000', '11', '74392', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Flamecaller - DTDB Scripts');
INSERT INTO creature_ai_scripts VALUES (NULL, '39814', '0', '0', '100', '3', '26000', '26000', '26000', '26000', '11', '74394', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Flamecaller - DTDB Scripts');
INSERT INTO creature_ai_scripts VALUES (NULL, '39814', '0', '0', '100', '5', '26000', '26000', '26000', '26000', '11', '74395', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Flamecaller - DTDB Scripts');
INSERT INTO creature_ai_scripts VALUES (NULL, '39814', '0', '0', '100', '5', '28000', '28000', '29000', '29000', '11', '74393', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Flamecaller - DTDB Scripts');

/*---- Charscale Commander*/
DELETE FROM creature_ai_scripts WHERE creature_id=40423;
UPDATE creature_template SET AIName='EventAI' WHERE entry=40423;
UPDATE creature_template SET ScriptName='' WHERE entry=40423;
INSERT INTO creature_ai_scripts VALUES (NULL, '40423', '0', '0', '100', '7', '18000', '18000', '18000', '18000', '11', '13737', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Commander - DTDB Scripts');
INSERT INTO creature_ai_scripts VALUES (NULL, '40423', '0', '0', '100', '7', '5000', '5000', '30000', '30000', '11', '75414', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Commander - DTDB Scripts');

/*---- Charscale Elite*/
DELETE FROM creature_ai_scripts WHERE creature_id=40421;
UPDATE creature_template SET AIName='EventAI' WHERE entry=40421;
UDPATE creature_template SET ScriptName='' WHERE entry=40421;
INSERT INTO creature_ai_scripts VALUES (NULL, '40421', '0', '0', '100', '7', '5000', '5000', '15000', '15000', '11', '15621', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Elite - DTDB Scripts');

SET @Halion10N = '39863';
SET @Halion25N = '39864';
SET @Halion10HC = '39944';
SET @Halion25HC = '39945';
SET @Balthar10N = '39751';
SET @Balthar10HC = '3975102';
SET @Saviaga10N = '39747';
SET @Saviaga10HC = '3974702';
SET @Saviaga25HC = '3974703';
SET @General10N = '39746';
SET @General10HC = '3974602';

DELETE FROM creature_loot_template WHERE entry=@Halion10N;
DELETE FROM creature_loot_template WHERE entry=@Halion25N;
DELETE FROM creature_loot_template WHERE entry=@Halion10HC;
DELETE FROM creature_loot_template WHERE entry=@Halion25HC;
DELETE FROM creature_loot_template WHERE entry=@Balthar10N;
DELETE FROM creature_loot_template WHERE entry=@Balthar10HC;
DELETE FROM creature_loot_template WHERE entry=@Saviaga10N;
DELETE FROM creature_loot_template WHERE entry=@Saviaga10HC;
DELETE FROM creature_loot_template WHERE entry=@Saviaga25HC;
DELETE FROM creature_loot_template WHERE entry=@General10N;
DELETE FROM creature_loot_template WHERE entry=@General10HC;


INSERT INTO `creature_loot_template` VALUES (@Halion10N, 53121, 30, 1, 1, 1, 1),
(@Halion10N, 53118, 30, 1, 2, 1, 1),
(@Halion10N, 53103, 30, 1, 3, 1, 1),
(@Halion10N, 53113, 30, 1, 4, 1, 1),
(@Halion10N, 53116, 30, 1, 1, 1, 1),
(@Halion10N, 53114, 30, 1, 2, 1, 1),
(@Halion10N, 53115, 30, 1, 3, 1, 1),
(@Halion10N, 53119, 30, 1, 4, 1, 1),
(@Halion10N, 53110, 30, 1, 1, 1, 1),
(@Halion10N, 53117, 30, 1, 2, 1, 1),
(@Halion10N, 53111, 30, 1, 3, 1, 1),
(@Halion10N, 53112, 30, 1, 4, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@Halion25N, 53490, 30, 1, 1, 1, 1),
(@Halion25N, 53133, 30, 1, 2, 1, 1),
(@Halion25N, 54569, 30, 1, 3, 1, 1),
(@Halion25N, 54572, 30, 1, 4, 1, 1),
(@Halion25N, 53486, 30, 1, 1, 1, 1),
(@Halion25N, 53489, 30, 1, 2, 1, 1),
(@Halion25N, 54573, 30, 1, 3, 1, 1),
(@Halion25N, 54571, 30, 1, 4, 1, 1),
(@Halion25N, 53126, 30, 1, 1, 1, 1),
(@Halion25N, 53487, 30, 1, 2, 1, 1),
(@Halion25N, 53134, 30, 1, 3, 1, 1),
(@Halion25N, 53488, 30, 1, 4, 1, 1),
(@Halion25N, 53129, 30, 1, 1, 1, 1),
(@Halion25N, 53132, 30, 1, 2, 1, 1),
(@Halion25N, 53127, 30, 1, 3, 1, 1),
(@Halion25N, 53125, 30, 1, 4, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@Halion10HC, 54566, 30, 1, 1, 1, 1),
(@Halion10HC, 54560, 30, 1, 2, 1, 1),
(@Halion10HC, 54565, 30, 1, 3, 1, 1),
(@Halion10HC, 54563, 30, 1, 4, 1, 1),
(@Halion10HC, 54558, 30, 1, 1, 1, 1),
(@Halion10HC, 54556, 30, 1, 2, 1, 1),
(@Halion10HC, 54557, 30, 1, 3, 1, 1),
(@Halion10HC, 54559, 30, 1, 4, 1, 1),
(@Halion10HC, 54564, 30, 1, 1, 1, 1),
(@Halion10HC, 54561, 30, 1, 2, 1, 1),
(@Halion10HC, 54567, 30, 1, 3, 1, 1),
(@Halion10HC, 54562, 30, 1, 4, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@Halion25HC, 54576, 30, 1, 3, 1, 1),
(@Halion25HC, 54590, 30, 1, 4, 1, 1),
(@Halion25HC, 54583, 30, 1, 1, 1, 1),
(@Halion25HC, 54588, 30, 1, 2, 1, 1),
(@Halion25HC, 54591, 30, 1, 3, 1, 1),
(@Halion25HC, 54586, 30, 1, 4, 1, 1),
(@Halion25HC, 54584, 30, 1, 1, 1, 1),
(@Halion25HC, 54582, 30, 1, 2, 1, 1),
(@Halion25HC, 54589, 30, 1, 3, 1, 1),
(@Halion25HC, 54577, 30, 1, 4, 1, 1),
(@Halion25HC, 54578, 30, 1, 1, 1, 1),
(@Halion25HC, 54581, 30, 1, 2, 1, 1),
(@Halion25HC, 54587, 30, 1, 3, 1, 1),
(@Halion25HC, 54580, 30, 1, 4, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@Balthar10N, 36288, 30, 1, 2, 1, 1),
(@Balthar10N, 36398, 30, 1, 3, 1, 1),
(@Balthar10N, 36397, 30, 1, 4, 1, 1),
(@Balthar10N, 36060, 30, 1, 5, 1, 1),
(@Balthar10N, 36285, 30, 1, 1, 1, 1),
(@Balthar10N, 36171, 30, 1, 2, 1, 1),
(@Balthar10N, 36059, 30, 1, 3, 1, 1),
(@Balthar10N, 36173, 30, 1, 4, 1, 1),
(@Balthar10N, 37761, 30, 1, 5, 1, 1),
(@Balthar10N, 36065, 30, 1, 1, 1, 1),
(@Balthar10N, 36444, 30, 1, 2, 1, 1),
(@Balthar10N, 36395, 30, 1, 3, 1, 1),
(@Balthar10N, 36400, 30, 1, 4, 1, 1),
(@Balthar10N, 36430, 30, 1, 5, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@Balthar10HC, 36288, 30, 1, 2, 1, 1),
(@Balthar10HC, 45912, 30, 1, 3, 1, 1),
(@Balthar10HC, 36398, 30, 1, 4, 1, 1),
(@Balthar10HC, 33568, 30, 1, 5, 1, 1),
(@Balthar10HC, 36171, 30, 1, 1, 1, 1),
(@Balthar10HC, 36397, 30, 1, 2, 1, 1),
(@Balthar10HC, 36290, 30, 1, 3, 1, 1),
(@Balthar10HC, 36401, 30, 1, 4, 1, 1),
(@Balthar10HC, 36542, 30, 1, 5, 1, 1),
(@Balthar10HC, 36060, 30, 1, 1, 1, 1),
(@Balthar10HC, 36059, 30, 1, 2, 1, 1),
(@Balthar10HC, 36173, 30, 1, 3, 1, 1),
(@Balthar10HC, 33427, 30, 1, 4, 1, 1),
(@Balthar10HC, 33368, 30, 1, 5, 1, 1),
(@Balthar10HC, 33413, 30, 1, 1, 1, 1),
(@Balthar10HC, 37761, 30, 1, 2, 1, 1),
(@Balthar10HC, 36066, 30, 1, 3, 1, 1),
(@Balthar10HC, 36062, 30, 1, 4, 1, 1),
(@Balthar10HC, 36065, 30, 1, 5, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@Saviaga10N, 36626, 30, 1, 1, 1, 1),
(@Saviaga10N, 36172, 30, 1, 2, 1, 1),
(@Saviaga10N, 36061, 30, 1, 3, 1, 1),
(@Saviaga10N, 37761, 30, 1, 4, 1, 1),
(@Saviaga10N, 36398, 30, 1, 5, 1, 1),
(@Saviaga10N, 36064, 30, 1, 1, 1, 1),
(@Saviaga10N, 36528, 30, 1, 2, 1, 1),
(@Saviaga10N, 36287, 30, 1, 3, 1, 1),
(@Saviaga10N, 36682, 30, 1, 4, 1, 1),
(@Saviaga10N, 36500, 30, 1, 5, 1, 1),
(@Saviaga10N, 36285, 30, 1, 1, 1, 1),
(@Saviaga10N, 36570, 30, 1, 2, 1, 1),
(@Saviaga10N, 36175, 30, 1, 3, 1, 1),
(@Saviaga10N, 36062, 30, 1, 4, 1, 1),
(@Saviaga10N, 36069, 30, 1, 5, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@Saviaga10HC, 36612, 30, 1, 1, 1, 1),
(@Saviaga10HC, 36598, 30, 1, 2, 1, 1),
(@Saviaga10HC, 36397, 30, 1, 3, 1, 1),
(@Saviaga10HC, 36668, 30, 1, 4, 1, 1),
(@Saviaga10HC, 36696, 30, 1, 5, 1, 1),
(@Saviaga10HC, 36178, 30, 1, 1, 1, 1),
(@Saviaga10HC, 36063, 30, 1, 2, 1, 1),
(@Saviaga10HC, 36064, 30, 1, 3, 1, 1),
(@Saviaga10HC, 36175, 30, 1, 4, 1, 1),
(@Saviaga10HC, 36062, 30, 1, 5, 1, 1),
(@Saviaga10HC, 36288, 30, 1, 1, 1, 1),
(@Saviaga10HC, 36284, 30, 1, 2, 1, 1),
(@Saviaga10HC, 36528, 30, 1, 3, 1, 1),
(@Saviaga10HC, 36285, 30, 1, 4, 1, 1),
(@Saviaga10HC, 36173, 30, 1, 5, 1, 1),
(@Saviaga10HC, 36283, 30, 1, 1, 1, 1),
(@Saviaga10HC, 36060, 30, 1, 2, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@Saviaga25HC, 36174, 30, 1, 1, 1, 1),
(@Saviaga25HC, 37771, 30, 1, 2, 1, 1),
(@Saviaga25HC, 45912, 30, 1, 3, 1, 1),
(@Saviaga25HC, 33424, 30, 1, 4, 1, 1),
(@Saviaga25HC, 36066, 30, 1, 5, 1, 1),
(@Saviaga25HC, 36401, 30, 1, 1, 1, 1),
(@Saviaga25HC, 33417, 30, 1, 2, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@General10N, 36668, 30, 1, 2, 1, 1),
(@General10N, 45912, 30, 1, 3, 1, 1),
(@General10N, 36682, 30, 1, 4, 1, 1),
(@General10N, 36458, 30, 1, 5, 1, 1),
(@General10N, 36176, 30, 1, 1, 1, 1),
(@General10N, 36399, 30, 1, 2, 1, 1),
(@General10N, 36430, 30, 1, 3, 1, 1),
(@General10N, 36063, 30, 1, 4, 1, 1),
(@General10N, 36064, 30, 1, 5, 1, 1),
(@General10N, 36066, 30, 1, 1, 1, 1),
(@General10N, 36514, 30, 1, 2, 1, 1),
(@General10N, 36395, 30, 1, 3, 1, 1),
(@General10N, 36402, 30, 1, 4, 1, 1),
(@General10N, 42173, 30, 1, 5, 1, 1);


INSERT INTO `creature_loot_template` VALUES (@General10HC, 36175, 30, 1, 2, 1, 1),
(@General10HC, 36063, 30, 1, 3, 1, 1),
(@General10HC, 36401, 30, 1, 4, 1, 1),
(@General10HC, 36400, 30, 1, 5, 1, 1),
(@General10HC, 36668, 30, 1, 1, 1, 1),
(@General10HC, 36064, 30, 1, 2, 1, 1),
(@General10HC, 33568, 30, 1, 3, 1, 1),
(@General10HC, 37794, 30, 1, 4, 1, 1),
(@General10HC, 36060, 30, 1, 5, 1, 1),
(@General10HC, 36065, 30, 1, 1, 1, 1),
(@General10HC, 36172, 30, 1, 2, 1, 1),
(@General10HC, 36173, 30, 1, 3, 1, 1),
(@General10HC, 36178, 30, 1, 4, 1, 1),
(@General10HC, 36696, 30, 1, 5, 1, 1),
(@General10HC, 36396, 30, 1, 1, 1, 1),
(@General10HC, 36598, 30, 1, 2, 1, 1),
(@General10HC, 36285, 30, 1, 3, 1, 1),
(@General10HC, 36287, 30, 1, 4, 1, 1);

SET @Charscale_Assaulter10N = '40419';
SET @Charscale_Assaulter25N = '40420';
SET @Charscale_Assaulter10HC = '4041902';
SET @Charscale_Assaulter25HC = '4041903';
SET @Charscale_Commander10N = '40423';
SET @Charscale_Commander25N = '40424';
SET @Charscale_Commander10HC = '4042302';
SET @Charscale_Commander25HC = '4042303';
SET @Charscale_Elite10N = '40421';
SET @Charscale_Elite25N = '40422';
SET @Charscale_Elite10HC = '4042102';
SET @Charscale_Elite25HC = '4042103';
SET @Charscale_Invoker10N = '40417';
SET @Charscale_Invoker25N = '40418';
SET @Charscale_Invoker10HC = '4041702';
SET @Charscale_Invoker25HC = '4041703';

DELETE FROM creature_loot_template WHERE entry IN 
(40419, 40420, 4041902, 4041903, 40423, 40424, 4042302, 4042303, 40421, 40422, 4042102, 4042103, 40417, 40418, 4041702, 4041703);

INSERT INTO `creature_loot_template` VALUES
(@Charscale_Assaulter10N, 33470, 30, 1, 4, 1, 1),
(@Charscale_Assaulter25N, 33470, 30, 1, 5, 1, 1),
(@Charscale_Assaulter10HC, 33470, 30, 1, 6, 1, 1),
(@Charscale_Assaulter25HC, 33470, 30, 1, 1, 1, 1),
(@Charscale_Assaulter10N, 43852, 30, 1, 2, 1, 1),
(@Charscale_Assaulter25N, 43852, 30, 1, 3, 1, 1),
(@Charscale_Assaulter10HC, 43852, 30, 1, 4, 1, 1),
(@Charscale_Assaulter25HC, 43852, 30, 1, 5, 1, 1),
(@Charscale_Assaulter10N, 33454, 30, 1, 6, 1, 1),
(@Charscale_Assaulter25N, 33454, 30, 1, 1, 1, 1),
(@Charscale_Assaulter10HC, 33454, 30, 1, 2, 1, 1),
(@Charscale_Assaulter25HC, 33454, 30, 1, 3, 1, 1),
(@Charscale_Assaulter10N, 33445, 30, 1, 4, 1, 1),
(@Charscale_Assaulter25N, 33445, 30, 1, 5, 1, 1),
(@Charscale_Assaulter10HC, 33445, 30, 1, 6, 1, 1),
(@Charscale_Assaulter25HC, 33445, 30, 1, 1, 1, 1),
(@Charscale_Assaulter10N, 33447, 30, 1, 2, 1, 1),
(@Charscale_Assaulter25N, 33447, 30, 1, 3, 1, 1),
(@Charscale_Assaulter25N, 36430, 30, 1, 4, 1, 1),
(@Charscale_Assaulter10N, 33428, 30, 1, 5, 1, 1),
(@Charscale_Assaulter25N, 36443, 30, 1, 6, 1, 1),
(@Charscale_Assaulter10N, 33419, 30, 1, 1, 1, 1),
(@Charscale_Assaulter25N, 33426, 30, 1, 2, 1, 1),
(@Charscale_Assaulter25N, 33398, 30, 1, 3, 1, 1),
(@Charscale_Assaulter25N, 36402, 30, 1, 4, 1, 1),
(@Charscale_Assaulter25N, 36681, 30, 1, 5, 1, 1),
(@Charscale_Assaulter25N, 33368, 30, 1, 6, 1, 1);


INSERT INTO `creature_loot_template` VALUES
(@Charscale_Commander10N, 33470, 30, 1, 4, 1, 1),
(@Charscale_Commander25N, 33470, 30, 1, 5, 1, 1),
(@Charscale_Commander10HC, 33470, 30, 1, 6, 1, 1),
(@Charscale_Commander25HC, 33470, 30, 1, 1, 1, 1),
(@Charscale_Commander10N, 43852, 30, 1, 2, 1, 1),
(@Charscale_Commander25N, 43852, 30, 1, 3, 1, 1),
(@Charscale_Commander10HC, 43852, 30, 1, 4, 1, 1),
(@Charscale_Commander25HC, 43852, 30, 1, 5, 1, 1),
(@Charscale_Commander10N, 33454, 30, 1, 6, 1, 1),
(@Charscale_Commander25N, 33454, 30, 1, 1, 1, 1),
(@Charscale_Commander10HC, 33454, 30, 1, 2, 1, 1),
(@Charscale_Commander25HC, 33454, 30, 1, 3, 1, 1),
(@Charscale_Commander10N, 33445, 30, 1, 4, 1, 1),
(@Charscale_Commander25N, 33445, 30, 1, 5, 1, 1),
(@Charscale_Commander10HC, 33445, 30, 1, 6, 1, 1),
(@Charscale_Commander25HC, 33445, 30, 1, 1, 1, 1),
(@Charscale_Commander10N, 36057, 30, 1, 1, 1, 1),
(@Charscale_Commander10HC, 36059, 30, 1, 1, 1, 1),
(@Charscale_Commander10N, 43508, 30, 1, 4, 1, 1),
(@Charscale_Commander25N, 43508, 30, 1, 5, 1, 1),
(@Charscale_Commander10HC, 43508, 30, 1, 6, 1, 1),
(@Charscale_Commander25HC, 43508, 30, 1, 1, 1, 1),
(@Charscale_Commander10N, 33413, 30, 1, 5, 1, 1),
(@Charscale_Commander10HC, 33568, 30, 1, 4, 1, 1),
(@Charscale_Commander10N, 33447, 30, 1, 5, 1, 1),
(@Charscale_Commander25N, 33368, 30, 1, 6, 1, 1),
(@Charscale_Commander10N, 33412, 30, 1, 7, 1, 1),
(@Charscale_Commander10N, 33417, 30, 1, 8, 1, 1),
(@Charscale_Commander25N, 36667, 30, 1, 9, 1, 1),
(@Charscale_Commander10N, 33425, 30, 1, 10, 1, 1),
(@Charscale_Commander10HC, 33425, 30, 1, 1, 1, 1),
(@Charscale_Commander10N, 36066, 30, 1, 2, 1, 1),
(@Charscale_Commander10N, 36060, 30, 1, 3, 1, 1),
(@Charscale_Commander10HC, 36062, 30, 1, 4, 1, 1),
(@Charscale_Commander10N, 37091, 30, 1, 5, 1, 1),
(@Charscale_Commander10N, 33382, 30, 1, 6, 1, 1),
(@Charscale_Commander10HC, 36393, 30, 1, 7, 1, 1),
(@Charscale_Commander10HC, 36279, 30, 1, 8, 1, 1),
(@Charscale_Commander10HC, 36429, 30, 1, 9, 1, 1),
(@Charscale_Commander10HC, 36165, 30, 1, 10, 1, 1),
(@Charscale_Commander25N, 33397, 30, 1, 1, 1, 1),
(@Charscale_Commander25HC, 33422, 30, 1, 2, 1, 1),
(@Charscale_Commander25N, 36556, 30, 1, 3, 1, 1),
(@Charscale_Commander25HC, 36611, 30, 1, 4, 1, 1),
(@Charscale_Commander25HC, 43507, 30, 1, 5, 1, 1),
(@Charscale_Commander25HC, 36387, 30, 1, 6, 1, 1),
(@Charscale_Commander25HC, 36682, 30, 1, 7, 1, 1),
(@Charscale_Commander10HC, 36286, 30, 1, 8, 1, 1),
(@Charscale_Commander25N, 36415, 30, 1, 9, 1, 1),
(@Charscale_Commander10HC, 36167, 30, 1, 10, 1, 1),
(@Charscale_Commander10HC, 38557, 30, 1, 1, 1, 1),
(@Charscale_Commander10HC, 37097, 30, 1, 2, 1, 1),
(@Charscale_Commander10HC, 33400, 30, 1, 3, 1, 1),
(@Charscale_Commander25N, 33369, 30, 1, 4, 1, 1),
(@Charscale_Commander10HC, 33371, 30, 1, 5, 1, 1),
(@Charscale_Commander25N, 33384, 30, 1, 6, 1, 1),
(@Charscale_Commander25N, 36391, 30, 1, 7, 1, 1),
(@Charscale_Commander25N, 36276, 30, 1, 8, 1, 1),
(@Charscale_Commander25HC, 33429, 30, 1, 9, 1, 1),
(@Charscale_Commander25N, 33431, 30, 1, 10, 1, 1);


INSERT INTO `creature_loot_template` VALUES
(@Charscale_Elite10N, 36389, 30, 1, 10, 1, 1),
(@Charscale_Elite10N, 33426, 30, 1, 10, 1, 1),
(@Charscale_Elite10N, 33379, 30, 1, 10, 1, 1),
(@Charscale_Elite10N, 33434, 30, 1, 10, 1, 1),
(@Charscale_Elite25N, 36163, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36393, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36066, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36542, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36164, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 33429, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36062, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36287, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 38557, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 33368, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 33425, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36177, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36401, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36391, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36392, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36166, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36399, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 36285, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 33447, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 33367, 30, 1, 8, 1, 1),
(@Charscale_Elite25N, 33435, 30, 1, 8, 1, 1),
(@Charscale_Elite10HC, 33384, 30, 1, 10, 1, 1),
(@Charscale_Elite10HC, 36430, 30, 1, 10, 1, 1),
(@Charscale_Elite10HC, 33412, 30, 1, 10, 1, 1),
(@Charscale_Elite10HC, 33428, 30, 1, 10, 1, 1),
(@Charscale_Elite10HC, 36394, 30, 1, 10, 1, 1),
(@Charscale_Elite10HC, 33423, 30, 1, 7, 1, 1),
(@Charscale_Elite10HC, 37091, 30, 1, 8, 1, 1),
(@Charscale_Elite10HC, 33369, 30, 1, 9, 1, 1),
(@Charscale_Elite10N, 43507, 30, 1, 10, 1, 1),
(@Charscale_Elite25N, 43507, 30, 1, 11, 1, 1),
(@Charscale_Elite10HC, 43507, 30, 1, 12, 1, 1),
(@Charscale_Elite25HC, 43507, 30, 1, 1, 1, 1),
(@Charscale_Elite10N, 33445, 30, 1, 2, 1, 1),
(@Charscale_Elite25N, 33445, 30, 1, 3, 1, 1),
(@Charscale_Elite10HC, 33445, 30, 1, 4, 1, 1),
(@Charscale_Elite25HC, 33445, 30, 1, 5, 1, 1),
(@Charscale_Elite25HC, 36429, 30, 1, 6, 1, 1),
(@Charscale_Elite25HC, 43509, 30, 1, 7, 1, 1),
(@Charscale_Elite25HC, 43510, 30, 1, 8, 1, 1),
(@Charscale_Elite25HC, 43508, 30, 1, 9, 1, 1),
(@Charscale_Elite25HC, 36175, 30, 1, 10, 1, 1),
(@Charscale_Elite25HC, 36060, 30, 1, 11, 1, 1),
(@Charscale_Elite25HC, 36695, 30, 1, 12, 1, 1),
(@Charscale_Elite25HC, 36172, 30, 1, 1, 1, 1),
(@Charscale_Elite25HC, 36286, 30, 1, 2, 1, 1),
(@Charscale_Elite25HC, 36059, 30, 1, 3, 1, 1),
(@Charscale_Elite25HC, 36500, 30, 1, 4, 1, 1),
(@Charscale_Elite25HC, 36165, 30, 1, 5, 1, 1),
(@Charscale_Elite25HC, 33433, 30, 1, 6, 1, 1),
(@Charscale_Elite25HC, 36282, 30, 1, 7, 1, 1),
(@Charscale_Elite25HC, 36668, 30, 1, 8, 1, 1),
(@Charscale_Elite25HC, 36170, 30, 1, 9, 1, 1),
(@Charscale_Elite25HC, 36696, 30, 1, 10, 1, 1),
(@Charscale_Elite10HC, 36275, 30, 1, 11, 1, 1),
(@Charscale_Elite25HC, 36275, 30, 1, 12, 1, 1),
(@Charscale_Elite10N, 33470, 30, 1, 1, 1, 1),
(@Charscale_Elite25N, 33470, 30, 1, 2, 1, 1),
(@Charscale_Elite10HC, 33470, 30, 1, 3, 1, 1),
(@Charscale_Elite25HC, 33470, 30, 1, 4, 1, 1),
(@Charscale_Elite10N, 43852, 30, 1, 5, 1, 1),
(@Charscale_Elite25N, 43852, 30, 1, 6, 1, 1),
(@Charscale_Elite10HC, 43852, 30, 1, 7, 1, 1),
(@Charscale_Elite25HC, 43852, 30, 1, 8, 1, 1),
(@Charscale_Elite10N, 33454, 30, 1, 9, 1, 1),
(@Charscale_Elite25N, 33454, 30, 1, 10, 1, 1),
(@Charscale_Elite10HC, 33454, 30, 1, 11, 1, 1),
(@Charscale_Elite25HC, 33454, 30, 1, 12, 1, 1);


INSERT INTO `creature_loot_template` VALUES
(@Charscale_Invoker10N, 33368, 30, 1, 1, 1, 1),
(@Charscale_Invoker10N, 33428, 30, 1, 2, 1, 1),
(@Charscale_Invoker10N, 33436, 30, 1, 3, 1, 1),
(@Charscale_Invoker25N, 43509, 30, 1, 4, 1, 1),
(@Charscale_Invoker25N, 36668, 30, 1, 5, 1, 1),
(@Charscale_Invoker25N, 36396, 30, 1, 6, 1, 1),
(@Charscale_Invoker25N, 36170, 30, 1, 7, 1, 1),
(@Charscale_Invoker25N, 36695, 30, 1, 8, 1, 1),
(@Charscale_Invoker25N, 36416, 30, 1, 9, 1, 1),
(@Charscale_Invoker25N, 33415, 30, 1, 10, 1, 1),
(@Charscale_Invoker25N, 36065, 30, 1, 11, 1, 1),
(@Charscale_Invoker25N, 36064, 30, 1, 12, 1, 1),
(@Charscale_Invoker25N, 36062, 30, 1, 1, 1, 1),
(@Charscale_Invoker25N, 36173, 30, 1, 2, 1, 1),
(@Charscale_Invoker25N, 36289, 30, 1, 3, 1, 1),
(@Charscale_Invoker25N, 33568, 30, 1, 4, 1, 1),
(@Charscale_Invoker25N, 33448, 30, 1, 5, 1, 1),
(@Charscale_Invoker10N, 36164, 30, 1, 6, 1, 1),
(@Charscale_Invoker25N, 36164, 30, 1, 7, 1, 1),
(@Charscale_Invoker10HC, 36387, 30, 1, 8, 1, 1),
(@Charscale_Invoker10HC, 39152, 30, 1, 9, 1, 1),
(@Charscale_Invoker10N, 36290, 30, 1, 10, 1, 1),
(@Charscale_Invoker25N, 36290, 30, 1, 11, 1, 1),
(@Charscale_Invoker10HC, 36290, 30, 1, 12, 1, 1),
(@Charscale_Invoker25HC, 36290, 30, 1, 1, 1, 1),
(@Charscale_Invoker25HC, 33431, 30, 1, 2, 1, 1),
(@Charscale_Invoker25HC, 33422, 30, 1, 3, 1, 1),
(@Charscale_Invoker25HC, 36391, 30, 1, 4, 1, 1),
(@Charscale_Invoker25HC, 43508, 30, 1, 5, 1, 1),
(@Charscale_Invoker25HC, 36402, 30, 1, 6, 1, 1),
(@Charscale_Invoker25HC, 36682, 30, 1, 7, 1, 1),
(@Charscale_Invoker25HC, 36276, 30, 1, 8, 1, 1),
(@Charscale_Invoker25HC, 36056, 30, 1, 9, 1, 1),
(@Charscale_Invoker25HC, 33381, 30, 1, 10, 1, 1),
(@Charscale_Invoker25HC, 33383, 30, 1, 11, 1, 1),
(@Charscale_Invoker25HC, 36500, 30, 1, 12, 1, 1),
(@Charscale_Invoker25HC, 36176, 30, 1, 1, 1, 1),
(@Charscale_Invoker25HC, 36282, 30, 1, 2, 1, 1),
(@Charscale_Invoker25HC, 36051, 30, 1, 3, 1, 1),
(@Charscale_Invoker25HC, 33429, 30, 1, 4, 1, 1),
(@Charscale_Invoker25HC, 36392, 30, 1, 5, 1, 1),
(@Charscale_Invoker25HC, 33380, 30, 1, 6, 1, 1),
(@Charscale_Invoker25HC, 36527, 30, 1, 7, 1, 1),
(@Charscale_Invoker25HC, 45912, 30, 1, 8, 1, 1),
(@Charscale_Invoker25HC, 36709, 30, 1, 9, 1, 1),
(@Charscale_Invoker25HC, 33447, 30, 1, 10, 1, 1),
(@Charscale_Invoker10N, 36443, 30, 1, 11, 1, 1),
(@Charscale_Invoker25N, 36443, 30, 1, 12, 1, 1),
(@Charscale_Invoker10HC, 36443, 30, 1, 1, 1, 1),
(@Charscale_Invoker25HC, 36443, 30, 1, 2, 1, 1),
(@Charscale_Invoker25N, 43510, 30, 1, 3, 1, 1),
(@Charscale_Invoker25HC, 43510, 30, 1, 4, 1, 1),
(@Charscale_Invoker25N, 43507, 30, 1, 5, 1, 1),
(@Charscale_Invoker25HC, 43507, 30, 1, 6, 1, 1),
(@Charscale_Invoker25N, 36055, 30, 1, 7, 1, 1),
(@Charscale_Invoker25HC, 36055, 30, 1, 8, 1, 1),
(@Charscale_Invoker10N, 33470, 30, 1, 9, 1, 1),
(@Charscale_Invoker25N, 33470, 30, 1, 10, 1, 1),
(@Charscale_Invoker10HC, 33470, 30, 1, 11, 1, 1),
(@Charscale_Invoker25HC, 33470, 30, 1, 12, 1, 1),
(@Charscale_Invoker10N, 43852, 30, 1, 1, 1, 1),
(@Charscale_Invoker25N, 43852, 30, 1, 2, 1, 1),
(@Charscale_Invoker10HC, 43852, 30, 1, 3, 1, 1),
(@Charscale_Invoker25HC, 43852, 30, 1, 4, 1, 1),
(@Charscale_Invoker10N, 33454, 30, 1, 5, 1, 1),
(@Charscale_Invoker25N, 33454, 30, 1, 6, 1, 1),
(@Charscale_Invoker10HC, 33454, 30, 1, 7, 1, 1),
(@Charscale_Invoker25HC, 33454, 30, 1, 8, 1, 1),
(@Charscale_Invoker10N, 33445, 30, 1, 9, 1, 1),
(@Charscale_Invoker25N, 33445, 30, 1, 10, 1, 1),
(@Charscale_Invoker10HC, 33445, 30, 1, 11, 1, 1),
(@Charscale_Invoker25HC, 33445, 30, 1, 12, 1, 1);
