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
         if (state = Set_time and Time_set = '1' and Door_open = '1') or
          (state = Operation_enabled and Door_open = '1') or
          (state = Operation_enabled and Start = '1' and door_open = '0') or
          (state = Operating) or
          (state = Operation_disabled and door_open='0')then
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
