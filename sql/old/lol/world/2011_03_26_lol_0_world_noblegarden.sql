-- Fix for noblegarden eggs and npc
REPLACE INTO game_event_gameobject SELECT 9, guid FROM gameobject WHERE id IN (113768, 113769, 113770, 113771);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES (9, 410015);
