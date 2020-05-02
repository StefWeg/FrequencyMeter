----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:47:17 12/25/2019 
-- Design Name: 
-- Module Name:    LUT_test - Behavioral 
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

entity LUT_test is

	PORT (
				clk_i : in STD_LOGIC := '0';
				inv_output : out STD_LOGIC := '0';
				xor_i1 : in STD_LOGIC := '0';
				xor_i2 : in STD_LOGIC := '0';
				xor_o : out STD_LOGIC := '0'
		   );

end LUT_test;

architecture Behavioral of LUT_test is

begin
	
	inverter : LUT1
   generic map (
      INIT => "01" ) -- initialize as inverter
   port map (
      O => inv_output,  -- LUT general output
      I0 => clk_i  -- LUT input
   );
	
--      ____________
--     | I1 I0 | O |
--     |-------|---|
--     |  0  0 | 0 |\
--     |  0  1 | 1 | \ = 0110 = INIT
--     |  1  0 | 1 | /  
--     |  1  1 | 0 |/   
--     |-------|---| 

	XOR_gate : LUT2
   generic map (
      INIT => "0110") -- initialize as XOR gate
   port map (
      O => xor_o,   -- LUT general output
      I0 => xor_i1, -- LUT input
      I1 => xor_i2  -- LUT input
   );

end Behavioral;
