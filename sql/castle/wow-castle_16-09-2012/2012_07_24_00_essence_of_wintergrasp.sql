SET @min_nh := 1;
SET @max_nh := 2;
SET @min_hc := 2;
SET @max_hc := 4;

-- 1) add aura to zones (taken from https://bitbucket.org/TCRC/patches/issue/19/essence-of-wintergrasp)
DELETE FROM spell_area WHERE spell IN (57940, 58045);
INSERT INTO spell_area VALUES 
(57940, 65, 0, 0, 0, 0, 0, 2, 1),
(57940, 66, 0, 0, 0, 0, 0, 2, 1),
(57940, 67, 0, 0, 0, 0, 0, 2, 1),
(57940, 206, 0, 0, 0, 0, 0, 2, 1),
(57940, 210, 0, 0, 0, 0, 0, 2, 1),
(57940, 394, 0, 0, 0, 0, 0, 2, 1),
(57940, 395, 0, 0, 0, 0, 0, 2, 1),
(57940, 1196, 0, 0, 0, 0, 0, 2, 1),
(57940, 2817, 0, 0, 0, 0, 0, 2, 1),
(57940, 3456, 0, 0, 0, 0, 0, 2, 1),
(57940, 3477, 0, 0, 0, 0, 0, 2, 1),
(57940, 3537, 0, 0, 0, 0, 0, 2, 1),
(57940, 3711, 0, 0, 0, 0, 0, 2, 1),
(57940, 4100, 0, 0, 0, 0, 0, 2, 1),
(57940, 4196, 0, 0, 0, 0, 0, 2, 1),
(57940, 4228, 0, 0, 0, 0, 0, 2, 1),
(57940, 4264, 0, 0, 0, 0, 0, 2, 1),
(57940, 4265, 0, 0, 0, 0, 0, 2, 1),
(57940, 4272, 0, 0, 0, 0, 0, 2, 1),
(57940, 4273, 0, 0, 0, 0, 0, 2, 1),
(57940, 4395, 0, 0, 0, 0, 0, 2, 1),
(57940, 4405, 0, 0, 0, 0, 0, 2, 1),
(57940, 4415, 0, 0, 0, 0, 0, 2, 1),
(57940, 4416, 0, 0, 0, 0, 0, 2, 1),
(57940, 4493, 0, 0, 0, 0, 0, 2, 1),
(57940, 4494, 0, 0, 0, 0, 0, 2, 1),
(57940, 4603, 0, 0, 0, 0, 0, 2, 1),
(57940, 4722, 0, 0, 0, 0, 0, 2, 1),
(57940, 4809, 0, 0, 0, 0, 0, 2, 1),
(57940, 4813, 0, 0, 0, 0, 0, 2, 1),
(57940, 4820, 0, 0, 0, 0, 0, 2, 1),
(58045, 4197, 0, 0, 0, 0, 0, 2, 1);

-- 2) add spell script eligibility check
DELETE FROM spell_script_names WHERE spell_id IN (57940, 58045);
-- INSERT INTO spell_script_names (spell_id, ScriptName) VALUES
-- (57940, 'spell_gen_essence_of_wintergrasp'),
-- (58045, 'spell_gen_essence_of_wintergrasp');

-- 3) add stone keeper's shard to northrend dungeon bosses
DELETE FROM creature_loot_template WHERE item = 43228;
INSERT creature_loot_template (entry, item, ChanceOrQuestChance, lootmode, groupid, minCountOrRef, maxcount) VALUES
(29309, 43228, 100, 1, 0, @min_nh, @max_nh), -- Elder Nadox
(31456, 43228, 100, 1, 0, @min_hc, @max_hc), 
(29308, 43228, 100, 1, 0, @min_nh, @max_nh), -- Prince Taldaram
(31469, 43228, 100, 1, 0, @min_hc, @max_hc), 
(31463, 43228, 100, 1, 0, @min_hc, @max_hc), -- Amanitar (only HC)
(29310, 43228, 100, 1, 0, @min_nh, @max_nh), -- Jedoga Shadowseeker
(31465, 43228, 100, 1, 0, @min_hc, @max_hc), 
(29311, 43228, 100, 1, 0, @min_nh, @max_nh), -- Herold Volazj
(31464, 43228, 100, 1, 0, @min_hc, @max_hc), 

(28684, 43228, 100, 1, 0, @min_nh, @max_nh), -- Krik'thir
(31612, 43228, 100, 1, 0, @min_hc, @max_hc), 
(28921, 43228, 100, 1, 0, @min_nh, @max_nh), -- Hadronox
(31611, 43228, 100, 1, 0, @min_hc, @max_hc), 
(29120, 43228, 100, 1, 0, @min_nh, @max_nh), -- Anub'arak
(31610, 43228, 100, 1, 0, @min_hc, @max_hc), 

(26529, 43228, 100, 1, 0, @min_nh, @max_nh), -- Meathook
(31211, 43228, 100, 1, 0, @min_hc, @max_hc), 
(26532, 43228, 100, 1, 0, @min_nh, @max_nh), -- Chrono-Lord Epoch
(31215, 43228, 100, 1, 0, @min_hc, @max_hc), 
(26530, 43228, 100, 1, 0, @min_nh, @max_nh), -- Salramm the Fleshcrafter
(31212, 43228, 100, 1, 0, @min_hc, @max_hc), 
(32313, 43228, 100, 1, 0, @min_hc, @max_hc), -- Infinite Corrupter (only HC)

(26630, 43228, 100, 1, 0, @min_nh, @max_nh), -- Trollgore
(31362, 43228, 100, 1, 0, @min_hc, @max_hc), 
(26631, 43228, 100, 1, 0, @min_nh, @max_nh), -- Novos
(31350, 43228, 100, 1, 0, @min_hc, @max_hc), 
(27483, 43228, 100, 1, 0, @min_nh, @max_nh), -- King Dred
(31349, 43228, 100, 1, 0, @min_hc, @max_hc), 
(26632, 43228, 100, 1, 0, @min_nh, @max_nh), -- Tharon'ja
(31360, 43228, 100, 1, 0, @min_hc, @max_hc), 

(29304, 43228, 100, 1, 0, @min_nh, @max_nh), -- Slad'ran
(31370, 43228, 100, 1, 0, @min_hc, @max_hc), 
(29573, 43228, 100, 1, 0, @min_nh, @max_nh), -- Drakkari Elemental
(31367, 43228, 100, 1, 0, @min_nh, @max_nh), 
(29305, 43228, 100, 1, 0, @min_nh, @max_nh), -- Moorabi
(30530, 43228, 100, 1, 0, @min_hc, @max_hc), 
(29932, 43228, 100, 1, 0, @min_hc, @max_hc), -- Eck (only HC)
(29306, 43228, 100, 1, 0, @min_nh, @max_nh), -- Gal'darah
(31368, 43228, 100, 1, 0, @min_hc, @max_hc), 

(28586, 43228, 100, 1, 0, @min_nh, @max_nh), -- General Bjarngrim
(31533, 43228, 100, 1, 0, @min_hc, @max_hc), 
(28587, 43228, 100, 1, 0, @min_nh, @max_nh), -- Volkhan
(31536, 43228, 100, 1, 0, @min_hc, @max_hc), 
(28546, 43228, 100, 1, 0, @min_nh, @max_nh), -- Ionar
(31537, 43228, 100, 1, 0, @min_hc, @max_hc), 
(28923, 43228, 100, 1, 0, @min_nh, @max_nh), -- Loken
(31538, 43228, 100, 1, 0, @min_hc, @max_hc), 

(27975, 43228, 100, 1, 0, @min_nh, @max_nh), -- Maiden of Grief
(31384, 43228, 100, 1, 0, @min_hc, @max_hc), 
(27977, 43228, 100, 1, 0, @min_nh, @max_nh), -- Krystallus
(31381, 43228, 100, 1, 0, @min_hc, @max_hc), 
(27978, 43228, 100, 1, 0, @min_nh, @max_nh), -- Sjonnir
(31386, 43228, 100, 1, 0, @min_hc, @max_hc),

(38112, 43228, 100, 1, 0, @min_nh, @max_nh), -- Falric
(38599, 43228, 100, 1, 0, @min_hc, @max_hc),
(38113, 43228, 100, 1, 0, @min_nh, @max_nh), -- Marwyn
(38603, 43228, 100, 1, 0, @min_hc, @max_hc),

(36494, 43228, 100, 1, 0, @min_nh, @max_nh), -- Garfrost
(37613, 43228, 100, 1, 0, @min_hc, @max_hc),
(36476, 43228, 100, 1, 0, @min_nh, @max_nh), -- Krick and Ick
(37627, 43228, 100, 1, 0, @min_hc, @max_hc),
(36658, 43228, 100, 1, 0, @min_nh, @max_nh), -- Scourgelord Tyrannus
(36938, 43228, 100, 1, 0, @min_hc, @max_hc),

(36497, 43228, 100, 1, 0, @min_nh, @max_nh), -- Bronjahm
(36498, 43228, 100, 1, 0, @min_hc, @max_hc),
(36502, 43228, 100, 1, 0, @min_nh, @max_nh), -- Devourer of Souls
(37677, 43228, 100, 1, 0, @min_hc, @max_hc),

(30397, 43228, 100, 1, 0, @min_hc, @max_hc), -- Kolurg (only HC)
(26731, 43228, 100, 1, 0, @min_nh, @max_nh), -- Telestra
(30510, 43228, 100, 1, 0, @min_hc, @max_hc),
(26763, 43228, 100, 1, 0, @min_nh, @max_nh), -- Anomalus
(30529, 43228, 100, 1, 0, @min_hc, @max_hc),
(26794, 43228, 100, 1, 0, @min_nh, @max_nh), -- Ormorok
(30532, 43228, 100, 1, 0, @min_hc, @max_hc),
(26723, 43228, 100, 1, 0, @min_nh, @max_nh), -- Keristrasza
(30540, 43228, 100, 1, 0, @min_hc, @max_hc),

(27654, 43228, 100, 1, 0, @min_nh, @max_nh), -- Drakos
(31558, 43228, 100, 1, 0, @min_hc, @max_hc),
(27655, 43228, 100, 1, 0, @min_nh, @max_nh), -- Urom
(31560, 43228, 100, 1, 0, @min_hc, @max_hc),
(27447, 43228, 100, 1, 0, @min_nh, @max_nh), -- Varos Cloudstrider
(31559, 43228, 100, 1, 0, @min_hc, @max_hc),

(23593, 43228, 100, 1, 0, @min_nh, @max_nh), -- Prince Keleseth
(30748, 43228, 100, 1, 0, @min_hc, @max_hc),
(24200, 43228, 100, 1, 0, @min_nh, @max_nh), -- Skarvald
(31679, 43228, 100, 1, 0, @min_hc, @max_hc),
(24201, 43228, 100, 1, 0, @min_nh, @max_nh), --  Dalronn
(31656, 43228, 100, 1, 0, @min_hc, @max_hc),
(23980, 43228, 100, 1, 0, @min_nh, @max_nh), -- Ingvar
(31674, 43228, 100, 1, 0, @min_hc, @max_hc),

(26693, 43228, 100, 1, 0, @min_nh, @max_nh), -- Skadi
(30807, 43228, 100, 1, 0, @min_hc, @max_hc),
(26668, 43228, 100, 1, 0, @min_nh, @max_nh), -- Svala
(30810, 43228, 100, 1, 0, @min_hc, @max_hc),
(26687, 43228, 100, 1, 0, @min_nh, @max_nh), -- Gortok
(30774, 43228, 100, 1, 0, @min_hc, @max_hc),
(26861, 43228, 100, 1, 0, @min_nh, @max_nh), -- Ymiron
(30788, 43228, 100, 1, 0, @min_hc, @max_hc),

(29315, 43228, 100, 1, 0, @min_nh, @max_nh), -- Erekem
(31507, 43228, 100, 1, 0, @min_hc, @max_hc),
(29314, 43228, 100, 1, 0, @min_nh, @max_nh), -- Zuramat
(31512, 43228, 100, 1, 0, @min_hc, @max_hc),
(29266, 43228, 100, 1, 0, @min_nh, @max_nh), -- Xevozz
(31511, 43228, 100, 1, 0, @min_hc, @max_hc),
(29313, 43228, 100, 1, 0, @min_nh, @max_nh), -- Ichoron
(31508, 43228, 100, 1, 0, @min_hc, @max_hc),
(29316, 43228, 100, 1, 0, @min_nh, @max_nh), -- Moragg
(31510, 43228, 100, 1, 0, @min_hc, @max_hc),
(29312, 43228, 100, 1, 0, @min_nh, @max_nh), -- Lavanthor
(31509, 43228, 100, 1, 0, @min_hc, @max_hc),
(31134, 43228, 100, 1, 0, @min_nh, @max_nh), -- Cyanigosa
(31506, 43228, 100, 1, 0, @min_hc, @max_hc);

-- 4) enable the template only when player has aura 57490
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 1 AND SourceEntry = 43228;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment)
SELECT 1, entry, item, 0, 0, 1, 0, 57940, 0, 0, 0, 0, '', 'Stone Keeper''s Shard - Only drops when Player has Aura 57940' FROM creature_loot_template WHERE item = 43228;

-- 5) repeat 3) and 4) for bosses that drop their loot in GOs
DELETE FROM gameobject_loot_template WHERE item = 43228;
INSERT gameobject_loot_template (entry, item, ChanceOrQuestChance, lootmode, groupid, minCountOrRef, maxcount) VALUES
(24556, 43228, 100, 1, 0, @min_nh, @max_nh), -- Mal'Ganis
(24589, 43228, 100, 1, 0, @min_hc, @max_hc),
(24661, 43228, 100, 1, 0, @min_nh, @max_nh), -- Tribunal of Ages
(26260, 43228, 100, 1, 0, @min_hc, @max_hc),
(24462, 43228, 100, 1, 0, @min_nh, @max_nh), -- Eregos
(24524, 43228, 100, 1, 0, @min_hc, @max_hc),
(27321, 43228, 100, 1, 0, @min_nh, @max_nh), -- Faction Champions
(27414, 43228, 100, 1, 0, @min_hc, @max_hc),
(27327, 43228, 100, 1, 0, @min_nh, @max_nh), -- Argent Confessor Paletress
(27417, 43228, 100, 1, 0, @min_hc, @max_hc),
(27325, 43228, 100, 1, 0, @min_nh, @max_nh), -- Eadric the Pure
(27416, 43228, 100, 1, 0, @min_hc, @max_hc),
(27985, 43228, 100, 1, 0, @min_nh, @max_nh), -- The Lich King (HoR)
(27993, 43228, 100, 1, 0, @min_hc, @max_hc);

DELETE FROM conditions WHERE SourceTypeOrReferenceId = 4 AND SourceEntry = 43228;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment)
SELECT 4, entry, item, 0, 0, 1, 0, 57940, 0, 0, 0, 0, '', 'Stone Keeper''s Shard - Only drops when Player has Aura 57940' FROM gameobject_loot_template WHERE item = 43228;
