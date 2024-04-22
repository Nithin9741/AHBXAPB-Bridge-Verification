//-------------------------
//    VIRTUAL_SEQUENCER
//-------------------------
   

class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item) ;
   
   // Factory Registration
	`uvm_component_utils(virtual_sequencer)

	ahb_sequencer ahb_sqrh[];
	apb_sequencer apb_sqrh[];
 
	env_config m_cfg;

   // Define Constructor new() function
	function new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

   // function void build_phase(uvm_phase phase)
	virtual function void build_phase(uvm_phase phase);

	     if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
    	     super.build_phase(phase);

	     ahb_sqrh = new[m_cfg.no_of_ahb_agent];
	     apb_sqrh = new[m_cfg.no_of_apb_agent];
    		
	endfunction

endclass

