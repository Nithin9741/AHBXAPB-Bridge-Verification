//AHB_AGENT_TOP
class ahb_agent_top extends uvm_env;
   `uvm_component_utils(ahb_agent_top)

    env_config m_cfg;
    ahb_agent agenth[];
       
    function new(string name = "ahb_agent_top", uvm_component parent = null);
  	super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal(get_type_name(),"Error in getting ENV CONFIG in environment.")

	if(m_cfg.has_ahb_agent) begin
	
  	 agenth = new[m_cfg.no_of_ahb_agent];
	
	 foreach(agenth[i]) begin

	    	uvm_config_db#(ahb_agent_config)::set(this,$sformatf("agenth[%0d]*",i),"ahb_agent_config",m_cfg.ahb_cfg[i]);

		agenth[i] = ahb_agent::type_id::create($sformatf("agenth[%0d]",i), this);
	  end
	end 	

   endfunction

endclass


