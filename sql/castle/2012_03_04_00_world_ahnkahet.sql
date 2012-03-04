-- remove unnecessary spell triggers for amanitar, mini<->potent_fungus relationship is handled in boss script now
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (56648, 57055);

-- remove trigger model for flame spheres in taldaram and jedoga encounter
UPDATE `creature_template` SET `modelid2` = 0 WHERE `entry` IN (30106, 31686, 31687, 31458);
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0 WHERE `entry` = 30181;