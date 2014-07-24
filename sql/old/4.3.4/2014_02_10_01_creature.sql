-- sets the phaseMask for the npcs "Jungle Serpent" and "Bambala Headhunter" to 2! (players under level 80 have no chance against these enemys!)
-- and they're not used atm for any quest so phase 2 is a good way to make them invisible without removing them...

UPDATE `creature` SET `phaseMask`=2 WHERE `id`=52224;
UPDATE `creature` SET `phaseMask`=2 WHERE `id`=52982;

-- If you want to undoing this remove this "--" in front of the following lines.

-- UPDATE `creature` SET `phaseMask`=1 WHERE `id`=52982;
-- UPDATE `creature` SET `phaseMask`=1 WHERE `id`=52224;
