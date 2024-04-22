
//------------------------------------
//    AHB_APB_BRIDGE_TEST_CLASS_LIB
//--------------------------------------


class base_test extends uvm_test;
 
  `uvm_component_utils(base_test)

  env envh;
  env_config m_cfg;
  
  ahb_agent_config ahb_cfg[];
  apb_agent_config apb_cfg[];

  bit has_apb_agent = 1;
  bit has_ahb_agent = 1;
  bit has_scoreboard = 1;
  int no_of_ahb_agent = 1;
  int no_of_apb_agent = 1;
  
  function new(string name = "base_test", uvm_component parent = null);
  	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	m_cfg = env_config::type_id::create("m_cfg");

	if(has_ahb_agent) begin
		ahb_cfg = new[no_of_ahb_agent];
		m_cfg.ahb_cfg = new[no_of_ahb_agent];

		foreach(ahb_cfg[i]) begin
		ahb_cfg[i] = ahb_agent_config::type_id::create($sformatf("ahb_cfg[%0d]",i));
		if(!uvm_config_db#(virtual ahb_if)::get(this,"","vif1",ahb_cfg[i].hvif))
			`uvm_fatal(get_type_name(),"Error in getting Input interface in agent.")
		m_cfg.ahb_cfg[i] = ahb_cfg[i];
		end
	end

	if(has_apb_agent) begin
		apb_cfg = new[no_of_apb_agent];
        	m_cfg.apb_cfg = new[no_of_apb_agent];

		foreach(apb_cfg[i]) begin
		apb_cfg[i] = apb_agent_config::type_id::create($sformatf("apb_cfg[%0d]",i));
		if(!uvm_config_db#(virtual apb_if)::get(this,"","vif2",apb_cfg[i].pvif))
			`uvm_fatal(get_type_name(),"Error in getting Input interface in agent.")
		m_cfg.apb_cfg[i] = apb_cfg[i];
		end
	end
	
 	   m_cfg.has_ahb_agent = has_ahb_agent;
  	 m_cfg.has_apb_agent = has_apb_agent;
  	 m_cfg.has_scoreboard = has_scoreboard;
  	 m_cfg.no_of_ahb_agent = no_of_ahb_agent;
  	 m_cfg.no_of_apb_agent = no_of_apb_agent;

	uvm_config_db#(env_config)::set(this,"*","env_config",m_cfg);
	
	envh = env::type_id::create("envh", this);

  endfunction
 
function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

endclass



//-------------------------------------------
//       ALL BURST TYPES TESTCASES STARTS
//--------------------------------------------

class test0 extends base_test;

	`uvm_component_utils(test0)
	
	ahb_sequence0 ahb_seqh;
	//apb_sequence apb_seqh;


  	function new(string name = "test0", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence0::type_id::create("ahb_seqh");
	//	apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
		#35;
		phase.drop_objection(this);
	endtask

endclass


class test1 extends base_test;

	`uvm_component_utils(test1)
	
	ahb_sequence1 ahb_seqh;
	//apb_sequence  apb_seqh;


  	function new(string name = "test1", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence1::type_id::create("ahb_seqh");
		//apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
		
		#35;
		phase.drop_objection(this);
	endtask

endclass

class test2 extends base_test;

	`uvm_component_utils(test2)
	
	ahb_sequence2 ahb_seqh;
	//apb_sequence  apb_seqh;


  	function new(string name = "test2", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence2::type_id::create("ahb_seqh");
		//apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction


	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
		
		#45;
		phase.drop_objection(this);
	endtask

endclass

class test3 extends base_test;

	`uvm_component_utils(test3)
	
	ahb_sequence3 ahb_seqh;
	//apb_sequence  apb_seqh;


  	function new(string name = "test3", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence3::type_id::create("ahb_seqh");
		//apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
		
		#45;
		phase.drop_objection(this);
	endtask

endclass

class test4 extends base_test;

	`uvm_component_utils(test4)
	
	ahb_sequence4 ahb_seqh;
	//apb_sequence  apb_seqh;


  	function new(string name = "test4", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence4::type_id::create("ahb_seqh");
		//apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
	
		#45;
		phase.drop_objection(this);
	endtask

endclass

class test5 extends base_test;

	`uvm_component_utils(test5)
	
	ahb_sequence5 ahb_seqh;
	//apb_sequence  apb_seqh;


  	function new(string name = "test5", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence5::type_id::create("ahb_seqh");
		//apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
	
		#45;
		phase.drop_objection(this);
	endtask

endclass

class test6 extends base_test;

	`uvm_component_utils(test6)
	
	ahb_sequence6 ahb_seqh;
	//apb_sequence  apb_seqh;


  	function new(string name = "test6", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence6::type_id::create("ahb_seqh");
		//apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
		
		#45;
		phase.drop_objection(this);
	endtask

endclass

class test7 extends base_test;

	`uvm_component_utils(test7)
	
	ahb_sequence7 ahb_seqh;
	//apb_sequence  apb_seqh;


  	function new(string name = "test7", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence7::type_id::create("ahb_seqh");
		//apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
		
		#45;
		phase.drop_objection(this);
	endtask

endclass


//------------------------------------------------------
//        BUSY & IDLE TESTCASES
//----------------------------------------------------

class test_idle extends base_test;

	`uvm_component_utils(test_idle)
	
	ahb_sequence_idle ahb_seqh;
	//apb_sequence apb_seqh;


  	function new(string name = "test_idle", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence_idle::type_id::create("ahb_seqh");
	//	apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
		#45;
		phase.drop_objection(this);
	endtask

endclass


class test_busy extends base_test;

	`uvm_component_utils(test_busy)
	
	ahb_sequence_busy ahb_seqh;
	//apb_sequence apb_seqh;


  	function new(string name = "test_busy", uvm_component parent = null);
  		super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_seqh = ahb_sequence_busy::type_id::create("ahb_seqh");
	//	apb_seqh = apb_sequence::type_id::create("apb_seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		ahb_seqh.start(envh.ahb_toph.agenth[0].seqrh);
		//apb_seqh.start(envh.apb_toph.agenth[0].seqrh);
		#45;
		phase.drop_objection(this);
	endtask

endclass



//-------------------------------------------------------











//-------------------------------------------------------

//--------- VIRTUAL-SEQUENCE-TESTCASES STARTS  ------- 

//------------------------------------------
// SINGLE XTN PACKET V-TEST CLASS
//------------------------------------------

class v0_test extends base_test;

	//factory registration
	`uvm_component_utils(v0_test)
	
	seq0_vseq single_pkt;

	//overriding constructor
	function new(string name= "v0_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

       single_pkt=seq0_vseq::type_id::create("single_pkt");  	//create instance for sequence
 		
	
	  single_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass


//------------------------------------------
// UNSPECIFIED XTN PACKET V-TEST CLASS
//------------------------------------------

class v1_test extends base_test;

	//factory registration
	`uvm_component_utils(v1_test)
	
	seq1_vseq unknown_pkt;

	//overriding constructor
	function new(string name= "v1_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    unknown_pkt=seq1_vseq::type_id::create("unknown_pkt");  	//create instance for sequence
 		
	
	  unknown_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass

//------------------------------------------
// 4-BEAT WRAPPING XTN PACKET V-TEST CLASS
//------------------------------------------

class v2_test extends base_test;

	//factory registration
	`uvm_component_utils(v2_test)
	
	seq2_vseq wrap4_pkt;

	//overriding constructor
	function new(string name= "v2_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    wrap4_pkt=seq2_vseq::type_id::create("wrap4_pkt");  	//create instance for sequence
 		
	
	  wrap4_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass


//------------------------------------------
// 4-BEAT INCREMENTING XTN PACKET V-TEST CLASS
//------------------------------------------

class v3_test extends base_test;

	//factory registration
	`uvm_component_utils(v3_test)
	
	seq3_vseq inc4_pkt;

	//overriding constructor
	function new(string name= "v3_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    	  inc4_pkt=seq3_vseq::type_id::create("inc4_pkt");  	//create instance for sequence
 		
	
	  inc4_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass


//------------------------------------------
// 8-BEAT WRAPPING XTN PACKET V-TEST CLASS
//------------------------------------------

class v4_test extends base_test;

	//factory registration
	`uvm_component_utils(v4_test)
	
	seq4_vseq wrap8_pkt;

	//overriding constructor
	function new(string name= "v4_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    	  wrap8_pkt=seq4_vseq::type_id::create("wrap8_pkt");  	//create instance for sequence
 		
	
	  wrap8_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass


//------------------------------------------
// 8-BEAT-INCREMENTING XTN PACKET V-TEST CLASS
//------------------------------------------

class v5_test extends base_test;

	//factory registration
	`uvm_component_utils(v5_test)
	
	seq5_vseq inc8_pkt;

	//overriding constructor
	function new(string name= "v5_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    inc8_pkt=seq5_vseq::type_id::create("inc8_pkt");  	//create instance for sequence
 		
	
	  inc8_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass

//------------------------------------------
// 16-BEAT WRAPPING XTN PACKET V-TEST CLASS
//------------------------------------------

class v6_test extends base_test;

	//factory registration
	`uvm_component_utils(v6_test)
	
	seq6_vseq wrap16_pkt;

	//overriding constructor
	function new(string name= "v6_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    wrap16_pkt=seq6_vseq::type_id::create("wrap16_pkt");  	//create instance for sequence
 		
	
	  wrap16_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass


//------------------------------------------
// 16-BEAT INCREMENTING XTN PACKET V-TEST CLASS
//------------------------------------------

class v7_test extends base_test;

	//factory registration
	`uvm_component_utils(v7_test)
	
	seq7_vseq inc16_pkt;

	//overriding constructor
	function new(string name= "v7_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    inc16_pkt=seq7_vseq::type_id::create("inc16_pkt");  	//create instance for sequence
 		
	
	  inc16_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass

//------------------------------------------
// IDLE TYPE XTN PACKET V-TEST CLASS
//------------------------------------------

class v_idle_test extends base_test;

	//factory registration
	`uvm_component_utils(v_idle_test)
	
	seq_idle_vseq idle_pkt;

	//overriding constructor
	function new(string name= "v_idle_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    idle_pkt=seq_idle_vseq::type_id::create("idle_pkt");  	//create instance for sequence
 		
	
	  idle_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass

//------------------------------------------
// BUSY TYPE XTN PACKET V-TEST CLASS
//------------------------------------------

class v_busy_test extends base_test;

	//factory registration
	`uvm_component_utils(v_busy_test)
	
	seq_busy_vseq busy_pkt;

	//overriding constructor
	function new(string name= "v_busy_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);
 	  phase.raise_objection(this);
 		

    busy_pkt=seq_busy_vseq::type_id::create("busy_pkt");  	//create instance for sequence
 		
	
	  busy_pkt.start(envh.v_sequencer);  	//start the sequence wrt virtual sequencer

		#45;
 	  phase.drop_objection(this);
	
	endtask 

endclass
