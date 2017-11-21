# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {HDL-1065} -limit 10000
create_project -in_memory -part xcku040-ffva1156-2-e

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/yamaguchi/koara/koara.cache/wt [current_project]
set_property parent.project_path /home/yamaguchi/koara/koara.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part xilinx.com:kcu105:part0:1.1 [current_project]
set_property ip_output_repo /home/yamaguchi/koara/koara.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib /home/yamaguchi/CPU-Adelie/core/src/core_top.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}

synth_design -top core_top -part xcku040-ffva1156-2-e


write_checkpoint -force -noxdef core_top.dcp

catch { report_utilization -file core_top_utilization_synth.rpt -pb core_top_utilization_synth.pb }
