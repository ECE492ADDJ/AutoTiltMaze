-- Dominic Trottier
-- dktrotti@ualberta.ca
-- This file is based on "niosII_microc_lab1.vhd" by Nancy Minderman (nancy.minderman@ualberta.ca)
-- This file makes extensive use of Altera template structures.
-- This file is the top-level file for ECE 492 W2017 Group 1


-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

	-- Basic sequential functions and concurrent procedures
	use ieee.VITAL_Primitives.all;
	
	use work.DE2_CONSTANTS.all;
	
	entity niosII_microc_tiltmaze is
	
	port
	(
		-- Input ports and 50 MHz Clock
		KEY		: in  std_logic_vector (0 downto 0);
		SW			: in 	std_logic_vector (7 downto 0);
		CLOCK_50	: in  std_logic;
		
		-- Green leds on board
		LEDG		: out std_logic_vector (7 downto 0);
		
		-- LCD on board
		LCD_BLON	: out std_logic;
		LCD_ON	: out std_logic;
		LCD_DATA	: inout std_logic_vector (7 downto 0);
		LCD_RS	: out std_logic;
		LCD_EN	: out std_logic;
		LCD_RW	: out std_logic;
		
		-- SDRAM on board
		DRAM_ADDR	:	out 	std_logic_vector (11 downto 0);
		--DRAM_ADDR	:	out	DE2_SDRAM_ADDR_BUS;
		DRAM_BA_0	: 	out	std_logic;
		DRAM_BA_1	:	out	std_logic;
		DRAM_CAS_N	:	out	std_logic;
		DRAM_CKE		:	out	std_logic;
		DRAM_CLK		:	out	std_logic;
		DRAM_CS_N	:	out	std_logic;
		DRAM_DQ		:	inout std_logic_vector (15 downto 0);
		--DRAM_DQ		:	inout DE2_SDRAM_DATA_BUS;
		DRAM_LDQM	: 	out	std_logic;
		DRAM_UDQM	: 	out	std_logic;
		DRAM_RAS_N	: 	out	std_logic;
		DRAM_WE_N	: 	out 	std_logic;

		-- SRAM on board
		
		SRAM_ADDR	:	out	std_logic_vector (17 downto 0);
		SRAM_DQ		:	inout std_logic_vector (15 downto 0);
		SRAM_WE_N	:	out	std_logic;
		SRAM_OE_N	:	out	std_logic;
		SRAM_UB_N	:	out 	std_logic;
		SRAM_LB_N	:	out	std_logic;
		SRAM_CE_N	:	out	std_logic;
		
		-- UART
		
		UART_RXD 	: in	std_logic;
		UART_TXD		: out std_logic;
		
		-- Flash
		
		FL_ADDR		: out std_logic_vector(21 downto 0);
		FL_CE_N		: out	std_logic_vector(0 downto 0);
		FL_OE_N		: out std_logic_vector(0 downto 0);
		FL_DQ			: inout std_logic_vector(7 downto 0);
		FL_RST_N		: out std_logic_vector(0 downto 0);
		FL_WE_N		: out std_logic_vector(0 downto 0)
		
	);
end niosII_microc_tiltmaze;


architecture structure of niosII_microc_tiltmaze is

	-- Declarations (optional)
	
    component niosII_system is
        port (
            clk_clk                                      : in    std_logic                     := 'X';             -- clk
            reset_reset_n                                : in    std_logic                     := 'X';             -- reset_n
            character_lcd_0_external_interface_DATA      : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- DATA
            character_lcd_0_external_interface_ON        : out   std_logic;                                        -- ON
            character_lcd_0_external_interface_BLON      : out   std_logic;                                        -- BLON
            character_lcd_0_external_interface_EN        : out   std_logic;                                        -- EN
            character_lcd_0_external_interface_RS        : out   std_logic;                                        -- RS
            character_lcd_0_external_interface_RW        : out   std_logic;                                        -- RW
            green_leds_external_connection_export        : out   std_logic_vector(7 downto 0);                     -- export
            on_board_switches_external_connection_export : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
            altpll_0_c0_clk                              : out   std_logic;                                        -- clk
            sdram_0_wire_addr                            : out   std_logic_vector(11 downto 0);                    -- addr
            sdram_0_wire_ba                              : out   std_logic_vector(1 downto 0);                     -- ba
            sdram_0_wire_cas_n                           : out   std_logic;                                        -- cas_n
            sdram_0_wire_cke                             : out   std_logic;                                        -- cke
            sdram_0_wire_cs_n                            : out   std_logic;                                        -- cs_n
            sdram_0_wire_dq                              : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            sdram_0_wire_dqm                             : out   std_logic_vector(1 downto 0);                     -- dqm
            sdram_0_wire_ras_n                           : out   std_logic;                                        -- ras_n
            sdram_0_wire_we_n                            : out   std_logic;                                        -- we_n
            sram_0_external_interface_DQ                 : inout std_logic_vector(15 downto 0) := (others => 'X'); -- DQ
            sram_0_external_interface_ADDR               : out   std_logic_vector(17 downto 0);                    -- ADDR
            sram_0_external_interface_LB_N               : out   std_logic;                                        -- LB_N
            sram_0_external_interface_UB_N               : out   std_logic;                                        -- UB_N
            sram_0_external_interface_CE_N               : out   std_logic;                                        -- CE_N
            sram_0_external_interface_OE_N               : out   std_logic;                                        -- OE_N
            sram_0_external_interface_WE_N               : out   std_logic;				-- WE_N
            rs232_0_external_interface_RXD               : in    std_logic                     := 'X';             -- rxd
            rs232_0_external_interface_TXD               : out   std_logic;                                        -- txd
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_read_n_out        : out   std_logic_vector(0 downto 0);                     -- generic_tristate_controller_0_tcm_read_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_data_out          : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- generic_tristate_controller_0_tcm_data_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_chipselect_n_out  : out   std_logic_vector(0 downto 0);                     -- generic_tristate_controller_0_tcm_chipselect_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_write_n_out       : out   std_logic_vector(0 downto 0);                     -- generic_tristate_controller_0_tcm_write_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_address_out       : out   std_logic_vector(21 downto 0)                     -- generic_tristate_controller_0_tcm_address_out
			);
    end component niosII_system;

--	These signals are for matching the provided IP core to
-- The specific SDRAM chip in our system	 
	 signal BA	: std_logic_vector (1 downto 0);
	 signal DQM	:	std_logic_vector (1 downto 0);
	 

begin

	DRAM_BA_1 <= BA(1);
	DRAM_BA_0 <= BA(0);
	
	DRAM_UDQM <= DQM(1);
	DRAM_LDQM <= DQM(0);
	
	FL_RST_N <= "1";
	
	-- Component Instantiation Statement (optional)
    u0 : component niosII_system
        port map (
            clk_clk                                      => CLOCK_50,
            reset_reset_n                                => KEY(0),				
            character_lcd_0_external_interface_DATA 		=> LCD_DATA, 
            character_lcd_0_external_interface_ON   		=> LCD_ON,   
            character_lcd_0_external_interface_BLON 		=> LCD_BLON, 
            character_lcd_0_external_interface_EN   		=> LCD_EN,   
            character_lcd_0_external_interface_RS   		=> LCD_RS,   
            character_lcd_0_external_interface_RW   		=> LCD_RW,
            green_leds_external_connection_export        => LEDG,
            on_board_switches_external_connection_export => SW,
            altpll_0_c0_clk                              => DRAM_CLK,
            sdram_0_wire_addr                       		=> DRAM_ADDR,                      
            sdram_0_wire_ba                         		=> BA,                        
            sdram_0_wire_cas_n                      		=> DRAM_CAS_N,                      
            sdram_0_wire_cke                        		=> DRAM_CKE,                       
            sdram_0_wire_cs_n                       		=> DRAM_CS_N,                      
            sdram_0_wire_dq                         		=> DRAM_DQ,                         
            sdram_0_wire_dqm                        		=> DQM,                        
            sdram_0_wire_ras_n                      		=> DRAM_RAS_N,                     
            sdram_0_wire_we_n                       		=> DRAM_WE_N,
            sram_0_external_interface_DQ            		=> SRAM_DQ,           
            sram_0_external_interface_ADDR          		=> SRAM_ADDR,          
            sram_0_external_interface_LB_N          		=> SRAM_LB_N,         
            sram_0_external_interface_UB_N          		=> SRAM_UB_N,          
            sram_0_external_interface_CE_N          		=> SRAM_CE_N,         
            sram_0_external_interface_OE_N          		=> SRAM_OE_N,         
            sram_0_external_interface_WE_N          		=> SRAM_WE_N,
				rs232_0_external_interface_RXD               => UART_RXD,               --            uart_0_external_connection.rxd
            rs232_0_external_interface_TXD               => UART_TXD,               --                                      .txd
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_read_n_out        => FL_OE_N,        --         tristate_conduit_bridge_0_out.generic_tristate_controller_0_tcm_read_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_data_out          => FL_DQ,          --                                      .generic_tristate_controller_0_tcm_data_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_chipselect_n_out  => FL_CE_N,  --                                      .generic_tristate_controller_0_tcm_chipselect_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_write_n_out       => FL_WE_N,       --                                    .generic_tristate_controller_0_tcm_begintransfer_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_address_out       => FL_ADDR       --                                      .generic_tristate_controller_0_tcm_address_out
			);

end structure;