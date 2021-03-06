//
//  AppDelegate.swift
//  DK Mini Swift Demo
//
//  Created by C.W. Betts on 12/10/17.
//

import Cocoa
import DKDrawKit
import DKDrawKit.DKGridLayer
import DKDrawKit.DKDrawingView
import DKDrawKit.DKDrawingTool
import DKDrawKit.DKDrawingToolProtocol
import DKDrawKit.LogEvent
import DrawKitSwift

import DKDrawKit.DKSweptAngleGradient

import DKDrawKit.CurveFit
import DKDrawKit.DKArcPath
import DKDrawKit.DKArrowStroke
import DKDrawKit.DKBSPDirectObjectStorage
import DKDrawKit.DKBSPObjectStorage
import DKDrawKit.DKBezierLayoutManager
import DKDrawKit.DKCIFilterRastGroup
import DKDrawKit.DKCategoryManager
import DKDrawKit.DKCommonTypes
import DKDrawKit.DKCropTool
import DKDrawKit.DKDashable
import DKDrawKit.DKDistortionTransform
import DKDrawKit.DKDrawKitMacros
import DKDrawKit.DKDrawableContainerProtocol
import DKDrawKit.DKDrawableObject
import DKDrawKit.DKDrawableObject.Metadata
import DKDrawKit.DKDrawablePath
import DKDrawKit.DKDrawableShape
import DKDrawKit.DKDrawableShape.Hotspots
import DKDrawKit.DKDrawing
import DKDrawKit.DKDrawing.Export
import DKDrawKit.DKDrawing.Paper
import DKDrawKit.DKDrawingDocument
import DKDrawKit.DKDrawingInfoLayer
import DKDrawKit.DKDrawingTool
import DKDrawKit.DKDrawingToolProtocol
import DKDrawKit.DKDrawingView
import DKDrawKit.DKDrawkitInspectorBase
import DKDrawKit.DKFill
import DKDrawKit.DKFillPattern
import DKDrawKit.DKGeometryUtilities
import DKDrawKit.DKGradient
import DKDrawKit.DKGradient.UISupport
import DKDrawKit.DKGradient.Extensions
import DKDrawKit.DKGridLayer
import DKDrawKit.DKGuideLayer
import DKDrawKit.DKHandle
import DKDrawKit.DKHatching
import DKDrawKit.DKImageAdornment
import DKDrawKit.DKImageDataManager
import DKDrawKit.DKImageOverlayLayer
import DKDrawKit.DKImageShape
import DKDrawKit.DKKeyedUnarchiver
import DKDrawKit.DKKnob
import DKDrawKit.DKLayer
import DKDrawKit.DKLayer.Metadata
import DKDrawKit.DKLayerGroup
import DKDrawKit.DKLinearObjectStorage
import DKDrawKit.DKMetadataItem
import DKDrawKit.DKObjectCreationTool
import DKDrawKit.DKObjectDrawingLayer
import DKDrawKit.DKObjectDrawingLayer.Alignment
import DKDrawKit.DKObjectDrawingLayer.Duplication
import DKDrawKit.DKObjectOwnerLayer
import DKDrawKit.DKObjectStorageProtocol
import DKDrawKit.DKPasteboardInfo
import DKDrawKit.DKPathDecorator
import DKDrawKit.DKPathInsertDeleteTool
import DKDrawKit.DKQuartzBlendRastGroup
import DKDrawKit.DKQuartzCache
import DKDrawKit.DKRandom
import DKDrawKit.DKRastGroup
import DKDrawKit.DKRasterizer
import DKDrawKit.DKRasterizerProtocol
import DKDrawKit.DKRegularPolygonPath
import DKDrawKit.DKReshapableShape
import DKDrawKit.DKRoughStroke
import DKDrawKit.DKRouteFinder
import DKDrawKit.DKRuntimeHelper
import DKDrawKit.DKSelectAndEditTool
import DKDrawKit.DKSelectionPDFView
import DKDrawKit.DKShapeCluster
import DKDrawKit.DKShapeFactory
import DKDrawKit.DKShapeGroup
import DKDrawKit.DKStroke
import DKDrawKit.DKStrokeDash
import DKDrawKit.DKStyle
import DKDrawKit.DKStyle.SimpleAccess
import DKDrawKit.DKStyle.Text
import DKDrawKit.DKStyleRegistry
import DKDrawKit.DKTextAdornment
import DKDrawKit.DKTextPath
import DKDrawKit.DKTextShape
import DKDrawKit.DKTextSubstitutor
import DKDrawKit.DKToolController
import DKDrawKit.DKToolRegistry
import DKDrawKit.DKUnarchivingHelper
import DKDrawKit.DKUndoManager
import DKDrawKit.DKUniqueID
import DKDrawKit.DKViewController
import DKDrawKit.DKZigZagFill
import DKDrawKit.DKZigZagStroke
import DKDrawKit.DKZoomTool
import DKDrawKit.DKMetadataStorable
import DKDrawKit.GCInfoFloater
import DKDrawKit.GCObservableObject
import DKDrawKit.GCUndoManager
import DKDrawKit.GCZoomView
import DKDrawKit.LogEvent
import DKDrawKit.DKAdditions.NSAffineTransform
import DKDrawKit.DKAdditions.NSAttributedString
import DKDrawKit.DKAdditions.NSBezierPath.Editing
import DKDrawKit.DKAdditions.NSBezierPath.Geometry
import DKDrawKit.DKAdditions.NSBezierPath.Text
import DKDrawKit.DKAdditions.NSBezierPath.Shapes
import DKDrawKit.DKAdditions.NSColor
import DKDrawKit.DKAdditions.NSDictionary.DeepCopy
import DKDrawKit.DKAdditions.NSImage
import DKDrawKit.DKAdditions.NSMutableArray
import DKDrawKit.DKAdditions.NSShadow.Scaling
import DKDrawKit.DKAdditions.NSString

@NSApplicationMain
class AppDelegate: NSWindowController, NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, NSWindowDelegate {

	// MARK: - TOOLS
	/// matrix of buttons for selecting the drawing tool
	@IBOutlet weak var toolMatrix: NSMatrix!
	/// checkbox for setting "sticky" state of tools
	@IBOutlet weak var toolStickyCheckbox: NSButton!

	// MARK: - STYLE
	/// checkbox for enabling the "fill" property
	@IBOutlet weak var styleFillCheckbox: NSButton!
	/// colour well for the fill's colour
	@IBOutlet weak var styleFillColourWell: NSColorWell!
	/// checkbox for enabling the "stroke" property
	@IBOutlet weak var styleStrokeCheckbox: NSButton!
	/// colour well for the stroke's colour
	@IBOutlet weak var styleStrokeColourWell: NSColorWell!
	/// text field for the stroke's width
	@IBOutlet weak var styleStrokeWidthTextField: NSTextField!
	/// stepper buttons for the stroke's width
	@IBOutlet weak var styleStrokeWidthStepper: NSStepper!
	
	// MARK: - GRID
	/// matrix of buttons for selecting the grid to use
	@IBOutlet weak var gridMatrix: NSMatrix!
	/// checkbox to enable "snap to grid"
	@IBOutlet weak var gridSnapCheckbox: NSButton!

	// MARK: - LAYERS
	/// table view for listing the drawing's layers
	@IBOutlet weak var layerTable: NSTableView!
	/// button for adding a new layer
	@IBOutlet weak var layerAddButton: NSButton!
	/// button for removing the active (selected) layer
	@IBOutlet weak var layerRemoveButton: NSButton!

	// MARK: - MAIN VIEW
	/// outlet to the main DKDrawingView that displays the content (and owns the drawing)
	@IBOutlet weak var drawingView: DKDrawingView!

	// MARK: - TOOLS
	/// the drawing view can handle this for us, provided we pass it an object that responds to `-title` and returns
	/// the valid name of a registered tool. The selected button cell is just such an object.
	@IBAction func toolMatrixAction(_ sender: NSMatrix?) {
		if let cell = sender?.selectedCell() {
			drawingView.selectDrawingToolByName(cell)
		}
	}
	
	/// sets the tool controller's flag to the inverted state of the checkbox
	@IBAction func toolStickyAction(_ sender: Any?) {
		(drawingView.controller as! DKToolController).automaticallyRevertsToSelectionTool = ((sender as? NSButton)?.intValue == 0)
	}
	
	
	// MARK: - STYLES
	@IBAction func styleFillColourAction(_ sender: NSColorWell?) {
		// get the style of the selected object
		
		let style = styleOfSelectedObject
		style?.fillColour = sender?.color
		drawingView.undoManager?.setActionName("Change Fill Colour")
	}
	
	@IBAction func styleStrokeColourAction(_ sender: NSColorWell?) {
		// get the style of the selected object
		
		let style = styleOfSelectedObject
		style?.strokeColour = sender?.color
		drawingView.undoManager?.setActionName("Change Stroke Colour")
	}
	
	@IBAction func styleStrokeWidthAction(_ sender: AnyObject?) {
		// get the style of the selected object
		
		guard let style = styleOfSelectedObject, let sendFloat = sender?.floatValue else {
			return
		}
		style.strokeWidth = CGFloat(sendFloat)
		
		// synchronise the text field and the stepper so they both have the same value
		
		if sender === styleStrokeWidthStepper {
			styleStrokeWidthTextField.floatValue = sendFloat
		} else {
			styleStrokeWidthStepper.floatValue = sendFloat
		}
		
		drawingView.undoManager?.setActionName("Change Stroke Width")
	}
	
	@IBAction func styleFillCheckboxAction(_ sender: AnyObject?) {
		// get the style of the selected object
		
		let style = styleOfSelectedObject
		
		let removing: Bool = sender?.intValue == 0
		
		if removing {
			style?.fillColour = nil
			drawingView.undoManager?.setActionName("Delete Fill")
		} else {
			style?.fillColour = styleFillColourWell.color
			drawingView.undoManager?.setActionName("Add Fill")
		}
	}
	
	@IBAction func styleStrokeCheckboxAction(_ sender: AnyObject?) {
		// get the style of the selected object
		
		let style = styleOfSelectedObject

		let removing: Bool = sender?.intValue == 0

		if removing {
			style?.strokeColour = nil
			drawingView.undoManager?.setActionName("Delete Stroke")
		} else {
			style?.strokeColour = styleStrokeColourWell.color
			drawingView.undoManager?.setActionName("Add Stroke")
		}
	}
	
	
	// MARK: - GRID
	/// the drawing's grid layer already knows how to do this - just pass it the selected cell from where it
	/// can extract the tag which it interprets as one of the standard grids.
	@IBAction func gridMatrixAction(_ sender: AnyObject?) {
		drawingView.drawing?.gridLayer?.setMeasurementSystemAction(sender?.selectedCell())
	}
	
	/// Set the drawing's snapToGrid flag to match the sender's state.
	@IBAction func snapToGridAction(_ sender: AnyObject?) {
		drawingView.drawing?.snapsToGrid = sender?.intValue != 0
	}
	
	
	// MARK: - LAYERS
	@IBAction func layerAddButtonAction(_ sender: Any?) {
		// adding a new layer - first create it

		let newLayer = DKObjectDrawingLayer()
		
		// add it to the drawing and make it active - this triggers notifications which update the UI

		drawingView.drawing?.addLayer(newLayer, andActivateIt: true)
		
		// drawing now owns the layer so we can release it
		
		//[newLayer release];
		
		// inform the Undo Manager what we just did:

		drawingView.undoManager?.setActionName("New Drawing Layer")
	}
	
	@IBAction func layerRemoveButtonAction(_ sender: Any?) {
		// removing the active (selected) layer - first find that layer
		
		let activeLayer = drawingView.drawing?.activeLayer
		
		// remove it and activate another (passing nil tells the drawing to use its nous to activate something sensible)

		drawingView.drawing?.removeLayer(activeLayer!, andActivate: nil)
		
		// inform the Undo Manager what we just did:

		drawingView.undoManager?.setActionName("Delete Drawing Layer")
	}
	
	// MARK: -
	
	/// The selection changed within the drawing - update the UI to match the state of whatever was selected. We pass nil
	/// because in fact we just grab the current selection directly.
	@objc private func drawingSelectionDidChange(_ note: Notification) {
		updateControlsForSelection(nil)
	}
	
	/// Change the selection in the layer table to match the actual layer that has been activated.
	@objc private func activeLayerDidChange(_ note: Notification?) {
		if let dwg = drawingView.drawing, let activeLayer = dwg.activeLayer {
			// now find the active layer's index and set the selection to the same value
			let index = dwg.index(of: activeLayer)
			if index != NSNotFound {
				layerTable.selectRowIndexes(IndexSet(integer: index), byExtendingSelection: false)
			}
		}
	}
	
	/// Update the table to match the number of layers in the drawing.
	@objc private func numberOfLayersChanged(_ note: Notification) {
		layerTable.reloadData()
		
		// re-establish the correct selection - requires a small delay so that the table is fully reloaded before the
		// selection is changed to avoid a potential out of range exception.

		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.microseconds(1)) {
			self.activeLayerDidChange(nil)
		}
	}
	
	/// The selected tool changed - find out which button cell matches and select it so that
	/// the tool UI and the actual selected tool agree. This is necessary because when a tool is automatically
	/// "sprung back" the UI needs to keep up with that automatic change.
	@objc private func selectedToolDidChange(_ note: Notification) {
		// which tool was selected?
		
		let tool = (note.object as? DKToolController)?.drawingTool
		let toolName = tool?.registeredName
		
		// keep the "sticky" checkbox synchronised with the tool controller's actual state
		
		let sticky = (drawingView.controller as! DKToolController).automaticallyRevertsToSelectionTool
		toolStickyCheckbox.state = sticky ? .on : .off
		
		// search through the matrix to find the cell whose title matches the tool's name,
		// and select it.

		var row = 0
		var col = 0
		
		toolMatrix.getNumberOfRows(&row, columns: &col)
		
		for rr in 0..<row {
			for cc in 0 ..< col {
				if let cell = toolMatrix.cell(atRow: rr, column: cc), cell.title == toolName?.rawValue {
					toolMatrix.selectCell(atRow: rr, column: cc)
					return
				}
			}
		}
		
		toolMatrix.selectCell(atRow: 0, column: 0)
	}
	
	// MARK: -
	
	/// Update all necessary UI controls to match the state of the selected object. Note that this ignores the selection passed to it
	/// and just gets the info directly. It also doesn't bother to worry about more than one selected object - it just uses the info from
	/// the topmost object - for this simple demo that's sufficient.
	func updateControlsForSelection(_ selection: [Any]?) {
		// get the selected object's style
		guard let style = styleOfSelectedObject else {
			styleFillColourWell.color = .white
			styleStrokeColourWell.color = .white
			styleStrokeWidthTextField.objectValue = 1
			styleStrokeWidthStepper.objectValue = 1
			styleFillColourWell.isEnabled = false
			styleFillCheckbox.state = .off
			styleStrokeColourWell.isEnabled = false
			styleStrokeWidthStepper.isEnabled = false
			styleStrokeWidthTextField.isEnabled = false
			styleStrokeCheckbox.state = .off
			return
		}
		var temp: NSColor?
		
		// set up the fill controls if the style has a fill property, or disable them
		// altogether if it does not.

		if let rast = style.renderers(of: DKFill.self)?.last {
			temp = rast.colour
			styleFillColourWell.isEnabled = true
			styleFillCheckbox.state = .on
		} else {
			temp = NSColor.white
			styleFillColourWell.isEnabled = false
			styleFillCheckbox.state = .off
		}
		styleFillColourWell.color = temp ?? .white
		
		let sw: CGFloat
		if let rast = style.renderers(of: DKStroke.self)?.last {
			temp = rast.colour
			sw = rast.width
			styleStrokeColourWell.isEnabled = true
			styleStrokeWidthStepper.isEnabled = true
			styleStrokeWidthTextField.isEnabled = true
			styleStrokeCheckbox.state = .on
		} else {
			temp = NSColor.white
			sw = 1
			styleStrokeColourWell.isEnabled = false
			styleStrokeWidthStepper.isEnabled = false
			styleStrokeWidthTextField.isEnabled = false
			styleStrokeCheckbox.state = .off
		}
		styleStrokeColourWell.color = temp ?? .white
		styleStrokeWidthTextField.objectValue = sw
		styleStrokeWidthStepper.objectValue = sw
	}
	
	/// returns the style of the topmost selected object in the active layer, or `nil` if there is nothing selected.
	private var styleOfSelectedObject: DKStyle? {
		var selectedStyle: DKStyle? = nil
		
		// get the active layer, but only if it's one that supports drawable objects
		if let activeLayer = drawingView.drawing?.activeLayer(of: DKObjectDrawingLayer.self) {
			// get the selected objects and use the style of the last object, corresponding to the
			// one drawn last, or on top of all the others.

			let selectedObjects = activeLayer.selectedAvailableObjects
			if selectedObjects.count != 0 {
				selectedStyle = selectedObjects.last!.style
				
				// ensure it can be edited
				selectedStyle!.locked = false
			}
		}
		
		return selectedStyle
	}
	
	// MARK: - as a NSWindowController
	override func awakeFromNib() {
		super.awakeFromNib()
		
		// make sure the view has a drawing object initialised. While the view itself would do this for us later, we tip its hand now so that we definitely
		// have a valid DKDrawing object available for setting up the notifications and user interface. In this case we are simply allowing the view to
		// create and own the drawing, rather than owning it here - though that would also be a perfectly valid way to do things.

		drawingView.createAutomaticDrawing()
		
		// subscribe to selection, layer and tool change notifications so that we can update the UI when these change

		NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.drawingSelectionDidChange(_:)), name: .dkLayerSelectionDidChange, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.drawingSelectionDidChange(_:)), name: .dkStyleDidChange, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.activeLayerDidChange(_:)), name: .dkDrawingActiveLayerDidChange, object: drawingView.drawing)
		NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.numberOfLayersChanged(_:)), name: .dkLayerGroupNumberOfLayersDidChange, object: drawingView.drawing)
		NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.selectedToolDidChange(_:)), name: .dkDidChangeTool, object: drawingView.drawing)

		// creating the drawing set up the initial active layer but we weren't ready to listen to that notification. So that we can set
		// up the user-interface correctly this first time, just call the responder method directly now.

		activeLayerDidChange(nil)
		drawingView.window?.makeFirstResponder(drawingView)
	}
	
	// MARK: - as the TableView dataSource
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		guard let layerCount = drawingView.drawing?.countOfLayers else {
			return 0
		}
		return Int(layerCount)
	}
	
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
		guard let layer = drawingView.drawing?.layers[row] else {
			return nil
		}
		if let columnName = tableColumn?.identifier.rawValue {
			return layer.value(forKey: columnName)
		}
		
		return nil
	}
	
	func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
		guard let layer = drawingView.drawing?.layers[row],
			let columnName = tableColumn?.identifier.rawValue else {
			return
		}

		layer.setValue(object, forKey: columnName)
	}
	
	// MARK: - as the TableView delegate
	
	func tableViewSelectionDidChange(_ notification: Notification) {
		// when the user selects a different layer in the table, change the real active layer to match.
		guard (notification.object as AnyObject?) === layerTable else {
			return
		}
		let row = layerTable.selectedRow
		if row != -1, let drawing = drawingView.drawing {
			drawing.setActiveLayer(drawing.objectInLayers(at: row))
		}
	}
	
	// MARK: - as the NSApplication delegate
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// app ready to go - first turn off all style sharing. For this simple demo this makes life a bit easier.
		// (note - comment out this line and see what happens. It's perfectly safe ;-)
		
		DKStyle.stylesAreSharableByDefault = false
		
		// set up an initial style to apply to all new objects created. Because sharing is off above, this style is copied
		// for each new object created, so each has its own individual style which can be edited independently.
		
		let ds = DKStyle(fillColour: NSColor.orange, strokeColour: NSColor.black, strokeWidth: 2.0)
		ds.name = "Demo Style"
		
		DKObjectCreationTool.styleForCreatedObjects = ds
		
		// register the default set of tools (Select, Rectangle, Oval, etc)
		
		DKDrawingTool.loadDefaults()
	}
	
	@IBAction func saveDocumentAs(_ sender: Any?) {
		let sp = NSSavePanel()
		
		sp.allowedFileTypes = [kUTTypePDF as String]
		sp.canSelectHiddenExtension = true
		sp.nameFieldStringValue = window!.title
		
		sp.beginSheetModal(for: window!) { (returnCode) in
			guard returnCode == .OK else {
				return
			}
			do {
				if let pdf = self.drawingView.drawing?.pdf(), let url = sp.url {
					try pdf.write(to: url)
				}
			} catch {
				NSApp.presentError(error)
			}
		}
	}
	
	@IBAction func showAboutBox(_ sender: Any?) {
		if let isOptionKeyDown = NSApp.currentEvent?.modifierFlags.contains(.option), isOptionKeyDown {
			LoggingController.shared.showLoggingWindow()
		} else {
			NSApp.orderFrontStandardAboutPanel(sender)
		}
	}
	
	// MARK: - as the Window delegate
	
	func windowWillReturnUndoManager(_ window: NSWindow) -> UndoManager? {
		// DK's own implementation of the undo manager is generally more functional than the default Cocoa one, especially
		// for interactive drawing as it implements task coalescing.
		struct Um {
			static let um = DKUndoManager()
		}
		
		return Um.um
	}
}
