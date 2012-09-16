-- fix graveyard linking for darnassus (horde) and thunder bluff (alliance), author: Tollmer
UPDATE game_graveyard_zone set id = 89 WHERE ghost_zone = 1638 AND faction = 469;
UPDATE game_graveyard_zone SET id = 91 WHERE ghost_zone = 1657 AND faction = 67; 