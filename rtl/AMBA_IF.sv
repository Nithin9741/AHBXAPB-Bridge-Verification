interface ahb_if(input bit clock);
	
	 	   
                   logic  	Hresetn;
                   logic  	[1:0]Htrans;
		   logic 	[2:0]Hsize;
		   logic        [2:0]Hburst;
		   logic 	Hreadyin;
		   logic 	[31:0]Hwdata; 
		   logic 	[31:0]Haddr;
		   logic 	Hwrite;
       		   logic 	[31:0]Hrdata;
		   logic 	[1:0]Hresp;
		   logic 	Hreadyout;

		clocking ahb_drv_cb@(posedge clock);
		   default input #1 output #1;
	   
                   output Hresetn;
                   output Htrans;
		   output Hsize;
		   output Hburst;  
		   output Hreadyin;
		   output Hwdata; 
		   output Haddr;
		   output Hwrite;
          	   input  Hresp;
		   input Hreadyout;
		endclocking
		
		clocking ahb_mon_cb@(posedge clock);
		   default input #1 output #1;
	
                   input Hresetn;
                   input Htrans;
		   input Hsize;
		   input Hburst;  
		   input Hreadyin;
		   input Hwdata; 
		   input Haddr;
		   input Hwrite;
       		   input Hrdata;
		   input Hresp;
		   input Hreadyout;
		endclocking
	  
	 modport AHB_DRV_MP(clocking ahb_drv_cb);
         modport AHB_MON_MP(clocking ahb_mon_cb);

endinterface

interface apb_if(input bit clock);

	  	   logic 	[3:0]Pselx;
		   logic  	Pwrite;
		   logic  	Penable; 
		   logic       [31:0] Paddr;
		   logic       [31:0] Pwdata;
 	   	   logic       [31:0] Prdata;

	     clocking apb_drv_cb@(posedge clock);
		default input #1 output #1;
		  input  Pwrite;
		  input Pselx;
	          output Prdata;
	     endclocking

	     clocking apb_mon_cb@(posedge clock);
		   default input #1 output #1;

		   input Pselx;
		   input Pwrite;
		   input Penable; 
		   input Paddr;
		   input Pwdata;
 	   	   input Prdata;
	      endclocking

          modport APB_DRV_MP(clocking apb_drv_cb);
          modport APB_MON_MP(clocking apb_mon_cb);

endinterface
