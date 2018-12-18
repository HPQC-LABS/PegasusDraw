% PegasusDraw.mp -- drawing the Chimera and the Pegasus graphs.
% Szilárd Szalay, Nike Dattani, Nicholas Chancellor
%
% MetaPost: 
%   https://tug.org/metapost.html
%   https://tug.org/docs/metapost/mpman.pdf
%
% compiling:
%   mpost DWaveGraphs.mp
%
% for converting .eps files to .pdf, use the shell command
%   for f in fig_*.eps; do a2ping $f; done
% see https://ctan.org/tex-archive/graphics/a2ping
%   OR
%   for f in fig_*.eps; do epspdf $f; done



% ** declarations for metaposting **********************************************

prologues := 3;	% needed if there are LaTeX labels and also for converting to pdf

% for writing out the indices:
numeric showindices;
showindices := 0;	% hide the indices
%showindices := 1;	% show the indices

if showindices=1:
	input TEX;
	TEXPRE("%&latex" & char(10) & "\documentclass{article}\begin{document}");
	TEXPOST("\end{document}");
fi;



% ** color definitions *********************************************************

color cblack;	cblack := (  0,  0,  0)/256;
color cgrey;	cgrey  := (208,208,208)/256;

color cred;	cred   := (256,  0,  0)/256;
color cblue;	cblue  := (  0,  0,256)/256;
color cgreen;	cgreen := (  0,154, 66)/256;
color corange;	corange:= (256,128,  0)/256;

color clblue; 	clblue := (180,206,256)/256;

color cblues[];
cblues[0] := .60[clblue,cblue];
cblues[1] := .20[clblue,cblue];
cblues[2] := clblue;



% ** units *********************************************************************

numeric X,Y,Z;	% Z Chimera layers of size $X\times Y$
X := 5;
Y := 5;
Z := 3;

string innermode;			% type of unit cells:
innermode := "Trp";			%   trapezoid
%innermode := "Dmd";			%   diamond
%innermode := "Std";			%   2x4
%innermode := "Dot";			%   one dot

string outermode;			% type of layer:
outermode := "Rect";			%   rectangular, one behind the other
%outermode := "Tilt";			%   parallelogram, one behind the other
% not implemented yet:
%outermode := "Stck";			%   parallelogram, stacked one on top of the other

numeric chimeraonly; chimeraonly := 0;

numeric ut, vt, dlt, urt, sfh; 
numeric th, tv, tlh, tlv;

% these can be merged later, if the parameters "converged"
if (innermode="Trp") and (outermode="Rect"):
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.25vt;			% horizontal=vertical steps for layers
	urt := 0;			% rotation of the unit cell
	sfh := 1.0;			% horizontal scale factor
elseif (innermode="Dmd") and (outermode="Rect"):
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.25vt;			% horizontal=vertical steps for layers
	urt := 0;			% rotation of the unit cell
	sfh := 1.0;			% horizontal scale factor
elseif (innermode="Std") and (outermode="Rect"):
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.25vt;			% horizontal=vertical steps for layers
	th  :=-0.70;      		% horizontal tilt factor of the unit cell
	tv  :=+0.25;			% vertical tilt factor of the unit cell
	sfh := 1.0;			% horizontal scale factor
elseif (innermode="Dot") and (outermode="Rect"):
	ut  := 6bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.25vt;			% horizontal=vertical steps for layers
	sfh := 1.0;			% horizontal scale factor
elseif (innermode="Trp") and (outermode="Tilt"):
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.45vt;			% horizontal=vertical steps for layers
	urt := 0;			% rotation of the unit cell
	sfh := 1;			% horizontal scale factor
	tlh := 0.00;			% horizontal tilt factor of the layer
	tlv :=-0.15;			% vertical tilt factor of the layer
elseif (innermode="Dmd") and (outermode="Tilt"):
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.45vt;			% horizontal=vertical steps for layers
	urt := 0;			% rotation of the unit cell
	sfh := 1.0;			% horizontal scale factor
	tlh := 0.00;			% horizontal tilt factor of the layer
	tlv :=-0.15;			% vertical tilt factor of the layer
elseif (innermode="Std") and (outermode="Tilt"):
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.0ut;			% base unit (for graph)
	dlt := 3.45vt;			% horizontal=vertical steps for layers
	sfh := 1.0;			% horizontal scale factor
	th  :=-0.75;      		% horizontal tilt factor of the unit cell
	tv  :=+0.25;			% vertical tilt factor of the unit cell
	tlh := 0.00;			% horizontal tilt factor of the layer
	tlv :=-0.15;			% vertical tilt factor of the layer
elseif (innermode="Dot") and (outermode="Tilt"):
	ut  := 6bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.45vt;			% horizontal=vertical steps for layers
	sfh := 1;			% horizontal scale factor
	tlh := 0.00;			% horizontal tilt factor of the layer
	tlv :=-0.15;			% vertical tilt factor of the layer
elseif outermode="Stck":	% to be implemented
	show "not implemented yet";
fi;

numeric dt; dt := .25ut;		% size of a vertex
numeric it; it := 1.0bp; % 0.7bp	% width of an edge



% ** drawing routines **********************************************************

% default vertex
vardef grvertex(expr A) =
	if innermode<>"Dot":
		draw A withpen pencircle scaled dt;
	else:
%		draw A withpen pencircle scaled 4dt;
		fill (-2dt,-2dt)--(-2dt,+2dt)--(+2dt,+2dt)--(+2dt,-2dt)--cycle shifted A withcolor black;
	fi;
enddef;

% default edge for the graph
vardef gredge(expr A,B,clr,emode) =
	if emode = "continuous":
		draw A--B withpen pencircle scaled it withcolor clr;
	elseif emode = "dashed":
		draw A--B withpen pencircle scaled it dashed evenly withcolor clr;
	elseif emode = "dotted":
		draw A--B withpen pencircle scaled it dashed withdots withcolor clr;
	fi;
enddef;



% ** definition of the vertex positions ***************************************

% calculates the coordinates of unit cells
vardef PVouter(expr x,y,z) =
numeric dij; dij := if chimeraonly=1: dlt/3; else: dlt; fi;
	if chimeraonly<>1:
	+ z*(sfh*vt,vt)			% z: index of the Chimera layers
	fi
	+ x*(sfh*dij,0)			% x: horizontal index of the unit cells
	+ y*(0,dij)			% y: vertical index of the unit cells
	if outermode="Tilt":
	+ (y*sfh*tlh*dij,x*tlv*dij)	% tilting of the lattice
	fi
enddef;

% calculates the coordinates of vertices inside unit cells
vardef PVinner(expr i,j,k) =
numeric jk; jk := 2*j+k;				% unit-cell coordinate
numeric jkb; jkb := jk-1.5;				% balanced unit-cell coordinate
numeric ib; ib := i-0.5;				% balanced unit-cell coordinate
	if innermode="Dmd":
		+ jkb*(-(1-i),-i)*ut rotated urt	% i: vertical or horizontal
	elseif innermode="Trp":
		((jk+0.75)*(-(1-i),-sfh*i)*ut +3.75/2*(1,1)*ut) rotated urt
	elseif innermode="Std":
		+ ib*(2.0ut,0)				% i: horizontal index of the vertices inside the unit cells
		+ jkb*(0,1.0ut)				% 2*j+k: vertical index of the vertices inside the unit cells
		+ ( jkb*th*ut, (-1)**i*tv*ut )		% tilting of the unit cells
	elseif innermode="Dot":
		(0,0)	
	fi
enddef;

% calculates the absolute coordinates of vertices
vardef PV(expr x,y,z,i,j,k) =
	PVouter(x,y,z) + PVinner(i,j,k)
enddef;



% ** Graph definitions ********************************************************

% drawing edges for given unit cell at coordinates (x,y,z),
% defined by the equations given in arXiv:1812.0xxxxv1 [quant-ph]
vardef edgeeq(expr eq,x,y,z,clr,emode) =
pair pici; pici:=1it*dir(-45);

if innermode<>"Dot":

	if eq = "Chimera_K44":		% equation (1): K_{4,4} edges in unit cells
		for j = 0 upto 1:
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,z,0,j,k), PV(x,y,z,1,jp,kp), clr, emode ); 
			endfor;
			endfor;
		endfor;
		endfor;
	elseif eq = "Chimera_Horizontal":	% equation (2): horizontal couplings
		for j = 0 upto 1:
			for k = 0 upto 1:
				gredge( PV(x,y,z,1,j,k), PV(x+1,y,z,1,j,k), clr, emode ); 
			endfor;
		endfor;
	elseif eq = "Chimera_Vertical":	% equation (3): vertical couplings
		for j = 0 upto 1:
			for k = 0 upto 1:
				gredge( PV(x,y,z,0,j,k), PV(x,y+1,z,0,j,k), clr, emode ); 
			endfor;
		endfor;
	elseif eq = "Pegasus_UC":	% equation (4): additional edges in unit cells
	for i = 0 upto 1:
		for j = 0 upto 1:
				gredge( PV(x,y,z,i,j,0), PV(x,y,z,i,j,1), clr, emode ); 
		endfor;
	endfor;


	elseif eq = "Pegasus_znl_xy_i0":	% equation (12) (valid for all but last z)
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,z,0,0,k), PV(x,y,z+1,1,jp,kp), clr, emode ); 
			endfor;
			endfor;
		endfor;
	elseif eq = "Pegasus_znl_xy_i1":	% equation (13) (valid for all but last z)
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,z,1,0,k), PV(x,y,z+1,0,jp,kp), clr, emode ); 
			endfor;
			endfor;
		endfor;
	elseif eq = "Pegasus_znl_xm1y_i0":	% equation (14) (valid for all but last z)
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,z,0,1,k), PV(x-1,y,z+1,1,jp,kp), clr, emode ); 
			endfor;
			endfor;
		endfor;
	elseif eq = "Pegasus_znl_xym1_i1":	% equation (15) (valid for all but last z)
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,z,1,1,k), PV(x,y-1,z+1,0,jp,kp), clr, emode );
			endfor;
			endfor;
		endfor;


	elseif eq = "Pegasus_zl_xp1yp1_i0":	% equation (16) (valid for last z)
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,Z-1,0,0,k), PV(x+1,y+1,0,1,jp,kp), clr, emode ); 
			endfor;
			endfor;
		endfor;
	elseif eq = "Pegasus_zl_xp1yp1_i1":	% equation (17) (valid for last z)
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,Z-1,1,0,k), PV(x+1,y+1,0,0,jp,kp), clr, emode ); 
			endfor;
			endfor;
		endfor;
	elseif eq = "Pegasus_zl_xyp1_i0":	% equation (18) (valid for last z)
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,Z-1,0,1,k), PV(x,y+1,0,1,jp,kp), clr, emode );
			endfor;
			endfor;
		endfor;
	elseif eq = "Pegasus_zl_xp1y_i1":	% equation (19) (valid for last z)
		for jp = 0 upto 1:
			for k = 0 upto 1:
			for kp = 0 upto 1:
				gredge( PV(x,y,Z-1,1,1,k), PV(x+1,y,0,0,jp,kp), clr, emode ); 
			endfor;
			endfor;
		endfor;
	fi;

else:

	if eq = "Chimera_Horizontal":		% equation (2): horizontal couplings
				gredge( PVouter(x,y,z), PVouter(x+1,y,z), clr, emode ); 
	elseif eq = "Chimera_Vertical":		% equation (3): vertical couplings
				gredge( PVouter(x,y,z), PVouter(x,y+1,z), clr, emode ); 
	elseif eq = "Pegasus_znl_xy_i0":	% equation (12) (valid for all but last z)
				gredge( PVouter(x,y,z)-pici, PVouter(x,y,z+1)-pici, clr, emode ); 
	elseif eq = "Pegasus_znl_xy_i1":	% equation (13) (valid for all but last z)
				gredge( PVouter(x,y,z)+pici, PVouter(x,y,z+1)+pici, clr, emode ); 
	elseif eq = "Pegasus_znl_xm1y_i0":	% equation (14) (valid for all but last z)
				gredge( PVouter(x,y,z), PVouter(x-1,y,z+1), clr, emode ); 
	elseif eq = "Pegasus_znl_xym1_i1":	% equation (15) (valid for all but last z)
				gredge( PVouter(x,y,z), PVouter(x,y-1,z+1), clr, emode );
	elseif eq = "Pegasus_zl_xp1yp1_i0":	% equation (16) (valid for last z)
				gredge( PVouter(x,y,Z-1)-pici, PVouter(x+1,y+1,0)-pici, clr, emode ); 
	elseif eq = "Pegasus_zl_xp1yp1_i1":	% equation (17) (valid for last z)
				gredge( PVouter(x,y,Z-1)+pici, PVouter(x+1,y+1,0)+pici, clr, emode ); 
	elseif eq = "Pegasus_zl_xyp1_i0":	% equation (18) (valid for last z)
				gredge( PVouter(x,y,Z-1), PVouter(x,y+1,0), clr, emode );
	elseif eq = "Pegasus_zl_xp1y_i1":	% equation (19) (valid for last z)
				gredge( PVouter(x,y,Z-1), PVouter(x+1,y,0), clr, emode ); 
	fi;
fi;

enddef;

% drawing vertices for unit cell of coordinates x,y,z
vardef ucvertex(expr x,y,z) =
	if innermode<>"Dot":
	for i = 0 upto 1:
		for j = 0 upto 1:
			for k = 0 upto 1:
				grvertex( PV(x,y,z,i,j,k) );
				if showindices=1: label.top(TEX("\tiny $"&decimal(x)&decimal(y)&decimal(z)&decimal(i)&decimal(j)&decimal(k)&"$") rotated 20, PV(x,y,z,i,j,k) ); fi;
			endfor;
		endfor;
	endfor;
	else:
				grvertex( PVouter(x,y,z) );
				if showindices=1: label.top(TEX("\tiny $"&decimal(x)&decimal(y)&decimal(z)&"$") rotated 20, PVouter(x,y,z) ); fi;
	fi;
enddef;

% ** output: unit cells *******************************************************

if innermode<>"Dot":

outputtemplate := "fig_Chimera"&innermode&outermode&"UC.eps";
beginfig(0)
				edgeeq("Chimera_K44",0,0,0,cgrey,"continuous");
				ucvertex(0,0,0);
endfig;

outputtemplate := "fig_Pegasus"&innermode&outermode&"UC.eps";
beginfig(0)
				edgeeq("Pegasus_UC",0,0,0,cblack,"continuous");
				edgeeq("Chimera_K44",0,0,0,cgrey,"continuous");
				ucvertex(0,0,0);
endfig;

fi;

% ** XxYx3 layout *************************************************************

picture ChimeraLL;
ChimeraLL := image(
	chimeraonly := 1;
	numeric z; z := 1;
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Chimera_K44",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Chimera_Vertical",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Chimera_Horizontal",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	chimeraonly := 0;
); % of ChimeraLL

picture PegasusLLone;
PegasusLLone := image(
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Chimera_K44",x,y,z,cgrey,"continuous");
				edgeeq("Pegasus_UC",x,y,z,cblack,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Chimera_Vertical",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Chimera_Horizontal",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	numeric z,x,y;
	z := 1;
	x := 2;
	y := 2;
				% outgoing edges
				edgeeq("Pegasus_znl_xy_i0",x,y,z,cblue,"continuous");
				edgeeq("Pegasus_znl_xy_i1",x,y,z,cred,"continuous");
				edgeeq("Pegasus_znl_xym1_i1",x,y,z,corange,"continuous");
				edgeeq("Pegasus_znl_xm1y_i0",x,y,z,cgreen,"continuous");
				% incoming edges
				edgeeq("Pegasus_znl_xy_i0",x,y,z-1,cblue,"continuous");
				edgeeq("Pegasus_znl_xy_i1",x,y,z-1,cred,"continuous");
				edgeeq("Pegasus_znl_xym1_i1",x,y+1,z-1,corange,"continuous");
				edgeeq("Pegasus_znl_xm1y_i0",x+1,y,z-1,cgreen,"continuous");
); % of PegasusLLone

picture PegasusLLoneblue;
PegasusLLoneblue := image(
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Chimera_K44",x,y,z,cgrey,"continuous");
				edgeeq("Pegasus_UC",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Chimera_Vertical",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Chimera_Horizontal",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	numeric z,x,y;
	z := 1;
	x := 2;
	y := 2;
				% outgoing edges
				edgeeq("Pegasus_znl_xy_i0",x,y,z,clblue,"continuous");
				edgeeq("Pegasus_znl_xy_i1",x,y,z,clblue,"continuous");
				edgeeq("Pegasus_znl_xym1_i1",x,y,z,clblue,"continuous");
				edgeeq("Pegasus_znl_xm1y_i0",x,y,z,clblue,"continuous");
				% incoming edges
				edgeeq("Pegasus_znl_xy_i0",x,y,z-1,clblue,"continuous");
				edgeeq("Pegasus_znl_xy_i1",x,y,z-1,clblue,"continuous");
				edgeeq("Pegasus_znl_xym1_i1",x,y+1,z-1,clblue,"continuous");
				edgeeq("Pegasus_znl_xm1y_i0",x+1,y,z-1,clblue,"continuous");
); % of PegasusLLoneblue

picture PegasusLLfull;
PegasusLLfull := image(
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Chimera_K44",x,y,z,cgrey,"continuous");
				edgeeq("Pegasus_UC",x,y,z,cblack,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Chimera_Vertical",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Chimera_Horizontal",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-2:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_znl_xy_i0",x,y,z,cblue,"continuous");
				edgeeq("Pegasus_znl_xy_i1",x,y,z,cred,"continuous");
			endfor;
		endfor;
		for x = 0 upto X-1:
			for y = 1 upto Y-1:
				edgeeq("Pegasus_znl_xym1_i1",x,y,z,corange,"continuous");
			endfor;
		endfor;
		for x = 1 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_znl_xm1y_i0",x,y,z,cgreen,"continuous");
			endfor;
		endfor;
	endfor;

		for x = 0 upto X-2:
			for y = 0 upto Y-2:
				edgeeq("Pegasus_zl_xp1yp1_i0",x,y,Z-1,cblue,"continuous");
				edgeeq("Pegasus_zl_xp1yp1_i1",x,y,Z-1,cred,"continuous");
			endfor;
		endfor;
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Pegasus_zl_xyp1_i0",x,y,Z-1,cgreen,"continuous");
			endfor;
		endfor;
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_zl_xp1y_i1",x,y,Z-1,corange,"continuous");
			endfor;
		endfor;
); % of PegasusLLfull

picture PegasusLLfullblue;
PegasusLLfullblue := image(
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Chimera_K44",x,y,z,cgrey,"continuous");
				edgeeq("Pegasus_UC",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Chimera_Vertical",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Chimera_Horizontal",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-2:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_znl_xy_i0",x,y,z,clblue,"continuous");
				edgeeq("Pegasus_znl_xy_i1",x,y,z,clblue,"continuous");
			endfor;
		endfor;
		for x = 0 upto X-1:
			for y = 1 upto Y-1:
				edgeeq("Pegasus_znl_xym1_i1",x,y,z,clblue,"continuous");
			endfor;
		endfor;
		for x = 1 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_znl_xm1y_i0",x,y,z,clblue,"continuous");
			endfor;
		endfor;
	endfor;

		for x = 0 upto X-2:
			for y = 0 upto Y-2:
				edgeeq("Pegasus_zl_xp1yp1_i0",x,y,Z-1,clblue,"continuous");
				edgeeq("Pegasus_zl_xp1yp1_i1",x,y,Z-1,clblue,"continuous");
			endfor;
		endfor;
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Pegasus_zl_xyp1_i0",x,y,Z-1,clblue,"continuous");
			endfor;
		endfor;
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_zl_xp1y_i1",x,y,Z-1,clblue,"continuous");
			endfor;
		endfor;
); % of PegasusLLfullblue

picture PegasusLLfullblues;
PegasusLLfullblues := image(
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Chimera_K44",x,y,z,cgrey,"continuous");
				edgeeq("Pegasus_UC",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Chimera_Vertical",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-1:
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Chimera_Horizontal",x,y,z,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for z = 0 upto Z-2:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_znl_xy_i0",x,y,z,cblues[z],"continuous");
				edgeeq("Pegasus_znl_xy_i1",x,y,z,cblues[z],"continuous");
			endfor;
		endfor;
		for x = 0 upto X-1:
			for y = 1 upto Y-1:
				edgeeq("Pegasus_znl_xym1_i1",x,y,z,cblues[z],"continuous");
			endfor;
		endfor;
		for x = 1 upto X-1:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_znl_xm1y_i0",x,y,z,cblues[z],"continuous");
			endfor;
		endfor;
	endfor;

		for x = 0 upto X-2:
			for y = 0 upto Y-2:
				edgeeq("Pegasus_zl_xp1yp1_i0",x,y,Z-1,cblues[2],"continuous");
				edgeeq("Pegasus_zl_xp1yp1_i1",x,y,Z-1,cblues[2],"continuous");
			endfor;
		endfor;
		for x = 0 upto X-1:
			for y = 0 upto Y-2:
				edgeeq("Pegasus_zl_xyp1_i0",x,y,Z-1,cblues[2],"continuous");
			endfor;
		endfor;
		for x = 0 upto X-2:
			for y = 0 upto Y-1:
				edgeeq("Pegasus_zl_xp1y_i1",x,y,Z-1,cblues[2],"continuous");
			endfor;
		endfor;
); % of PegasusLLfullblues


picture ChimeraLLVertices;
ChimeraLLVertices := image(
	chimeraonly := 1;
	numeric z; z := 1;
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				ucvertex(x,y,z);
			endfor;
		endfor;
	chimeraonly := 0;
); % of ChimeraLLVertices

picture PegasusLLVertices;
PegasusLLVertices := image(
	for z = 0 upto Z-1:
		for x = 0 upto X-1:
			for y = 0 upto Y-1:
				ucvertex(x,y,z);
			endfor;
		endfor;
	endfor;
); % of PegasusLLVertices



% ** output: graphs ***********************************************************

numeric bbl,bbt,bbr,bbb;	% bounding box parameters
path bb;			% path for bounding box

% this could be simplified
vardef calcbb(expr xl,yt,xr,yb)=
	% calculates the bounding box
	% left, top, right, bottom, as in "pdfcrop"
	bbl := min( xpart(.5[PVouter(xl,yb,1),PVouter(xl-1,yb-1,1)]), xpart(.5[PVouter(xl,yt,1),PVouter(xl-1,yt+1,1)]) );
	bbt := max( ypart(.5[PVouter(xr,yt,1),PVouter(xr+1,yt+1,1)]), ypart(.5[PVouter(xl,yt,1),PVouter(xl-1,yt+1,1)]) );
	bbr := max( xpart(.5[PVouter(xr,yt,1),PVouter(xr+1,yt+1,1)]), xpart(.5[PVouter(xr,yb,1),PVouter(xr+1,yb-1,1)]) );
	bbb := min( ypart(.5[PVouter(xl,yb,1),PVouter(xl-1,yb-1,1)]), ypart(.5[PVouter(xr,yb,1),PVouter(xr+1,yb-1,1)]) );
enddef;

% uncropped output:

chimeraonly := 1;
calcbb(0,Y-1,X-1,0);
bb:=(bbl,bbb)--(bbr,bbb)--(bbr,bbt)--(bbl,bbt)--cycle;
setbounds ChimeraLL to bb;
setbounds ChimeraLLVertices to bb;
chimeraonly := 0;

outputtemplate := "fig_Chimera"&innermode&outermode&decimal(X)&"x"&decimal(Y)&".eps";
beginfig(0)
	draw ChimeraLL; 
	draw ChimeraLLVertices;
endfig;

calcbb(0,Y-1,X-1,0);
bb:=(bbl,bbb)--(bbr,bbb)--(bbr,bbt)--(bbl,bbt)--cycle;
setbounds PegasusLLone to bb;
setbounds PegasusLLoneblue to bb;
setbounds PegasusLLfull to bb;
setbounds PegasusLLfullblue to bb;
setbounds PegasusLLfullblues to bb;
setbounds PegasusLLVertices to bb;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"one.eps";
beginfig(0)
	draw PegasusLLone;
	draw PegasusLLVertices;
endfig;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"oneblue.eps";
beginfig(0)
	draw PegasusLLoneblue;
	draw PegasusLLVertices;
endfig;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"full.eps";
beginfig(0)
	draw PegasusLLfull;
	draw PegasusLLVertices;
endfig;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"fullblue.eps";
beginfig(0)
	draw PegasusLLfullblue;
	draw PegasusLLVertices;
endfig;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"fullblues.eps";
beginfig(0)
	draw PegasusLLfullblues;
	draw PegasusLLVertices;
endfig;



% cropped output:

numeric dbblone,dbbtone,dbbrone,dbbbone;
numeric dbblfull,dbbtfull,dbbrfull,dbbbfull;

% these can be merged later, if the parameters "converged"
if (innermode="Trp") and (outermode="Rect"):
	dbblone := vt-1.5ut;
	dbbtone := vt-2.25ut;
	dbbrone := vt-2.25ut;
	dbbbone := vt-1.5ut;
%	dbblone := vt+.5ut;
%	dbbtone := vt+.5ut;
%	dbbrone := vt+.5ut;
%	dbbbone := vt+.5ut;
	dbblfull := -.5ut;
	dbbtfull := -.5ut;
	dbbrfull := -.5ut;
	dbbbfull := -.5ut;
elseif (innermode="Dmd") and (outermode="Rect"):
	dbblone := vt-1.5ut;
	dbbtone := vt-1.5ut;
	dbbrone := vt-1.5ut;
	dbbbone := vt-1.5ut;
	dbblfull := -.5ut;
	dbbtfull := -.5ut;
	dbbrfull := -.5ut;
	dbbbfull := -.5ut;
elseif (innermode="Std") and (outermode="Rect"):
	dbblone := vt+.5ut;
	dbbtone := vt+.5ut;
	dbbrone := vt+.5ut;
	dbbbone := vt+.5ut;
	dbblfull := -.5ut;
	dbbtfull := -.5ut;
	dbbrfull := -.5ut;
	dbbbfull := -.5ut;
elseif (innermode="Dot") and (outermode="Rect"):
	dbblone := vt+.5ut;
	dbbtone := vt+.5ut;
	dbbrone := vt+.5ut;
	dbbbone := vt+.5ut;
	dbblfull := -.5ut;
	dbbtfull := -.5ut;
	dbbrfull := -.5ut;
	dbbbfull := -.5ut;
elseif (innermode="Trp") and (outermode="Tilt"):
	dbblone := vt-1.00ut;
	dbbtone := vt-3.00ut;
	dbbrone := vt-1.50ut;
	dbbbone := vt-1.75ut;
	dbblfull := -.5ut;
	dbbtfull := -1.5ut;
	dbbrfull := -.5ut;
	dbbbfull := -1.5ut;
elseif (innermode="Dmd") and (outermode="Tilt"):
	dbblone := vt-1.00ut;
	dbbtone := vt-2.00ut;
	dbbrone := vt-1.00ut;
	dbbbone := vt-2.00ut;
	dbblfull := -.5ut;
	dbbtfull := -1.5ut;
	dbbrfull := -.5ut;
	dbbbfull := -1.5ut;
elseif (innermode="Std") and (outermode="Tilt"):
	dbblone := vt+1.5ut;
	dbbtone := vt+0.25ut;
	dbbrone := vt+1.5ut;
	dbbbone := vt+0.25ut;
	dbblfull := -.5ut;
	dbbtfull := -1.5ut;
	dbbrfull := -.5ut;
	dbbbfull := -1.5ut;
elseif (innermode="Dot") and (outermode="Tilt"):
	dbblone := vt+.5ut;
	dbbtone := vt+.5ut;
	dbbrone := vt+.5ut;
	dbbbone := vt+.5ut;
	dbblfull := -0.5ut;
	dbbtfull := -1.5ut;
	dbbrfull := -0.5ut;
	dbbbfull := -1.5ut;
elseif outermode="Stck":	% to be implemented
	show "not implemented yet";
fi;

chimeraonly := 1;
calcbb(1,2,2,1);
bb:=(bbl,bbb)--(bbr,bbb)--(bbr,bbt)--(bbl,bbt)--cycle;
setbounds ChimeraLL to bb;
setbounds ChimeraLLVertices to bb;
chimeraonly := 0;

outputtemplate := "fig_Chimera"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"_crop.eps";
beginfig(0)
	draw ChimeraLL; 
	draw ChimeraLLVertices;
endfig;

calcbb(2,2,2,2);
bb:=(bbl-sfh*dbblone,bbb-dbbbone)--(bbr+sfh*dbbrone,bbb-dbbbone)--(bbr+sfh*dbbrone,bbt+dbbtone)--(bbl-sfh*dbblone,bbt+dbbtone)--cycle;
setbounds PegasusLLone to bb;
setbounds PegasusLLoneblue to bb;
setbounds PegasusLLVertices to bb;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"one_crop.eps";
beginfig(0)
	draw PegasusLLone;
	draw PegasusLLVertices;
endfig;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"oneblue_crop.eps";
beginfig(0)
	draw PegasusLLoneblue;
	draw PegasusLLVertices;
endfig;

calcbb(0,1,1,0);
bb:=(bbl-sfh*dbblfull,bbb-dbbbfull)--(bbr+sfh*dbbrfull,bbb-dbbbfull)--(bbr+sfh*dbbrfull,bbt+dbbtfull)--(bbl-sfh*dbblfull,bbt+dbbtfull)--cycle;
setbounds PegasusLLfull to bb;
setbounds PegasusLLfullblue to bb;
setbounds PegasusLLfullblues to bb;
setbounds PegasusLLVertices to bb;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"full_crop.eps";
beginfig(0)
	draw PegasusLLfull;
	draw PegasusLLVertices;
endfig;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"fullblue_crop.eps";
beginfig(0)
	draw PegasusLLfullblue;
	draw PegasusLLVertices;
endfig;

outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"fullblues_crop.eps";
beginfig(0)
	draw PegasusLLfullblues;
	draw PegasusLLVertices;
endfig;

% a different cropping for the fig in the main text
if (innermode="Dot") and (outermode="Rect"):

	calcbb(1,2,3,1);
	bbl := bbl-2.0ut;
	bbt := bbt-1.5ut;
	bbr := bbr+2.0ut;
	bbb := bbb+1.5ut;
	bb:=(bbl,bbb)--(bbr,bbb)--(bbr,bbt)--(bbl,bbt)--cycle;
	setbounds PegasusLLfull to bb;
	setbounds PegasusLLVertices to bb;
	
	outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"full_croprect.eps";
	beginfig(0)
	        draw PegasusLLfull;
	        draw PegasusLLVertices;
	endfig;

fi;

% one-vertex insets
if innermode<>"Dot":

	bb := ((-.5ut,-ut)--(+.5ut,-ut)--(+.5ut,+ut)--(-.5ut,+ut)--cycle) shifted if innermode = "Std": PV(2,2,2,1,0,0) else: PV(2,2,2,0,0,1) fi;
	setbounds PegasusLLfull to bb;
	setbounds PegasusLLfullblue to bb;
	setbounds PegasusLLVertices to bb;
	
	outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"full_vertexcrop.eps";
	beginfig(0)
		draw PegasusLLfull;
		draw PegasusLLVertices;
	endfig;
	
	outputtemplate := "fig_Pegasus"&innermode&outermode&decimal(X)&"x"&decimal(Y)&"fullblue_vertexcrop.eps";
	beginfig(0)
		draw PegasusLLfullblue;
		draw PegasusLLVertices;
	endfig;

fi;



end;
