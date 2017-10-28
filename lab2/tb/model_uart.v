`timescale 1ns / 1ps

module model_uart(/*AUTOARG*/
   // Outputs
   TX,
   // Inputs
   RX
   );

   output TX;
   input  RX;

   parameter baud    = 115200;
   parameter bittime = 1000000000/baud;
   parameter name    = "UART0";
   
   reg [7:0] rxData;
   event     evBit;
   event     evByte;
   event     evTxBit;
   event     evTxByte;
   reg       TX;
	reg [55:0] ra;	//ADDED: includes contents of register a in 4 bytes
	//reg [7:0] reg_num; //ADDED: register number to display
	//reg		isRegNum; //ADDED: True if next byte is register number
   initial
     begin
        TX = 1'b1;
		  ra = 32'b0;	//ADDED
		  //isRegNum = 1'b1; //ADDED: First byte is register number
     end
   
   always @ (negedge RX)
     begin
        rxData[7:0] = 8'h0;
        #(0.5*bittime);
        repeat (8)
          begin
             #bittime ->evBit;
             //rxData[7:0] = {rxData[6:0],RX}; commment was originally here
             rxData[7:0] = {RX,rxData[7:1]};
          end
        ->evByte;
		  /*if (isRegNum) begin	//ADDED:if rxData is the register number, assign
				reg_num = rxData; //ADDED:
				isRegNum = 1'b0; // //ADDED: Have register number so set to false
		 end*/
		  if (rxData == 8'h0D || rxData == 8'h0A)	begin	//ADDED
					if (rxData == 8'h0D) begin //ADDED: if rx_data = carriage return \r
					//$display("%s%s%s%s%s%s%s", ra[55:48],ra[47:40], ra[39:32],ra[31:24], ra[23:16], ra[15:8], ra[7:0]); //ADDED
					$display("%s", ra);
					//isRegNum = 1'b1;	//ADDED: next byte is register number if hit carriage return 
					end
				end //ADDED
		  else 
				ra = {ra, rxData};	//ADDED: replace lsb byte with rxData
        //$display ("%d %s Received byte %02x (%s)", $stime, name, rxData, rxData); mycomment
     end

   task tskRxData;
      output [7:0] data;
      begin
         @(evByte);
         data = rxData;
      end
   endtask // for
      
   task tskTxData;
      input [7:0] data;
      reg [9:0]   tmp;
      integer     i;
      begin
         tmp = {1'b1, data[7:0], 1'b0};
         for (i=0;i<10;i=i+1)
           begin
              TX = tmp[i];
              #bittime;
              ->evTxBit;
           end
         ->evTxByte;
      end
   endtask // tskTxData
   
endmodule // model_uart
