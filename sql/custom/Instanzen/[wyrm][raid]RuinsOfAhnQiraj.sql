-- Trigger für Kurinnax präperieren ... kann auch für alle anderen Bosse genutzt werden nun (ist Ahn'Qiraj Trigger und wird in TDB nicht verwendet)
UPDATE creature_template SET minlevel = 63 , maxlevel = 63 , faction_A = 14  , faction_H = 14  , flags_extra = 130 WHERE entry = 15426;



-- uPDATE ScriptName
-- Kurinnaxx
UPDATE creature_template SET ScriptName = "boss_kurinnaxx" WHERE entry = 15348;