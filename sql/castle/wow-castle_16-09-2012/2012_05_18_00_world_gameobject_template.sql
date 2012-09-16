-- @DorianGrey
-- Fix for Q9910: Standards and Practices
-- According to spellwork, the Battle Standard's spell requires spell-focus (data 1393) on the object.
-- Except the first Burning Blade Pyre (GO182263), this wasn't enabled on any of the corresponding GO's.
-- Thus - change it :)
UPDATE `gameobject_template` SET `data0`=1393 WHERE `entry` IN (182262, 182264); 