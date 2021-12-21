----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2019 11:10:03
-- Design Name: 
-- Module Name: opgave_5 - Behavioral
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

entity opgave_5 is

    Port ( A : in integer range -8 to 7; -- 7 is grootst mogelijke getal bij twos complement
           B : in integer range -8 to 7; -- 7 is grootst mogelijke getal bij twos complement
           DipSW0: in std_logic_vector (0 downto 0);
           Leds: out std_logic_vector(15 downto 8));
           
end opgave_5;
     
architecture Behavioral of opgave_5 is

signal Product: integer;

begin

pIets: process(DipSW0, A, B, Product)
begin
if DipSW0 = "0" then
Product <= to_integer(to_unsigned(A, 4) * to_unsigned(B, 4));
Leds <= std_logic_vector(to_unsigned(Product, 8));
else
Product <= to_integer(to_signed(A, 4) * to_signed(B, 4));
Leds <= std_logic_vector(to_signed(Product, 8));
end if;
end process pIets;

end Behavioral;
