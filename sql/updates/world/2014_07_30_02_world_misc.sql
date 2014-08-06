

-- frostmane troll,frostmane hedhunter,frostmane snowstriger,frostmane shadowcaster
UPDATE creature_template SET minlevel=3,maxlevel=4,mindmg=5.7,maxdmg=7.6,attackpower=53,minrangedmg=1.9,maxrangedmg=3.8,rangedattackpower=0 WHERE entry=1120;
UPDATE creature_template SET minlevel=3,maxlevel=4,mindmg=5.7,maxdmg=7.6,attackpower=53,minrangedmg=1.9,maxrangedmg=3.8,rangedattackpower=0 WHERE entry=1123;
UPDATE creature_template SET minlevel=3,maxlevel=4,mindmg=5.7,maxdmg=7.6,attackpower=53,minrangedmg=1.9,maxrangedmg=3.8,rangedattackpower=0 WHERE entry=1121;
UPDATE creature_template SET minlevel=3,maxlevel=4,mindmg=5.7,maxdmg=7.6,attackpower=53,minrangedmg=1.9,maxrangedmg=3.8,rangedattackpower=0 WHERE entry=1124;
UPDATE creature_template SET minlevel=3,maxlevel=4,mindmg=5.7,maxdmg=7.6,attackpower=53,minrangedmg=1.9,maxrangedmg=3.8,rangedattackpower=0 WHERE entry=1122;

-- Tentacle of the old ones
UPDATE creature_template SET mindmg=957.1,maxdmg=1274.1,attackpower=1530,minrangedmg=957.1,maxrangedmg=1274.1,rangedattackpower=1530,minlevel=85,maxlevel=85,exp=0 WHERE entry=58078;

-- Rockjaw invader
UPDATE creature_template SET unit_flags=0 WHERE entry=37070;

-- http://www.wowhead.com/quest=26997/sospechosos-habituales
UPDATE creature_template SET unit_flags=0 WHERE entry=29152;

-- Dormus the camelhoarder
UPDATE creature_template SET dynamicflags=0,Health_mod=3 WHERE entry=50245;


