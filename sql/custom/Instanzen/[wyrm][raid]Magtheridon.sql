delete from creature_addon where guid in (select guid from creature where id = 17257);
delete from creature_addon where guid in (select guid from creature where id = 17256);
delete from creature where id = 17256;
delete from creature where id = 17376;
update creature_template set unit_flags = 0 and type_flags = 0 where entry = 17257;
update gameobject_template set flags = 0 where entry = 181713;

update creature_template set scriptname = "boss_magtheridon" where entry = 17257;
update creature_template set scriptname = "mob_hellfire_channeler" where entry = 17256;
update creature_template set scriptname = "go_manticron_cube" where entry = 181713;
update creature_template set scriptname = "mob_abyssal" where entry = 17454;