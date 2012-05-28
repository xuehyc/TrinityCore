DELETE FROM achievement_criteria_data WHERE criteria_id IN (12302, 12303, 12304, 12305, 12306, 12307, 12308, 12318, 12319, 12320, 12321, 12322, 12323, 12324, 12439, 11420, 12298, 12299, 12300, 12301, 11559, 11560, 12310, 12311, 12312, 12313, 12314, 12315, 12316, 12317);
INSERT INTO achievement_criteria_data (criteria_id, type, value1, value2, ScriptName) VALUES
-- alliance nh
(12302, 11, 0, 0, 'achievement_toc5_champions_mokra'), 
(12303, 11, 0, 0, 'achievement_toc5_champions_visceri'), 
(12304, 11, 0, 0, 'achievement_toc5_champions_runok'), 
(12305, 11, 0, 0, 'achievement_toc5_champions_eressea'), 
(12306, 11, 0, 0, 'achievement_toc5_champions_zultore'), 
(12307, 11, 0, 0, 'achievement_toc5_paletress'), 
(12308, 11, 0, 0, 'achievement_toc5_eadric'), 
-- alliance hc
(12318, 11, 0, 0, 'achievement_toc5_champions_mokra'), 
(12318, 12, 1, 0, ''), 
(12319, 11, 0, 0, 'achievement_toc5_champions_visceri'), 
(12319, 12, 1, 0, ''),
(12320, 11, 0, 0, 'achievement_toc5_champions_runok'), 
(12320, 12, 1, 0, ''),
(12321, 11, 0, 0, 'achievement_toc5_champions_eressea'), 
(12321, 12, 1, 0, ''),
(12322, 11, 0, 0, 'achievement_toc5_champions_zultore'), 
(12322, 12, 1, 0, ''),
(12323, 11, 0, 0, 'achievement_toc5_paletress'), 
(12323, 12, 1, 0, ''),
(12324, 11, 0, 0, 'achievement_toc5_eadric'), 
(12324, 12, 1, 0, ''),
(12439, 12, 1, 0, ''), -- black knight, diffculty check suffices
-- horde nh
(11420, 11, 0, 0, 'achievement_toc5_champions_alerius'), 
(12298, 11, 0, 0, 'achievement_toc5_champions_lana'), 
(12299, 11, 0, 0, 'achievement_toc5_champions_colosos'), 
(12300, 11, 0, 0, 'achievement_toc5_champions_ambrose'), 
(12301, 11, 0, 0, 'achievement_toc5_champions_jaelyne'), 
(11559, 11, 0, 0, 'achievement_toc5_paletress'), 
(11560, 11, 0, 0, 'achievement_toc5_eadric'), 
-- horde hc
(12310, 11, 0, 0, 'achievement_toc5_champions_alerius'), 
(12310, 12, 1, 0, ''), 
(12311, 11, 0, 0, 'achievement_toc5_champions_lana'), 
(12311, 12, 1, 0, ''),
(12312, 11, 0, 0, 'achievement_toc5_champions_colosos'), 
(12312, 12, 1, 0, ''),
(12313, 11, 0, 0, 'achievement_toc5_champions_ambrose'), 
(12313, 12, 1, 0, ''),
(12314, 11, 0, 0, 'achievement_toc5_champions_jaelyne'), 
(12314, 12, 1, 0, ''),
(12315, 11, 0, 0, 'achievement_toc5_paletress'), 
(12315, 12, 1, 0, ''),
(12316, 11, 0, 0, 'achievement_toc5_eadric'), 
(12316, 12, 1, 0, ''),
(12317, 12, 1, 0, ''); -- black knight, diffculty check suffices

-- eadric credit spell
DELETE FROM spell_dbc WHERE Id = 68575;
INSERT INTO spell_dbc (Id, Dispel, Mechanic, Attributes, AttributesEx, AttributesEx2, AttributesEx3, AttributesEx4, AttributesEx5, AttributesEx6, AttributesEx7, Stances, StancesNot, Targets, CastingTimeIndex, AuraInterruptFlags, ProcFlags, ProcChance, ProcCharges, MaxLevel, BaseLevel, SpellLevel, DurationIndex, RangeIndex, StackAmount, EquippedItemClass, EquippedItemSubClassMask, EquippedItemInventoryTypeMask, Effect1, Effect2, Effect3, EffectDieSides1, EffectDieSides2, EffectDieSides3, EffectRealPointsPerLevel1, EffectRealPointsPerLevel2, EffectRealPointsPerLevel3, EffectBasePoints1, EffectBasePoints2, EffectBasePoints3, EffectMechanic1, EffectMechanic2, EffectMechanic3, EffectImplicitTargetA1, EffectImplicitTargetA2, EffectImplicitTargetA3, EffectImplicitTargetB1, EffectImplicitTargetB2, EffectImplicitTargetB3, EffectRadiusIndex1, EffectRadiusIndex2, EffectRadiusIndex3, EffectApplyAuraName1, EffectApplyAuraName2, EffectApplyAuraName3, EffectAmplitude1, EffectAmplitude2, EffectAmplitude3, EffectMultipleValue1, EffectMultipleValue2, EffectMultipleValue3, EffectMiscValue1, EffectMiscValue2, EffectMiscValue3, EffectMiscValueB1, EffectMiscValueB2, EffectMiscValueB3, EffectTriggerSpell1, EffectTriggerSpell2, EffectTriggerSpell3, EffectSpellClassMaskA1, EffectSpellClassMaskA2, EffectSpellClassMaskA3, EffectSpellClassMaskB1, EffectSpellClassMaskB2, EffectSpellClassMaskB3, EffectSpellClassMaskC1, EffectSpellClassMaskC2, EffectSpellClassMaskC3, MaxTargetLevel, SpellFamilyName, SpellFamilyFlags1, SpellFamilyFlags2, SpellFamilyFlags3, MaxAffectedTargets, DmgClass, PreventionType, DmgMultiplier1, DmgMultiplier2, DmgMultiplier3, AreaGroupId, SchoolMask, Comment) VALUES
(68575, 0, 0, 536870912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 16, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Argent Champion credit marker - Eadric The Pure");
