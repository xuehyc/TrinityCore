Update creature_template set faction_h = 776 and faction_a = 776 where entry in (15380,15379,15378,15502,15504,15503);
Update creature_template set scriptname = '' where entry = 15263;
update creature set spawntimesecs = '36000' where map = 531;
update creature set spawntimesecs = '72000' where map = 531 and id in (15263,15516,15510,15509,15276,15275,15727,15589,15543,15544,15511,15299,15517);
update creature_template set minlevel = 63 , maxlevel = 63 where entry in (15263,15516,15510,15509,15276,15275,15727,15589,15543,15544,15511,15299,15517);
