--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:13:41 12/25/2019
-- Design Name:   
-- Module Name:   C:/Users/stefa/Documents/ISE_Xilinx/floorplanner/top_tb.vhd
-- Project Name:  floorplanner
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         TXD_o : OUT  std_logic;
         RXD_i : IN  std_logic;
         sw_i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal RXD_i : std_logic := '0';
   signal sw_i : std_logic := '0';

 	--Outputs
   signal TXD_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          TXD_o => TXD_o,
          RXD_i => RXD_i,
          sw_i => sw_i
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process (simulate 1.1 s)
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		sw_i <= '1';
		rst_i <= '1';
      wait for 100 ns;	
		rst_i <= '0';

      wait for clk_i_period*10;
		
		-- trun on TRNG for a moment
		wait for 100 ms;
		sw_i <= '0';
		wait for 100 ms;
		sw_i <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
