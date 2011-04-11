-- add recovery option for quest #338 items
DELETE FROM `gossip_menu_option` WHERE `menu_id`=5483;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`)
VALUES
(5483,0,0,'GOSSIP_OPTION_QUESTGIVER',2,2,0,0,0,0,0,''),
(5483,1,0,'Bitte gib mir ein neues Kapitel I.',1,1,0,0,548301,0,0,''),
(5483,2,0,'Bitte gib mir ein neues Kapitel II.',1,1,0,0,548302,0,0,''),
(5483,3,0,'Bitte gib mir ein neues Kapitel III.',1,1,0,0,548303,0,0,''),
(5483,4,0,'Bitte gib mir ein neues Kapitel IV.',1,1,0,0,548304,0,0,'');

DELETE FROM `gossip_scripts` WHERE `id` BETWEEN 548301 AND 548304;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(548301,0,17,2756,1,0,0,0,0,0),
(548301,0,33,0,0,0,0,0,0,0),
(548302,0,17,2757,1,0,0,0,0,0),
(548302,0,33,0,0,0,0,0,0,0),
(548303,0,17,2758,1,0,0,0,0,0),
(548303,0,33,0,0,0,0,0,0,0),
(548304,0,17,2759,1,0,0,0,0,0),
(548304,0,33,0,0,0,0,0,0,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=5483;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
-- Chapter I
(15,5483,1,1,9,338,0,0,0,'',''),
(15,5483,1,1,8,339,0,0,0,'',''),
(15,5483,1,1,26,2756,1,0,0,'',''),
-- Chapter II
(15,5483,2,1,9,338,0,0,0,'',''),
(15,5483,2,1,8,340,0,0,0,'',''),
(15,5483,2,1,26,2757,1,0,0,'',''),
-- Chapter III
(15,5483,3,1,9,338,0,0,0,'',''),
(15,5483,3,1,8,341,0,0,0,'',''),
(15,5483,3,1,26,2758,1,0,0,'',''),
-- Chapter IV
(15,5483,4,1,9,338,0,0,0,'',''),
(15,5483,4,1,8,342,0,0,0,'',''),
(15,5483,4,1,26,2759,1,0,0,'','');
