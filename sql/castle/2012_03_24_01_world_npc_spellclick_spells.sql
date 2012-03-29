-- make player cast spell on himself instead of creature on player for maloric / there's something about the squire
UPDATE npc_spellclick_spells SET cast_flags = 3 WHERE npc_entry = 33498 AND spell_id = 63126;
