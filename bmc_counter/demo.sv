module demo (
  input clk,
  output [5:0] counter
);
  logic [5:0] counter = 0;

  always @(posedge clk) begin
    if (counter == 15)
      counter <= 0;
    else
      counter <= counter + 1;
  end

`ifdef FORMAL
  always @(posedge clk) begin
    assert (counter < 10);
  end
`endif
endmodule // demo
/*
module demo
  ( input wire clk,
    input wire         rstf,
    output wire [5:0] cnt
    );
   
   logic [5:0]   counter = 0;

   assign cnt = counter;
   

   always @(posedge clk) begin
      if(~rstf) begin
         counter <= 0;
      end
      else begin
         if(counter == 15)
           counter <= 0;
         else
           counter <= counter + 1;
      end
   end

`ifdef FORMAL
   always @(posedge clk) begin
      assert(cnt < 6);
   end

   initial  begin
      //assume(!rstf);
      assume(counter == 0);
      //#2;
      
      //assume(rstf);
      
   end
   
`endif
endmodule

*/
