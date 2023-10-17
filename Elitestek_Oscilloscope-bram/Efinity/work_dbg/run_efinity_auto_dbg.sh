python.exe  -m "efx_dbg.DbgWizard" --device  "T35F324" --family  "Trion" --in_profile_name  "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/debug_profile.wizard.json" --out_dbg_vdb  "debug_top.post.vdb" --out_profile_name  "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/debug_profile.wizard.json" --out_dir  "work_dbg"
efx_map  --mode "speed" --max_ram "-1" --max_mult "-1" --infer-clk-enable "3" --infer-sync-set-reset "1" --fanout-limit "100" --seq_opt "0" --bram_output_regs_packing "1" --retiming "0" --blast_const_operand_adders "1" --mult_input_regs_packing "1" --mult_output_regs_packing "1" --operator-sharing "0" --optimize-adder-tree "0" --min-sr-fanout "0" --seq-opt-sync-only "0" --blackbox-error "1" --allow-const-ram-index "0" --hdl-compile-unit "1" --create-onehot-fsms "0" --min-ce-fanout "0" --mult-decomp-retime "0" --optimize-zero-init-rom "1" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/etx_ddr3_reset_controller" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/R0_FIFO" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/W0_FIFO" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/WAVE_BUF_FIFO" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/WAVE_MAPPING_RAM" --family "Trion" --device "T35F324" --root "edb_top" --v "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/work_dbg/debug_top.v" --write-postmap-module "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/work_dbg/debug_top.post.vdb" --generate_sig_profile "false" --work-dir "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/work_dbg" --output-dir "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/outflow"
efx_map  --family "Trion" --device "T35F324" --mode "speed" --max_ram "-1" --max_mult "-1" --infer-clk-enable "3" --infer-sync-set-reset "1" --fanout-limit "100" --seq_opt "0" --bram_output_regs_packing "1" --retiming "0" --blast_const_operand_adders "1" --mult_input_regs_packing "1" --mult_output_regs_packing "1" --operator-sharing "0" --optimize-adder-tree "0" --min-sr-fanout "0" --seq-opt-sync-only "0" --blackbox-error "1" --allow-const-ram-index "0" --hdl-compile-unit "1" --create-onehot-fsms "0" --min-ce-fanout "0" --mult-decomp-retime "0" --optimize-zero-init-rom "1" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/etx_ddr3_reset_controller" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/R0_FIFO" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/W0_FIFO" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/WAVE_BUF_FIFO" --I "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/ip/WAVE_MAPPING_RAM" --root "OscilloscopeInterfaceTest" --vdb "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/outflow/OscilloscopeInterfaceTest.elab.vdb" --vdb "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/work_dbg/debug_top.post.vdb" --write-efx-verilog "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/work_dbg/OscilloscopeInterfaceTest.dbg.map.v" --binary-db "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/work_dbg/OscilloscopeInterfaceTest.dbg.vdb" --merge_vdbs=1 --conn "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/debug_profile.wizard.json" --generate_sig_profile "false" --work-dir "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/work_dbg" --output-dir "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/outflow"
python.exe  "D:/Tools/Efinity/scripts/efx_pt_jtag_util.py" --device "T35F324" --project "OscilloscopeInterfaceTest" --design_file "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/OscilloscopeInterfaceTest.peri.xml" --action "add" --jtag_user "JTAG_USER1" --output "D:/LearningMaterials/FPGA_Competition/VF-T35F324_Board_HDK_Info_V1.51/06_FPGA_Examples_Image/OscilloscopeInterface/Efinity/OscilloscopeInterfaceTest.dbg.peri.xml"
python 
