--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:49:56 12/25/2019
-- Design Name:   
-- Module Name:   C:/Users/stefa/Documents/ISE_Xilinx/floorplanner/LUT_test_tb.vhd
-- Project Name:  floorplanner
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LUT_test
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
 
ENTITY LUT_test_tb IS
END LUT_test_tb;
 
ARCHITECTURE behavior OF LUT_test_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LUT_test
    PORT(
				clk_i : in STD_LOGIC := '0';
				inv_output : out STD_LOGIC := '0';
				xor_i1 : in STD_LOGIC := '0';
				xor_i2 : in STD_LOGIC := '0';
				xor_o : out STD_LOGIC := '0'
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
	signal xor_i1 : std_logic := '0';
	signal xor_i2 : std_logic := '0';

 	--Outputs
   signal inv_output : std_logic;
	signal xor_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LUT_test PORT MAP (
          clk_i => clk_i,
          inv_output => inv_output,
			 xor_i1 => xor_i1,
			 xor_i2 => xor_i2,
			 xor_o => xor_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process (simulate 1 us)
   stim_proc: process
   begin		

      wait for clk_i_period*10;

      -- insert stimulus here 
		wait for clk_i_period*10;
		xor_i1 <= '1';
		xor_i2 <= '1';
		wait for clk_i_period*10;
		xor_i1 <= '0';
		xor_i2 <= '1';
		wait for clk_i_period*10;
		xor_i1 <= '1';
		xor_i2 <= '0';
		wait for clk_i_period*10;
		xor_i1 <= '0';
		xor_i2 <= '0';

      wait;
   end process;

END;
