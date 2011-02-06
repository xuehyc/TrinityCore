
-- set scriptnames for quest #12644 (still at it)

UPDATE creature_template SET scriptname = 'npc_tipsy_mcmanus' where entry = 28566;
UPDATE gameobject_template SET scriptname = 'go_brew_event' where entry in (190635,190636,190637,190638,190639);