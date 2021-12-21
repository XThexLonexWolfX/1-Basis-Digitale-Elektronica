----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 09:03:42
-- Design Name: 
-- Module Name: opgave_6 - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity opgave_6 is

    Port ( BTNC : in std_logic;
           Clk100MHz: in std_logic := '0';
           Leds: out std_logic_vector (15 downto 0));
           
end opgave_6;

architecture Behavioral of opgave_6 is

    signal Clk20HZ: std_logic := '0';
    signal Teller: integer := 0;
    signal LoopLichtTeller: integer := 0;
    
begin

process (Clk100MHz) is
begin
if rising_edge(Clk100MHz) then -- stijgende flank van de klok
    if Teller < 2500000 then
        Clk20Hz <= '0';
        Teller <= Teller + 1;
    elsif 2500000 <= Teller and Teller <= 5000000 then
        Clk20Hz <= '1';
        Teller <= Teller + 1;
    else
        Clk20Hz <= Clk20HZ;
        Teller <= 0;
    end if;
end if;
end process;

process (Clk20Hz) is
begin
if falling_edge(Clk20Hz) then
    if BTNC = '1' then -- synchrone reset
        Leds <= "1000000000000000";
        LoopLichtTeller <= 0;
    else
    if LoopLichtTeller = 0 or LoopLichtTeller = 30 then
        Leds <= "1000000000000000";
        LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 1 or LoopLichtTeller = 29 then
         Leds <= "0100000000000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 2 or LoopLichtTeller = 28 then
         Leds <= "0010000000000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 3 or LoopLichtTeller = 27 then
         Leds <= "0001000000000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 4 or LoopLichtTeller = 26 then
         Leds <= "0000100000000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 5 or LoopLichtTeller = 25 then
         Leds <= "0000010000000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 6 or LoopLichtTeller = 24 then
         Leds <= "0000001000000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 7 or LoopLichtTeller = 23 then
         Leds <= "0000000100000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 8 or LoopLichtTeller = 22 then
         Leds <= "0000000010000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 9 or LoopLichtTeller = 21 then
         Leds <= "0000000001000000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 10 or LoopLichtTeller = 20 then
         Leds <= "0000000000100000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 11 or LoopLichtTeller = 19 then
         Leds <= "0000000000010000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 12 or LoopLichtTeller = 18 then
         Leds <= "0000000000001000";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 13 or LoopLichtTeller = 17 then
         Leds <= "0000000000000100";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 14 or LoopLichtTeller = 16 then
         Leds <= "0000000000000010";
         LoopLichtTeller <= LoopLichtTeller + 1;
    elsif LoopLichtTeller = 15 then
         Leds <= "0000000000000001";
         LoopLichtTeller <= LoopLichtTeller + 1;
    else
         Leds <= "0100000000000000";
        LoopLichtTeller <= 2;
    end if;
    end if;
end if;
end process;

end Behavioral;
