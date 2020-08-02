// For flush 

module flush( branch, zero, out);

	input branch;
	input [1:0] zero;
	output reg out;
	
	initial begin
		out <= 0;
		end

	always @ (*) begin

		if( branch) begin
			if(zero != 00) begin
				out <= 1;
				end
			end
		else begin
				out <= 0;
			 end

	end
endmodule