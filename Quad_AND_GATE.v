`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
 
// Create Date: 29.01.2025 16:36:08
// Design Name: 
// Module Name: Quad_AND_GATE
// Project Name: Quad 2 input AND Gate, Digital Ic design which is performed on the logic inputs and output 
// there have several input pins with respect to power pins

// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// this project we are designing the Quad Input and Gate using simple And Gate Operation
//there is also mention of the operation of the 78HC08D IC which has 8 input pins, 4 output pins, and 2 power pins

module Quad_AND_GATE(
     input A, B, // we are declared the inputs pins 
     input VCC, VSS, // power pin input 
     output Y    // we are declared the output pins 
    );
    

  
wire Not;  // this is used to convert the output as inverters

//// we are taken two veritable for the power supply  
    
//    supply1 vcc_power;
//    supply0 vss_power;
    
////there assigned the values using the non blocking assigned statement
//assign VCC = vcc_power; // this is the VCC power to always 1
//assign VSS = ~vss_power;   // this is vss power which is inverted 0 to 1

//we are using simple assignment statement for entire operations
 
assign Not = ~(A & B & VCC & VSS);
assign Y = ~Not;  // Gate level convertes

      
    initial 
     $display("[T=%t], A = %d, B = %d, Not = %d, VCC = %d, VSS = %d,",$time,A,B,Not,VCC,VSS);
endmodule


module generator  // thie also number of output
    (  input A1, B1, A2, B2, A3, B3, A4, B4,  // vector size for each A[0] to A[4] , B[0] to B[4].
       input  vcc, vss,
       output Y1, Y2, Y3, Y4); 
   
//We are creating the generate to generate the number of gates instance 
  genvar num_of;  // variable of the generator
    
    generate
     for(num_of = 0; num_of < 4; num_of = num_of + 1) begin
        if(num_of == 0) begin
           Quad_AND_GATE Quad_ANDS(
            .A(A1), .B(B1), . Y(Y1), .VSS(vcc), .VCC(vcc));
            
        end if(num_of == 1)begin
          Quad_AND_GATE Quad_ANDS(
            .A(A2), .B(B2), . Y(Y2), .VCC(vcc), .VSS(vss));
        
        end if(num_of == 2) begin
          Quad_AND_GATE Quad_ANDS(
            .A(A3), .B(B3), . Y(Y3), .VCC(vcc), .VSS(vss));
            
        end if(num_of == 3)begin
        Quad_AND_GATE Quad_ANDS(
            .A(A4), .B(B4), . Y(Y4), .VCC(vcc), .VSS(vss));
         end
       end
    endgenerate
endmodule


//we are creating the test bench to assign the value to the sub_generate module

module test_bech;
    
    
//   we are also taking the input-output port to connect the above module
    reg [3:0] A, B;
    wire [3:0] Y;
    wire vcc,vss;
    integer i;
    
    
//  we are create the supplies data type variable and assign the values
  supply1 vcc_power;
  supply0 vss_power;
  
//We are assign directly to the VCC and vss variables

assign vcc = vcc_power;  
assign vss = ~vss_power;

//   There is create the global instance to assign the values;
  generator  Quad_2_AND_GATE(
    .A1(A[0]), .B1(B[0]), .Y1(Y[0]), .vcc(vcc), .vss(vss),
    .A2(A[1]), .B2(B[1]), .Y2(Y[1]),
    .A3(A[2]), .B3(B[2]), .Y3(Y[2]),
    .A4(A[3]), .B4(B[3]), .Y4(Y[3]));
    
  
//  we are assigning the values in different forms and print it 
   
   initial begin
//      we are assigned values using concatenation operators     
    for( i = 0; i < 4; i = i + 1) begin
       {A,B} = i;  // concatenation operators
       #10;
       $monitor("[T=%t], A[]=%d, B[]=%d ,Y[]=%d, VCC=%d, VSS=%d",$time, A[i], B[i] ,Y[i], vcc,vss);
      end
     $finish;
     end
 endmodule
