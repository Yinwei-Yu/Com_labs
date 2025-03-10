vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/dist_mem_gen_v8_0_12

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap dist_mem_gen_v8_0_12 activehdl/dist_mem_gen_v8_0_12

vlog -work xil_defaultlib  -sv2k12 \
"E:/StudyApps/Vivado_2018_3/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"E:/StudyApps/Vivado_2018_3/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work dist_mem_gen_v8_0_12  -v2k5 \
"../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../5-level-pipeline.srcs/sources_1/ip/ROM_D/sim/ROM_D.v" \


vlog -work xil_defaultlib \
"glbl.v"

