DELETE FROM `creature_template_spell` WHERE (`CreatureID`=417 AND `Index` IN (6,5,4,3,2,1,0)) OR (`CreatureID`=1863 AND `Index` IN (7,6,5,4,3,2,1,0)) OR (`CreatureID`=63508 AND `Index` IN (4,3,2,1,0)) OR (`CreatureID`=73967 AND `Index` IN (5,4,3,2,1,0)) OR (`CreatureID` IN (92957,100959,109827,112919,165192) AND `Index`=0) OR (`CreatureID` IN (160974,162682,170856,171776,171782,178099,184952) AND `Index` IN (1,0)) OR (`CreatureID` IN (172483,179580) AND `Index` IN (3,2,1,0)) OR (`CreatureID` IN (113063,113101,178685,178699,181453,183667) AND `Index` IN (2,1,0));
INSERT INTO `creature_template_spell`(`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES 
(417, 0, 1, 44730), -- Felhunter
(417, 1, 4, 44730), -- Felhunter
(417, 3, 54049, 44730), -- Felhunter
(417, 2, 19647, 44730), -- Felhunter
(417, 4, 19505, 44730), -- Felhunter
(417, 5, 3, 44730), -- Felhunter
(417, 6, 4, 44730), -- Felhunter
(1863, 0, 1, 44730), -- Succubus
(1863, 1, 4, 44730), -- Succubus
(1863, 2, 6360, 44730), -- Succubus
(1863, 3, 7814, 44730), -- Succubus
(1863, 4, 6358, 44730), -- Succubus
(1863, 5, 7870, 44730), -- Succubus
(1863, 6, 3, 44730), -- Succubus
(1863, 7, 4, 44730), -- Succubus
(63508, 4, 4, 44730), -- Xuen
(63508, 3, 3, 44730), -- Xuen
(63508, 2, 124007, 44730), -- Xuen
(63508, 1, 4, 44730), -- Xuen
(63508, 0, 1, 44730), -- Xuen
(73967, 0, 1, 44730), -- Niuzao
(73967, 1, 4, 44730), -- Niuzao
(73967, 2, 196728, 44730), -- Niuzao
(73967, 3, 227291, 44730), -- Niuzao
(73967, 4, 3, 44730), -- Niuzao
(73967, 5, 4, 44730), -- Niuzao
(92957, 0, 186276, 44730), -- Skyfire Deck Gun
(100959, 0, 199402, 44730), -- Unattended Cannon
(109827, 0, 221420, 44730), -- Subdued Nightwing
(112919, 0, 224264, 44730), -- Illidan Stormrage
(113063, 0, 224518, 44730), -- Illidan Stormrage
(113063, 1, 224450, 44730), -- Illidan Stormrage
(113063, 2, 224264, 44730), -- Illidan Stormrage
(113101, 0, 224518, 44730), -- Illidan Stormrage
(113101, 1, 224450, 44730), -- Illidan Stormrage
(113101, 2, 224264, 44730), -- Illidan Stormrage
(160974, 1, 313757, 44730), -- Repaired Goliath
(160974, 0, 313790, 44730), -- Repaired Goliath
(162682, 0, 316689, 44730), -- Ben Howell
(162682, 1, 316696, 44730), -- Ben Howell
(165192, 0, 324273, 44730), -- Willowblossom
(170856, 0, 322745, 44730), -- Highland Runestag
(170856, 1, 323229, 44730), -- Highland Runestag
(171776, 1, 335876, 44730), -- Battlesewn Roc
(171776, 0, 335283, 44730), -- Battlesewn Roc
(171782, 1, 335876, 44730), -- Battlesewn Roc
(171782, 0, 335283, 44730), -- Battlesewn Roc
(172483, 0, 337445, 44730), -- Ravenous Devourer
(172483, 1, 337414, 44730), -- Ravenous Devourer
(172483, 2, 337946, 44730), -- Ravenous Devourer
(172483, 3, 337457, 44730), -- Ravenous Devourer
(178099, 0, 359733, 44730), -- Cervid Protector
(178099, 1, 190329, 44730), -- Cervid Protector
(178685, 2, 354607, 44730), -- Creep
(178685, 1, 354600, 44730), -- Creep
(178685, 0, 354255, 44730), -- Creep
(178699, 0, 354255, 44730), -- Creep
(178699, 1, 354600, 44730), -- Creep
(178699, 2, 354607, 44730), -- Creep
(179580, 0, 354666, 44730), -- Prototype Colossus
(179580, 1, 354667, 44730), -- Prototype Colossus
(179580, 2, 354801, 44730), -- Prototype Colossus
(179580, 3, 354668, 44730), -- Prototype Colossus
(181453, 0, 359763, 44730), -- Motivated Constructor
(181453, 1, 359747, 44730), -- Motivated Constructor
(181453, 2, 361890, 44730), -- Motivated Constructor
(183667, 0, 362811, 44730), -- Pocopoc
(183667, 1, 362818, 44730), -- Pocopoc
(183667, 2, 362821, 44730), -- Pocopoc
(184952, 0, 363586, 44730), -- Nascence Attendant
(184952, 1, 363294, 44730); -- Nascence 

UPDATE `creature_template_spell` SET `Spell`=47481, `VerifiedBuild`=44730 WHERE (`CreatureID`=26125 AND `Index`=3); -- Risen Ghoul
UPDATE `creature_template_spell` SET `Spell`=47468, `VerifiedBuild`=44730 WHERE (`CreatureID`=26125 AND `Index`=2); -- Risen Ghoul
UPDATE `creature_template_spell` SET `Spell`=4, `VerifiedBuild`=44730 WHERE (`CreatureID`=26125 AND `Index`=1); -- Risen Ghoul
UPDATE `creature_template_spell` SET `Spell`=1, `VerifiedBuild`=44730 WHERE (`CreatureID`=26125 AND `Index`=0); -- Risen Ghoul
UPDATE `creature_template_spell` SET `VerifiedBuild`=44730 WHERE (`CreatureID`=26125 AND `Index` IN (7,6,5,4));
