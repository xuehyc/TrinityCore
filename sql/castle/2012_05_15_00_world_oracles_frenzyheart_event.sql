-- set scripts, fix unit flags, etc.
UPDATE creature_template SET unit_flags = 32832 WHERE entry = 28668;
UPDATE creature_template SET ScriptName = 'npc_zepik_jaloot' WHERE entry IN (28667, 28668);
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