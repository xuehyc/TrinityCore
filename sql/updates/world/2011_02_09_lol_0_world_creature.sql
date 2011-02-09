## spawn Lovely Merchant
SET @npc_lovely_merchant    = 37674;
SET @guid                   = 1690610;
SET @event                  = 8;

REPLACE INTO `creature` (`guid`,  `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
 (@guid+0, 37674, 1, 1, 1, 0, 0,  1654.19, -4436.26,   18.008, 2.07106, 300, 0, 0, 2138, 0, 0, 0, 0, 0, 0),     -- Orgrimmar
 (@guid+1, 37674, 0, 1, 1, 0, 0,  1636.33,  224.987, -43.1032, 2.97447, 300, 0, 0, 1716, 0, 0, 0, 0, 0, 0),     -- Undercity
 (@guid+2, 37674, 0, 1, 1, 0, 0, -4896.46, -964.897,  501.444, 2.57495, 300, 0, 0, 1716, 0, 0, 0, 0, 0, 0),     -- Ironforge
 (@guid+3, 37674, 0, 1, 1, 0, 0, -8821.54,  650.451,  94.8971, 4.94836, 300, 0, 0, 1990, 0, 0, 0, 0, 0, 0);     -- Stormwind

-- Link creatures with Event
REPLACE INTO `game_event_creature` (`guid`, `event`) VALUES
 (@guid+0, @event),
 (@guid+1, @event),
 (@guid+2, @event),
 (@guid+3, @event);