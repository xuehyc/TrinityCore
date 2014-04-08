-- Fix for the last boss in deadmines
-- thanks goes to Myst5 in forums

UPDATE `creature_template` SET `mechanic_immune_mask`='650854235', `flags_extra`='1' WHERE (`entry`='49541');
