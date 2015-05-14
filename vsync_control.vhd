LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY vsync_control IS
PORT(
	h_clk:IN STD_LOGIC;
	out_y:OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	v_blank:OUT STD_LOGIC;
	vsync:OUT STD_LOGIC
	);
END vsync_control; 
ARCHITECTURE main OF vsync_control IS

SIGNAL row_count: INTEGER RANGE 0 TO 794;
SIGNAL y: INTEGER RANGE 0 TO 767;

BEGIN
	PROCESS(h_clk)
	BEGIN
		IF h_clk'EVENT AND h_clk = '1' THEN
			IF (row_count >= 794)	THEN
				vsync <= '0';
				row_count <= 0;
				vsync <= '0';
			ELSE
				vsync <= '1';
				row_count <= row_count + 1;
				IF (row_count >= 23 AND row_count < 791) THEN
					y <= y + 1;
					v_blank <= '1';
				ELSE
					y <= 0;
					v_blank <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
out_y <= conv_std_logic_vector(y, 11);
END main;