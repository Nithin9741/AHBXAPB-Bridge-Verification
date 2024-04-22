//AGENT
class ahb_agent extends uvm_agent;

	`uvm_component_utils(ahb_agent)

	ahb_agent_config m_cfg;

	ahb_sequencer seqrh;
	ahb_driver drvh;
	ahb_monitor monh;

	 function new(string name = "ahb_agent", uvm_component parent = null);
  		super.new(name,parent);
   	 endfunction

	function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",m_cfg))
		`uvm_fatal(get_type_name(),"Error in getting Input CONFIG in agent.")

	monh = ahb_monitor::type_id::create("monh", this);

	if(m_cfg.is_active == UVM_ACTIVE) begin
		seqrh = ahb_sequencer::type_id::create("seqrh", this);
		drvh = ahb_driver::type_id::create("drvh", this);
	end
	endfunction

	function void connect_phase(uvm_phase phase);
	if(m_cfg.is_active == UVM_ACTIVE) begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
	end
	endfunction

endclass

