----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2019 11:42:22
-- Design Name: 
-- Module Name: opgave_7 - Behavioral
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

entity opgave_7 is
  Port ( Clk100MHz: in std_logic := '0';
         Rood: out std_logic_vector (3 downto 0);
         Groen: out std_logic_vector (3 downto 0);
         Blauw: out std_logic_vector (3 downto 0);
         HS: out std_logic;
         VS: out std_logic);
end opgave_7;

architecture Behavioral of opgave_7 is

    signal HCounter: integer := 1;
    signal VCounter: integer := 1;
    signal Clk25MHz: std_logic := '0';
    signal Teller: integer := 0;
    
begin

Groen <= "0000";
Blauw <= "0000";

process (Clk100MHz) is
begin
if rising_edge(Clk100MHz) then -- stijgende flank van de klok
    if Teller < 1 then
        Clk25MHz <= '0';
        Teller <= Teller + 1;
    elsif Teller <= 2 then
        Clk25MHz <= '1';
        Teller <= Teller + 1;
    else
        Clk25MHz <= '0';
        Teller <= 0;
    end if;
end if;
end process;

process (Clk25MHz) is
begin
if rising_edge(Clk25MHz) then
    if HCounter = 800 then
        HCounter <= 1;
        if VCounter = 525 then
            VCounter <= 1;
        else 
            VCounter <= VCounter + 1;
        end if;
    else HCounter <= HCounter + 1;
    end if;
end if;
end process;

pHSVS: process (HCounter, VCounter)
begin
if VCounter > 523 and VCounter <= 525 then
    VS <= '0';
else
    VS <= '1';
end if;
if HCounter > 704 and HCounter <= 800 then
    HS <= '0';
else
    HS <= '1';
end if;
if HCounter <= 688 and HCounter > 48 and VCounter <= 513 and VCounter > 33 then
    Rood <= "1111";
else
    Rood <= "0000";
end if;
end process;

end Behavioral;
