
-- http://www.wowhead.com/npc=4079	Sentinel Thenysil
-- on quest reward, remove aura 64572 "see invisible 1" from player (done by script)
-- https://www.youtube.com/watch?v=FphJBZf8wh0

UPDATE creature_template SET AIName="",ScriptName="npc_sentinel_thenysil" WHERE entry=4079;
