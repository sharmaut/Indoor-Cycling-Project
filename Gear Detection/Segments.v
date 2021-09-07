module Segments(bcd, segment);
     
     //Declare inputs,outputs and internal variables.
     input [3:0] bcd;
     output reg [6:0] segment;

	 //always block for converting bcd digit into 7 segment format
    always @(bcd)
    begin
        case (bcd) //case statement
            0 : segment = 7'b0000001;
            1 : segment = 7'b1001111;
            2 : segment = 7'b0010010;
            3 : segment = 7'b0000110;
            4 : segment = 7'b1001100;
            5 : segment = 7'b0100100;
            6 : segment = 7'b0100000;
            7 : segment = 7'b0001111;
            8 : segment = 7'b0000000;
            9 : segment = 7'b0000100;
            //switch off 7 segment character 
            default : segment = 7'b1111111; 
        endcase
    end
    
endmodule 