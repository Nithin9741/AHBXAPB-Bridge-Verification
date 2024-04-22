//MONITOR
class ahb_monitor extends uvm_monitor;

	`uvm_component_utils(ahb_monitor)
	   
   	ahb_agent_config m_cfg;
	  virtual ahb_if.AHB_MON_MP vif;
     
     	ahb_trans mxtn;
 	 uvm_analysis_port #(ahb_trans) monitor_port;

	function new(string name = "ahb_monitor", uvm_component parent = null);
		super.new(name,parent);
		monitor_port = new("monitor_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_cfg = ahb_agent_config::type_id::create("m_cfg");

    		if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",m_cfg))
		   `uvm_fatal(get_type_name(),"Error in getting Input interface in AHB monitor.")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.hvif;
	endfunction


	task run_phase(uvm_phase phase);
	forever
		collect_data();
	endtask	

	task collect_data();
		mxtn= ahb_trans::type_id::create("mxtn");

		wait(vif.ahb_mon_cb.Hreadyout)
	
		wait((vif.ahb_mon_cb.Htrans==2) || (vif.ahb_mon_cb.Htrans == 3))
		

		mxtn.HADDR  = vif.ahb_mon_cb.Haddr;
 	    	mxtn.HTRANS = vif.ahb_mon_cb.Htrans;
		mxtn.HSIZE  = vif.ahb_mon_cb.Hsize;
   		mxtn.HWRITE = vif.ahb_mon_cb.Hwrite;
		mxtn.HRESP  = vif.ahb_mon_cb.Hresp;

		@(vif.ahb_mon_cb);

		mxtn.HREADYOUT = vif.ahb_mon_cb.Hreadyout;

		while(!vif.ahb_mon_cb.Hreadyout)
			@(vif.ahb_mon_cb);

		if(mxtn.HWRITE == 1)
			mxtn.HWDATA = vif.ahb_mon_cb.Hwdata;	
  		if(mxtn.HWRITE == 0)
      			mxtn.HRDATA  = vif.ahb_mon_cb.Hrdata;
  
   	    `uvm_info(get_type_name(),"AHB-MONITOR Transaction Collecting...",UVM_LOW)
    	     mxtn.print();
     	     monitor_port.write(mxtn);
	//@(vif.ahb_mon_cb);
	    endtask
endclass
