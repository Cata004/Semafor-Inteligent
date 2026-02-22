library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_light_tb is
end traffic_light_tb;

architecture sim of traffic_light_tb is

  signal clk, rst : std_logic := '0';

  signal ns_red, ns_yellow, ns_green : std_logic;
  signal ew_red, ew_yellow, ew_green : std_logic;

begin

  uut: entity work.traffic_light
    port map (
      clk => clk,
      rst => rst,

      ns_red => ns_red,
      ns_yellow => ns_yellow,
      ns_green => ns_green,

      ew_red => ew_red,
      ew_yellow => ew_yellow,
      ew_green => ew_green
    );

  -- clock: 10 ns
  clk_process : process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;

  -- reset
  process
  begin
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait;
  end process;

end sim;
