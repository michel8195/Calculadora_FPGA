
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ca2_sym is
	port( 
		ca2 : in signed(4 downto 0);
		sym : out std_logic_vector(4 downto 0)
	);
end ca2_sym;


architecture Behavioral of ca2_sym is
	signal neg: signed(4 downto 0);
begin
	-- sum_pos <= signed('0' & sym(2 downto 0));
	neg <= signed((not std_logic_vector(ca2))) + "10001" ;
	with ca2(4) select
      sym <=    std_logic_vector(ca2) when '0',
					std_logic_vector(neg) when '1',
					"00000" when others;
end Behavioral; 
