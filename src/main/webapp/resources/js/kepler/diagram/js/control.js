/*!
  * Diagram InitControl
 * Copyright dg.ryu
 * v1.0.0
 */

var diagram;

function createAccordionTree(name, data, fields, templateId, activate) {
    try {
        logicalCompGroupAcrdn._destroys();
    } catch(err) {
        //console.log("no AccordionTree");
    }
    
    //트리의 선택 방지
    function beforeSelect(args) {
        args.cancel = true;
    }
    
    //아코디언트리 생성
    var option = { 
            enableMultipleOpen: true
            ,treeOption: { 
                nodeDropped: treeNodeDropped
                , nodeDragStart: treeNodeDragStart
                , allowDropSibling: false   //
                , expanded: true        //전체 열기
                , allowDropChild: false   //자식노드로 이동
                , allowDragAndDrop: true //드래그 앤드 드랍
                , showCheckbox : false   //체크박스
                , allowEditing : false    //텍스트 변경
                , beforeSelect : beforeSelect
            } 
    };
    
    //트리 필드 설정
    if (isNotEmpty(fields)) {
        option.treeOption.fields = fields;
    }
    
    //템플릿 설정
    if (isNotEmpty(templateId)) {
        option.treeOption.template = templateId;
    }
    
    if (isNotEmpty(activate)) {
        option.activate = activate;
        option.inActivate = activate;
    }
    
    $.fn.ifvmCreateAccordionTree(name, option, data);
}

//context menu 생성
function createContextMenu(name, targetName, data) {
    if (data.length > 0) {
        var option = {
                menuType: ej.MenuType.ContextMenu,
                openOnClick: false,
                contextMenuTarget: "#" + targetName,
                beforeOpen: beforeContextMenuOpen,
                click: contextMenuClicked,
                data: data
        };
        
        $.fn.ifvmCreateContextMenu(name, option);
    }
}

//create diagram
function createDiagram(items) {
	
    //reset diagram
    $("#diagram").ejDiagram({
        connectors: items.connectors,
        nodes: items.nodes,
        width: "100%",
        height: "100%",
        defaultSettings: {
            connector: { segments: [{ "type": "orthogonal" }], labels: [{ "fontColor": "black" }], lineWidth: 1, targetDecorator: { shape: "arrow", width: "10", height: "10" }, cornerRadius: 10, labels: [{ readOnly: true}], constraints: getConnectorConstraints() },
            node: { borderWidth: 0, ports: getDefaultPort() },
        },
        selectedItems: {
            userHandles: createUserHandles() 
        },
        
        drag: dragging,
        selectionChange: selectionchanged,
        nodeCollectionChange: nodecollectionchanged,
        connectionChange: connectionChange,
        connectorCollectionChange: connectorCollectionChanged,
        connectorSourceChange: connectorSourceChange,
        connectorTargetChange: connectorTargetChange,
        doubleClick: doubleClick,
        itemClick: itemClick,
        click: click,
        
        drop: function(args) {
            console.log("drop");
            console.log(args);
            diagram._selectedNode = args.targetNode;
        },
        
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
        enableContextMenu: false,    
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
    diagram._selectedObject = new NodeDataClass();
    diagram._selectedNode = {};
    
    //updateNode function 생성
    diagram._updateNode = function(name, option) {
        
        var node = diagram.getNode(name);
        if (isNotEmpty(node)) {
            diagram.updateNode(name, option);
            
            $('#' + node.name + "_html").mouseenter(function(args){
                //console.log("OnMouseenter : " + node.name );
                diagram._selectedNode = diagram.getNode(node.name);
            })
            
            $('#' + node.name + "_html").mouseleave(function(args){
                //console.log("OnMouseleave : " + node.name );
                diagram._selectedNode = {};
            })
            
            //노드 위에 노드를 드랍할때 이벤트를 얻기 위해 사용
            //jquery ui 
            $('#' + node.name + "_html").draggable();
            $('#' + node.name + "_html").droppable({
                drop: function( event, ui ) {
                    //console.log("nodeOnNode : " + node.name );
                    diagram._selectedNode = diagram.getNode(node.name);
                    
                    if (diagramType == "SEG") {
                        segNodeDragCompleted();
                    }
                }
            }); 
        }
        
        //set tooltip
        if (diagramType == "SEG" || diagramType =="TGT_GROUP") {
            $('#' + name + "_html").hover(function(){
                // Hover over code
                var html = $('#' + name + "_html #attribute").clone();
                $(this).data('tipText', html).removeAttr('title');
                $('<div class="tooltip"></div>')
                .html(html)
                .appendTo('body')
                .fadeIn('slow');
            }, function() {
                    // Hover out code
                    $('.tooltip').remove();
            }).mousemove(function(e) {
                    var mousex = e.pageX + 20; //Get X coordinates
                    var mousey = e.pageY + 10; //Get Y coordinates
                    $('.tooltip')
                    .css({ top: mousey, left: mousex })
            });
        }
    }
    
    setDiagramSize();
    

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
