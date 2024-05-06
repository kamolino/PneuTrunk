PROGRAM _CYCLIC
	
	TON_0(IN := kalibraciaStart, PT := T#5s0ms);
		
	CASE step OF
		
		0:  // Detekcia referencnej polohy
			IF switch2 = FALSE THEN
				switch2 := TRUE;
				FOR id:=0 TO 6 BY 1 DO
					modul.tlak1[id]	:= REAL_TO_INT(0);
					modul.tlak2[id]	:= REAL_TO_INT(0);
					modul.tlak3[id]	:= REAL_TO_INT(0);
					packetPos.qDesired[id*2] := 0;
					packetPos.qDesired[id*2+1] := 0;
					automatika.x_desired[id]	:= 0;
					automatika.y_desired[id]	:= 0;
				END_FOR
				
			END_IF
			

			IF stlacene = TRUE AND centralStop = TRUE THEN
				IF switch = FALSE THEN
					switch 			:= TRUE;
					kalibraciaStart := TRUE;
					FOR id:=0 TO 6 BY 1 DO
						modul.tlak1[id]	:= REAL_TO_INT(4*32767/9);
						modul.tlak2[id]	:= REAL_TO_INT(4*32767/9);
						modul.tlak3[id]	:= REAL_TO_INT(4*32767/9);
					END_FOR
				END_IF
				
				IF switch = TRUE AND TON_0.Q = TRUE THEN
					switch			:= FALSE;
					kalibraciaStart	:= FALSE;
					step			:= 1;
				END_IF	
			END_IF
			global_step				:= 0;
			
			
		1:	// Vypustenie vzduchu zo vsetkych mechov, zapnutie I-regulatora 
			
			FOR id:=0 TO 6 BY 1 DO
				modul.tlak1[id]	:= 0;
				modul.tlak2[id]	:= 0;
				modul.tlak3[id]	:= 0;
			END_FOR
			//I_ON					:= TRUE;
			switch2 				:= FALSE;
			kalibraciaStart			:= TRUE;
			step					:= 2;
		
		2:
			IF TON_0.Q = TRUE THEN
				kalibraciaStart		:= FALSE;
				step				:= 3;
			END_IF
			
		3:
			FOR id:=0 TO 6 BY 1 DO
				modull.nula_x[id]:= modul.uhol1[id];
				modull.nula_y[id]:= modul.uhol2[id];
			END_FOR
			step					:= 4;
			I_ON					:= TRUE;
			global_step := 1;
			
		4:
			ball_popcorn.ball		:= automatika.ball_up;
			ball_popcorn.ball_piston:= automatika.ball_piston;
			ball_popcorn.popcorn	:= automatika.popcorn;
			modull.efektor			:= automatika.effector;
			
			
			IF stlacene = TRUE AND centralStop = TRUE THEN
				FOR id:=0 TO 6 BY 1 DO
					modull.real_uhol_x_kalibrovane[id]	:= modul.uhol1[id];
					modull.real_uhol_y_kalibrovane[id]	:= modul.uhol2[id];
					modul.uhol_XminusRef[id] 			:= modull.real_uhol_x_kalibrovane[id] - modull.nula_x[id];
					modul.uhol_YminusRef[id] 			:= modull.real_uhol_y_kalibrovane[id] - modull.nula_y[id];
					modul.linearReal		 			:= ref_linearny_posun;
				END_FOR
				
				IF automatika.automatic = TRUE THEN
					IF automatika.holdPosition = FALSE THEN
						FOR id:=0 TO 6 BY 1 DO
							modull.pozadovany_uhol_y[id]	:=  packetPos.qDesired[id*2];
							modull.pozadovany_uhol_x[id]	:= -packetPos.qDesired[id*2+1];
						END_FOR
						modull.pozadovanyLinear				:= packetPos.qDesired[14]*7/25 + 23;
					END_IF
				ELSE
					FOR id:=0 TO 6 BY 1 DO
						modull.pozadovany_uhol_x[id]	:= automatika.x_desired[id];
						modull.pozadovany_uhol_y[id] 	:= automatika.y_desired[id];
					END_FOR
					modull.pozadovanyLinear				:= automatika.linear;
				END_IF

				// Joint limits
				FOR id:=0 TO 6 BY 1 DO
					IF modull.pozadovany_uhol_x[id] >= maxUhol THEN
						modull.pozadovany_uhol_x[id]	:= maxUhol;
					ELSIF modull.pozadovany_uhol_x[id] <= - maxUhol THEN
						modull.pozadovany_uhol_x[id] := -maxUhol;
					END_IF
			
					IF modull.pozadovany_uhol_y[id] >= maxUhol THEN
						modull.pozadovany_uhol_y[id]	:= maxUhol;
					ELSIF modull.pozadovany_uhol_y[id] <= - maxUhol THEN
						modull.pozadovany_uhol_y[id] := -maxUhol;
					END_IF
			
				END_FOR
				
				//regulatory solo_feed_forward
				(*
				IF cos_test=TRUE THEN
					
					modull.pozadovany_uhol_x[0]:=cos_test_hodnota1;
					modull.pozadovany_uhol_x[1]:=cos_test_hodnota1;
					modull.pozadovany_uhol_x[2]:=cos_test_hodnota1;
					modull.pozadovany_uhol_x[3]:=cos_test_hodnota1;
					modull.pozadovany_uhol_x[4]:=cos_test_hodnota1;
					modull.pozadovany_uhol_x[5]:=cos_test_hodnota1;
					
					modull.pozadovany_uhol_y[0]:=cos_test_hodnota2;
					modull.pozadovany_uhol_y[1]:=cos_test_hodnota2;
					modull.pozadovany_uhol_y[2]:=cos_test_hodnota2;
					modull.pozadovany_uhol_y[3]:=cos_test_hodnota2;
					modull.pozadovany_uhol_y[4]:=cos_test_hodnota2;
					modull.pozadovany_uhol_y[5]:=cos_test_hodnota2;
					
					
					
					END_IF
					*)
				
				
				ref_alfa_x_ID1:= modull.pozadovany_uhol_x[0];
				ref_alfa_y_ID1:= modull.pozadovany_uhol_y[0];
				ref_alfa_x_ID2:= modull.pozadovany_uhol_x[1];
				ref_alfa_y_ID2:= modull.pozadovany_uhol_y[1];
				ref_alfa_x_ID3:= modull.pozadovany_uhol_x[2];
				ref_alfa_y_ID3:= modull.pozadovany_uhol_y[2];	
				ref_alfa_x_ID4:= modull.pozadovany_uhol_x[3];
				ref_alfa_y_ID4:= modull.pozadovany_uhol_y[3];
				ref_alfa_x_ID5:= modull.pozadovany_uhol_x[4];
				ref_alfa_y_ID5:= modull.pozadovany_uhol_y[4];
				ref_alfa_x_ID6:= modull.pozadovany_uhol_x[5];
				ref_alfa_y_ID6:= modull.pozadovany_uhol_y[5];
				ref_alfa_x_ID7:= modull.pozadovany_uhol_x[6];
				ref_alfa_y_ID7:= modull.pozadovany_uhol_y[6];
				
				// Obmedzenie pre linearny posun (ak je hodnota nad 30 regulator sa sprava divne, nechce sa vypnut)
				IF modull.pozadovanyLinear >30 THEN
					ref_linearny_posun	:= 30;
				ELSIF modull.pozadovanyLinear <23 THEN
					ref_linearny_posun	:= 23;
				ELSE
					ref_linearny_posun	:= modull.pozadovanyLinear;
				END_IF
				
				
				act_alfa_x_ID1:= modull.real_uhol_x_kalibrovane[0] - modull.nula_x[0];
				act_alfa_y_ID1:= modull.real_uhol_y_kalibrovane[0] - modull.nula_y[0];
				act_alfa_x_ID2:= modull.real_uhol_x_kalibrovane[1] - modull.nula_x[1];
				act_alfa_y_ID2:= modull.real_uhol_y_kalibrovane[1] - modull.nula_y[1];
				act_alfa_x_ID3:= modull.real_uhol_x_kalibrovane[2] - modull.nula_x[2];
				act_alfa_y_ID3:= modull.real_uhol_y_kalibrovane[2] - modull.nula_y[2];
				act_alfa_x_ID4:= modull.real_uhol_x_kalibrovane[3] - modull.nula_x[3];
				act_alfa_y_ID4:= modull.real_uhol_y_kalibrovane[3] - modull.nula_y[3];
				act_alfa_x_ID5:= modull.real_uhol_x_kalibrovane[4] - modull.nula_x[4];
				act_alfa_y_ID5:= modull.real_uhol_y_kalibrovane[4] - modull.nula_y[4];
				act_alfa_x_ID6:= modull.real_uhol_x_kalibrovane[5] - modull.nula_x[5];
				act_alfa_y_ID6:= modull.real_uhol_y_kalibrovane[5] - modull.nula_y[5];
				act_alfa_x_ID7:= modull.real_uhol_x_kalibrovane[6] - modull.nula_x[6];
				act_alfa_y_ID7:= modull.real_uhol_y_kalibrovane[6] - modull.nula_y[6];
				
				
				// Nastavenie tlakov podla regulacie
				// ID1
				id:=0;
				modul.tlak1[id] := REAL_TO_INT(Blue_tab_ID1*32767/9);		
				modul.tlak2[id] := REAL_TO_INT(Green_tab_ID1*32767/9);
				modul.tlak3[id] := REAL_TO_INT(Yellow_tab_ID1*32767/9);
		
				// ID2
				id:=1;
				modul.tlak1[id] := REAL_TO_INT(Blue_tab_ID2*32767/9);		
				modul.tlak2[id] := REAL_TO_INT(Green_tab_ID2*32767/9);
				modul.tlak3[id] := REAL_TO_INT(Yellow_tab_ID2*32767/9);
		
				// ID3
				id:=2;
				modul.tlak1[id] := REAL_TO_INT(Blue_tab_ID3*32767/9);		
				modul.tlak2[id] := REAL_TO_INT(Green_tab_ID3*32767/9);
				modul.tlak3[id] := REAL_TO_INT(Yellow_tab_ID3*32767/9);
		
				// ID4
				id:=3;
				modul.tlak1[id] := REAL_TO_INT(Blue_tab_ID4*32767/9);		
				modul.tlak2[id] := REAL_TO_INT(Green_tab_ID4*32767/9);
				modul.tlak3[id] := REAL_TO_INT(Yellow_tab_ID4*32767/9);
		
				// ID5
				id:=4;
				modul.tlak1[id] := REAL_TO_INT(Blue_tab_ID5*32767/9);		
				modul.tlak2[id] := REAL_TO_INT(Green_tab_ID5*32767/9);
				modul.tlak3[id] := REAL_TO_INT(Yellow_tab_ID5*32767/9);
		
				// ID6
				id:=5;
				modul.tlak1[id] := REAL_TO_INT(Blue_tab_ID6*32767/9);		
				modul.tlak2[id] := REAL_TO_INT(Green_tab_ID6*32767/9);
				modul.tlak3[id] := REAL_TO_INT(Yellow_tab_ID6*32767/9);
				
				// ID7
				id:=6;
				modul.tlak3[id] := REAL_TO_INT(Blue_tab_ID7*32767/9);		
				modul.tlak1[id] := REAL_TO_INT(Green_tab_ID7*32767/9);
				modul.tlak2[id] := REAL_TO_INT(Yellow_tab_ID7*32767/9);
		
				//lin_modul
				modul.tlakLinear:= REAL_TO_INT(lin_pressure*32767/9);
				
			ELSIF centralStop = FALSE OR stlacene = FALSE THEN
				stlacene	:= FALSE;
				switch		:= FALSE;
				I_ON		:= FALSE;
				step		:= 0;
				FOR i:=0 TO 6 BY 1 DO
					modul.tlak1[i] := 0;
					modul.tlak2[i] := 0;
					modul.tlak3[i] := 0;
				END_FOR
				modul.tlakLinear:= 0;
				modull.efektor	:= FALSE;
				modull.pozadovanyLinear	:= 23;
				ball_popcorn.ball		:= FALSE;
				ball_popcorn.ball_piston:= FALSE;
			END_IF
			
	END_CASE
	
	IF I_ON= TRUE THEN
		RESET_ID1:= TRUE;
		RESET_ID2:= TRUE;
		RESET_ID3:= TRUE;
		RESET_ID4:= TRUE;
		RESET_ID5:= TRUE;
		RESET_ID6:= TRUE;
		RESET_ID7:= TRUE;
	ELSE	
		RESET_ID1:= FALSE;
		RESET_ID2:= FALSE;
		RESET_ID3:= FALSE;
		RESET_ID4:= FALSE;
		RESET_ID5:= FALSE;
		RESET_ID6:= FALSE;
		RESET_ID7:= FALSE;
	END_IF
	
	I_konstanta_ID1;
	I_konstanta_ID2;
	I_konstanta_ID3;
	I_konstanta_ID4;
	I_konstanta_ID5;
	I_konstanta_ID6;
	I_konstanta_ID7;
	
END_PROGRAM
