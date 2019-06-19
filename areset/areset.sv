module areset
  (input wire i_clk, i_areset_n,
   output reg o_reset
   );

   reg [1:0]  sync_fifo;

   initial sync_fifo = 2'h3;
   initial o_reset = 1'b1;


   always @(posedge i_clk or negedge i_areset_n)
     if(!i_areset_n)
       { o_reset, sync_fifo } <= 3'h7;
     else
       { o_reset, sync_fifo } <= {sync_fifo, 1'b0};

`ifdef FORMAL
   initial assume(!i_areset_n);


   always @(*)
     if(!i_areset_n)
       assert(o_reset);

   always @($global_clock)
     if($fell(o_reset))
       assert($rose(i_clk));

   always @(*)
     cover(!o_reset);

   always @(*)
     if(!o_reset)
       assert(sync_fifo == 2'b00);


   always @(*)
     assert(sync_fifo != 2'b01);

   always @(*)
     if(sync_fifo[1])
       assert(o_reset);

   always @(*)
     if(!i_areset_n)
       assert(sync_fifo == 2'b11);
`endif
   
endmodule
   
