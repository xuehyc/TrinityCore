-- quest 39384
delete from creature_queststarter where id=95396 and quest=39384;
insert into creature_queststarter values (95396,39384);


-- Enter Moonclaw Cavern kill credit 99074 SAI, quest 39384
UPDATE creature_template SET flags_extra=128 WHERE entry=99074;
DELETE FROM creature WHERE id=99074;
insert into creature (guid, id, map, zoneId, areaId, spawnMask, phaseUseFlags, PhaseId, PhaseGroup, TerrainSwapMap, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, unit_flags2, unit_flags3, dynamicflags, ScriptName, VerifiedBuild) values
(20544504,99074,1220,0,0,1,0,0,0,0,0,0,2449.75,6138.53,158.77,6.25508,300,0,0,8,0,0,0,0,0,0,0,'',0);
UPDATE creature_template SET AIName='SmartAI' WHERE entry=99074;
DELETE FROM smart_scripts WHERE entryorguid=99074;
INSERT INTO smart_scripts(entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,
action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(99074,0,0,0,10,0,100,0,1,200,0,0,33,99074,0,0,0,0,0,18,20,0,0,0,0,0,0,'Within 1-200 Range Out of Combat LoS -Enter Moonclaw Cavern kill credit quest 39384');

delete from creature_questender where id=91650 and quest=39384;
insert into creature_questender values (91650,39384);