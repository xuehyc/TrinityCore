--
--
--
-- fixes startup error loading creature_template (this table has currently no data)
ALTER TABLE creature_template ADD femaleName CHAR(100) not null AFTER name;
