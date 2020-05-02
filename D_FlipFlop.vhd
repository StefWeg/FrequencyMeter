----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:04 12/21/2019 
-- Design Name: 
-- Module Name:    D_FlipFlop - Behavioral 
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity D_FlipFlop is

	PORT (
				Q : out STD_LOGIC := '0';
				clk : in STD_LOGIC := '0';
				D : in STD_LOGIC := '0'
			);

end D_FlipFlop;

architecture Behavioral of D_FlipFlop is
begin

	process(clk)
	begin
		if (rising_edge(clk)) then
			Q <= D;
		end if;
	end process;

end Behavioral;
