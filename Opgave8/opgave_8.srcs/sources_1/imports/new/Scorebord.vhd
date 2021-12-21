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


entity Scorebord is

    Port ( Clk100MHz: in std_logic := '0';
           Cathode : out std_logic_vector (6 downto 0); 
           Anode : out std_logic_vector (7 downto 0);
           TellerGeraakt : in integer;
           ScoreLinks: in integer;
           ScoreRechts: in integer); 
           
end Scorebord;

architecture Behavioral of Scorebord is

    signal BCD1: unsigned (3 downto 0);
    signal BCD2: unsigned (3 downto 0);
    signal BCD3: unsigned (3 downto 0);
    signal BCD4: unsigned (3 downto 0);
    signal BCD5: unsigned (3 downto 0);
    signal BCD6: unsigned (3 downto 0);
    signal BCD: unsigned (3 downto 0);
    signal TellerScoreBord: integer;
    signal TellerVerliezerWinner: integer;
    type tSegm is array(0 to 15) of std_logic_vector(6 downto 0);
    constant cSegm : tSegm := ("0000001", -- 0
                               "1001111", -- 1
                               "0010010", -- 2
                               "0000110", -- 3
                               "1001100", -- 4
                               "0100100", -- 5
                               "0100000", -- 6
                               "0001111", -- 7
                               "0000000", -- 8
                               "0000100", -- 9
                               "0001000", -- 10(A)
                               "1100000", -- 11(b)
                               "0110001", -- 12(C)
                               "1000010", -- 13(d)
                               "0110000", -- 14(E)
                               "0111000"); -- 15(F)

    signal SevenSegment : std_logic_vector(6 downto 0);
    
begin

process(Clk100MHz) is
begin
if rising_edge(Clk100MHz)then
    if TellerVerliezerWinner = 500000000 then
        Tellerverliezerwinner <= 0;
    else 
        TellerVerliezerWinner <= TellerVerliezerwinner + 1;
    end if;
    if TellerScoreBord = 40000 then
        TellerScoreBord <= 0;
    else
        TellerScoreBord <= TellerScoreBord + 1;
    end if;
end if;
end process;

pLinks: process (ScoreLinks)
begin
if ScoreLinks >= 0 and ScoreLinks <= 9 then
BCD1 <= "0000";
BCD2 <= to_unsigned(ScoreLinks, 4); -- De 4 staat voor het aantal bits dat de integer in moet omgezet worden dus xxxx
elsif ScoreLinks >= 10 and ScoreLinks <= 19 then
BCD1 <= "0001";
BCD2 <= to_unsigned(ScoreLinks - 10, 4); -- Min 10 om het getal te verkrijgen dat op het rechterscherm vertoond moet worden, ook voor de volgende lijnen geldt hetzelfde
elsif ScoreLinks >= 20 and ScoreLinks <= 29 then
BCD1 <= "0010";
BCD2 <= to_unsigned(ScoreLinks - 20, 4);
elsif ScoreLinks >= 30 and ScoreLinks <= 39 then
BCD1 <= "0011";
BCD2 <= to_unsigned(ScoreLinks - 30, 4);
elsif ScoreLinks >= 40 and ScoreLinks <= 49 then
BCD1 <= "0100";
BCD2 <= to_unsigned(ScoreLinks - 40, 4);
elsif ScoreLinks >= 50 and ScoreLinks <= 59 then
BCD1 <= "0101";
BCD2 <= to_unsigned(ScoreLinks - 50, 4);
elsif ScoreLinks >= 60 and ScoreLinks <= 69 then
BCD1 <= "0110";
BCD2 <= to_unsigned(ScoreLinks - 60, 4);
elsif ScoreLinks >= 70 and ScoreLinks <= 79 then
BCD1 <= "0111";
BCD2 <= to_unsigned(ScoreLinks - 70, 4);
elsif ScoreLinks >= 80 and ScoreLinks <= 89 then
BCD1 <= "1000";
BCD2 <= to_unsigned(ScoreLinks - 80, 4);
elsif ScoreLinks >= 90 and ScoreLinks <= 99 then
BCD1 <= "1001";
BCD2 <= to_unsigned(ScoreLinks - 90, 4);
else 
BCD1 <= "1110"; -- = E van error
BCD2 <= "1110"; -- = E van error
end if;
end process pLinks;

pRechts: process (ScoreRechts)
begin
if ScoreRechts >= 0 and ScoreRechts <= 9 then
BCD3 <= "0000";
BCD4 <= to_unsigned(ScoreRechts, 4);
elsif ScoreRechts >= 10 and ScoreRechts <= 19 then
BCD3 <= "0001";
BCD4 <= to_unsigned(ScoreRechts - 10, 4);
elsif ScoreRechts >= 20 and ScoreRechts <= 29 then
BCD3 <= "0010";
BCD4 <= to_unsigned(ScoreRechts - 20, 4);
elsif ScoreRechts >= 30 and ScoreRechts <= 39 then
BCD3 <= "0011";
BCD4 <= to_unsigned(ScoreRechts - 30, 4);
elsif ScoreRechts >= 40 and ScoreRechts <= 49 then
BCD3 <= "0100";
BCD4 <= to_unsigned(ScoreRechts - 40, 4);
elsif ScoreRechts >= 50 and ScoreRechts <= 59 then
BCD3 <= "0101";
BCD4 <= to_unsigned(ScoreRechts - 50, 4);
elsif ScoreRechts >= 60 and ScoreRechts <= 69 then
BCD3 <= "0110";
BCD4 <= to_unsigned(ScoreRechts - 60, 4);
elsif ScoreRechts >= 70 and ScoreRechts <= 79 then
BCD3 <= "0111";
BCD4 <= to_unsigned(ScoreRechts - 70, 4);
elsif ScoreRechts >= 80 and ScoreRechts <= 89 then
BCD3 <= "1000";
BCD4 <= to_unsigned(ScoreRechts - 80, 4);
elsif ScoreRechts >= 90 and ScoreRechts <= 99 then
BCD3 <= "1001";
BCD4 <= to_unsigned(ScoreRechts - 90, 4);
else
BCD3 <= "1110";
BCD4 <= "1110";
end if;
end process pRechts;

pTellerGeraakt: process (TellerGeraakt)
begin
if TellerGeraakt >= 0 and TellerGeraakt <= 9 then
BCD5 <= "0000";
BCD6 <= to_unsigned(TellerGeraakt, 4);
elsif TellerGeraakt >= 10 and TellerGeraakt <= 19 then
BCD5 <= "0001";
BCD6 <= to_unsigned(TellerGeraakt - 10, 4);
elsif TellerGeraakt >= 20 and TellerGeraakt <= 29 then
BCD5 <= "0010";
BCD6 <= to_unsigned(TellerGeraakt - 20, 4);
elsif TellerGeraakt >= 30 and TellerGeraakt <= 39 then
BCD5 <= "0011";
BCD6 <= to_unsigned(TellerGeraakt - 30, 4);
elsif TellerGeraakt >= 40 and TellerGeraakt <= 49 then
BCD5 <= "0100";
BCD6 <= to_unsigned(TellerGeraakt - 40, 4);
elsif TellerGeraakt >= 50 and TellerGeraakt <= 59 then
BCD5 <= "0101";
BCD6 <= to_unsigned(TellerGeraakt - 50, 4);
elsif TellerGeraakt >= 60 and TellerGeraakt <= 69 then
BCD5 <= "0110";
BCD6 <= to_unsigned(TellerGeraakt - 60, 4);
elsif TellerGeraakt >= 70 and TellerGeraakt <= 79 then
BCD5 <= "0111";
BCD6 <= to_unsigned(TellerGeraakt - 70, 4);
elsif TellerGeraakt >= 80 and TellerGeraakt <= 89 then
BCD5 <= "1000";
BCD6 <= to_unsigned(TellerGeraakt - 80, 4);
elsif TellerGeraakt >= 90 and TellerGeraakt <= 99 then
BCD5 <= "1001";
BCD6 <= to_unsigned(TellerGeraakt - 90, 4);
else
BCD5 <= "1110";
BCD6 <= "1110";
end if;
end process;

pScherm: process(BCD1, BCD2, BCD3, BCD4, BCD5, BCD6, SevenSegment, TellerScoreBord, ScoreLinks, ScoreRechts, TellerVerliezerWinner)
begin
if ScoreLinks >= 10 then --tijdelijk 10 gemaakt normaal 99
if TellerVerliezerWinner < 250000000 then
    if TellerScoreBord < 5000 then 
        Anode <= "01111111";
        Cathode <= "0100100";
    elsif TellerScoreBord >= 5000 and TellerScoreBord < 10000 then
        Anode <= "10111111";
        Cathode <= "0011000";
    elsif TellerScoreBord >= 10000 and TellerScoreBord < 15000 then
        Anode <= "11011111";
        Cathode <= "0110000";
   elsif TellerScoreBord >= 15000 and TellerScoreBord < 20000 then
        Anode <= "11101111";
        Cathode <= "1110001";
   elsif TellerScoreBord >= 20000 and TellerScoreBord < 25000 then
        Anode <= "11110111";
        Cathode <= "0110000";
   elsif TellerScoreBord >= 25000 and TellerScoreBord < 30000 then
        Anode <= "11111011";
        Cathode <= "0111001";
   elsif TellerScoreBord >= 30000 and TellerScoreBord < 35000 then
        Anode <= "11111101";
        Cathode <= "1001111";
   else 
        Anode <= "11111110";
        Cathode <= "1010100";
   end if;
else 
    if TellerScoreBord < 5000 then
        Anode <= "01111111";
        Cathode <= "0100100";
    elsif TellerScoreBord >= 5000 and TellerScoreBord < 10000 then
        Anode <= "10111111";
        Cathode <= "0011000";
    elsif TellerScoreBord >= 10000 and TellerScoreBord < 15000 then
        Anode <= "11011111";
        Cathode <= "0110000";
   elsif TellerScoreBord >= 15000 and TellerScoreBord < 20000 then
        Anode <= "11101111";
        Cathode <= "1110001";
   elsif TellerScoreBord >= 20000 and TellerScoreBord < 25000 then
        Anode <= "11110111";
        Cathode <= "0110000";
   elsif TellerScoreBord >= 25000 and TellerScoreBord < 30000 then
        Anode <= "11111011";
        Cathode <= "0111001";
   elsif TellerScoreBord >= 30000 and TellerScoreBord < 35000 then
        Anode <= "11111101";
        Cathode <= "0010010";
   else 
        Anode <= "11111110";
        Cathode <= "1110001";
   end if;
end if;
elsif ScoreRechts >= 10 then --tijdelijk 10 gemaakt normaal 99
if TellerVerliezerWinner < 250000000 then
    if TellerScoreBord < 5000 then
        Anode <= "01111111";
        Cathode <= "0100100";
    elsif TellerScoreBord >= 5000 and TellerScoreBord < 10000 then
        Anode <= "10111111";
        Cathode <= "0011000";
    elsif TellerScoreBord >= 10000 and TellerScoreBord < 15000 then
        Anode <= "11011111";
        Cathode <= "0110000";
   elsif TellerScoreBord >= 15000 and TellerScoreBord < 20000 then
        Anode <= "11101111";
        Cathode <= "1110001";
   elsif TellerScoreBord >= 20000 and TellerScoreBord < 25000 then
        Anode <= "11110111";
        Cathode <= "0110000";
   elsif TellerScoreBord >= 25000 and TellerScoreBord < 30000 then
        Anode <= "11111011";
        Cathode <= "0111001";
   elsif TellerScoreBord >= 30000 and TellerScoreBord < 35000 then
        Anode <= "11111101";
        Cathode <= "0010010";
   else 
        Anode <= "11111110";
        Cathode <= "1010100";
   end if;
else 
    if TellerScoreBord < 5000 then
        Anode <= "01111111";
        Cathode <= "0100100";
    elsif TellerScoreBord >= 5000 and TellerScoreBord < 10000 then
        Anode <= "10111111";
        Cathode <= "0011000";
    elsif TellerScoreBord >= 10000 and TellerScoreBord < 15000 then
        Anode <= "11011111";
        Cathode <= "0110000";
   elsif TellerScoreBord >= 15000 and TellerScoreBord < 20000 then
        Anode <= "11101111";
        Cathode <= "1110001";
   elsif TellerScoreBord >= 20000 and TellerScoreBord < 25000 then
        Anode <= "11110111";
        Cathode <= "0110000";
   elsif TellerScoreBord >= 25000 and TellerScoreBord < 30000 then
        Anode <= "11111011";
        Cathode <= "0111001";
   elsif TellerScoreBord >= 30000 and TellerScoreBord < 35000 then
        Anode <= "11111101";
        Cathode <= "1001111";
   else 
        Anode <= "11111110";
        Cathode <= "1110001";
   end if;
end if;
else
if TellerScoreBord < 5000 then
    Anode <= "01111111";
    Cathode <= cSegm(to_integer(BCD1));
elsif TellerScoreBord >= 5000 and TellerScoreBord < 10000 then
    Anode <= "10111111";
    Cathode <= cSegm(to_integer(BCD2));
elsif TellerScoreBord >= 15000 and TellerScoreBord < 20000 then
    Anode <= "11101111";
    Cathode <= cSegm(to_integer(BCD5));
elsif TellerScoreBord >= 20000 and TellerScoreBord < 25000 then
    Anode <= "11110111";
    Cathode <= cSegm(to_integer(BCD6));
elsif TellerScoreBord >= 30000 and TellerScoreBord < 35000 then
    Anode <= "11111101";
    Cathode <= cSegm(to_integer(BCD3));
else
    Anode <= "11111110";
    Cathode <= cSegm(to_integer(BCD4));
end if;
end if;
end process;

end Behavioral;

