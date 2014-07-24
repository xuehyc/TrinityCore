--
--
--
-- fixes startup error loading phase_definitions (this table has currently no data)
ALTER TABLE phase_definitions ADD phaseGroup INT(10) not null DEFAULT'0' AFTER phaseId;