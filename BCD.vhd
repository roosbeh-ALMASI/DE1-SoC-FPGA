--------------------------------------------------------

 -- date 22/09/2015   
 -- BCD   0 to 19 ,  it adds to 4 bit inputs and shows the results on segments in decimal

--------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity BCD is
port(

     
			  SW : in  std_logic_vector(9 downto 0);
			LEDR : out std_logic_vector(9 downto 0);
			HEX0 : out std_logic_vector(0 to 6);
			HEX1 : out std_logic_vector(0 to 6);
			HEX2 : out std_logic_vector(0 to 6);
			HEX4 : out std_logic_vector(0 to 6)
);
end BCD;

architecture main of BCD is
                                        -- components 1
component decode_a is
port(

       x : in  std_logic_vector(3 downto 0);
		 z : out std_logic_vector(0 to 6)

);
end component decode_a;
                                        -- component 2
													 
component decode_b is
port(

       x : in  std_logic_vector(4 downto 0);
		 z : out std_logic_vector(4 downto 0)

);
end component decode_b;
                                          -- component 3
component decode_c is
port(

       x : in  std_logic_vector(4 downto 0);
		 z : out std_logic_vector(0 to 6)

);
end component decode_c;	
                                        --component 4
												 
component decode_d is
port(

       x : in  std_logic;
		 z : out std_logic_vector(0 to 6)

);
end component decode_d;
                                        --component 5

component cmp is
port(

       x : in  std_logic_vector(4 downto 0);
		 z : out std_logic

);
end component cmp;   
                                        --component 6
component mux is
port(

       x, y : in  std_logic_vector(4 downto 0);
		    z : out std_logic_vector(4 downto 0);
			 s : in std_logic

);
end component mux;
                                       --component 7
component adder_4bits is
port(

       x, y : in  std_logic_vector(3 downto 0);
		    z : out std_logic_vector(4 downto 0);
			 ci : in std_logic

);
end component adder_4bits;

signal a, b : std_logic;
signal c, d, e : std_logic_vector(4 downto 0);

begin


g0: decode_a    port map(x=>sw(3 downto 0), z=>HEX2);
g1: decode_a    port map(x=>sw(7 downto 4), z=>HEX4);
g2: adder_4bits port map(x=>sw(3 downto 0), y=>sw(7 downto 4), ci=>sw(9), z=>c);
g3: decode_b    port map(x=>c, z=>d);
g4: cmp         port map(x=>c, z=>b);
g5: mux         port map(x=>c, y=>d, s=>b, z=>e);
g6: decode_d    port map(x=>b, z=>HEX1);
g7: decode_c    port map(x=>e, z=>HEX0);

LEDR(4 downto 0) <= c;
LEDR(9) <= SW(9);


end main;

--**************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity decode_a is
port(

       x : in  std_logic_vector(3 downto 0);
		 z : out std_logic_vector(0 to 6)

);
end decode_a;

architecture main of decode_a is
begin

   process(x)
	       begin
			     case x is
				            when "0000" => z <= "0000001";
								when "0001" => z <= "1001111";
								when "0010" => z <= "0010010";
								when "0011" => z <= "0000110";
								when "0100" => z <= "1001100";
								when "0101" => z <= "0100100";
								when "0110" => z <= "0100000";
								when "0111" => z <= "0001111";
								when "1000" => z <= "0000000";
								when "1001" => z <= "0001100";
								when others => z <= "1111111";
				  end case;
	end process;

end main;
--**********************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity decode_b is
port(

       x : in  std_logic_vector(4 downto 0);
		 z : out std_logic_vector(4 downto 0)

);
end decode_b;

architecture main of decode_b is
begin

   process(x)
	       begin
			     case x is
				            when "01010" => z <= "00000";
								when "01011" => z <= "00001";
								when "01100" => z <= "00010";
								when "01101" => z <= "00011";
							   when "01110" => z <= "00100";
								when "01111" => z <= "00101";
							   when "10000" => z <= "00110";
								when "10001" => z <= "00111";
							   when "10010" => z <= "01000";
							   when "10011" => z <= "01001";
							   when others =>  z <= "-----";
				  end case;
	end process;



end main;

--**********************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity decode_c is
port(

       x : in  std_logic_vector(4 downto 0);
		 z : out std_logic_vector(0 to 6)

);
end decode_c;

architecture main of decode_c is
begin

   process(x)
	       begin
			     case x is
				            when "00000" => z <= "0000001";
								when "00001" => z <= "1001111";
								when "00010" => z <= "0010010";
								when "00011" => z <= "0000110";
								when "00100" => z <= "1001100";
								when "00101" => z <= "0100100";
								when "00110" => z <= "0100000";
								when "00111" => z <= "0001111";
								when "01000" => z <= "0000000";
								when "01001" => z <= "0001100";
								when others  => z <= "-------";
				  end case;
	end process;

end main;


--**********************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity decode_d is
port(

       x : in  std_logic;
		 z : out std_logic_vector(0 to 6)

);
end decode_d;

architecture main of decode_d is
begin

     process(x)
	       begin
			     case x is
				            when '0'    => z <= "0000001";
								when '1'    => z <= "1001111";
								when others => z <= "-------";
								
				  end case;
	  end process; 

end main;

--**********************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity cmp is
port(

       x : in  std_logic_vector(4 downto 0);
		 z : out std_logic

);
end cmp;

architecture main of cmp is
begin

     z <= (not x(4) and x(3) and x(2)) or (not x(4) and x(3) and x(1)) or (x(4) and not x(3) and not x(2));

end main;

--**********************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity mux is
port(

       x, y : in  std_logic_vector(4 downto 0);
		    z : out std_logic_vector(4 downto 0);
			 s : in std_logic

);
end mux;

architecture main of mux is
begin

        process (s)
		      begin
		            if(s = '0') then z <= x; else z <= y;
						end if;
						
		 end process;

end main;

--**********************************************************************
--        adder 
--**********************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity adder_4bits is
port(

       x, y : in  std_logic_vector(3 downto 0);
		    z : out std_logic_vector(4 downto 0);
			 ci : in std_logic

);
end adder_4bits;

architecture main of adder_4bits is
component adder is
port(

       x, y, ci : in  std_logic;
		    s, co : out std_logic
		

);
end component adder;
signal a : std_logic_vector(2 downto 0);
begin

g0: adder port map(x=>x(0), y=>y(0), ci=>ci,   co=>a(0), s=>z(0));
g1: adder port map(x=>x(1), y=>y(1), ci=>a(0), co=>a(1), s=>z(1));
g2: adder port map(x=>x(2), y=>y(2), ci=>a(1), co=>a(2), s=>z(2));
g3: adder port map(x=>x(3), y=>y(3), ci=>a(2), co=>z(4), s=>z(3));
      

end main;

--**********************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity adder is
port(

       x, y, ci : in  std_logic;
		    s, co : out std_logic
);
end adder;
 
architecture main of adder is
signal a : std_logic;
begin
    
	  a <= x xor y;
	  s <= a xor ci;
	 co <= (not a and y) or (a and ci); 
      

end main;

