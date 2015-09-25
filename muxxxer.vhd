--**********************************************************
--             ROOSBEH ALMASI 31/08/2015

-- multiplexing  dE1 alphabets and rotating them on the seven segment 
--**********************************************************
 




library ieee;
use ieee.std_logic_1164.all;



entity muxxxer is
port(

             CLOCK_50 : in  std_logic;
			  SW : in  std_logic_vector(9 downto 0);
			 KEY : in  std_logic_vector(3 downto 0);
			LEDR : out std_logic_vector(9 downto 0);
			HEX0 : out std_logic_vector(0 to 6);
			HEX1 : out std_logic_vector(0 to 6);
			HEX2 : out std_logic_vector(0 to 6);
			HEX3 : out std_logic_vector(0 to 6);
			HEX4 : out std_logic_vector(0 to 6);
			HEX5 : out std_logic_vector(0 to 6)
		

);
end muxxxer;

architecture main of muxxxer is
signal R0, R1, R2, R3, R4, R5 : std_logic_vector(1 downto 0);


--CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
component muxer is
port(
       u, v, w, x, y, z : in  std_logic_vector(1 downto 0);
		                s : in  std_logic_vector(2 downto 0);
		                m : out std_logic_vector(1 downto 0)

);
end component muxer;
component segment is
port(
         j : in  std_logic_vector(1 downto 0);
		   k : out std_logic_vector(0 to 6)

);
end component segment;
--CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
begin                --2

g0: muxer port map( u => sw(5 downto 4),
                    v => sw(3 downto 2),
						  w => sw(1 downto 0),
						  x => "11",
						  y => "11",
						  z => "11",
						  s => sw(9 downto 7),
						  
						  m => R2
);

g1: segment port map(
                      j => R2,
							 k => hex2
);

     -------------------- 1 --------------------------
g2: muxer port map( z => sw(5 downto 4),
                    u => sw(3 downto 2),
						  v => sw(1 downto 0),
						  w => "11",
						  x => "11",
						  y => "11",
						  s => sw(9 downto 7),
						  
						  m => R1
);

g3: segment port map(
                      j => R1,
							 k => hex1
);

     -------------------  0 -------------------------

g4: muxer port map( y => sw(5 downto 4),
                    z => sw(3 downto 2),
						  u => sw(1 downto 0),
						  v => "11",
						  w => "11",
						  x => "11",
						  s => sw(9 downto 7),
						  
						  m => R0
);

g5: segment port map(
                      j => R0,
							 k => hex0
);

 ----------------------- 5 ---------------------
g6: muxer port map( x => sw(5 downto 4),
                    y => sw(3 downto 2),
						  z => sw(1 downto 0),
						  u => "11",
						  v => "11",
						  w => "11",
						  s => sw(9 downto 7),
						  
						  m => R5
);

g7: segment port map(
                      j => R5,
							 k => hex5
);

 ----------------------- 4 ---------------------
g8: muxer port map( w => sw(5 downto 4),
                    x => sw(3 downto 2),
						  y => sw(1 downto 0),
						  z => "11",
						  u => "11",
						  v => "11",
						  s => sw(9 downto 7),
						  
						   m => R4
);

g9: segment port map(
                      j => R4,
							 k => hex4
);

 ----------------------- 3 ---------------------
g10: muxer port map( v => sw(5 downto 4),
                    w => sw(3 downto 2),
						  x => sw(1 downto 0),
						  y => "11",
						  z => "11",
						  u => "11",
						  s => sw(9 downto 7),
						  
						   m => R3
);

g11: segment port map(
                      j => R3,
							 k => hex3
);

end main;





--***************************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity muxer is
port(
      u, v, w, x, y, z : in  std_logic_vector(1 downto 0);
		               s : in  std_logic_vector(2 downto 0);
		               m : out std_logic_vector(1 downto 0)

);
end muxer;

architecture main of muxer is

signal a : std_logic_vector(3 downto 0);
signal b : std_logic_vector(3 downto 0);

begin
       
		 a(3) <= (not s(2) and u(1)) or (s(2) and v(1));
		 a(2) <= (not s(2) and u(0)) or (s(2) and v(0));
		 
		 a(1) <= (not s(2) and w(1)) or (s(2) and x(1));
		 a(0) <= (not s(2) and w(0)) or (s(2) and x(0));
		 
		 b(1) <= (not s(2) and y(1)) or (s(2) and z(1));
		 b(0) <= (not s(2) and y(0)) or (s(2) and z(0));
		 
		 b(3) <= (not s(1) and a(3)) or (s(1) and a(1));
		 b(2) <= (not s(1) and a(2)) or (s(1) and a(0));
		 
		 m(1) <= (not s(0) and b(3)) or (s(0) and b(1));
		 m(0) <= (not s(0) and b(2)) or (s(0) and b(0));

end main;


--*****************************************************************************

library ieee;
use ieee.std_logic_1164.all;


entity segment is
port(
         j : in  std_logic_vector(1 downto 0);
		   k : out std_logic_vector(0 to 6)

);
end segment;

architecture main of segment is
begin
       with j select
              k <= "1000010" when "00",       
	                "0110000" when "01",
						 "1001111" when "10",
		    			 "1111111" when others;

end main;