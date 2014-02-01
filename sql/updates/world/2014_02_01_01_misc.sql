

-- darkshore

-- npc 34415 Darkscale Priestess
update creature_template set AIName="", ScriptName="npc_darkscale_priestess" where entry=34415;

-- npc 34416 Queen Azshara
update creature_template set AIName="", ScriptName="npc_queen_azshara" where entry=34416;

-- npc 34422 Malfurion Stormrage
update creature_template set AIName="", ScriptName="npc_malfurion_stormrage" where entry=34422;




-- When you kill the 4 priestesses, Queen Azshara will spawn, followed by Malfurion Stormrage.

-- Queen Azshara yells: Who dares oppose Queen Azshara? You will soon beg for a swift death!
-- Malfurion Stormrage yells: It's over Azshara! You and your naga will return to the bottom of the seas where you belong!
-- Queen Azshara says: Ah... Malfurion Stormrage. I'd hoped to keep you occupied for a little longer. It was my goal to keep you away from Hyjal while my allies attacked. It would seem I have succeeded.
-- Queen Azshara says: I've no need to fight you, for it appears I've already won. You cannot stop our attack on Darkshore and save Hyjal at the same time!

-- Queen Azshara leaves and despawns.

-- Malfurion Stormrage says: She's not lying. Nordrassil is in danger. I must make haste and prepare for Hyjal's defense.
-- Malfurion Stormrage says: It will be up to you to use the Horn of the Ancients and stop Soggoth's return.

-- Malfurion then offers a followup quest The Battle for Darkshore (pick it up quickly before he despawns after a minute or you have to repeat the scripted event).
-- das ist quest 13897

-- Azshara 4607.107    ,884.2894    ,37.89753,    2.423
-- Malfurion X: 4595.326172 Y: 905.159851 Z: 42.118744

