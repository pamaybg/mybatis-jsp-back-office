/*!
 * Diagram InitControl
 * Copyright dg.ryu
 * v1.0.0
 */

$(function () {

});

//create palette
function createPalette() {
	
    //reset minimized palette
    $("#minimizedPalette").ejSymbolPalette({
        diagramId: "diagram", 
        palettes: window.diagramPaletteCollection2, 
        height: "100%", 
        width: "100%",
        headerHeight: 0,
        showPaletteItemText: false, 
        previewWidth : 70, 
        previewHeight : 70,
        paletteItemWidth: 35,
        paletteItemHeight: 35
    });
    
    $("#minimizedPalette #mPalettes_header").remove();
    minimizedPalette = $("#minimizedPalette").ejSymbolPalette("instance");
    $("#minimizedPalette").ejScroller();
    //hide minimized palette
    $("#minimizedPalette").hide();
    
    //reset palette
    $("#main-left").css("width", "206px");
    $("#symbolpalette").ejSymbolPalette({
        diagramId: "diagram", 
        palettes: window.diagramPaletteCollection, 
        height: "100%",
        width: "100%", 
        paletteItemWidth: 60, 
        paletteItemHeight: 50, 
        showPaletteItemText: false,
        previewWidth : 200,
        previewHeight : 66,
        create : function(){
        	$("#symbolpalette_canvas .e-header").height(45);
        	$("#symbolpalette_canvas .e-header-arrow.e-icon").css({"top":"18px"});
        	$("#symbolpalette_canvas image").css({width:"72px", height :"72px"});
        }
    });
    
    symbolpalette = $("#symbolpalette").ejSymbolPalette("instance");
    $("#symbolpalette").ejScroller();

    //set palette comment
    setPaletteCommentDiv();

    //set palette size
    setPaletteSize();
}

//custom menu
var menucollection = [{ name: "Remove", text: "Remove" }];

//create diagram
function createDiagram(items) {
	
    //reset diagram
    $("#diagram").ejDiagram({
        connectors: items.connectors,
        nodes: items.nodes,
        width: "100%",
        height: "100%",
        //pageSettings: { pageHeight: 1100, pageWidth: 1200, showPageBreak: false, multiplePage: true },
        
        //fullscreen : true,
        
        selectedItems: { 
        	userHandles: createUserHandles() 
        },
        
        historyManager: {
        	//Called to revert a custom action
            undo: customUndoRedo,
            //Called to restore the reverted custom action
            redo: customUndoRedo
        },
        
        drop: nodeondrop,
        //drag: nodeDragging,
        //dragOver: dragOver,
        dragEnter: dragEnter,
        selectionChange: selectionchanged,
        nodeCollectionChange: nodecollectionchanged,
        connectionChange: connectionChange,
        connectorCollectionChange: connectorCollectionChanged,
        connectorSourceChange: connectorSourceChange,
        connectorTargetChange: connectorTargetChange,
        itemClick: itemClick,
        
        drawingTools: {
            textTool: ej.datavisualization.Diagram.TextTool(),
        },
        
        snapSettings: {
            snapConstraints: ej.datavisualization.Diagram.SnapConstraints.All & ~ej.datavisualization.Diagram.SnapConstraints.SnapToLines
        },
        
        selectorConstraints: //ej.datavisualization.Diagram.SelectorConstraints.All
              ~ej.datavisualization.Diagram.SelectorConstraints.Rotator
              & ~ej.datavisualization.Diagram.SelectorConstraints.Resizer
              ,
              
        enableContextMenu: true,
        contextMenu: { items: menucollection, showCustomMenuItemsOnly: true },
        contextMenuBeforeOpen: contextMenuBeforeOpening,
        contextMenuClick: contextMenuClicked,
              
        commandManager: {
            	    commands: {
            	        //Commands to clone the selected item
            	        "clone": {
            	            //Method to define whether the command can be executed at the current moment
            	            canExecute: function (args) {
            	            	//Defines that the clone command can be executed, if and only if the selection list is not empty.
            	                if (args.model.selectedItems.length) {
            	                    return true;
            	                }
            	            },
            	            //Command handler
            	            execute: function (args) {
            	                //Logic to clone the selected element
            	            },
            	            //Defines that the clone command has to be executed on the recognition of Ctrl+C key press.
            	            gesture: {
            	                key: ej.datavisualization.Diagram.Keys.C,
            	                keyModifiers: ej.datavisualization.Diagram.KeyModifiers.Control
            	            }
            	        },
            	        "paste": {
                            canExecute: function (args) {
                                return false;
                            },
                            //Command handler
                            execute: function (args) {
                            },
                            gesture: {
                                key: ej.datavisualization.Diagram.Keys.V,
                                keyModifiers: ej.datavisualization.Diagram.KeyModifiers.Control
                            }
                        },
                        "cut": {
                            canExecute: function (args) {
                                return false;
                            },
                            //Command handler
                            execute: function (args) {
                            },
                            gesture: {
                                key: ej.datavisualization.Diagram.Keys.X,
                                keyModifiers: ej.datavisualization.Diagram.KeyModifiers.Control
                            }
                        },
                        "delete": {
                            canExecute: function (args) {
                                return true;
                            },
                            //Command handler
                            execute: function (args) {
                            	removeSelectedNodes(args);
                            },
                            gesture: {
                            	key: ej.datavisualization.Diagram.Keys.Delete,
                            }
                        },
                        "undo": {
                            canExecute: function (args) {
                                return false;
                            },

                            //Command handler
                            execute: function (args) {
                            },
                            gesture: {
                            	key: ej.datavisualization.Diagram.Keys.Z,
                                keyModifiers: ej.datavisualization.Diagram.KeyModifiers.Control
                            }
                        },
                        "redo": {
                            canExecute: function (args) {
                                return false;
                            },
                            //Command handler
                            execute: function (args) {
                            },
                            gesture: {
                                key: ej.datavisualization.Diagram.Keys.Y,
                                keyModifiers: ej.datavisualization.Diagram.KeyModifiers.Control
                            }
                        }
            	    }
        },
    });

    //reset Custom Class
    diagram = $("#diagram").ejDiagram("instance");
    diagram._removeNodes = [];
    diagram._removeConnectors = [];
    diagram._onMouseenterNode = {};
    diagram._onTargetNode = {};
    diagram._selectedObject = new NodeDataClass();
    
    //set default node
    setDefaultNodes(items);
    
    $.each(diagram.nodes(), function(index, node) {
        $('#' + node.name + "_html").mouseenter(function(args){
            //console.log("OnMouseenter : " + node.name );
            diagram._onMouseenterNode = diagram.getNode(node.name);
            //console.log(diagram._selectedNode);
        })
        
        $('#' + node.name + "_html").mouseleave(function(args){
            //console.log("OnMouseleave : " + node.name ); 
            diagram._onMouseenterNode = {};
        })
    });
}

function createTollbar() {
	//toolbar 초기화
	$("#toolbarEvents").ejToolbar({
	    orientation: "horizontal",
	    create: "toolbarLoad",
	    click: "toolbarClick",
	    itemHover: "toolbarChecked",
	    itemLeave: "toolbarUnChecked"
	});
}
