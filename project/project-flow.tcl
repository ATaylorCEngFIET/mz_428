set outputDir ./projectflow
file mkdir $outputDir

create_project project_flow_mz428 ./$outputDir -part xc7s50csga324-1 -force

add_files ../led_fsm.vhd
add_files -fileset constrs_1 ../io.xdc
import_files -force -norecurse
set_property top top [current_fileset]
update_compile_order -fileset sources_1

launch_runs synth_1
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
puts "Implementation done!"
set_param labtools.override_cs_server_version_check 1
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
set_property PROGRAM.FILE {C:/hdl_projects/scripting/project/outputDir/project_flow_mz428.runs/impl_1/led_fsm.bit} [get_hw_devices xc7s50_0]
current_hw_device [get_hw_devices xc7s50_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7s50_0] 0]
program_hw_devices [get_hw_devices xc7s50_0]