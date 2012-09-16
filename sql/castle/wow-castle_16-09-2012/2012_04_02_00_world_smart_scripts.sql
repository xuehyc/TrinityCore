-- Fix for Q 12291: The forgotten tale.
-- @DorianGrey: I've changed the npc's gossip-behavior to give a kill-credit corresponding to the defined bunnys 
-- instead of casting a non-working spell that would - ironically - do the same.
UPDATE `smart_scripts` SET `action_type`=33, `action_param1`=27473 WHERE `entryorguid`=27224 AND `source_type`=0 AND `id`=0 AND `link`=1;
UPDATE `smart_scripts` SET `action_type`=33, `action_param1`=27471 WHERE `entryorguid`=27225 AND `source_type`=0 AND `id`=0 AND `link`=1;
UPDATE `smart_scripts` SET `action_type`=33, `action_param1`=27472 WHERE `entryorguid`=27226 AND `source_type`=0 AND `id`=0 AND `link`=1;
UPDATE `smart_scripts` SET `action_type`=33, `action_param1`=27474 WHERE `entryorguid`=27229 AND `source_type`=0 AND `id`=0 AND `link`=1;