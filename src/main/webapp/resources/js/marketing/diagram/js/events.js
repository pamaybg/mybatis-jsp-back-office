/*!
 * Diagram Events
 * Copyright dg.ryu
 * v1.0.0
 */

//node select change 이벤트
function selectionchanged(args) {
	//console.log("selectionchanged");
	
	if (isNotEmpty(args.element)) {
		var type = args.element.type;
		var name = args.element.name;
		
		//노드가 없을경우 해당 좌표를 선택하는 현상을 방지한다.
		if (isEmpty(diagram.getNode(name))) {
			args.cancel = true;
			diagram._selectedObject = {};
			
			return false;
		}
		
		//set _selectedObject
		diagram._selectedObject = args.element.addInfo;
		
		//remove resize circle
		if (!(type == 'connector')) {
			setTimeout(function(){
				$("#diagram_canvas_svg_adornerhandle_g circle").remove();
			}, 50);
		}
		
		//핸들 설정
		ShowHandles(diagram, args, !(type === 'connector' || name === 'Start'));
	} else {
		diagram._selectedObject = {};
	}
	
	
	//선택/해제 노드 선색 변경
	if (args.selectedItems.length > 0 || args.oldItems.length > 0) {
		setSelectedNode(args);
	}
}

function itemClick(args) {
	//console.log("itemClick");
	//node 최상단 이동
	//diagram.bringToFront(args.selectedObject); //syncfusion 함수 사용시 오류 발생
	bringToFront();
}

function setContextMenu() {
	var items = [];
	
	//get default menu
	$.each(menucollection, function(index, menu) {
		items.push(menu);
	});
	
	//get node menu
	var handelList = diagram._selectedObject.handleList;
	if (isNotEmpty(handelList)) {
		$.each(handelList, function(index, handle) {
			var item = {name: handle.handleName, text: handle.methodTypeCode + "||" + handle.method };
			items.push(item);
		});
	} else {
		
	}
	
	//set diagram context menu
	$("#diagram").ejDiagram({enableContextMenu: true, contextMenu: {items: items, showCustomMenuItemsOnly: true} });
}


//nodecollectionchanged
function nodecollectionchanged(args) {
	//console.log("nodecollectionchanged");
	
	//삭제되는 노드를 저장한다.
	if (args.changeType == "remove") {
		var _removeNodes = diagram._removeNodes;
		if (isEmpty(_removeNodes)){
			_removeNodes = [];
		}
		
		//렌더시에는 제외한다.
		if (args.element.addInfo.taskDataStatus != "R") {
			//node change type
			args.element.changeType = args.changeType;
			//task data status
			args.element.addInfo.taskDataStatus = "D";
			
			//push removeNodes
			_removeNodes.push(args.element);
			diagram._removeNodes = _removeNodes;
		}
	}
}

function connectionChange(args) {
	//console.log("connectionChange");
}

//connectorCollectionChanged
function connectorCollectionChanged(args) {
	//console.log("connectorCollectionChanged");
	
	//삭제되는 커넥터를 저장한다.
	if (args.changeType == "remove") {
		var _removeConnectors = diagram._removeConnectors;
		if (isEmpty(_removeConnectors)){
			_removeConnectors = [];
		}
		
		//connector change type
		args.element.changeType = args.changeType;
		
		//task data status
		args.element.addInfo.taskDataStatus = "D";
		
		//push removeConnectors
		_removeConnectors.push(args.element);
		diagram._removeConnectors = _removeConnectors;
		
		diagram._clearSelection();
	} 
}

var oldSourceNode;
//connectorSourceChange
function connectorSourceChange(args) {
	//console.log("connectorSourceChange : " + args.dragState);
	//변경전 노드 확인
	if (args.dragState == "starting") {
		oldSourceNode = findNode(diagram.selectionList[0].targetNode);
	}
	
	if (args.dragState == "completed") {
		//변경후 이전 노드의 캠페인 ID 확인
		if (isNotEmpty(oldSourceNode)) { 
			var campaignInfo = getNodesByNodeType(oldSourceNode, "INFO");
			if (isNotEmpty(campaignInfo)) {
				oldSourceNode.addInfo.campaignId = campaignInfo[0].addInfo.actualTaskId;
			} else {
				oldSourceNode.addInfo.campaignId = "";
			}
		}
		//변경후 이후 노드의 캠페인 ID 확인
		if (isNotEmpty(args.node)) {
			var campaignInfo = getNodesByNodeType(args.node, "INFO");
			if (isNotEmpty(campaignInfo)) {
				args.node.addInfo.campaignId = campaignInfo[0].addInfo.actualTaskId;
			} else {
				args.node.addInfo.campaignId = "";
			}
		}
	}
	
	return true;
}

var oldTargtNode;
//connectorTargetChange
function connectorTargetChange(args) {
	//console.log("connectorTargetChange : " + args.dragState);
	//변경전 노드 확인
	if (args.dragState == "starting") {
		oldTargtNode = findNode(diagram.selectionList[0].targetNode);
	}
	
	if (args.dragState == "completed") {
		//변경후 이전 노드의 캠페인 ID 확인
		if (isNotEmpty(oldTargtNode)) { 
			var campaignInfo = getNodesByNodeType(oldTargtNode, "INFO");
			if (isNotEmpty(campaignInfo)) {
				oldTargtNode.addInfo.campaignId = campaignInfo[0].addInfo.actualTaskId;
			} else {
				oldTargtNode.addInfo.campaignId = "";
			}
		}
		//변경후 이후 노드의 캠페인 ID 확인
		if (isNotEmpty(args.node)) {
			var campaignInfo = getNodesByNodeType(args.node, "INFO");
			if (isNotEmpty(campaignInfo)) {
				args.node.addInfo.campaignId = campaignInfo[0].addInfo.actualTaskId;
			} else {
				args.node.addInfo.campaignId = "";
			}
		}
	}
	
	return true;
}

function mouseEnter(args) {
	//console.log("mouseEnter");
}

function mouseLeave(args) {
	//console.log("mouseLeave");
}

//node draging 이벤트
function nodeDragging(args) {
	//console.log("nodeDragging");
}

function customUndoRedo(args){
	//console.log("customUndoRedo");
}

function contextMenuBeforeOpening(args) {
	//console.log("contextMenuBeforeOpening");
}

//메뉴 선택시 이벤트
function contextMenuClicked(args) {
    var menuselect = args.text;
    if (isNotEmpty(diagram.selectionList)){
	    var node = diagram.selectionList[0];
	    if (node) {
	        switch (menuselect) {
	            //삭제
	            case "Remove":
	            	removeSelectedNodes(node);
	                break;
	            default:
	                return;
	        }
	    }
    }
}

function dragEnter(args) {
	//console.log("dragEnter");
	//node명 생성
	args.element.name = $.ifvmGetRowID();
	
	diagram._onMouseenterNode = {};
	diagram._onTargetNode = {};
}

function dragOver(args) {
	//console.log("dragOver");
}

//node drop 이벤트
function nodeondrop(args) {
	//console.log("nodeondrop");
	if(args){
		//추가 노드 확인
		if (!checkAddNode(args)) {
			return false;
		}
		
		//drop 노드 설정
		setTimeout(function(){
			var node = setDropOnNode(args.element);
		}, 10);
	}
}

//#region Toolbar events
function evtpropscheckedevent(args) {
  //console.log("evtpropscheckedevent");
  var currentZoom = diagram._getCurrentZoom();
  if (args.text) {
      switch (args.text) {
          case "400%":
              zoom.zoomFactor = (4 / currentZoom) - 1;
              break;
          case "200%":
              zoom.zoomFactor = (2 / currentZoom) - 1;
              break;
          case "150%":
              zoom.zoomFactor = (1.5 / currentZoom) - 1;
              break;
          case "100%":
              zoom.zoomFactor = (1 / currentZoom) - 1;
              break;
          case "75%":
              zoom.zoomFactor = (0.75 / currentZoom) - 1;
              break;
          case "50%":
              zoom.zoomFactor = (0.5 / currentZoom) - 1;
              break;
          case "25%":
              zoom.zoomFactor = (0.25 / currentZoom) - 1;
              break;
      }
      diagram.zoomTo(zoom);
      setZoomSlider();
  }
}

function toolbarClick(sender) {
  //console.log("toolbarClick");
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
  //console.log("ToolBarMouseOver");
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
  //console.log("ToolBarMouseOut");
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
		console.log("window resize");
		setPaletteSize();
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
	
    $("#edit_splitter_hideslide").click(function () {
        isPMinized = true;
        $("#main-left").animate({ width: '40px' }, 300, function () {
            openMinimizedPalette();
            setDiagramSize();
        });

        $("#EnableOverView").find("span").css("display", "none");
        diagram._enableOverView = false;
        $("#Overview-div").css("display", "none");
        updateSize();
    });
    
    $("#edit_splitter_palette").on('click', function(){
    	changePalette();
    });
    
  //취소 클릭시
	$("#dialog_title .e-close").on('click', function(){
    	cDialog.destroy();
    });
    
    
});

//#region document events

// #endregion

