-- Fix Item - Druid T10 Balance 2P Bonus
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 70721;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 70721, 0, 1, 70718, 0, 0, 0, '', 'Item - Druid T10 Balance 2P Bonus - Omen of Doom can only be activated if has T10 aura');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 16870 AND `spell_effect` = 70721;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(16870, 70721, 0, 'Item - Druid T10 Balance 2P Bonus - Omen of Doom activated on clearcasting trigger');

-- Fix Item - Rogue T10 2P Bonus
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 70804;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 70804, 0, 1, 70805, 0, 0, 0, '', 'Item - Rogue T10 2P Bonus - +15 Energy only activated if has T10 aura');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 57934 AND `spell_effect` = 70804;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(57934, 70804, 0, 'Item - Rogue T10 2P Bonus - +15 Energy on Trick of Trade trigger');

-- Fix Item - Paladin T10 Holy 2P Bonus
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 71166;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 71166, 0, 1, 70755, 0, 0, 0, '', 'Item - Paladin T10 Holy 2P Bonus - +35% heal only activated if has T10 aura');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 31842 AND `spell_effect` = 71166;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(31842, 71166, 0, 'Item - Paladin T10 Holy 2P Bonus - +35% heal on Divine Favor trigger');

-- Fix Item - Shaman T10 Elemental 4P Bonus
DELETE FROM `spell_script_names` WHERE `spell_id` IN (51505, 60043);
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(51505, 'spell_sha_lava_burst_t10_effect'),
(60043, 'spell_sha_lava_burst_t10_effect');

-- Fix Item - Warrior T10 Protection 4P Bonus
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 70845;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 70845, 0, 1, 70844, 0, 0, 0, '', 'Item - Warrior T10 Melee 4P Bonus - Stoicism only activated if has T10 aura');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 2687 AND `spell_effect` = 70845;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(2687, 70845, 0, 'Item - Warrior T10 Protection 4P Bonus - Stoicism on Frenzy trigger');
DELETE FROM `spell_script_names` WHERE `spell_id` = 70845;
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(70845, 'spell_warr_tank_t10_effect');