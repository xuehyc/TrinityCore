-- set scripts, fix unit flags, etc.
UPDATE creature_template SET unit_flags = 32832 WHERE entry = 28668;
UPDATE creature_template SET Health_Mod = 9.2, ScriptName = 'npc_zepik_jaloot' WHERE entry IN (28667, 28668);
UPDATE creature_template SET ScriptName = 'npc_artruis' WHERE entry = 28659;

-- remove jaloot&zepik from end relation for a hero's burden, end is phylactery only!
DELETE FROM creature_involvedrelation WHERE quest = 12581;
-- correct quest turnin for hero of frenzyheart / hand of oracle quests
DELETE FROM creature_involvedrelation WHERE quest IN (12582, 12689);
INSERT INTO creature_involvedrelation (id, quest) VALUES
(28667, 12689),
(28668, 12582);

-- hero of frenzyheart / hand of oracle are qutocomplete, same quest giver and turn in npc
UPDATE quest_template SET Method = 0 WHERE Id in(12582, 12689);

DELETE FROM `creature_text` WHERE `entry` IN (28659, 28668, 28667);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
-- Artruis
(28659, 0, 0, 'Ah, the heroes. Your little friends said you would come. This certainly saves me the trouble of hunting you down myself.', 14, 0, 100, 0, 0, 0, ''),
(28659, 1, 0, 'I\'ve weathered a hundred years of war and suffering. Do you truly think it wise to pit your mortal bodies against a being that cannot die? I\'d venture you have more to loose.', 14, 0, 100, 0, 0, 0, ''),
(28659, 2, 0, 'Even shattered in countless pieces, the crystals all around weaken me... perhaps I should not have underestimated the titans so...', 14, 0, 100, 0, 0, 0, ''),
(28659, 3, 0, 'These two brave, ignorant fools despise each other, yet somehow they both spoke of you as heroes. Perhaps you just lack the will to choose a side... let me extend you that opportunity.', 14, 0, 100, 0, 0, 0, ''),
(28659, 4, 0, 'Artruis is shielded. You must choose your side quickly to break his spell.', 41, 0, 100, 0, 0, 0, ''),
(28659, 5, 0, 'Arthas once mustered strength... of the very same sort... perhaps his is the path you will follow.', 14, 0, 100, 0, 0, 0, ''),
-- Zepik
(28668, 0, 0, 'You going die big bad undead thing. You not catch Zepik sleeping this time!', 12, 0, 100, 0, 0, 0, ''),
-- Jaloot
(28667, 0, 0, 'Now you not catch us with back turned. Now we hurt you bad undead. BAD!', 12, 0, 100, 0, 0, 0, '');

-- spawn phylactery, workaround for miserable spell >.<
DELETE FROM gameobject WHERE id = 190777;
INSERT INTO gameobject (id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(190777, 571, 1, 1, 5610.05, 3789.69, -91.184, 5.8553, 0, 0, 0.212312, -0.977202, 300, 0, 1);

-- set implicit spell target for Bindings of Submission
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 13 AND SourceEntry = 52185;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES 
(13,0,52185,0,0,18,0,1,28667,0,0,0,'','Bindings of Submission - Implict Target Jaloot'),
(13, 0, 52185, 0, 0, 18, 0, 1, 28668, 0, 0, 0, '', 'Bindings of Submission - Implict Target Zepik');