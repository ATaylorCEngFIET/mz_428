set outputDir ./nonprojectflow
file mkdir $outputDir

read_vhdl ../led_fsm.vhd
read_xdc ../io.xdc

synth_design -top led_fsm -part xc7s50csga324-1
write_checkpoint -force $outputDir/post_synth.dcp
report_utilization -file $outputDir/post_synth_util.rpt

opt_design
place_design
write_checkpoint -force $outputDir/post_place.dcp
route_design
write_checkpoint -force $outputDir/post_route.dcp
write_bitstream -force $outputDir/led.bit
