//------------------------------------------
// VIRTUAL SEQUENCE BASE CLASS
//------------------------------------------

class virtual_base_sequence extends uvm_sequence#(uvm_sequence_item);

	//factory registration
	`uvm_object_utils(virtual_base_sequence)

	//declare physical sequencer and virtual sequencer handles
	ahb_sequencer ahb_sqrh[];
	apb_sequencer apb_sqrh[];
 
	virtual_sequencer vsqrh;
 
	env_config m_env_cfg;  	// declare env_config handle


	//declare sequence handles

    ahb_sequence0 hseq0;
    ahb_sequence1 hseq1;
    ahb_sequence2 hseq2;
    ahb_sequence3 hseq3;
    ahb_sequence4 hseq4;
    ahb_sequence5 hseq5;
    ahb_sequence6 hseq6;
    ahb_sequence7 hseq7;
    
    ahb_sequence_idle hseq_idle;
    ahb_sequence_busy hseq_busy;
    
    apb_sequence pseq;

	//overriding constructor
	function new(string name="virtual_base_sequence");
		super.new(name);
	endfunction

	//body
	task body();
		
		//get env config
		if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",m_env_cfg))
			`uvm_fatal("CONFIG","cannot get() m_env_cfg from uvm_config_db. Have you set() it?") 
      
	/*	
		//get addr
		if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal("CONFIG","cannot get() addr from uvm_config_db. Have you set() it?")
	*/
  	
		//get dynamic array size for physical sequencer handles
   
		ahb_sqrh = new[m_env_cfg.no_of_ahb_agent];
		ahb_sqrh = new[m_env_cfg.no_of_apb_agent];

	
		assert($cast(vsqrh,m_sequencer));  	// check compatibility of virtual sequencer and m_sequencer
		
		// assign virtual sequencer's physical sequencer handle to physical sequencer handle of this class
   
		foreach(ahb_sqrh[i])
			ahb_sqrh[i]=vsqrh.ahb_sqrh[i];
      
		foreach(apb_sqrh[i])
			apb_sqrh[i]=vsqrh.apb_sqrh[i];

	endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE SINGLE PACKET CLASS
//------------------------------------------

class seq0_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq0_vseq)

	//overriding constructor
	function new(string name="seq0_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq0 =ahb_sequence0::type_id::create("hseq0");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq0.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE UNSPECIFIED-Length PACKET CLASS
//------------------------------------------

class seq1_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq1_vseq)

	//overriding constructor
	function new(string name="seq1_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq1 =ahb_sequence1::type_id::create("hseq1");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all AHB and APB sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq1.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE 4-beat_Wrapping PACKET CLASS
//------------------------------------------

class seq2_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq2_vseq)

	//overriding constructor
	function new(string name="seq2_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq2 =ahb_sequence2::type_id::create("hseq2");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq2.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE 4-beat_Increment PACKET CLASS
//------------------------------------------

class seq3_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq3_vseq)

	//overriding constructor
	function new(string name="seq3_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq3 =ahb_sequence3::type_id::create("hseq3");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq3.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE 8-beat_Wrapping PACKET CLASS
//------------------------------------------

class seq4_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq4_vseq)

	//overriding constructor
	function new(string name="seq4_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq4 =ahb_sequence4::type_id::create("hseq4");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq4.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE 8-beat_Increment PACKET CLASS
//------------------------------------------

class seq5_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq5_vseq)

	//overriding constructor
	function new(string name="seq5_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq5 =ahb_sequence5::type_id::create("hseq5");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq5.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE 16-beat_Wrapping PACKET CLASS
//------------------------------------------

class seq6_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq6_vseq)

	//overriding constructor
	function new(string name="seq6_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq6 =ahb_sequence6::type_id::create("hseq6");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq6.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE 16-beat_Increment PACKET CLASS
//------------------------------------------

class seq7_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq7_vseq)

	//overriding constructor
	function new(string name="seq7_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq7 =ahb_sequence7::type_id::create("hseq7");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq7.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE IDLE-TRANS PACKET CLASS
//------------------------------------------

class seq_idle_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq_idle_vseq)

	//overriding constructor
	function new(string name="seq_idle_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq_idle =ahb_sequence_idle::type_id::create("hseq_idle");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq_idle.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass


//------------------------------------------
// VIRTUAL SEQUENCE IDLE-TRANS PACKET CLASS
//------------------------------------------

class seq_busy_vseq extends virtual_base_sequence;

	//factory registration
	`uvm_object_utils(seq_busy_vseq)

	//overriding constructor
	function new(string name="seq_busy_vseq");
		super.new(name);
	endfunction

	//task body
	task body();
		
		super.body();

		repeat(5) begin
   
		hseq_busy =ahb_sequence_busy::type_id::create("hseq_busy");
   
	 // pseq =apb_sequence::type_id::create("pseq");

		//start sequence on all source and dest sequencers 
		fork
			begin
				if(m_env_cfg.has_ahb_agent)
					begin
					for(int i=0;i<m_env_cfg.no_of_ahb_agent;i++)
						begin
						   hseq_busy.start(ahb_sqrh[i]);
						end
					end

			end
   
      /*
			begin
				if(m_env_cfg.has_apb_agent)
					begin
						for(int i=0;i<m_env_cfg.no_of_apb_agent;i++)
							begin
								//if(addr==i)
									pseq.start(apb_sqrh[i]);
							end
		
					end
			end
      */
      
		join
	end
endtask

endclass







