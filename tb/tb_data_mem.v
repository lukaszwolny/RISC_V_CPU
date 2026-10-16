`timescale 1ns/1ps

module tb_data_mem;

    reg         clk;
    reg         i_write_en;
    reg  [2:0]  i_funct3;
    reg  [31:0] i_address, i_data;

    wire [31:0] o_data;

    data_mem u_data_mem (
        .i_clk(clk),    
        .i_address(i_address),  
        .i_data(i_data),   
        .i_write_en(i_write_en), 
        .i_funct3(i_funct3),
        .o_data(o_data)
    );

    initial clk = 1;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_data_mem.vcd");
        $dumpvars(0, tb_data_mem);

        // ===================================================
        i_write_en = 0;
        i_funct3 = 0;
        i_address = 0;
        i_data = 0;

        @(posedge clk);
        @(posedge clk);


        i_write_en = 1;
        i_funct3 = 0;
        i_address = 8;
        i_data = 32'h12345678;
        #1;

        @(posedge clk);

        i_write_en = 1;
        i_funct3 = 1;
        i_address = 48;
        i_data = 55;
        #1;

        @(posedge clk);

        i_write_en = 1;
        i_funct3 = 2;
        i_address = 52;
        i_data = 32'h12345689;
        #1;

        @(posedge clk); // read 

        i_write_en = 0;
        i_funct3 = 0;
        i_address = 0;
    
        @(posedge clk); // read 

        i_write_en = 0;
        i_funct3 = 0;
        i_address = 52;

        @(posedge clk); // read 

        i_write_en = 0;
        i_funct3 = 1;
        i_address = 52;

        @(posedge clk); // read 

        i_write_en = 0;
        i_funct3 = 2;
        i_address = 52;

        @(posedge clk); // read 

        i_write_en = 0;
        i_funct3 = 4;
        i_address = 52;

        @(posedge clk); // read 

        i_write_en = 0;
        i_funct3 = 5;
        i_address = 52;

        @(posedge clk); // read 

        i_write_en = 0;
        i_funct3 = 0;
        i_address = 52;

        @(posedge clk); // read 

        i_write_en = 0;
        i_funct3 = 0;
        i_address = 52;

        //============================
        @(posedge clk);

        i_write_en = 1;
        i_funct3 = 1;
        i_address = 100;
        i_data = 32'hFF00FF00;
        
        
        @(posedge clk);

        i_write_en = 0;
        i_funct3 = 2;
        i_address = 100;

        //============================
        @(posedge clk);

        i_write_en = 0;
        i_funct3 = 2;
        i_address = 52;

        @(posedge clk);
        #1;
        i_write_en = 1;
        i_funct3 = 2;
        i_address = 104;
        i_data = 32'hFF55FF55;
        
        @(posedge clk);
        #1;

        i_write_en = 0;
        i_funct3 = 2;
        i_address = 104;
        

        #1000
        $finish;
    end

endmodule
