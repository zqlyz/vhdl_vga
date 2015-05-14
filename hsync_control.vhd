LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY hsync_control IS
PORT(
	point_clk:IN STD_LOGIC;
	out_x:OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	h_blank:OUT STD_LOGIC;
	hsync:OUT STD_LOGIC;
	h_clk:OUT STD_LOGIC
	);
END hsync_control; 
ARCHITECTURE main OF hsync_control IS

SIGNAL point_count: INTEGER RANGE 0 TO 1799;
SIGNAL x: INTEGER RANGE 0 TO 1367;

BEGIN
	PROCESS(point_clk)
	BEGIN
		IF point_clk'EVENT AND point_clk = '1' THEN
			IF (point_count >= 1799)	THEN
				h_clk <= '1';
				hsync <= '0';
				point_count <= 0;
			ELSE
				h_clk <= '0';
				point_count <= point_count + 1;
				IF (point_count >= 144) THEN
					hsync <= '1';
				ELSE
					hsync <= '0';
				END IF;
				IF (point_count >= 216 AND point_count <= 1584) THEN
					x <= x + 1;
					h_blank <= '1';
				ELSE
					x <= 0;
					h_blank <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
out_x <= conv_std_logic_vector(x, 11);

END main;