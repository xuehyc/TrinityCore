-- Fix killcredit for quest 10506 A Dire Situation / Eine düstere Lage
-- Event script is activated by quest relevant quest item

DELETE FROM event_scripts WHERE id = 13584;
INSERT INTO event_scripts(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(13584,0,8,21176,0,0,0,0,0,0);

