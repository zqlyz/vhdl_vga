LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY vga_control IS
PORT(
	clk_50mz :IN STD_LOGIC;
	hsync:OUT STD_LOGIC;
	vsync:OUT STD_LOGIC;
	blank:OUT STD_LOGIC;
	sync:OUT STD_LOGIC;
	point_clk:OUT STD_LOGIC;
	x:OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	y:OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END vga_control;

ARCHITECTURE main OF vga_control IS

COMPONENT  pll_85mz IS
PORT
(
	inclk0	: IN STD_LOGIC  := '0';
	c0		: OUT STD_LOGIC 
);
END COMPONENT;

COMPONENT hsync_control IS
PORT(
	point_clk:IN STD_LOGIC;
	out_x:OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	h_blank:OUT STD_LOGIC;
	hsync:OUT STD_LOGIC;
	h_clk:OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT vsync_control IS
PORT(
	h_clk:IN STD_LOGIC;
	out_y:OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	v_blank:OUT STD_LOGIC;
	vsync:OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL clk_85mz:STD_LOGIC;
SIGNAL h_blank:STD_LOGIC;
SIGNAL v_blank:STD_LOGIC;
SIGNAL h_clk:STD_LOGIC;


BEGIN

U1:pll_85mz PORT map(clk_50mz, clk_85mz);
U2:hsync_control PORT map(clk_85mz, x, h_blank, hsync, h_clk);
U3:vsync_control PORT map(h_clk, y, v_blank, vsync);


point_clk <= clk_85mz;
blank <= h_blank AND v_blank;
sync <= '0';
END main;
