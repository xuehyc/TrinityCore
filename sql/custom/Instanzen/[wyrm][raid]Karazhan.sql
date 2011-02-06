UPDATE `creature` SET `spawntimesecs`= 3600000 where `map` in(532,548,565);
Update creature_template set mechanic_immune_mask = 0 where entry in (19872,19873,19874,19875,19876,17007);

Update creature_template set mechanic_immune_mask = 113983323 where entry = 16151;
Update creature_template set mechanic_immune_mask = 113983323 where entry = 15550;
Update creature_template set mechanic_immune_mask = 113983323 where entry = 15687;
Update creature_template set mechanic_immune_mask = 113983323 where entry = 16457;
Update creature_template set mechanic_immune_mask = 113983323 where entry = 15691;
Update creature_template set mechanic_immune_mask = 113983323 where entry = 15688;
Update creature_template set mechanic_immune_mask = 113983323 where entry = 17229;
Update creature_template set mechanic_immune_mask = 113983323 where entry = 15690;

update event_scripts set datalong2 = 1 where id =10591;

delete from creature where id = 15689;