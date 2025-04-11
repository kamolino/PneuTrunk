(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Client
 * File: Client.typ
 * Author: Bernecker + Rainer
 * Created: June 02, 2008
 ********************************************************************
 * Local data types of program Client
 ********************************************************************)

TYPE
	Client_typ : 	STRUCT  (*UDP Client Variables*)
		sStep : UINT; (*UDP Client Step Variable*)
		server_address : STRING[20]; (*Address of the Server*)
		server_portnumber : UINT; (*Portnumber of the Server*)
		no_data_received_count : UINT; (*Counts up if no data are received*)
		UdpOpen_0 : UdpOpen; (*AsUDP.UdpOpen FUB*)
		UdpConnect_0 : UdpConnect; (*AsUDP.UdpConnect FUB*)
		UdpSend_0 : UdpSend; (*AsUDP.UdpSend FUB*)
		UdpRecv_0 : UdpRecv; (*AsUDP.UdpRecv FUB*)
		UdpDisconnect_0 : UdpDisconnect; (*AsUDP.UdpDisconnect FUB*)
		UdpClose_0 : UdpClose; (*AsUDP.UdpClose FUB*)
		sendBuffer : STRING[255];
		tempString : STRING[50];
	END_STRUCT;
END_TYPE
