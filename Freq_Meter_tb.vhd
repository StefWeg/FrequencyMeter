--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:11:30 12/22/2019
-- Design Name:   
-- Module Name:   C:/Users/stefa/Documents/ISE_Xilinx/floorplanner/Freq_Meter_tb.vhd
-- Project Name:  floorplanner
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Freq_Meter
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
 
ENTITY Freq_Meter_tb IS
END Freq_Meter_tb;
 
ARCHITECTURE behavior OF Freq_Meter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Freq_Meter
    PORT(
         clk_i : IN  std_logic;
         input : IN  std_logic;
         rst_counter : IN  std_logic;
         counter : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal input : std_logic := '0';
   signal rst_counter : std_logic := '0';

 	--Outputs
   signal counter : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Freq_Meter PORT MAP (
          clk_i => clk_i,
          input => input,
          rst_counter => rst_counter,
          counter => counter
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process (simulate 100 us)
   stim_proc: process
   begin	
	
		rst_counter <= '1';
		wait for 2 us;
		rst_counter <= '0';
	
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;
		input <= '1';
      wait for 1 us;
		input <= '0';
		wait for 1 us;

      wait;
   end process;

END;
