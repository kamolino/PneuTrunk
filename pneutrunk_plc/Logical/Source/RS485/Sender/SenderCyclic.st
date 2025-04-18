(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Sender
 * File: SenderCyclic.st
 * Author: Bernecker & Rainer
 * Created: January 25, 2010
 ********************************************************************
 * Implementation of program Sender
 ********************************************************************)

(*************init program**********************)
PROGRAM _INIT
	Sender.Commands.open_send := TRUE;												(*enable sender by default*)	
	packet485.sendPacketFinal[0] := 255;
	packet485.sendPacketFinal[1] := 255;
	packet485.sendPacketFinal[2] := 1;				// ID
	packet485.sendPacketFinal[3] := 1;
	packet485.sendPacketFinal[4] := 254;
	packet485.sendPacketFinal[5] := 254;
	Sender.step					 := FRM_WAIT;
END_PROGRAM

(*************cyclic program********************)
PROGRAM _CYCLIC


	CASE Sender.step OF
		FRM_WAIT:	(*--- wait for command*)
			
			IF Sender.Commands.open_send = TRUE THEN								(*command for sender activation*)
				Sender.step := FRM_OPEN;
   			END_IF			
		
			(*close will be requested in step FRM_WRITE*)
		
		FRM_OPEN:	(*--- open serial interface*)
			
			(*Parameters for FRM_xopen()*)
			Sender.FRM_xopen_0.enable := TRUE;
			Sender.FRM_xopen_0.device := ADR('IF6.ST1.IF1');										(*Devicename --> see your serial interface properties*)
			Sender.FRM_xopen_0.mode := ADR('/PHY=RS485 /BD=38400 /DB=8 /PA=N /SB=1'); 		(*Modestring --> specifies the seria operation mode*)
			Sender.FRM_xopen_0.config := ADR(Sender.xopenConfig) ;					(*Additional Parameters, optional*)
			
			(*Additional Parameters for FRM_xopen()*)
			Sender.xopenConfig.idle := 10;											(*Idle time between two characters*)
			Sender.xopenConfig.delimc := 0;											(*activate two delimeters*)
			Sender.xopenConfig.delim[0] := 0; 										(*CR - carridge return -> dec 13*)
			Sender.xopenConfig.delim[1] := 0; 										(*LF - line feed -> dec 10*)
			Sender.xopenConfig.tx_cnt := 3;											(*number of transmit buffers*)
			Sender.xopenConfig.rx_cnt := 3; 										(*number of receive buffers*)
			Sender.xopenConfig.tx_len := 256; 										(*length of transmit buffers*)
			Sender.xopenConfig.rx_len := 256; 										(*lenght of receive buffers*)
			Sender.xopenConfig.argc := 0;											(*activate additional options*)
			Sender.xopenConfig.argv := 0;											(*parameters for additional options (check help)*)
	
			Sender.FRM_xopen_0();													(*call the FRM_xopen() function*)
			
			IF Sender.FRM_xopen_0.status = 0 THEN
				Sender.step := FRM_GBUF;											(*Interface opend successfully --> next step*)
			ELSIF Sender.FRM_xopen_0.status = BUSY THEN
				Sender.step := FRM_OPEN;											(*operation not finished yet --> call again*)
			ELSE
				Sender.step := FRM_ERROR;											(*function returned errorcode --> check help*)
   			END_IF			
			
		FRM_GBUF:	(*--- aquire sendbuffer for FRM_WRITE*)
			Sender.FRM_gbuf_0.enable := TRUE;
   			Sender.FRM_gbuf_0.ident := Sender.FRM_xopen_0.ident;
			
			Sender.FRM_gbuf_0();													(*call the FRM_gbuf() function*)
			
			IF Sender.FRM_gbuf_0.status = 0 THEN
				memset(Sender.FRM_gbuf_0.buffer,0,Sender.FRM_gbuf_0.buflng);		(*clear sendbuffer*)
				Sender.step := FRM_PREPARE_SENDDATA;								(*system returned a valid buffer --> next step*)
			ELSIF Sender.FRM_gbuf_0.status = BUSY THEN
				Sender.step := FRM_GBUF;											(*operation not finished yet --> call again*)
			ELSE
				Sender.step := FRM_ERROR;											(*function returned errorcode --> check help*)
   			END_IF			
			
		
		FRM_PREPARE_SENDDATA: (*--- prepare senddata, copy data to sendbuffer*)
			
			IF packet485.id = 8 THEN
				packet485.id := 1;
			ELSE
				packet485.id := packet485.id + 1;
			END_IF
			Sender.Commands.open_send := TRUE;										(*enable sender by default*)	
			packet485.sendPacketFinal[0] := 255;
			packet485.sendPacketFinal[1] := 255;
			packet485.sendPacketFinal[2] := USINT_TO_BYTE(packet485.id);
			packet485.sendPacketFinal[3] := 1;
			packet485.sendPacketFinal[4] := 254;
			packet485.sendPacketFinal[5] := 254;
			packet485.sendPacketFinal[0] := 255;
			
			strcpy(Sender.FRM_gbuf_0.buffer,ADR(packet485.sendPacketFinal));		(*copy senddata to sendbuffer*)
			Sender.step := FRM_WRITE;												(*--> next step*)
		
		
		FRM_WRITE:	(*--- write data to interface*)
			
			(*Parameters for FRM_write()*)
			Sender.FRM_write_0.enable := TRUE;
			Sender.FRM_write_0.ident := Sender.FRM_xopen_0.ident;					(*ident from FRM_xopen()*)
			Sender.FRM_write_0.buffer := Sender.FRM_gbuf_0.buffer;					(*sendbuffer*)
			Sender.FRM_write_0.buflng := strlen(ADR(packet485.sendPacketFinal));				(*net length of senddata*)
   			
			Sender.FRM_write_0();													(*call the FRM_write() function*)
			
			IF Sender.FRM_write_0.status = 0 THEN
				IF Sender.Commands.close = TRUE THEN								(*requst to close the serial port*)
					Sender.Commands.open_send := FALSE;								(*disable command open_send*)
					Sender.step := FRM_CLOSE;
				ELSE
					Sender.step := FRM_GBUF;										(*writing successful --> get next sendbuffer*)
				END_IF
			ELSIF Sender.FRM_write_0.status = BUSY THEN
				Sender.step := FRM_WRITE;											(*operation not finished yet --> call again*)
			ELSE
				Sender.step := FRM_ROBUF;											(*function returned errorcode --> check help*)
   			END_IF			
			
		FRM_ROBUF:	(*--- release sendbuffer in case of no successful write operation*)
			Sender.FRM_robuf_0.enable := TRUE;
			Sender.FRM_robuf_0.buffer := Sender.FRM_gbuf_0.buffer;					(*sendbuffer*)
			Sender.FRM_robuf_0.buflng := Sender.FRM_gbuf_0.buflng;					(*buffer length*)
			Sender.FRM_robuf_0.ident := Sender.FRM_xopen_0.ident;					(*ident open*)
		
			Sender.FRM_robuf_0();													(*call the FRM_robuf() function*)
		
			IF Sender.FRM_robuf_0.status = 0 THEN
				Sender.step := FRM_GBUF;											(*released buffer successful --> get next sendbuffer*)
			ELSIF Sender.FRM_robuf_0.status = BUSY THEN
				Sender.step := FRM_ROBUF;											(*operation not finished yet --> call again*)
			ELSE
				Sender.step := FRM_ERROR;											(*function returned errorcode --> check help*)
   			END_IF			
		
		FRM_CLOSE:	(*--- close the interface*)
			Sender.FRM_close_0.enable := TRUE;
   			Sender.FRM_close_0.ident := Sender.FRM_xopen_0.ident;					(*ident from FRM_xopen()*)			
			
			Sender.FRM_close_0();													(*call the FRM_close() function*)
			
			IF Sender.FRM_close_0.status = 0 THEN
				Sender.Commands.close := FALSE;										(*disable close command*)
				Sender.step := FRM_WAIT;											(*closed interface successfully --> wait step*)
			ELSIF Sender.FRM_close_0.status = BUSY THEN
				Sender.step := FRM_CLOSE;											(*operation not finished yet --> call again*)
			ELSE
				Sender.step := FRM_ERROR;											(*function returned errorcode --> check help*)
			END_IF
			
		FRM_ERROR:	(*--- error handling*)
			Sender.step := FRM_WAIT;
			//; (*not implementet yet, check help for error codes*)
 	END_CASE	


END_PROGRAM
