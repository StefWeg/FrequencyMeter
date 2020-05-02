--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:48:13 12/25/2019
-- Design Name:   
-- Module Name:   C:/Users/stefa/Documents/ISE_Xilinx/floorplanner/Int2ASCII_tb.vhd
-- Project Name:  floorplanner
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Int2ASCII
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Int2ASCII_tb IS
END Int2ASCII_tb;
 
ARCHITECTURE behavior OF Int2ASCII_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Int2ASCII
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         integer_i : in STD_LOGIC_VECTOR(31 downto 0);
         convEnable : IN  std_logic;
         ASCII_o : out STD_LOGIC_VECTOR(79 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal integer_i : std_logic_vector(31 downto 0) := (others => '0');
   signal convEnable : std_logic := '0';

 	--Outputs
   signal ASCII_o : std_logic_vector(79 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Int2ASCII PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          integer_i => integer_i,
          convEnable => convEnable,
          ASCII_o => ASCII_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process (simulate 0.5 ms)
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst_i <= '1';
      wait for 100 us;	
		rst_i <= '0';

      -- insert stimulus here
		wait for 100 us;
		wait for clk_i_period;
		integer_i <= X"FFFFFFFF"; -- max 4 294 967 295
		wait for clk_i_period;
		convEnable <= '1';
		wait for clk_i_period;
		convEnable <= '0';

      wait;
   end process;

END;
