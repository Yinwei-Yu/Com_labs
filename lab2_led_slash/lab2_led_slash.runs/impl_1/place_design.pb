
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
22default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1253.1642default:default2
0.0002default:defaultZ17-268h px� 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 533825c6
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.006 . Memory (MB): peak = 1253.164 ; gain = 0.0002default:defaulth px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1253.1642default:default2
0.0002default:defaultZ17-268h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
h
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 101fab0a6
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.547 . Memory (MB): peak = 1263.027 ; gain = 9.8632default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 194d69dbc
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.603 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 194d69dbc
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.605 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 194d69dbc
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.607 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px� 
C
.Phase 2.1 Floorplanning | Checksum: 1bb455f60
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.633 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 


Phase %s%s
101*constraints2
2.2 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px� 
K
)No high fanout nets found in the design.
65*physynthZ32-65h px� 
�
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
0No setup violation found.  %s was not performed.344*physynth2-
DSP Register Optimization2default:defaultZ32-670h px� 
�
0No setup violation found.  %s was not performed.344*physynth2/
Shift Register Optimization2default:defaultZ32-670h px� 
�
0No setup violation found.  %s was not performed.344*physynth2.
BRAM Register Optimization2default:defaultZ32-670h px� 
R
.No candidate nets found for HD net replication521*physynthZ32-949h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1270.7032default:default2
0.0002default:defaultZ17-268h px� 
B
-
Summary of Physical Synthesis Optimizations
*commonh px� 
B
-============================================
*commonh px� 


*commonh px� 


*commonh px� 
�
�----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Optimization                  |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Very High Fanout              |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  DSP Register                  |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  Shift Register                |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  BRAM Register                 |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  HD Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total                         |            0  |              0  |                     0  |           0  |           2  |  00:00:00  |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
R
=Phase 2.2 Physical Synthesis In Placer | Checksum: 1894edb5c
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.807 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
D
/Phase 2 Global Placement | Checksum: 1638bd931
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.838 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 1638bd931
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.840 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 1a242a348
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.863 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 1edc8745b
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.868 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 169d72bc0
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.868 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 


Phase %s%s
101*constraints2
3.5 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.5 Small Shape Detail Placement | Checksum: 207956a04
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.932 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
u

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.6 Re-assign LUT pins | Checksum: 207956a04
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.934 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
�

Phase %s%s
101*constraints2
3.7 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.7 Pipeline Register Optimization | Checksum: 26387b479
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.934 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 26387b479
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.935 . Memory (MB): peak = 1270.703 ; gain = 17.5392default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 274d622d2
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
�BUFG insertion identified %s candidate nets, %s success, %s bufg driver replicated, %s skipped for placement/routing, %s skipped for timing, %s skipped for netlist change reason40*	placeflow2
02default:default2
02default:default2
02default:default2
02default:default2
02default:default2
02default:defaultZ46-46h px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 274d622d2
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.966 . Memory (MB): peak = 1274.156 ; gain = 20.9922default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
96.7262default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 207899d85
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.967 . Memory (MB): peak = 1274.156 ; gain = 20.9922default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 207899d85
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.967 . Memory (MB): peak = 1274.156 ; gain = 20.9922default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 207899d85
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.970 . Memory (MB): peak = 1274.156 ; gain = 20.9922default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 207899d85
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.971 . Memory (MB): peak = 1274.156 ; gain = 20.9922default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1274.1562default:default2
0.0002default:defaultZ17-268h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 16f0e1410
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.973 . Memory (MB): peak = 1274.156 ; gain = 20.9922default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 16f0e1410
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.973 . Memory (MB): peak = 1274.156 ; gain = 20.9922default:defaulth px� 
=
(Ending Placer Task | Checksum: fcf487f8
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.977 . Memory (MB): peak = 1274.156 ; gain = 20.9922default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
542default:default2
242default:default2
242default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1274.1562default:default2
0.0002default:defaultZ17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:002default:default2 
00:00:00.0252default:default2
1275.8242default:default2
1.6332default:defaultZ17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0012default:default2
1281.8442default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2_
KE:/Works/com_labs/lab2_led_slash/lab2_led_slash.runs/impl_1/lab2_placed.dcp2default:defaultZ17-1381h px� 
_
%s4*runtcl2C
/Executing : report_io -file lab2_io_placed.rpt
2default:defaulth px� 
�
kreport_io: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.033 . Memory (MB): peak = 1281.859 ; gain = 0.000
*commonh px� 
�
%s4*runtcl2t
`Executing : report_utilization -file lab2_utilization_placed.rpt -pb lab2_utilization_placed.pb
2default:defaulth px� 
|
%s4*runtcl2`
LExecuting : report_control_sets -verbose -file lab2_control_sets_placed.rpt
2default:defaulth px� 
�
ureport_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.002 . Memory (MB): peak = 1281.859 ; gain = 0.000
*commonh px� 


End Record