-- bone spikes should be immune to grip effects
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask | 32 WHERE ScriptName = 'npc_bone_spike';