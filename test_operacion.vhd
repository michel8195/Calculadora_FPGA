
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_operacion IS
END test_operacion;
 
ARCHITECTURE behavior OF test_operacion IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT operaciones
    PORT(
         a : IN  signed(3 downto 0);
         b : IN  signed(3 downto 0);
         eleccion : IN  std_logic_vector(2 downto 0);
         overflow : OUT  std_logic;
         operacion : OUT  signed(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : signed(3 downto 0) := (others => '0');
   signal b : signed(3 downto 0) := (others => '0');
   signal eleccion : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal overflow : std_logic;
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

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
