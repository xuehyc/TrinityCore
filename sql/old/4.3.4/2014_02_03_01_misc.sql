
-- thousand needles

--
-- quest 28086  Free the Pridelings
--
-- npc is in cage..
update creature set SpawnDist=0,MovementType=0 where id=47481;
update creature_template set npcflag=1,AIName="",ScriptName="npc_highperch_prideling" where entry=47481;
-- npc sript is wrong
update creature_template set unit_flags=0,AIName="",ScriptName="" where entry=47479;
update creature_template set unit_flags=0,AIName="",ScriptName="" where entry=47485;
-- npc is not death
update creature_template_addon set auras=81376 where entry in(47479,47485);
-- ToDo: CoreBug??  the Z height on some npc is wrong, but shown correct from value..
-- ToDo: CoreBug??  the free npc Prideling is aggresiv to creature..fighting in the underground.. but should escord the player.. 

--
-- 28088 Release Heartrazor
--
-- Heartrazor is on rope.. so no movement..
update creature set SpawnDist=0, MovementType=0 where guid=81057;
-- ToDo: CoreBug Z height.. good to see here.. Heartrazor is flying on earth, but position_Z values are 7 yards above 
-- script for give credit if all 4 npc's are death
update creature_template set AIName="",ScriptName="npc_twilight_subduer" where entry=47487;






