
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
00:00:00.0012default:default2
1240.9222default:default2
0.0002default:defaultZ17-268h px� 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: f9bf25eb
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.007 . Memory (MB): peak = 1240.922 ; gain = 0.0002default:defaulth px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1240.9222default:default2
0.0002default:defaultZ17-268h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
g
RPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: f9bf25eb
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.491 . Memory (MB): peak = 1246.734 ; gain = 5.8122default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 122b3906e
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.531 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 122b3906e
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.532 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 122b3906e
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.534 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
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
.Phase 2.1 Floorplanning | Checksum: 122b3906e
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.539 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
h
Eplace_design is not in timing mode. Skip physical synthesis in placer29*	placeflowZ46-29h px� 
D
/Phase 2 Global Placement | Checksum: 138b7d84b
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.660 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
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
;Phase 3.1 Commit Multi Column Macros | Checksum: 138b7d84b
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.662 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 1a1d6c645
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.665 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 1e004e0b7
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.671 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 1e004e0b7
*commonh px� 
�

%s
*constraints2t
`Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.671 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 


Phase %s%s
101*constraints2
3.5 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.5 Small Shape Detail Placement | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
u

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.6 Re-assign LUT pins | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
�

Phase %s%s
101*constraints2
3.7 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.7 Pipeline Register Optimization | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
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
N
9Phase 4.1 Post Commit Optimization | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
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
1254.4302default:default2
0.0002default:defaultZ17-268h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 1c7ea71f0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
>
)Ending Placer Task | Checksum: 135cbfceb
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1254.430 ; gain = 13.5082default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
392default:default2
252default:default2
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
1254.4302default:default2
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
00:00:00.0192default:default2
1254.4302default:default2
0.0002default:defaultZ17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1254.4302default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2K
7E:/Works/com_labs/lab1/lab1.runs/impl_1/lab1_placed.dcp2default:defaultZ17-1381h px� 
_
%s4*runtcl2C
/Executing : report_io -file lab1_io_placed.rpt
2default:defaulth px� 
�
kreport_io: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.028 . Memory (MB): peak = 1254.430 ; gain = 0.000
*commonh px� 
�
%s4*runtcl2t
`Executing : report_utilization -file lab1_utilization_placed.rpt -pb lab1_utilization_placed.pb
2default:defaulth px� 
|
%s4*runtcl2`
LExecuting : report_control_sets -verbose -file lab1_control_sets_placed.rpt
2default:defaulth px� 
�
ureport_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.001 . Memory (MB): peak = 1254.430 ; gain = 0.000
*commonh px� 


End Record