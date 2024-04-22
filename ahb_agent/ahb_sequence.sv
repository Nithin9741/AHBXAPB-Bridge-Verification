//AHB_SEQUENCE_CLASS

//SEQ-IDLE: Single Type Burst xnsfer

class ahb_sequence_idle extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence_idle)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;


	function new(string name = "ahb_sequence_idle");
		super.new(name);
	endfunction

	task body();
	repeat(1)
		begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==0; HTRANS==0;});
			finish_item(req);
	
		end
	endtask

endclass


//SEQ-BUSY: Single Type Burst xnsfer

class ahb_sequence_busy extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence_busy)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;


	function new(string name = "ahb_sequence_busy");
		super.new(name);
	endfunction

	task body();
	repeat(1)
		begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==0; HTRANS==1;});
			finish_item(req);
	
		end
	endtask

endclass


//SEQ-0: Single Type Burst xnsfer

class ahb_sequence0 extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence0)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;
	 logic[31:0] RDATA;
	 bit[1:0] RESP;


	function new(string name = "ahb_sequence0");
		super.new(name);
	endfunction

	task body();
	repeat(1)
		begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==0; HTRANS==2;});
			finish_item(req);
	
		end
	endtask

endclass


//SEQ-1: Unspecified Length Incrementing Type Burst xnsfer

class ahb_sequence1 extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence1)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int Length;


	function new(string name = "ahb_sequence1");
		super.new(name);
	endfunction

	task body();

	begin
		req = ahb_trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HBURST==1; HTRANS==2;});
		finish_item(req);
	
		ADDR   = req.HADDR;
		WRITE  = req.HWRITE;
		SIZE   = req.HSIZE;
		BURST  = req.HBURST;
		Length = req.length;
	
		for(int i=0;i<Length;i++) 
		begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR ==ADDR+(1<<SIZE);
						     HSIZE == SIZE;
						     HWRITE == WRITE;
                 				length == Length;});
			finish_item(req);
			ADDR = req.HADDR;
		end

	end
	endtask

endclass



//SEQ-2: 4-beat Wrapping Type Burst xnsfer

class ahb_sequence2 extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence2)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;
	 logic[31:0] RDATA;
	 bit[1:0] RESP;


	function new(string name = "ahb_sequence2");
		super.new(name);
	endfunction

	task body();

	begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==2; HTRANS==2;});
			finish_item(req);
	
		ADDR   = req.HADDR;
		WRITE  = req.HWRITE;
		SIZE   = req.HSIZE;
		BURST  = req.HBURST;
		
		if(SIZE == 0) begin
		     for(int i=0;i<3;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:2],(ADDR[1:0]+1'b1)};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

		if(SIZE == 1) begin
		     for(int i=0;i<3;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:3],(ADDR[2:1]+1'b1),ADDR[0]};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

		if(SIZE == 2) begin
		     for(int i=0;i<3;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:4],(ADDR[3:2]+1'b1),ADDR[1:0]};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

	end
	endtask

endclass


//SEQ-3: 4-beat Incrementing Type Burst xnsfer

class ahb_sequence3 extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence3)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;
	 logic[31:0] RDATA;
	 bit[1:0] RESP;


	function new(string name = "ahb_sequence3");
		super.new(name);
	endfunction

	task body();

	begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==3; HTRANS==2;});
			finish_item(req);
	
		ADDR   = req.HADDR;
		WRITE  = req.HWRITE;
		SIZE   = req.HSIZE;
		BURST  = req.HBURST;
		
		for(int i=0;i<3;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR ==ADDR+(1<<HSIZE);
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
		 ADDR = req.HADDR;
		end

	end
	endtask

endclass



//SEQ-4: 8-beat Wrapping Type Burst xnsfer

class ahb_sequence4 extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence4)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;
	 logic[31:0] RDATA;
	 bit[1:0] RESP;


	function new(string name = "ahb_sequence4");
		super.new(name);
	endfunction

	task body();

	begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==4; HTRANS==2;});
			finish_item(req);
	
		ADDR   = req.HADDR;
		WRITE  = req.HWRITE;
		SIZE   = req.HSIZE;
		BURST  = req.HBURST;
		
		if(SIZE == 0) begin
		     for(int i=0;i<7;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:3],(ADDR[2:0]+1'b1)};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

		if(SIZE == 1) begin
		     for(int i=0;i<7;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:4],(ADDR[3:1]+1'b1),ADDR[0]};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

		if(SIZE == 2) begin
		     for(int i=0;i<7;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:5],(ADDR[4:2]+1'b1),ADDR[1:0]};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

	end
	endtask

endclass



//SEQ-5: 8-beat Incrementing Type Burst xnsfer

class ahb_sequence5 extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence5)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;
	 logic[31:0] RDATA;
	 bit[1:0] RESP;


	function new(string name = "ahb_sequence5");
		super.new(name);
	endfunction

	task body();

	begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==5; HTRANS==2;});
			finish_item(req);
	
		ADDR   = req.HADDR;
		WRITE  = req.HWRITE;
		SIZE   = req.HSIZE;
		BURST  = req.HBURST;
		
		for(int i=0;i<7;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR ==ADDR+(1<<HSIZE);
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		end

	end
	endtask

endclass


//SEQ-6: 16-beat Wrapping Type Burst xnsfer

class ahb_sequence6 extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence6)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;
	 logic[31:0] RDATA;
	 bit[1:0] RESP;


	function new(string name = "ahb_sequence6");
		super.new(name);
	endfunction

	task body();

	begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==6; HTRANS==2;});
			finish_item(req);
	
		ADDR   = req.HADDR;
		WRITE  = req.HWRITE;
		SIZE   = req.HSIZE;
		BURST  = req.HBURST;
		
		if(SIZE == 0) begin
		     for(int i=0;i<15;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:4],(ADDR[3:0]+1'b1)};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

		if(SIZE == 1) begin
		     for(int i=0;i<15;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:5],(ADDR[4:1]+1'b1),ADDR[0]};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

		if(SIZE == 2) begin
		     for(int i=0;i<15;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR == {ADDR[31:6],(ADDR[5:2]+1'b1),ADDR[1:0]};
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		     end
		end

	end
	endtask

endclass


//SEQ-7: 16-beat Incrementing Type Burst xnsfer

class ahb_sequence7 extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence7)

	 bit[31:0] ADDR;
	 bit[1:0] TRANS;
	 bit WRITE;
	 bit[2:0] SIZE;
	 bit[2:0] BURST;
	 bit[31:0] WDATA;
	 bit READY;
	 int length;
	 logic[31:0] RDATA;
	 bit[1:0] RESP;


	function new(string name = "ahb_sequence7");
		super.new(name);
	endfunction

	task body();

	begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==7; HTRANS==2;});
			finish_item(req);
	
		ADDR   = req.HADDR;
		WRITE  = req.HWRITE;
		SIZE   = req.HSIZE;
		BURST  = req.HBURST;
		
		for(int i=0;i<15;i++) begin
			req = ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {HBURST==BURST; HTRANS ==3;
						     HADDR ==ADDR+(1<<HSIZE);
						     HSIZE == SIZE;
						     HWRITE == WRITE;});
			finish_item(req);
			ADDR = req.HADDR;
		end

	end
	endtask

endclass



