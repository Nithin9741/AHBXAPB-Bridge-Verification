//APB_MONITOR
class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)

 	  apb_agent_config m_cfg;
	  virtual apb_if.APB_MON_MP vif;
	
	apb_trans mxtn;
	
 	uvm_analysis_port #(apb_trans) monitor_port;

	function new(string name = "apb_monitor", uvm_component parent = null);
		super.new(name,parent);
		monitor_port = new("monitor_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_cfg = apb_agent_config::type_id::create("m_cfg");

    		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",m_cfg))
		   `uvm_fatal(get_type_name(),"Error in getting Input interface in APB monitor.")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.pvif;
	endfunction

	task run_phase(uvm_phase phase);

	forever
		collect_data();
	endtask	

	task collect_data();
		mxtn= apb_trans::type_id::create("mxtn");
		
		wait(vif.apb_mon_cb.Penable) 

		mxtn.PADDR  = vif.apb_mon_cb.Paddr;
	  	mxtn.PSELx = vif.apb_mon_cb.Pselx;
   		mxtn.PWRITE = vif.apb_mon_cb.Pwrite;

		if(mxtn.PWRITE == 0)
			mxtn.PRDATA = vif.apb_mon_cb.Prdata;	
      		else
			mxtn.PWDATA  = vif.apb_mon_cb.Pwdata;

   	 	`uvm_info(get_type_name(),"APB-MONITOR Transaction Collecting...",UVM_LOW)
    	    	mxtn.print();
     		monitor_port.write(mxtn);
		 
   		 @(vif.apb_mon_cb);


    endtask


endclass

