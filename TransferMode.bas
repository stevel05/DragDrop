﻿Type=StaticCode
Version=4.7
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@
'Code Module
Sub Process_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private TJO As JavaObject
	'Constants / Fields are defined here and initialized in Sub UpdateConstants
	'Array containing all transfer modes.
	Public ANY As Object
	'Array containing transfer modes COPY and MOVE.
	Public COPY_OR_MOVE As Object
	'Empty array of transfer modes.
'	Public NONE As Object
	'Indicates copying of data is supported or intended.
	Public COPY As Object
	'Indicates moving of data is supported or intended.
	Public MOVE As Object
	'Indicates moving of data is supported or intended.
	Public LINK As Object
	
	Private Initialized As Boolean

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	If Initialized Then Return
	TJO.InitializeStatic("javafx.scene.input.TransferMode")
	UpdateConstants
	Initialized = True
End Sub

Private Sub UpdateConstants
	ANY = TJO.GetField("ANY")
	COPY_OR_MOVE = TJO.GetField("COPY_OR_MOVE")
'	NONE = TJO.GetField("NONE")
	Dim Arr As JavaObject
	Arr.InitializeArray("javafx.scene.input.TransferMode",Array(TJO.RunMethod("valueOf",Array("COPY"))))
	COPY = Arr
	Dim Arr As JavaObject
	Arr.InitializeArray("javafx.scene.input.TransferMode",Array(TJO.RunMethod("valueOf",Array("MOVE"))))
	MOVE = Arr
	Dim Arr As JavaObject
	Arr.InitializeArray("javafx.scene.input.TransferMode",Array(TJO.RunMethod("valueOf",Array("LINK"))))
	LINK = Arr
End Sub

Public Sub ToString(Mode As Object) As String
	Return ASJO(Mode).RunMethod("toString",Null)
End Sub

Private Sub ASJO(JO As JavaObject) As JavaObject
	Return JO
End Sub
