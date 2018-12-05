#!/bin/bash

for f in fig*.eps; do ./a2ping.pl $f; done
#for f in fig*.eps; do epspdf $f; done

pdfcrop --margins '-100 -100 -215 -215'	fig_ChimeraDmdRect5x5.pdf		fig_ChimeraDmdRect5x5_crop.pdf
pdfcrop --margins '-560 -560 -560 -560'	fig_PegasusDmdRect5x5one.pdf		fig_PegasusDmdRect5x5one_crop.pdf
pdfcrop --margins '-320 -320 -670 -670'	fig_PegasusDmdRect5x5full.pdf		fig_PegasusDmdRect5x5full_crop.pdf
pdfcrop --margins '-320 -320 -670 -670'	fig_PegasusDmdRect5x5fullblue.pdf	fig_PegasusDmdRect5x5fullblue_crop.pdf

pdfcrop --margins '-100 -100 -215 -215'	fig_ChimeraTrpRect5x5.pdf		fig_ChimeraTrpRect5x5_crop.pdf
pdfcrop --margins '-560 -560 -560 -560'	fig_PegasusTrpRect5x5one.pdf		fig_PegasusTrpRect5x5one_crop.pdf
pdfcrop --margins '-320 -320 -670 -670'	fig_PegasusTrpRect5x5full.pdf		fig_PegasusTrpRect5x5full_crop.pdf
pdfcrop --margins '-320 -320 -670 -670'	fig_PegasusTrpRect5x5fullblue.pdf	fig_PegasusTrpRect5x5fullblue_crop.pdf

pdfcrop --margins '-110 -100 -225 -215'	fig_ChimeraStdRect5x5.pdf		fig_ChimeraStdRect5x5_crop.pdf
pdfcrop --margins '-565 -565 -565 -565'	fig_PegasusStdRect5x5one.pdf		fig_PegasusStdRect5x5one_crop.pdf
pdfcrop --margins '-330 -330 -690 -690'	fig_PegasusStdRect5x5full.pdf		fig_PegasusStdRect5x5full_crop.pdf
pdfcrop --margins '-330 -330 -690 -690'	fig_PegasusStdRect5x5fullblue.pdf	fig_PegasusStdRect5x5fullblue_crop.pdf

pdfcrop --margins ' -20  -20  -50  -50'	fig_ChimeraDotRect5x5.pdf		fig_ChimeraDotRect5x5_crop.pdf
pdfcrop --margins '-125 -125 -125 -125'	fig_PegasusDotRect5x5one.pdf		fig_PegasusDotRect5x5one_crop.pdf
pdfcrop --margins ' -75  -75 -160 -160'	fig_PegasusDotRect5x5full.pdf		fig_PegasusDotRect5x5full_crop.pdf
pdfcrop --margins ' -75  -75 -160 -160'	fig_PegasusDotRect5x5fullblue.pdf	fig_PegasusDotRect5x5fullblue_crop.pdf

pdfcrop --margins '-100 -130 -215 -265'	fig_ChimeraDmdTilt5x5.pdf		fig_ChimeraDmdTilt5x5_crop.pdf
pdfcrop --margins '-560 -670 -560 -670'	fig_PegasusDmdTilt5x5one.pdf		fig_PegasusDmdTilt5x5one_crop.pdf
pdfcrop --margins '-340 -420 -720 -840'	fig_PegasusDmdTilt5x5full.pdf		fig_PegasusDmdTilt5x5full_crop.pdf
pdfcrop --margins '-340 -420 -720 -840'	fig_PegasusDmdTilt5x5fullblue.pdf	fig_PegasusDmdTilt5x5fullblue_crop.pdf

pdfcrop --margins '-110 -140 -235 -280'	fig_ChimeraTrpTilt5x5.pdf		fig_ChimeraTrpTilt5x5_crop.pdf
pdfcrop --margins '-580 -690 -580 -690'	fig_PegasusTrpTilt5x5one.pdf		fig_PegasusTrpTilt5x5one_crop.pdf
pdfcrop --margins '-340 -420 -720 -850'	fig_PegasusTrpTilt5x5full.pdf		fig_PegasusTrpTilt5x5full_crop.pdf
pdfcrop --margins '-340 -420 -720 -850'	fig_PegasusTrpTilt5x5fullblue.pdf	fig_PegasusTrpTilt5x5fullblue_crop.pdf

pdfcrop --margins '-110 -125 -220 -250'	fig_ChimeraStdTilt5x5.pdf		fig_ChimeraStdTilt5x5_crop.pdf
pdfcrop --margins '-520 -620 -520 -620'	fig_PegasusStdTilt5x5one.pdf		fig_PegasusStdTilt5x5one_crop.pdf
pdfcrop --margins '-320 -380 -660 -760'	fig_PegasusStdTilt5x5full.pdf		fig_PegasusStdTilt5x5full_crop.pdf
pdfcrop --margins '-320 -380 -660 -760'	fig_PegasusStdTilt5x5fullblue.pdf	fig_PegasusStdTilt5x5fullblue_crop.pdf

pdfcrop --margins ' -20  -30  -50  -60'	fig_ChimeraDotTilt5x5.pdf		fig_ChimeraDotTilt5x5_crop.pdf
pdfcrop --margins '-135 -165 -135 -165'	fig_PegasusDotTilt5x5one.pdf		fig_PegasusDotTilt5x5one_crop.pdf
pdfcrop --margins ' -80 -100 -170 -200'	fig_PegasusDotTilt5x5full.pdf		fig_PegasusDotTilt5x5full_crop.pdf
pdfcrop --margins ' -80 -100 -170 -200'	fig_PegasusDotTilt5x5fullblue.pdf	fig_PegasusDotTilt5x5fullblue_crop.pdf

