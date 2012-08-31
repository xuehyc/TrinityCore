-- Register spell-scripts
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62692, 63276, 63278, 63322, 63323);
INSERT INTO `spell_script_names` VALUES 
(62692,'spell_aura_of_despair_aura'),
(63276,'spell_mark_of_the_faceless_aura'),
(63278,'spell_mark_of_the_faceless_drain'),
(63323,'spell_saronite_vapors');

-- Update saronite animus entry. TODO: Check if its health-modifier is ok.
UPDATE `creature_template` SET `minlevel`=83, `maxlevel`=83, `mindmg`=480, `maxdmg`=700, `flags_extra`=1 WHERE `entry`=33524;

-- Achievements "I love the smell of saronite in the morning" and "Shadowdodger"
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10451, 10462, 10173, 10306);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10451, 11, 0, 0, 'achievement_i_love_the_smell_of_saronite_in_the_morning'), 
(10451, 12, 0, 0, ''), 
(10462, 11, 0, 0, 'achievement_i_love_the_smell_of_saronite_in_the_morning_25'), 
(10462, 12, 1, 0, ''),
(10173, 11, 0, 0, 'achievement_shadowdodger'), 
(10173, 12, 0, 0, ''), 
(10306, 11, 0, 0, 'achievement_shadowdodger_25'), 
(10306, 12, 1, 0, '');


