----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2019 17:01:58
-- Design Name: 
-- Module Name: opgave_2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity opgave_2 is

    Port ( Dip: in std_logic_vector (15 downto 0);
           Cathode : out std_logic_vector (6 downto 0); 
           Anode : out std_logic_vector (7 downto 0);
           DP: out std_logic_vector (0 downto 0);
           BTNC: in std_logic_vector (0 downto 0)); 
           
end opgave_2;

architecture Behavioral of opgave_2 is

    signal Diplinks: unsigned (6 downto 0);
    signal Diplinks_twoscomplement: signed (6 downto 0);
    signal Diplinksinteger: integer;
    signal Diprechts: unsigned (6 downto 0);
    signal Diprechts_twoscomplement: signed (6 downto 0);
    signal Diprechtsinteger: integer;
    signal Dipmidden: unsigned (1 downto 0);
    signal BCD1: unsigned (3 downto 0);
    signal BCD2: unsigned (3 downto 0);
    signal BCD3: unsigned (3 downto 0);
    signal BCD4: unsigned (3 downto 0);
    signal BCD: unsigned (3 downto 0);
    signal SevenSegment: std_logic_vector (6 downto 0);
    
    component opgave_1
    Port ( BCD : in unsigned (3 downto 0);
           SevenSegment : out std_logic_vector (6 downto 0));
    end component;
    
begin

Opgave1_invoegen: opgave_1 port map(
BCD => BCD,
SevenSegment => SevenSegment);

Diplinks <= unsigned(Dip(15 downto 9)); --std_logic_vector naar unsigned (type casten)
Diprechts <= unsigned(Dip(6 downto 0)); --std_logic_vector naar unsigned (type casten)
Dipmidden <= unsigned(Dip(8 downto 7)); --std_logic_vector naar unsigned (type casten)
Diplinks_twoscomplement <= signed(Dip(15 downto 9)); -- std_logic_vector naar signed (type casten)
Diprechts_twoscomplement <= signed(Dip(6 downto 0)); -- std_logic_vector naar signed (type casten)

pBTNC: process (Diplinks, Diprechts, BTNC, Diplinks_twoscomplement, Diprechts_twoscomplement)
begin
case BTNC is
when "0" =>
Diplinksinteger <= to_integer(Diplinks); --unsigned naar integer
Diprechtsinteger <= to_integer(Diprechts); --unsigned naar integer
when others =>
Diplinksinteger <= to_integer(Diplinks_twoscomplement); --signed naar integer
Diprechtsinteger <= to_integer(Diprechts_twoscomplement); --signed naar integer
end case;
end process pBTNC;

pLinks: process (Diplinksinteger)
begin
if abs(Diplinksinteger) >= 0 and abs(Diplinksinteger) <= 9 then
BCD1 <= "0000";
BCD2 <= to_unsigned(abs(Diplinksinteger), 4); -- De 4 staat voor het aantal bits dat de integer in moet omgezet worden dus xxxx
elsif abs(Diplinksinteger) >= 10 and abs(Diplinksinteger) <= 19 then
BCD1 <= "0001";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 10, 4); -- Min 10 om het getal te verkrijgen dat op het rechterscherm vertoond moet worden, ook voor de volgende lijnen geldt hetzelfde
elsif abs(Diplinksinteger) >= 20 and abs(Diplinksinteger) <= 29 then
BCD1 <= "0010";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 20, 4);
elsif abs(Diplinksinteger) >= 30 and abs(Diplinksinteger) <= 39 then
BCD1 <= "0011";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 30, 4);
elsif abs(Diplinksinteger) >= 40 and abs(Diplinksinteger) <= 49 then
BCD1 <= "0100";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 40, 4);
elsif abs(Diplinksinteger) >= 50 and abs(Diplinksinteger) <= 59 then
BCD1 <= "0101";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 50, 4);
elsif abs(Diplinksinteger) >= 60 and abs(Diplinksinteger) <= 69 then
BCD1 <= "0110";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 60, 4);
elsif abs(Diplinksinteger) >= 70 and abs(Diplinksinteger) <= 79 then
BCD1 <= "0111";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 70, 4);
elsif abs(Diplinksinteger) >= 80 and abs(Diplinksinteger) <= 89 then
BCD1 <= "1000";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 80, 4);
elsif abs(Diplinksinteger) >= 90 and abs(Diplinksinteger)<= 99 then
BCD1 <= "1001";
BCD2 <= to_unsigned(abs(Diplinksinteger) - 90, 4);
else 
BCD1 <= "1110"; -- = E van error
BCD2 <= "1110"; -- = E van error
end if;
end process pLinks;

pRechts: process (Diprechtsinteger)
begin
if abs(Diprechtsinteger) >= 0 and abs(Diprechtsinteger) <= 9 then
BCD3 <= "0000";
BCD4 <= to_unsigned(abs(Diprechtsinteger), 4);
elsif abs(Diprechtsinteger) >= 10 and abs(Diprechtsinteger) <= 19 then
BCD3 <= "0001";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 10, 4);
elsif abs(Diprechtsinteger) >= 20 and abs(Diprechtsinteger) <= 29 then
BCD3 <= "0010";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 20, 4);
elsif abs(Diprechtsinteger) >= 30 and abs(Diprechtsinteger) <= 39 then
BCD3 <= "0011";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 30, 4);
elsif abs(Diprechtsinteger) >= 40 and abs(Diprechtsinteger) <= 49 then
BCD3 <= "0100";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 40, 4);
elsif abs(Diprechtsinteger) >= 50 and abs(Diprechtsinteger) <= 59 then
BCD3 <= "0101";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 50, 4);
elsif abs(Diprechtsinteger) >= 60 and abs(Diprechtsinteger) <= 69 then
BCD3 <= "0110";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 60, 4);
elsif abs(Diprechtsinteger) >= 70 and abs(Diprechtsinteger) <= 79 then
BCD3 <= "0111";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 70, 4);
elsif abs(Diprechtsinteger) >= 80 and abs(Diprechtsinteger) <= 89 then
BCD3 <= "1000";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 80, 4);
elsif abs(Diprechtsinteger) >= 90 and abs(Diprechtsinteger) <= 99 then
BCD3 <= "1001";
BCD4 <= to_unsigned(abs(Diprechtsinteger) - 90, 4);
else
BCD3 <= "1110";
BCD4 <= "1110";
end if;
end process pRechts;

pMidden: process(Dipmidden, BCD1, BCD2, BCD3, BCD4, SevenSegment)
begin
case Dipmidden is
when "00" => 
BCD <= BCD1;
Cathode <= SevenSegment;
Anode <= "01111111";
when "01" => 
BCD <= BCD2; 
Cathode <= SevenSegment;
Anode <= "10111111";
when "10" => 
BCD <= BCD3;
Cathode <= SevenSegment;
Anode <= "11111101";
when "11" => 
BCD <= BCD4;
Cathode <= SevenSegment;
Anode <= "11111110";
when others =>
BCD <= "1110"; 
Cathode <= SevenSegment;
Anode <= "11111111";
end case;
end process pMidden;

pDP: process (Diplinksinteger, Diprechtsinteger, Dipmidden)
begin 
if Diplinksinteger < 0 and DipMidden = "00" then
DP <= "0";
elsif Diplinksinteger < 0 and DipMidden = "01" then
DP <= "0";
elsif Diprechtsinteger < 0 and Dipmidden = "10" then
DP <= "0";
elsif Diprechtsinteger < 0 and Dipmidden = "11" then
DP <= "0";
else
DP <= "1";
end if;
end process pDP;

end Behavioral;
