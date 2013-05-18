DROP TABLE IF EXISTS `character_research_digsites`;

CREATE TABLE `character_research_digsites` (
  `guid` int(11) unsigned NOT NULL COMMENT 'ID del personaje',
  `digsiteId` int(11) unsigned NOT NULL COMMENT 'ID del digsite',
  `point_x` float NOT NULL DEFAULT '0' COMMENT 'Coordenada "x" aleatoria',
  `point_y` float NOT NULL DEFAULT '0' COMMENT 'Coordenada "y" aleatoria',
  `count` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Veces explorado el digsite',
  PRIMARY KEY (`guid`,`digsiteId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

DROP TABLE IF EXISTS `character_research_history`;

CREATE TABLE `character_research_history` (
  `guid` int(10) unsigned NOT NULL COMMENT 'GUID del Player',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primera vez resuelto el artefacto',
  `projectId` smallint(5) unsigned NOT NULL COMMENT 'Id del proyecto',
  `count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Veces completado',
  PRIMARY KEY (`guid`,`projectId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

DROP TABLE IF EXISTS `character_research_projects`;

CREATE TABLE `character_research_projects` (
  `guid` int(10) NOT NULL COMMENT 'GUID del player',
  `projectId` int(10) NOT NULL COMMENT 'Id del proyecto',
  PRIMARY KEY (`guid`,`projectId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
