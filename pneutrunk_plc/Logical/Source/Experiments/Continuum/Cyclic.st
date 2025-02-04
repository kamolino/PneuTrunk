PROGRAM _CYCLIC
	automatika.continuum	:= TRUE;
	FOR id:=0 TO 5 BY 1 DO
		modul.tlak1[id]	:= REAL_TO_INT(pressure.p1*32767/9);
		modul.tlak2[id]	:= REAL_TO_INT(pressure.p2*32767/9);
		modul.tlak3[id]	:= REAL_TO_INT(pressure.p3*32767/9);
	END_FOR
	modul.tlak2[6]	:= REAL_TO_INT(pressure.p3*32767/9);
	modul.tlak3[6]	:= REAL_TO_INT(pressure.p2*32767/9);
	modul.tlak1[6]	:= REAL_TO_INT(pressure.p1*32767/9);
	 
END_PROGRAM
