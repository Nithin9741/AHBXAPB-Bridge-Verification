class ahb_trans extends uvm_sequence_item;

	`uvm_object_utils(ahb_trans)

	function new(string name ="ahb_trans");
		super.new(name);
	endfunction


	rand bit HRESETn;
	rand bit[31:0] HADDR;
	rand bit[1:0] HTRANS;
	rand bit HWRITE;
	rand bit[2:0] HSIZE;
	rand bit[2:0] HBURST;
	rand bit[31:0] HWDATA;
	rand bit HREADYIN;
	rand int length;
	logic [31:0] HRDATA;
 	logic [1:0] HRESP;
	logic  HREADYOUT;
  	constraint c1{HADDR inside {[32'h8000_0000 : 32'h8000_03ff],
                              [32'h8400_0000 : 32'h8400_03ff],
                              [32'h8800_0000 : 32'h8800_03ff],
                              [32'h8c00_0000 : 32'h8c00_03ff]};}

	constraint c2{HSIZE inside {[0:2]};}

	constraint c3{(HADDR%(1<<HSIZE))==0;}  //because memory has defined like (4096X8 bits) 
	
	constraint c6{(HADDR%1024)+(length*(1<<HSIZE))<1024;}

	constraint c7{length inside{[1:1023]};}
	
	constraint c4{HRESETn dist{1:=90,0:=10};}

	constraint c5{HWRITE dist{1:=50,0:=30};}

		
	//function void post_randomize();
		
	//endfunction

	virtual function void do_print(uvm_printer printer);
		super.do_print(printer);

		printer.print_field("HRESETn",	this.HRESETn, 	1, UVM_DEC);
		printer.print_field("HADDR",	this.HADDR, 	32, UVM_HEX);
		printer.print_field("HTRANS",	this.HTRANS, 	2, UVM_DEC);
		printer.print_field("HWRITE",	this.HWRITE, 	1, UVM_DEC);
		printer.print_field("HSIZE",	this.HSIZE, 	3, UVM_DEC);
		printer.print_field("Length",	this.length, 	32, UVM_DEC);
		printer.print_field("HBURST",	this.HBURST, 	3, UVM_DEC);
		printer.print_field("HWDATA",	this.HWDATA, 	32, UVM_HEX);
		printer.print_field("HREADYIN",	this.HREADYIN, 	1, UVM_DEC);
		printer.print_field("HREADYOUT",this.HREADYOUT,	1, UVM_DEC);
		printer.print_field("HRDATA",	this.HRDATA, 	32, UVM_HEX);
		printer.print_field("HRESP",	this.HRESP, 	2, UVM_DEC);
	
	endfunction

	virtual function void do_copy(uvm_object rhs);

    		ahb_trans rhs_;	    	// handle for overriding the variable

    		if(!$cast(rhs_,rhs)) 	//check the compatibility
			begin
   			`uvm_fatal("do_copy","cast of the rhs object failed")
    			end
    		super.do_copy(rhs);

  		// Copy over data members:
    		HRESETn = rhs_.HRESETn;
		HADDR   = rhs_.HADDR;
		HTRANS  = rhs_.HTRANS;
		HWRITE  = rhs_.HWRITE;
		HSIZE   = rhs_.HSIZE;
		HBURST  = rhs_.HBURST;
		HWDATA  = rhs_.HWDATA;
		HREADYIN  = rhs_.HREADYIN;
		HREADYOUT  = rhs_.HREADYOUT;
		HRDATA  = rhs_.HRDATA;
		HRESP   = rhs_.HRESP;
	
  	endfunction:do_copy


endclass	
