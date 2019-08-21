--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:58:27 08/18/2019
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Calculadora/test_operaciones.vhd
-- Project Name:  Calculadora
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: operaciones
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_operaciones IS
END test_operaciones;
 
ARCHITECTURE behavior OF test_operaciones IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT operaciones
    PORT(
         a : IN  signed(3 downto 0);
         b : IN  signed(3 downto 0);
         eleccion : IN  std_logic_vector(2 downto 0);
         overflow : OUT  std_logic_vector(3 downto 0);
         operacion : OUT  signed(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : signed(3 downto 0) := (others => '0');
   signal b : signed(3 downto 0) := (others => '0');
   signal eleccion : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal overflow : std_logic_vector(3 downto 0);
   signal operacion : signed(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
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
   begin		
      -- hold reset state for 100 ns.
      wait for 1 ns;	
		

      -- insert stimulus here 
	stim_proc: process
	variable i, j, prod : integer; 
	variable valor: signed(4 downto 0);
   begin		
      wait for 1 ns;	
		
		-- Testeo la suma
		eleccion <= "001" ;
		for i in -7 to 7 loop
			for j in -7 to 7 loop
				a <= to_signed(i, 4);
				b <= to_signed(j, 4);
				valor := to_signed(i+j, 5);
				wait for 1 ns;
				assert (operacion = valor) report "Fallo suma" severity failure;
			end loop;
		end loop;
		
		-- Testeo la resta
		
		eleccion <= "010" ;
		for i in -7 to 7 loop
			for j in -7 to 7 loop
				a <= to_signed(i, 4);
				b <= to_signed(j, 4);
				valor := to_signed(i-j, 5);
				wait for 1 ns;
				assert (operacion = valor) report "Fallo resta" severity failure;
			end loop;
		end loop;
		
      wait;
   end process;

END;
