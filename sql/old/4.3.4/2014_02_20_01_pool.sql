
-- crater un'goro

set @MPI = 14498;
set @CI = @MPI+1;

delete from pool_template where entry=@MPI;
insert into pool_template value(@MPI,1,"Mother pool (plated)stegodon, crater un'goror");

delete from pool_template where entry between @CI and @CI+18;
insert into pool_template value(@CI,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+1,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+2,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+3,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+4,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+5,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+6,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+7,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+8,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+9,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+10,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+11,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+12,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+13,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+14,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+15,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+16,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+17,1,"Group (plated)stegodon, crater un'goror");
insert into pool_template value(@CI+18,1,"Group (plated)stegodon, crater un'goror");


delete from pool_pool where pool_id between @CI and @CI+18;
insert into pool_pool values (@CI,@MPI,0,"group1: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+1,@MPI,0,"group2: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+2,@MPI,0,"group3: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+3,@MPI,0,"group4: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+4,@MPI,0,"group5: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+5,@MPI,0,"group6: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+6,@MPI,0,"group7: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+7,@MPI,0,"group8: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+8,@MPI,0,"group9: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+9,@MPI,0,"group10: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+10,@MPI,0,"group11: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+11,@MPI,0,"group12: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+12,@MPI,0,"group13: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+13,@MPI,0,"group14: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+14,@MPI,0,"group15: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+15,@MPI,0,"group16: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+16,@MPI,0,"group17: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+17,@MPI,0,"group18: (plated)stegodon, crater un'goror"); 
insert into pool_pool values (@CI+18,@MPI,0,"group19: (plated)stegodon, crater un'goror"); 


-- group 1
delete from pool_creature where guid in (73692,105446);
insert into pool_creature values (73692,@CI,0,"stegodon group 1");
insert into pool_creature values (105446,@CI,0,"stegodon group 1");

-- group 2
delete from pool_creature where guid in (73691,105713);
insert into pool_creature values (73691,@CI+1,0,"stegodon group 2");
insert into pool_creature values (105713,@CI+1,0,"stegodon group 2");

-- group 3
delete from pool_creature where guid in (73690,113889);
insert into pool_creature values (73690,@CI+2,0,"stegodon group 3");
insert into pool_creature values (113889,@CI+2,0,"stegodon group 3");

-- group 4
delete from pool_creature where guid in (73694,105662);
insert into pool_creature values (73694,@CI+3,0,"stegodon group 4");
insert into pool_creature values (105662,@CI+3,0,"stegodon group 4");

-- group 5
delete from pool_creature where guid in (73696,105965);
insert into pool_creature values (73696,@CI+4,0,"stegodon group 5");
insert into pool_creature values (105965,@CI+4,0,"stegodon group 5");

-- group 6
delete from pool_creature where guid in (73702,105773);
insert into pool_creature values (73702,@CI+5,0,"stegodon group 6");
insert into pool_creature values (105773,@CI+5,0,"stegodon group 6");

-- group 7
delete from pool_creature where guid in (73684,105694);
insert into pool_creature values (73684,@CI+6,0,"stegodon group 7");
insert into pool_creature values (105694,@CI+6,0,"stegodon group 7");

-- group 8
delete from pool_creature where guid in (73689,113539);
insert into pool_creature values (73689,@CI+7,0,"stegodon group 8");
insert into pool_creature values (113539,@CI+7,0,"stegodon group 8");

-- group 9
delete from pool_creature where guid in (73695,105929);
insert into pool_creature values (73695,@CI+8,0,"stegodon group 9");
insert into pool_creature values (105929,@CI+8,0,"stegodon group 9");

-- group 10
delete from pool_creature where guid in (73680,105677);
insert into pool_creature values (73680,@CI+9,0,"stegodon group 10");
insert into pool_creature values (105677,@CI+9,0,"stegodon group 10");

-- group 11
delete from pool_creature where guid in (73704,113623);
insert into pool_creature values (73704,@CI+10,0,"stegodon group 11");
insert into pool_creature values (113623,@CI+10,0,"stegodon group 11");

-- group 12
delete from pool_creature where guid in (73700,105665);
insert into pool_creature values (73700,@CI+11,0,"stegodon group 12");
insert into pool_creature values (105665,@CI+11,0,"stegodon group 12");

-- group 13
delete from pool_creature where guid in (73693,113636);
insert into pool_creature values (73693,@CI+12,0,"stegodon group 13");
insert into pool_creature values (113636,@CI+12,0,"stegodon group 13");

-- group 14
delete from pool_creature where guid in (73687,105410);
insert into pool_creature values (73687,@CI+13,0,"stegodon group 14");
insert into pool_creature values (105410,@CI+13,0,"stegodon group 14");

-- group 15
delete from pool_creature where guid in (73701,113746);
insert into pool_creature values (73701,@CI+14,0,"stegodon group 15");
insert into pool_creature values (113746,@CI+14,0,"stegodon group 15");

-- group 16
delete from pool_creature where guid in (73685,105774);
insert into pool_creature values (73685,@CI+15,0,"stegodon group 16");
insert into pool_creature values (105774,@CI+15,0,"stegodon group 16");

-- group 17
delete from pool_creature where guid in (73689,113719);
insert into pool_creature values (73689,@CI+16,0,"stegodon group 17");
insert into pool_creature values (113719,@CI+16,0,"stegodon group 17");

-- group 18
delete from pool_creature where guid in (73688,113810);
insert into pool_creature values (73688,@CI+17,0,"stegodon group 18");
insert into pool_creature values (113810,@CI+17,0,"stegodon group 18");

-- group 19
delete from pool_creature where guid in (73681,105396);
insert into pool_creature values (73681,@CI+18,0,"stegodon group 19");
insert into pool_creature values (105396,@CI+18,0,"stegodon group 19");
