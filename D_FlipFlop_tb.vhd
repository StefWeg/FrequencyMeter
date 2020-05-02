--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:51:57 12/25/2019
-- Design Name:   
-- Module Name:   C:/Users/stefa/Documents/ISE_Xilinx/floorplanner/D_FlipFlop_tb.vhd
-- Project Name:  floorplanner
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: D_FlipFlop
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
 
ENTITY D_FlipFlop_tb IS
END D_FlipFlop_tb;
 
ARCHITECTURE behavior OF D_FlipFlop_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT D_FlipFlop
    PORT(
         Q : OUT  std_logic;
         clk : IN  std_logic;
         D : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal D : std_logic := '0';

 	--Outputs
   signal Q : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: D_FlipFlop PORT MAP (
          Q => Q,
          clk => clk,
          D => D
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process (simulate 200 us)
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		D <= '1';
		wait for 90 us;
		D <= '0';
		wait for 75 us;
		D <= '1';

      wait;
   end process;

END;
