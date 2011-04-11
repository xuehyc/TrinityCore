-- Workaround the Shadowsight Crystalls
UPDATE `gameobject_template` SET `data5`=120 WHERE `entry` IN (184663, 184664);