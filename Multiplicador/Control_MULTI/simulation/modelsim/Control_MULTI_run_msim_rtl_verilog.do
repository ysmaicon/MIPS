transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ysmai/Desktop/MIPS/Multiplicador/Control_MULTI {C:/Users/ysmai/Desktop/MIPS/Multiplicador/Control_MULTI/Control_MULTI.v}

vlog -vlog01compat -work work +incdir+C:/Users/ysmai/Desktop/MIPS/Multiplicador/Control_MULTI {C:/Users/ysmai/Desktop/MIPS/Multiplicador/Control_MULTI/Control_MULTI_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  Control_MULTI_TB

add wave *
view structure
view signals
run -all
