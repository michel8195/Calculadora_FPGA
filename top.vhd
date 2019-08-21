library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
	port( a, b : in std_logic_vector(3 downto 0);
			eleccion: in std_logic_vector(2 downto 0);
			led: out std_logic;
			sseg: out std_logic_vector(7 downto 0);
			an: out std_logic_vector(3 downto 0)
	);
end top;



architecture Behavioral of top is
signal con_a, con_b : signed(3 downto 0);
signal con_op : signed(4 downto 0);
signal con_sseg : std_logic_vector(4 downto 0);

begin
	-- Instanciamos dos conversores de signo y magnitud a complemento a 2
		conv_sym_ca2_a: entity work.conv_compa2(Behavioral)
			port map(sym => a, 
						ca2 => con_a
			);
		conv_sym_ca2_b: entity work.conv_compa2(Behavioral)
			port map(sym => b,
						ca2 => con_b
			);
	
	-- Instanciamos el operador
		operador: entity work.operaciones(op)
			port map(a => con_a,
						b => con_b,
						eleccion => eleccion,
						overflow => an,
						operacion => con_op
			);
	
	-- Instanciamos el conversor de complemento a 2 a signo y magnitud
		conv_ca2_sym: entity work.ca2_sym(Behavioral)
			port map(ca2 => con_op,
						sym => con_sseg
			);
	
	-- Instanciamos el siete segmentos 
		siete_seg: entity work.sseg(Behavioral)
			port map(num => con_sseg(3 downto 0),
						seg => sseg
			);
		led <= con_sseg(4);
end Behavioral;

