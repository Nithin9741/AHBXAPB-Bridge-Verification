//APB_CONFIGURATION_FILE
class apb_agent_config extends uvm_object;

   `uvm_object_utils(apb_agent_config)

  virtual apb_if pvif;

  uvm_active_passive_enum is_active = UVM_ACTIVE;

 function new(string name  = "apb_agent_config");
	super.new(name);
 endfunction

endclass

