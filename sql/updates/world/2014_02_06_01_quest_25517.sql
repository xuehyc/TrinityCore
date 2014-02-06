
--
-- quest 25517_Alliance 25518_Horde Bar Fight!
--
update quest_template set QuestGiverPortrait=31912 where Id=25518;
update quest_template set QuestGiverPortrait=31915 where Id=25517;

update creature_template set unit_flags=33536 where entry in (40776,40778,40779,40483,40494,40529,40530,42718);

update creature_template set AIName="",ScriptName="npc_goblin_bar_patron" where entry=40530;
update creature_template set AIName="",ScriptName="npc_goblin_bar_patron" where entry=40494;

update creature_template set AIName="",ScriptName="npc_gnome_bar_patron" where entry=40483;
update creature_template set AIName="",ScriptName="npc_gnome_bar_patron" where entry=40529;

