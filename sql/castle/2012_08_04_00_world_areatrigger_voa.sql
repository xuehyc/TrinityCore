DELETE FROM areatrigger_teleport WHERE id = 5258;
DELETE FROM areatrigger_scripts WHERE entry = 5258;
INSERT INTO areatrigger_scripts (entry, ScriptName) VALUES
(5258, 'at_vault_of_archavon_entrance');