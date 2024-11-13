/*!
 * Diagram Events
 * Copyright dg.ryu
 * v1.0.0
 */


//트리 노드 드랍시
function treeNodeDropped(args) {
    console.log("treeNodeDropped");
	// 로지컬 컴포넌트에서 수정 불가시	
	if(diagramType === "LGC_COMP"){
		if(lgcCompData.isAnalysisSegmentUsed){
			alert(lgcCompMsg.M01439);
			args.cancel = true;			
		}
	}

    //다이어그램일경우만 동작
	if (args.target[0].id.indexOf("diagram_canvas") >= 0 && args.droppedElementData.count == 0) {
        //노드 추가
        addDropNode(args);
    } else {
        if (isNotEmpty(diagram._selectedNode)) {
            addSegmentNode(args);
        }
    }	
}

//트리 노드 클릭시
function treeNodeDragStart(args) {
    console.log("treeNodeDragStart");
    diagram._clearSelection();
    diagram._selectedNode = {};
}

//node select change 이벤트
function selectionchanged(args) {
	console.log("selectionchanged");
	
	if (isNotEmpty(args.element)) {
		var type = args.element.type;
		var name = args.element.name;
		console.log("selectionchanged : " + name);
		
		//노드가 없을경우 해당 좌표를 선택하는 현상을 방지한다.
		if (isEmpty(diagram.getNode(name))) {
			args.cancel = true;
			diagram._selectedObject = {};
			
			return false;
		}
		
		//set _selectedObject
		diagram._selectedObject = args.element.addInfo;
		
		//핸들 설정
        ShowHandles(diagram, args, true);
		
		//remove resize circle
		if (!(type == 'connector')) {
			setTimeout(function(){
				//$("#diagram_canvas_svg_adornerhandle_g circle").remove();
			}, 50);
		}
	} else {
		diagram._selectedObject = {};
	}
	
	if (args.changeType ==='insert' && args.cause === 'mouse' && args.elementType === 'node') {
	    //diagram.update(args.element.name, args.element);
	}
	
	//선택/해제 노드 선색 변경
	if (args.selectedItems.length > 0 || args.oldItems.length > 0) {
		setSelectedNode(args);
	}
}

//클릭
function click(args) {
    console.log("click");
    
    if (args.elementType != "node") {
        diagram._selectedNode = {};
    }
    
    if (diagramType == "LGC_COMP") {
        setLgcCompClick(args);
    }
}

//더블 클릭
function doubleClick(args) {
    console.log("doubleClick");
    //로지컬 컴포넌트
    if (diagramType == "LGC_COMP") {
        setLgcCompDoubleClick(args);
    }
}

//아이템 클릭
function itemClick(args) {
	console.log("itemClick");
	
	//로지컬 컴포넌트
	if (diagramType == "LGC_COMP") {
        //클릭 설정
	    setLgcCompItemeClick(args);
    }
}

//메뉴 클릭시
function contextMenuClicked(args) {
    console.log("contextMenuClicked");
    //세그먼트
    if (diagramType == "SEG") {
        //클릭 설정
        segContextMenuClick(args);
    }
}

//메뉴 열기전
function beforeContextMenuOpen(args) {
    console.log("beforeContextMenuOpen");
    //기존 열린 메뉴 닫기
    window[args.model.name].hideContextMenu();
    
    //노드가 선택 되었을때 메뉴 보이기
    if (diagram.selectionList.length == 0) {
        args.cancel = true;
    } else {
        //세그먼트
        if (diagramType == "SEG") {
            args.cancel = checkContextMenuOpen(args);
        }
    }
}

//nodecollectionchanged
function nodecollectionchanged(args) {
	console.log("nodecollectionchanged");
	
	//삭제되는 노드를 저장한다.
	if (args.changeType == "remove") {
		var _removeNodes = diagram._removeNodes;
		if (isEmpty(_removeNodes)){
			_removeNodes = [];
		}
		
		//렌더시에는 제외한다.
		if (args.element.addInfo.nodeDataStatus != "R") {
			//node change type
			args.element.changeType = args.changeType;
			//task data status
			args.element.addInfo.nodeDataStatus = "D";
			
			//push removeNodes
			_removeNodes.push(args.element);
			diagram._removeNodes = _removeNodes;
		}
	}
}

function connectionChange(args) {
	console.log("connectionChange");
}

//connectorCollectionChanged
function connectorCollectionChanged(args) {
	console.log("connectorCollectionChanged");
	
	//삭제되는 커넥터를 저장한다.
	if (args.changeType == "remove") {
		var _removeConnectors = diagram._removeConnectors;
		if (isEmpty(_removeConnectors)){
			_removeConnectors = [];
		}
		
		//connector change type
		args.element.changeType = args.changeType;
		
		//task data status
		args.element.addInfo.nodeDataStatus = "D";
		
		//push removeConnectors
		_removeConnectors.push(args.element);
		diagram._removeConnectors = _removeConnectors;
	}
}

var oldSourceNode;
//connectorSourceChange
function connectorSourceChange(args) {
	console.log("connectorSourceChange : " + args.dragState);
	//변경전 노드 확인
	if (args.dragState == "starting") {
	    if (diagramType == "LGC_COMP") {
	    }
	}
	
	if (args.dragState == "completed") {
	}
	
	return true;
}

var oldTargtNode;
//connectorTargetChange
function connectorTargetChange(args) {
	console.log("connectorTargetChange : " + args.dragState);
	//변경전 노드 확인
	if (args.dragState == "starting") {
	}
	
	if (args.dragState == "completed") {
	}
	
	return true;
}

//draging 이벤트
function dragging(args) {
    console.log("dragging : " + args.dragState);
    if (args.dragState == "starting" && args.element && diagram.getObjectType(args.element) == "node") {
        diagram._selectedObject.oldOffSetX = args.element.offsetX;
        diagram._selectedObject.oldOffSetY = args.element.offsetY;
        
        console.log("dragging : " + diagram._selectedObject.oldOffSetX);
        
        diagram._selectedDragNode = args.element;
    }
    
    if (args.dragState == "completed" && args.element && diagram.getObjectType(args.element) == "node") {
        if (diagramType == "SEG") {
            
            //diagram._selectedDragNode = {};
            //setTimeout(function(){
                //segNodeDragCompleted(args);
            //}, 50);
        }
    }
}

function toolbarClick(sender) {
  console.log("toolbarClick");
  var object;
  var nodes, i;
  var option = sender.currentTarget.id;
  
  diagram._modified = true;
  
  if (!(option == "Pan_Tool"))
      diagram._modified = true;
  if (option == "Redo_Tool") {
      diagram.redo();
  }
  if (option == "Undo_Tool") {
      diagram.undo();
  }
  if (option == "Delete_Tool") {
      diagram.remove();
  }
  if (option == "ZoomIn_Tool" || option == "ZoomOut_Tool") {
      var zoom1 = ej.datavisualization.Diagram.Zoom();
      zoom1.zoomFactor = 0.2;
      zoom1.zoomCommand = ej.datavisualization.Diagram.ZoomCommand.ZoomIn;
      if (option == "ZoomOut_Tool")
          zoom1.zoomCommand = ej.datavisualization.Diagram.ZoomCommand.ZoomOut;
      diagram.zoomTo(zoom1);
  }
  if (option == "FitToPage_Tool") {
      diagram.fitToPage();
  }
  if (option == "ZoomIn_Tool" || option == "ZoomOut_Tool" || option == "FitToPage_Tool") {
      $('#zoompercentage').ejDropDownList("option", "value", String(Math.round(diagram._getCurrentZoom() * 100)) + "%");
  }
  if (option == "Pan_Tool") {
	  $('#toolblock3 li').removeClass("focus");
      $('#Pan_Tool').addClass("focus");
      //ToolbarCommandEnabled(option);
      diagram.update({ tool: ej.datavisualization.Diagram.Tool.ZoomPan });
  }
  if (option == "MoveTool_Tool") {
	  $('#toolblock3 li').removeClass("focus");
      $('#MoveTool_Tool').addClass("focus");
      //ToolbarCommandEnabled(option);
      diagram.update({ tool: ej.datavisualization.Diagram.Tool.SingleSelect | ej.datavisualization.Diagram.Tool.MultipleSelect });
  }
  if (option == "Text_Tool") {
      //$('#Text_Tool').css('background-color', '#D3D1D1');
      //ToolbarCommandEnabled(option);
      var drawType = { type: "text" };
      diagram.update({ tool: ej.datavisualization.Diagram.Tool.ContinuesDraw, drawType: drawType });
  }
  if (option == "ConnectorDraw_Tool") {
      //$('#ConnectorDraw_Tool').css('background-color', '#D3D1D1');
      //ToolbarCommandEnabled(option);
      diagram._clearSelection();
      var drawType = { type: "connector",  
      name: "StartConnect", segments: [{ type: "orthogonal" }],
      lineWidth: 2, targetDecorator: { shape: "arrow" },
      lineColor:"#666666",
      labels: [{ readOnly: true}],
      cornerRadius: 10,
      constraints: connectorConstraints
      };
      diagram.update({ tool: ej.datavisualization.Diagram.Tool.ContinuesDraw, drawType: drawType });
  }
  if (option == "ConnectorDraw_Tool_Straight") {
      //$('#ConnectorDraw_Tool_Straight').css('background-color', '#D3D1D1');
      //ToolbarCommandEnabled(option);
      diagram._clearSelection();
      var drawType = { type: "connector", segments: [{ type: "straight" }] };
      diagram.update({ tool: ej.datavisualization.Diagram.Tool.ContinuesDraw, drawType: drawType });
  }

  if (option == "AlignLeft_Tool") {
      diagram.align("left");
  }
  if (option == "AlignCenter_Tool") {
      diagram.align("center");
  }
  if (option == "AlignRight_Tool") {
      diagram.align("right");
  }
  if (option == "AlignBottom_Tool") {
      diagram.align("bottom");
  }
  if (option == "AlignMiddle_Tool") {
      diagram.align("middle");
  }
  if (option == "AlignTop_Tool") {
      diagram.align("top");
  }
  if (option == "Group_Tool") {
      diagram.group();
  }
  if (option == "UnGroup_Tool") {
      diagram.ungroup();
  }
  if (option == "SendToBack_Tool") {
      diagram.sendToBack();
  }
  if (option == "MoveForward_Tool") {
      diagram.moveForward();
  }
  if (option == "SendBackward_Tool") {
      diagram.sendBackward();
  }
  if (option == "BringToFront_Tool") {
      diagram.bringToFront();
  }
  if (option == "Lock_Tool") {
      updateNodeProperties(null, "Lock");
      updateConnectorProperties(null, "Lock");
  }
}

function ToolBarMouseOver(li) {
  console.log("ToolBarMouseOver");
  var target = li.classList ? li : (li.target ? li.target : li);
  var targetClass = target.classList ? target.classList[0] : target.className.split(" ")[0];
  if (targetClass != "artboardtitle") {
      var x = target.style.backgroundColor;
      if ((x != "rgb(211, 209, 209)")) {
          if (x != "#D3D1D1") {
              //target.style.backgroundColor = "#e4eef6";
              //target.style.border = "1px solid #808080";
          }
      }
  }
}

function ToolBarMouseOut(li) {
  console.log("ToolBarMouseOut");
  var target = li.classList ? li : (li.target ? li.target : li);
  var targetClass = target.classList ? target.classList[0] : target.className.split(" ")[0];
  if (targetClass != "artboardtitle") {
      var x = target.style.backgroundColor;
      if ((x != "#D3D1D1")) {
          if (x != "rgb(211, 209, 209)") {
              //target.style.backgroundColor = "#f1f1f3";
          }
          else {
              //target.style.backgroundColor = "#fff";
          }
      }
      else {
          target.style.backgroundColor = "#D3D1D1";
      }
  }
}

//#region Splitter
$(function () {
	$(window).resize(function () {
	    setDiagramSize(true);
	});
	
	$(window).keydown(function (e) {
		/*    if (e.ctrlKey) {
		    	alert("ctrl");
		    	window.event.keyCode = 0;
		    	return false;
		    }
		    if (e.ctrlKey && e.keyCode == 88) {
		    	window.event.keyCode = 0;
		    	alert("ctrl x");
		    	return false;
		    }*/
	});
});

//#region document events

// #endregion

