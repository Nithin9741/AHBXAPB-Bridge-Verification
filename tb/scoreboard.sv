//SCOREBOARD


  // Include definitions
   `include "definitions.v"

class scoreboard extends uvm_scoreboard;

  	uvm_tlm_analysis_fifo #(ahb_trans) Hfifo;
  	uvm_tlm_analysis_fifo #(apb_trans) Pfifo;

  	`uvm_component_utils(scoreboard)
   
    ahb_trans hxtn;
    apb_trans pxtn;
   
     int  wr_xtns_in, rd_xtns_in , xtns_compared ,xtns_dropped;	
     
    ahb_trans cov_hxtn;
    apb_trans cov_pxtn;

	 
// Covergroup for AHB-Master transactions

covergroup ahb_cov;
    
     option.per_instance=1;
       
       //DATA
        H_data : coverpoint cov_hxtn.HWDATA {bins low  = {[32'h0000_0000:32'hffff_ffff]};}
	     	     
        //ADDRESS
        H_addr : coverpoint cov_hxtn.HADDR {
                   		bins paddr1  =  {[32'h8000_0000:32'h8000_03ff]};
		               bins paddr2 = {[32'h8400_0000:32'h8400_03ff]};
		               bins paddr3 = {[32'h8800_0000:32'h8800_03ff]};
		               bins paddr4 = {[32'h8c00_0000:32'h8c00_03ff]};}
    
        // WRITE
        H_write : coverpoint cov_hxtn.HWRITE;
        
         // HTRANS type
        H_trans : coverpoint cov_hxtn.HTRANS {
               bins Idle = {0};
               bins Busy = {1};
               bins NoSeq = {2};
               bins Seq =  {3};}
    
        // SIZE of DATA
        H_size : coverpoint cov_hxtn.HSIZE {
               bins size1 = {0};
               bins size2 = {1};
               bins size4 = {2};}
    
        //Cross Operation - Functional Coverage
        
        CROSS_HBIN : cross H_write, H_size, H_addr;
          
endgroup


// Covergroup for APB-Slave transactions

covergroup apb_cov;

          option.per_instance=1;

       //P_DATA
       P_data : coverpoint cov_pxtn.PRDATA { bins low  = {[32'h0000_0000:32'hffff_ffff]};}
                             
        //P_ADDRESS
        P_addr :coverpoint cov_pxtn.PADDR {
                   		bins paddr1  =  {[32'h8000_0000:32'h8000_03ff]};
		               bins paddr2 = {[32'h8400_0000:32'h8400_03ff]};
		               bins paddr3 = {[32'h8800_0000:32'h8800_03ff]};
		               bins paddr4 = {[32'h8c00_0000:32'h8c00_03ff]};}
                                  
        //P_WRITE
        P_write : coverpoint cov_pxtn.PWRITE;
        
         //P_ENABLE
       // P_enable : coverpoint cov_pxtn.PENABLE;
        
        //PSELECT SLAVES
        P_selx : coverpoint cov_pxtn.PSELx {
               bins s1 = {1};
               bins s2 = {2};
               bins s3 = {3};
               bins s4 = {4};}
        
        //Read Operation - Functional Coverage
        CROSS_PBIN : cross P_write, P_addr, P_selx;
        
 endgroup


    function new(string name = "scoreboard", uvm_component parent = null);
  		super.new(name,parent);
		  Hfifo = new("Hfifo",this);
		  Pfifo = new("Pfifo", this);
      		  ahb_cov = new();
      		apb_cov = new();
   endfunction
      
  //------ RUN PHASE -------------    
      
     task run_phase(uvm_phase phase);
         super.run_phase(phase);
         
           
           forever
               begin
		fork
                 	Hfifo.get(hxtn);
                	Pfifo.get(pxtn);
                 join
                 compare_data();
                // xtns_compared++;

                 cov_hxtn = hxtn;
                 cov_pxtn = pxtn;
                 
                // `uvm_info("AHB_FIFO","AHB-Trans Data Collected." , UVM_LOW)
                 //cov_hxtn.print;   
         
                // `uvm_info("APB_FIFO","APB-Trans Data Collected." , UVM_LOW)               
                // cov_pxtn.print; 
                 
                 ahb_cov.sample();
                 apb_cov.sample();       
                
               end
		//$display("NO of Transactions Compared = %0d",xtns_compared);
     endtask
     
     
     //compare_data  task
     
	task compare_data();
 
		if(hxtn.HADDR == pxtn.PADDR)
			`uvm_info("COMPARE","Address is successfully compared",UVM_LOW)
		else
			`uvm_fatal("COMPARE","Address is not compared successfully")
      
		if(hxtn.HWRITE == pxtn.PWRITE)
			`uvm_info("COMPARE","Write Enable is successfully compared",UVM_LOW)
		else
			`uvm_fatal("COMPARE","Write Enable is not compared successfully")


	//WRITE DATA COMPARISION   --------------------------

	if(hxtn.HWRITE ==1)
	begin 		
		        case(hxtn.HSIZE)
			 3'b000:         begin
			                    case(hxtn.HADDR[1:0])
					       `ADDR_OFFSET_BYTE_0:begin      if(pxtn.PWDATA == hxtn.HWDATA[7:0])
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end
					       `ADDR_OFFSET_BYTE_1:begin     if(pxtn.PWDATA == hxtn.HWDATA[15:8])
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end

					       `ADDR_OFFSET_BYTE_2:begin     if(pxtn.PWDATA ==  hxtn.HWDATA[23:16])
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end

					       `ADDR_OFFSET_BYTE_3:begin     if(pxtn.PWDATA ==  hxtn.HWDATA[31:24])
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end

					        default           :begin     if(pxtn.PWDATA == 0)
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end

					    endcase
					 end


			 3'b001:          begin
			                    case(hxtn.HADDR[1:0])
					       `ADDR_OFFSET_HFWORD_0:begin      if(pxtn.PWDATA == hxtn.HWDATA[15:0])
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end
					       `ADDR_OFFSET_HFWORD_2:begin      if(pxtn.PWDATA == hxtn.HWDATA[31:16])
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end
					        default             :begin     if(pxtn.PWDATA == 0)
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end

					    endcase
					  end


			 3'b010:          begin
			                    case(hxtn.HADDR[1:0])
					       `ADDR_OFFSET_WORD  :begin      if(pxtn.PWDATA == hxtn.HWDATA[31:0])
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end
					        default           :begin     if(pxtn.PWDATA == 0)
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end

					    endcase
			                  end


			default:         begin     if(pxtn.PWDATA == 0)
							`uvm_info("COMPARE","Write_DATA is successfully compared.",UVM_LOW)
						   else
							`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
					 end

		    endcase
        	end
		

	//READ DATA COMPARISION		------------------------------
	if(hxtn.HWRITE ==0)
		begin
		        case(hxtn.HSIZE)
			 3'b000:         begin
			                    case(hxtn.HADDR[1:0])
					       `ADDR_OFFSET_BYTE_0:begin     if(hxtn.HRDATA == pxtn.PRDATA[7:0])
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end
					       `ADDR_OFFSET_BYTE_1:begin     if(hxtn.HRDATA == pxtn.PRDATA[15:8])
										`uvm_info("COMPARE","Write_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Write_DATA is not compared successfully")
								   end

					       `ADDR_OFFSET_BYTE_2:begin     if(hxtn.HRDATA ==  pxtn.PRDATA[23:16])
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end

					       `ADDR_OFFSET_BYTE_3:begin     if(hxtn.HRDATA ==  pxtn.PRDATA[31:24])
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end

					        default           :begin     if(hxtn.HRDATA == 0)
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end

					    endcase
					 end


			 3'b001:          begin
			                    case(hxtn.HADDR[1:0])
					       `ADDR_OFFSET_HFWORD_0:begin      if(hxtn.HRDATA == pxtn.PRDATA[15:0])
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end
					       `ADDR_OFFSET_HFWORD_2:begin      if(hxtn.HWDATA == pxtn.PRDATA[31:16])
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end
					        default             :begin     if(hxtn.HRDATA == 0)
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end

					    endcase
					  end


			 3'b010:          begin
			                    case(hxtn.HADDR[1:0])
					       `ADDR_OFFSET_WORD  :begin      if(hxtn.HRDATA == pxtn.PRDATA[31:0])
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end
					        default           :begin     if(hxtn.HRDATA == 0)
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end

					    endcase
			                  end


			default:         begin     if(hxtn.HRDATA == 0)
										`uvm_info("COMPARE","Read_DATA is successfully compared",UVM_LOW)
										else
										`uvm_fatal("COMPARE","Read_DATA is not compared successfully")
								   end

		       endcase
        	end

	endtask

endclass


