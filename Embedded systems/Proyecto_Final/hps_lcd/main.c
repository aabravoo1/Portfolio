// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================

#include "terasic_os_includes.h"
#include "LCD_Lib.h"
#include "lcd_graphic.h"
#include "font.h"
#include <math.h>
#include <stdio.h>


#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

#define PS2_REG (volatile int *) 0x000000000
#define READY (volatile int *)   0x000000000

int short number1[5] = {0,0,0,0,0};
int short operation;
int short number2[5] = {0,0,0,0,0};

int operand1;
int operand2;
int result;

LCD_CANVAS LcdCanvas;

int main() {

	void *virtual_base;
	int fd;

		
	// map the address space for the LED registers into user space so we can interact with them.
	// we'll actually map in the entire CSR span of the HPS since we want to access various registers within that span
	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}

	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );



	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}


		
	//printf("Can you see LCD?(CTRL+C to terminate this program)\r\n");
	printf("Graphic LCD Demo\r\n");
		
		LcdCanvas.Width = LCD_WIDTH;
		LcdCanvas.Height = LCD_HEIGHT;
		LcdCanvas.BitPerPixel = 1;
		LcdCanvas.FrameSize = LcdCanvas.Width * LcdCanvas.Height / 8;
		LcdCanvas.pFrame = (void *)malloc(LcdCanvas.FrameSize);
		
	if (LcdCanvas.pFrame == NULL){
			printf("failed to allocate lcd frame buffer\r\n");
	}else{			
		
	
		LCDHW_Init(virtual_base);
		LCDHW_BackLight(true); // turn on LCD backlight
		
    LCD_Init();
   
    // clear screen
    DRAW_Clear(&LcdCanvas, LCD_WHITE);

		// demo grphic api    
    DRAW_Rect(&LcdCanvas, 0,0, LcdCanvas.Width-1, LcdCanvas.Height-1, LCD_BLACK); // retangle
    DRAW_Circle(&LcdCanvas, 10, 10, 6, LCD_BLACK);
    DRAW_Circle(&LcdCanvas, LcdCanvas.Width-10, 10, 6, LCD_BLACK);
    DRAW_Circle(&LcdCanvas, LcdCanvas.Width-10, LcdCanvas.Height-10, 6, LCD_BLACK);
    DRAW_Circle(&LcdCanvas, 10, LcdCanvas.Height-10, 6, LCD_BLACK);
    
    // demo font
    DRAW_PrintString(&LcdCanvas, 40, 5, "Hello", LCD_BLACK, &font_16x16);
    DRAW_PrintString(&LcdCanvas, 40, 5+16, "SoCFPGA", LCD_BLACK, &font_16x16);
	 DRAW_PrintString(&LcdCanvas, 40, 5+32, "Terasic ", LCD_BLACK, &font_16x16);
	 DRAW_PrintString(&LcdCanvas, 0, 5+40, "Me gustan los chetos", LCD_BLACK, &font_16x16);
    DRAW_Refresh(&LcdCanvas);
    
    
    free(LcdCanvas.pFrame);
	}    
	
	int short flag;
	int short counter;
	while (1){
		int short read_poll = poll();
		if(read_poll == 1){
			if (flag == 0){
				if(counter < 5){
					number1[counter] = *PS2_REG;
					counter++;
					print_line(counter, number1[counter]);
				}//if more than 5 numbers are entered nothing happens
			}else if(flag == 1){
				if(counter < 5){
					number2[counter] = *PS2_REG;
					counter++;
				}//if more than 5 numbers are entered nothing happens
			}
		}else if(read_poll == 2){
			counter = 0;
			flag = 1;
			make_operand(1);
			operation = *PS2_REG;
			print_line(6, operation);
			
		}else if(read_poll == 3){
			counter = 0;
			make_operand(2);
			calculate();
		}else if(read_poll == 4){
			flag = 0;
			counter = 0;
			 // clear screen
			DRAW_Clear(&LcdCanvas, LCD_WHITE);
			
		}
	}
  
	// clean up our memory mapping and exit
	
	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );
}

int poll(){
	int ready = *READY;
	if(ready){
		*READY = 0;
		if (*PS2_REG == 10 || *PS2_REG == 11 || *PS2_REG == 12 || *PS2_REG == 13){
			return 2;//if return is 2 it is operation
		}else if(*PS2_REG == 14){
			return 3;//if return is 3 it is enter
		}else if(*PS2_REG == 15){
			return 4;//if return is 4 it is clear
		}else{
			return 1;//if return is 1 it is a number
		}
	}else{
		return 0;//nothing to be read
	}
}
void make_operand(int op){
	int i;
	if(op == 1){
		for (i = 0; i < 5; i++){
			operand1 = number1[i]*pow(10,i);
		}
	}else if(op == 2){
		for (i = 0; i < 5; i++){
			operand2 = number2[i]*pow(10,i);
		}
	}
}

void calculate(){
	switch(operation){
		case 10:
			result = operand1 + operand2;
		case 11:
			result = operand1 - operand2;
		case 12:
			result = operand1/operand2;
		case 13:
			result = operand1*operand2;
	}
	print_result();
}

void print_line(int short position, int short number){
	char Char;
	if(number > 9){
		switch(number){
			case 10:
				Char = '+';
			case 11:
				Char = '-';
			case 12:
				Char = '*';
			case 13:
				Char = '/';
		}
	}else{
		Char  = number;
	}
	DRAW_PrintString(&LcdCanvas, position, 5, Char, LCD_BLACK, &font_16x16);
	DRAW_Refresh(&LcdCanvas);
	
}

void print_result(){
	char str[10];
	snprintf(str, sizeof(str), "%d", result);
	DRAW_PrintString(&LcdCanvas, 40, 5+16, str, LCD_BLACK, &font_16x16);
	DRAW_Refresh(&LcdCanvas);
}
