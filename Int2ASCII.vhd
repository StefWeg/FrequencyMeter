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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Int2ASCII is

PORT (
		clk_i : in STD_LOGIC;
		rst_i : in STD_LOGIC;
		integer_i : in STD_LOGIC_VECTOR(31 downto 0) := X"00000000";  -- 32-bit unsigned integer
		convEnable : in STD_LOGIC;
		ASCII_o : out STD_LOGIC_VECTOR(79 downto 0) := X"00000000000000000000" -- max 4 294 967 295 (10 digits = 80 bits)
		);
	
end Int2ASCII;

architecture Behavioral of Int2ASCII is
	
	function to_bcd ( bin : STD_LOGIC_VECTOR ) return STD_LOGIC_VECTOR is
	
        variable i : integer:=0;
        variable bcd : STD_LOGIC_VECTOR(39 downto 0) := (others => '0');
        variable bint : STD_LOGIC_VECTOR(31 downto 0) := bin;

       begin
       for i in 0 to 31 loop  -- repeating 32 times.
		 
        bcd(39 downto 1) := bcd(38 downto 0);  --shifting the bits.
        bcd(0) := bint(31);
        bint(31 downto 1) := bint(30 downto 0);
        bint(0) := '0';

        if(i < 31 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
        bcd(3 downto 0) := bcd(3 downto 0) + "0011";
        end if;

        if(i < 31 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
        bcd(7 downto 4) := bcd(7 downto 4) + "0011";
        end if;

        if(i < 31 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(11 downto 8) := bcd(11 downto 8) + "0011";
        end if;
		  
		  if(i < 31 and bcd(15 downto 12) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(15 downto 12) := bcd(15 downto 12) + "0011";
        end if;
		  
		  if(i < 31 and bcd(19 downto 16) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(19 downto 16) := bcd(19 downto 16) + "0011";
        end if;
		  
		  if(i < 31 and bcd(23 downto 20) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(23 downto 20) := bcd(23 downto 20) + "0011";
        end if;
		  
		  if(i < 31 and bcd(27 downto 24) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(27 downto 24) := bcd(27 downto 24) + "0011";
        end if;
		  
		  if(i < 31 and bcd(31 downto 28) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(31 downto 28) := bcd(31 downto 28) + "0011";
        end if;
		  
		  if(i < 31 and bcd(35 downto 32) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(35 downto 32) := bcd(35 downto 32) + "0011";
        end if;
		  
		  if(i < 31 and bcd(39 downto 36) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(39 downto 36) := bcd(39 downto 36) + "0011";
        end if;

		end loop;
		
		return bcd;
		
   end to_bcd;
	
	function to_ASCII ( bcd_digit : STD_LOGIC_VECTOR(3 downto 0) ) return STD_LOGIC_VECTOR is
	
      constant d0 : STD_LOGIC_VECTOR (7 downto 0) := "00110000"; -- \\
		constant d1 : STD_LOGIC_VECTOR (7 downto 0) := "00110001"; -- ||
		constant d2 : STD_LOGIC_VECTOR (7 downto 0) := "00110010"; -- ||
		constant d3 : STD_LOGIC_VECTOR (7 downto 0) := "00110011"; -- ||
		constant d4 : STD_LOGIC_VECTOR (7 downto 0) := "00110100"; -- \\
		constant d5 : STD_LOGIC_VECTOR (7 downto 0) := "00110101"; --  >> Constant ASCII-binary value of digits 0 to 9
		constant d6 : STD_LOGIC_VECTOR (7 downto 0) := "00110110"; -- //
		constant d7 : STD_LOGIC_VECTOR (7 downto 0) := "00110111"; -- ||
		constant d8 : STD_LOGIC_VECTOR (7 downto 0) := "00111000"; -- ||
		constant d9 : STD_LOGIC_VECTOR (7 downto 0) := "00111001"; -- //

		variable ASCII : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

      begin
		
		case bcd_digit(3 downto 0) is
			when "0000" => ASCII := d0;
			when "0001" => ASCII := d1;
			when "0010" => ASCII := d2;
			when "0011" => ASCII := d3;
			when "0100" => ASCII := d4;
			when "0101" => ASCII := d5;
			when "0110" => ASCII := d6;
			when "0111" => ASCII := d7;
			when "1000" => ASCII := d8;
			when "1001" => ASCII := d9;
			when others => null;
		end case;
		
		return ASCII;
		
   end to_ASCII;
	
	
	type t_state is (idle, convert);
	signal convState : t_state := idle;

begin
	
	process (rst_i, clk_i) is
	
		variable BCD_ARRAY : STD_LOGIC_VECTOR(39 downto 0) := X"0000000000"; -- (10 digits = 40 bits)
	
	begin
	
		if rst_i = '1' then
			convState <= idle;
			BCD_ARRAY := X"0000000000";

		elsif rising_edge(clk_i) then
	
			case convState is
			
				when idle =>
					if convEnable = '1' then
						convState <= convert;
					end if;
				
				when convert =>
					----- Convert X to BCD -----
					BCD_ARRAY := to_bcd(integer_i);
					---- Convert X to ASCII --------
					ASCII_o(7 downto 0) <= to_ASCII(BCD_ARRAY(3 downto 0));
					ASCII_o(15 downto 8) <= to_ASCII(BCD_ARRAY(7 downto 4));
					ASCII_o(23 downto 16) <= to_ASCII(BCD_ARRAY(11 downto 8));
					ASCII_o(31 downto 24) <= to_ASCII(BCD_ARRAY(15 downto 12));
					ASCII_o(39 downto 32) <= to_ASCII(BCD_ARRAY(19 downto 16));
					ASCII_o(47 downto 40) <= to_ASCII(BCD_ARRAY(23 downto 20));
					ASCII_o(55 downto 48) <= to_ASCII(BCD_ARRAY(27 downto 24));
					ASCII_o(63 downto 56) <= to_ASCII(BCD_ARRAY(31 downto 28));
					ASCII_o(71 downto 64) <= to_ASCII(BCD_ARRAY(35 downto 32));
					ASCII_o(79 downto 72) <= to_ASCII(BCD_ARRAY(39 downto 36));
					convState <= idle;
				
			end case;

			 
		end if;
		
	end process;

end Behavioral;

