
-- 
-- Definition of  Oven_ctrl
-- 
--      Wed 04 Apr 2018 01:07:56 PM CEST
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

architecture Structural_view_gray_encoding of Oven_ctrl is
   signal state_0, state_1, state_2, nx461, nx2, nx4, nx10, nx24, nx32, nx36, 
      nx40, nx44, nx462, nx76, nx104, nx118, nx463, nx130, nx134, nx471, 
      nx475, nx479, nx482, nx484, nx486, nx492, nx494, nx496, nx498, nx502, 
      nx505, nx508, nx511, nx513, nx514, nx516, nx518, nx521, nx527, nx530, 
      nx533, nx536, nx540: std_logic ;

begin
   ix165 : NOR40 port map ( Q=>Stop_count, A=>nx471, B=>state_1, C=>nx492, D
      =>nx513);
   ix472 : CLKIN1 port map ( Q=>nx471, A=>Door_open);
   ix77 : OAI2111 port map ( Q=>nx76, A=>nx475, B=>nx514, C=>nx516, D=>nx518
   );
   ix476 : NAND31 port map ( Q=>nx475, A=>state_0, B=>nx492, C=>nx482);
   reg_state_0 : DFC1 port map ( Q=>state_0, QN=>nx513, C=>clk, D=>nx134, RN
      =>nx484);
   ix135 : OAI2111 port map ( Q=>nx134, A=>nx471, B=>nx479, C=>nx486, D=>
      nx505);
   ix480 : NAND21 port map ( Q=>nx479, A=>Time_set, B=>nx462);
   ix85 : NOR21 port map ( Q=>nx462, A=>nx482, B=>state_0);
   reg_state_1 : DFC1 port map ( Q=>state_1, QN=>nx482, C=>clk, D=>nx76, RN
      =>nx484);
   ix485 : CLKIN1 port map ( Q=>nx484, A=>reset);
   ix487 : NOR21 port map ( Q=>nx486, A=>nx130, B=>nx118);
   ix131 : OAI221 port map ( Q=>nx130, A=>Timeout, B=>nx463, C=>nx498, D=>
      nx36);
   ix147 : NAND31 port map ( Q=>nx463, A=>nx482, B=>state_2, C=>state_0);
   ix11 : OAI2111 port map ( Q=>nx10, A=>nx492, B=>nx494, C=>nx496, D=>nx479
   );
   reg_state_2 : DFC1 port map ( Q=>state_2, QN=>nx492, C=>clk, D=>nx10, RN
      =>nx484);
   ix495 : NOR21 port map ( Q=>nx494, A=>state_0, B=>state_1);
   ix497 : NAND21 port map ( Q=>nx496, A=>nx471, B=>state_2);
   ix499 : AOI211 port map ( Q=>nx498, A=>state_1, B=>state_0, C=>nx494);
   ix37 : NAND21 port map ( Q=>nx36, A=>nx492, B=>Full_power);
   ix119 : OAI311 port map ( Q=>nx118, A=>nx482, B=>nx471, C=>nx492, D=>
      nx502);
   ix503 : NAND31 port map ( Q=>nx502, A=>nx2, B=>Start, C=>nx462);
   ix3 : NOR21 port map ( Q=>nx2, A=>Door_open, B=>nx492);
   ix506 : AOI211 port map ( Q=>nx505, A=>nx482, B=>nx40, C=>nx104);
   ix41 : NOR21 port map ( Q=>nx40, A=>nx508, B=>state_2);
   ix509 : CLKIN1 port map ( Q=>nx508, A=>Half_power);
   ix105 : NOR40 port map ( Q=>nx104, A=>s30, B=>s120, C=>s60, D=>nx511);
   ix512 : NAND21 port map ( Q=>nx511, A=>nx492, B=>state_0);
   ix515 : NOR40 port map ( Q=>nx514, A=>nx40, B=>s30, C=>s60, D=>s120);
   ix517 : NAND21 port map ( Q=>nx516, A=>nx502, B=>nx462);
   ix519 : AOI211 port map ( Q=>nx518, A=>nx36, B=>nx44, C=>nx32);
   ix45 : OAI211 port map ( Q=>nx44, A=>nx513, B=>nx482, C=>nx521);
   ix522 : NAND21 port map ( Q=>nx521, A=>Half_power, B=>nx492);
   ix33 : NOR40 port map ( Q=>nx32, A=>Timeout, B=>nx492, C=>nx24, D=>nx471
   );
   ix25 : OAI211 port map ( Q=>nx24, A=>nx482, B=>nx513, C=>nx4);
   ix5 : NAND21 port map ( Q=>nx4, A=>nx513, B=>nx482);
   ix175 : OAI221 port map ( Q=>Finished, A=>nx527, B=>nx463, C=>nx4, D=>
      nx496);
   ix528 : CLKIN1 port map ( Q=>nx527, A=>Timeout);
   ix161 : NAND21 port map ( Q=>In_light, A=>nx530, B=>nx463);
   ix531 : AOI311 port map ( Q=>nx530, A=>nx461, B=>nx471, C=>nx492, D=>
      nx118);
   ix87 : NOR31 port map ( Q=>nx461, A=>nx533, B=>nx482, C=>state_0);
   ix534 : CLKIN1 port map ( Q=>nx533, A=>Time_set);
   ix69 : NOR40 port map ( Q=>Start_count, A=>nx496, B=>nx536, C=>nx482, D=>
      state_0);
   ix537 : CLKIN1 port map ( Q=>nx536, A=>Start);
   ix181 : AOI2111 port map ( Q=>Half, A=>nx513, B=>state_1, C=>nx508, D=>
      state_2);
   ix189 : AOI2111 port map ( Q=>Full, A=>nx513, B=>state_1, C=>nx540, D=>
      state_2);
   ix541 : CLKIN1 port map ( Q=>nx540, A=>Full_power);
end Structural_view_gray_encoding ;

