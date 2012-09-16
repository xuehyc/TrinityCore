-- add support for murloc dedicated insanity check gossip text
DELETE FROM npc_text WHERE ID = 50031;
INSERT INTO npc_text (ID, text0_0, text0_1) VALUES 
(50031, 'Der sichere Wahnsinn soll es also sein?$BDann schauen wir mal wie es um eure Ausrüstung steht.', 'Der sichere Wahnsinn soll es also sein?$BDann schauen wir mal wie es um eure Ausrüstung steht.');