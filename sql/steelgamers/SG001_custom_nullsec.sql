CREATE TABLE `custom_nullsec_zones` (
	`zone_id` INT(10) UNSIGNED NOT NULL COMMENT 'Zone ID (As defined in SharedDefines.h)',
	`zone_name` VARCHAR(255) NOT NULL COMMENT 'Zone name',
	`owner` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'The owner\'s ID (Guild)',
	PRIMARY KEY (`zone_id`),
	INDEX `FK_ZONE_GUILD_GUID` (`owner`),
	CONSTRAINT `FK_ZONE_GUILD_GUID` FOREIGN KEY (`owner`) REFERENCES `guild` (`guildid`)
)
COMMENT='Stores data about the ownership of the Null Sec zones.'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

REPLACE INTO custom_nullsec_zones (zone_id, zone_name, owner) VALUES
(1, 'Cuna del Invierno Norte', NULL),
(2, 'Cuna del Invierno Sur', NULL),
(3, 'Frondavil Norte', NULL),
(4, 'Frondavil Centro', NULL),
(5, 'Frondavil Sur', NULL),
(6, 'Sierra Espolón Este', NULL),
(7, 'Sierra Espolón Oeste', NULL),
(8, 'Desolace Norte', NULL),
(9, 'Desolace Sur', NULL),
(10, 'Marjal Revolcafango Este', NULL),
(11, 'Marjal Revolcafango Norte', NULL),
(12, 'Marjal Revolcafango Sur', NULL);

REPLACE INTO trinity_string (entry, content_default, content_loc6, content_loc7) VALUES
(12000, "You have entered a safe zone.", "Has entrado en una zona segura.", "Has entrado en una zona segura."),
(12001, "ATTENTION: You have entered an Alliance territory, the security for you here is NULL.", "ADVERTENCIA: Has entrado en un territorio de la Alianza, donde la seguridad para ti es NULA.", "ADVERTENCIA: Has entrado en un territorio de la Alianza, donde la seguridad para ti es NULA."),
(12002, "ATTENTION: You have entered a Horde territory, the security for you here is NULL.", "ADVERTENCIA: Has entrado en un territorio de la Horda, donde la seguridad para ti es NULA.", "ADVERTENCIA: Has entrado en un territorio de la Horda, donde la seguridad para ti es NULA."),
(12003, "ATTENTION: You have entered a LOW security zone.", "ADVERTENCIA: Has entrado en una zona de BAJA seguridad.", "ADVERTENCIA: Has entrado en una zona de BAJA seguridad."),
(12004, "ATTENTION: You have entered a NULL security zone.", "ADVERTENCIA: Has entrado en una zona de seguridad NULA.", "ADVERTENCIA: Has entrado en una zona de seguridad NULA."),
(12005, "The guild %s has lost control of %s!", "La Hermandad %s ha perdido el control de %s!", "La Hermandad %s ha perdido el control de %s!"),
(12006, "The guild %s has taken control of %s!", "La Hermandad %s ha conquistado %s!", "La Hermandad %s ha conquistado %s!"),
(12007, "ATTENTION: You have entered in %s, a neutral territory.", "ADVERTENCIA: Has entrado en %s, un territorio que aún no ha sido conquistado.", "ADVERTENCIA: Has entrado en %s, un territorio que aún no ha sido conquistado."),
(12008, "ATTENTION: You have entered in %s, a territory owned by the guild %s.", "ADVERTENCIA: Has entrado en %s, un territorio que pertenece a la Hermandad %s.", "ADVERTENCIA: Has entrado en %s, un territorio que pertenece a la Hermandad %s."),
(12009, "You have entered in %s, a territory owned by your guild.", "Has entrado en %s, un territorio que pertenece a tu Hermandad.", "Has entrado %s, un territorio que pertenece a tu Hermandad."),
(12010, "You have left %s.", "Has salido de %s.", "Has salido de %s."),
(12011, "You have entered in a very dangerous territory! Your character has been moved to a safe place.", "¡Has entrado en un territorio demasiado peligroso! Tu personaje ha sido devuelto a un lugar seguro.", "¡Has entrado en un territorio demasiado peligroso! Tu personaje ha sido devuelto a un lugar seguro.");