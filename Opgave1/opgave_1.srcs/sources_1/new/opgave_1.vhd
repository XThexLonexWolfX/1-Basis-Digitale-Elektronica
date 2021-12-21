----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2019 12:00:07
-- Design Name: 
-- Module Name: opgave_1 - Behavioral
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


entity opgave_1 is
    Port ( BCD : in unsigned (3 downto 0);
           SevenSegment : out std_logic_vector(6 downto 0));
end opgave_1;

architecture RTL of opgave_1 is

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
    signal seven_segment_display : std_logic_vector(6 downto 0);

begin
pBCDnaarsevensegment: process (BCD)
begin
case BCD is
when "0000" =>
seven_segment_display <= cSegm(0);
when "0001" =>
seven_segment_display <= cSegm(1);
when "0010" =>
seven_segment_display <= cSegm(2);
when "0011" =>
seven_segment_display <= cSegm(3);
when "0100" =>
seven_segment_display <= cSegm(4);
when "0101" =>
seven_segment_display <= cSegm(5);
when "0110" =>
seven_segment_display <= cSegm(6);
when "0111" =>
seven_segment_display <= cSegm(7);
when "1000" =>
seven_segment_display <= cSegm(8);
when "1001" =>
seven_segment_display <= cSegm(9);
when "1010" =>
seven_segment_display <= cSegm(10);
when "1011" =>
seven_segment_display <= cSegm(11);
when "1100" =>
seven_segment_display <= cSegm(12);
when "1101" =>
seven_segment_display <= cSegm(13);
when "1110" =>
seven_segment_display <= cSegm(14);
when "1111" =>
seven_segment_display <= cSegm(15);
when others =>
seven_segment_display <= "1111111";
end case;
end process pBCDnaarsevensegment;
SevenSegment <= seven_segment_display;


end RTL;
