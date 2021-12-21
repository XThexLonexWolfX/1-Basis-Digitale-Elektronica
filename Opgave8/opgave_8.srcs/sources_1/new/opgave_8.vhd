----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2019 18:36:47
-- Design Name: 
-- Module Name: opgave_8 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity opgave_8 is
    Port ( Clk100MHz: in std_logic := '0';
           Cathode: out std_logic_vector(6 downto 0);
           Anode: out std_logic_vector(7 downto 0);
           Rood: out std_logic_vector (3 downto 0);
           Groen: out std_logic_vector (3 downto 0);
           Blauw: out std_logic_vector (3 downto 0);
           Dip: in std_logic_vector (12 downto 0);
           HS: out std_logic;
           VS: out std_logic;
           BTNC: in std_logic;
           BTNU: in std_logic;
           BTND: in std_logic;
           BTNL: in std_logic;
           BTNR: in std_logic);
           
end opgave_8;

architecture Behavioral of opgave_8 is

    signal HCounter: integer := 1;
    signal VCounter: integer := 1;
    signal Clk25MHz: std_logic := '0';
    signal Clk250Hz: std_logic := '0';
    signal Teller25MHz: integer := 0;
    signal Teller250Hz: integer := 0;
    signal PaletLinksBovenY: integer := 180;
    signal PaletLinksOnderY: integer := 300;
    signal PaletRechtsBovenY: integer := 180;
    signal PaletRechtsOnderY: integer := 300;
    signal BalRechts: integer := 325;
    signal BalLinks: integer := 315;
    signal BalBoven: integer := 235;
    signal BalOnder: integer := 245;
    signal directionX: integer := 1;
    signal directionY: integer := 1;
    signal ScoreLinks: integer;
    signal ScoreRechts: integer;
    signal TellerGeraakt: integer;
    signal DipKleur: std_logic_vector (0 downto 0);
    signal DipRood: std_logic_vector (3 downto 0);
    signal DipGroen: std_logic_vector (3 downto 0);
    signal DipBlauw: std_logic_vector (3 downto 0);
    component Scorebord
    Port ( Clk100MHz: in std_logic := '0';
           Cathode : out std_logic_vector (6 downto 0); 
           Anode : out std_logic_vector (7 downto 0);
           TellerGeraakt : in integer;
           ScoreLinks: in integer;
           ScoreRechts : in integer);
    end component;
    
begin

DipKleur <= Dip (0 downto 0);
DipRood <= Dip (4 downto 1);
DipGroen <= Dip (8 downto 5);
DipBlauw <= Dip (12 downto 9);

Scorebord_invoegen: Scorebord port map(
Clk100MHz => Clk100MHz,
Cathode => Cathode,
Anode => Anode,
TellerGeraakt => TellerGeraakt,
ScoreLinks => ScoreLinks,
ScoreRechts => ScoreRechts);

process(Clk100MHz) is
begin
if rising_edge(Clk100MHz) then -- stijgende flank van de klok
    if Teller25MHz < 1 then
        Clk25MHz <= '0';
        Teller25MHz <= Teller25MHz + 1;
    elsif Teller25MHz <= 2 then
        Clk25MHz <= '1';
        Teller25MHz <= Teller25MHz + 1;
    else
        Clk25MHz <= '0';
        Teller25MHz <= 0;
    end if;
    if Teller250HZ < 200000 then
        Clk250Hz <= '0';
        Teller250HZ <= Teller250HZ + 1;
    elsif Teller250HZ <= 400000 then
        Clk250Hz <= '1';
        Teller250HZ <= Teller250HZ +1;
    else 
        Clk250Hz <= '0';
        Teller250HZ <= 0;
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

process (Clk250Hz) is
begin
if rising_edge(Clk250Hz) then
if BTNC = '1' then 
    BalBoven <= 235;
    BalOnder <= 245;
    BalLinks <= 315;
    BalRechts <= 325;
    PaletLinksOnderY <= 300;
    PaletLinksBovenY <= 180;
    PaletRechtsOnderY <= 300;
    PaletRechtsBovenY <= 180;
    ScoreLinks <= 0;
    ScoreRechts <= 0;
    TellerGeraakt <= 0;
else
    if BTNL = '1' and BTND = '0' and PaletLinksBovenY > 11 then
        PaletLinksBovenY <= PaletLinksBovenY - 1;
        PaletLinksOnderY <= PaletLinksOnderY - 1;
    elsif BTND = '1' and BTNL = '0' and PaletLinksOnderY < 469 then
        PaletLinksBovenY <= PaletLinksBovenY + 1;
        PaletLinksOnderY <= PaletLinksOnderY + 1;
    else
        PaletLinksBovenY <= PaletLinksBovenY;
        PaletLinksOnderY <= PaletLinksOnderY;
    end if;
    if BTNU = '1' and BTNR = '0' and PaletRechtsBovenY > 11 then
        PaletRechtsBovenY <= PaletRechtsBovenY - 1;
        PaletRechtsOnderY <= PaletRechtsOnderY - 1;
    elsif BTNR = '1' and BTNU = '0' and PaletRechtsOnderY < 469 then
        PaletRechtsBovenY <= PaletRechtsBovenY + 1;
        PaletRechtsOnderY <= PaletRechtsOnderY + 1;
    else
        PaletRechtsBovenY <= PaletRechtsBovenY;
        PaletRechtsOnderY <= PaletRechtsOnderY;
    end if;
    if BalLinks = 35 and BalBoven <= PaletLinksOnderY and BalOnder >= PaletLinksBovenY then 
        BalLinks <= BalLinks + (-1 * directionX);
        BalRechts <= BalRechts + (-1 * directionX);
        directionX <= -1 * directionX;
        TellerGeraakt <= TellerGeraakt + 1;
    elsif BalRechts = 605 and BalBoven <= PaletRechtsOnderY and BalOnder >= PaletRechtsBovenY then 
        BalLinks <= BalLinks + (-1 * directionX);
        BalRechts <= BalRechts + (-1 * directionX); 
        directionX <= -1 * directionX;
        TellerGeraakt <= TellerGeraakt + 1;
    else 
        BalLinks <= BalLinks + directionX;
        BalRechts <= BalRechts + directionX;
    end if;
    if BalBoven = 10 or BalOnder = 470 then 
        BalBoven <= BalBoven + (-1 * directionY);
        BalOnder <= BalOnder + (-1 * directionY);
        directionY <= -1 * directionY;
    else 
        BalBoven <= BalBoven + directionY;
        BalOnder <= BalOnder + directionY;
    end if;
    if BalLinks = 10 then 
        BalLinks <= 315; 
        BalRechts <= 325;
        BalBoven <= 235;
        BalOnder <= 245;
        directionY <= -1 * directionY;
        ScoreRechts <= ScoreRechts + 1;
        TellerGeraakt <= 0;
    elsif BalRechts = 630 then
        BalLinks <= 315; 
        BalRechts <= 325;
        BalBoven <= 235;
        BalOnder <= 245;
        directionY <= -1 * directionY;
        ScoreLinks <= ScoreLinks + 1;
        TellerGeraakt <= 0;
    end if;
end if;
end if;
end process;

pTonen: process (PaletLinksBovenY, PaletLinksOnderY, PaletRechtsBovenY, PaletRechtsOnderY, VCounter, HCounter, DipKleur, DipRood, DipGroen, DipBlauw, BalBoven, BalOnder, BalLinks, BalRechts)
begin
if VCounter >= BalBoven and VCounter <= BalOnder and HCounter <= BalRechts and HCounter >= BalLinks then
    if DipKleur = "1" then
        Rood <= DipRood;
        Groen <= DipGroen;
        Blauw <= DipBlauw;
    else
        Rood <= "0000";
        Groen <= "0000";
        Blauw <= "1111";
    end if;
elsif VCounter >= PaletLinksBovenY and VCounter <= PaletLinksOnderY and HCounter <= 35 and HCounter >= 15 then
    if DipKleur = "1" then
        Rood <= DipRood;
        Groen <= DipGroen;
        Blauw <= DipBlauw;
    else
        Rood <= "1111";
        Groen <= "0000";
        Blauw <= "0000";
    end if;
elsif VCounter <= PaletRechtsOnderY and VCounter >= PaletRechtsBovenY and HCounter <= 625 and HCounter >= 605 then
    if DipKleur = "1" then
        Rood <= DipRood;
        Groen <= DipGroen;
        Blauw <= DipBlauw;
    else
        Rood <= "1111";
        Groen <= "0000";
        Blauw <= "0000";
    end if;
elsif HCounter <= 640 and (VCounter <= 10 or (VCounter >= 470 and VCounter <= 480)) then
    if DipKleur = "1" then
        Rood <= DipRood;
        Groen <= DipGroen;
        Blauw <= DipBlauw;
    else
        Rood <= "0000";
        Groen <= "1111";
        Blauw <= "0000";
    end if;
elsif VCounter <= 480 and (HCounter <= 10 or (HCounter >= 630 and HCounter <= 640)) then
    if DipKleur = "1" then
        Rood <= DipRood;
        Groen <= DipGroen;
        Blauw <= DipBlauw;
    else
        Rood <= "0000";
        Groen <= "1111";
        Blauw <= "0000";
    end if;
elsif VCounter <= 480 and (HCounter >= 315 and HCounter <= 325) then
    if DipKleur = "1" then
        Rood <= DipRood;
        Groen <= DipGroen;
        Blauw <= DipBlauw;
    else
        Rood <= "0000";
        Groen <= "1111";
        Blauw <= "0000";
    end if;
else 
    Rood <= "0000";
    Groen <= "0000";
    Blauw <= "0000";
end if;
end process;

pHSVS: process (HCounter, VCounter)
begin
if VCounter >= 490 and VCounter < 492 then
    VS <= '0';
else
    VS <= '1';
end if;
if HCounter >= 656 and HCounter < 752 then
    HS <= '0';
else
    HS <= '1';
end if;
end process;
end Behavioral;
