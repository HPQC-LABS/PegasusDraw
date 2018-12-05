% https://github.com/HPQC-LABS/PegasusDraw
%
% Szilard Szalay, Nike Dattani, Nicholas Chancellor
%
% compiling:
% simple compiling: 
%     mpost DWaveGraphs.mp
% if there are LaTeX labels:
%     TEX=pdflatex mpost DWaveGraphs.mp
% for converting and cropping PDFs,  you can use the shell script makepdf.sh

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
color cblack;	cblack := ( 0*16+ 0, 0*16+ 0, 0*16+ 0)/256;	% hsv:   0,  0,  0
color cgrey;	cgrey  := (13*16+ 0,13*16+ 0,13*16+ 0)/256;	% hsv:   
%color cred;	cred   := (15*16+15, 3*16+ 6, 3*16+ 6)/256;	% hsv:   0, 79,100
color cred;	cred   := (       1,       0,       0)    ;	% hsv:   
color clblue; 	clblue := ( 180    , 206    , 256    )/256;     % hsv: 
%color cblue;	cblue  := ( 8*16+ 4, 8*16+ 4,15*16+15)/256;     % hsv: 240, 22, 67
color cblue;	cblue  := clblue;
%color cdblue;	cdblue := ( 45     , 98     ,     255)/256;     % hsv: 
color cdblue;	cdblue := clblue;
color cgreeno;	cgreeno:= ( 9*16+10,15*16+15, 9*16+10)/256;	% hsv: 120, 40,100
color cgreen ;	cgreen := (       0,    0.95,       0)    ;	% hsv: 

color cgreen;	cgreen := ( 0*16+ 0, 9*16+10, 4*16+ 2)/256;	% hsv: 146,100, 60
%color corange;	corange:= (15*16+15, 9*16+15, 0*16+ 0)/256;	% hsv:  37,100,100
color corange;	corange:= (       1,     0.5,       0)    ;	% hsv:  37,100,100

% ** units *********************************************************************

numeric L;                          	% size of the Chimera blocks, $L\times L$
L := 5;

string drawingmode;			% unit cells:	  layers:
%drawingmode := "DmdRect";		%   diamond	  rectangular, one behind the other
%drawingmode := "TrpRect";		%   trapezoid	  rectangular, one behind the other
%drawingmode := "StdRect";		%   2x4		  rectangular, one behind the other
%drawingmode := "DotRect";		%   one dot	  rectangular, one behind the other
%drawingmode := "DmdTilt"; 		%   diamond	  parallelogram, one behind the other
%drawingmode := "TrpTilt";		%   trapezoid	  parallelogram, one behind the other
%drawingmode := "StdTilt";		%   2x4		  parallelogram, one behind the other
%drawingmode := "DotTilt";		%   one dot	  parallelogram, one behind the other
% not implemented yet:
%drawingmode := "DmdStck";		%   diamond	  parallelogram, stacked one on top of the other
%drawingmode := "StdStck";		%   2x4		  parallelogram, stacked one on top of the other

numeric ChimeraOnly; ChimeraOnly := 0;

numeric ut, vt, dlt, urt, sfh; 
numeric th, tv, tlh, tlv;

if drawingmode="DmdRect":
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.25vt;			% horizontal=vertical steps for layers
	urt := 0;			% rotation of the unit cell
	sfh := 1.0;			% horizontal scale factor
elseif drawingmode="TrpRect":
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.25vt;			% horizontal=vertical steps for layers
	urt := 0;			% rotation of the unit cell
	sfh := 1.0;			% horizontal scale factor
elseif drawingmode="StdRect":
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.25vt;			% horizontal=vertical steps for layers
	th  :=-0.70;      		% horizontal tilt factor of the unit cell
	tv  :=+0.25;			% vertical tilt factor of the unit cell
elseif drawingmode="DotRect":
	ut  := 6bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.25vt;			% horizontal=vertical steps for layers
	sfh := 1.0;			% horizontal scale factor
elseif drawingmode="DmdTilt":
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.45vt;			% horizontal=vertical steps for layers
	urt := 0;			% rotation of the unit cell
	sfh := 1.0;			% horizontal scale factor
	tlh := 0.00;			% horizontal tilt factor of the layer
	tlv :=-0.15;			% vertical tilt factor of the layer
elseif drawingmode="TrpTilt":
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.45vt;			% horizontal=vertical steps for layers
	urt := 0;			% rotation of the unit cell
	sfh := 1;			% horizontal scale factor
	tlh := 0.00;			% horizontal tilt factor of the layer
	tlv :=-0.15;			% vertical tilt factor of the layer
elseif drawingmode="StdTilt":
	ut  := 24bp;			% base unit (general, and for unit cells)
	vt  := 4.0ut;			% base unit (for graph)
	dlt := 3.45vt;			% horizontal=vertical steps for layers
	th  :=-0.75;      		% horizontal tilt factor of the unit cell
	tv  :=+0.25;			% vertical tilt factor of the unit cell
	tlh := 0.00;			% horizontal tilt factor of the layer
	tlv :=-0.15;			% vertical tilt factor of the layer
elseif drawingmode="DotTilt":
	ut  := 6bp;			% base unit (general, and for unit cells)
	vt  := 4.5ut;			% base unit (for graph)
	dlt := 3.45vt;			% horizontal=vertical steps for layers
	sfh := 1;			% horizontal scale factor
	tlh := 0.00;			% horizontal tilt factor of the layer
	tlv :=-0.15;			% vertical tilt factor of the layer
elseif drawingmode="DmdStck":	% to be implemented
	show "not implemented yet";
elseif drawingmode="StdStck":	% to be implemented
	show "not implemented yet";
fi;

numeric dt; dt := .25ut;		% size of a vertex
numeric it; it := 1.0bp; % 0.7bp	% width of an edge

% ** drawing routines **********************************************************

% default vertex
vardef grvertex(expr A) =
	if (drawingmode<>"DotRect") and (drawingmode<>"DotTilt"):
		draw A withpen pencircle scaled dt;
	else:
		draw A withpen pencircle scaled 4dt;
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

% calculates the coordinates of vertices,
vardef PV(expr c,i,j,u,p,q) =
% c: index of the Chimera layers
% i: horizontal index of the unit cells
% j: vertical index of the unit cells
numeric pq; pq := 2*p+q;		% unit-cell coordinate
numeric pqb; pqb := pq-1.5;		% balanced unit-cell coordinate
numeric ub; ub := u-0.5;		% balanced unit-cell coordinate
numeric dij; dij := if ChimeraOnly=1: dlt/3; else: dlt; fi;

	if drawingmode="DmdRect":
		+ c*(sfh*vt,vt)
		+ i*(sfh*dij,0)
		+ j*(0,dij)
		+ pqb*(-sfh*(1-u),-u)*ut rotated urt		% u: vertical or horizontal
	elseif drawingmode="TrpRect":
		+ c*(vt,vt)
		+ i*(dij,0)
		+ j*(0,dij)
		+ (pq+0.75)*(-(1-u),-sfh*u)*ut rotated urt	% u: vertical or horizontal
	elseif drawingmode="StdRect":
		+ c*(vt,vt)
		+ i*(dij,0)
		+ j*(0,dij)
		+ ub*(2.0ut,0)			% u: horizontal index of the vertices inside the unit cells
		+ pqb*(0,1.0ut)			% 2*p+q: vertical index of the vertices inside the unit cells
		+ ( pqb*th*ut, (-1)**u*tv*ut )	% tilting of the unit cells
	elseif drawingmode="DotRect":
		+ c*(sfh*vt,vt)
		+ i*(sfh*dij,0)
		+ j*(0,dij)
	elseif drawingmode="DmdTilt":
		+ c*(sfh*vt,vt)
		+ i*(sfh*dij,0)
		+ j*(0,dij)
		+ (j*tlh*dij,i*tlv*dij)		% tilting of the lattice
		+ pqb*(-sfh*(1-u),-u)*ut rotated urt	% u: vertical or horizontal
	elseif drawingmode="TrpTilt":
		+ c*(vt,vt)
		+ i*(dij,0)
		+ j*(0,dij)
		+ (j*tlh*dij,i*tlv*dij)	% tilting of the lattice
		+ (pq+0.75)*(-(1-u),-sfh*u)*ut rotated urt	%u: vertical or horizontal
	elseif drawingmode="StdTilt":
		+ c*(vt,vt)
		+ i*(dij,0)
		+ j*(0,dij)
		+ (j*tlh*dij,i*tlv*dij)		% tilting of the lattice
		+ ub*(2.0ut,0)			% u: horizontal index of the vertices inside the unit cells
		+ pqb*(0,1.0ut)			% 2*p+q: vertical index of the vertices inside the unit cells
		+ ( pqb*th*ut, (-1)**u*tv*ut )	% tilting of the unit cells
	elseif drawingmode="DotTilt":
		+ c*(sfh*vt,vt)
		+ i*(sfh*dij,0)
		+ j*(0,dij)
		+ (j*tlh*dij,i*tlv*dij)		% tilting of the lattice
	elseif drawingmode="DmdStck":	% to be implemented
	elseif drawingmode="StdStck":	% to be implemented
	fi
enddef;


% ** Graph definitions ********************************************************

% drawing edges defined by the equations, for given unit cell coordinates c,i,j
% based on the .pdf dated Nov 26, 2018 > no, that is corrected
vardef edgeeq(expr eq, c,i,j,clr,emode) =
pair pici; pici:=1it*dir(-45);


if (drawingmode<>"DotRect") and (drawingmode<>"DotTilt"):

	if eq = "Chimera_K44":		% equation (12): K_{4,4} edges in unit cells
					for p = 0 upto 1:
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(c,i,j,0,p,q), PV(c,i,j,1,pp,qp), clr, emode ); 
						endfor;
						endfor;
					endfor;
					endfor;
	elseif eq = "Chimera_Vertical":	% equation (13): vertical couplings
					for p = 0 upto 1:
						for q = 0 upto 1:
							gredge( PV(c,i,j,0,p,q), PV(c,i,j+1,0,p,q), clr, emode ); 
						endfor;
					endfor;
	elseif eq = "Chimera_Horizontal":	% equation (14): horizontal couplings
					for p = 0 upto 1:
						for q = 0 upto 1:
							gredge( PV(c,i,j,1,p,q), PV(c,i+1,j,1,p,q), clr, emode ); 
						endfor;
					endfor;
	elseif eq = "Pegasus_UC":	% equation (1): additional edges in unit cells
				for u = 0 upto 1:
					for p = 0 upto 1:
							gredge( PV(c,i,j,u,p,0), PV(c,i,j,u,p,1), clr, emode ); 
					endfor;
				endfor;


	elseif eq = "Pegasus_c01_ij_u0":	% equation (2) for u=0 (valid for c=0,1)
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(c,i,j,0,0,q), PV((c+1)mod3,i,j,1,pp,qp), clr, emode ); 
						endfor;
						endfor;
					endfor;
	elseif eq = "Pegasus_c01_ij_u1":	% equation (2) for u=1 (valid for c=0,1)
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(c,i,j,1,0,q), PV((c+1)mod3,i,j,0,pp,qp), clr, emode ); 
						endfor;
						endfor;
					endfor;
	elseif eq = "Pegasus_c01_ijm1_u1":	% equation (3) (valid for c=0,1)
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(c,i,j,1,1,q), PV((c+1)mod3,i,j-1,0,pp,qp), clr, emode );
						endfor;
						endfor;
					endfor;
	elseif eq = "Pegasus_c01_im1j_u0":	% equation (4) (valid for c=0,1)
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(c,i,j,0,1,q), PV((c+1)mod3,i-1,j,1,pp,qp), clr, emode ); 
						endfor;
						endfor;
					endfor;


	elseif eq = "Pegasus_c2_ip1jp1_u0":	% equation (5) for u=0 (valid for c=2, hardcoded)
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(2,i,j,0,0,q), PV(0,i+1,j+1,1,pp,qp), clr, emode ); 
						endfor;
						endfor;
					endfor;
	elseif eq = "Pegasus_c2_ip1jp1_u1":	% equation (5) for u=1 (valid for c=2, hardcoded)
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(2,i,j,1,0,q), PV(0,i+1,j+1,0,pp,qp), clr, emode ); 
						endfor;
						endfor;
					endfor;
	elseif eq = "Pegasus_c2_ijp1_u0":	% equation (6) (valid for c=2, hardcoded)
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(2,i,j,0,1,q), PV(0,i,j+1,1,pp,qp), clr, emode );
						endfor;
						endfor;
					endfor;
	elseif eq = "Pegasus_c2_ip1j_u1":	% equation (7) (valid for c=2, hardcoded)
					for pp = 0 upto 1:
						for q = 0 upto 1:
						for qp = 0 upto 1:
							gredge( PV(2,i,j,1,1,q), PV(0,i+1,j,0,pp,qp), clr, emode ); 
						endfor;
						endfor;
					endfor;
	fi;

else:

	if eq = "Chimera_Vertical":		% equation (13): vertical couplings
							gredge( PV(c,i,j,0,0,0), PV(c,i,j+1,0,0,0), clr, emode ); 
	elseif eq = "Chimera_Horizontal":	% equation (14): horizontal couplings
							gredge( PV(c,i,j,0,0,0), PV(c,i+1,j,0,0,0), clr, emode ); 
	elseif eq = "Pegasus_c01_ij_u0":	% equation (2) for u=0 (valid for c=0,1)
							gredge( PV(c,i,j,0,0,0)-pici, PV((c+1)mod3,i,j,0,0,0)-pici, clr, emode ); 
	elseif eq = "Pegasus_c01_ij_u1":	% equation (2) for u=1 (valid for c=0,1)
							gredge( PV(c,i,j,0,0,0)+pici, PV((c+1)mod3,i,j,0,0,0)+pici, clr, emode ); 
	elseif eq = "Pegasus_c01_ijm1_u1":	% equation (3) (valid for c=0,1)
							gredge( PV(c,i,j,0,0,0), PV((c+1)mod3,i,j-1,0,0,0), clr, emode );
	elseif eq = "Pegasus_c01_im1j_u0":	% equation (4) (valid for c=0,1)
							gredge( PV(c,i,j,0,0,0), PV((c+1)mod3,i-1,j,0,0,0), clr, emode ); 
	elseif eq = "Pegasus_c2_ip1jp1_u0":	% equation (5) for u=0 (valid for c=2, hardcoded)
							gredge( PV(2,i,j,0,0,0)-pici, PV(0,i+1,j+1,0,0,0)-pici, clr, emode ); 
	elseif eq = "Pegasus_c2_ip1jp1_u1":	% equation (5) for u=1 (valid for c=2, hardcoded)
							gredge( PV(2,i,j,0,0,0)+pici, PV(0,i+1,j+1,0,0,0)+pici, clr, emode ); 
	elseif eq = "Pegasus_c2_ijp1_u0":	% equation (6) (valid for c=2, hardcoded)
							gredge( PV(2,i,j,0,0,0), PV(0,i,j+1,0,0,0), clr, emode );
	elseif eq = "Pegasus_c2_ip1j_u1":	% equation (7) (valid for c=2, hardcoded)
							gredge( PV(2,i,j,0,0,0), PV(0,i+1,j,0,0,0), clr, emode ); 
	fi;
fi;

enddef;

% drawing vertices for unit cell of coordinates c,i,j
vardef ucvertex(expr c,i,j) =
	if (drawingmode<>"DotRect") and (drawingmode<>"DotTilt"):
				for u = 0 upto 1:
					for p = 0 upto 1:
						for q = 0 upto 1:
							grvertex( PV(c,i,j,u,p,q) );
							if showindices=1: label.top(TEX("\tiny $"&decimal(c)&decimal(i)&decimal(j)&decimal(u)&decimal(p)&decimal(q)&"$") rotated 20, PV(c,i,j,u,p,q) ); fi;
						endfor;
					endfor;
				endfor;
	else:
							grvertex( PV(c,i,j,0,0,0) );
							if showindices=1: label.top(TEX("\tiny $"&decimal(c)&decimal(i)&decimal(j)&"$") rotated 20, PV(c,i,j,0,0,0) ); fi;
	fi;
enddef;

% ** unit cells ***************************************************************

if (drawingmode<>"DotRect") and (drawingmode<>"DotTilt"):

outputtemplate := "fig_Chimera"&drawingmode&"UC.eps";
beginfig(0)
				edgeeq("Chimera_K44",0,0,0,cgrey,"continuous");
				ucvertex(0,0,0);
endfig;

outputtemplate := "fig_Pegasus"&drawingmode&"UC.eps";
beginfig(0)
				edgeeq("Pegasus_UC",0,0,0,cblack,"continuous");
				edgeeq("Chimera_K44",0,0,0,cgrey,"continuous");
				ucvertex(0,0,0);
endfig;

fi;

% ** 3xLxL layout *************************************************************

picture ChimeraLL;
ChimeraLL := image(
	ChimeraOnly := 1;
	numeric c; c := 1;
		for i = 0 upto L-1:
			for j = 0 upto L-1:
				edgeeq("Chimera_K44",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
		for i = 0 upto L-1:
			for j = 0 upto L-2:
				edgeeq("Chimera_Vertical",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
		for i = 0 upto L-2:
			for j = 0 upto L-1:
				edgeeq("Chimera_Horizontal",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
	ChimeraOnly := 0;
); % of ChimeraLL

picture PegasusLLone;
PegasusLLone := image(
	for c = 0 upto 2:
		for i = 0 upto L-1:
			for j = 0 upto L-1:
				edgeeq("Chimera_K44",c,i,j,cgrey,"continuous");
				edgeeq("Pegasus_UC",c,i,j,cblack,"continuous");
			endfor;
		endfor;
	endfor;
	for c = 0 upto 2:
		for i = 0 upto L-1:
			for j = 0 upto L-2:
				edgeeq("Chimera_Vertical",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for c = 0 upto 2:
		for i = 0 upto L-2:
			for j = 0 upto L-1:
				edgeeq("Chimera_Horizontal",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	numeric c,i,j;
	c := 1;
	i := 2;
	j := 2;
				% outgoing edges
				edgeeq("Pegasus_c01_ij_u0",c,i,j,cblue,"continuous");
				edgeeq("Pegasus_c01_ij_u1",c,i,j,cred,"continuous");
				edgeeq("Pegasus_c01_ijm1_u1",c,i,j,corange,"continuous");
				edgeeq("Pegasus_c01_im1j_u0",c,i,j,cgreen,"continuous");
				% incoming edges
				edgeeq("Pegasus_c01_ij_u0",c-1,i,j,cblue,"continuous");
				edgeeq("Pegasus_c01_ij_u1",c-1,i,j,cred,"continuous");
				edgeeq("Pegasus_c01_ijm1_u1",c-1,i,j+1,corange,"continuous");
				edgeeq("Pegasus_c01_im1j_u0",c-1,i+1,j,cgreen,"continuous");
); % of PegasusLLone

picture PegasusLLfull;
PegasusLLfull := image(
	for c = 0 upto 2:
		for i = 0 upto L-1:
			for j = 0 upto L-1:
				edgeeq("Chimera_K44",c,i,j,cgrey,"continuous");
				edgeeq("Pegasus_UC",c,i,j,cblack,"continuous");
			endfor;
		endfor;
	endfor;
	for c = 0 upto 2:
		for i = 0 upto L-1:
			for j = 0 upto L-2:
				edgeeq("Chimera_Vertical",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for c = 0 upto 2:
		for i = 0 upto L-2:
			for j = 0 upto L-1:
				edgeeq("Chimera_Horizontal",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for c = 0 upto 1:
		for i = 0 upto L-1:
			for j = 0 upto L-1:
				edgeeq("Pegasus_c01_ij_u0",c,i,j,cblue,"continuous");
				edgeeq("Pegasus_c01_ij_u1",c,i,j,cred,"continuous");
			endfor;
		endfor;
		for i = 0 upto L-1:
			for j = 1 upto L-1:
				edgeeq("Pegasus_c01_ijm1_u1",c,i,j,corange,"continuous");
			endfor;
		endfor;
		for i = 1 upto L-1:
			for j = 0 upto L-1:
				edgeeq("Pegasus_c01_im1j_u0",c,i,j,cgreen,"continuous");
			endfor;
		endfor;
	endfor;

		for i = 0 upto L-2:
			for j = 0 upto L-2:
				edgeeq("Pegasus_c2_ip1jp1_u0",2,i,j,cblue,"continuous");
				edgeeq("Pegasus_c2_ip1jp1_u1",2,i,j,cred,"continuous");
			endfor;
		endfor;
		for i = 0 upto L-1:
			for j = 0 upto L-2:
				edgeeq("Pegasus_c2_ijp1_u0",2,i,j,corange,"continuous");
			endfor;
		endfor;
		for i = 0 upto L-2:
			for j = 0 upto L-1:
				edgeeq("Pegasus_c2_ip1j_u1",2,i,j,cgreen,"continuous");
			endfor;
		endfor;
); % of PegasusLLfull

picture PegasusLLfullblue;
PegasusLLfullblue := image(
	for c = 0 upto 2:
		for i = 0 upto L-1:
			for j = 0 upto L-1:
				edgeeq("Chimera_K44",c,i,j,cgrey,"continuous");
				edgeeq("Pegasus_UC",c,i,j,cblack,"continuous");
			endfor;
		endfor;
	endfor;
	for c = 0 upto 2:
		for i = 0 upto L-1:
			for j = 0 upto L-2:
				edgeeq("Chimera_Vertical",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	for c = 0 upto 2:
		for i = 0 upto L-2:
			for j = 0 upto L-1:
				edgeeq("Chimera_Horizontal",c,i,j,cgrey,"continuous");
			endfor;
		endfor;
	endfor;
	color cblues[];
	cblues[0] := cdblue;
	cblues[1] := cblue;
	cblues[2] := clblue;
	for c = 0 upto 1:
		for i = 0 upto L-1:
			for j = 0 upto L-1:
				edgeeq("Pegasus_c01_ij_u0",c,i,j,cblues[c],"continuous");
				edgeeq("Pegasus_c01_ij_u1",c,i,j,cblues[c],"continuous");
			endfor;
		endfor;
		for i = 0 upto L-1:
			for j = 1 upto L-1:
				edgeeq("Pegasus_c01_ijm1_u1",c,i,j,cblues[c],"continuous");
			endfor;
		endfor;
		for i = 1 upto L-1:
			for j = 0 upto L-1:
				edgeeq("Pegasus_c01_im1j_u0",c,i,j,cblues[c],"continuous");
			endfor;
		endfor;
	endfor;

		for i = 0 upto L-2:
			for j = 0 upto L-2:
				edgeeq("Pegasus_c2_ip1jp1_u0",2,i,j,cblues[2],"continuous");
				edgeeq("Pegasus_c2_ip1jp1_u1",2,i,j,cblues[2],"continuous");
			endfor;
		endfor;
		for i = 0 upto L-1:
			for j = 0 upto L-2:
				edgeeq("Pegasus_c2_ijp1_u0",2,i,j,cblues[2],"continuous");
			endfor;
		endfor;
		for i = 0 upto L-2:
			for j = 0 upto L-1:
				edgeeq("Pegasus_c2_ip1j_u1",2,i,j,cblues[2],"continuous");
			endfor;
		endfor;
); % of PegasusLLfullblue


picture ChimeraLLDots;
ChimeraLLDots := image(
	ChimeraOnly := 1;
	numeric c; c := 1;
		for i = 0 upto L-1:
			for j = 0 upto L-1:
				ucvertex(c,i,j);
			endfor;
		endfor;
	ChimeraOnly := 0;
); % of ChimeraLLDots

picture PegasusLLDots;
PegasusLLDots := image(
	for c = 0 upto 2:
		for i = 0 upto L-1:
			for j = 0 upto L-1:
				ucvertex(c,i,j);
			endfor;
		endfor;
	endfor;
); % of PegasusLLDots

% output
outputtemplate := "fig_Chimera"&drawingmode&decimal(L)&"x"&decimal(L)&".eps";
beginfig(0)
	draw ChimeraLL;
	draw ChimeraLLDots;
endfig;

outputtemplate := "fig_Pegasus"&drawingmode&decimal(L)&"x"&decimal(L)&"one.eps";
beginfig(0)
	draw PegasusLLone;
	draw PegasusLLDots;
endfig;

outputtemplate := "fig_Pegasus"&drawingmode&decimal(L)&"x"&decimal(L)&"full.eps";
beginfig(0)
	draw PegasusLLfull;
	draw PegasusLLDots;
endfig;

outputtemplate := "fig_Pegasus"&drawingmode&decimal(L)&"x"&decimal(L)&"fullblue.eps";
beginfig(0)
	draw PegasusLLfullblue;
	draw PegasusLLDots;
endfig;

end;
