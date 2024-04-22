//APB_AGENT_TOP
class apb_agent_top extends uvm_env;
   `uvm_component_utils(apb_agent_top)

    env_config m_cfg;
    apb_agent agenth[];
       
    function new(string name = "apb_agent_top", uvm_component parent = null);
  	super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal(get_type_name(),"Error in getting ENV CONFIG in environment.")

	if(m_cfg.has_apb_agent) begin
	
  	 agenth = new[m_cfg.no_of_apb_agent];
	
	 foreach(agenth[i]) begin

		uvm_config_db#(apb_agent_config)::set(this,$sformatf("agenth[%0d]*",i),"apb_agent_config",m_cfg.apb_cfg[i]);

		agenth[i] = apb_agent::type_id::create($sformatf("agenth[%0d]",i), this);
	  end
	end 	

   endfunction

endclass


