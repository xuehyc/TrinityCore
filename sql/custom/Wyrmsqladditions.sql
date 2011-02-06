-- Sethekk Halls
UPDATE creature_template SET ScriptName = 'npc_lakka' where entry = 18956;
UPDATE quest_template SET ReqCreatureOrGOId2 = 10097 where entry = 10097;


-- shattred halls
update creature_template set scriptname = 'boss_warchief_kargath_bladefist' where entry = 16808;
update creature_template set scriptname = 'mob_shattered_hand_executioner' where entry = 17301;
UPDATE creature_template SET flags_extra = 2 WHERE entry in (17297,17296,17295,17289,17292,17290);
delete from creature_onkill_reputation where creature_id in (17621,17623,17622) or creature_id in (select heroic_entry from creature_template where entry in (17621,17623,17622));

-- shadowlaby
update creature_template set scriptname = 'mob_voidtraveler' where entry = 19226;

-- mechanar
update creature_template set scriptname = 'boss_mechano_lord_capacitus' where entry = 19219;
update creature_template set scriptname = 'mob_nether_charge', faction_A = 14, faction_H = 14 where entry = 20405;
update creature_template set scriptname = 'boss_pathaleon_the_calculator' where entry = 19220;
update creature_template set scriptname = 'boss_gatewatcher_gyro' where entry = 19218;
update creature_template set scriptname = 'boss_gatewatcher_iron' where entry = 19710;
update creature_template set scriptname = 'mob_ragin_flames' where entry = 20481;
update creature_template set scriptname = 'boss_sepethrea' where entry = 19221;
update instance_template set script = "instance_mechanar" where map = 554;

-- arcatraz
update creature_template set scriptname = 'boss_dalliah' where entry = 20885;
update creature_template set scriptname = 'boss_soccothates' where entry = 20886;
update creature_template set scriptname = 'npc_warden_mellichar' where entry = 20904;
update creature_template set scriptname = 'npc_millhouse_manastorm' where entry = 20977;
update creature_template set scriptname = 'boss_harbinger_skyriss' where entry = 20912;
update creature_template set scriptname = 'boss_image_skyriss' where entry in (21466,21467);
update creature_template set scriptname = 'mob_zerekethvoidzone'  where entry = 21101;
update creature_template set scriptname = 'boss_zereketh_the_unbound' where entry = 20870;

-- Magister's Terrace
UPDATE instance_template SET script = 'instance_magisters_terrace' WHERE map = 585;
UPDATE creature_template SET ScriptName = 'boss_selin_fireheart' WHERE entry = 24723;
UPDATE creature_template SET ScriptName = 'mob_fel_crystal' WHERE entry = 24722;
UPDATE creature_template SET ScriptName = 'boss_vexallus' WHERE entry = 24744;
UPDATE creature_template SET ScriptName = 'mob_pure_energy' WHERE entry = 24745;
insert ignore into spell_script_target (entry,type,targetEntry) values (44320,1,24723);
insert ignore into spell_script_target (entry,type,targetEntry) values (44374,1,24723);
insert ignore into spell_script_target (entry,type,targetEntry) values (44321,1,24723);


-- Dark Portal
UPDATE `creature_template` SET `modelid_A`='11686',`modelid_H`='11686',`scale`='1.5',`ScriptName`='mob_dark_portal_controllers' WHERE (`entry`='18562');
UPDATE `creature_template` SET `modelid_A`='11686',`modelid_H`='11686',`ScriptName`='mob_dark_portal_controllers' WHERE (`entry`='18553');
UPDATE `creature_template` SET `modelid_A`='11686',`modelid_H`='11686',`ScriptName`='mob_dark_portal_controllers' WHERE (`entry`='18582');
UPDATE `creature_template` SET `modelid_A`='11686',`modelid_H`='11686',`ScriptName`='mob_dark_portal_controllers' WHERE (`entry`='18555');
UPDATE `creature_template` SET `ScriptName`='mob_medivh' WHERE (`entry`='15608');
UPDATE `creature_template` SET `ScriptName`='mob_time_rift' WHERE (`entry`='17838');
UPDATE `instance_template` SET `script`='instance_the_dark_portal' WHERE (`map`='269');
UPDATE `creature_template` SET `faction_A`='168',`faction_H`='168',`ScriptName`='mobs_infinite_adds' WHERE (`entry`='17892');
UPDATE `creature_template` SET `faction_A`='168',`faction_H`='168',`ScriptName`='mobs_infinite_adds' WHERE (`entry`='18994');
UPDATE `creature_template` SET `faction_A`='168',`faction_H`='168',`ScriptName`='mobs_infinite_adds' WHERE (`entry`='21818');
UPDATE `creature_template` SET `faction_A`='168',`faction_H`='168',`ScriptName`='mobs_infinite_adds' WHERE (`entry`='17835');
UPDATE `creature_template` SET `faction_A`='168',`faction_H`='168',`ScriptName`='mobs_infinite_adds' WHERE (`entry`='18995');
UPDATE `creature_template` SET `faction_A`='168',`faction_H`='168',`ScriptName`='mobs_infinite_adds' WHERE (`entry`='21697');
UPDATE `creature_template` SET `faction_A`='168',`faction_H`='168',`ScriptName`='mobs_infinite_adds' WHERE (`entry`='21698');
UPDATE `creature_template` SET `ScriptName`='npc_saat',npcflag = 3 WHERE entry = 20201;
update creature_template set `ScriptName`='mob_time_keeper',faction_a = 1779, faction_h = 1779 where entry = 17918;
DELETE FROM creature WHERE id IN (17835,21697,17892,18994,21698,18995,21818,21104,17839,17838,17918,17881,17879,17880,21136,21137) AND map = 269;
update creature_template set faction_A = 14, faction_H = 14 where entry in (20905,20906,20909,20908,20911,20910);
update creature_template set flags = 0 where entry = 20912;
Delete from creature_onkill_reputation WHERE creature_id IN (17835,21697,17892,18994,21698,18995,21818,17838,17918,17881,17879,17880,21136,21137,20075);
update creature_template set minhealth = 250000 ,maxhealth = 250000 where entry = 15608;
Delete from creature_onkill_reputation WHERE creature_id IN (21104,17839,17881,17879,17880);
update creature_template set flags = 2, flag1 = 2 where entry = 17838;
insert ignore into `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`) VALUES (17880, 989, 7, 1, 120);
insert ignore into `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`) VALUES (17879, 989, 7, 1, 120);
insert ignore into `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`) VALUES (17881, 989, 7, 1, 120);
insert ignore into `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`) VALUES (17839, 989, 7, 1, 50);
insert ignore into `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`) VALUES (21104, 989, 7, 1, 50);

-- Isle of Quel'Danas
update creature_template set scriptname = 'mob_arcane_sentries' where entry = 24972;
update item_template set ScriptName = 'item_wyrm_attuned_crystal_cores' where entry = 34368;
-- update creature_template set scriptname = 'mob_emissary_of_hate' where entry in (25003);
update creature_template set scriptname = 'mob_bombingrun_target' where entry in (25031,25033,25030,19397,19399,19398);

-- Dragonmaw Peon
update creature_template set scriptname = 'mob_wyrm_dragonmaw_peon' where entry = 22252;

-- hellfire Fellblood
update creature_template set scriptname = 'mob_felblood_initiate' where entry = 24918;
update quest_template set  ReqSpellCast1 = 0 where entry = 11515;
insert ignore into spell_script_target values (44937,1,24918);
insert ignore into spell_script_target values (44936,1,24918);
-- living flare
insert ignore into spell_script_target values (44877,1,24916);
update creature_template set scriptname = 'mob_living_flare' where entry = 24916;
update creature_template set scriptname = 'mob_incandescent_fel_spark' where entry = 22323;


-- Naxxramas
update `creature_template` set `scriptname` = 'boss_anubrekhan' where `entry`= 15956;
update `creature_template` set `scriptname` = 'mob_crypt_guard' where `entry`= 16573;
update `creature_template` set `scriptname` = 'boss_faerlina' where `entry`= 15953;
update `creature_template` set `scriptname` = 'boss_maexxna' where `entry`= 15952;
update `creature_template` set `scriptname` = 'mob_webwrap' where `entry`= 16486;
update `creature_template` set `scriptname` = 'boss_patchwerk' where `entry`= 16028;
update `creature_template` set `scriptname` = 'boss_grobbulus' where `entry`= 15931;
update `creature_template` set `scriptname` = 'mob_grobbulus_poisoncloud' where `entry`= 16363;
update `creature_template` set `scriptname` = 'boss_gluth' where `entry`= 15932;
update `creature_template` set `scriptname` = 'boss_thaddius' where `entry`= 15928;
update `creature_template` set `scriptname` = 'mob_feugen' where `entry`= 15930;
update `creature_template` set `scriptname` = 'mob_stalagg' where `entry`= 15929;
update `creature_template` set `scriptname` = 'boss_razuvious' where `entry`= 16061;
update `creature_template` set `scriptname` = 'boss_gothik' where `entry`= 16060;
update `creature_template` set `scriptname` = 'mob_u_trainee' where `entry`= 16124;
update `creature_template` set `scriptname` = 'mob_u_deathknight' where `entry`= 16125;
update `creature_template` set `scriptname` = 'mob_u_rider' where `entry`= 16126;
update `creature_template` set `scriptname` = 'boss_thane_korthazz' where `entry`= 16064;
update `creature_template` set `scriptname` = 'boss_lady_blaumeux' where `entry`= 16065;
update `creature_template` set `scriptname` = 'boss_highlord_mograine' where `entry`= 16062;
update `creature_template` set `scriptname` = 'boss_sir_zeliek' where `entry`= 16063;
update `creature_template` set `scriptname` = 'boss_noth' where `entry`= 15954;
update `creature_template` set `scriptname` = 'boss_heigan' where `entry`= 15936;
update `creature_template` set `scriptname` = 'mob_eye_stalks' where `entry`= 16236;
update `creature_template` set `scriptname` = 'boss_loatheb' where `entry`= 16011;
update `creature_template` set `scriptname` = 'mob_loatheb_spores' where `entry`= 16286;
update `creature_template` set `scriptname` = 'boss_sapphiron' where `entry`= 15989;
update `creature_template` set `scriptname` = 'boss_kelthuzad' where `entry`= 15990;
update `instance_template` set `script` = 'instance_naxxramas' where `map`= 533;

-- shattrath
insert ignore into spell_target_position values (36643,530,-1947.9,5042.75,28.863,1);

-- Maghteridon
update creature_template set scriptname = "boss_magtheridon" where entry = 17257;
update creature_template set scriptname = "mob_hellfire_channeler" where entry = 17256;
update creature_template set scriptname = "go_manticron_cube" where entry = 181713;
update creature_template set scriptname = "mob_abyssal" where entry = 17454;

-- serpent shrine
update creature_template set scriptname = 'mob_inner_demon' where entry = 21857;

-- slave pents
update creature_template set scriptName = "boss_mennu_the_betrayer" where entry in (17941,19893);
update creature_template set scriptName = "boss_quagmirran" where entry in (17942,19894);
update creature_template set scriptName = "boss_rokmar_the_crackler" where entry in (17991,19895);
update creature_template set spell1 = 34978, scriptname = '', heroic_entry = 22322 where entry = 20208;
update creature_template set spell1 = 38799, scriptname = '' where entry = 22322;
update creature_template set spell1 = 31986, scriptname = '' where entry = 18177;
update creature_template set scriptname = 'mob_mennu_nova_totem', type = 11, spell1 = 0  where entry = 18179;
update creature_template set scriptname = 'mob_mennu_earthgrab_totem', type = 11, heroic_entry = 19897, spell1 = 31983 where entry = 18176;
update creature_template set scriptname = 'mob_mennu_earthgrab_totem', type = 11, spell1 = 31983 where entry = 19897;

-- underborg
update creature_template set scriptname = 'boss_ghazan' where entry = 18105;
update creature_template set scriptname = 'boss_muselek' where entry = 17826;
update gameobject_template set data7 = 0 where entry = 182145;
update creature_template set scriptname = 'boss_the_black_stalker' where entry = 17882;
update creature_template set scriptname = 'mob_spore_strider' where entry = 22299;
update `instance_template` set `script` = 'instance_the_underbog' where `map`= 546;

-- Karazhan
delete from event_scripts where id = 10951;
insert into event_scripts values 
(10951,0,10,17651,180000,0,-11159,-1907.22,91.48,0);
delete from event_scripts where id = 10591;
insert into `event_scripts` values
('10591','0','10','17225','3000000','0','-11003.7','-1760.19','140.25','0.29');
update creature_template set mechanic_immune_mask = 113983323 where entry = 17225;


delete from creature where id = 17651;
update creature_template set scriptname = 'npc_image_of_medivh', faction_H = 35, faction_A = 35 where entry = 17651;
update creature_template set MovementType = 4 where entry = 17652;

UPDATE `creature_template` SET `ScriptName`='boss_netherspite' WHERE `entry`='15689';
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel` = 70, `flags`= 33554496, `faction_A` = 16, `faction_H` = 16, `ScriptName` = 'mob_void_zone'  WHERE `entry` = 16697;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `flags` = 33554496 WHERE `entry` = 17367;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `flags` = 33554496 WHERE `entry` = 17368;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `flags` = 33554496 WHERE `entry` = 17369;

-- Key Giver
update creature_template set scriptname = 'npc_archmage_alturus' where entry = 17613;
update creature_template set scriptname = 'npc_hellfire_smith' where entry in (16583,21209);
update creature_template set scriptname = 'npc_adal' where entry = 18481;

-- Orgrimmar Eitrigg
update creature_template set scriptname = 'npc_eitrigg' where entry = 3144;

-- Hydraxians Molten Core Questreihe
update creature_template set scriptname = 'npc_eastern_plagueland_water_elemental' where entry in(8521,8522,8519,8520);
update creature_template set scriptname = 'npc_duke_hydraxis' where entry in(13278);

-- Silithus wind stone
update gameobject_template set scriptname = 'go_wind_stone' where entry in (180502,180529,180534,180456,180461,180466,180518,180539,180544,180549,180554,180559,180564);

-- Ogrilar
update creature_template set scriptname = 'mob_deamon_portal' where entry in(23322,23327);
update creature_template set scriptname = 'mob_deamon_ogrila' where entry in (19973,20557,22195,22201,22202,22204,22291,22392);
update item_template set scriptname = 'item_skygard_bombs' where entry = 32456;
update creature_template set scriptname = 'mob_bomb_target' where entry in (22991,23118);

-- diverses 
update creature_template set scriptname = 'mob_doomguard_commander' where entry = 12396;

-- Ringe
UPDATE creature_template SET scriptname = 'npc_soridormi' WHERE entry = 19935;
UPDATE creature_template SET scriptname = 'npc_anachronos' WHERE entry = 15192;
UPDATE creature_template SET scriptname = 'npc_archmage_leryda' WHERE entry = 18253;

-- Stratholme
UPDATE `creature_template` SET `ScriptName` = 'mob_bile_spewer' WHERE `entry` = 10416;
UPDATE `creature_template` SET `ScriptName` = 'npc_venom_belcher' WHERE `entry` = 10417;

-- Blackrock Depths
update creature_template set unit_flags=0 where entry=9037;
update creature_template set unit_flags=0 where entry=9035;
update creature_template set unit_flags=0 where entry=9039;
update creature_template set unit_flags=0 where entry=9040;
update creature_template set unit_flags=0 where entry=9034;
update creature_template set unit_flags=0 where entry=9038;
update creature_template set unit_flags=0 where entry=9036;
update instance_template set script="instance_blackrock_depths" where map=230;
UPDATE `item_template` SET `ScriptName` = 'item_shadowforge_torch' WHERE `entry` = 11885;
UPDATE `creature_template` SET `faction_A` = 7, `faction_H` = 7, `npcflag` = 0 WHERE `entry` = 9502;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 16079;
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` = 16079;
UPDATE `creature_template` SET `unit_flags` = 2 WHERE `entry` = 10096;

-- Blackfathom Depths
UPDATE `gameobject_template` SET `ScriptName` = 'go_fire_of_akumai' WHERE `entry` = 21118;
UPDATE `gameobject_template` SET `ScriptName` = 'go_fire_of_akumai' WHERE `entry` = 21119;
UPDATE `gameobject_template` SET `ScriptName` = 'go_fire_of_akumai' WHERE `entry` = 21120;
UPDATE `gameobject_template` SET `ScriptName` = 'go_fire_of_akumai' WHERE `entry` = 21121;
UPDATE `instance_template` SET `Script` = 'instance_blackfathom_depths' WHERE `map` = 48;

-- Razorfen Kraul
UPDATE `creature_template` SET `ScriptName` = 'ward_keeper' WHERE `entry` = 4625;
update instance_template set script="instance_razorfen_kraul" where map=47;´

-- Diverses (Escord Quests von Darkman)
DELETE FROM `eventai_scripts` WHERE (`id`='618003');
UPDATE `creature_template` SET ScriptName = 'npc_daphne_stilwell' WHERE entry = 6182;
UPDATE `creature_template` SET `ScriptName`='npc_ringo' WHERE (`entry`='9999');

-- GO Einträge
UPDATE gameobject_template SET ScriptName = 'go_panther_prison' where entry = 176195;
UPDATE gameobject_template SET ScriptName = 'go_sacred_fire_life' where entry = 175944;
UPDATE gameobject_template SET ScriptName = 'go_iruxos' where entry = 176581;
UPDATE gameobject_template SET ScriptName = 'go_veil_skith_cage_1' where entry in (185202,185203);
UPDATE gameobject_template SET ScriptName = 'go_veil_skith_cage_2' where entry = 185204;
UPDATE gameobject_template SET ScriptName = 'go_veil_skith_cage_3' where entry = 185205;
UPDATE gameobject_template SET ScriptName = 'go_maghar_prison' where entry in (182484,182486,182487,182488,182489,182490,182491,182492,182493,182494,182495,182496,182497,182498,182499,182500,182501,182502,182503,182504);

-- Creature Einträge
UPDATE creature_loot_template SET ChanceOrQuestChance=25,lootcondition=9,condition_value1=10641 where item = 30850;
UPDATE creature_loot_template SET lootcondition = 9,condition_value1 = 10852,ChanceOrQuestChance = 33 where item = 31655;
UPDATE creature_loot_template SET lootcondition = 9,condition_value1 = 9948 where item = 25604;
UPDATE creature_template SET ScriptName = 'npc_kanati' where entry = 10638;
UPDATE creature_template SET ScriptName = 'npc_muglash' where entry = 12717;

-- Quest Einträge
UPDATE quest_template SET RequiredRaces=0 where entry = 9719;
UPDATE quest_template SET ReqSpellCast1 = 0, ReqSourceID1 = 0, ReqSourceCount1 = 0, ReqSourceRef1 = 0 where entry = 9948;
UPDATE quest_template SET SpecialFlags = 2 where entry = 4966;
UPDATE quest_template SET SpecialFlags=2, ReqCreatureOrGOId1=0, ReqCreatureOrGOCount1=0 where entry = 10839;
UPDATE quest_template SET SpecialFlags=0 where entry = 10162;
UPDATE quest_template SET ReqSpellCast1=0, ReqSpellCast2=0 where entry in (10305,10306,10307,10182);
UPDATE quest_template SET ReqCreatureOrGOId1 = 19354 where entry = 10369;

-- Item Einträge
UPDATE item_template SET ScriptName='item_warp_orb' where entry = 29324;
UPDATE item_template SET spellid_1 = 38736, spellcooldown_1=1000, spellcategorycooldown_1=1000,ScriptName='item_purification_rod' where entry = 31610;
UPDATE item_template SET ScriptName = 'item_beacon_torch' where entry = 12815;
UPDATE item_template SET ScriptName = 'item_crow' where entry = 25465;


-- flugmeister
UPDATE `creature_template` SET `ScriptName` = 'mob_flymaster' WHERE entry in (2389, 16189, 12636, 16192, 4551, 2226,26560,22931, 10583, 24851, 23612, 16227, 22216,
	18938, 18940, 19581, 22455, 21766, 20515, 19583,20234, 18809, 8018, 8609, 18939, 7823, 12596, 12617, 21107, 18931, 16822, 24366, 1571, 1572, 2835, 2409, 523,
	2941, 1573, 2299, 352, 4321, 931, 2859, 2432,3838, 3841, 15177, 18937, 17555, 18785, 18788, 18789, 17554, 4267, 4319, 1233, 6706, 22935, 22485, 10897, 11138,
	4407, 12577, 12578, 8019,2861, 19558, 2858, 18942, 1387, 19317, 2851, 20762, 8020, 18953, 18930, 2995, 11901, 4312, 11899, 11139, 4314, 10378, 8610, 4317, 7824,
	6726, 12616, 12740, 13177, 18808, 18807, 18791, 14242, 3305, 16587, 3310, 3615, 11900, 15178, 6026);