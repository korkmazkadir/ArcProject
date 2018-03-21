library IEEE;
use IEEE.std_logic_1164.all;

entity test_counter is
end test_counter;

architecture test1 of test_counter is
  component Oven_count is
     port(reset, clk, start, stop, s30, s60, s120: in std_logic; 
         aboveth: out std_logic);
  end component;
  signal r,timer,sta,sto,s3,s6,s12 : std_logic := '0';
  signal abv : std_logic;
begin
	A: oven_count port map(r,timer,sta,sto,s3,s6,s12,abv);
     -- Add here your input stimulis
clocktime: process 
begin  -- process clocktime
	wait for 500 ms;
    	timer <= not timer;
end process clocktime;	

	s3<= '1';
	sta <= '1' after 5000 ms,'0' after 6 sec;

end test1;

library LIB_oven;
library LIB_oven_BENCH;

configuration config1 of LIB_oven_BENCH.test_counter is 
    for test1 
       for A:oven_count use entity LIB_oven.oven_count(Impl);
       end for;
    end for; 
end config1; 

