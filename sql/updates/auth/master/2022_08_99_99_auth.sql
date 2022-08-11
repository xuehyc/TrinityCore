-- 
SET @PERMISSION := 883;

DELETE FROM `rbac_permissions` WHERE `id`=@PERMISSION;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(@PERMISSION, 'Command: quest completeobjective');

DELETE FROM `rbac_linked_permissions` WHERE `id`=196 AND `linkedId`=@PERMISSION;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(196, @PERMISSION);
