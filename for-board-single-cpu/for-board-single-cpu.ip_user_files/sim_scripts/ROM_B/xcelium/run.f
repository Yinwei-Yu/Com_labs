-makelib xcelium_lib/xil_defaultlib -sv \
  "E:/StudyApps/Vivado_2018_3/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "E:/StudyApps/Vivado_2018_3/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_2 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../for-board-single-cpu.srcs/sources_1/ip/ROM_B/sim/ROM_B.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

