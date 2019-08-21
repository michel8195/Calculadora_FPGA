library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sseg is
	port( 
			num : in std_logic_vector(3 downto 0);
			seg : out std_logic_vector(7 downto 0)
			
	);
end sseg;


architecture Behavioral of sseg is
begin
	with num select
		seg <= not "11111100" when "0000",
             not "01100000" when "0001" ,
				 not "11011010" when "0010" ,
             not "11110010" when "0011" ,
				 not "01100110" when "0100" ,
             not "10110110" when "0101" ,
				 not "10111110" when "0110" ,
             not "11100000" when "0111" ,
				 not "11111110" when "1000" ,
             not "11100110" when "1001" ,
				 not "11111010" when "1010" ,
             not "00111110" when "1011" ,
				 not "00011010" when "1100" ,
             not "01111010" when "1101" ,
				 not "11011110" when "1110" ,
             not "10001110" when "1111" ,
             not "00000000" when others;
end Behavioral; 