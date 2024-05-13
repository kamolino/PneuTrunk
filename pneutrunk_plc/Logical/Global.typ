
TYPE
	tlacidla : 	STRUCT 
		start : BOOL;
		ros : BOOL;
		stopLED : BOOL;
		stop : BOOL;
		startLED : BOOL;
		startButton : BOOL;
		centralStop : BOOL;
		stropBielaLED : BOOL;
		stropCervenaLED : BOOL;
	END_STRUCT;
	automatic : 	STRUCT 
		y_desired : ARRAY[0..6]OF INT := [7(0)];
		x_desired : ARRAY[0..6]OF INT := [7(0)];
		linear : INT;
		ball_up : BOOL;
		casovac : BOOL;
		effector : BOOL;
		casovac_uchopenie : BOOL;
		ball_piston : BOOL;
		novyCyklus : TIME := T#1s;
		novyCyklusStart : BOOL;
		trajectoryStart2 : BOOL;
		trajectoryTime2 : TIME := T#6s;
		automatic : BOOL;
		holdPosition : BOOL;
		cas : INT;
		box : INT;
		step_color : INT;
		popcorn : BOOL;
		testFarba : INT;
		loptickyVzasobniku : BOOL := TRUE;
		x_desired_previous : ARRAY[0..6]OF INT;
		y_desired_previous : ARRAY[0..6]OF INT;
		I_konstanta : ARRAY[0..6]OF INT;
		levitacia : BOOL;
	END_STRUCT;
	podavac : 	STRUCT 
		levitovanie : BOOL;
		ball_piston_sjf : BOOL;
		ball : BOOL;
		ball_piston : BOOL;
	END_STRUCT;
	identifikacia : 	STRUCT 
		p3 : REAL;
		p2 : REAL;
		p1 : REAL;
		vzorka : USINT;
		uhol2 : ARRAY[0..9]OF INT;
		uhol2Priemer : INT;
		uhol1Priemer : INT;
		uhol1 : ARRAY[0..9]OF INT;
		uhol2Stabilny : BOOL;
		uhol1Stabilny : BOOL;
		uhol2Ref : INT;
		uhol1Ref : INT;
		krok : USINT;
		p2Mem : REAL;
		p1Mem : REAL;
		tonStart : BOOL;
		pocetOverenie : USINT := 10;
		spustit : BOOL;
		p3Koniec : BOOL;
		p2Koniec : BOOL;
		p1Koniec : BOOL;
		p3Mem : REAL;
		results : INT;
		switchs : BOOL;
		inkrement : REAL;
		hornyTlak : REAL;
	END_STRUCT;
	packetRS485 : 	STRUCT 
		packet : ARRAY[0..9]OF BYTE;
		sendPacketLED : ARRAY[0..5]OF BYTE;
		sendPacketSnimace : ARRAY[0..5]OF BYTE;
		sendPacketFinal : ARRAY[0..5]OF BYTE;
		id : USINT;
	END_STRUCT;
	packetUDP : 	STRUCT 
		qLength : INT;
		c : INT;
		q : INT;
		qFull : STRING[80];
		comma : INT;
		qString : ARRAY[0..14]OF STRING[6];
		qDesired : ARRAY[0..14]OF REAL;
		color : INT;
		step : INT;
	END_STRUCT;
	tlaky : 	STRUCT 
		tlak3 : USINT;
		tlak2 : USINT;
		tlak1 : USINT;
	END_STRUCT;
	moduly : 	STRUCT 
		uhol2 : ARRAY[0..6]OF INT := [7(0)];
		uhol1 : ARRAY[0..6]OF INT := [7(0)];
		koncak : ARRAY[0..6]OF BOOL;
		led : ARRAY[0..6]OF BOOL;
		uholINT2 : INT;
		uholINT1 : INT;
		tlak1 : ARRAY[0..6]OF INT;
		tlak2 : ARRAY[0..6]OF INT;
		tlak3 : ARRAY[0..6]OF INT;
		tlakLinear : INT;
		uhol_XminusRef : ARRAY[0..6]OF REAL; (*uhol ktory posiela PLC do PC po odpocitani odchylky naklonenia realneho robota*)
		uhol_YminusRef : ARRAY[0..6]OF REAL; (*uhol ktory posiela PLC do PC po odpocitani odchylky naklonenia realneho robota*)
		linearReal : REAL;
		naraz : ARRAY[0..7]OF BOOL;
		narazAktivny : BOOL;
	END_STRUCT;
END_TYPE
