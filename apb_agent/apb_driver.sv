//DRIVER
class apb_driver extends uvm_driver #(apb_trans);

	`uvm_component_utils(apb_driver)
	
	apb_agent_config m_cfg;
	virtual apb_if.APB_DRV_MP vif;
  	bit[31:0] data;

	function new(string name = "apb_driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_cfg = apb_agent_config::type_id::create("m_cfg");

        	if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",m_cfg))
		 `uvm_fatal(get_type_name(),"Error in getting Input interface in APB driver.")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.pvif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
   
		     //seq_item_port.get_next_item(req);
		     send_to_dut(req);
		     //seq_item_port.item_done();

	endtask	

	task send_to_dut(apb_trans xtn);
	
   
		while(vif.apb_drv_cb.Pselx == 0)
			@(vif.apb_drv_cb);
    
		@(vif.apb_drv_cb);
		if(vif.apb_drv_cb.Pwrite ==0) 
    		begin
		data = {$urandom};
		vif.apb_drv_cb.Prdata <= data;
			
		`uvm_info(get_type_name(),"APB-DRIVER Transaction Printing..",UVM_LOW)
     		$display("PRDATA = %0h",data);
     
     		//xtn.print();
     		end
     		@(vif.apb_drv_cb);
	 	@(vif.apb_drv_cb);
     
	endtask


endclass

