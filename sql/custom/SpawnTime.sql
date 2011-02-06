-- Quest "Keeping the Enemy at the Bay (11543) - Dawnblade Reservist (25087)
UPDATE `creature` SET `spawntimesecs` = '180' WHERE `spawntimesecs` > '180' AND `id` = '25087';

-- Quest "Maintaining the Sunwell Portal" (11514) - Smuggled Mana Cell (187039)
UPDATE `gameobject` SET `spawntimesecs` = '150' WHERE id = '187039';

-- Quest "Revenge of Gann" (849) - Flying Machine
UPDATE `gameobject` SET `spawntimesecs` = '60' WHERE `id` = '3644';

-- Quest "Crush the Dawnblade" (11540)
UPDATE `creature` SET `spawntimesecs` = '240' WHERE  `id` IN (24978, 24976, 24979);

-- Quest "Arm the Wards!" (11523)
UPDATE `creature` SET `spawntimesecs` = '240' WHERE `id` IN (25047, 24966, 24960);

-- Quest "Fields of Grief" (365) - Tirisfal Pumpkin (375)
UPDATE `gameobject` SET `spawntimesecs` = '60' WHERE `id` = '375';