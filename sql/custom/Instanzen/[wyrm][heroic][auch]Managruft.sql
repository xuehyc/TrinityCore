-- id
update creature_template set `flags_extra` = `flags_extra`|'1' where entry in 
(20267,20268,20266);