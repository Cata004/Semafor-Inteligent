library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_fsm is
  Port (
    clk  : in  std_logic;
    rst  : in  std_logic;
    leds : out std_logic_vector(3 downto 0)
  );
end traffic_fsm;

architecture Behavioral of traffic_fsm is
  signal state : std_logic_vector(1 downto 0);
begin


  process(clk, rst)
  begin
    if rst = '1' then
      state <= "00";             
    elsif rising_edge(clk) then
      case state is
        when "00" => state <= "01"; 
        when "01" => state <= "10";  
        when "10" => state <= "11";  
        when others => state <= "00";
      end case;
    end if;
  end process;

 
  with state select
    leds <= "1000" when "00", 
            "0100" when "01",  
            "0010" when "10",  
            "0001" when others;

end Behavioral;
