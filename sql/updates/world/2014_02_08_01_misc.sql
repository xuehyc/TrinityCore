
-- fix all trainings dummy on the different startareas

-- npc 46363 
-- wrong questgiver, over all questmarks
delete from creature_queststarter where id=46363 and quest=27670;

-- quest autocomplete
UPDATE quest_template SET Flags=524288,SpecialFlags=4 WHERE Id=28169;

-- trainings dummy has wrong flags
update creature_template set unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=44171;

-- trainings dummy has wrong auras death
update creature_addon set auras="" where guid in (61301,61507,61975,62598,62661,62978,63262);

-- trainings dummy has wrong flags
update creature_template set KillCredit1=44175,unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=42328;

-- trainings dummy has wrong flags
update creature_template set unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=44548; --  Elwynn Forest

-- trainings dummy has wrong flags
update creature_template set unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=44614; -- Teldrassil
-- trainings dummy has wrong auras death
update creature_addon set auras="" where guid in (select guid from creature where id=44614);

-- wronc race mask, autocomplete
UPDATE quest_template SET Method=2,SpecialFlags=4,RequiredRaces=1101 WHERE Id=9287;
update quest_template set RequiredRaces=1101 where Id=26966;

-- trainings dummy has wrong flags
update creature_template set KillCredit1=44175,unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=44703; --  Am'memtal

-- trainings dummy has wrong flags
update creature_template set unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=44820; -- Valley of Trials

-- quest 25143 wrong kill credit 
update quest_template set RequiredNpcOrGo1=44175 where Id=25143;

-- trainings dummy has wrong flags
update creature_template set unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=44794; -- Tirisfall

-- trainings dummy has wrong flags
update creature_template set unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=44848; -- camp narache

update creature_template set AIName="",ScriptName="npc_wounded_brave" where entry=45199;

-- trainings dummy has wrong flags
update creature_template set unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=38038; -- Echo Isles

-- quest 24751 wrong kill credit
UPDATE quest_template SET RequiredNpcOrGo1=44175 WHERE Id=24751;

-- trainings dummy has wrong flags
update creature_template set unit_flags=131076,unit_flags2=0,flags_extra=66,AIName="",ScriptName="npc_trainings_dummy" where entry=44937; -- Sunstrider Isle 
-- trainings dummy has wrong auras death
update creature_addon set auras="" where guid in (161066,161067,161203);






