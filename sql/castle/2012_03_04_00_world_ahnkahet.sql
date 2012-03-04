-- remove unnecessary spell triggers for amanitar, mini<->potent_fungus relationship is handled in boss script now
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (56648, 57055);
