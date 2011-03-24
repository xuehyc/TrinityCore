-- Fix Teleport between Sholazar Basin and Un'Goro Crater
-- in conection with quests 'The Etymidian' (12548) and 'Back Through the Waygate' (12797)
DELETE FROM areatrigger_teleport WHERE id IN (5046,5047);
INSERT INTO areatrigger_teleport VALUES
(5046,'Teleport from Sholazar to Un`Goro',1,-6164.0117,-1329.0784,-170.5762,2.378), -- Sholazar Waygate
(5047,'Teleport from Un`Goro to Sholazar',571,4892.8154,5179.8438,-88.5301,0.376); -- Un`Goro Waygate 