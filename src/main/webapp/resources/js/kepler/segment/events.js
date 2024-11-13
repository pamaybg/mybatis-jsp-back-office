/*!
 * Diagram Events
 * Copyright dg.ryu
 * v1.0.0
 */


//트리 노드 드랍시

function keplerDiagramEvent() {
    this.oldSourceNode;
    this.oldTargtNode;
}

keplerDiagramEvent.prototype = {
    
    treeNodeDropped : function(args) {
        //console.log("treeNodeDropped");
        var _this = this;
        
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
            if (isNotEmpty(KPRDiagram._selectedNode)) {
                _this.kprMeth.addSegmentNode(args);
            }
        }	
    },
    
    //트리 노드 클릭시
    treeNodeDragStart : function(args) {
        //console.log("treeNodeDragStart");
        KPRDiagram._clearSelection();
        KPRDiagram._selectedNode = {};
    },
    
    //node select change 이벤트
    selectionchanged : function(args) {
    	//console.log("selectionchanged");
        var _this = this;
        
    	if (isNotEmpty(args.element)) {
    		var type = args.element.type;
    		var name = args.element.name;
    		//console.log("selectionchanged : " + name);
    		
    		//노드가 없을경우 해당 좌표를 선택하는 현상을 방지한다.
    		if (isEmpty(KPRDiagram.getNode(name))) {
    			args.cancel = true;
    			KPRDiagram._selectedObject = {};
    			
    			return false;
    		}
    		
    		//set _selectedObject
    		KPRDiagram._selectedObject = args.element.addInfo;
    		
    		//핸들 설정
    		_this.kprMeth.showHandles(args, true);
    		
    		//remove resize circle
    		if (!(type == 'connector')) {
    			setTimeout(function(){
    				//$("#diagram_canvas_svg_adornerhandle_g circle").remove();
    			}, 50);
    		}
    	} else {
    		KPRDiagram._selectedObject = {};
    	}
    	
    	if (args.changeType ==='insert' && args.cause === 'mouse' && args.elementType === 'node') {
    	    //KPRDiagram.update(args.element.name, args.element);
    	}
    	
    	//선택/해제 노드 선색 변경
    	if (args.selectedItems.length > 0 || args.oldItems.length > 0) {
    	    _this.kprMeth.setSelectedNode(args);
    	}
    },
    
    //클릭
    click : function(args) {
        //console.log("click");
        
        var _this = this;
        
        if (args.elementType != "node") {
            KPRDiagram._selectedNode = {};
        }
        
        if (diagramType == "LGC_COMP") {
            _this.kprMeth.setLgcCompClick(args);
        }
    },
    
    //더블 클릭
    doubleClick : function(args) {
        //console.log("doubleClick");
        
        var _this = this;
        
        //로지컬 컴포넌트
        if (diagramType == "LGC_COMP") {
            _this.kprMeth.setLgcCompDoubleClick(args);
        }
    },
    
    //아이템 클릭
    itemClick : function(args) {
    	//console.log("itemClick");
        
        var _this = this;
    	
    	//로지컬 컴포넌트
    	if (diagramType == "LGC_COMP") {
            //클릭 설정
    	    _this.kprMeth.setLgcCompItemeClick(args);
        }
    },
    
    //메뉴 클릭시
    contextMenuClicked : function(args) {
        //console.log("contextMenuClicked");
        
        var _this = this;
        
        //세그먼트
        if (diagramType == "SEG") {
            //클릭 설정
            _this.kprMeth.segContextMenuClick(args);
        }
    },
    
    //메뉴 열기전
    beforeContextMenuOpen : function(args) {
        //console.log("beforeContextMenuOpen");
        
        var _this = this;
        
        //기존 열린 메뉴 닫기
        window[args.model.name].hideContextMenu();
        
        //노드가 선택 되었을때 메뉴 보이기
        if (KPRDiagram.selectionList.length == 0) {
            args.cancel = true;
        } else {
            //세그먼트
            if (diagramType == "SEG") {
                _this.kprMeth.args.cancel = checkContextMenuOpen(args);
            }
        }
    },
    
    //nodecollectionchanged
    nodecollectionchanged : function(args) {
    	//console.log("nodecollectionchanged");
        
        var _this = this;
    	
    	//삭제되는 노드를 저장한다.
    	if (args.changeType == "remove") {
    		var _removeNodes = KPRDiagram._removeNodes;
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
    			KPRDiagram._removeNodes = _removeNodes;
    		}
    	}
    },
    
    //connectorCollectionChanged
    connectorCollectionChanged : function(args) {
    	//console.log("connectorCollectionChanged");
    	
    	//삭제되는 커넥터를 저장한다.
    	if (args.changeType == "remove") {
    		var _removeConnectors = KPRDiagram._removeConnectors;
    		if (isEmpty(_removeConnectors)){
    			_removeConnectors = [];
    		}
    		
    		//connector change type
    		args.element.changeType = args.changeType;
    		
    		//task data status
    		args.element.addInfo.nodeDataStatus = "D";
    		
    		//push removeConnectors
    		_removeConnectors.push(args.element);
    		KPRDiagram._removeConnectors = _removeConnectors;
    	}
    },
    
    //draging 이벤트
    dragging : function(args) {
        //console.log("dragging : " + args.dragState);
        if (args.dragState == "starting" && args.element && KPRDiagram.getObjectType(args.element) == "node") {
            KPRDiagram._selectedObject.oldOffSetX = args.element.offsetX;
            KPRDiagram._selectedObject.oldOffSetY = args.element.offsetY;
            
            KPRDiagram._selectedDragNode = args.element;
        }
        
        if (args.dragState == "completed" && args.element && KPRDiagram.getObjectType(args.element) == "node") {
            if (diagramType == "SEG") {
                
                //KPRDiagram._selectedDragNode = {};
                //setTimeout(function(){
                    //segNodeDragCompleted(args);
                //}, 50);
            }
        }
    }

}

//#region Splitter
$(function () {
    $(window).resize(function () {
        var kprMeth = new keplerDiagramMethods();
        //kprMeth.setDiagramSize(true);
    });
});

//#region document events

// #endregion

