
--
-- fix console message spell_hun_steady_shot did not match DBC effect Data 
--

--
-- change trainigs dummy MonsterKillCredit 44175 from hunter_spell to TrainingsDumy 44389
--
update creature_template set unit_flags=131076,AIName="",ScriptName="npc_trainigs_dummy_coldridge_valley" where entry=44389;

delete from spell_script_names where spell_id=2098; -- rogue
delete from spell_script_names where spell_id=5143; -- mage
delete from spell_script_names where spell_id=348; --  warlock




