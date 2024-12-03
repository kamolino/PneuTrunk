PROGRAM _CYCLIC
	
	TON_0(IN := casovac_start, PT := INT_TO_TIME(automatika.cas));
	TON_1(IN := pauza, PT := T#10s0ms);
	TON_2(IN := kameraBool, PT := T#1s0ms);
	
	IF step = 4 THEN
		
		CASE automatika.step_repeatability OF 
			0:
				casovac_start					:= TRUE;
				automatika.step_repeatability	:= 1;
				automatika.repeatability		:= TRUE;
				automatika.cas					:= 5000;
				
			1:	// Point A
				automatika.desiredPressure1[0]:= TIME_TO_INT(TON_0.ET)*1669/((automatika.cas));
				automatika.desiredPressure1[1]:= TIME_TO_INT(TON_0.ET)*3013/((automatika.cas));
				automatika.desiredPressure1[2]:= TIME_TO_INT(TON_0.ET)*(-4146)/((automatika.cas));
				automatika.desiredPressure1[3]:= TIME_TO_INT(TON_0.ET)*(-8424)/((automatika.cas));
				automatika.desiredPressure1[4]:= TIME_TO_INT(TON_0.ET)*335/((automatika.cas));
				automatika.desiredPressure1[5]:= TIME_TO_INT(TON_0.ET)*2453/((automatika.cas));
				automatika.desiredPressure1[6]:= TIME_TO_INT(TON_0.ET)*6053/((automatika.cas));
			
				automatika.desiredPressure2[0]:= TIME_TO_INT(TON_0.ET)*6958/((automatika.cas));
				automatika.desiredPressure2[1]:= TIME_TO_INT(TON_0.ET)*4381/((automatika.cas));
				automatika.desiredPressure2[2]:= TIME_TO_INT(TON_0.ET)*12008/((automatika.cas));
				automatika.desiredPressure2[3]:= TIME_TO_INT(TON_0.ET)*13312/((automatika.cas));
				automatika.desiredPressure2[4]:= TIME_TO_INT(TON_0.ET)*8361/((automatika.cas));
				automatika.desiredPressure2[5]:= TIME_TO_INT(TON_0.ET)*6761/((automatika.cas));
				automatika.desiredPressure2[6]:= TIME_TO_INT(TON_0.ET)*3567/((automatika.cas));
			
				automatika.desiredPressure3[0]:= TIME_TO_INT(TON_0.ET)*4006/((automatika.cas));
				automatika.desiredPressure3[1]:= TIME_TO_INT(TON_0.ET)*5379/((automatika.cas));
				automatika.desiredPressure3[2]:= TIME_TO_INT(TON_0.ET)*5605/((automatika.cas));
				automatika.desiredPressure3[3]:= TIME_TO_INT(TON_0.ET)*3560/((automatika.cas));
				automatika.desiredPressure3[4]:= TIME_TO_INT(TON_0.ET)*3900/((automatika.cas));
				automatika.desiredPressure3[5]:= TIME_TO_INT(TON_0.ET)*3205/((automatika.cas));
				automatika.desiredPressure3[6]:= TIME_TO_INT(TON_0.ET)*2770/((automatika.cas));
			
				automatika.desiredPressureLinear := TIME_TO_INT(TON_0.ET)*10800/((automatika.cas));
			
				IF TON_0.Q = TRUE THEN
					casovac_start					:= FALSE;
					automatika.step_repeatability	:= 2;
					FOR i:=0 TO 6 BY 1 DO
						automatika.desiredPressure1_previous[i]		:= automatika.desiredPressure1[i];
						automatika.desiredPressure2_previous[i]		:= automatika.desiredPressure2[i];
						automatika.desiredPressure3_previous[i]		:= automatika.desiredPressure3[i];
					END_FOR
				END_IF
				
			2:	// Pause 
				pauza								:= TRUE;
				automatika.step_repeatability		:= 3;
			3:
				IF TON_1.Q = TRUE THEN
					pauza							:= FALSE;
					automatika.step_repeatability	:= 44;
					casovac_start					:= TRUE;
					kameraBool						:= TRUE;
				END_IF				
			44:
				IF TON_2.Q = TRUE THEN
					kameraBool						:= FALSE;
					automatika.step_repeatability	:= 4;
				END_IF
			
			4:	// Point B
				automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5403)/(automatika.cas);
				automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5622)/(automatika.cas);
				automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7940)/(automatika.cas);
				automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6420)/(automatika.cas);
				automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8355)/(automatika.cas);
				automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6516)/(automatika.cas);
				automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(565)/(automatika.cas);
				
				automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1406)/(automatika.cas);
				automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2287)/(automatika.cas);
				automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(271)/(automatika.cas);
				automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2520)/(automatika.cas);
				automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(829)/(automatika.cas);
				automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1928)/(automatika.cas);
				automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4860)/(automatika.cas);
				
				automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5933)/(automatika.cas);
				automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4731)/(automatika.cas);
				automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4820)/(automatika.cas);
				automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3573)/(automatika.cas);
				automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3796)/(automatika.cas);
				automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4104)/(automatika.cas);
				automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7462)/(automatika.cas);
				
				automatika.desiredPressureLinear := TIME_TO_INT(TON_0.ET)*10800/((automatika.cas));
				
				IF TON_0.Q = TRUE THEN
					casovac_start					:= FALSE;
					automatika.step_repeatability	:= 5;
					FOR i:=0 TO 6 BY 1 DO
						automatika.desiredPressure1_previous[i]	:= automatika.desiredPressure1[i];
						automatika.desiredPressure2_previous[i]	:= automatika.desiredPressure2[i];
						automatika.desiredPressure3_previous[i]	:= automatika.desiredPressure3[i];
					END_FOR
				END_IF
			5:	// Pause
				pauza								:= TRUE;
				automatika.step_repeatability		:= 6;
			6:
				IF TON_1.Q = TRUE THEN
					pauza							:= FALSE;
					automatika.step_repeatability	:= 77;
					casovac_start					:= TRUE;
					kameraBool						:= TRUE;
				END_IF
			77: 
				IF TON_2.Q = TRUE THEN
					kameraBool						:= FALSE;
					automatika.step_repeatability	:= 7;
				END_IF
			
			7:	// Point A
				automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1669)/(automatika.cas);
				automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3013)/(automatika.cas);
				automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-4146)/(automatika.cas);
				automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-8424)/(automatika.cas);
				automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(335)/(automatika.cas);
				automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2453)/(automatika.cas);
				automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6053)/(automatika.cas);
				
				automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6958)/(automatika.cas);
				automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4381)/(automatika.cas);
				automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(12008)/(automatika.cas);
				automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(13312)/(automatika.cas);
				automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8361)/(automatika.cas);
				automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6761)/(automatika.cas);
				automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3567)/(automatika.cas);
				
				automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4006)/(automatika.cas);
				automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5379)/(automatika.cas);
				automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5605)/(automatika.cas);
				automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3560)/(automatika.cas);
				automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3900)/(automatika.cas);
				automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3205)/(automatika.cas);
				automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2770)/(automatika.cas);
				
				automatika.desiredPressureLinear := TIME_TO_INT(TON_0.ET)*10800/((automatika.cas));
			
				IF TON_0.Q = TRUE THEN
					casovac_start					:= FALSE;
					automatika.step_repeatability	:= 8;
					FOR i:=0 TO 6 BY 1 DO
						automatika.desiredPressure1_previous[i]	:= automatika.desiredPressure1[i];
						automatika.desiredPressure2_previous[i]	:= automatika.desiredPressure2[i];
						automatika.desiredPressure3_previous[i]	:= automatika.desiredPressure3[i];
					END_FOR
				END_IF
			8:	// Pause
				pauza								:= TRUE;
				automatika.step_repeatability		:= 9;
			9:
				IF TON_1.Q = TRUE THEN
					pauza							:= FALSE;
					automatika.step_repeatability	:= 99;
					casovac_start					:= TRUE;
					kameraBool						:= TRUE;
				END_IF
			99:
				IF TON_2.Q = TRUE THEN
					kameraBool						:= FALSE;
					automatika.step_repeatability	:= 4;
				END_IF
			
		END_CASE			
		
	END_IF
	 
END_PROGRAM
