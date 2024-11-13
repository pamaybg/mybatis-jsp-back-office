<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<jsp:include
	page="/WEB-INF/views/marketing/plan/include/planListPopScript.jsp" />

<!-- SyncFusion Diagram CSS & NodeDataClass Start -->
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/NodeDataClass.js" type="text/javascript"></script>    

<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" />

<!-- SyncFusion Diagram CSS & NodeDataClass End -->

<script id="htmlTemplate" type="text/x-jsrender">
<div></div>
</script>
<!-- Style Upend -->
    <style>

.e-menu.e-context>.e-list>a {
 	padding-left: 30px;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box
}
.e-menu.e-context .e-list>ul .e-list, .e-menu.e-context .e-list {
 	line-height: 22px;

 }
    </style>
    <!-- Template setting -->
<script id="segmentNodeTemplate" type="text/x-jquery-tmpl">
<div id="{{:addInfo.nodeId}}{{:addInfo._Suffix}}" class="attribute_box text_nodrag {{:addInfo.attributeType}}">
    <span class="ellip"> <i class="fa fa-users" aria-hidden="true"></i>{{:addInfo.data}}</span>
    <ul id="attribute">
			<li class="ellip"><i class="fa fa-caret-right" aria-hidden="true"></i>{{:addInfo.Startdd}} ~ {{:addInfo.Enddd}}</li>
    </ul>
</div>
</script>

<script>
/*
 * 마케팅 플랜 캠페인 워크플로우 스크립트
 * 
 * @date 2020. 06. 11.
 * @author LEE GYEONG YOUNG
 * 
 */
 
//캠페인 조회 데이터
var gridData = null;
var diagram;
var planId = '<%=cleanXss(request.getParameter("id"))%>';	

var selectDataList = [];
selectDataList = null;
/* node select */
function nodeSelect(){

	$.ifvSyncPostJSON('<ifvm:action name="planNodeSelect"/>', {
		planId : planId
	}, function(result){
		if ($.fn.ifvmIsNotEmpty(result)) {
			selectDataList = result;
		}
	});
}
/* node insert */
function nodeInsert(parCam,node){
			$.ifvSyncPostJSON('<ifvm:action name="planNodeInsert"/>', {
				mktPlanId : planId,
				camId : gridData.id,
				parCamId : parCam,
				offSetX : node.offSetX,
				offSetY : node.offSetY
			}, function(result) {
					if (result.success) {
						//alert('<spring:message code="M01047"/>');
						//nodeDataSelect();
	        		}else{	
						alert('<spring:message code="M01050"/>');
					}
			});
 }
/* node update */
function planNodeUpdate(camId,parCamId,offSetY){
	$.ifvSyncPostJSON('<ifvm:action name="planNodeUpdate"/>', {
		camId : camId,
		parCamId : parCamId,
		offSetY : offSetY
	}, function(result) {
			if (result.success) {
				//alert('<spring:message code="M01047"/>');
				//nodeDataSelect();
    		}else{	
				alert('<spring:message code="M01050"/>');
			}
	});
}
/* all node update */
function planAllNodeUpdate(nodeDataObj){
	
	$.ifvSyncPostJSON('<ifvm:action name="planAllNodeUpdate"/>', {
		nodeList : nodeDataObj
	}, function(result) {
			if (result.success) {
				//alert('<spring:message code="M01047"/>');
				//nodeDataSelect();
				alert('<spring:message code="M02947" />');
    		}else{	
				alert('<spring:message code="M01050"/>');
			}
	});
}
/* only one node Delete */
function nodeDelete(nodeId){

	$.ifvSyncPostJSON('<ifvm:action name="planNodeDelete"/>', {
		camId : nodeId
	}, function(result){
		if (result.success) {
			//alert('<spring:message code="I00726"/>');
			//nodeDataSelect();
		}else{	
			alert('<spring:message code="I00742"/>');
		}
	});
}	 
//Not Empty 여부
function isNotEmpty(val) {
	if (val!=null) {
		return true;
	}
	
	return false;
};
//Empty 여부
function isEmpty(val) {
	if (val==null) {
		return true;
	}
	
	return false;
};

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
		args.element.addInfo.nodeDataStatus = "D";
		
		//push removeConnectors
		_removeConnectors.push(args.element);
		diagram._removeConnectors = _removeConnectors;
	}
}
//handler diaplay 설정
function ShowHandles(diagram, args, flag) {
    //console.log("ShowHandles");
    var handles = diagram.model.selectedItems.userHandles;
    for (var i = 0; i < handles.length; i++) {
        handles[i].visible = false;
        
        if (args.elementType == "node") {
            handles[i].visible = true;
        }
        
        if (args.elementType == "connector") {
            handles[i].visible = true;
        }
    }
    
/*     if (args.elementType != "nodes" ) {
        setTimeout(function(){
            $("#diagram_canvas_svg_adorneruserHandle_g").remove();
        }, 100);
    } */
}
//node select change 이벤트
function selectionchanged(args) {
	//console.log("selectionchanged");
	
	if (isNotEmpty(args.element)) {
		var type = args.element.type;
		var name = args.element.name;
		//console.log("selectionchanged : " + name);
		
		//노드가 없을경우 해당 좌표를 선택하는 현상을 방지한다.
		if ($.fn.ifvmIsEmpty(diagram.getNode(name))) {
			args.cancel = true;
			diagram._selectedObject = {};
			
			return false;
		}
		
		//set _selectedObject
		diagram._selectedObject = args.element.addInfo;
		
		//핸들 설정
        ShowHandles(diagram, args, true);
		
		//remove resize circle
		if (!(type == 'connectors')) {
			setTimeout(function(){
				//$("#diagram_canvas_svg_adornerhandle_g circle").remove();
			}, 50);
		}
	} else {
		diagram._selectedObject = {};
	}
	
	if (args.changeType ==='insert' && args.cause === 'mouse' && args.elementType === 'nodes') {
	    //diagram.update(args.element.name, args.element);
	}
	
	//선택/해제 노드 선색 변경
	if (args.selectedItems.length > 0 || args.oldItems.length > 0) {
		setSelectedNode(args);
	}
}
//선택 노드 선색 설정
function setSelectedNode(args, type) {
    //console.log("setSelectedNode");
    $.each(diagram.nodes(), function(index, item) {
        if (isNotEmpty(item._type) && item._type == "node") {
            // 선택 해제
            $('#' + item.name + item.addInfo._Suffix).css('border', '');
        }
        
        $('#' + item.name + '_html').css('z-index', '0');
    });
    
    $.each(args.selectedItems, function(index, item) {
        if (isNotEmpty(item._type) && item._type == "node") {
            // 선택
            if ($('#' + item.name + item.addInfo._Suffix).hasClass("attribute_all") || $('#' + item.name + item.addInfo._Suffix).hasClass("lgcComp_tbl_box_dimension")) {
                $('#' + item.name + item.addInfo._Suffix).css('border', '2px solid #9a7caf');
            }
            else if ($('#' + item.name + item.addInfo._Suffix).hasClass("attribute_filter") || $('#' + item.name + item.addInfo._Suffix).hasClass("lgcComp_tbl_box_fact")) {
                $('#' + item.name + item.addInfo._Suffix).css('border', '2px solid #55a9d0');
            }
            else if ($('#' + item.name + item.addInfo._Suffix).hasClass("attribute_member")) { 
                $('#' + item.name + item.addInfo._Suffix).css('border', '2px solid #919396');
            }
            else if ($('#' + item.name + item.addInfo._Suffix).hasClass("attribute_combi") || $('#' + item.name + item.addInfo._Suffix).hasClass("lgcComp_tbl_box_aggregation")) { 
                $('#' + item.name + item.addInfo._Suffix).css('border', '2px solid #F26D5F');
            }
            else {
                $('#' + item.name + item.addInfo._Suffix).css('border', '2px solid #55a9d0');
            }
            
            //최상단으로
            $('#' + item.name + '_html').css('z-index', '50');
        }
    });
}


//기본 포트 추출
function getDefaultPort(name) {
    //console.log("getDefaultPort");
	var port = [
		{ name: "port1" + ej.datavisualization.Diagram.Util.randomId()
			, offset: { x: 0, y: 0.5 }
			, visibility: ej.datavisualization.Diagram.PortVisibility.Default
			, connectorPadding:2
			, constraints: ej.datavisualization.Diagram.PortConstraints.Connect
		},
		{ name: "port2" + ej.datavisualization.Diagram.Util.randomId()
			, offset: { x: 0.5, y: 0 }
			, visibility: ej.datavisualization.Diagram.PortVisibility.Default 
			, connectorPadding:2
			, constraints: ej.datavisualization.Diagram.PortConstraints.Connect
		},
		{ name: "port3" + ej.datavisualization.Diagram.Util.randomId(), 
			offset: { x: 1, y: 0.5 }
			, visibility: ej.datavisualization.Diagram.PortVisibility.Default
			, connectorPadding:2
			, constraints: ej.datavisualization.Diagram.PortConstraints.Connect
		},
		{ name: "port4" + ej.datavisualization.Diagram.Util.randomId()
			, offset: { x: 0.5, y: 1 }
			, visibility: ej.datavisualization.Diagram.PortVisibility.Default 
			, connectorPadding:2
			, constraints: ej.datavisualization.Diagram.PortConstraints.Connect
		}
	];
	return port;
}
//커넥터 생성
function createNextConnector(sourceNode, targetNode) {
    //console.log("createNextConnector");
    var connector = {
            name: $.ifvmGetRowID(),
            sourceNode: sourceNode,
            targetNode: targetNode
    }
    
    diagram.add(connector);
}
//클릭
function click(args) {
    //console.log("click");
    
    if (args.elementType != "node") {
        diagram._selectedNode = {};
    }
    
}


//node Constraints setting
function getNodeConstraints() {
    //console.log("getNodeConstraints");
    /*var constraints = ej.datavisualization.Diagram.NodeConstraints.Select 
    | ej.datavisualization.Diagram.NodeConstraints.Delete
    | ej.datavisualization.Diagram.NodeConstraints.Connect
    | ej.datavisualization.Diagram.NodeConstraints.Drag
    | ej.datavisualization.Diagram.NodeConstraints.Bridging
    | ej.datavisualization.Diagram.NodeConstraints.InheritBridging
    ;*/
    
    var constraints = ej.datavisualization.Diagram.NodeConstraints.Default 
    & ~ej.datavisualization.Diagram.NodeConstraints.Rotate
    & ~ej.datavisualization.Diagram.NodeConstraints.ResizeNorthEast
    & ~ej.datavisualization.Diagram.NodeConstraints.ResizeEast
    & ~ej.datavisualization.Diagram.NodeConstraints.ResizeSouthEast
    & ~ej.datavisualization.Diagram.NodeConstraints.ResizeSouth
    & ~ej.datavisualization.Diagram.NodeConstraints.ResizeSouthWest
    & ~ej.datavisualization.Diagram.NodeConstraints.ResizeWest
    & ~ej.datavisualization.Diagram.NodeConstraints.ResizeNorthWest
    & ~ej.datavisualization.Diagram.NodeConstraints.ResizeNorth
    & ~ej.datavisualization.Diagram.NodeConstraints.Resize
    & ~ej.datavisualization.Diagram.NodeConstraints.Shadow
    & ~ej.datavisualization.Diagram.NodeConstraints.DragLabel
    & ~ej.datavisualization.Diagram.NodeConstraints.AllowPan
    & ~ej.datavisualization.Diagram.NodeConstraints.AspectRatio
    ;
    
    constraints = ej.datavisualization.Diagram.NodeConstraints.Default;
    return constraints;
}

//connector Constraints setting
function getConnectorConstraints() {
    //console.log("getConnectorConstraints");
    var connectorConstraints = ej.datavisualization.Diagram.ConnectorConstraints.Default 
    & ~ej.datavisualization.Diagram.ConnectorConstraints.DragSourceEnd
    & ~ej.datavisualization.Diagram.ConnectorConstraints.DragTargetEnd
    & ~ej.datavisualization.Diagram.ConnectorConstraints.Drag
    & ~ej.datavisualization.Diagram.ConnectorConstraints.DragSegmentThumb
    & ~ej.datavisualization.Diagram.ConnectorConstraints.Bridging
    & ~ej.datavisualization.Diagram.ConnectorConstraints.DragLabel
    & ~ej.datavisualization.Diagram.ConnectorConstraints.InheritBridging;

    connectorConstraints = connectorConstraints 
        & ~ej.datavisualization.Diagram.ConnectorConstraints.Select;
    
    return connectorConstraints;
}


//핸들 생성
function createUserHandles() {
	
	  var UrlTool = (function (base) {
	        var node = null;
	        var targetNode = null;
	        var connector = null;
          ej.datavisualization.Diagram.extend(UrlTool, base);
          function UrlTool(name) {
              base.call(this, name);
              this.singleAction = true;
              this.cursor = "pointer";
              return this;
          }
      	// Defines the required evnts
      	UrlTool.prototype.mouseup = function (evt) {
            connector = null;
            node = this.diagram.selectionList[0];
            this._currentPossibleConnection = node;
            base.prototype.mouseup.call(this, evt);
            //console.log(node.name);
    		var url = '<ifvm:url name="campaignWorkFlow"/>?type=MKT&id=' + node.name;
    		var newWindow = window.open(url);
      	};
          return UrlTool;
      })(ej.datavisualization.Diagram.ToolBase);
	 var userHandle = [];
	        var urlHandle = ej.datavisualization.Diagram.UserHandle();
	        urlHandle.name = "urlHandle";
	       	urlHandle.position ="topright";
	        urlHandle.size = 30;
	        urlHandle.backgroundColor = "#4D4D4D";
	        urlHandle.pathData = "M4.6350084,4.8909971 L4.6350084,9.3649971 9.5480137,9.3649971 9.5480137,4.8909971 z M3.0000062,2.8189973 L11.184016,2.8189973 11.184016,10.999997 3.0000062,10.999997 z M0,0 L7.3649998,0 7.3649998,1.4020001 1.4029988,1.4020001 1.4029988,8.0660002 0,8.0660002 0,1.4020001 0,0.70300276 z";
	        urlHandle.tool = new UrlTool(urlHandle.name); 
	        userHandle.push(urlHandle);
	        
	        return userHandle;
}

//custom menu
var menucollection = [{ name: "Remove", text: "Remove" }];
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
	            	execRemove();
	                break;
	            default:
	                return;
	        }
	    }
    }
}

//diagram size 설정
function setDiagramSize(showpropeditor) {
    //console.log("setDiagramSize");
    var width = $(window).width() - $("#analysis_tree").width();
    $("#main-right").css("width", width);
    
    var pixels = $("#header").outerHeight() + $(".page_btn_area").outerHeight() + $("#analysis_top").outerHeight();
    var screenHeight = $(window).outerHeight();
    var height = screenHeight  - pixels-60;
    $(".dashboard_wrap").css("height", height);
    
    if (isNotEmpty(diagram)) {
        diagram.updateViewPort();
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
        	connector: { segments: [{ "type": "orthogonal" }], 
        		labels: [{ "fontColor": "black" }], 
        		lineWidth: 1,
        		targetDecorator: { shape: "arrow", width: "10", height: "10" }, 
        		cornerRadius: 10, 
        		labels: [{ readOnly: true}],
        		constraints: getConnectorConstraints() },
            node: {  width : 180,height : 60, borderWidth: 0, ports: getDefaultPort() },
        },

        selectedItems: {
            userHandles: createUserHandles() 
        },
        
        selectionChange: selectionchanged,
        connectorCollectionChange: connectorCollectionChanged,
        click: click,
        
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
        }
    }    
}

	//노드의 addInfo 부분에 들어가는 값들을 지정
	 function nodeAddInfo(node){
			// NodeDataClass 생성
			var nodeData = new NodeDataClass();
			nodeData.nodeId = node.name;
			nodeData.htmlTemplateId = "segmentNodeTemplate";
			nodeData.data = node.data;
			if(gridData!=null){
				nodeData.Startdd = gridData.camStartdd;
				nodeData.Enddd = gridData.camEnddd;
			}else{
				nodeData.Startdd = node.camStartdd;
				nodeData.Enddd = node.camEnddd;
			}
			nodeData.attributeType = "attribute_filter";
			node.addInfo = nodeData;

	 }
	 //노드와 커네턱의 연결을 위해서 객체로 묶음
	 function nodeitemset(node,connector){
		    var addInfo = node.addInfo;

		    var renderNode = { 
		            name: node.name,
		            type: ej.datavisualization.Diagram.Shapes.Html,
		            templateId : addInfo.htmlTemplateId,
		            //borderWidth: node.borderWidth,
		            labels: [{ readOnly: true, offset: {x: 0.5, y:1} }],
		            constraints : getNodeConstraints(),
		            offsetX: node.offsetX,
		            offsetY: node.offsetY,
		            addInfo: addInfo,
		            ports: node.ports

		     };
	        
		    var connectors = connector;
		    var itemSet = {};
		    itemSet.nodes = renderNode;
		    itemSet.connectors = connectors;
		    return itemSet;
		}
	 //실행시에 마케팅 캠페인의 ID값을 통해서 조회를 한 값들의 노드를 불러와서 커넥터와 연결해서 WorkFlow에 뿌려주는 곳
	 function nodeDataSelect(){
		 	nodeSelect();

			var nodeAllSetList = {
					nodes : [],
					connectors : []
			}; 
		if(selectDataList != null){	
	        $.each(selectDataList, function(index,args){
	        	
				var node = {};
				var connector = {};
			
				node.name = args.camId;
				node.offsetX = Number(args.offSetX);
				node.offsetY = Number(args.offSetY);
				node.data = args.name;
				node.camStartdd = args.camStartDd;
				node.camEnddd = args.camEndDd;
				
				nodeAddInfo(node);
				
	           	connector = { 
	        			name: $.ifvmGetRowID(),
	            		sourceNode: args.parCamId,
	            		targetNode: args.camId
	           	};
				var item = nodeitemset(node,connector);
				nodeAllSetList.nodes.push(item.nodes);
				
				if (args.parCamId != null && args.parCamId != '') {
					nodeAllSetList.connectors.push(item.connectors);
				}
	           
			});
		 }
	   	return nodeAllSetList;		
	}
	 //그리드 선택시 diagram에 노드 추가
	function renderNode(node){

	    var addInfo = node.addInfo;
	    
	    
	    if (isNotEmpty(addInfo.htmlTemplateId)) {
	        var itemSet = { 
		            name: node.name,
		            type: ej.datavisualization.Diagram.Shapes.Html,
		            templateId : addInfo.htmlTemplateId,
		            //borderWidth: node.borderWidth,
		            labels: [{ readOnly: true, offset: {x: 0.5, y:1} }],
		            constraints : getNodeConstraints(),
		            offsetX: node.offSetX,
		            offsetY: node.offSetY,
		            addInfo: addInfo,
		            ports: node.ports
	        };
	        
	        diagram.add(itemSet);
	        
	        var addNode = diagram.getNode(node.name);
        	width = 180;
            height = 60;	
        
        	var option = {width: width, height: height };
	        diagram.updateNode(node.name,option);
	        
	        $('#' + node.name + "_html").mouseenter(function(args){
	            //console.log("OnMouseenter : " + node.name );
	            diagram._selectedNode = diagram.getNode(node.name);
	            //console.log(diagram._selectedNode);
	        })
	        
	        $('#' + node.name + "_html").mouseleave(function(args){
	            //console.log("OnMouseleave : " + node.name );
	            diagram._selectedNode = {};
	        })
	        
	        
	        diagram._clearSelection();
	    }
	}
	//노드의 생성부
	function nodeCreate(){
	 	nodeSelect();

			if(diagram._nodes == ""){//시작 노드를 생성
				var node = {};
				node = {
					name : gridData.id,
					offSetX : 520,
					offSetY : 70,
					data : gridData.camNm
				};
				// NodeDataClass 생성
				nodeAddInfo(node);
				renderNode(node);
				nodeInsert("",node);
			} else{ //시작 다음의 노드들 생성	
					var selectNodeItem = diagram._selectedItem;
					var node = {};
					node = {
						name : gridData.id,
						offSetX :  Number(diagram.getNode(selectNodeItem).offsetX),
						offSetY :  Number(diagram.getNode(selectNodeItem).offsetY)+100,
						data : gridData.camNm
					};
					var checkSelectDataList = false;
					//function planNodeUpdate(camId,parCamId,offSetY){
			        $.each(selectDataList, function(index,args){
						
						if(node.name == args.camId){ //이미 있는 노드를 선택했을때
								checkSelectDataList = true;
								alert('<spring:message code="M02948"/>');
								return false;
							}

					});
			        if(checkSelectDataList == false){ //신규노드
				        nodeAddInfo(node);
						renderNode(node);
						createNextConnector(selectNodeItem,node.name);
						nodeInsert(selectNodeItem,node);
			       	}
			}
	        diagram._clearSelection();
	}

	
	
	// diagram에서 node 및 connector 지우기
	function removeNode(){

		//상위 커넥터
		var inEdges = diagram.getNode(String(diagram.getNode(diagram._selectedItem).inEdges))
		var outEdges = diagram.getNode(String(diagram.getNode(diagram._selectedItem).outEdges))

		var node = diagram.getNode(diagram._selectedItem).name;
    	var multipleNodeCheck= diagram.getNode(diagram._selectedItem).outEdges.length
		var nodeName = diagram.getNode(diagram.getNode(diagram._selectItem))

	    if( inEdges != null && inEdges != ''){
	    	if( outEdges != null && outEdges != ''){ // 중간 노드
		    		$.each(diagram._nodes, function(index, node) {

			    	    if(String(node.name) == String(outEdges.targetNode)) { //하위노드 //선택한 노드의 하위노드
			    	    	
			    	    		var offSetY = String(diagram.getNode(node.name).offsetY);
			    	    		//선택한 노드로 부터 상위
		    	    			var sourceNode = diagram.getNode(String(diagram.getNode(diagram.getNode(diagram.getNode(String(diagram.getNode(node.name).inEdges))).sourceNode).inEdges)).sourceNode;
		    	    			var targetNode = outEdges.targetNode;
		    		    		createNextConnector(sourceNode,targetNode);	
		    	        		planNodeUpdate(targetNode,sourceNode,offSetY);	
								return false;
						}
		    	    });
		    		diagram.remove(diagram.getNode(node));
					nodeDelete(node);
				
	    	}else{//마지막 노드
	    		
	    		var diagramInstanceName = diagram._selectedItem;
	    		var diagarmInstanceDeleteWithName = diagram.getNode(diagram._selectedItem).name;
    	    	if(Number(multipleNodeCheck) > 1){//하위노드가 여러가지인 경우
    	    		$.each(diagram.getNode(diagram._selectedItem).outEdges, function(index, args) {
    	    			
    	    			if(multipleNodeCheck > index){
    	    				var offSetY = diagram.getNode(String(diagram.getNode(diagram.getNode(diagram.getNode(diagram.getNode(diagramInstanceName).outEdges[index]))).targetNode)).offsetY;
	    					var sourceNode = diagram.getNode(String(diagram.getNode(diagram.getNode(diagramInstanceName)).inEdges)).sourceNode;
	    					var targetNode = diagram.getNode(diagram.getNode(diagramInstanceName).outEdges[index]).targetNode;
	    		    		createNextConnector(sourceNode,targetNode);	
	    	        		planNodeUpdate(targetNode,sourceNode,offSetY);	
    	    			}		    	    		
    	    		});
		    		diagram.remove(diagram.getNode(diagarmInstanceDeleteWithName));
					nodeDelete(diagarmInstanceDeleteWithName);
    	    	}else{
		    		diagram.remove(diagram.getNode(diagarmInstanceDeleteWithName));
					nodeDelete(diagarmInstanceDeleteWithName);
    	    	}
	    	}	    	
	    }else{
	    	
	    	if(Number(multipleNodeCheck) > 1){
				alert('<spring:message code="M02951"/>');
		    }else{
		    	if( outEdges != null && outEdges != ''){ //시작 노드
	        		var offSetY = diagram.getNode(diagram._selectedItem).offsetY;
	        	    
	    			var sourceNode = diagram.getNode(diagram._selectedItem).addInfo.nodeId;
					var sourceUnderNode = diagram.getNode(String(diagram.getNode(diagram.getNode(diagram._selectedItem).addInfo.nodeId).outEdges)).targetNode;
					
	        		planNodeUpdate(sourceNode,null,offSetY);//시작노드
	        		planNodeUpdate(sourceUnderNode,null,offSetY);//시작노드의 하위 노드
					diagram.remove(diagram.getNode(node));
					nodeDelete(node);								    		
		    	}else{
					diagram.remove(diagram.getNode(node));
					nodeDelete(node);	
		    	}
		    }
		}
        diagram._clearSelection();
	}
	
	/*워크플로우 노드 및 커넥터 삭제*/
	function execRemove() {
	  if (planId != "null") {
		if(diagram._nodes != ""){  
	    	if (diagram._selectedItem!=null && diagram._selectedItem!=""){
				if(diagram._selectedItem != "multipleSelection"){
					removeNode();
				}else{
					alert('<spring:message code="M02946"/>');
				}
	    	}else{
				alert('<spring:message code="M02945"/>');
	    	}
		}else{
			alert('<spring:message code="M02949" />');		
		}
	  }else{
			//먼저 마케팅 플랜을 저장해주세요.
			alert('<spring:message code="M02943"/>');
	  }
	}
	//노드의 위치들을 변경하고 저장하게 되면 update 쿼리를 시작함.
	function saveWorkFlow(){
		if(diagram._nodes != null && diagram._nodes != '' ){
			var allNodes = diagram._nodes;
			var nodeList = [];
			
			$.each(allNodes,function(index,node){
				var offSetX = diagram.getNode(diagram._nodes[index].addInfo.nodeId).offsetX;
				var offSetY = diagram.getNode(diagram._nodes[index].addInfo.nodeId).offsetY;
				var camId = node.name;
				var nodeData = {};
				nodeData.camId = camId;
				nodeData.offSetX = offSetX;
				nodeData.offSetY = offSetY;
				
				nodeList.push(nodeData);
			});
				planAllNodeUpdate(nodeList);
		}else{
			alert('<spring:message code="M02949" />');
		}

	}
	//Workflow가 실행가능 한지에 대한 검사
	function plancampaignWorkFlowInit() {
		if (!(ej.browserInfo().name === "msie" && Number(ej.browserInfo().version) < 9)) {
	 				//워크플로우 생성및 노드 생성
	 				var dataList = nodeDataSelect();
	 				createDiagram(dataList);
		}else {
			alert('<spring:message code="M01025" />');
		}
	}	

	/*
	 * 마케팅 플랜 디테일 스크립트 
	 * 
	 * @date 2020. 06. 11.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
		
		/**
		 * 캠페인 그리드 팝업 선택 버튼 처리 
		 */
	function planCamNodeData(temp) {
		gridData = this.temp;
		temp = null;
		nodeCreate();
		dialog._destroy();
	}
	//신규 클릭시 나오는 팝업창
	function popUpDialog(){
		$("#dialog").ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : '<ifvm:url name="planDetailPop"/>',
			contentType : "ajax",
			title : '<spring:message code="M00967" />',
			width : 1200,
			maxWidth : 2000,
			maxHeight : 2000,
			open : function() {
				new ifvm.PopupCenter({
					popupDivId : 'dialog'
				});
			}
		});
	}
	
	$(document).ready(function() {
		//메인
		plancampaignWorkFlowInit();
		//저장버튼
    	$("#execSaveBtn").click(function() {
        	validation = $("#planDtlDiv").ifvValidation();	
    		saveWorkFlow();
    	});
    	//신규버튼
		$("#execNewBtn").on('click', function() {
			gridData = null;
			if (planId != "null") {
				if(diagram._selectedItem != "multipleSelection"){
					if(diagram._nodes == ""){
						popUpDialog();
					}else{
							if(diagram._selectedItem != ""){
								popUpDialog();
							}else{
								alert('<spring:message code="M02944"/>');
							} 
				  	}
				}else{
					alert('<spring:message code="M02946"/>');
				}
			} else {
				//먼저 마케팅 플랜을 저장해주세요.
				alert('<spring:message code="M02943"/>');
			}
		});
		//삭제버튼
		$("#execRemoveBtn").click(function() {
			execRemove();		
		});
	});
</script>


<div>
	<%-- 실행계획 상세 --%>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M02939" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<%-- 저장 버튼 --%>
			<button class="btn btn-sm" id="execSaveBtn">
			    <i class="glyphicon glyphicon-check"></i>
            	<spring:message code="M00573"/>
			</button>
			<%-- 신규 버튼 --%>
			<button class="btn btn-sm" id="execNewBtn">
				<spring:message code="M01852" />
			</button>
			<%-- 삭제 버튼 --%>
			<button class="btn btn-sm" id="execRemoveBtn">
				<spring:message code="M01854" />
			</button>
		</div>
	</div>

	<div class="sample-main" style="width: 100%; height: 700px">
		<div id="diagram"></div>
	</div>
</div>