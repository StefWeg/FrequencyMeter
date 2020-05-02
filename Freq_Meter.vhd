----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:19:28 12/21/2019 
-- Design Name: 
-- Module Name:    Freq_Meter - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.All;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Freq_Meter is

	PORT (
				clk_i : in STD_LOGIC;
				input : in STD_LOGIC;
				rst_counter : in STD_LOGIC;
				counter : out STD_LOGIC_VECTOR(31 downto 0)
			);

end Freq_Meter;

architecture Behavioral of Freq_Meter is

	component D_FlipFlop
		port (
		Q : out STD_LOGIC;
		clk : in STD_LOGIC;
		D : in STD_LOGIC);
	end component;
	
	-- 4-stage ripple counter (prescaler 1/16)
	signal RC_Q1 : STD_LOGIC := '0';
	signal RC_Q2 : STD_LOGIC := '0';
	signal RC_Q3 : STD_LOGIC := '0';
	signal RC_Q4 : STD_LOGIC := '0';
	
	signal RC_D1 : STD_LOGIC := '0';
	signal RC_D2 : STD_LOGIC := '0';
	signal RC_D3 : STD_LOGIC := '0';
	signal RC_D4 : STD_LOGIC := '0';
	
	-- double FF signal synchronizer
	signal SS_Q1 : STD_LOGIC := '0';
	signal SS_Q2 : STD_LOGIC := '0';
	
	-- synchronous frequency counter
	signal counter_input : STD_LOGIC := '0';
	signal last_counter_input : STD_LOGIC := '0';
	SHARED variable value : Integer := 0;

begin

	-- 4-stage ripple counter (prescaler 1/16)
	RC_D1 <= not RC_Q1;
	RC_DFF_1 : D_FlipFlop port map (
		Q => RC_Q1,
		clk => input,
		D => RC_D1);
	
	RC_D2 <= not RC_Q2;
	RC_DFF_2 : D_FlipFlop port map (
		Q => RC_Q2,
		clk => RC_D1,
		D => RC_D2);
	
	RC_D3 <= not RC_Q3;
	RC_DFF_3 : D_FlipFlop port map (
		Q => RC_Q3,
		clk => RC_D2,
		D => RC_D3);
	
	RC_D4 <= not RC_Q4;
	RC_DFF_4 : D_FlipFlop port map (
		Q => RC_Q4,
		clk => RC_D3,
		D => RC_D4);

	-- double FF signal synchronizer
	SS_DFF_1 : D_FlipFlop port map (
		Q => SS_Q1,
		clk => clk_i,
		D => RC_D4);
		
	SS_DFF_2 : D_FlipFlop port map (
		Q => SS_Q2,
		clk => clk_i,
		D => SS_Q1);

	-- synchronous frequency counter
	counter_input <= SS_Q2;
	
	process (clk_i, rst_counter)
	begin
	
		if rst_counter = '1' then
			value := 0;
			counter <= X"00000000";
			last_counter_input <= counter_input;
			
		elsif rising_edge(clk_i) then
			if (counter_input = not last_counter_input) and counter_input = '1' then -- detecting rising edge
				value := value + 1;
			end if;
			last_counter_input <= counter_input;
			counter <= CONV_STD_LOGIC_VECTOR(value, 32);
			
		end if;
		
	end process;

end Behavioral;

