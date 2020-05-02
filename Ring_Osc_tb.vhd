--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:09:41 12/25/2019
-- Design Name:   
-- Module Name:   C:/Users/stefa/Documents/ISE_Xilinx/floorplanner/Ring_Osc_tb.vhd
-- Project Name:  floorplanner
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Ring_Osc
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
 
ENTITY Ring_Osc_tb IS
END Ring_Osc_tb;
 
ARCHITECTURE behavior OF Ring_Osc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Ring_Osc
    PORT(
         enable_i : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal enable_i : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal clk_i : std_logic;
 
   constant clk_i_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Ring_Osc PORT MAP (
          enable_i => enable_i,
          Q => Q
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		enable_i <= '0';
      wait for 100 ns;	
		enable_i <= '1';
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
