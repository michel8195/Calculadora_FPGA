--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:55:34 08/14/2019
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Calculadora/test_conv_compa2.vhd
-- Project Name:  Calculadora
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: conv_compa2
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
USE ieee.numeric_std.ALL;
 
ENTITY test_conv_compa2 IS
END test_conv_compa2;
 
ARCHITECTURE behavior OF test_conv_compa2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT conv_compa2
    PORT(
         sym : IN  std_logic_vector(3 downto 0);
         ca2 : OUT  signed(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sym : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ca2 : signed(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriat e port name 
 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: conv_compa2 PORT MAP (
          sym => sym,
          ca2 => ca2
        );


   -- Stimulus process
   stim_proc: process
	variable i : integer;
	variable neg: signed(3 downto 0);
   begin		
      -- hold reset state for 100 ns.
      wait for 1 ns;	
		
		-- Loop para checkear positivos y 0
 		for i in 0 to 7 loop
			sym <= std_logic_vector(to_signed(i, 4)); 
			assert ca2 = signed(sym) report "Fallo positivo" severity failure;
			wait for 1 ns;
		end loop;
		
		-- Loop para checkear negativos
 		for i in 1 to 7 loop
			sym <= '1' & std_logic_vector(to_signed(i, 3));
			neg := to_signed(-1*i, 4);
			wait for 1 ns;
			assert ca2 = neg report "Fallo negativo" severity failure;
		end loop;
		assert false report "Funciona" severity failure;
      wait;
   end process;

END;


