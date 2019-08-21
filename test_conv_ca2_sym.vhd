LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_conv_ca2_sym IS
END test_conv_ca2_sym;
 
ARCHITECTURE behavior OF test_conv_ca2_sym IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ca2_sym
    PORT(
         ca2 : IN  signed(4 downto 0);
         sym : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ca2 : signed(4 downto 0) := (others => '0');

 	--Outputs
   signal sym : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ca2_sym PORT MAP (
          ca2 => ca2,
          sym => sym
        );


   -- Stimulus process
   stim_proc: process
	variable i : integer;
	variable valor : std_logic_vector(4 downto 0):="00000";
   begin		
      -- hold reset state for 100 ns.
      wait for 1 ns;	
		
      -- insert stimulus here  
		-- negative plus zero
		for i in -7 to -1 loop 
			ca2 <= to_signed(i, 5);
			valor := '1' & std_logic_vector(to_signed(-i, 4));
			wait for 1 ns;
			assert sym = valor report "fallo negativo" severity failure;
		end loop;
		
		-- positive plus zero
		for i in 0 to 7 loop 
			ca2 <= to_signed(i, 5);
			valor := std_logic_vector(to_signed(i, 5));
			wait for 1 ns;
			assert sym = valor report "fallo positivo" severity failure;
		end loop;
		assert false report "Funciona" severity failure;
      wait;
	end process;

END;
