

-- Ashenvale

-- 
-- quest Of Their Own Design
--
-- autocomplete
UPDATE quest_template SET Method=2,RequiredSourceItemId1=0,RequiredSourceItemId2=0,RequiredSourceItemCount1=0,RequiredSourceItemCount2=0  WHERE Id=13595;

-- GO 194202 quest not set
update gameobject_template set flags=0,data0=43,data8=13595 where entry=194202;

-- spell 62506 Potion of Wildfire not working, 
delete from spell_script_names where spell_id=62506;
insert into spell_script_names values (62506,"spell_potion_of_wildfire");

--
-- quest 13594 Don't Forget the Horde
--
update creature_template set KillCredit1=3734 where entry=3733;

--
-- quest 13602 Naga of the Strand
--
update creature_template set KillCredit1=3711 where entry in (3712,3713,3715,3717,3944);

--
-- quest 13624 A Squad of Your Own
--
UPDATE quest_template SET Method=2 WHERE Id=13624;

--
-- quest 13642 Bathed in Light
--
UPDATE quest_template SET Method=2 WHERE Id=13642;
delete from spell_script_names where spell_id=62981;
insert into spell_script_names values (62981,"spell_unbathed_concoction");

--
-- quest 13630 The Reason Why
--
UPDATE quest_template SET Method=2,RequiredNpcOrGo1=-194309,RequiredNpcOrGo2=-194310,RequiredNpcOrGo3=-194311,RequiredNpcOrGoCount1=1,RequiredNpcOrGoCount2=1,RequiredNpcOrGoCount3=1 WHERE Id=13630;

--
-- quest 13626 Respect for the Fallen
--
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=13626;
update creature_template set AIName="",unit_flags=768,dynamicflags=1,ScriptName="npc_delgren_the_purifier" where entry=33347;
update creature_template set AIName="",unit_flags=768,dynamicflags=1,ScriptName="npc_feero_ironhand" where entry=33348;

--
-- quest 13849 Astranaar's Burning!
--
UPDATE quest_template SET Method=2 WHERE Id=13849;

--
-- quest 8725 Riversong the Elder
--
UPDATE quest_template SET Method=2,Level=0 WHERE Id=8725;












