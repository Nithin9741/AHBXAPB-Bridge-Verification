//APB_SEQUENCE

class apb_sequence extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence)

	function new(string name = "apb_sequence");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		 begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

/*
class apb_sequence1 extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence1)

	function new(string name = "apb_sequence1");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		 begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

class apb_sequence2 extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence2)

	function new(string name = "apb_sequence2");
		super.new(name);
	endfunction
	
	task body();
		repeat(4)
		 begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

class apb_sequence3 extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence3)

	function new(string name = "apb_sequence3");
		super.new(name);
	endfunction
	
	task body();
		repeat(4)
		 begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

class apb_sequence4 extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence4)

	function new(string name = "apb_sequence4");
		super.new(name);
	endfunction
	
	task body();
		repeat(8)
		 begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

class apb_sequence5 extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence5)

	function new(string name = "apb_sequence5");
		super.new(name);
	endfunction
	
	task body();
		repeat(8)
		 begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

class apb_sequence6 extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence6)

	function new(string name = "apb_sequence6");
		super.new(name);
	endfunction
	
	task body();
		repeat(16)
		 begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

class apb_sequence7 extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence7)

	function new(string name = "apb_sequence7");
		super.new(name);
	endfunction
	
	task body();
		repeat(16)
		 begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

*/
