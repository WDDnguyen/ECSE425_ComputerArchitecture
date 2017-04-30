proc AddWaves {} {
#TODO
	;#Add waves we're interested in to the Wave window
    add wave -position end sim:/fsm_tb/clk
    add wave -position end sim:/fsm_tb/s_reset
    add wave -position end sim:/fsm_tb/s_input
    add wave -position end sim:/fsm_tb/s_output
}

vlib work

;# Compile components if any
vcom alu.vhd
vcom controller.vhd
vcom cpuPipeline.vhd
vcom cpuPipeline_tb.vhd
vcom instructionFetchStage.vhd
vcom instructionMemory.vhd
vcom mem.vhd
vcom memory.vhd
vcom mux.vhd
vcom PC.vhd
vcom register_file.vhd
vcom signextender.vhd
vcom wb.vhd
vcom zero.vhd

;# Start simulation
vsim cpuPipeline_tb

;# Generate a clock with 1ns period
force -deposit clk 0 0 ns, 1 0.5 ns -repeat 1 ns

;# Add the waves
AddWaves

;# Run for 50 ns
run 100ns
