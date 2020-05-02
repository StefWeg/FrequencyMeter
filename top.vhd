----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:28:36 12/21/2019 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is

PORT (
		clk_i : in STD_LOGIC;
		rst_i : in STD_LOGIC;
		TXD_o : out STD_LOGIC;
		RXD_i : in STD_LOGIC;
		sw_i : in STD_LOGIC
		);
	
end top;

architecture Behavioral of top is

	component transmitter is
		Port (
		clk_i : in STD_LOGIC;
		rst_i : in STD_LOGIC;
		data_i : in STD_LOGIC_VECTOR(7 downto 0);
		RO_xor_i : in STD_LOGIC;
		sw_i : in STD_LOGIC;
		TXD_enable_i : in  STD_LOGIC; -- transmission activation
		TXD_is_ongoing_o : out STD_LOGIC;
		TXD_o : out STD_LOGIC );
	end component;
	
	component Freq_Meter is
		Port (
		clk_i : in STD_LOGIC;
		input : in STD_LOGIC;
		rst_counter : in STD_LOGIC;
		counter : out STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
	component Ring_Osc is
		Port (
		enable_i : in STD_LOGIC;
		Q : out STD_LOGIC);
	end component;
	
	component Int2ASCII is
		Port (
		clk_i : in STD_LOGIC;
		rst_i : in STD_LOGIC;
		integer_i : in STD_LOGIC_VECTOR(31 downto 0);  -- 32-bit unsigned integer
		convEnable : in STD_LOGIC;
		ASCII_o : out STD_LOGIC_VECTOR(79 downto 0)); -- max 4 294 967 295 (10 digits = 80 bits)
	end component;
	
	component D_FlipFlop
		port (
		Q : out STD_LOGIC;
		clk : in STD_LOGIC;
		D : in STD_LOGIC);
	end component;
		
	-- TXD signals
	signal TXD_enable : std_logic := '0';
	signal TXD_ongoing : std_logic := '0';
	signal t_data_TXD : STD_LOGIC_VECTOR(7 downto 0) := X"FF";
	type t_state is (standby, transmitMeas);
	signal TXD_state : t_state := standby;
	signal TXD_next_state : t_state := standby;
	
	-- Frequency meters' signals
	signal FREQ1_rstCnt : STD_LOGIC := '0';
	signal FREQ2_rstCnt : STD_LOGIC := '0';
	signal FREQ1_counter : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	signal FREQ2_counter : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	
	-- ROs' signals
	signal RO_enable : STD_LOGIC := '0';
	signal RO1_output : STD_LOGIC := '0';
	signal RO2_output : STD_LOGIC := '0';
	signal RO_xor : STD_LOGIC := '0';  -- XOR gate output
	signal TRNG : STD_LOGIC := '0';    -- 50 MHz sampled XOR gate output (TRNG)
	
	-- Int2ASCII singals
	signal CONV_frequency1 : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";  -- 32-bit unsigned integer
	signal CONV_frequency2 : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";  -- 32-bit unsigned integer
	signal CONV_enable : STD_LOGIC;
	signal ASCII_dec_string1 : STD_LOGIC_VECTOR(79 downto 0); -- max 4 294 967 295 (10 digits = 80 bits)
	signal ASCII_dec_string2 : STD_LOGIC_VECTOR(79 downto 0); -- max 4 294 967 295 (10 digits = 80 bits)

begin

	TXD : transmitter port map (
		clk_i => clk_i,
		rst_i => rst_i,
		data_i => t_data_TXD,
		RO_xor_i => TRNG,
		sw_i => sw_i,
		TXD_enable_i => TXD_enable,
		TXD_is_ongoing_o => TXD_ongoing,
		TXD_o => TXD_o);

	FREQ1 : Freq_Meter port map (
		clk_i => clk_i,
		input => RO1_output,
		rst_counter => FREQ1_rstCnt,
		counter => FREQ1_counter);
		
	FREQ2 : Freq_Meter port map (
		clk_i => clk_i,
		input => RO2_output,
		rst_counter => FREQ2_rstCnt,
		counter => FREQ2_counter);

	RO1 : Ring_Osc port map (
		enable_i => RO_enable,
		Q => RO1_output);
	
	RO2 : Ring_Osc port map (
		enable_i => RO_enable,
		Q => RO2_output);
		
	CONV1 : Int2ASCII port map (
		clk_i => clk_i,
		rst_i => rst_i,
		integer_i => CONV_frequency1,
		convEnable => CONV_enable,
		ASCII_o => ASCII_dec_string1);
		
	CONV2 : Int2ASCII port map (
		clk_i => clk_i,
		rst_i => rst_i,
		integer_i => CONV_frequency2,
		convEnable => CONV_enable,
		ASCII_o => ASCII_dec_string2);
		
	XOR_gate : LUT2
		generic map (
      INIT => "0110")     -- initialize as XOR gate
		port map (
      O => RO_xor,        -- LUT general output
      I0 => RO1_output,   -- LUT input
      I1 => RO2_output);  -- LUT input
   
	XOR_RO : D_FlipFlop port map (
		Q => TRNG,
		clk => clk_i,
		D => RO_xor);
	
	process (rst_i, clk_i) is
		
		variable Hz_counter : Integer := 0;
		variable kHz_counter : Integer := 0;
		
		variable charIdx : Integer := 0;
		constant CHAR_IN_MSG : Integer := 40;
	
	begin
		
		if rst_i = '1' then
			TXD_state <= standby;
			TXD_next_state <= standby;
			charIdx := 0;
			kHz_counter := 0;
			Hz_counter := 0;

		elsif rising_edge(clk_i) then
		
			RO_enable <= '1'; -- enable ROs during program execution
		
			TXD_state <= TXD_next_state;
		
			kHz_counter := kHz_counter + 1;
			Hz_counter := Hz_counter + 1;
			
			CONV_enable <= '0';
			TXD_enable <= '0';
			
			FREQ1_rstCnt <= '0';
			FREQ2_rstCnt <= '0';
			
			if kHz_counter = 50000 then  -- 50 MHz / 50 000 = 1 kHz

				kHz_counter := 0;
				
				CONV_frequency1(3 downto 0) <= X"0";
				CONV_frequency2(3 downto 0) <= X"0";
				CONV_frequency1(31 downto 4) <= FREQ1_counter(27 downto 0); -- capture frequency measurements
				CONV_frequency2(31 downto 4) <= FREQ2_counter(27 downto 0); -- 8-bit shift (multiply by 2^4 = 16)
				
				FREQ1_rstCnt <= '1'; -- reset frequency counters
				FREQ2_rstCnt <= '1';
				
			end if;
			
			if Hz_counter = 50000000 then  -- 50 MHz / 50 000 000 = 1 Hz

				Hz_counter := 0;
				
				CONV_enable <= '1'; -- perform conversion of measurements
				
				if sw_i = '1' then
					TXD_next_state <= transmitMeas; -- trigger transmission of measurement results
					charIdx := 0;
				end if;
				
			end if;
			
			if TXD_state = transmitMeas then
			
				if charIdx < CHAR_IN_MSG then
				
					if TXD_ongoing = '0' and TXD_enable = '0' then
				
						case charIdx is
						
							when 0  => t_data_TXD <= X"52"; -- R
							when 1  => t_data_TXD <= X"4F"; -- O
							when 2  => t_data_TXD <= X"31"; -- 1
							when 3  => t_data_TXD <= X"3D"; -- =
							
							when 4  => t_data_TXD <= ASCII_dec_string1(79 downto 72);
							when 5  => t_data_TXD <= ASCII_dec_string1(71 downto 64);
							when 6  => t_data_TXD <= ASCII_dec_string1(63 downto 56);
							when 7  => t_data_TXD <= ASCII_dec_string1(55 downto 48);
							when 8  => t_data_TXD <= ASCII_dec_string1(47 downto 40);
							when 9  => t_data_TXD <= ASCII_dec_string1(39 downto 32);
							when 10 => t_data_TXD <= ASCII_dec_string1(31 downto 24);
							when 11 => t_data_TXD <= ASCII_dec_string1(23 downto 16);
							when 12 => t_data_TXD <= ASCII_dec_string1(15 downto 8);
							when 13 => t_data_TXD <= ASCII_dec_string1(7 downto 0);
							
							when 14 => t_data_TXD <= X"20"; -- Space
							when 15 => t_data_TXD <= X"6B"; -- k
							when 16 => t_data_TXD <= X"48"; -- H
							when 17 => t_data_TXD <= X"7A"; -- z
							when 18 => t_data_TXD <= X"0A"; -- \LF
							when 19 => t_data_TXD <= X"0D"; -- \CR
							
							when 20 => t_data_TXD <= X"52"; -- R
							when 21 => t_data_TXD <= X"4F"; -- O
							when 22 => t_data_TXD <= X"32"; -- 2
							when 23 => t_data_TXD <= X"3D"; -- =
							
							when 24 => t_data_TXD <= ASCII_dec_string2(79 downto 72);
							when 25 => t_data_TXD <= ASCII_dec_string2(71 downto 64);
							when 26 => t_data_TXD <= ASCII_dec_string2(63 downto 56);
							when 27 => t_data_TXD <= ASCII_dec_string2(55 downto 48);
							when 28 => t_data_TXD <= ASCII_dec_string2(47 downto 40);
							when 29 => t_data_TXD <= ASCII_dec_string2(39 downto 32);
							when 30 => t_data_TXD <= ASCII_dec_string2(31 downto 24);
							when 31 => t_data_TXD <= ASCII_dec_string2(23 downto 16);
							when 32 => t_data_TXD <= ASCII_dec_string2(15 downto 8);
							when 33 => t_data_TXD <= ASCII_dec_string2(7 downto 0);
							
							when 34 => t_data_TXD <= X"20"; -- Space
							when 35 => t_data_TXD <= X"6B"; -- k
							when 36 => t_data_TXD <= X"48"; -- H
							when 37 => t_data_TXD <= X"7A"; -- z
							when 38 => t_data_TXD <= X"0A"; -- \LF
							when 39 => t_data_TXD <= X"0D"; -- \CR
							
							when others => null;
						end case;
					
						charIdx := charIdx + 1;
						TXD_enable <= '1';
						
					end if;
				
				else
					TXD_next_state <= standby;
				end if;
				
			end if;
		
		end if;

	end process;
	
	

end Behavioral;

