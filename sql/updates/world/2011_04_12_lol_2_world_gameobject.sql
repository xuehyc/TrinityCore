UPDATE `gameobject`,`pool_gameobject` SET `gameobject`.`spawntimesecs`=180 
WHERE `gameobject`.`id` IN (189978,189979,189980,189981,191133) AND `gameobject`.`guid`=`pool_gameobject`.`guid`;
