
-- http://www.wowhead.com/npc=33338  	summon: Maestra's Post Sentinel

update creature_template set spell1=62818, AIName="",ScriptName="npc_maestras_post_sentinel" where entry=33338;
UPDATE creature_template SET flags_extra=32768 WHERE entry=33338;

delete from creature_equip_template where entry=33338 and id=1;
insert into creature_equip_template values
(33338,1,5598,15907,14118,18019);