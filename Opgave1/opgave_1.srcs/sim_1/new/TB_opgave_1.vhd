----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2019 11:49:34
-- Design Name: 
-- Module Name: TB_opgave_1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_opgave_1 is
--  Port ( );
end TB_opgave_1;

architecture Behavioral of TB_opgave_1 is
    signal AllValues: unsigned (3 downto 0);
    signal AllValuesuitgang: std_logic_vector (6 downto 0);
    
    component opgave_1
        Port ( BCD : in unsigned (3 downto 0);
               SevenSegment : out std_logic_vector (6 downto 0));
    end component;
begin

    Voorbeeld: opgave_1 port map(
    BCD => AllValues,
    SevenSegment => AllValuesuitgang);
    
    p_Stimuli: process
    begin
    AllValues <= "0000";
    wait for 50 ns;
    AllValues <= "0001";
    wait for 50 ns;
    AllValues <= "0010";
    wait for 50 ns;
    AllValues <= "0011";
    wait for 50 ns;
    AllValues <= "0100";
    wait for 50 ns;
    Allvalues <= "0101";
    wait for 50 ns;
    AllValues <= "0110";
    wait for 50 ns;
    AllValues <= "0111";
    wait for 50 ns;
    AllValues <= "1000";
    wait for 50 ns;
    AllValues <= "1001";
    wait for 50 ns;
    AllValues <= "1010";
    wait for 50 ns;
    AllValues <= "1011";
    wait for 50 ns;
    AllValues <= "1100";
    wait for 50 ns;
    AllValues <= "1101";
    wait for 50 ns;
    AllValues <= "1110";
    wait for 50ns;
    AllValues <= "1111";
    wait for 50 ns;
    end process p_Stimuli;
    
    
  
end Behavioral;
