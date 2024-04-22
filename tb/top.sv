module top();

import uvm_pkg::*;
import test_pkg::*;
`include "uvm_macros.svh"

 bit clock;
 always #5 clock = ~clock;

 ahb_if in1(clock);
 apb_if in2(clock);

  rtl_top DUT(  .Hclk(clock),
                .Hresetn(in1.Hresetn),
                .Htrans(in1.Htrans),
		.Hsize(in1.Hsize), 
		.Hreadyin(in1.Hreadyin),
		.Hwdata(in1.Hwdata), 
		.Haddr(in1.Haddr),
		.Hwrite(in1.Hwrite),
                .Prdata(in2.Prdata),
		.Hrdata(in1.Hrdata),
		.Hresp(in1.Hresp),
		.Hreadyout(in1.Hreadyout),
		.Pselx(in2.Pselx),
		.Pwrite(in2.Pwrite),
		.Penable(in2.Penable), 
		.Paddr(in2.Paddr),
		.Pwdata(in2.Pwdata)
		    ) ;	

 initial 
  begin
  uvm_config_db#(virtual ahb_if)::set(null,"*","vif1", in1);
  uvm_config_db#(virtual apb_if)::set(null,"*","vif2", in2);

   run_test();
  end

endmodule


