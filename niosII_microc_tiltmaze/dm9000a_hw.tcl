# TCL File Generated by Component Editor 12.1sp1
# Wed Feb 01 16:32:56 MST 2017
# DO NOT MODIFY


# 
# dm9000a "DM9000a series ethernet" v7.2
# null 2017.02.01.16:32:56
# 
# 

# 
# request TCL package from ACDS 12.1
# 
package require -exact qsys 12.1


# 
# module dm9000a
# 
set_module_property DESCRIPTION ""
set_module_property NAME dm9000a
set_module_property VERSION 7.2
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Ethernet
set_module_property DISPLAY_NAME "DM9000a series ethernet"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL dm9000a
set_fileset_property quartus_synth ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file dm9000a.vhd VHDL PATH dm9000a.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true

add_interface_port clock clock clk Input 1


# 
# connection point clock_reset
# 
add_interface clock_reset reset end
set_interface_property clock_reset associatedClock clock
set_interface_property clock_reset synchronousEdges DEASSERT
set_interface_property clock_reset ENABLED true

add_interface_port clock_reset iRST_N reset_n Input 1


# 
# connection point export_0
# 
add_interface export_0 conduit end
set_interface_property export_0 associatedClock clock
set_interface_property export_0 associatedReset clock_reset
set_interface_property export_0 ENABLED true

add_interface_port export_0 ENET_DATA export Bidir 16
add_interface_port export_0 ENET_CMD export Output 1
add_interface_port export_0 ENET_RD_N export Output 1
add_interface_port export_0 ENET_WR_N export Output 1
add_interface_port export_0 ENET_CS_N export Output 1
add_interface_port export_0 ENET_RST_N export Output 1
add_interface_port export_0 ENET_INT export Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressAlignment NATIVE
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset clock_reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true

add_interface_port avalon_slave_0 iCMD address Input 1
add_interface_port avalon_slave_0 iRD_N read_n Input 1
add_interface_port avalon_slave_0 iWR_N write_n Input 1
add_interface_port avalon_slave_0 iDATA writedata Input 16
add_interface_port avalon_slave_0 oDATA readdata Output 16
add_interface_port avalon_slave_0 iCS_N chipselect_n Input 1
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point interrupt_sender
# 
add_interface interrupt_sender interrupt end
set_interface_property interrupt_sender associatedAddressablePoint avalon_slave_0
set_interface_property interrupt_sender associatedClock clock
set_interface_property interrupt_sender associatedReset clock_reset
set_interface_property interrupt_sender ENABLED true

add_interface_port interrupt_sender oINT irq Output 1

