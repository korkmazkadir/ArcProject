
-- 
-- Definition of  Oven_ctrl
-- 
--      Wed 04 Apr 2018 01:02:56 PM CEST
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

architecture Structural_view_binary_encoding of Oven_ctrl is
   signal state_1, state_2, nx449, state_0, nx450, nx451, nx2, nx34, nx452, 
      nx48, nx68, nx96, nx108, nx124, nx132, nx460, nx463, nx467, nx470, 
      nx473, nx476, nx481, nx483, nx485, nx487, nx489, nx492, nx494, nx496, 
      nx499, nx502, nx504, nx507, nx509, nx512, nx516, nx519, nx521, nx524, 
      nx528: std_logic ;

begin
   ix169 : NOR21 port map ( Q=>Stop_count, A=>nx460, B=>nx124);
   ix461 : CLKIN1 port map ( Q=>nx460, A=>Door_open);
   ix125 : NAND21 port map ( Q=>nx124, A=>nx463, B=>state_2);
   ix464 : NOR21 port map ( Q=>nx463, A=>state_0, B=>nx494);
   ix49 : IMUX21 port map ( Q=>nx48, A=>nx467, B=>nx504, S=>nx509);
   ix468 : AOI2111 port map ( Q=>nx467, A=>Timeout, B=>nx463, C=>nx2, D=>
      Door_open);
   ix3 : NOR21 port map ( Q=>nx2, A=>nx470, B=>nx451);
   ix73 : NAND21 port map ( Q=>nx450, A=>nx473, B=>nx481);
   ix474 : AOI221 port map ( Q=>nx473, A=>state_2, B=>nx451, C=>Time_set, D
      =>nx452);
   reg_state_2 : DFC1 port map ( Q=>state_2, QN=>nx470, C=>clk, D=>nx450, RN
      =>nx476);
   ix477 : CLKIN1 port map ( Q=>nx476, A=>reset);
   ix59 : NAND21 port map ( Q=>nx451, A=>state_0, B=>state_1);
   ix133 : OAI2111 port map ( Q=>nx132, A=>nx481, B=>nx483, C=>nx487, D=>
      nx496);
   ix482 : NAND21 port map ( Q=>nx481, A=>nx460, B=>state_2);
   ix484 : AOI211 port map ( Q=>nx483, A=>Start, B=>nx485, C=>state_1);
   reg_state_0 : DFC1 port map ( Q=>state_0, QN=>nx485, C=>clk, D=>nx48, RN
      =>nx476);
   ix488 : AOI221 port map ( Q=>nx487, A=>nx489, B=>nx452, C=>Timeout, D=>
      nx492);
   ix490 : CLKIN1 port map ( Q=>nx489, A=>Time_set);
   ix65 : NOR21 port map ( Q=>nx452, A=>state_2, B=>nx451);
   ix493 : NOR31 port map ( Q=>nx492, A=>state_0, B=>nx494, C=>nx470);
   reg_state_1 : DFC1 port map ( Q=>state_1, QN=>nx494, C=>clk, D=>nx132, RN
      =>nx476);
   ix497 : OAI211 port map ( Q=>nx496, A=>nx108, B=>nx96, C=>nx470);
   ix109 : AOI2111 port map ( Q=>nx108, A=>nx499, B=>nx494, C=>Full_power, D
      =>state_0);
   ix500 : CLKIN1 port map ( Q=>nx499, A=>Half_power);
   ix97 : AOI2111 port map ( Q=>nx96, A=>nx502, B=>nx499, C=>state_1, D=>
      nx485);
   ix503 : NOR31 port map ( Q=>nx502, A=>s60, B=>s120, C=>s30);
   ix505 : AOI2111 port map ( Q=>nx504, A=>Full_power, B=>nx485, C=>nx452, D
      =>nx34);
   ix35 : OAI311 port map ( Q=>nx34, A=>nx485, B=>Half_power, C=>state_1, D
      =>nx507);
   ix508 : OAI311 port map ( Q=>nx507, A=>s60, B=>s120, C=>s30, D=>nx463);
   ix510 : AOI2111 port map ( Q=>nx509, A=>Time_set, B=>nx452, C=>nx68, D=>
      nx449);
   ix69 : NOR21 port map ( Q=>nx68, A=>nx470, B=>nx512);
   ix513 : NOR21 port map ( Q=>nx512, A=>nx485, B=>nx494);
   ix81 : NOR21 port map ( Q=>nx449, A=>Door_open, B=>nx470);
   ix179 : OAI221 port map ( Q=>Finished, A=>nx516, B=>nx124, C=>nx451, D=>
      nx481);
   ix517 : CLKIN1 port map ( Q=>nx516, A=>Timeout);
   ix165 : NAND31 port map ( Q=>In_light, A=>nx519, B=>nx124, C=>nx521);
   ix520 : OAI2111 port map ( Q=>nx519, A=>nx494, B=>nx460, C=>nx450, D=>
      nx481);
   ix522 : NAND41 port map ( Q=>nx521, A=>Start, B=>nx494, C=>nx485, D=>
      nx449);
   ix147 : NOR40 port map ( Q=>Start_count, A=>nx524, B=>state_1, C=>state_0, 
      D=>nx481);
   ix525 : CLKIN1 port map ( Q=>nx524, A=>Start);
   ix185 : NOR31 port map ( Q=>Half, A=>nx512, B=>nx499, C=>state_2);
   ix191 : NOR31 port map ( Q=>Full, A=>nx512, B=>nx528, C=>state_2);
   ix529 : CLKIN1 port map ( Q=>nx528, A=>Full_power);
end Structural_view_binary_encoding ;

