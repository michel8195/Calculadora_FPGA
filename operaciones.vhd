library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity operaciones is
	port(
		a, b: in signed(3 downto 0);
 		eleccion: in std_logic_vector(2 downto 0);
		overflow: out std_logic_vector(3 downto 0);
		operacion: out signed(4 downto 0)
	);
end operaciones;

architecture op of operaciones is
signal suma, resta : signed(4 downto 0);
signal multi : signed(7 downto 0);
begin
	suma <= signed(a(3)  & std_logic_vector(a)) + signed(b(3)  & std_logic_vector(b));
	resta <= signed(a(3)  & std_logic_vector(a)) - signed(b(3)  & std_logic_vector(b));
	multi <= a * b;
	
-- checkeamos si hay overflow o no
	process(multi)
	begin
	-- Si presiono mas de un pulsador simultaneamente -> senial de error
		if (eleccion /= "100" and eleccion /= "010" and eleccion /= "001") then
			overflow <= "0000";
		elsif (eleccion = "100") then
			if (multi > "00001111") then
				overflow <= "0000";
			elsif (multi < "11110001") then
				overflow <= "0000";
			else
				overflow <= "1110";
			end if;
		else
			overflow <= "1110";
		end if;
	end process;
	
	with eleccion select
		operacion <= suma when "001",
						 resta when "010" ,
						 multi(4 downto 0) when "100" ,
						 "00000" when others;
end op;
