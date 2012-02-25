-- #938: Stranglethorn fishing event, correct base-times
UPDATE `game_event` SET `start_time` = '2011-01-02 14:00:00' WHERE `game_event`.`eventEntry` IN (14,15,62);

-- #1013: Creature-loot of Titanium-Lockbox increased
-- Corresponds to http://old.wowhead.com/item=43624
-- + Merged with the 23 entries present before
DELETE FROM `creature_loot_template` WHERE `item` = 43624;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(34183, 43624, 0.83, 1, 0, 1, 1), -- Arachnopod Destroyer
(12129, 43624, 0.48, 1, 0, 1, 1), -- Onyxian Warder
(37217, 43624, 0.48, 1, 0, 1, 1), -- Precious
(37098, 43624, 0.45, 1, 0, 1, 1), -- Val'kyr Herald
(37022, 43624, 0.26, 1, 0, 1, 1), -- Blighted Abomination
(37038, 43624, 0.2, 1, 0, 1, 1), -- Vengeful Fleshreaper
(36725, 43624, 0.2, 1, 0, 1, 1), -- Nerub'ar Broodkeeper
(28199, 43624, 0.18, 1, 0, 1, 1), -- Tomb Stalker
(37023, 43624, 0.16, 1, 0, 1, 1), -- Plague Scientist
(26623, 43624, 0.14, 1, 0, 1, 1), -- Scourge Brute
(36724, 43624, 0.14, 1, 0, 1, 1), -- Servant of the Throne
(29829, 43624, 0.13, 1, 0, 1, 1), -- Drakkari Earthshaker
(34267, 43624, 0.13, 1, 0, 1, 1), -- Parts Recovery Technician
(37501, 43624, 0.13, 1, 0, 1, 1), -- Nerub'ar Champion
(16037, 43624, 0.13, 1, 0, 1, 1), -- Plagued Bat
(37012, 43624, 0.13, 1, 0, 1, 1), -- Ancient Skeletal Soldier
(34273, 43624, 0.12, 1, 0, 1, 1), -- XB-488 Disposalbot
(16022, 43624, 0.12, 1, 0, 1, 1), -- Surgical Assistant
(26805, 43624, 0.12, 1, 0, 1, 1), -- Alliance Cleric
(31265, 43624, 0.11, 1, 0, 1, 1), -- Savage Proto-Drake
(10404, 43624, 0.11, 1, 0, 1, 1), -- Pustulating Horror
(37532, 43624, 0.11, 1, 0, 1, 1), -- Frostwing Whelp
(26636, 43624, 0.11, 1, 0, 1, 1), -- Risen Drakkari Soulmage
(37025, 43624, 0.11, 1, 0, 1, 1), -- Stinky
(27734, 43624, 0.11, 1, 0, 1, 1), -- Crypt Fiend
(37011, 43624, 0.1, 1, 0, 1, 1), -- The Damned
(32353, 43624, 0.1, 1, 0, 1, 1), -- Archavon Warder
(32260, 43624, 0.1, 1, 0, 1, 1), -- Enslaved Minion
(37531, 43624, 0.1, 1, 0, 1, 1), -- Frostwarden Handler
(16036, 43624, 0.09, 1, 0, 1, 1), -- Frenzied Bat
(27744, 43624, 0.09, 1, 0, 1, 1), -- Infinite Agent
(34269, 43624, 0.09, 1, 0, 1, 1), -- XR-949 Salvagebot
(31037, 43624, 0.08, 1, 0, 1, 1), -- Forgotten Depths High Priest
(36880, 43624, 0.08, 1, 0, 1, 1), -- Decaying Colossus
(28231, 43624, 0.08, 1, 0, 1, 1), -- Crystalline Tender
(27743, 43624, 0.08, 1, 0, 1, 1), -- Infinite Hunter
(26782, 43624, 0.08, 1, 0, 1, 1), -- Crystalline Keeper
(29834, 43624, 0.08, 1, 0, 1, 1), -- Drakkari Frenzy
(27731, 43624, 0.08, 1, 0, 1, 1), -- Acolyte
(31159, 43624, 0.08, 1, 0, 1, 1), -- Baelok
(34193, 43624, 0.07, 1, 0, 1, 1), -- Clockwork Sapper
(37229, 43624, 0.07, 1, 0, 1, 1), -- Frostwarden Sorceress
(36892, 43624, 0.07, 1, 0, 1, 1), -- Ymirjar Deathbringer
(28920, 43624, 0.07, 1, 0, 1, 1), -- Stormforged Giant
(38177, 43624, 0.07, 1, 0, 1, 1), -- Shadowy Mercenary
(34271, 43624, 0.07, 1, 0, 1, 1), -- XD-175 Compactobot
(37502, 43624, 0.07, 1, 0, 1, 1), -- Nerub'ar Webweaver
(28965, 43624, 0.06, 1, 0, 1, 1), -- Titanium Thunderer
(24082, 43624, 0.06, 1, 0, 1, 1), -- Proto-Drake Handler
(36896, 43624, 0.06, 1, 0, 1, 1), -- Stonespine Gargoyle
(36522, 43624, 0.06, 1, 0, 1, 1), -- Soul Horror
(36516, 43624, 0.06, 1, 0, 1, 1), -- Soulguard Animator
(38173, 43624, 0.05, 1, 0, 1, 1), -- Spectral Footman
(28467, 43624, 0.05, 1, 0, 1, 1), -- Broodmother Slivina
(36881, 43624, 0.05, 1, 0, 1, 1), -- Skeletal Slave
(28200, 43624, 0.05, 1, 0, 1, 1), -- Dark Necromancer
(32162, 43624, 0.05, 1, 0, 1, 1), -- Grimkor the Wicked
(29822, 43624, 0.05, 1, 0, 1, 1), -- Drakkari Fire Weaver
(36842, 43624, 0.05, 1, 0, 1, 1), -- Wrathbone Coldwraith
(36499, 43624, 0.05, 1, 0, 1, 1), -- Soulguard Reaper
(27742, 43624, 0.05, 1, 0, 1, 1), -- Infinite Adversary
(27732, 43624, 0.05, 1, 0, 1, 1), -- Master Necromancer
(27729, 43624, 0.05, 1, 0, 1, 1), -- Enraging Ghoul
(37711, 43624, 0.05, 1, 0, 1, 1), -- Hungering Ghoul
(30083, 43624, 0.05, 1, 0, 1, 1), -- Marauding Geist
(36478, 43624, 0.05, 1, 0, 1, 1), -- Soulguard Watchman
(26734, 43624, 0.05, 1, 0, 1, 1), -- Azure Enforcer
(36620, 43624, 0.05, 1, 0, 1, 1), -- Soulguard Adept
(29819, 43624, 0.05, 1, 0, 1, 1), -- Drakkari Lancer
(36666, 43624, 0.05, 1, 0, 1, 1), -- Spectral Warden
(36788, 43624, 0.04, 1, 0, 1, 1), -- Deathwhisper Necrolyte
(28837, 43624, 0.04, 1, 0, 1, 1), -- Stormforged Sentinel
(26830, 43624, 0.04, 1, 0, 1, 1), -- Risen Drakkari Death Knight
(32191, 43624, 0.04, 1, 0, 1, 1), -- Azure Stalker
(30668, 43624, 0.04, 1, 0, 1, 1), -- Azure Raider
(28732, 43624, 0.04, 1, 0, 1, 1), -- Anub'ar Warrior
(36879, 43624, 0.04, 1, 0, 1, 1), -- Plagueborn Horror
(36830, 43624, 0.04, 1, 0, 1, 1), -- Wrathbone Laborer
(26801, 43624, 0.04, 1, 0, 1, 1), -- Horde Ranger
(36893, 43624, 0.04, 1, 0, 1, 1), -- Ymirjar Flamebearer
(37713, 43624, 0.04, 1, 0, 1, 1), -- Deathwhisper Torturer
(29826, 43624, 0.04, 1, 0, 1, 1), -- Drakkari Medicine Man
(26792, 43624, 0.04, 1, 0, 1, 1), -- Crystalline Protector
(28249, 43624, 0.04, 1, 0, 1, 1), -- Devouring Ghoul
(36564, 43624, 0.04, 1, 0, 1, 1), -- Soulguard Bonecaster
(29237, 43624, 0.04, 1, 0, 1, 1), -- Gundrak Fire-eater
(29836, 43624, 0.03, 1, 0, 1, 1), -- Drakkari Battle Rider
(26800, 43624, 0.03, 1, 0, 1, 1), -- Alliance Berserker
(36886, 43624, 0.03, 1, 0, 1, 1), -- Geist Ambusher
(30667, 43624, 0.03, 1, 0, 1, 1), -- Azure Sorceror
(26729, 43624, 0.03, 1, 0, 1, 1), -- Steward
(38176, 43624, 0.03, 1, 0, 1, 1), -- Tortured Rifleman
(28477, 43624, 0.03, 1, 0, 1, 1), -- Scion of Quetz'lun
(38175, 43624, 0.03, 1, 0, 1, 1), -- Ghostly Priest
(31260, 43624, 0.03, 1, 0, 1, 1), -- Ymirjar Skycaller
(30287, 43624, 0.03, 1, 0, 1, 1), -- Plundering Geist
(26694, 43624, 0.03, 1, 0, 1, 1), -- Ymirjar Dusk Shaman
(26803, 43624, 0.03, 1, 0, 1, 1), -- Horde Cleric
(23956, 43624, 0.03, 1, 0, 1, 1), -- Dragonflayer Strategist
(26550, 43624, 0.03, 1, 0, 1, 1), -- Dragonflayer Deathseeker
(36840, 43624, 0.03, 1, 0, 1, 1), -- Ymirjar Wrathbringer
(27640, 43624, 0.03, 1, 0, 1, 1), -- Ring-Lord Conjurer
(26727, 43624, 0.03, 1, 0, 1, 1), -- Mage Hunter Ascendant
(36891, 43624, 0.03, 1, 0, 1, 1), -- Iceborn Proto-Drake
(29323, 43624, 0.03, 1, 0, 1, 1), -- Sifreldar Storm Maiden
(27966, 43624, 0.03, 1, 0, 1, 1), -- Dark Rune Controller
(27639, 43624, 0.03, 1, 0, 1, 1), -- Ring-Lord Sorceress
(29920, 43624, 0.03, 1, 0, 1, 1), -- Ruins Dweller
(30003, 43624, 0.03, 1, 0, 1, 1), -- Gnarlhide
(26696, 43624, 0.03, 1, 0, 1, 1), -- Ymirjar Berserker
(28581, 43624, 0.03, 1, 0, 1, 1), -- Stormforged Tactician
(29490, 43624, 0.03, 1, 0, 1, 1), -- Captain Hartford
(28582, 43624, 0.03, 1, 0, 1, 1), -- Stormforged Mender
(26635, 43624, 0.03, 1, 0, 1, 1), -- Risen Drakkari Warrior
(26735, 43624, 0.03, 1, 0, 1, 1), -- Azure Scale-Binder
(28368, 43624, 0.03, 1, 0, 1, 1), -- Ymirjar Necromancer
(26622, 43624, 0.02, 1, 0, 1, 1), -- Drakkari Bat
(31150, 43624, 0.02, 1, 0, 1, 1), -- Plagued Fiend
(27962, 43624, 0.02, 1, 0, 1, 1), -- Dark Rune Elementalist
(27963, 43624, 0.02, 1, 0, 1, 1), -- Dark Rune Theurgist
(30283, 43624, 0.02, 1, 0, 1, 1), -- Plague Walker
(26669, 43624, 0.02, 1, 0, 1, 1), -- Ymirjar Savage
(29862, 43624, 0.02, 1, 0, 1, 1), -- Stormforged Monitor
(38172, 43624, 0.02, 1, 0, 1, 1), -- Phantom Mage
(24069, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Bonecrusher
(26626, 43624, 0.02, 1, 0, 1, 1), -- Scourge Reanimator
(40446, 43624, 0.02, 1, 0, 1, 1), -- Skar'this the Summoner
(28257, 43624, 0.02, 1, 0, 1, 1), -- Hath'ar Necromagus
(27635, 43624, 0.02, 1, 0, 1, 1), -- Azure Spellbinder
(30278, 43624, 0.02, 1, 0, 1, 1), -- Ahn'kahar Spell Flinger
(28826, 43624, 0.02, 1, 0, 1, 1), -- Stormfury Revenant
(26728, 43624, 0.02, 1, 0, 1, 1), -- Mage Hunter Initiate
(28848, 43624, 0.02, 1, 0, 1, 1), -- Prophet of Har'koa
(31039, 43624, 0.02, 1, 0, 1, 1), -- Forgotten Depths Underking
(29335, 43624, 0.02, 1, 0, 1, 1), -- Anub'ar Webspinner
(27960, 43624, 0.02, 1, 0, 1, 1), -- Dark Rune Warrior
(27644, 43624, 0.02, 1, 0, 1, 1), -- Phantasmal Wolf
(29768, 43624, 0.02, 1, 0, 1, 1), -- Unyielding Constrictor
(28410, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Spiritualist
(23961, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Ironhelm
(28583, 43624, 0.02, 1, 0, 1, 1), -- Blistering Steamrager
(27636, 43624, 0.02, 1, 0, 1, 1), -- Azure Ley-Whelp
(29820, 43624, 0.02, 1, 0, 1, 1), -- Drakkari God Hunter
(30111, 43624, 0.02, 1, 0, 1, 1), -- Twilight Worshipper
(30277, 43624, 0.02, 1, 0, 1, 1), -- Ahn'kahar Slasher
(26553, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Fanatic
(24071, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Heartsplitter
(26555, 43624, 0.02, 1, 0, 1, 1), -- Scourge Hulk
(37712, 43624, 0.02, 1, 0, 1, 1), -- Deathwhisper Shadowcaster
(37228, 43624, 0.02, 1, 0, 1, 1), -- Frostwarden Warrior
(26621, 43624, 0.02, 1, 0, 1, 1), -- Ghoul Tormentor
(28659, 43624, 0.02, 1, 0, 1, 1), -- Artruis the Heartless
(27647, 43624, 0.02, 1, 0, 1, 1), -- Phantasmal Ogre
(26554, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Seer
(26670, 43624, 0.02, 1, 0, 1, 1), -- Ymirjar Flesh Hunter
(27965, 43624, 0.02, 1, 0, 1, 1), -- Dark Rune Shaper
(30831, 43624, 0.02, 1, 0, 1, 1), -- High Priest Yath'amon
(26637, 43624, 0.02, 1, 0, 1, 1), -- Risen Drakkari Handler
(27961, 43624, 0.02, 1, 0, 1, 1), -- Dark Rune Worker
(26620, 43624, 0.02, 1, 0, 1, 1), -- Drakkari Guardian
(29931, 43624, 0.02, 1, 0, 1, 1), -- Drakkari Rhino
(27964, 43624, 0.02, 1, 0, 1, 1), -- Dark Rune Scholar
(24078, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Metalworker
(30698, 43624, 0.02, 1, 0, 1, 1), -- Morbidus
(31411, 43624, 0.02, 1, 0, 1, 1), -- Hulking Horror
(28325, 43624, 0.02, 1, 0, 1, 1), -- Ravenous Mangal Crocolisk
(26641, 43624, 0.02, 1, 0, 1, 1), -- Drakkari Gutripper
(28105, 43624, 0.02, 1, 0, 1, 1), -- Warlord Tartek
(28580, 43624, 0.02, 1, 0, 1, 1), -- Hardened Steel Skycaller
(30279, 43624, 0.02, 1, 0, 1, 1), -- Deep Crawler
(29915, 43624, 0.02, 1, 0, 1, 1), -- Instructor Hroegar
(29838, 43624, 0.02, 1, 0, 1, 1), -- Drakkari Rhino
(28579, 43624, 0.02, 1, 0, 1, 1), -- Hardened Steel Berserker
(27871, 43624, 0.02, 1, 0, 1, 1), -- Flesheating Ghoul
(27972, 43624, 0.02, 1, 0, 1, 1), -- Lightning Construct
(30164, 43624, 0.02, 1, 0, 1, 1), -- Cavedweller Worg
(28747, 43624, 0.02, 1, 0, 1, 1), -- Quetz'lun Worshipper
(23960, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Runecaster
(28836, 43624, 0.02, 1, 0, 1, 1), -- Stormforged Runeshaper
(30286, 43624, 0.02, 1, 0, 1, 1), -- Frostbringer
(35309, 43624, 0.02, 1, 0, 1, 1), -- Argent Lightwielder
(27651, 43624, 0.02, 1, 0, 1, 1), -- Phantasmal Fire
(26737, 43624, 0.02, 1, 0, 1, 1), -- Crazed Mana-Surge
(27971, 43624, 0.02, 1, 0, 1, 1), -- Unrelenting Construct
(24080, 43624, 0.02, 1, 0, 1, 1), -- Dragonflayer Weaponsmith
(29832, 43624, 0.02, 1, 0, 1, 1), -- Drakkari Golem
(27649, 43624, 0.02, 1, 0, 1, 1), -- Phantasmal Murloc
(26730, 43624, 0.01, 1, 0, 1, 1), -- Mage Slayer
(26799, 43624, 0.01, 1, 0, 1, 1), -- Horde Berserker
(28961, 43624, 0.01, 1, 0, 1, 1), -- Titanium Siegebreaker
(28213, 43624, 0.01, 1, 0, 1, 1), -- Hardknuckle Matriarch
(28838, 43624, 0.01, 1, 0, 1, 1), -- Titanium Vanguard
(30414, 43624, 0.01, 1, 0, 1, 1), -- Forgotten One
(30660, 43624, 0.01, 1, 0, 1, 1), -- Portal Guardian
(28578, 43624, 0.01, 1, 0, 1, 1), -- Hardened Steel Reaver
(27633, 43624, 0.01, 1, 0, 1, 1), -- Azure Inquisitor
(31123, 43624, 0.01, 1, 0, 1, 1), -- Shandaral Spirit Wolf
(30893, 43624, 0.01, 1, 0, 1, 1), -- Portal Keeper
(30276, 43624, 0.01, 1, 0, 1, 1), -- Ahn'kahar Web Winder
(28538, 43624, 0.01, 1, 0, 1, 1), -- Cultist Saboteur
-- old entries, also present in TDB 46
(28069, 43624, 0.05, 1, 0, 1, 1),
(28096, 43624, 0.05, 1, 0, 1, 1),
(28101, 43624, 0.05, 1, 0, 1, 1),
(28158, 43624, 0.05, 1, 0, 1, 1),
(28403, 43624, 0.05, 1, 0, 1, 1),
(28417, 43624, 0.05, 1, 0, 1, 1),
(28565, 43624, 0.05, 1, 0, 1, 1),
(28858, 43624, 0.05, 1, 0, 1, 1),
(28877, 43624, 0.2, 1, 0, 1, 1),
(29013, 43624, 0.05, 1, 0, 1, 1),
(29411, 43624, 0.05, 1, 0, 1, 1),
(29450, 43624, 0.05, 1, 0, 1, 1),
(29569, 43624, 0.05, 1, 0, 1, 1),
(29570, 43624, 0.05, 1, 0, 1, 1),
(29605, 43624, 0.05, 1, 0, 1, 1),
(29623, 43624, 0.1, 1, 0, 1, 1),
(29719, 43624, 0.05, 1, 0, 1, 1),
(29720, 43624, 0.05, 1, 0, 1, 1),
(29843, 43624, 0.1, 1, 0, 1, 1),
(30037, 43624, 0.05, 1, 0, 1, 1),
(31267, 43624, 0.05, 1, 0, 1, 1),
(31746, 43624, 0.05, 1, 0, 1, 1),
(31787, 43624, 4.3, 1, 0, 1, 1);

