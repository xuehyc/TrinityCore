-- @DorianGrey: Fixing movement distractions on Putricides' Ooze-pets. 
-- It should only be possible to slow them down with "Regurgitated Ooze" from the abomination.
-- Since this counts as a special-effect, it's enough to cut any other possible distractions off.
UPDATE `creature_template` SET `mechanic_immune_mask`=(650853247|1024) WHERE `entry` in (37697, 37562);