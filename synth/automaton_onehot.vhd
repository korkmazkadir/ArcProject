
-- 
-- Definition of  Oven_ctrl
-- 
--      Wed 04 Apr 2018 01:04:57 PM CEST
--      
--      LeonardoSpectrum Level 3, 2015a.6
-- 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
library c35_CORELIB;
use c35_CORELIB.vcomponents.all;


entity Oven_ctrl is
   port (
      reset : IN std_logic ;
      clk : IN std_logic ;
      Half_power : IN std_logic ;
      Full_power : IN std_logic ;
      Start : IN std_logic ;
      s30 : IN std_logic ;
      s60 : IN std_logic ;
      s120 : IN std_logic ;
      Time_set : IN std_logic ;
      Door_open : IN std_logic ;
      Timeout : IN std_logic ;
      Full : OUT std_logic ;
      Half : OUT std_logic ;
      In_light : OUT std_logic ;
      Finished : OUT std_logic ;
      Start_count : OUT std_logic ;
      Stop_count : OUT std_logic) ;
end Oven_ctrl ;

architecture Structural_view_onehot_encoding of Oven_ctrl is
   signal Finished_EXMPLR, state_3, nx2, state_1, state_2, state_0, state_7, 
      state_6, state_4, state_5, nx38, nx56, nx76, nx96, nx104, nx110, nx120, 
      nx142, nx844, nx846, nx849, nx853, nx855, nx857, nx861, nx863, nx865, 
      nx870, nx872, nx874, nx877, nx880, nx883, nx886, nx888, nx890, nx892, 
      nx893, nx897, nx899, nx901, nx905, nx908, nx910: std_logic ;

begin
   Finished <= Finished_EXMPLR ;
   ix89 : OAI221 port map ( Q=>Finished_EXMPLR, A=>nx844, B=>nx846, C=>
      Door_open, D=>nx883);
   ix845 : CLKIN1 port map ( Q=>nx844, A=>Timeout);
   ix77 : OAI311 port map ( Q=>nx76, A=>Door_open, B=>nx846, C=>Timeout, D=>
      nx849);
   ix850 : NAND31 port map ( Q=>nx849, A=>state_4, B=>Start, C=>nx897);
   reg_state_4 : DFC1 port map ( Q=>state_4, QN=>nx905, C=>clk, D=>nx56, RN
      =>nx872);
   ix57 : AOI211 port map ( Q=>nx56, A=>nx853, B=>nx857, C=>Door_open);
   ix854 : NAND21 port map ( Q=>nx853, A=>nx855, B=>state_4);
   ix856 : CLKIN1 port map ( Q=>nx855, A=>Start);
   ix858 : AOI211 port map ( Q=>nx857, A=>Time_set, B=>state_3, C=>state_5);
   ix143 : OAI221 port map ( Q=>nx142, A=>nx861, B=>nx863, C=>Time_set, D=>
      nx893);
   ix862 : NOR31 port map ( Q=>nx861, A=>s60, B=>s120, C=>s30);
   ix864 : AOI221 port map ( Q=>nx863, A=>nx865, B=>state_2, C=>nx890, D=>
      state_1);
   ix866 : CLKIN1 port map ( Q=>nx865, A=>Full_power);
   ix111 : OAI311 port map ( Q=>nx110, A=>nx2, B=>Full_power, C=>nx870, D=>
      nx874);
   ix3 : CLKIN1 port map ( Q=>nx2, A=>nx861);
   reg_state_2 : DFC1 port map ( Q=>state_2, QN=>nx870, C=>clk, D=>nx110, RN
      =>nx872);
   ix873 : CLKIN1 port map ( Q=>nx872, A=>reset);
   ix875 : OAI211 port map ( Q=>nx874, A=>nx104, B=>state_1, C=>Half_power);
   ix105 : NOR21 port map ( Q=>nx104, A=>Full_power, B=>nx877);
   reg_state_0 : DFP1 port map ( Q=>state_0, QN=>nx877, C=>clk, D=>nx96, SN
      =>nx872);
   ix97 : OAI311 port map ( Q=>nx96, A=>nx877, B=>Half_power, C=>Full_power, 
      D=>nx880);
   ix881 : NAND21 port map ( Q=>nx880, A=>Door_open, B=>state_7);
   reg_state_7 : DFC1 port map ( Q=>state_7, QN=>nx883, C=>clk, D=>
      Finished_EXMPLR, RN=>nx872);
   reg_state_1 : DFC1 port map ( Q=>state_1, QN=>nx892, C=>clk, D=>nx120, RN
      =>nx872);
   ix121 : OAI211 port map ( Q=>nx120, A=>nx865, B=>nx886, C=>nx888);
   ix887 : NOR21 port map ( Q=>nx886, A=>state_0, B=>state_2);
   ix889 : NAND31 port map ( Q=>nx888, A=>nx861, B=>nx890, C=>state_1);
   ix891 : CLKIN1 port map ( Q=>nx890, A=>Half_power);
   reg_state_3 : DFC1 port map ( Q=>state_3, QN=>nx893, C=>clk, D=>nx142, RN
      =>nx872);
   reg_state_5 : DFC1 port map ( Q=>state_5, QN=>OPEN, C=>clk, D=>nx38, RN=>
      nx872);
   ix39 : OAI221 port map ( Q=>nx38, A=>nx897, B=>nx899, C=>Timeout, D=>
      nx901);
   ix898 : CLKIN1 port map ( Q=>nx897, A=>Door_open);
   ix900 : AOI2111 port map ( Q=>nx899, A=>Time_set, B=>state_3, C=>state_5, 
      D=>state_4);
   ix902 : NAND21 port map ( Q=>nx901, A=>Door_open, B=>state_6);
   reg_state_6 : DFC1 port map ( Q=>state_6, QN=>nx846, C=>clk, D=>nx76, RN
      =>nx872);
   ix33 : NOR21 port map ( Q=>Stop_count, A=>nx897, B=>nx846);
   ix163 : NAND41 port map ( Q=>In_light, A=>nx849, B=>nx846, C=>nx908, D=>
      nx910);
   ix909 : OAI211 port map ( Q=>nx908, A=>state_4, B=>state_5, C=>Door_open
   );
   ix911 : NAND31 port map ( Q=>nx910, A=>state_3, B=>Time_set, C=>nx897);
   ix67 : NOR31 port map ( Q=>Start_count, A=>nx905, B=>nx855, C=>Door_open
   );
   ix167 : AOI211 port map ( Q=>Half, A=>nx886, B=>nx892, C=>nx890);
   ix171 : AOI211 port map ( Q=>Full, A=>nx886, B=>nx892, C=>nx865);
end Structural_view_onehot_encoding ;

