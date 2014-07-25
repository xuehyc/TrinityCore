--
--
--
-- fixes startup error loading transports (this table has currently no data)
ALTER TABLE transports ADD phaseid INT(10) not null DEFAULT'0' AFTER name;
ALTER TABLE transports ADD phasegroup INT(10) not null DEFAULT'0' AFTER phaseid;