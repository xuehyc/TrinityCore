-- make Garwal tameable (24277 normal - 24278 worgen)
UPDATE creature_template SET type_flags = type_flags | 1 WHERE entry IN (24277,24278); 