
-- mulgore

-- exist on moon
delete from creature where guid=75902;

update creature_template set unit_flags=512,dynamicflags=0,AIName="",ScriptName="npc_fledgling_brave" where entry=36942;
update creature_template set unit_flags=512,dynamicflags=0,AIName="",ScriptName="npc_bristleback_invader" where entry=36943;




