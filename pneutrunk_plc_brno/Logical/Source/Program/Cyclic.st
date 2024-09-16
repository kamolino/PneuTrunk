PROGRAM _CYCLIC
	
	TON_0(IN := automatika.casovac, PT := INT_TO_TIME(automatika.cas));
	TON_1(IN := automatika.casovac_uchopenie, PT := T#4s);
	//TON_2(IN := automatika.trajectoryStart, PT := automatika.trajectoryTime);
	//TON_4(IN := automatika.trajectoryStart2, PT := automatika.trajectoryTime2);
	//TON_3(IN := automatika.novyCyklusStart, PT := automatika.novyCyklus);

	
	CASE global_step OF
		
		0:	// caka kym spravi uvodne odmeranie referencii....v controlleri ak je krok 4, vtedy prechadza global_step = 1
			(*
			automatika.y_desired[0]	:= 0;
			automatika.y_desired[1]	:= 0;
			automatika.y_desired[2]	:= 0;
			automatika.y_desired[3]	:= 0;
			automatika.y_desired[4]	:= 0;
			automatika.y_desired[5]	:= 0;
			automatika.y_desired[6]	:= 0;
			
			automatika.x_desired[0]	:= 0;
			automatika.x_desired[1]	:= 0;
			automatika.x_desired[2]	:= 0;
			automatika.x_desired[3]	:= 0;
			automatika.x_desired[4]	:= 0;
			automatika.x_desired[5]	:= 0;
			automatika.x_desired[6]	:= 0;
			*)
			automatika.linear		:= 23;
			FOR i:=0 TO 6 BY 1 DO
				automatika.I_konstanta[i]	:= 5;
			END_FOR
			automatika.automatic	:= FALSE;
			(*
			IF automatika.step_color = 1 OR automatika.step_color = 2 THEN
				global_step				:= 999;
			END_IF				
			*)
			modul;
			
		999:
			IF automatika.step_color = 1 OR automatika.step_color = 2 THEN
				automatika.loptickyVzasobniku	:= TRUE;
			ELSE
				automatika.loptickyVzasobniku	:= FALSE;
			END_IF
			
			IF automatika.loptickyVzasobniku = TRUE OR global_step_udp = 1 THEN
				automatika.effector		:= FALSE;
			//	global_step_udp			:= 0;
				global_step				:= 1;
				automatika.automatic	:= FALSE;
				I_ON					:= FALSE;
			END_IF
			FOR i:=0 TO 6 BY 1 DO
				automatika.I_konstanta[i]	:= 0;
			END_FOR
			
		1:	
			automatika.cas			:= 1000;
			automatika.casovac		:= TRUE;
			I_ON					:= TRUE;
			global_step				:= 100;
			
		100:
			IF TON_0.Q = TRUE THEN
				automatika.casovac	:= FALSE;
				IF global_step_udp = 1 THEN
					global_step				:= 11;
				ELSE
					automatika.cas			:= 1000;
					automatika.casovac		:= TRUE;
					global_step				:= 2;
				END_IF
			END_IF
			
		2:
			IF TON_0.Q=TRUE THEN
				automatika.casovac		:= FALSE;
				//automatika.ball_up		:= TRUE;
				global_step				:= 3;
			//	automatika.ball_piston	:= FALSE;
			END_IF
			
			
		3:	// pohyb pre uchopenie gulicky
			//automatika.casovac_uchopenie	:= TRUE;
			IF(automatika.step_color = 1)THEN
				automatika.box := 1;
				automatika.loptickyVzasobniku := TRUE;
			ELSIF(automatika.step_color = 2)THEN
				automatika.box	:= 2;
				automatika.loptickyVzasobniku := TRUE;
			ELSIF(automatika.step_color = 3)THEN
				automatika.loptickyVzasobniku := FALSE;
				automatika.box := 3;
			END_IF
			
			automatika.casovac			:= TRUE;
			automatika.cas				:= 5000;
			automatika.effector			:= FALSE;
			automatika.linear			:= 23;
			global_step					:= 4;
			FOR i:=0 TO 6 BY 1 DO
				automatika.I_konstanta[i]	:= 30;
			END_FOR
		4:
			// Pohyb ku levitujucej lopte
			(*
			automatika.y_desired[0]	:= TIME_TO_INT(TON_0.ET)*(-7)/((automatika.cas));
			automatika.y_desired[1]	:= TIME_TO_INT(TON_0.ET)*(6)/((automatika.cas));	
			automatika.y_desired[2]	:= TIME_TO_INT(TON_0.ET)*(-10)/((automatika.cas));
			automatika.y_desired[3]	:= TIME_TO_INT(TON_0.ET)*(-10)/((automatika.cas));
			automatika.y_desired[4]	:= TIME_TO_INT(TON_0.ET)*(-8)/((automatika.cas));
			automatika.y_desired[5]	:= TIME_TO_INT(TON_0.ET)*(-5)/((automatika.cas));
			automatika.y_desired[6]	:= TIME_TO_INT(TON_0.ET)*(-5)/((automatika.cas));//-10
			
			automatika.x_desired[0]	:= TIME_TO_INT(TON_0.ET)*5/((automatika.cas));
			automatika.x_desired[1]	:= TIME_TO_INT(TON_0.ET)*4/((automatika.cas));
			automatika.x_desired[2]	:= TIME_TO_INT(TON_0.ET)*5/((automatika.cas));
			automatika.x_desired[3]	:= TIME_TO_INT(TON_0.ET)*5/((automatika.cas));
			automatika.x_desired[4]	:= TIME_TO_INT(TON_0.ET)*5/((automatika.cas));
			automatika.x_desired[5]	:= TIME_TO_INT(TON_0.ET)*1/((automatika.cas));
			automatika.x_desired[6]	:= 0;// TIME_TO_INT(TON_0.ET)*2/((automatika.cas));
			*)
			//automatika.linear		:= TIME_TO_INT(TON_2.ET)*30/(TIME_TO_INT(automatika.trajectoryTime));
			
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
			
			IF TON_0.Q=TRUE THEN
				automatika.casovac			:= FALSE;
				automatika.casovac_uchopenie:= TRUE;
				global_step					:= 55;
				FOR i:=0 TO 6 BY 1 DO
				//	automatika.x_desired_previous[i]	:= automatika.x_desired[i];
				//	automatika.y_desired_previous[i]	:= automatika.y_desired[i];
				//	automatika.I_konstanta[i]			:= 20;
					automatika.desiredPressure1_previous[i]		:= automatika.desiredPressure1[i];
					automatika.desiredPressure2_previous[i]		:= automatika.desiredPressure2[i];
					automatika.desiredPressure3_previous[i]		:= automatika.desiredPressure3[i];
				END_FOR
			END_IF
			
		55:
			IF TON_1.Q = TRUE THEN
				automatika.levitacia			:= TRUE;
				automatika.linear				:= 30;
				automatika.desiredPressureLinear := 10800;
				automatika.casovac_uchopenie	:= FALSE;
				global_step						:= 555;
			END_IF
			
		555:
			automatika.cas						:= 1000;
			automatika.casovac					:= TRUE;
			global_step							:= 5;
			
		5:	// uchopenie
			IF TON_0.Q = TRUE THEN
				automatika.casovac				:= FALSE;
				automatika.effector				:= TRUE;
				global_step						:= 6;
			END_IF
		
		6:	
			automatika.casovac_uchopenie		:= TRUE;
			global_step							:= 7;
			automatika.linear					:= 23;
			automatika.desiredPressureLinear := 0;
			
		7:
			IF TON_1.Q = TRUE THEN
				automatika.casovac_uchopenie	:= FALSE;
				global_step						:= 8;
				automatika.levitacia			:= FALSE;
				automatika.ball_piston			:= TRUE;
				automatika.cas					:= 4500;
				automatika.casovac				:= TRUE;
				FOR i:=0 TO 6 BY 1 DO
					automatika.I_konstanta[i]	:= 50;
				END_FOR
			END_IF
			
		8:	
			IF(automatika.box = 1) THEN
				// prenesenie objektu
				(*
				automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7)/((automatika.cas));
				automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));	// 5000ms
				automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
				automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
				automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(8)/((automatika.cas));
				automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(5)/((automatika.cas));
				automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
			
				automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(2)/((automatika.cas));
				automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(-2)/((automatika.cas));
				automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(-2)/((automatika.cas));
				automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(-2)/((automatika.cas));
				automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(-5)/((automatika.cas));
				automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) +  TIME_TO_INT(TON_0.ET)*(-5)/((automatika.cas));
				automatika.x_desired[6]	:= TIME_TO_INT(TON_0.ET)*(-5)/((automatika.cas));
			
				automatika.linear		:= TIME_TO_INT(TON_0.ET)*30/((automatika.cas));
				*)
				automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5110)/(automatika.cas);
				automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5111)/(automatika.cas);
				automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7940)/(automatika.cas);
				automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6420)/(automatika.cas);
				automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8355)/(automatika.cas);
				automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6516)/(automatika.cas);
				automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(565)/(automatika.cas);
				
				automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1952)/(automatika.cas);
				automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3178)/(automatika.cas);
				automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(271)/(automatika.cas);
				automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2520)/(automatika.cas);
				automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(829)/(automatika.cas);
				automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1928)/(automatika.cas);
				automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4860)/(automatika.cas);
				
				automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5596)/(automatika.cas);
				automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4301)/(automatika.cas);
				automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4820)/(automatika.cas);
				automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3573)/(automatika.cas);
				automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3796)/(automatika.cas);
				automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4104)/(automatika.cas);
				automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7462)/(automatika.cas);
				
				automatika.desiredPressureLinear := TIME_TO_INT(TON_0.ET)*10800/((automatika.cas));
				
			ELSIF(automatika.box = 2) THEN
				// prenesenie objektu
				(*
				automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7)/((automatika.cas));
				automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2)/((automatika.cas));	// 5000ms
				automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
				automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
				automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8)/((automatika.cas));
				automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5)/((automatika.cas));
				automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
			
				automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-5)/((automatika.cas));
				automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
				automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
				automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
				automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
				automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
				automatika.x_desired[6]	:= 0;
			
				automatika.linear		:= TIME_TO_INT(TON_0.ET)*30/((automatika.cas));
				*)
				automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6742)/(automatika.cas);
				automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4943)/(automatika.cas);
				automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7130)/(automatika.cas);
				automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2634)/(automatika.cas);
				automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2996)/(automatika.cas);
				automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4870)/(automatika.cas);
				automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(641)/(automatika.cas);
				
				automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1843)/(automatika.cas);
				automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2823)/(automatika.cas);
				automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(303)/(automatika.cas);
				automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2546)/(automatika.cas);
				automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(863)/(automatika.cas);
				automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1985)/(automatika.cas);
				automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6512)/(automatika.cas);
				
				automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4092)/(automatika.cas);
				automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4838)/(automatika.cas);
				automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5555)/(automatika.cas);
				automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7505)/(automatika.cas);
				automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(9217)/(automatika.cas);
				automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5656)/(automatika.cas);
				automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5690)/(automatika.cas);
				
				automatika.desiredPressureLinear := TIME_TO_INT(TON_0.ET)*10800/((automatika.cas));
			ELSIF(automatika.box = 3) THEN
				(*
				IF(automatika.step_color = 1)THEN
					automatika.loptickyVzasobniku	:= TRUE;
					automatika.box := 1;
				ELSIF(automatika.step_color = 2)THEN
					automatika.box	:= 2;
					automatika.loptickyVzasobniku	:= TRUE;
				ELSIF(automatika.step_color = 3)THEN
					*)
					(*
					automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//+ TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));	// 5000ms
					automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);// TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			
					automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas);//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
					automatika.x_desired[6]	:= 0;//TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));;
					*)
				
				automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				
				automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				
				automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				
				automatika.desiredPressureLinear := 0;
					
					automatika.loptickyVzasobniku	:= FALSE;
					automatika.effector				:= FALSE;
					global_step						:= 0;
				//END_IF
				
			END_IF

			IF TON_0.Q=TRUE THEN
				automatika.casovac					:= FALSE;
				automatika.ball_piston				:= FALSE;
				IF automatika.loptickyVzasobniku = TRUE THEN
					global_step						:= 9;
				ELSE
					global_step						:= 999;//0
				END_IF
				FOR i:=0 TO 6 BY 1 DO
				//	automatika.x_desired_previous[i]:= automatika.x_desired[i];
				//	automatika.y_desired_previous[i]:= automatika.y_desired[i];
					automatika.desiredPressure1_previous[i]	:= automatika.desiredPressure1[i];	
					automatika.desiredPressure2_previous[i]	:= automatika.desiredPressure2[i];	
					automatika.desiredPressure3_previous[i]	:= automatika.desiredPressure3[i];	
				END_FOR
			END_IF

		9:
			automatika.effector				:= FALSE;
			automatika.cas					:= 2000;
			automatika.casovac				:= TRUE;
			global_step						:= 901;
			
		901:
			IF(automatika.step_color = 3)THEN
				automatika.testFarba	:= 1;
			END_IF
			global_step					:= 902;
			
		902:
			IF(automatika.step_color = 3)THEN
				automatika.testFarba	:= 2;
			END_IF
			global_step					:= 903;
			
		903:
			IF TON_0.Q = TRUE THEN
				automatika.casovac			:= FALSE;
				automatika.popcorn			:= FALSE;
				IF(automatika.step_color = 3)THEN
					automatika.testFarba	:= 0;
					automatika.loptickyVzasobniku	:= FALSE;
				END_IF
				global_step					:= 904;			
			END_IF
			
		904:
			automatika.cas					:= 4000;
			automatika.casovac				:= TRUE;
			global_step						:= 905;
			
		905:
			(*
			automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));	// 5000ms
			automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			
			automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[6]	:= (automatika.x_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			
			automatika.linear		:= 23;
			*)
			automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				
			automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				
			automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				
			automatika.desiredPressureLinear := 0;
			
			
			IF TON_0.Q = TRUE THEN
				automatika.casovac			:= FALSE;
				global_step					:= 999;//posledne bolo 1 predtym 0
			END_IF
			
			
		11:
			automatika.cas					:= 5000;
			global_step						:= 111;
			automatika.linear				:= 23;
			automatika.desiredPressureLinear := 0;
			FOR i:=0 TO 6 BY 1 DO
			//	automatika.x_desired_previous[i]:= automatika.x_desired[i];
			//	automatika.y_desired_previous[i]:= automatika.y_desired[i];
			//	automatika.I_konstanta[i]	:= 50;
				automatika.desiredPressure1_previous[i]	:= automatika.desiredPressure1[i];	
				automatika.desiredPressure2_previous[i]	:= automatika.desiredPressure2[i];	
				automatika.desiredPressure3_previous[i]	:= automatika.desiredPressure3[i];	
			END_FOR
			automatika.casovac				:= TRUE;
			
		111:
			// ide po loptu
			(*
			automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
			automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(18)/((automatika.cas));	
			automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(18)/((automatika.cas));
			automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(18)/((automatika.cas));
			automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-18)/((automatika.cas));
			automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-15)/((automatika.cas));
			automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-18)/((automatika.cas));//-18
			
			automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(15)/((automatika.cas));
			automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(13)/((automatika.cas));
			automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3)/((automatika.cas));
			automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
			automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-10)/((automatika.cas));
			automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12)/((automatika.cas));
			automatika.x_desired[6]	:= (automatika.x_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-15)/((automatika.cas));//-10
			*)
			(*1
			automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2576)/(automatika.cas);
			automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3565)/(automatika.cas);
			automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2491)/(automatika.cas);
			automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5002)/(automatika.cas);
			automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5610)/(automatika.cas);
			automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3950)/(automatika.cas);
			automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11769)/(automatika.cas);
				
			automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(911)/(automatika.cas);
			automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(195)/(automatika.cas);
			automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-2072)/(automatika.cas);
			automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1601)/(automatika.cas);
			automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10415)/(automatika.cas);
			automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10162)/(automatika.cas);
			automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1551)/(automatika.cas);
				
			automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(9478)/(automatika.cas);
			automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(9253)/(automatika.cas);
			automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(14120)/(automatika.cas);
			automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10928)/(automatika.cas);
			automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1767)/(automatika.cas);
			automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-607)/(automatika.cas);
			automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3893)/(automatika.cas);
			*)
			(*2:
			automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1918)/(automatika.cas);
			automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3565)/(automatika.cas);
			automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7440)/(automatika.cas);
			automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5002)/(automatika.cas);
			automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4056)/(automatika.cas);
			automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3950)/(automatika.cas);
			automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11769)/(automatika.cas);
				
			automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3243)/(automatika.cas);
			automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(195)/(automatika.cas);
			automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1814)/(automatika.cas);
			automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1601)/(automatika.cas);
			automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10648)/(automatika.cas);
			automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10162)/(automatika.cas);
			automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1551)/(automatika.cas);
				
			automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7549)/(automatika.cas);
			automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(9253)/(automatika.cas);
			automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8285)/(automatika.cas);
			automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10928)/(automatika.cas);
			automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-923)/(automatika.cas);
			automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-607)/(automatika.cas);
			automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3893)/(automatika.cas);
			//automatika.desiredPressureLinear := TIME_TO_INT(TON_0.ET)*10800/((automatika.cas));
			*)
			//3:
			automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2228)/(automatika.cas);
			automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3565)/(automatika.cas);
			automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7440)/(automatika.cas);
			automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5002)/(automatika.cas);
			automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(4056)/(automatika.cas);
			automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3950)/(automatika.cas);
			automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11769)/(automatika.cas);
				
			automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2171)/(automatika.cas);
			automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(195)/(automatika.cas);
			automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1814)/(automatika.cas);
			automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1601)/(automatika.cas);
			automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10648)/(automatika.cas);
			automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10162)/(automatika.cas);
			automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1551)/(automatika.cas);
				
			automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8374)/(automatika.cas);
			automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(9253)/(automatika.cas);
			automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8285)/(automatika.cas);
			automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10928)/(automatika.cas);
			automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-923)/(automatika.cas);
			automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-607)/(automatika.cas);
			automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3893)/(automatika.cas);
			
			(*5:
			automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1551)/(automatika.cas);
			automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3204)/(automatika.cas);
			automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10733)/(automatika.cas);
			automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11418)/(automatika.cas);
			automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(12891)/(automatika.cas);
			automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(9489)/(automatika.cas);
			automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(19050)/(automatika.cas);
				
			automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2578)/(automatika.cas);
			automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-1433)/(automatika.cas);
			automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12736)/(automatika.cas);
			automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12490)/(automatika.cas);
			automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(17696)/(automatika.cas);
			automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(17982)/(automatika.cas);
			automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12474)/(automatika.cas);
				
			automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8709)/(automatika.cas);
			automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11851)/(automatika.cas);
			automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(15567)/(automatika.cas);
			automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(15179)/(automatika.cas);
			automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12690)/(automatika.cas);
			automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-11678)/(automatika.cas);
			automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11174)/(automatika.cas);
			*)
			(*6:
			automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1329)/(automatika.cas);
			automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3602)/(automatika.cas);
			automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11012)/(automatika.cas);
			automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(5643)/(automatika.cas);
			automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8636)/(automatika.cas);
			automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(10063)/(automatika.cas);
			automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(19050)/(automatika.cas);
				
			automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2199)/(automatika.cas);
			automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-3166)/(automatika.cas);
			automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12736)/(automatika.cas);
			automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12523)/(automatika.cas);
			automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(17930)/(automatika.cas);
			automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(17166)/(automatika.cas);
			automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12474)/(automatika.cas);
				
			automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(9329)/(automatika.cas);
			automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(14196)/(automatika.cas);
			automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(15567)/(automatika.cas);
			automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(18210)/(automatika.cas);
			automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-10155)/(automatika.cas);
			automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-10432)/(automatika.cas);
			automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11174)/(automatika.cas);
			*)
			
			IF TON_0.Q=TRUE THEN
				automatika.casovac			:= FALSE;
				global_step					:= 1110;
			END_IF
		1110:
			automatika.cas					:= 3500;
			automatika.casovac				:= TRUE;
			global_step						:= 11101;
		11101:
			IF TON_0.Q = TRUE THEN
				automatika.casovac			:= FALSE;
				automatika.ball_up			:= TRUE;
				global_step					:= 11102;
			END_IF
		11102:
			automatika.cas					:= 3000;
			automatika.casovac				:= TRUE;
			global_step						:= 1112;	
			
		1112:// pockanie na vysunutie linearneho clena
			IF TON_0.Q = TRUE THEN
				automatika.casovac		:= FALSE;
				//	automatika.linear		:= 30;
				//automatika.desiredPressureLinear := 10800;
				global_step				:= 1113;
			END_IF
				
		1113:// uchopenie lopty
			automatika.cas				:= 3000;
			automatika.casovac			:= TRUE;
			automatika.effector			:= TRUE;
			global_step					:= 122;

		122://pockanie na uchopenie lopty
			IF TON_0.Q = TRUE THEN
				automatika.casovac			:= FALSE;
				automatika.linear			:= 23;
				automatika.desiredPressureLinear := 0;
				automatika.ball_up			:= FALSE;	// dvihac lopty dole
				global_step					:= 1222;
			END_IF
			
		1222:	
			automatika.cas					:= 3000;
			automatika.casovac				:= TRUE;
			global_step						:= 12222;
		12222:
			IF TON_0.Q = TRUE THEN
				automatika.casovac			:= FALSE;
				global_step					:= 12223;
			END_IF
			
		12223:
			automatika.cas					:= 3000;
			automatika.casovac				:= TRUE;
			
			FOR i:=0 TO 6 BY 1 DO
			//	automatika.x_desired_previous[i]:= automatika.x_desired[i];
			//	automatika.y_desired_previous[i]:= automatika.y_desired[i];
				automatika.desiredPressure1_previous[i]	:= automatika.desiredPressure1[i];	
				automatika.desiredPressure2_previous[i]	:= automatika.desiredPressure2[i];	
				automatika.desiredPressure3_previous[i]	:= automatika.desiredPressure3[i];	
			END_FOR
			global_step						:= 12224;
			
		12224:
			
			// nulova poloha
			(*
			automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));	
			automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			(*
			automatika.y_desired[4]	:= TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
			automatika.y_desired[5]	:= TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
			automatika.y_desired[6]	:= TIME_TO_INT(TON_0.ET)*(0)/((automatika.cas));
			
			automatika.x_desired[0]	:= TIME_TO_INT(TON_0.ET)*(-12)/((automatika.cas));
			automatika.x_desired[1]	:= TIME_TO_INT(TON_0.ET)*(-10)/((automatika.cas));
			automatika.x_desired[2]	:= TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
			automatika.x_desired[3]	:= TIME_TO_INT(TON_0.ET)*(10)/((automatika.cas));
			automatika.x_desired[4]	:= TIME_TO_INT(TON_0.ET)*(15)/((automatika.cas));
			automatika.x_desired[5]	:= TIME_TO_INT(TON_0.ET)*(15)/((automatika.cas));
			automatika.x_desired[6]	:= TIME_TO_INT(TON_0.ET)*(15)/((automatika.cas));
			*)
			
			automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(398)/(automatika.cas);
			automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1655)/(automatika.cas);
			automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2477)/(automatika.cas);
			automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-536)/(automatika.cas);
			automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(6406)/(automatika.cas);
			automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(7637)/(automatika.cas);
			automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(19050)/(automatika.cas);
				
			automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(3114)/(automatika.cas);
			automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2681)/(automatika.cas);
			automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-5184)/(automatika.cas);
			automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(371)/(automatika.cas);
			automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(16471)/(automatika.cas);
			automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(13332)/(automatika.cas);
			automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-12474)/(automatika.cas);
				
			automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(9501)/(automatika.cas);
			automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(8729)/(automatika.cas);
			automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(12309)/(automatika.cas);
			automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(14985)/(automatika.cas);
			automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-6826)/(automatika.cas);
			automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(-5806)/(automatika.cas);
			automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(11174)/(automatika.cas);
			
			IF TON_0.Q = TRUE THEN
				automatika.casovac			:= FALSE;
				global_step					:= 12225;
			END_IF

		12225:
			automatika.cas					:= 4000;
			FOR i:=0 TO 6 BY 1 DO
			//	automatika.x_desired_previous[i]:= automatika.x_desired[i];
			//	automatika.y_desired_previous[i]:= automatika.y_desired[i];
				automatika.desiredPressure1_previous[i]	:= automatika.desiredPressure1[i];	
				automatika.desiredPressure2_previous[i]	:= automatika.desiredPressure2[i];	
				automatika.desiredPressure3_previous[i]	:= automatika.desiredPressure3[i];
			END_FOR
			automatika.casovac				:= TRUE;
			automatika.popcorn				:= TRUE;
			global_step						:= 12226;
			
		12226:
			(*
			automatika.x_desired[0]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[1]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[2]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[3]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[4]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[5]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[6]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			*)
			(*
			automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));	// 5000ms
			automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			
			automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[6]	:= (automatika.x_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			*)
			automatika.desiredPressure1[0]:= (automatika.desiredPressure1_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[1]:= (automatika.desiredPressure1_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[2]:= (automatika.desiredPressure1_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[3]:= (automatika.desiredPressure1_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[4]:= (automatika.desiredPressure1_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[5]:= (automatika.desiredPressure1_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure1[6]:= (automatika.desiredPressure1_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				
			automatika.desiredPressure2[0]:= (automatika.desiredPressure2_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[1]:= (automatika.desiredPressure2_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[2]:= (automatika.desiredPressure2_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[3]:= (automatika.desiredPressure2_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[4]:= (automatika.desiredPressure2_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[5]:= (automatika.desiredPressure2_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure2[6]:= (automatika.desiredPressure2_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
				
			automatika.desiredPressure3[0]:= (automatika.desiredPressure3_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[1]:= (automatika.desiredPressure3_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[2]:= (automatika.desiredPressure3_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[3]:= (automatika.desiredPressure3_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[4]:= (automatika.desiredPressure3_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[5]:= (automatika.desiredPressure3_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			automatika.desiredPressure3[6]:= (automatika.desiredPressure3_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(2*32767/9)/(automatika.cas);
			
			IF TON_0.Q = TRUE THEN
				automatika.casovac			:= FALSE;
				automatika.automatic		:= TRUE;
				global_step					:= 15;//12227
			END_IF
			
		12227:
			automatika.cas					:= 6000;
			global_step						:= 12228;
			FOR i:=0 TO 6 BY 1 DO
			//	automatika.x_desired_previous[i]:= automatika.x_desired[i];
			//	automatika.y_desired_previous[i]:= automatika.y_desired[i];
				automatika.desiredPressure1_previous[i]	:= automatika.desiredPressure1[i];	
				automatika.desiredPressure2_previous[i]	:= automatika.desiredPressure2[i];	
				automatika.desiredPressure3_previous[i]	:= automatika.desiredPressure3[i];
			END_FOR
			automatika.casovac				:= TRUE;
			
		12228:
			(*
			automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[2]))/((automatika.cas));	
			automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[4]))/((automatika.cas));
			automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[6]))/((automatika.cas));
			automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[8]))/((automatika.cas));
			automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[10]))/((automatika.cas));
			automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[12]))/((automatika.cas));
			
			automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[3]))/((automatika.cas));
			automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[5]))/((automatika.cas));
			automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[7]))/((automatika.cas));
			automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[9]))/((automatika.cas));
			automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[11]))/((automatika.cas));
			automatika.x_desired[6]	:= (automatika.x_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[13]))/((automatika.cas));
			*)
			automatika.y_desired[0]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			automatika.y_desired[1]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[2]))/((automatika.cas));	
			automatika.y_desired[2]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[4]))/((automatika.cas));
			automatika.y_desired[3]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[6]))/((automatika.cas));
			automatika.y_desired[4]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[8]))/((automatika.cas));
			automatika.y_desired[5]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[10]))/((automatika.cas));
			automatika.y_desired[6]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[12]))/((automatika.cas));
			
			automatika.x_desired[0]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			automatika.x_desired[1]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[3]))/((automatika.cas));
			automatika.x_desired[2]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[5]))/((automatika.cas));
			automatika.x_desired[3]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[7]))/((automatika.cas));
			automatika.x_desired[4]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[9]))/((automatika.cas));
			automatika.x_desired[5]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[11]))/((automatika.cas));
			automatika.x_desired[6]	:= TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[13]))/((automatika.cas));
			
			IF TON_0.Q THEN
				automatika.casovac				:= FALSE;
				FOR i:=0 TO 6 BY 1 DO
					automatika.I_konstanta[i]	:= 20;
				END_FOR 
				automatika.automatic			:= TRUE;
				automatika.holdPosition			:= FALSE;
				global_step						:= 15;
				automatika.popcorn				:= FALSE;
			END_IF	
				
		13:
			IF global_step_udp = 1 THEN
				automatika.effector			:= FALSE;
				//automatika.casovac_uchopenie:= TRUE;
				global_step					:= 14;
			END_IF
		
		14:
			//IF TON_1.Q = TRUE THEN
				automatika.casovac_uchopenie:= FALSE;
				global_step					:= 15;
			//END_IF
			
		15:
			IF global_step_udp = 2 THEN
				automatika.holdPosition		:= TRUE;
				automatika.cas				:= 1000;
				automatika.casovac			:= TRUE;
				global_step					:= 16;
			END_IF
		16:
			IF TON_0.Q = TRUE THEN
				automatika.casovac			:= FALSE;
				global_step					:= 17;
				automatika.popcorn			:= FALSE;
			END_IF
		17:	// pustenie objektu a cakanie na povel pokracovat
			IF global_step_udp = 3 THEN
				automatika.effector			:= FALSE;
				global_step					:= 18;
			END_IF
			
		18:
			IF global_step_udp = 4 THEN
				
				automatika.automatic		:= FALSE;
				automatika.holdPosition		:= FALSE;
				I_ON						:= FALSE;
				global_step					:= 19;//19
			END_IF
			
		19:
			
			
			FOR i:=0 TO 6 BY 1 DO
				automatika.x_desired_previous[i]	:= REAL_TO_INT(packetPos.qDesired[i*2]); //automatika.x_desired[i];
				automatika.y_desired_previous[i]	:= REAL_TO_INT(-packetPos.qDesired[i*2+1]); //automatika.y_desired[i];
				automatika.x_desired[i]				:= 0;
				automatika.y_desired[i]				:= 0;
				packetPos.qDesired[i*2]				:= 0;
				packetPos.qDesired[i*2+1]			:= 0;
				automatika.I_konstanta[i]			:= 5;
			END_FOR
			
			global_step				:= 20;
		20:
			I_ON					:= TRUE;
			automatika.cas			:= 5000;
			automatika.casovac		:= TRUE;
			global_step				:= 21;
		21:
			
			(*
			automatika.y_desired[0]	:= 0;
			automatika.y_desired[1]	:= 0;	// 5000ms
			automatika.y_desired[2]	:= 0;
			automatika.y_desired[3]	:= 0;
			automatika.y_desired[4]	:= 0;
			automatika.y_desired[5]	:= 0;
			automatika.y_desired[6]	:= 0;
			
			automatika.x_desired[0]	:= 0;
			automatika.x_desired[1]	:= 0;
			automatika.x_desired[2]	:= 0;
			automatika.x_desired[3]	:= 0;
			automatika.x_desired[4]	:= 0;
			automatika.x_desired[5]	:= 0;
			automatika.x_desired[6]	:= 0;
			*)
			automatika.desiredPressure1[0]:= 0;
			automatika.desiredPressure1[1]:= 0;
			automatika.desiredPressure1[2]:= 0;
			automatika.desiredPressure1[3]:= 0;
			automatika.desiredPressure1[4]:= 0;
			automatika.desiredPressure1[5]:= 0;
			automatika.desiredPressure1[6]:= 0;
			
			automatika.desiredPressure2[0]:= 0;
			automatika.desiredPressure2[1]:= 0;
			automatika.desiredPressure2[2]:= 0;
			automatika.desiredPressure2[3]:= 0;
			automatika.desiredPressure2[4]:= 0;
			automatika.desiredPressure2[5]:= 0;
			automatika.desiredPressure2[6]:= 0;
			
			automatika.desiredPressure3[0]:= 0;
			automatika.desiredPressure3[1]:= 0;
			automatika.desiredPressure3[2]:= 0;
			automatika.desiredPressure3[3]:= 0;
			automatika.desiredPressure3[4]:= 0;
			automatika.desiredPressure3[5]:= 0;
			automatika.desiredPressure3[6]:= 0;
			
			
			
			(*
			automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[0]))/((automatika.cas));
			
			automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			automatika.x_desired[6]	:= (automatika.x_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(REAL_TO_INT(packetPos.qDesired[1]))/((automatika.cas));
			*)
			automatika.linear		:= 23;
			automatika.desiredPressureLinear := 0;
			
			IF TON_0.Q = TRUE THEN
				automatika.casovac	:= FALSE;
				global_step			:= 999;
			END_IF
			
			(*
			FOR i:=0 TO 6 BY 1 DO
				packetPos.qDesired[i*2]		:= 0;
				packetPos.qDesired[i*2+1]	:= 0;
				automatika.y_desired[i]		:= 0;
				automatika.x_desired[i]		:= 0;
			END_FOR
		*)
			
			
		//	IF TON_0.Q = TRUE THEN
		//		automatika.casovac		:= FALSE;
				//	global_step				:= 999;
		//	END_IF
			
		//	global_step						:= 20;
			
		22:
			
			
			(*
			automatika.y_desired[0]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[1]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));	// 5000ms
			automatika.y_desired[2]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[3]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[4]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[5]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[6]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			
			automatika.x_desired[0]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[1]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[2]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[3]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[4]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[5]	:= TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			*)
			(*
			automatika.y_desired[0]	:= (automatika.y_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[1]	:= (automatika.y_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));	// 5000ms
			automatika.y_desired[2]	:= (automatika.y_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[3]	:= (automatika.y_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[4]	:= (automatika.y_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[5]	:= (automatika.y_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.y_desired[6]	:= (automatika.y_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			
			automatika.x_desired[0]	:= (automatika.x_desired_previous[0]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[1]	:= (automatika.x_desired_previous[1]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[2]	:= (automatika.x_desired_previous[2]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[3]	:= (automatika.x_desired_previous[3]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[4]	:= (automatika.x_desired_previous[4]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[5]	:= (automatika.x_desired_previous[5]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			automatika.x_desired[6]	:= (automatika.x_desired_previous[6]*(automatika.cas - TIME_TO_INT(TON_0.ET))/automatika.cas) + TIME_TO_INT(TON_0.ET)*(1)/((automatika.cas));
			*)

			
			

	END_CASE
		 
END_PROGRAM
