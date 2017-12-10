//
//  AppDelegate.swift
//  DK Mini Swift Demo
//
//  Created by C.W. Betts on 12/10/17.
//

import Cocoa
import DKDrawKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!

	/*
// TOOLS
IBOutlet	id	mToolMatrix;					// matrix of buttons for selecting the drawing tool
IBOutlet	id	mToolStickyCheckbox;			// checkbox for setting "sticky" state of tools

// STYLE
IBOutlet	id	mStyleFillCheckbox;				// checkbox for enabling the "fill" property
IBOutlet	id	mStyleFillColourWell;			// colour well for the fill's colour
IBOutlet	id	mStyleStrokeCheckbox;			// checkbox for enabling the "stroke" property
IBOutlet	id	mStyleStrokeColourWell;			// colour well for the stroke's colour
IBOutlet	id	mStyleStrokeWidthTextField;		// text field for the stroke's width
IBOutlet	id	mStyleStrokeWidthStepper;		// stepper buttons for the stroke's width

// GRID
IBOutlet	id	mGridMatrix;					// matrix of buttons for selecting the grid to use
IBOutlet	id	mGridSnapCheckbox;				// checkbox to enable "snap to grid"
	*/

// LAYERS
	/// table view for listing the drawing's layers
	@IBOutlet weak var layerTable: NSTableView!
	/// button for adding a new layer
	@IBOutlet weak var layerAddButton: NSButton!
	/// button for removing the active (selected) layer
	@IBOutlet weak var layerRemoveButton: NSButton!

// MAIN VIEW
	/// outlet to the main DKDrawingView that displays the content (and owns the drawing)
	@IBOutlet weak var drawingView: DKDrawingView!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

