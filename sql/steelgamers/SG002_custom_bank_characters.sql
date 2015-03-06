-- Custom gold bank
ALTER TABLE `characters` ADD COLUMN `customBankMoney` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Stores the money that the player has in his "bank account" (Custom)' AFTER `deleteDate`;
