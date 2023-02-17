`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/09 12:22:03
// Design Name: 补码乘法器单元
// Module Name: booth
// Project Name: 
// Target Devices: ZYNQ
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module booth(
    input[2:0]          mult_1,
    input[7:0]         mult_2,

    input[15:0]         mult_pre,
    
    input               clk,
    input               rst_n,
    input               en,

    output reg          rdy,
    output reg[15:0]    mult_next
);

	wire[7:0]	bmul_2;
	assign bmul_2 = (~mult_2 + 1'b1);

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        mult_next <= 0;
        rdy <= 0;
    end
    else if(en) begin
        rdy <= 1;
        case({mult_1[2], mult_1[1], mult_1[0]})
        	3'b000:begin
        		mult_next <=  mult_pre;
        	end
        	3'b001:begin
        		mult_next <=  mult_pre + ({{8{mult_2[7]}},mult_2});
        	end
        	3'b010:begin
        		mult_next <=  mult_pre + ({{8{mult_2[7]}},mult_2});
        	end
        	3'b011:begin
        		mult_next <=  mult_pre + ({{8{mult_2[7]}},mult_2} << 1);
        	end
        	3'b100:begin
        		mult_next <=  mult_pre + ({{8{bmul_2[7]}},bmul_2} << 1'b1);
        	end
        	3'b101:begin
        		mult_next <=  mult_pre + ({{8{bmul_2[7]}},bmul_2});
        	end   
        	3'b110:begin
        		mult_next <=  mult_pre + ({{8{bmul_2[7]}},bmul_2});
        	end
        	3'b111:begin
        		mult_next <=  mult_pre;
        	end
        endcase
    end
    else begin
        mult_next <= 0;
        rdy <= 0;
    end
end

endmodule