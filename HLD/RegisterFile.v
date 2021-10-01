//! Register file. Synchronous write. Asynchronous read.
module RegisterFile(
    input           clk,
    input           rst,    //! High level synchronous reset
    input [31:0]    WriteData,
    input [4:0]     WriteDir,
    input           WriteEn,
    output [31:0]    ReadData1,
    output [31:0]    ReadData2,
    input [4:0]     ReadDir1,
    input [4:0]     ReadDir2
);


reg [31:0]  bank [31:0];    //! Internal memory state of the registers
integer i;  //! Index to reset *multidimensional* bank

//! Write the register bank (except zero) if enabled
always @(posedge clk) begin : WriteBank
    if (rst == 0) begin
        if (WriteEn) begin
            if(WriteDir!=0)begin
                bank[WriteDir] <= WriteData;
            end 
        end
    else
        for (i=0; i<8; i++)
        begin
            bank[i] <= 0;
        end
    end
end

//Read
assign ReadData1 = bank[ReadDir1];
assign ReadData2 = bank[ReadDir2];

endmodule