-- Fix Shadowmeld leaving combat completely, restore aggro, if possible
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 58984 AND `spell_effect` = 59646;