//AHB_DRIVER

class ahb_driver extends uvm_driver#(ahb_trans);

	`uvm_component_utils(ahb_driver)
	
	ahb_agent_config m_cfg;
	virtual ahb_if.AHB_DRV_MP vif;

	function new(string name = "ahb_driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_cfg = ahb_agent_config::type_id::create("m_cfg");

        	if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",m_cfg))
		 `uvm_fatal(get_type_name(),"Error in getting Input interface in AHB driver.")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.hvif;
	endfunction

	task run_phase(uvm_phase phase);

		@(vif.ahb_drv_cb);

		vif.ahb_drv_cb.Hresetn <= 1'b0;
		@(vif.ahb_drv_cb);
		vif.ahb_drv_cb.Hresetn <= 1'b1;
		@(vif.ahb_drv_cb);

		//	while(!vif.ahb_drv_cb.Hreadyout)
		//	@(vif.ahb_drv_cb);

		forever
		begin
		     seq_item_port.get_next_item(req);
		     send_to_dut(req);
		     seq_item_port.item_done();
		end
	endtask	

	task send_to_dut(ahb_trans xtn);
         	`uvm_info(get_type_name(),"AHB-DRIVER Transaction Driving...",UVM_LOW)
		xtn.print();
		vif.ahb_drv_cb.Haddr <= xtn.HADDR;
		vif.ahb_drv_cb.Htrans <= xtn.HTRANS;
		vif.ahb_drv_cb.Hreadyin <= 1'b1;
		vif.ahb_drv_cb.Hsize <= xtn.HSIZE;
   		vif.ahb_drv_cb.Hwrite <= xtn.HWRITE;
		xtn.HRESP <= vif.ahb_drv_cb.Hresp;

		@(vif.ahb_drv_cb);
		
		while(vif.ahb_drv_cb.Hreadyout == 0)
			@(vif.ahb_drv_cb);
		if(xtn.HWRITE == 1)
			vif.ahb_drv_cb.Hwdata <= xtn.HWDATA;		
		
   	
	endtask
endclass
