-- Fix Quests 10182,10305,10306,10307
UPDATE item_template SET ScriptName="item_belmara_luminrath_frostweaver_dathric" WHERE entry IN(28336,28352,28353,34144);
UPDATE quest_template SET questflags=130,ReqCreatureOrGOId1=0,ReqCreatureOrGOCount1=0 WHERE entry IN(10305,10306,10307,10182);

DELETE FROM spell_script_names WHERE spell_id IN(34140,34142,34144,34141);
INSERT INTO spell_script_names VALUES
(34140,"spell_belmara_luminrath_frostweaver_dathric"),
(34142,"spell_belmara_luminrath_frostweaver_dathric"),
(34144,"spell_belmara_luminrath_frostweaver_dathric"),
(34141,"spell_belmara_luminrath_frostweaver_dathric");
