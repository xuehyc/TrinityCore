-- Updates by Monad from SPP community

-- npc - fix for engi vendor in stormwind
UPDATE creature_template SET npcflag=128 WHERE entry=5519;

-- NPC - Silvermoon bankers set to open bank
UPDATE creature_template SET gossip_menu_id=0 WHERE entry IN (17631,17632, 17633);

-- fix- adding spells to npc trainer 16367 
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=2366;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 2366, 10, 0, 0, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=2368;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 2368, 500, 182, 50, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=3570;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 3570, 5000, 182, 125, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=11993;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 11993, 50000, 182, 200, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=28695;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 28695, 100000, 182, 275, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=50300;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 50300, 350000, 182, 350, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=74519;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 74519, 500000, 182, 425, 0, 0);
DELETE FROM `npc_trainer` WHERE `ID`=16367 AND `SpellID`=110413;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES (16367, 110413, 600000, 182, 500, 0, 0);