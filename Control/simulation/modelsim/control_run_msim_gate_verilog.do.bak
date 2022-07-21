transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {control_7_1200mv_100c_slow.vo}

vlog -vlog01compat -work work +incdir+D:/QuartusLite/Projeto\ de\ Sistemas\ Digitais/MIPS_CPU/Control {D:/QuartusLite/Projeto de Sistemas Digitais/MIPS_CPU/Control/control_TB.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_mf_ver -L altera_ver -L lpm_ver -L sgate_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L gate_work -L work -voptargs="+acc"  control_TB

add wave *
view structure
view signals
run -all
