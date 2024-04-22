//ENVIRONMENT_CLASS
class env extends uvm_env;
   `uvm_component_utils(env)

    env_config m_cfg;

    ahb_agent_top ahb_toph;
    apb_agent_top apb_toph;

    scoreboard sb;
     virtual_sequencer v_sequencer;
    
    function new(string name = "env", uvm_component parent = null);
  	super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal(get_type_name(),"Error in getting ENV CONFIG in environment.")

	if(m_cfg.has_ahb_agent)
	  ahb_toph = ahb_agent_top::type_id::create("ahb_toph", this);

	if(m_cfg.has_apb_agent)
	  apb_toph = apb_agent_top::type_id::create("apb_toph", this);
	
	if(m_cfg.has_scoreboard)
	  sb = scoreboard::type_id::create("sb", this);
     
 	if(m_cfg.has_virtual_sequencer)
	  v_sequencer = virtual_sequencer::type_id::create("v_sequencer", this);

   endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        if(m_cfg.has_scoreboard) 
			begin
			  ahb_toph.agenth[0].monh.monitor_port.connect(sb.Hfifo.analysis_export);
        apb_toph.agenth[0].monh.monitor_port.connect(sb.Pfifo.analysis_export);                      

			end
      
      
      if(m_cfg.has_virtual_sequencer)
	   	begin	  

          if(m_cfg.has_ahb_agent) 
		     begin
			v_sequencer.ahb_sqrh[0] = ahb_toph.agenth[0].seqrh;	
	              end

                   if(m_cfg.has_apb_agent) 
		       begin
                     v_sequencer.apb_sqrh[0] = apb_toph.agenth[0].seqrh;		
 		       end
                end
	endfunction

endclass


