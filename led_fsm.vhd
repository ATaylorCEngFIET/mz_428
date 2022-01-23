library ieee;
use ieee.std_logic_1164.all;

entity led_fsm is port(
    clk : in std_logic;
    enable : in std_logic; 
    sw_in : in std_logic_vector(2 downto 0);
    enb_led : out std_logic;
    led_enb : out std_logic_vector(2 downto 0)
);
end entity; 

architecture rtl of led_fsm is

    type fsm is (idle, enab);
    signal current_state : fsm := idle;

begin

    fsm_proc : process(clk)
    begin
        if rising_edge(clk) then 
            case current_state is  
                when idle => 
                    enb_led <= '0';
                    led_enb <= (others=>'0');
                    if enable = '1' then 
                        current_state <= enab;
                    end if;
                when enab =>
                    enb_led <= '1';
                    led_enb <= sw_in;
                    if enable = '0' then 
                        current_state <= idle;
                    end if;
                when others => null;
            end case;
        end if;
    end process;

end architecture; 