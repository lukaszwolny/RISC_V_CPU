`timescale 1ns/1ps

module tb_cpu;

    reg         clk, rst;
reg [31:0] result;
    single_cycle_cpu u_cpu(
        .i_clk(clk),           
        .i_rst(rst)          
    );
integer i;
    initial clk = 1;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_cpu.vcd");
        $dumpvars(0, tb_cpu);
        rst = 0;

        // ===================================================
        
        repeat(2) @(posedge clk);
        rst = 1;

    
        // (9 instructions × loop 5 times + setup = ~30 cycles)
        repeat(50) @(posedge clk);
        #1;

        // Check: memory address 0 should contain 15 (sum 1..5)
        // DMEM is byte-addressed; word at addr 0 = bytes [3:0]
   
            
        result = {u_cpu.u_data_mem.mem_data[3], u_cpu.u_data_mem.mem_data[2],
                    u_cpu.u_data_mem.mem_data[1], u_cpu.u_data_mem.mem_data[0]};
        if (result === 32'd15)
            $display("PASS: sum(1..5) = %0d stored at mem[0]", result);
        else
            $display("FAIL: mem[0] = %0d (expected 15)", result);
       

        // Bonus: dump register file
        $display("--- Register File Snapshot ---");
        for (i = 0; i < 8; i = i+1)
            $display("  x%0d = %0d", i, u_cpu.u_datapath.u_reg_file.reg_file[i]);
        $finish;
    end

endmodule
