UPDATE creature SET curhealth='4056' WHERE  guid=21001459;

DELETE FROM creature_addon WHERE guid=21001459;
INSERT INTO creature_addon (guid, path_id, mount, bytes1, bytes2, emote, aiAnimKit, movementAnimKit, meleeAnimKit, auras) VALUES
(21001459, 0, 0, 50331648, 1, 0, 0, 0, 0, ''); -- 55786