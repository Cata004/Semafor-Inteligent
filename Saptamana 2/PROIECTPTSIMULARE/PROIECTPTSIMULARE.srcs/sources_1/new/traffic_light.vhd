library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity traffic_light is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;

    ns_red    : out std_logic;
    ns_yellow : out std_logic;
    ns_green  : out std_logic;

    ew_red    : out std_logic;
    ew_yellow : out std_logic;
    ew_green  : out std_logic
  );
end traffic_light;

architecture rtl of traffic_light is

  type state_type is (S0, S1, S2, S3);
  signal state, next_state : state_type;

  signal counter : integer := 0;

  constant GREEN_TIME  : integer := 10;
  constant YELLOW_TIME : integer := 3;

begin

  -- FSM: stare + contor
  process(clk, rst)
  begin
    if rst = '1' then
      state   <= S0;
      counter <= 0;
    elsif rising_edge(clk) then
      if counter = 0 then
        state <= next_state;
      end if;

      if counter = 0 then
        case next_state is
          when S0 | S2 => counter <= GREEN_TIME;
          when S1 | S3 => counter <= YELLOW_TIME;
        end case;
      else
        counter <= counter - 1;
      end if;
    end if;
  end process;

  -- Next state logic
  process(state)
  begin
    case state is
      when S0 => next_state <= S1;
      when S1 => next_state <= S2;
      when S2 => next_state <= S3;
      when S3 => next_state <= S0;
    end case;
  end process;

  -- Output logic
  process(state)
  begin
    -- default OFF
    ns_red    <= '0';
    ns_yellow <= '0';
    ns_green  <= '0';
    ew_red    <= '0';
    ew_yellow <= '0';
    ew_green  <= '0';

    case state is
      when S0 =>
        ns_green <= '1';
        ew_red   <= '1';

      when S1 =>
        ns_yellow <= '1';
        ew_red    <= '1';

      when S2 =>
        ns_red   <= '1';
        ew_green <= '1';

      when S3 =>
        ns_red    <= '1';
        ew_yellow <= '1';
    end case;
  end process;

end rtl;
