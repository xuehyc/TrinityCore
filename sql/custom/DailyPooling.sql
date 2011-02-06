-- //////////////////////////////////////////////////////
-- Northrend Normal Instance Dailys
INSERT INTO pool_template (entry,max_limit,description)
VALUES
(13240,1,'Normal Instance Northrend Daily');

DELETE FROM pool_quest WHERE pool_entry = 13240;
INSERT INTO pool_quest (entry, pool_entry, description)
VALUES
(13240,13240,'Timear Foresees Centrifuge Constructs in your Future!'),
(13241,13240,'Timear Foresees Ymirjar Berserkers in your Future!'),
(13243,13240,'Timear Foresees Infinite Agents in your Future!'),
(13244,13240,'Timear Foresees Titanium Vanguards in your Future!');

DELETE FROM creature_questrelation WHERE id = 31439;
INSERT INTO creature_questrelation (id,quest) VALUES
(31439,13240),
(31439,13241),
(31439,13243),
(31439,13244);

DELETE FROM creature_involvedrelation WHERE id = 31439;
INSERT INTO creature_involvedrelation (id,quest) VALUES
(31439,13240),
(31439,13241),
(31439,13243),
(31439,13244);

-- /////////////////////////////////////////////////////////////////
-- Outland Heroic Instance Dailys
DELETE FROM game_event WHERE entry IN (100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115);
DELETE FROM game_event_creature WHERE event IN (100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115);
DELETE FROM game_event_creature_quest WHERE event IN (100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115);

INSERT INTO pool_template (entry,max_limit,description)
VALUES
(11354,1,'Heroic Instance Outland Daily');

DELETE FROM pool_quest WHERE pool_entry = 11354;
INSERT INTO pool_quest (entry, pool_entry, description)
VALUES
(11369,11354,'Wanted: A Black Stalker Egg'),
(11384,11354,'Wanted: A Warp Splinter Clipping'),
(11382,11354,'Wanted: Aeonus\'s Hourglass'),
(11363,11354,'Wanted: Bladefist\'s Seal'),
(11362,11354,'Wanted: Keli\'dan\'s Feathered Stave'),
(11375,11354,'Wanted: Murmur\'s Whisper'),
(11354,11354,'Wanted: Nazan\'s Riding Crop'),
(11386,11354,'Wanted: Pathaleon\'s Projector'),
(11373,11354,'Wanted: Shaffar\'s Wondrous Pendant'),
(11378,11354,'Wanted: The Epoch Hunter\'s Head'),
(11374,11354,'Wanted: The Exarch\'s Soul Gem'),
(11372,11354,'Wanted: The Headfeathers of Ikiss'),
(11368,11354,'Wanted: The Heart of Quagmirran'),
(11388,11354,'Wanted: The Scroll of Skyriss'),
(11499,11354,'Wanted: The Signet Ring of Prince Kael\'thas'),
(11370,11354,'Wanted: The Warlord\'s Treatise');

DELETE FROM creature_questrelation WHERE id = 24369;
INSERT INTO creature_questrelation (id,quest) VALUES
(24369,11369),
(24369,11384),
(24369,11382),
(24369,11363),
(24369,11362),
(24369,11375),
(24369,11354),
(24369,11386),
(24369,11373),
(24369,11378),
(24369,11374),
(24369,11372),
(24369,11368),
(24369,11388),
(24369,11499),
(24369,11370);

DELETE FROM creature_involvedrelation WHERE id = 24369;
INSERT INTO creature_involvedrelation (id,quest) VALUES
(24369,11369),
(24369,11384),
(24369,11382),
(24369,11363),
(24369,11362),
(24369,11375),
(24369,11354),
(24369,11386),
(24369,11373),
(24369,11378),
(24369,11374),
(24369,11372),
(24369,11368),
(24369,11388),
(24369,11499),
(24369,11370);

-- /////////////////////////////////////////////////////////////////
-- Outland Normal Instance Dailys
DELETE FROM game_event WHERE entry IN (116,117,118,119,120,121,122);
DELETE FROM game_event_creature WHERE event IN (116,117,118,119,120,121,122);
DELETE FROM game_event_creature_quest WHERE event IN (116,117,118,119,120,121,122);

INSERT INTO pool_template (entry,max_limit,description)
VALUES
(11500,1,'Normal Instance Outland Daily');

DELETE FROM pool_quest WHERE pool_entry = 11500;
INSERT INTO pool_quest (entry, pool_entry, description)
VALUES
(11371,11500,'Wanted: Coilfang Myrmidons'),
(11385,11500,'Wanted: Sunseeker Channelers'),
(11500,11500,'Wanted: Sisters of Torment'),
(11364,11500,'Wanted: Shattered Hand Centurions'),
(11387,11500,'Wanted: Tempest-Forge Destroyers'),
(11389,11500,'Wanted: Arcatraz Sentinels'),
(11383,11500,'Wanted: Rift Lords'),
(11376,11500,'Wanted: Malicious Instructors');

DELETE FROM creature_questrelation WHERE id = 24370;
INSERT INTO creature_questrelation (id,quest) VALUES
(24370,11371),
(24370,11385),
(24370,11500),
(24370,11364),
(24370,11387),
(24370,11389),
(24370,11383),
(24370,11376);

DELETE FROM creature_involvedrelation WHERE id = 24370;
INSERT INTO creature_involvedrelation (id,quest) VALUES
(24370,11371),
(24370,11385),
(24370,11500),
(24370,11364),
(24370,11387),
(24370,11389),
(24370,11383),
(24370,11376);

-- /////////////////////////////////////////////////////////////////
-- Outland Cooking Dailys
INSERT INTO pool_template (entry,max_limit,description)
VALUES
(11377,1,'Outland Cooking Daily');

DELETE FROM pool_quest WHERE pool_entry = 11377;
INSERT INTO pool_quest (entry, pool_entry, description)
VALUES
(11380,11377,'Manalicious'),
(11377,11377,'Revenge is Tasty'),
(11381,11377,'Soup for the Soul'),
(11379,11377,'Super Hot Stew');

DELETE FROM creature_questrelation WHERE id = 24393;
INSERT INTO creature_questrelation (id,quest) VALUES
(24393,11380),
(24393,11377),
(24393,11381),
(24393,11379);

DELETE FROM creature_involvedrelation WHERE id = 24393;
INSERT INTO creature_involvedrelation (id,quest) VALUES
(24393,11380),
(24393,11377),
(24393,11381),
(24393,11379);

-- /////////////////////////////////////////////////////////////////
-- Outland Fishing Dailys
INSERT INTO pool_template (entry,max_limit,description)
VALUES
(11665,1,'Outland Fishing Daily');

DELETE FROM pool_quest WHERE pool_entry = 11665;
INSERT INTO pool_quest (entry, pool_entry, description)
VALUES
(11666,11665,'Bait Bandits'),
(11665,11665,'Crocolisks in the City'),
(11669,11665,'Felblood Fillet'),
(11668,11665,'Shrimpin\' Ain\'t Easy'),
(11667,11665,'Soup for the Soul');

DELETE FROM creature_questrelation WHERE id = 25580;
INSERT INTO creature_questrelation (id,quest) VALUES
(25580,11666),
(25580,11665),
(25580,11669),
(25580,11668),
(25580,11667);

DELETE FROM creature_involvedrelation WHERE id = 25580;
INSERT INTO creature_involvedrelation (id,quest) VALUES
(25580,11666),
(25580,11665),
(25580,11669),
(25580,11668),
(25580,11667);
