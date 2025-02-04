PROGRAM _CYCLIC
	
	FOR id:=0 TO 6 BY 1 DO
		automatika.x_desired[id]	:= (uhly.ref_alfa_x[id]);
		automatika.y_desired[id]	:= (uhly.ref_alfa_y[id]);
	END_FOR
	
END_PROGRAM
