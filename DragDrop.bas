Type=Class
Version=4.7
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@
#IgnoreWarnings: 2

Sub Class_Globals
	Private fx As JFX
	Private Mode As String
	Private DataID() As String
	Private DataObject() As Object
	Private DragboardImg As Image
	Private StartDrag As Boolean
	Private CallBack As Object
	Private sEventName,tEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

Public Sub MakeDragSource(pNode As Node, vCallBack As Object, vEventName As String)
	CallBack = vCallBack
	sEventName = vEventName
	If SubExists(CallBack,sEventName & "_DragDetected") Then
		Dim Event As Object = AsJO(pNode).CreateEventFromUI("javafx.event.EventHandler","DragDetected",Null)
		AsJO(pNode).RunMethod("setOnDragDetected",Array(Event))
	End If
	
	If SubExists(CallBack,sEventName & "_DragDone") Then
		Dim Event As Object = AsJO(pNode).CreateEventFromUI("javafx.event.EventHandler","DragDone",Null)
		AsJO(pNode).RunMethod("setOnDragDone",Array(Event))
	End If
	
End Sub

Private Sub DragDetected_Event(MethodName As String,Args() As Object) As Object
	
	CallSub2(CallBack,sEventName & "_DragDetected",AsMouseEvent(Args(0)))
	
	If StartDrag Then
		Dim DataFormat As JavaObject
		DataFormat.InitializeStatic("javafx.scene.input.DataFormat")
		Dim TransferMode As JavaObject
		TransferMode.InitializeArray("javafx.scene.input.TransferMode",Array(Mode))
		Dim DragBoard As JavaObject = AsJO(Args(0)).RunMethodJO("getSource",Null).RunMethod("startDragAndDrop",Array(TransferMode))
		For i = 0 To DataID.Length - 1
			Dim LDF As JavaObject = DataFormat.RunMethod("lookupMimeType",Array(DataID(i)))
			If LDF = Null Then LDF.InitializeNewInstance("javafx.scene.input.DataFormat",Array(Array As String(DataID(i))))
			Dim ClipboardContent As JavaObject
			ClipboardContent.InitializeNewInstance("javafx.scene.input.ClipboardContent",Null)
			ClipboardContent.RunMethod("put",Array(LDF,DataObject(i)))
			DragBoard.RunMethod("setContent",Array(ClipboardContent))
			If DragboardImg.IsInitialized Then DragBoard.RunMethod("setDragView",Array(DragboardImg))
		Next
		
	End If
End Sub

Private Sub DragDone_Event(MethodName As String,Args() As Object) As Object
	Dim DE As DragEvent
	DE.Initialize
	DE.SetObject(Args(0))
	CallSub2(CallBack,sEventName & "_DragDone",DE)
End Sub

Public Sub StartDragModeAndData(TransferMode As String,DataIDs() As String,DataObjects() As Object,DragboardImage As Image)
	Mode = TransferMode
	DataID = DataIDs
	DataObject = DataObjects
	StartDrag = True
	DragboardImg = DragboardImage
End Sub


Public Sub MakeDragTarget(pNode As Node, vEventName As String)
	tEventName = vEventName
	If SubExists(CallBack,tEventName & "_DragOver") Then
		Dim Event As Object = AsJO(pNode).CreateEventFromUI("javafx.event.EventHandler","DragOver",Null)
		AsJO(pNode).RunMethod("setOnDragOver",Array(Event))
	End If
	If SubExists(CallBack,tEventName & "_DragEntered") Then
		Dim Event As Object = AsJO(pNode).CreateEventFromUI("javafx.event.EventHandler","DragEntered",Null)
		AsJO(pNode).RunMethod("setOnDragEntered",Array(Event))
	End If
	If SubExists(CallBack,tEventName & "_DragExited") Then
		Dim Event As Object = AsJO(pNode).CreateEventFromUI("javafx.event.EventHandler","DragExited",Null)
		AsJO(pNode).RunMethod("setOnDragExited",Array(Event))
	End If
	If SubExists(CallBack,tEventName & "_DragDropped") Then
		Dim Event As Object = AsJO(pNode).CreateEventFromUI("javafx.event.EventHandler","DragDropped",Null)
		AsJO(pNode).RunMethod("setOnDragDropped",Array(Event))
	End If
End Sub

Private Sub DragOver_Event(MethodName As String,Args() As Object) As Object
	Dim DE As DragEvent
	DE.Initialize
	DE.SetObject(Args(0))
	CallSub2(CallBack,tEventName & "_DragOver",DE)
End Sub

Private Sub DragEntered_Event(MethodName As String,Args() As Object) As Object
	Dim DE As DragEvent
	DE.Initialize
	DE.SetObject(Args(0))
	CallSub2(CallBack,tEventName & "_DragEntered",DE)
End Sub

Private Sub DragExited_Event(MethodName As String,Args() As Object) As Object
	Dim DE As DragEvent
	DE.Initialize
	DE.SetObject(Args(0))
	CallSub2(CallBack,tEventName & "_DragExited",DE)
End Sub

Private Sub DragDropped_Event(MethodName As String,Args() As Object) As Object
	Dim DE As DragEvent
	DE.Initialize
	DE.SetObject(Args(0))
	CallSub2(CallBack,tEventName & "_DragDroppedr",DE)
End Sub

Private Sub AsMouseEvent(M As MouseEvent) As MouseEvent
	Return M
End Sub
Private Sub AsJO(JO As JavaObject) As JavaObject
	Return JO
End Sub