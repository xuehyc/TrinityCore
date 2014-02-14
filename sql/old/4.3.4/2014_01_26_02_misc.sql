

-- quest 28051  We All Scream for Ice Cream... and then Die!
UPDATE quest_template SET SourceSpellId=88478,RequiredSpell=0 WHERE Id=28051;

-- npc 47446  Dead Employee
update creature_template set npcflag=1,AIName="", ScriptName="npc_dead_employee" where entry=47446;








