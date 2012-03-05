-- remove unnecessary spell triggers for amanitar, mini<->potent_fungus relationship is handled in boss script now
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (56648, 57055);

-- remove trigger model for flame spheres in taldaram and jedoga encounter
UPDATE `creature_template` SET `modelid2` = 0 WHERE `entry` IN (30106, 31686, 31687, 31458);
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0 WHERE `entry` = 30181;

-- Insert exit areatrigger for Ahnkahet
DELETE FROM `areatrigger_teleport` WHERE `id` = 5235;
INSERT INTO `areatrigger_teleport` (id, name, target_map, target_position_x, target_position_y, target_position_z, target_orientation) VALUES
(5235, 'Ahn\'kahet (Ausgang)', 571, 3641.84, 2032.94, 2.47, 1.178);

-- Set correct visuals for mushrooms in Amanitar encounter
UPDATE `creature_template` SET `modelid1` = 26981, `modelid2` = 0 WHERE `entry` IN (30391, 30435, 31461, 31462);

-- Amanitar should bind to instance on heroic
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 31463;