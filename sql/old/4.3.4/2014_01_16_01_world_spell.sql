
--  http://www.wowhead.com/spell=348  Immolate
-- this spell is needed for Warlock quest on training dummy

delete from spell_script_names where spell_id=348;
insert into spell_script_names values (348,"spell_warl_immolate");

--  http://www.wowhead.com/spell=2061  Flash Heal
-- this spell is needed for priest quest on healing wounded trainee

delete from spell_script_names where spell_id=2061;
insert into spell_script_names values (2061,"spell_pri_flash_heal");

--  http://www.wowhead.com/spell=2098  Eviscerate
-- this spell is needed for rogue quest on training dummy

delete from spell_script_names where spell_id=2098;
insert into spell_script_names values (2098,"spell_rog_eviscerate");

--  http://www.wowhead.com/spell=5143  Arcane Missiles
-- this spell is needed for mage quest on training dummy

delete from spell_script_names where spell_id=5143;
insert into spell_script_names values (5143,"spell_mage_arcane_missiles");

