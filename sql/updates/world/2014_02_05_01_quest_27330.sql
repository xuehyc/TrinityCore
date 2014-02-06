
--
-- quest 27330 Invoking the Serpent
--
delete from spell_script_names where spell_id=84925;
insert into spell_script_names values (84925,"spell_shuhalo_artifacts");

-- Arikara is spawnet from script
delete from creature where guid=117678 and id=45447;

-- has zero values
update creature_template set modelid1=34507,faction_A=16,faction_H=16,minlevel=43,maxlevel=43,InhabitType=7,mindmg=74.4,maxdmg=98.4,attackpower=182,dmg_multiplier=1.7,minrangedmg=50.4,maxrangedmg=74.4,rangedattackpower=21 where entry=45447;

