----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:58:55 12/21/2019 
-- Design Name: 
-- Module Name:    Ring_Osc - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Ring_Osc is

	PORT (
				enable_i : in STD_LOGIC := '0';
				Q : out STD_LOGIC := '0'
		   );

end Ring_Osc;

architecture Behavioral of Ring_Osc is

	signal input : STD_LOGIC := '0';

	signal output1 : STD_LOGIC := '0';
	signal output2 : STD_LOGIC := '0';
	signal output3 : STD_LOGIC := '0';

begin

	-- additional gating
	
	input <= output3 when enable_i = '1' else '0';

	-- 3-inverter ring oscillator
	
	inverter_1 : LUT1
   generic map (
      INIT => "01" ) -- initialize as inverter
   port map (
      O => output1,  -- LUT general output
      I0 => input    -- LUT input
   );
	
	inverter_2 : LUT1
   generic map (
      INIT => "01" ) -- initialize as inverter
   port map (
      O => output2,  -- LUT general output
      I0 => output1  -- LUT input
   );
	
	inverter_3 : LUT1
   generic map (
      INIT => "01" ) -- initialize as inverter
   port map (
      O => output3,  -- LUT general output
      I0 => output2  -- LUT input
   );
	
	Q <= output3;

end Behavioral;

