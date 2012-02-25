ALTER TABLE `irc_commands` CHANGE `Description` `Description` varchar(350);
UPDATE `irc_commands` SET `Description`='[tele <Player> <l/c/r/to/cr/go> <Loc.Name/MAPID X Y Z/Recall/Player/Creature GUID/Gameobject GUID>] : Teleport Player To Location, Player, NPC, Gameobject.' WHERE (`Command`='tele');
UPDATE `irc_commands` SET `Description`='[char <Player> <mailcheat/taxicheat/maxskill/setskill/combatstop>] : Perform Action To Character.' WHERE (`Command`='char');
