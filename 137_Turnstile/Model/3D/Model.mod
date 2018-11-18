'# MWS Version: Version 2015.0 - Jan 16 2015 - ACIS 24.0.2 -

'# length = m
'# frequency = MHz
'# time = ns
'# frequency range: fmin = 100 fmax = 200
'# created = '[VERSION]2015.0|24.0.2|20150116[/VERSION]


'@ use template: 137MHz

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
'set the units
With Units
    .Geometry "cm"
    .Frequency "MHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "NanoH"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "PikoF"
End With

'----------------------------------------------------------------------------

Plot.DrawBox True

With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mue "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With

With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With

' switch on FD-TET setting for accurate farfields

FDSolver.ExtrudeOpenBC "True"

Mesh.FPBAAvoidNonRegUnite "True"
Mesh.ConsiderSpaceForLowerMeshLimit "False"
Mesh.MinimumStepNumber "5"

With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
End With

With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With

PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"

'----------------------------------------------------------------------------

'set the frequency range
Solver.FrequencyRange "100", "200"

Dim sDefineAt As String
sDefineAt = "100;137;200"
Dim sDefineAtName As String
sDefineAtName = "100;137;200"
Dim sDefineAtToken As String
sDefineAtToken = "f="
Dim aFreq() As String
aFreq = Split(sDefineAt, ";")
Dim aNames() As String
aNames = Split(sDefineAtName, ";")

Dim nIndex As Integer
For nIndex = LBound(aFreq) To UBound(aFreq)

Dim zz_val As String
zz_val = aFreq (nIndex)
Dim zz_name As String
zz_name = sDefineAtToken & aNames (nIndex)

' Define E-Field Monitors
With Monitor
    .Reset
    .Name "e-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Efield"
    .Frequency zz_val
    .Create
End With

' Define H-Field Monitors
With Monitor
    .Reset
    .Name "h-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Hfield"
    .Frequency zz_val
    .Create
End With

' Define Farfield Monitors
With Monitor
    .Reset
    .Name "farfield ("& zz_name &")"
    .Domain "Frequency"
    .FieldType "Farfield"
    .Frequency zz_val
    .ExportFarfieldSource "False"
    .Create
End With

Next

'----------------------------------------------------------------------------

With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With

With Mesh
     .MeshType "PBA"
End With

'set the solver type
ChangeSolverType("HF Time Domain")



'@ define material: Aluminum

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Material
     .Reset
     .Name "Aluminum"
     .Folder ""
.FrqType "static" 
.Type "Normal" 
.SetMaterialUnit "Hz", "mm" 
.Epsilon "1" 
.Mue "1.0" 
.Kappa "3.56e+007" 
.TanD "0.0" 
.TanDFreq "0.0" 
.TanDGiven "False" 
.TanDModel "ConstTanD" 
.KappaM "0" 
.TanDM "0.0" 
.TanDMFreq "0.0" 
.TanDMGiven "False" 
.TanDMModel "ConstTanD" 
.DispModelEps "None" 
.DispModelMue "None" 
.DispersiveFittingSchemeEps "General 1st" 
.DispersiveFittingSchemeMue "General 1st" 
.UseGeneralDispersionEps "False" 
.UseGeneralDispersionMue "False" 
.FrqType "all" 
.Type "Lossy metal" 
.MaterialUnit "Frequency", "GHz"
.MaterialUnit "Geometry", "mm"
.MaterialUnit "Time", "s"
.MaterialUnit "Temperature", "Kelvin"
.Mue "1.0" 
.Sigma "3.56e+007" 
.Rho "2700.0" 
.ThermalType "Normal" 
.ThermalConductivity "237.0" 
.HeatCapacity "0.9"
.MetabolicRate "0"
.BloodFlow "0"
.VoxelConvection "0"
.MechanicsType "Isotropic"
.YoungsModulus "69"
.PoissonsRatio "0.33"
.ThermalExpansionRate "23"
.ReferenceCoordSystem "Global"
.CoordSystemType "Cartesian"
.NLAnisotropy "False"
.NLAStackingFactor "1"
.NLADirectionX "1"
.NLADirectionY "0"
.NLADirectionZ "0"
.ParticleProperty "SecondaryEmission"
.SeModel "Furman"
.SeVaughan "805", "2.98", "0", "1.0", "7.5"
.SePlot1D "True", "0", "100", "0", "1000"
.SeMaxSecondaries "10"
.SeTsParam_T1 "0.66"
.SeTsParam_T2 "0.80"
.SeTsParam_T3 "0.70"
.SeTsParam_T4 "1.00"
.SeTsParam_SEY "2.98"
.SeTsParam_Energy "805"
.SeTsParam_S "1.1"
.SeTsParam_PN "0", "1.6"
.SeTsParam_PN "1", "2.0"
.SeTsParam_PN "2", "1.8"
.SeTsParam_PN "3", "4.7"
.SeTsParam_PN "4", "1.8"
.SeTsParam_PN "5", "2.4"
.SeTsParam_PN "6", "1.8"
.SeTsParam_PN "7", "1.8"
.SeTsParam_PN "8", "2.3"
.SeTsParam_PN "9", "1.8"
.SeTsParam_EpsN "0", "3.90"
.SeTsParam_EpsN "1", "6.20"
.SeTsParam_EpsN "2", "13.00"
.SeTsParam_EpsN "3", "8.80"
.SeTsParam_EpsN "4", "6.25"
.SeTsParam_EpsN "5", "2.25"
.SeTsParam_EpsN "6", "9.20"
.SeTsParam_EpsN "7", "5.30"
.SeTsParam_EpsN "8", "17.80"
.SeTsParam_EpsN "9", "10.00"
.SeRdParam_R "1.0"
.SeRdParam_R1 "0.26"
.SeRdParam_R2 "2.0"
.SeRdParam_Q "0.4"
.SeRdParam_P1Inf "0.01"
.SeRdParam_Energy "40.0"
.SeBsParam_Sigma "1.9"
.SeBsParam_E1 "0.26"
.SeBsParam_E2 "2.0"
.SeBsParam_P1Hat "0.02"
.SeBsParam_P1Inf "0.01"
.SeBsParam_Energy "0.0"
.SeBsParam_P "0.9"
.SeBsParam_W "100.0"
.Colour "1", "1", "0" 
.Wireframe "False" 
.Reflection "False" 
.Allowoutline "True" 
.Transparentoutline "False" 
.Transparency "0" 
.Create
End With 


'@ new component: dipoles

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Component.New "dipoles" 


'@ define cylinder: dipoles:dipole_1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Cylinder 
     .Reset 
     .Name "dipole_1" 
     .Component "dipoles" 
     .Material "Aluminum" 
     .OuterRadius "radius" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "l" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ define units

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Units 
     .Geometry "m" 
     .Frequency "MHz" 
     .Time "ns" 
     .TemperatureUnit "Kelvin" 
     .Voltage "V" 
     .Current "A" 
     .Resistance "Ohm" 
     .Conductance "Siemens" 
     .Capacitance "PikoF" 
     .Inductance "NanoH" 
End With 


'@ paste structure data: 1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With SAT 
     .Reset 
     .FileName "*1.cby" 
     .SubProjectScaleFactor "1" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With 



'@ align: Faces previously pasted

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Pick 
     .PickFaceFromId "dipoles:dipole_1_1", "1" 
     .PickFaceFromId "dipoles:dipole_1", "1" 
End With 

With Align
     .Reset 
     .ClearSubProjectImportInfo "True" 
     .SetKindOfPickFor "SourcePlane", "Face" 
     .SetKindOfPickFor "TargetPlane", "Face" 
     .Align "Subproject", "Faces" 
End With 


'@ rename block: dipoles:dipole_1_1 to: dipoles:dipole_2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Rename "dipoles:dipole_1_1", "dipole_2"


'@ transform: translate dipoles:dipole_2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "dipoles:dipole_2" 
     .Vector "0", "0", "-gap" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Translate" 
End With 


'@ clear picks

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.ClearAllPicks 


'@ pick edge

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickEdgeFromId "dipoles:dipole_2", "1", "1" 


'@ pick edge

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickEdgeFromId "dipoles:dipole_1", "1", "1" 


'@ define cylinder: dipoles:gap

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Cylinder 
     .Reset 
     .Name "gap" 
     .Component "dipoles" 
     .Material "Vacuum" 
     .OuterRadius "radius" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "-gap" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ clear picks

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.ClearAllPicks 


'@ paste structure data: 2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With SAT 
     .Reset 
     .FileName "*2.cby" 
     .SubProjectScaleFactor "1" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With 



'@ transform: rotate component1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1" 
     .Origin "CommonCenter" 
     .Center "0", "0", "0" 
     .Angle "90", "0", "0" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With 


'@ boolean add shapes: dipoles:gap, component1:gap

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Add "dipoles:gap", "component1:gap" 

'@ rename block: component1:dipole_1 to: component1:dipole_3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Rename "component1:dipole_1", "dipole_3"


'@ rename block: component1:dipole_2 to: component1:dipole_4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Rename "component1:dipole_2", "dipole_4"


'@ change component: component1:dipole_3 to: dipoles:dipole_3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.ChangeComponent "component1:dipole_3", "dipoles" 


'@ change component: component1:dipole_4 to: dipoles:dipole_4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.ChangeComponent "component1:dipole_4", "dipoles" 


'@ delete component: component1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Component.Delete "component1" 


'@ align wcs with point

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickEndpointFromId "dipoles:gap", "5" 
WCS.AlignWCSWithSelectedPoint 


'@ activate global coordinates

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
WCS.ActivateWCS "global"


'@ activate local coordinates

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
WCS.ActivateWCS "local"


