-- set ScriptName for Wounded Skirmisher and Wounded Infantry in Grizzly Hills
UPDATE creature_template SET ScriptName = 'npc_wounded_skirmisher' WHERE entry IN (27482, 27463);