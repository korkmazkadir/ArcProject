library ieee;
use ieee.std_logic_1164.all;


entity Oven_ctrl is
     port(reset, clk, Half_power, Full_power, Start, s30, s60, s120, Time_set, Door_open, Timeout : in std_logic;
          Full, Half, In_light, Finished, Start_count, Stop_count: out std_logic);
end Oven_ctrl;

architecture Dataflow_view of Oven_ctrl is 
 type States is (Idle, 
	Full_power_on, 
	Half_power_on, 
	Set_time, 
	Operation_enabled, 
	Operation_disabled, 
	Operating,
	Complete);

 signal state, nextstate : States := Idle;
 
-- PSL default clock is (clk'event and clk='1');
-- PSL property prop1 is always((state=Idle -> state/= Operation_enabled) until Time_set='1');
-- PSL assert prop1;

-- PSL property prop2 is always((state=Operating and  Door_open='1' ) -> ( next (state /= Operating) and (start='1' before state = Operating) )   );
-- PSL assert prop2;

-- PSL property prop3 is always((state=Operating) ->  (In_light = '1' until( (state = Operation_disabled and Door_open /= '1' ) or Timeout = '1' ) ) );
-- PSL assert prop3;
-- -- PSL property prop4 is ( ( state=Operation_enabled and start='1') ; (timeout='0' and Door_open='0')[*] ; (Door_open='0')[*]; Timeout='1' ; (Door_open='0')[*];Door_open='1')      ;


begin 
 
 t: process (reset, clk, Half_power, Full_power, Start, s30, s60, s120, Time_set, Door_open, Timeout)
 begin  -- process
   case state is
     when Idle => 
	if Full_power='1' then
	 nextstate <= Full_power_on;
        elsif Half_power='1' then
          nextstate <= Half_power_on;
        else
          nextstate <= Idle;
        end if;
     when Full_power_on =>
       if Half_power='1' then
         nextstate <= Half_power_on;
       elsif s30='1' or s60='1' or s120='1'then
           nextstate <= Set_time;
       else
           nextstate <= Full_power_on;
       end if;
     when Half_power_on =>
       if Full_power='1' then
         nextstate <= Full_power_on;
       elsif s30='1' or s60='1' or s120='1'then
           nextstate <= Set_time;
           
       else
           nextstate <= Half_power_on;
       end if;

     when Set_time =>
           if Time_set ='1' and not (door_open='1') then
             nextstate <= Operation_enabled;
           elsif Time_set='1' and door_open='1' then
             nextstate <= Operation_disabled;
           else
             nextstate<= Set_time;
           end if;
     when Operation_enabled =>
           if Start='1' and door_open='0' then
             nextstate <= Operating;
           elsif Door_open='1' then
             nextstate <= Operation_disabled;
           else
             nextstate <= Operation_enabled;
           end if;
     when Operation_disabled =>
           if Door_open='0' then
             nextstate <= Operation_enabled;
           else
             nextstate <= Operation_disabled; 
           end if;
     when Operating =>
           if timeout='1' then
             nextstate <= Complete;
           elsif Door_open='1' then
             nextstate <= Operation_disabled;
           else
             nextstate <= Operating;          
           end if;
     when Complete =>
           if Door_open='1' then
             nextstate <= Idle;
           else
             nextstate <= Complete;
           end if;
     when others        => null;
   end case;            
 end process;

 
 -- purpose: apply nexstate into state
 -- type   : combinational
 -- inputs : nexstate
 -- outputs: state
 changestate: process (reset,clk)
 begin  -- process changestate
   if(reset = '1') then state <= Idle;
   elsif clk'event and clk = '1' then
     state <= nextstate;  
   end if;  
 end process changestate;


 
f: process (reset, clk, Half_power, Full_power, Start, s30, s60, s120, Time_set, Door_open, Timeout)
begin  -- process

       -- Full
       if (state = Idle and Full_power = '1') or
         (state = Full_power_on and Full_power = '1') or
         (state = Half_power_on and Full_power = '1')  then
         Full <= '1';
       else
         Full <= '0';
       end if;

       -- Half
        if (state = Idle and Half_power = '1') or
         (state = Half_power_on and Half_power = '1') or
         (state = Full_power_on and Half_power = '1')  then
         Half <= '1';
       else
         Half <= '0';
       end if;

         --inlight
         if (state = Set_time and Time_set = '1' and Door_open = '0') or
          (state = Operation_enabled and Door_open = '1') or
          (state = Operation_enabled and Start = '1' and door_open = '0') or
          (state = Operating) or
          (state = Operation_disabled and door_open='1')then
           in_light <= '1';
         else
           in_light <= '0';
         end if;
         
         --finished
         if (state = Operating and Timeout='1') or ( state = Complete and Door_open='0') then
           finished <= '1';
         else
           finished <= '0';
         end if;

        --Start_count
         if (state = Operation_enabled and Start = '1' and Door_open='0') then
           Start_count <= '1';
         else
           Start_count <= '0'; 
         end if;

         --Stop_count
         if (state= Operating and Door_open='1') then
           Stop_count<='1';
         else
           Stop_count<='0';
         end if;
         
end process  ;

end Dataflow_view;

library c35_CORELIB;
use c35_CORELIB.vcomponents.all;

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

library c35_CORELIB;
use c35_CORELIB.vcomponents.all;

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

library c35_CORELIB;
use c35_CORELIB.vcomponents.all;

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

