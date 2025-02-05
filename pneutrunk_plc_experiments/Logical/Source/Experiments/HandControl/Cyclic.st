PROGRAM _CYCLIC
	IF automatika.handControl = TRUE THEN
		FOR id:=0 TO 6 BY 1 DO
			automatika.x_desired[id]	:= (uhly.ref_alfa_x[id]);
			automatika.y_desired[id]	:= (uhly.ref_alfa_y[id]);
		END_FOR
	ELSIF automatika.handControl = FALSE THEN
		FOR id:=0 TO 6 BY 1 DO
			automatika.x_desired[id]	:= 0;
			automatika.y_desired[id]	:= 0;
		END_FOR
	END_IF
	
END_PROGRAM
