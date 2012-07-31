-- Update mechanic immunity flags.
UPDATE `creature_template` SET `mechanic_immune_mask`=650853247, `flags_extra`=1 WHERE `entry` IN 
(
33113,   -- Flame Leviathan
33118,   -- Ignis the Furnace Master
33186,   -- Razorscale
33293,   -- XT002
32867,   -- Steelbreaker
32927,   -- Runemaster Molgeim
32930,   -- Kologarn
32906,   -- Freya
32845,   -- Hodir
33350,   -- Mimiron
33432,   -- Leviathan MK II
33651,   -- VX-001
33670,   -- Aerial Unit
32865,   -- Thorim
33271,   -- General Vezax
33524,   -- Saronite Animus
33288,   -- Yogg-Saron
33134,   -- Sara
33890    -- Brain of Yogg-Saron
);

-- Auriaya should be interruptible, due to Sentinel Blast
UPDATE `creature_template` SET `mechanic_immune_mask`=617298815 WHERE `entry` IN (33515);
-- Stormcaller Brundir, immunities to stun and interrupt are gained infight.
UPDATE `creature_template` SET `mechanic_immune_mask`=617296767, `flags_extra`=1 WHERE `entry` IN (32857);   
