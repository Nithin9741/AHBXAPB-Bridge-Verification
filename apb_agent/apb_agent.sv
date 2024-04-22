//APB_AGENT
class apb_agent extends uvm_agent;

	`uvm_component_utils(apb_agent)

	apb_agent_config m_cfg;

	apb_sequencer seqrh;
	apb_driver drvh;
	apb_monitor monh;

	 function new(string name = "apb_agent", uvm_component parent = null);
  		super.new(name,parent);
   	 endfunction

	function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",m_cfg))
		`uvm_fatal(get_type_name(),"Error in getting apb CONFIG in agent.")

	monh = apb_monitor::type_id::create("monh", this);

	if(m_cfg.is_active == UVM_ACTIVE) begin
		seqrh = apb_sequencer::type_id::create("seqrh", this);
		drvh = apb_driver::type_id::create("drvh", this);
	end
	endfunction

	function void connect_phase(uvm_phase phase);
	if(m_cfg.is_active == UVM_ACTIVE) begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
	end
	endfunction

endclass


