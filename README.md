# DragDrop - B4j
##javafx 8 Drag and Drop

This library is an update to jDragandDrop to take advantage of the DragBorad.DragView available in JavaFX8. This allows displaying a graphic next to or behind the mouse cursor while dragging items.

It's not quite a drop in replacement, but I tried to make it as close as possible.

The differences are:
- The DragAndDrop class needs to be initialized with the Callback module.
- The Transfer Mode does not support strings, it needs to be a TransferMode array, which are available as variables from the TransferMode static class.
- The e.AcceptTransferMode call has changed to e.AcceptTransferModes.
- There are two additional SetDragModeAndData methods to cater for setting the DragView.
- I have exposed most of the Dragboard methods which make it easier to select the data you want to accept, and get the results from the dragboard, and most of the DragEvent methods. Existing code should work as is.
- If you use sender to get the current EventSource (as opposed to the GestureSource) you will need to change it from sender to e.GetEventSource
- The demo shows drag and drop from within the app, and from outside it for text and images.

Issues:
- The only issue I found, and it may be a 'feature'. Is that if an image is being dragged, a copy of that image is used in place of whatever is set in the dragview. I would have preferred to be able to set a thumbnail, but it doesn't appear to work like that.​

It written as 4 code modules, you can compile it to a library if you prefer.

Please let me know if you find any problems with it.
