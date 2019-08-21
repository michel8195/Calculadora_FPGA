library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity conv_compa2 is
	port( 
		sym : in std_logic_vector(3 downto 0);
		ca2: out signed(3 downto 0)
	);
end conv_compa2;

architecture Behavioral of conv_compa2 is
	signal sum_pos: signed(3 downto 0);
	signal sum_neg: signed(3 downto 0);
begin
	-- sum_pos <= signed('0' & sym(2 downto 0));
	sum_neg <= signed(not ('0' & sym(2 downto 0))) + "0001";
	with sym(3) select
      ca2 <= signed(sym) when '0',
                 sum_neg when '1',
             "0000" when others;
end Behavioral; 

