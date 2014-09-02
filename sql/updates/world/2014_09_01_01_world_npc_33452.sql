
-- http://www.wowhead.com/npc=33452	Avana's Nightsaber
-- the vehicle id is wrong..

update creature_template set AIName="", ScriptName="npc_avanas_nightsaber", VehicleId=25 where entry=33452;
UPDATE creature_template SET minlevel=20,maxlevel=21,unit_flags=134349699 WHERE entry=33452;

