LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_top IS
END test_top;
 
ARCHITECTURE behavior OF test_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         eleccion : IN  std_logic_vector(2 downto 0);
         led : OUT  std_logic;
         sseg : OUT  std_logic_vector(7 downto 0);
         an : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
 
   --Inputs 
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal eleccion : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal led : std_logic;
   signal sseg : std_logic_vector(7 downto 0);
   signal an : std_logic_vector(3 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          a => a,
          b => b,
          eleccion => eleccion,
          led => led,
          sseg => sseg,
          an => an
        );
 

   -- Stimulus process
   stim_proc: process
	variable i : integer;
	variable j : integer;
	variable res : integer := 0;
	variable resultado : std_logic_vector(4 downto 0);
	variable seg : std_logic_vector(7 downto 0);
   begin		
		wait for 1 ns;
		

		-- SUMA
		
		eleccion <= "001";
		for i in -7 to 7 loop
			for j in -7 to 7 loop 
				if (i > -1) then
					a <= std_logic_vector(to_signed(i, 4));
				else
					a <= std_logic_vector(signed((not std_logic_vector(to_signed(i,4)))) + "1001");
				end if;	
				
				if (j > -1) then
					b <= std_logic_vector(to_signed(j, 4));
				else
					b <= std_logic_vector(signed((not std_logic_vector(to_signed(j,4)))) + "1001");
				end if;
				
				res := i + j;
				
				wait for 1 ns;

				
				-- Primero verifico el overflow
				if (res > 15 or res < -15) then
					assert an = "0000"  report "Fallo overflow 'a'"& integer'image(res) 
											& integer'image(i) & integer'image(j) severity failure;
				else 
					assert an = "1110" report  "Fallo no overflow" severity failure;
				
				-- En caso que no ocurra overflow obtengo el resultado en formato std_logic_vector 
				-- para verificar el led y el sseg. 
					if (res > -1) then
						resultado := std_logic_vector(to_signed(res, 5));
					else
						resultado := std_logic_vector(signed(not std_logic_vector(to_signed(res, 5))) + "10001"); 
					end if; 
					wait for 1 ns;				
					
				-- Verifico el led y magnitud
					assert led = resultado(4) report "Fallo led" severity failure;
				
				-- Verifico salida siete segmentos
					if resultado(3 downto 0) = "0000" then
						seg := not "11111100";
					elsif resultado(3 downto 0) = "0001" then
						seg := not "01100000";
					elsif resultado(3 downto 0) = "0010" then
						seg := not "11011010";
					elsif resultado(3 downto 0) = "0011" then
						seg := not "11110010";
					elsif resultado(3 downto 0) = "0100" then
						seg := not "01100110";
					elsif resultado(3 downto 0) = "0101" then
						seg := not "10110110";
					elsif resultado(3 downto 0) = "0110" then
						seg := not "10111110";
					elsif resultado(3 downto 0) = "0111" then
						seg := not "11100000";
					elsif resultado(3 downto 0) = "1000" then
						seg :=  not "11111110";
					elsif resultado(3 downto 0) = "1001" then
						seg := not "11100110";
					elsif resultado(3 downto 0) = "1010" then
						seg :=  not "11111010";
					elsif resultado(3 downto 0) = "1011" then
						seg := not "00111110";
					elsif resultado(3 downto 0) = "1100" then
						seg := not "00011010";
					elsif resultado(3 downto 0) = "1101" then
						seg :=  not "01111010";
					elsif resultado(3 downto 0) = "1110" then
						seg := not "11011110";
					elsif resultado(3 downto 0) = "1111" then
						seg := not "10001110";
					else
						seg := not "00000000";
					end if;
						
					assert sseg = seg report "Fallo siete segmentos suma" severity failure;
				
				end if; 
			end loop;
		end loop;
		
		-- RESTA
		
		eleccion <= "010";
		for i in -7 to 7 loop
			for j in -7 to 7 loop 
				if (i > -1) then
					a <= std_logic_vector(to_signed(i, 4));
				else
					a <= std_logic_vector(signed((not std_logic_vector(to_signed(i,4)))) + "1001");
				end if;	
				
				if (j > -1) then
					b <= std_logic_vector(to_signed(j, 4));
				else
					b <= std_logic_vector(signed((not std_logic_vector(to_signed(j,4)))) + "1001");
				end if;
				
				res := i - j;
				
				wait for 1 ns;

				
				-- Primero verifico el overflow
				if (res > 15 or res < -15) then
					assert an = "0000"  report "Fallo overflow 'a'"& integer'image(res) 
											& integer'image(i) & integer'image(j) severity failure;
				else 
					assert an = "1110" report  "Fallo no overflow" severity failure;
				
				-- En caso que no ocurra overflow obtengo el resultado en formato std_logic_vector 
				-- para verificar el led y el sseg. 
					if (res > -1) then
						resultado := std_logic_vector(to_signed(res, 5));
					else
						resultado := std_logic_vector(signed(not std_logic_vector(to_signed(res, 5))) + "10001"); 
					end if; 
					wait for 1 ns;				
					
				-- Verifico el led y magnitud
					assert led = resultado(4) report "Fallo led" severity failure;
				
				-- Verifico salida siete segmentos
					if resultado(3 downto 0) = "0000" then
						seg := not "11111100";
					elsif resultado(3 downto 0) = "0001" then
						seg := not "01100000";
					elsif resultado(3 downto 0) = "0010" then
						seg := not "11011010";
					elsif resultado(3 downto 0) = "0011" then
						seg := not "11110010";
					elsif resultado(3 downto 0) = "0100" then
						seg := not "01100110";
					elsif resultado(3 downto 0) = "0101" then
						seg := not "10110110";
					elsif resultado(3 downto 0) = "0110" then
						seg := not "10111110";
					elsif resultado(3 downto 0) = "0111" then
						seg := not "11100000";
					elsif resultado(3 downto 0) = "1000" then
						seg :=  not "11111110";
					elsif resultado(3 downto 0) = "1001" then
						seg := not "11100110";
					elsif resultado(3 downto 0) = "1010" then
						seg :=  not "11111010";
					elsif resultado(3 downto 0) = "1011" then
						seg := not "00111110";
					elsif resultado(3 downto 0) = "1100" then
						seg := not "00011010";
					elsif resultado(3 downto 0) = "1101" then
						seg :=  not "01111010";
					elsif resultado(3 downto 0) = "1110" then
						seg := not "11011110";
					elsif resultado(3 downto 0) = "1111" then
						seg := not "10001110";
					else
						seg := not "00000000";
					end if;
						
					assert sseg = seg report "Fallo siete segmentos resta" severity failure;
				
				end if; 
			end loop;
		end loop;
		
		
		
		eleccion <= "100";
		for i in -6 to 7 loop
			for j in -7 to 7 loop 
				if (i > -1) then
					a <= std_logic_vector(to_signed(i, 4));
				else
					a <= std_logic_vector(signed((not std_logic_vector(to_signed(i,4)))) + "1001");
				end if;	
				
				if (j > -1) then
					b <= std_logic_vector(to_signed(j, 4));
				else
					b <= std_logic_vector(signed((not std_logic_vector(to_signed(j,4)))) + "1001");
				end if;
				
				res := i * j;
				
				wait for 1 ns;
				
				-- Primero verifico el overflow
				if (res > 15 or res < -15) then
					assert an = "0000"  report "Fallo overflow 'a'"& integer'image(res) 
											& integer'image(i) & integer'image(j) severity failure;
				else 
					assert an = "1110" report  "Fallo no overflow" severity failure;
				
				-- En caso que no ocurra overflow obtengo el resultado en formato std_logic_vector 
				-- para verificar el led y el sseg. 
					if (res > -1) then
						resultado := std_logic_vector(to_signed(res, 5));
					else
						resultado := std_logic_vector(signed(not std_logic_vector(to_signed(res, 5))) + "10001"); 
					end if; 
					wait for 1 ns;				
					
				-- Verifico el led y magnitud
					assert led = resultado(4) report "Fallo led" severity failure;
				
				-- Verifico salida siete segmentos
					if resultado(3 downto 0) = "0000" then
						seg := not "11111100";
					elsif resultado(3 downto 0) = "0001" then
						seg := not "01100000";
					elsif resultado(3 downto 0) = "0010" then
						seg := not "11011010";
					elsif resultado(3 downto 0) = "0011" then
						seg := not "11110010";
					elsif resultado(3 downto 0) = "0100" then
						seg := not "01100110";
					elsif resultado(3 downto 0) = "0101" then
						seg := not "10110110";
					elsif resultado(3 downto 0) = "0110" then
						seg := not "10111110";
					elsif resultado(3 downto 0) = "0111" then
						seg := not "11100000";
					elsif resultado(3 downto 0) = "1000" then
						seg :=  not "11111110";
					elsif resultado(3 downto 0) = "1001" then
						seg := not "11100110";
					elsif resultado(3 downto 0) = "1010" then
						seg :=  not "11111010";
					elsif resultado(3 downto 0) = "1011" then
						seg := not "00111110";
					elsif resultado(3 downto 0) = "1100" then
						seg := not "00011010";
					elsif resultado(3 downto 0) = "1101" then
						seg :=  not "01111010";
					elsif resultado(3 downto 0) = "1110" then
						seg := not "11011110";
					elsif resultado(3 downto 0) = "1111" then
						seg := not "10001110";
					else
						seg := not "00000000";
					end if;
						
					assert sseg = seg report "Fallo siete segmentos" severity failure;
				
				end if; 
			end loop;
		end loop;
		
		-- Verifico el caso -7 -7 para la multiplicacion
		eleccion <= "100";
		a <= "1111";
		b <= "1111";
		wait for 1 ns;
		assert an ="0000" report "fallo overflow" severity failure;
		
		-- Verifico todas las combinaciones de los plusadores que no fueron consideradas
		eleccion <= "000" ;
		wait for 1 ns;
		assert an ="0000" report "fallo eleccion incorrecta" severity failure;
		eleccion <= "011" ;
		wait for 1 ns;
		assert an ="0000" report "fallo eleccion incorrecta" severity failure; 		
		eleccion <= "110" ;
		wait for 1 ns;
		assert an ="0000" report "fallo eleccion incorrecta" severity failure;
		eleccion <= "101" ;
		wait for 1 ns;
		assert an ="0000" report "fallo eleccion incorrecta" severity failure;
		eleccion <= "111" ;
		wait for 1 ns;
		assert an ="0000" report "fallo eleccion incorrecta" severity failure;
		
		assert false report "Funciona" severity failure;
		
      wait;
   end process;

END;
