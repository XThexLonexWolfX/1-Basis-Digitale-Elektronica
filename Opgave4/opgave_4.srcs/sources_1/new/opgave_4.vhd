----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2019 11:12:29
-- Design Name: 
-- Module Name: opgave_4 - Behavioral
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

entity opgave_4 is
    Port ( A: in std_logic_vector (15 downto 12);
           B: in std_logic_vector (11 downto 8);
           Leds: out std_logic_vector (15 downto 11);
           DipSW: in std_logic_vector (1 downto 0));
    
end opgave_4;

architecture Behavioral of opgave_4 is
  
    signal DipSW0: std_logic_vector(0 downto 0);
    signal DipSW1: std_logic_vector(0 downto 0);
    signal Som: integer;
   
begin
DipSW0 <= DipSW(0 downto 0);
DipSW1 <= DipSW(1 downto 1);

pDipSW1: process(DipSW1, DipSW0, Som, A, B)
begin
if DipSW0 = "0" and DipSW1 = "0" then
Som <= to_integer(unsigned(A)) + to_integer(unsigned(B));
Leds <= std_logic_vector(to_unsigned(Som, 5));
elsif DipSW0 = "0" and DipSW1 = "1" then
Som <= to_integer(unsigned(A)) + to_integer(unsigned(B));
Leds <= "0" & std_logic_vector(to_unsigned(Som, 4));
elsif DipSW0 = "1" and DipSW1 = "0" then
Som <= to_integer(signed(A)) + to_integer(signed(B));
Leds <= std_logic_vector(to_signed(Som, 5));
else
Som <= to_integer(signed(A)) + to_integer(signed(B));
Leds <= "0" & std_logic_vector(to_signed(Som, 4));
end if;
end process pDipSW1;

end Behavioral;
