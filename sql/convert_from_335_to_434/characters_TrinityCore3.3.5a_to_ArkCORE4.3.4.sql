-- Use on TrinityCORE 3.3.5a characters database
-- both cores updates to 30/05/2013
-- STATUS: 80%

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- clean old currencies, this broken pets bar
DELETE FROM `character_inventory` WHERE `slot` IN ('118','135');
DELETE FROM `item_instance` WHERE `itemEntry` IN (
49426, -- Emblem of Frost
47241, -- Emblem of Triumph
40752, -- Emblem of Heroism
40753, -- Emblem of Valor
45624, -- Emblem of Conquest
20559, -- Arathi Basin Mark of Honor
29024, -- Eye of the Storm Mark of Honor
20560, -- Alterac Valley Mark of Honor
20558, -- Warsong Gulch Mark of Honor
43228, -- Stone Keeper's Shard	
42425, -- Strand of the Ancients Mark of Honor
47395, -- Isle of Conquest Mark of Honor
43308, -- Old Honor Points
43307  -- Old Arena Points 
);

-- Clean Talents table
TRUNCATE TABLE `character_talent`;
UPDATE `characters` SET `speccount` = '1' ,`activespec` = '0';

-- character_glyphs
ALTER TABLE `character_glyphs` 
	ADD COLUMN `glyph7` smallint(5) unsigned   NULL DEFAULT 0 after `glyph6`, 
	ADD COLUMN `glyph8` smallint(5) unsigned   NULL DEFAULT 0 after `glyph7`, 
	ADD COLUMN `glyph9` smallint(5) unsigned   NULL DEFAULT 0 after `glyph8`;

-- character_pet
ALTER TABLE `character_pet` 
	CHANGE `savetime` `savetime` int(10) unsigned   NOT NULL DEFAULT 0 after `curmana`, 
	CHANGE `abdata` `abdata` text  COLLATE utf8_general_ci NULL after `savetime`, 
	DROP COLUMN `curhappiness`;

-- character_queststatus_rewarded
ALTER TABLE `character_queststatus_rewarded` 
	CHANGE `active` `active` tinyint(3) unsigned   NOT NULL DEFAULT 1 after `quest`;

-- character_research_digsites
CREATE TABLE `character_research_digsites`(
	`guid` int(11) unsigned NOT NULL  COMMENT 'ID del personaje' , 
	`digsiteId` int(11) unsigned NOT NULL  COMMENT 'ID del digsite' , 
	`point_x` float NOT NULL  DEFAULT 0 COMMENT 'Coordenada \"x\" aleatoria' , 
	`point_y` float NOT NULL  DEFAULT 0 COMMENT 'Coordenada \"y\" aleatoria' , 
	`count` int(1) unsigned NOT NULL  DEFAULT 0 COMMENT 'Veces explorado el digsite' , 
	PRIMARY KEY (`guid`,`digsiteId`) 
) ENGINE=InnoDB DEFAULT CHARSET='latin1';

-- character_research_history
CREATE TABLE `character_research_history`(
	`guid` int(10) unsigned NOT NULL  COMMENT 'GUID del Player' , 
	`time` int(10) unsigned NOT NULL  DEFAULT 0 COMMENT 'Primera vez resuelto el artefacto' , 
	`projectId` smallint(5) unsigned NOT NULL  COMMENT 'Id del proyecto' , 
	`count` smallint(5) unsigned NOT NULL  DEFAULT 0 COMMENT 'Veces completado' , 
	PRIMARY KEY (`guid`,`projectId`) 
) ENGINE=InnoDB DEFAULT CHARSET='latin1';

-- character_research_projects
CREATE TABLE `character_research_projects`(
	`guid` int(10) NOT NULL  COMMENT 'GUID del player' , 
	`projectId` int(10) NOT NULL  COMMENT 'Id del proyecto' , 
	PRIMARY KEY (`guid`,`projectId`) 
) ENGINE=InnoDB DEFAULT CHARSET='latin1';

-- character_stats
ALTER TABLE `character_stats` 
	CHANGE `strength` `strength` int(10) unsigned   NOT NULL DEFAULT 0 after `maxpower5`, 
	CHANGE `agility` `agility` int(10) unsigned   NOT NULL DEFAULT 0 after `strength`, 
	CHANGE `stamina` `stamina` int(10) unsigned   NOT NULL DEFAULT 0 after `agility`, 
	CHANGE `intellect` `intellect` int(10) unsigned   NOT NULL DEFAULT 0 after `stamina`, 
	CHANGE `spirit` `spirit` int(10) unsigned   NOT NULL DEFAULT 0 after `intellect`, 
	CHANGE `armor` `armor` int(10) unsigned   NOT NULL DEFAULT 0 after `spirit`, 
	CHANGE `resHoly` `resHoly` int(10) unsigned   NOT NULL DEFAULT 0 after `armor`, 
	CHANGE `resFire` `resFire` int(10) unsigned   NOT NULL DEFAULT 0 after `resHoly`, 
	CHANGE `resNature` `resNature` int(10) unsigned   NOT NULL DEFAULT 0 after `resFire`, 
	CHANGE `resFrost` `resFrost` int(10) unsigned   NOT NULL DEFAULT 0 after `resNature`, 
	CHANGE `resShadow` `resShadow` int(10) unsigned   NOT NULL DEFAULT 0 after `resFrost`, 
	CHANGE `resArcane` `resArcane` int(10) unsigned   NOT NULL DEFAULT 0 after `resShadow`, 
	CHANGE `blockPct` `blockPct` float unsigned   NOT NULL DEFAULT '0' after `resArcane`, 
	CHANGE `dodgePct` `dodgePct` float unsigned   NOT NULL DEFAULT '0' after `blockPct`, 
	CHANGE `parryPct` `parryPct` float unsigned   NOT NULL DEFAULT '0' after `dodgePct`, 
	CHANGE `critPct` `critPct` float unsigned   NOT NULL DEFAULT '0' after `parryPct`, 
	CHANGE `rangedCritPct` `rangedCritPct` float unsigned   NOT NULL DEFAULT '0' after `critPct`, 
	CHANGE `spellCritPct` `spellCritPct` float unsigned   NOT NULL DEFAULT '0' after `rangedCritPct`, 
	CHANGE `attackPower` `attackPower` int(10) unsigned   NOT NULL DEFAULT 0 after `spellCritPct`, 
	CHANGE `rangedAttackPower` `rangedAttackPower` int(10) unsigned   NOT NULL DEFAULT 0 after `attackPower`, 
	CHANGE `spellPower` `spellPower` int(10) unsigned   NOT NULL DEFAULT 0 after `rangedAttackPower`, 
	CHANGE `resilience` `resilience` int(10) unsigned   NOT NULL DEFAULT 0 after `spellPower`, 
	DROP COLUMN `maxpower6`, 
	DROP COLUMN `maxpower7`;

-- characters
ALTER TABLE `characters` 
	ADD COLUMN `slot` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `name`, 
	CHANGE `race` `race` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `slot`, 
	CHANGE `class` `class` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `race`, 
	CHANGE `gender` `gender` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `class`, 
	CHANGE `level` `level` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `gender`, 
	CHANGE `xp` `xp` int(10) unsigned   NOT NULL DEFAULT 0 after `level`, 
	CHANGE `money` `money` bigint(20) unsigned   NOT NULL DEFAULT 0 after `xp`, 
	CHANGE `playerBytes` `playerBytes` int(10) unsigned   NOT NULL DEFAULT 0 after `money`, 
	CHANGE `playerBytes2` `playerBytes2` int(10) unsigned   NOT NULL DEFAULT 0 after `playerBytes`, 
	CHANGE `playerFlags` `playerFlags` int(10) unsigned   NOT NULL DEFAULT 0 after `playerBytes2`, 
	CHANGE `position_x` `position_x` float   NOT NULL DEFAULT 0 after `playerFlags`, 
	CHANGE `position_y` `position_y` float   NOT NULL DEFAULT 0 after `position_x`, 
	CHANGE `position_z` `position_z` float   NOT NULL DEFAULT 0 after `position_y`, 
	CHANGE `map` `map` smallint(5) unsigned   NOT NULL DEFAULT 0 COMMENT 'Map Identifier' after `position_z`, 
	CHANGE `instance_id` `instance_id` int(10) unsigned   NOT NULL DEFAULT 0 after `map`, 
	CHANGE `instance_mode_mask` `instance_mode_mask` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `instance_id`, 
	CHANGE `orientation` `orientation` float   NOT NULL DEFAULT 0 after `instance_mode_mask`, 
	CHANGE `taximask` `taximask` text  COLLATE utf8_general_ci NOT NULL after `orientation`, 
	CHANGE `online` `online` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `taximask`, 
	CHANGE `cinematic` `cinematic` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `online`, 
	CHANGE `totaltime` `totaltime` int(10) unsigned   NOT NULL DEFAULT 0 after `cinematic`, 
	CHANGE `leveltime` `leveltime` int(10) unsigned   NOT NULL DEFAULT 0 after `totaltime`, 
	CHANGE `logout_time` `logout_time` int(10) unsigned   NOT NULL DEFAULT 0 after `leveltime`, 
	CHANGE `is_logout_resting` `is_logout_resting` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `logout_time`, 
	CHANGE `rest_bonus` `rest_bonus` float   NOT NULL DEFAULT 0 after `is_logout_resting`, 
	CHANGE `resettalents_cost` `resettalents_cost` int(10) unsigned   NOT NULL DEFAULT 0 after `rest_bonus`, 
	CHANGE `resettalents_time` `resettalents_time` int(10) unsigned   NOT NULL DEFAULT 0 after `resettalents_cost`, 
	ADD COLUMN `talentTree` varchar(10)  COLLATE utf8_general_ci NOT NULL DEFAULT '0 0' after `resettalents_time`, 
	CHANGE `trans_x` `trans_x` float   NOT NULL DEFAULT 0 after `talentTree`, 
	CHANGE `trans_y` `trans_y` float   NOT NULL DEFAULT 0 after `trans_x`, 
	CHANGE `trans_z` `trans_z` float   NOT NULL DEFAULT 0 after `trans_y`, 
	CHANGE `trans_o` `trans_o` float   NOT NULL DEFAULT 0 after `trans_z`, 
	CHANGE `transguid` `transguid` mediumint(8) unsigned   NOT NULL DEFAULT 0 after `trans_o`, 
	CHANGE `extra_flags` `extra_flags` smallint(5) unsigned   NOT NULL DEFAULT 0 after `transguid`, 
	CHANGE `stable_slots` `stable_slots` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `extra_flags`, 
	CHANGE `at_login` `at_login` smallint(5) unsigned   NOT NULL DEFAULT 0 after `stable_slots`, 
	CHANGE `zone` `zone` smallint(5) unsigned   NOT NULL DEFAULT 0 after `at_login`, 
	CHANGE `death_expire_time` `death_expire_time` int(10) unsigned   NOT NULL DEFAULT 0 after `zone`, 
	CHANGE `taxi_path` `taxi_path` text  COLLATE utf8_general_ci NULL after `death_expire_time`, 
	CHANGE `totalKills` `totalKills` int(10) unsigned   NOT NULL DEFAULT 0 after `taxi_path`, 
	CHANGE `todayKills` `todayKills` smallint(5) unsigned   NOT NULL DEFAULT 0 after `totalKills`, 
	CHANGE `yesterdayKills` `yesterdayKills` smallint(5) unsigned   NOT NULL DEFAULT 0 after `todayKills`, 
	CHANGE `chosenTitle` `chosenTitle` int(10) unsigned   NOT NULL DEFAULT 0 after `yesterdayKills`, 
	CHANGE `watchedFaction` `watchedFaction` int(10) unsigned   NOT NULL DEFAULT 0 after `chosenTitle`, 
	CHANGE `drunk` `drunk` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `watchedFaction`, 
	CHANGE `health` `health` int(10) unsigned   NOT NULL DEFAULT 0 after `drunk`, 
	CHANGE `power1` `power1` int(10) unsigned   NOT NULL DEFAULT 0 after `health`, 
	CHANGE `power2` `power2` int(10) unsigned   NOT NULL DEFAULT 0 after `power1`, 
	CHANGE `power3` `power3` int(10) unsigned   NOT NULL DEFAULT 0 after `power2`, 
	CHANGE `power4` `power4` int(10) unsigned   NOT NULL DEFAULT 0 after `power3`, 
	CHANGE `power5` `power5` int(10) unsigned   NOT NULL DEFAULT 0 after `power4`, 
	CHANGE `latency` `latency` mediumint(8) unsigned   NOT NULL DEFAULT 0 after `power5`, 
	CHANGE `speccount` `speccount` tinyint(3) unsigned   NOT NULL DEFAULT 1 after `latency`, 
	CHANGE `activespec` `activespec` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `speccount`, 
	CHANGE `exploredZones` `exploredZones` longtext  COLLATE utf8_general_ci NULL after `activespec`, 
	CHANGE `equipmentCache` `equipmentCache` longtext  COLLATE utf8_general_ci NULL after `exploredZones`, 
	CHANGE `knownTitles` `knownTitles` longtext  COLLATE utf8_general_ci NULL after `equipmentCache`, 
	CHANGE `actionBars` `actionBars` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `knownTitles`, 
	CHANGE `grantableLevels` `grantableLevels` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `actionBars`, 
	ADD COLUMN `guildId` int(10) unsigned   NOT NULL DEFAULT 0 after `grantableLevels`, 
	CHANGE `deleteInfos_Account` `deleteInfos_Account` int(10) unsigned   NULL after `guildId`, 
	CHANGE `deleteInfos_Name` `deleteInfos_Name` varchar(12)  COLLATE utf8_general_ci NULL after `deleteInfos_Account`, 
	CHANGE `deleteDate` `deleteDate` int(10) unsigned   NULL after `deleteInfos_Name`, 
	DROP COLUMN `arenaPoints`, 
	DROP COLUMN `totalHonorPoints`, 
	DROP COLUMN `todayHonorPoints`, 
	DROP COLUMN `yesterdayHonorPoints`, 
	DROP COLUMN `knownCurrencies`, 
	DROP COLUMN `power6`, 
	DROP COLUMN `power7`, 
	DROP COLUMN `ammoId`;

-- corpse
ALTER TABLE `corpse` 
	CHANGE `flags` `flags` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `bytes2`, 
	CHANGE `dynFlags` `dynFlags` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `flags`, 
	CHANGE `time` `time` int(10) unsigned   NOT NULL DEFAULT 0 after `dynFlags`, 
	CHANGE `corpseType` `corpseType` tinyint(3) unsigned   NOT NULL DEFAULT 0 after `time`, 
	CHANGE `instanceId` `instanceId` int(10) unsigned   NOT NULL DEFAULT 0 COMMENT 'Instance Identifier' after `corpseType`, 
	DROP COLUMN `guildId`;

-- guild
ALTER TABLE `guild` 
	ADD COLUMN `level` int(10) unsigned   NULL DEFAULT 1 after `BankMoney`, 
	ADD COLUMN `experience` bigint(20) unsigned   NULL DEFAULT 0 after `level`, 
	ADD COLUMN `todayExperience` bigint(20) unsigned   NULL DEFAULT 0 after `experience`;

-- guild_member_withdraw
ALTER TABLE `guild_member_withdraw` 
	ADD COLUMN `tab6` int(10) unsigned   NOT NULL DEFAULT 0 after `tab5`, 
	ADD COLUMN `tab7` int(10) unsigned   NOT NULL DEFAULT 0 after `tab6`, 
	CHANGE `money` `money` int(10) unsigned   NOT NULL DEFAULT 0 after `tab7`;

-- mail
ALTER TABLE `mail` 
	CHANGE `money` `money` bigint(20) unsigned   NOT NULL DEFAULT 0 after `deliver_time`, 
	CHANGE `cod` `cod` bigint(20) unsigned   NOT NULL DEFAULT 0 after `money`;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;