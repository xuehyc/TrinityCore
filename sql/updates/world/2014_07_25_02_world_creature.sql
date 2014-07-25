
-- guid by ArkDB
-- ship  <The Lady Mehley> = map 584.. the crew is not spawned 
-- http://www.wowhead.com/npc=24833  Captain "Stash" Torgoley <The Lady Mehley>
-- http://www.wowhead.com/npc=24834  Galley Chief Grace <The Lady Mehley>
-- http://www.wowhead.com/npc=24835  First Mate Kowalski <The Lady Mehley>
-- http://www.wowhead.com/npc=24836  Abe the Cabin Boy <The Lady Mehley>
-- http://www.wowhead.com/npc=24837  Navigator Mehran <The Lady Mehley>
-- http://www.wowhead.com/npc=24838  Sailor Henders <The Lady Mehley>
-- http://www.wowhead.com/npc=24839  Sailor Wicks <The Lady Mehley>
-- http://www.wowhead.com/npc=24840  Sailor Vines <The Lady Mehley>
-- http://www.wowhead.com/npc=24841  Marine Halters
-- http://www.wowhead.com/npc=24842  Marine Anderson
-- http://www.wowhead.com/npc=24843  Engineer Combs <The Lady Mehley>

delete from creature where id between 24833 and 24843;

insert into creature (guid,id,map,position_x,position_y,position_z,orientation,spawntimesecs) values
(282915,24833,584,25.2165,6.9111,16.1459,3.94958,120),
(282916,24843,584,13.2057,-2.817,6.09989,3.88733,120),
(282917,24835,584,19.2178,-8.20848,12.1102,4.81518,120),
(282918,24834,584,18.1475,-7.41572,6.09809,1.88535,120),
(282919,24841,584,0.194107,9.84585,6.09941,3.08731,120),
(282920,24842,584,-0.532552,-8.68575,6.09815,3.19019,120),
(282921,24837,584,34.0669,0.119702,18.287,3.17832,120),
(282922,24838,584,-11.1276,6.60326,6.09852,3.05167,120),
(282923,24839,584,6.22581,9.13103,11.4836,1.53614,120),
(282924,24840,584,10.2474,2.78122,11.803,3.46823,120),
(282925,24836,584,-10.1276,4.60326,6.09852,1.21167,120);


