/* Trainer Spell fix.
Spell Control Pet from trainer doesnt work, changed to spell ID 93321
Spell Mail Specialization of Hunter from trainer doesnt work
Spell Mail Specialization of Shaman from trainer doesnt work
These correct them for the time being until a permanent solution comes from CPP

undo sql restore
UPDATE `trainer_spell` SET `SpellID` = 87506 WHERE `TrainerID` = 40 AND `SpellId` = 86528;
UPDATE `trainer_spell` SET `SpellID` = 79682 WHERE `TrainerID` = 40 AND `SpellId` = 93321;
UPDATE `trainer_spell` SET `SpellID` = 87507 WHERE `TrainerID` = 124 AND `SpellId` = 86529;
*/

-- Correct hunter spell trainer
UPDATE `trainer_spell` SET `SpellID` = 86528 WHERE `TrainerID` = 40 AND `SpellId` = 87506;
UPDATE `trainer_spell` SET `SpellID` = 93321 WHERE `TrainerID` = 40 AND `SpellId` = 79682;

-- Correct shaman spell trainer
UPDATE `trainer_spell` SET `SpellID` = 86529 WHERE `TrainerID` = 124 AND `SpellId` = 87507;