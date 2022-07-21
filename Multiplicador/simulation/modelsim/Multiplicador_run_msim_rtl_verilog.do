transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ysmai/Desktop/MIPS/Multiplicador/Control_MULTI {C:/Users/ysmai/Desktop/MIPS/Multiplicador/Control_MULTI/Control_MULTI.v}
vlog -vlog01compat -work work +incdir+C:/Users/ysmai/Desktop/MIPS/Multiplicador {C:/Users/ysmai/Desktop/MIPS/Multiplicador/Multiplicador.v}
vlog -vlog01compat -work work +incdir+C:/Users/ysmai/Desktop/MIPS/Multiplicador/ACC {C:/Users/ysmai/Desktop/MIPS/Multiplicador/ACC/ACC.v}
vlog -vlog01compat -work work +incdir+C:/Users/ysmai/Desktop/MIPS/Multiplicador/Adder {C:/Users/ysmai/Desktop/MIPS/Multiplicador/Adder/Adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/ysmai/Desktop/MIPS/Multiplicador/Counter {C:/Users/ysmai/Desktop/MIPS/Multiplicador/Counter/Counter.v}

vlog -vlog01compat -work work +incdir+C:/Users/ysmai/Desktop/MIPS/Multiplicador {C:/Users/ysmai/Desktop/MIPS/Multiplicador/Multiplicador_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  Multiplicador_TB

add wave *
view structure
view signals
run -all
