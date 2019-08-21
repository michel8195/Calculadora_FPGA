LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_op IS
END test_op;
 
ARCHITECTURE behavior OF test_op IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT operaciones
    PORT(
         a : IN  signed(3 downto 0);
         b : IN  signed(3 downto 0);
         eleccion : IN  std_logic_vector(2 downto 0);
			overflow: OUT std_logic_vector(3 downto 0);
         operacion : OUT  signed(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : signed(3 downto 0) := (others => '0');
   signal b : signed(3 downto 0) := (others => '0');
   signal eleccion : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal operacion : signed(4 downto 0);
	signal overflow : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name x
 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: operaciones PORT MAP (
          a => a,
          b => b,
          eleccion => eleccion,
			 overflow => overflow,
          operacion => operacion
        );


   -- Stimulus process
   stim_proc: process
	variable i, j, prod : integer; 
	variable valor: signed(4 downto 0);
	variable test: signed(7 downto 0);
   begin		
      -- hold reset state for 100 ns.
      wait for 1 ns;	
		
		
		-- Testeo suma
		eleccion <= "001" ;
		for i in -7 to 7 loop
			for j in -7 to 7 loop
				a <= to_signed(i, 4);
				b <= to_signed(j, 4);
				valor := to_signed(i+j, 5);
				wait for 1 ns;
				assert (operacion = valor) report "Fallo suma" severity failure;
				assert overflow ="1110" report "fallo no overflow" severity failure;	
			end loop;
		end loop;
		
		-- Testeo resta
		eleccion <= "010" ;
		for i in -7 to 7 loop
			for j in -7 to 7 loop
				a <= to_signed(i, 4);
				b <= to_signed(j, 4);
				valor := to_signed(i-j, 5);
				wait for 1 ns;
				assert (operacion = valor) report "Fallo resta" severity failure;
				assert overflow ="1110" report "fallo no overflow" severity failure;	
			end loop;
		end loop;
		
		-- Testeo multiplicacion
		eleccion <= "100" ; 
		for i in -6 to 7 loop
			for j in -7 to 7 loop
				wait for 1 ns;
				a <= to_signed(i, 4);
				b <= to_signed(j, 4);
				valor := to_signed(i*j, 5);
				test := a*b;
				prod := i*j; 
				--  
				wait for 1 ns;
				assert (operacion = valor) report "Fallo multiplicacion" severity failure;
				
				-- Testeo overflow
				if (prod > 15 or prod < -15) then 
					assert overflow ="0000" report "fallo overflow" 
									& integer'image(prod) & integer'image(i) & integer'image(j) severity failure;
				else
					assert overflow ="1110" report "fallo no overflow" severity failure;	
				end if;
				
			end loop; 
		end loop;
		
		eleccion <= "100";
		a <= "1001";
		b <= "1001";
		wait for 1 ns;
		assert overflow ="0000" report "fallo overflow" severity failure;
		
		eleccion <= "000" ;
		wait for 1 ns;
		assert overflow ="0000" report "fallo eleccion incorrecta" severity failure;
		eleccion <= "011" ;
		wait for 1 ns;
		assert overflow ="0000" report "fallo eleccion incorrecta" severity failure; 		
		eleccion <= "110" ;
		wait for 1 ns;
		assert overflow ="0000" report "fallo eleccion incorrecta" severity failure;
		eleccion <= "101" ;
		wait for 1 ns;
		assert overflow ="0000" report "fallo eleccion incorrecta" severity failure;
		eleccion <= "111" ;
		wait for 1 ns;
		assert overflow ="0000" report "fallo eleccion incorrecta" severity failure;
		

		
		
		assert false report "Funciona" severity failure;

      wait;
   end process;

END;
