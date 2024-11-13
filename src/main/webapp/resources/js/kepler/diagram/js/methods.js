/*!
 * Diagram Methods
 * Copyright dg.ryu
 * v1.0.0
 */

var cDialog;
var userHandles = [];
var diagramType;
var forTxt;
var diagramSubType=null;

// handler diaplay 설정
function ShowHandles(diagram, args, flag) {
    console.log("ShowHandles");
    var handles = diagram.model.selectedItems.userHandles;
    for (var i = 0; i < handles.length; i++) {
        handles[i].visible = false;
        
        if (args.elementType == "node" && diagramType == "LGC_COMP" && handles[i].name != "JoinSet") {
            handles[i].visible = true;
        }
        
        if (args.elementType == "connector" && diagramType == "LGC_COMP" && handles[i].name == "JoinSet") {
            handles[i].visible = true;
        }
    }
    
    /*if (args.elementType != "node" ) {
        setTimeout(function(){
            $("#diagram_canvas_svg_adorneruserHandle_g").remove();
        }, 100);
    }*/
}

// 핸들 생성
function createUserHandles() {
    console.log("createUserHandles");
    //로지컬 컴포넌트 커넥터
    var LinkTool = (function (base) {
        var node = null;
        var targetNode = null;
        var connector = null;
        ej.datavisualization.Diagram.extend(LinkTool, base);
        function LinkTool(name) {
            base.call(this, name);
            this.singleAction = true;
            this.cursor = "pointer";
            return this;
        }
        LinkTool.prototype.mousedown = function (evt) {
            connector = null;
            node = this.diagram.selectionList[0];
            this._currentPossibleConnection = node;
            // this._possibleConnectionPort = node.ports[0];
            base.prototype.mousedown.call(this, evt);
            this._showAllPorts();
            this.diagram.addSelection(node);
            this._sourcePossibleConnection = node;
            targetNode = null;
        };

        LinkTool.prototype.mouseup = function (evt) {
            
            // 대상노드 확인
            if (isNotEmpty(this._targetPossibleConnection)) {
                targetNode = this._targetPossibleConnection.name;
            }
            
            this.diagram._updateEdges(this);
            this._showAllPorts(true);
            base.prototype.mouseup.call(this, evt);
            
            if (targetNode) {
                
                var flag = true;
                // 로지컬 컴포넌트일경우
                if (diagramType == "LGC_COMP") {
                    // 커넥션 설정
                    flag = setLgcCompAddSelection(node, diagram.getNode(targetNode));
                }
                
                if (flag) {
                    // 대상 노드 연결
                    this.diagram.addSelection(targetNode);
                
                    // node data class 생성
                    var connectorName = this.diagram.selectionList[0].children[0];
                    var connector = diagram.getNode(connectorName);
                    // 유형: 커넥터, addInfo 설정 X
                    if (connector.type=="connector" && isEmpty(connector.addInfo)) {
                        var nodeData = new NodeDataClass();
                        nodeData.nodeId = connectorName;
                        nodeData.nodeType = "connector";
                        connector.addInfo = nodeData;
                    }
                } else {
                    // 커넥터 삭제
                    if (diagram.selectionList[0]._type != "node")
                        this.diagram.remove();
                }
            } else {
                // 대상 노드 없을 경우 커넥터 삭제
                if (diagram.selectionList[0]._type != "node")
                    this.diagram.remove();
            }
            
            this.diagram._clearSelection();
        };

        return LinkTool;
    })(ej.datavisualization.Diagram.OrthogonalLineTool);

    var linkHandle = ej.datavisualization.Diagram.UserHandle();
    linkHandle.name = "Line";

    linkHandle.position = ej.datavisualization.Diagram.UserHandlePositions.MiddleRight;
    linkHandle.visible = true;
    linkHandle.tool = new LinkTool(linkHandle.name);
    linkHandle.size = 30;
    linkHandle.backgroundColor = "#4D4D4D";
    linkHandle.pathData = "M196.2104,93.6494L196.2104,90.2544L189.1674,90.2544L189.1674,87.6694L196.2104,87.6694L196.2104,84.7344L200.6674,89.1914z";
    userHandles.push(linkHandle);
    
    //로지컬 컴포넌트 상세 팝업
    var DetailPopTool = (function (base) {
        var node = null;
        var targetNode = null;
        var connector = null;
        ej.datavisualization.Diagram.extend(DetailPopTool, base);
        function DetailPopTool(name) {
            base.call(this, name);
            this.singleAction = true;
            this.cursor = "pointer";
            return this;
        }
        DetailPopTool.prototype.mouseup = function (evt) {
            setTableNodeDetailPopup(diagram.selectionList[0].addInfo.nodeId); // function -> logicalComponentJoin.jsp
            
            base.prototype.mouseup.call(this, evt);
        };

        return DetailPopTool;
    })(ej.datavisualization.Diagram.ToolBase);
    
    var detailPopHandle = ej.datavisualization.Diagram.UserHandle();
    detailPopHandle.name = "DetailPop";

    detailPopHandle.position = ej.datavisualization.Diagram.UserHandlePositions.TopRight;
    detailPopHandle.visible = true;
    detailPopHandle.tool = new DetailPopTool(detailPopHandle.name);
    detailPopHandle.size = 30;
    detailPopHandle.backgroundColor = "#4D4D4D";
    detailPopHandle.pathData = "M236.2,1317.6c-1,0.1-1.8,1-1.8,2v84c0,1.1,0.9,2,2,2h62c1.1,0,2-0.9,2-2v-68c0-0.5-0.2-1.1-0.6-1.4l-16-16c-0.4-0.4-0.9-0.6-1.4-0.6h-46C236.3,1317.5,236.2,1317.5,236.2,1317.6z M238.4,1321.6h42v14c0,1.1,0.9,2,2,2h14v64h-58V1321.6zM284.4,1324.4l9.2,9.2h-9.2V1324.4z M245.2,1340.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h22c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-22C245.3,1340.5,245.2,1340.5,245.2,1340.6z M245.2,1351.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h44c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-44C245.3,1351.5,245.2,1351.5,245.2,1351.6z M245.2,1362.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h44c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-44C245.3,1362.5,245.2,1362.5,245.2,1362.6zM245.2,1373.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h44c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-44C245.3,1373.5,245.2,1373.5,245.2,1373.6z M245.2,1384.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h44c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-44C245.3,1384.5,245.2,1384.5,245.2,1384.6z";
    userHandles.push(detailPopHandle);
    
    //로지컬 컴포넌트 커넥터 조인 설정
    var JoinSetTool = (function (base) {
        var node = null;
        var targetNode = null;
        var connector = null;
        ej.datavisualization.Diagram.extend(JoinSetTool, base);
        function JoinSetTool(name) {
            base.call(this, name);
            this.singleAction = true;
            this.cursor = "pointer";
            return this;
        }
        JoinSetTool.prototype.mouseup = function (evt) {
        	
         	var reqData = {
         		    leftTblNode : diagram.getNode(diagram.selectionList[0].sourceNode)
         		  , rightTblNode : diagram.getNode(diagram.selectionList[0].targetNode)
         		  , popType : "MODIFY"
         	   }
         	setJoinSettingPop(reqData);
            
            base.prototype.mouseup.call(this, evt);
        };

        return JoinSetTool;
    })(ej.datavisualization.Diagram.ToolBase);
    
    var joinSetHandle = ej.datavisualization.Diagram.UserHandle();
    joinSetHandle.name = "JoinSet";

    joinSetHandle.position = ej.datavisualization.Diagram.UserHandlePositions.MiddleRight;
    joinSetHandle.visible = true;
    joinSetHandle.tool = new JoinSetTool(joinSetHandle.name);
    joinSetHandle.size = 30;
    joinSetHandle.backgroundColor = "#4D4D4D";
    joinSetHandle.pathData = "M236.2,1317.6c-1,0.1-1.8,1-1.8,2v84c0,1.1,0.9,2,2,2h62c1.1,0,2-0.9,2-2v-68c0-0.5-0.2-1.1-0.6-1.4l-16-16c-0.4-0.4-0.9-0.6-1.4-0.6h-46C236.3,1317.5,236.2,1317.5,236.2,1317.6z M238.4,1321.6h42v14c0,1.1,0.9,2,2,2h14v64h-58V1321.6zM284.4,1324.4l9.2,9.2h-9.2V1324.4z M245.2,1340.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h22c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-22C245.3,1340.5,245.2,1340.5,245.2,1340.6z M245.2,1351.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h44c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-44C245.3,1351.5,245.2,1351.5,245.2,1351.6z M245.2,1362.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h44c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-44C245.3,1362.5,245.2,1362.5,245.2,1362.6zM245.2,1373.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h44c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-44C245.3,1373.5,245.2,1373.5,245.2,1373.6z M245.2,1384.6c-1.1,0.1-2,1-1.9,2.1c0.1,1.1,1,2,2.1,1.9h44c1.1,0,2-0.9,2-2c0-1.1-0.9-2-2-2c0,0,0,0-0.1,0h-44C245.3,1384.5,245.2,1384.5,245.2,1384.6z";
    userHandles.push(joinSetHandle);
    

    //로지컬 컴포넌트 그룹 컬럼 상세 팝업
    var GroupColPopTool = (function (base) {
        var node = null;
        var targetNode = null;
        var connector = null;
        ej.datavisualization.Diagram.extend(GroupColPopTool, base);
        function GroupColPopTool(name) {
            base.call(this, name);
            this.singleAction = true;
            this.cursor = "pointer";
            return this;
        }
        GroupColPopTool.prototype.mouseup = function (evt) {
            setTableGroupColPopup(diagram.selectionList[0].addInfo.nodeId, diagram.selectionList[0].addInfo.data.columnList, diagram.selectionList[0].addInfo.data.grpColFlag); // function -> logicalComponentJoin.jsp
            
            base.prototype.mouseup.call(this, evt);
        };

        return GroupColPopTool;
    })(ej.datavisualization.Diagram.ToolBase);
    
    var groupColPopHandle = ej.datavisualization.Diagram.UserHandle();
    groupColPopHandle.name = "GroupColPop";

    groupColPopHandle.position = ej.datavisualization.Diagram.UserHandlePositions.BottomRight;
    groupColPopHandle.visible = true;
    groupColPopHandle.tool = new GroupColPopTool(groupColPopHandle.name);
    groupColPopHandle.size = 30;
    groupColPopHandle.backgroundColor = "#4D4D4D";
//    groupColPopHandle.pathData = "M22.0542,27.332C20.4002,27.332,19.0562,25.987,19.0562,24.333C19.0562,22.678,20.4002,21.333,22.0542,21.333C23.7082,21.333,25.0562,22.678,25.0562,24.333C25.0562,25.987,23.7082,27.332,22.0542,27.332 M30.6282,22.889L28.3522,22.889C28.1912,22.183,27.9142,21.516,27.5272,20.905L29.1392,19.293C29.3062,19.126,29.3062,18.853,29.1392,18.687L27.7032,17.251C27.6232,17.173,27.5152,17.125,27.3982,17.125C27.2862,17.125,27.1782,17.173,27.0952,17.251L25.4872,18.863C24.8732,18.476,24.2082,18.201,23.5002,18.038L23.5002,15.762C23.5002,15.525,23.3092,15.333,23.0732,15.333L21.0422,15.333C20.8062,15.333,20.6122,15.525,20.6122,15.762L20.6122,18.038C19.9072,18.201,19.2412,18.476,18.6292,18.863L17.0192,17.252C16.9342,17.168,16.8242,17.128,16.7162,17.128C16.6052,17.128,16.4972,17.168,16.4112,17.252L14.9752,18.687C14.8952,18.768,14.8492,18.878,14.8492,18.99C14.8492,19.104,14.8952,19.216,14.9752,19.293L16.5872,20.905C16.2002,21.516,15.9242,22.183,15.7642,22.889L13.4852,22.889C13.2502,22.889,13.0572,23.08,13.0572,23.316L13.0572,25.35C13.0572,25.584,13.2502,25.777,13.4852,25.777L15.7612,25.777C15.9242,26.486,16.2002,27.15,16.5872,27.764L14.9752,29.374C14.8092,29.538,14.8092,29.813,14.9752,29.979L16.4112,31.416C16.4912,31.494,16.6022,31.541,16.7162,31.541C16.8272,31.541,16.9382,31.494,17.0192,31.416L18.6252,29.805C19.2412,30.191,19.9072,30.467,20.6122,30.63L20.6122,32.906C20.6122,33.141,20.8062,33.333,21.0422,33.333L23.0732,33.333C23.3092,33.333,23.5002,33.141,23.5002,32.906L23.5002,30.63C24.2082,30.467,24.8732,30.191,25.4872,29.805L27.0952,31.416C27.1812,31.499,27.2892,31.541,27.3982,31.541C27.5102,31.541,27.6202,31.499,27.7032,31.416L29.1392,29.979C29.2202,29.899,29.2662,29.791,29.2662,29.677C29.2662,29.563,29.2202,29.453,29.1392,29.374L27.5312,27.764C27.9142,27.149,28.1912,26.486,28.3522,25.777L30.6282,25.777C30.8652,25.777,31.0552,25.584,31.0552,25.35L31.0552,23.316C31.0552,23.08,30.8652,22.889,30.6282,22.889";
    groupColPopHandle.pathData = "M336 64h-80c0-35.3-28.7-64-64-64s-64 28.7-64 64H48C21.5 64 0 85.5 0 112v352c0 26.5 21.5 48 48 48h288c26.5 0 48-21.5 48-48V112c0-26.5-21.5-48-48-48zM96 424c-13.3 0-24-10.7-24-24s10.7-24 24-24 24 10.7 24 24-10.7 24-24 24zm0-96c-13.3 0-24-10.7-24-24s10.7-24 24-24 24 10.7 24 24-10.7 24-24 24zm0-96c-13.3 0-24-10.7-24-24s10.7-24 24-24 24 10.7 24 24-10.7 24-24 24zm96-192c13.3 0 24 10.7 24 24s-10.7 24-24 24-24-10.7-24-24 10.7-24 24-24zm128 368c0 4.4-3.6 8-8 8H168c-4.4 0-8-3.6-8-8v-16c0-4.4 3.6-8 8-8h144c4.4 0 8 3.6 8 8v16zm0-96c0 4.4-3.6 8-8 8H168c-4.4 0-8-3.6-8-8v-16c0-4.4 3.6-8 8-8h144c4.4 0 8 3.6 8 8v16zm0-96c0 4.4-3.6 8-8 8H168c-4.4 0-8-3.6-8-8v-16c0-4.4 3.6-8 8-8h144c4.4 0 8 3.6 8 8v16z";
   // userHandles.push(groupColPopHandle);
    
    return userHandles;
}

function setSelection() {
    console.log("setSelection");
}

// diagram size 설정
function setDiagramSize(showpropeditor) {
    console.log("setDiagramSize");
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

// drop 노드 추가
function addDropNode(args) {
    console.log("addDropNode");
    if (diagramType == "SEG") {
        addSegmentNode(args);
    } else {
        addLogicalComponentNode(args);
    }
}

// html node 렌더 (edit:2016.01.04)
function renderNode(node){
    console.log("renderNode");
    var addInfo = node.addInfo;
    
    console.log("renderNode X1");
    console.log(node);
    console.log(node.offsetX);
    
    // 노드 Data의 htmlTemplateId 가지고 있을 경우만 html node 렌더
    // 아래 node처럼 강제로 html 생성시 ie에서는 보이지 않는현상이 발생
    // diagram html shape node 생성 후 해당 html안에 template 생성후 교체함
    
    if (isNaN(node.offsetX)) {
        node.offsetX = diagram._selectedNode.offsetX;
    }
    
    if (isNaN(node.offsetY)) {
        node.offsetY = diagram._selectedNode.offsetY;
    }
    
    //이전 좌표 기본 설정
    addInfo.oldOffSetX = Number(node.offsetX);
    addInfo.oldOffSetY = Number(node.offsetY);
    
    if (isNotEmpty(addInfo.htmlTemplateId)) {
        var itemSet = { 
            name: node.name,
            type: ej.datavisualization.Diagram.Shapes.Html,
            templateId : addInfo.htmlTemplateId,
            borderWidth: node.borderWidth,
            // minWidth: "250", maxWidth: "300", maxHeight: "200",
            labels: [{ readOnly: true, offset: {x: 0.5, y:1} }],
            constraints : getNodeConstraints(),
            offsetX: node.offsetX, offsetY: node.offsetY,
            addInfo: addInfo,
            ports: node.ports
        };
        
        diagram.add(itemSet);
        
        var addNode = diagram.getNode(node.name);
        var width, height;
        if(node.addInfo.diagramType == "SEG"){
        	width = $('#' + addNode.addInfo.nodeId + addNode.addInfo._Suffix).width()+5;
        	height = $('#' + addNode.addInfo.nodeId + addNode.addInfo._Suffix).height()+5;
        } else {
        	width = 240;
            height = 58;	
        }
        
        var option = {width: width, height: height };
        
        diagram.updateNode(node.name, option);
        
        $('#' + node.name + "_html").mouseenter(function(args){
            console.log("OnMouseenter : " + node.name );
            diagram._selectedNode = diagram.getNode(node.name);
            console.log(diagram._selectedNode);
        })
        
        $('#' + node.name + "_html").mouseleave(function(args){
            console.log("OnMouseleave : " + node.name );
            diagram._selectedNode = {};
        })
        
        //노드 위에 노드를 드랍할때 이벤트를 얻기 위해 사용
        //jquery ui 
        $('#' + node.name + "_html").draggable();
        $('#' + node.name + "_html").droppable({
            drop: function( event, ui ) {
                console.log("nodeOnNode : " + node.name );
                diagram._selectedNode = diagram.getNode(node.name);
                
                if (diagramType == "SEG") {
                    segNodeDragCompleted();
                }
            }
        });
        
        //set tooltip
        if (diagramType == "SEG" || diagramType =="TGT_GROUP") {
            $('#' + node.name + "_html").hover(function(){              // Hover over code
                var html = $('#' + node.name + "_html #attribute").clone();
    			segFilterIdForTxt=node.addInfo.data.segFilterId;
				$(this).data('tipText', html).removeAttr('title');
				
				if(diagramSubType=="CSSEG"){
					setCustRuleTxt(segFilterIdForTxt);
				}else{
				   	$('<div class="tooltip"></div>')
                	.html(html)
                	.appendTo('body')
                	.fadeIn('slow');
				}
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
        
        diagram._clearSelection();
    }
}

//전체 노드 노드 위에 노드를 드랍할때 이벤트 얻기 위해 사용
function setDroppableEvent() {
    console.log("setDroppableEvent");
    $.each(diagram.nodes(), function(index, node) {
        $('#' + node.name + "_html").mouseenter(function(args){
            console.log("OnMouseenter : " + node.name );
            diagram._selectedNode = node;
        })
        
        $('#' + node.name + "_html").mouseleave(function(args){
            console.log("OnMouseleave : " + node.name );
            diagram._selectedNode = {};
        })
        
        
        $('#' + node.name + "_html").draggable();
        $('#' + node.name + "_html").droppable({
            drop: function( event, ui ) {
                console.log("nodeOnNode : " + node.name );
                diagram._selectedNode = node;
                
                if (diagramType == "SEG") {
                    segNodeDragCompleted();
                }
            }
        });
    });
}

// 선택 노드 선색 설정
function setSelectedNode(args, type) {
    console.log("setSelectedNode");
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

// 조인연결 설정
function setConnectJoin(args) {
    console.log("setConnectJoin");
    if (args.newItems.length == 1 && args.oldItems.length) {
        if (args.newItems[0]._type == "node" && args.oldItems[0]._type == "node") {
            
            var name = $.ifvmGetRowID();
            var nodeData = new NodeDataClass();
            nodeData.nodeId = name;
            var node = {
                name: name,
                // segments: item.segments,
                cornerRadius: 10,
                sourceNode: args.oldItems[0].name,
                targetNode: args.newItems[0].name,
                lineWidth: 2,
                lineColor: "black",
                // constraints: item.constraints,
                addInfo: nodeData
            };
            
            diagram.add(node);
        }
    }
}

// set nodeDataClass
function setNewNodeDataClass(data) {
    console.log("setNewNodeDataClass");
    var nodeData = new NodeDataClass();
    nodeData.nodeId = data.nodeId;
    nodeData.nodeName = data.nodeName;
    nodeData.nodeType = data.nodeType;
    nodeData.title = data.title;
    nodeData.htmlTemplateId = data.htmlTemplateId;
    nodeData.imageSource = data.imageSource;
    nodeData.nodeDesc = data.nodeDesc;
    nodeData.title = data.title;
    nodeData.text = data.text;
    nodeData.fillColor = data.fillColor;
    nodeData.connectSeq = stringToNumber(data.connectSeq);
    
    $.each(data.handleList, function(index, handle) {
        nodeData.handleList.push(handle);
    });
    
    return nodeData;
}

// shape 생성
function createIntelligentShape(name, fNode) {
    console.log("setNewNodeDataClass");
    var node = {};
    node.ports = [];
    node.ports.push(createPort(name, .5, .5));
    node.name = name;
    node.width = 40;
    node.height = 40;
    node.fillColor = "white";
    node.borderWidth = 1.5;
    
    
    // 커넥터 생성
    var item = getPaletteItemByName("next");
    if (item) {
        var name = $.ifvmGetRowID();// item.name +
                                    // ej.datavisualization.Diagram.Util.randomId();
        
        var nodeData = new NodeDataClass();
        nodeData.nodeName = name;
        nodeData.nodeId = item.addInfo.nodeId;
        nodeData.taskId = name;
        node = {
			name: name,
			segments: item.segments,
			cornerRadius: 10,
			sourceNode: sourceNode,
			targetNode: fNode.name,
			targetDecorator: item.targetDecorator,
			lineWidth: item.lineWidth,
			lineDashArray: item.lineDashArray,
			lineColor: item.lineColor,
			labels: item.labels,
			constraints: item.constraints,
			addInfo: nodeData
        };
    }
    
    return node;
}

// 연결 순서에 따른 source node 찾기
function getConnectSourceNode(fnode){
    console.log("getConnectSourceNode");
	var tSeq = fnode.addInfo.connectSeq;
	var rNode = {};
	for (var i=1; i < tSeq; i++) {
		$.each(diagram.nodes(), function(index, node) {
			if (node.addInfo.connectSeq == tSeq-i) {
				rNode = node;
				
				return false;
			}
		});
		
		if (isNotEmpty(rNode)) {
			break;
		}
	}
	
	return rNode;
}

// source node의 out connectors 설정
function setConnectSourceNodeOutEdges(fNode) {
    console.log("setConnectSourceNodeOutEdges");
	$.each(fNode.outEdges, function(index, edge) {
		var connector = diagram.getNode(edge);
		
		if (isNotEmpty(connector) && isNotEmpty(connector.targetNode)) {
			var targetNode = diagram.getNode(connector.targetNode);
			var newSourceNode = getConnectSourceNode(targetNode);
			
			if (isNotEmpty(newSourceNode)) {
				var sourceNode = newSourceNode.name;
				connector.sourceNode = sourceNode;
				diagram.updateConnector(connector.name, { sourceNode: sourceNode });
			}
		}
	});
}

// diagram에서 node 찾기
function findNode(name){
    console.log("findNode");
    return diagram.getNode(name);
}

// diagram에서 node 찾기
function findNodeByNodeType(type){
    console.log("findNodeByNodeType");
	var rNode = [];
	$.each(diagram.nodes(), function(index, node) {
		if (node.addInfo.nodeType == type) {
			rNode.push(node);
		}
	}); 
	
    return rNode;
}

// diagram에서 node명으로 node선택
function selectionNode(name){
    console.log("selectionNode");
    // 기존 선택 노드 해제
    diagram._clearSelection();
    
    var node = diagram.getNode(name);
    // 노드 선택
    diagram.addSelection(node);
}

// diagram에서 connector 찾기
function findConnector(name){
    console.log("findConnector");
    var rtnConnector = null;
    $.each(diagram.connectors(), function(index, connector) { 
       if(connector.name === name) {
           rtnConnector = connector;
       }
    });
    
    return rtnConnector;
}

// diagram json data 반환
function getDiagramData(){
    console.log("getDiagramData");
    var diagramData = diagram.save();
    
    return JSON.stringify(diagramData);
}

// json data를 diagram에 셋팅
function setDiagramData(data){
    console.log("setDiagramData");
    diagram.load(JSON.parse(data));

    $.each(diagram.nodes(), function(index, node) {
        var nodeData = new NodeDataClass();
        nodeData.setData(node.addInfo);
        node.addInfo = nodeData;
        setDropOnNode(node);
    });
}

// 포트 생성
function createPort(name, x, y) {
    console.log("createPort");
    var port = { name: name + ej.datavisualization.Diagram.Util.randomId(), offset: { x: x, y: y } };
    return port;
}

// node Constraints 추출
function getNodeConstraints() {
    console.log("getNodeConstraints");
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

// connector Constraints 추출
function getConnectorConstraints() {
    console.log("getConnectorConstraints");
    var connectorConstraints = ej.datavisualization.Diagram.ConnectorConstraints.Default 
        & ~ej.datavisualization.Diagram.ConnectorConstraints.DragSourceEnd
        & ~ej.datavisualization.Diagram.ConnectorConstraints.DragTargetEnd
        & ~ej.datavisualization.Diagram.ConnectorConstraints.Drag
        & ~ej.datavisualization.Diagram.ConnectorConstraints.DragSegmentThumb
        & ~ej.datavisualization.Diagram.ConnectorConstraints.Bridging
        & ~ej.datavisualization.Diagram.ConnectorConstraints.DragLabel
        & ~ej.datavisualization.Diagram.ConnectorConstraints.InheritBridging;
    
    if (diagramType == "SEG") {
        connectorConstraints = connectorConstraints 
            & ~ej.datavisualization.Diagram.ConnectorConstraints.Select
    }
    
    return connectorConstraints;
}

// 기본 포트 추출
function getDefaultPort(name) {
    console.log("getDefaultPort");
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

// diagram 초기화
function setDiagramClear() {
    console.log("setDiagramClear");
    diagram.clear();
}

// get nodes By nodeType
function getNodesByNodeType(node, type) {
    console.log("getNodesByNodeType");
	var nodes = [];
	if (isNotEmpty(node)) {
		var parentNodes = getParentNodesByNodeType(node, type);
	    var childNodes = getChildNodesByNodeType(node, type);
	    nodes = $.merge(parentNodes, childNodes);
	    
	    if (node.addInfo.nodeType == type) {
	    	nodes.push(node);
	    }
	}
    
	return nodes;
}

// get parent nodes By nodeType
function getParentNodesByNodeType(node, type) {
    console.log("getParentNodesByNodeType");
	var nodes = [];
	var chkNodeNames = [];
	if (isNotEmpty(node) && isNotEmpty(node.inEdges)) {
	    var inEdges = [];
	    $.each(node.inEdges, function(index, edge) {
	    	inEdges.push(edge);
    	});
	    for (var idx = 0; idx < inEdges.length; idx++) {
	        var connector = findNode(inEdges[idx]);
	        if (isNotEmpty(connector)) {
		        var node = findNode(connector.sourceNode);
		        if (isNotEmpty(node)) {
		        	if (checkNodeNames(chkNodeNames, node.name)) {
				        if (node.addInfo.nodeType == type) {
				            nodes.push(node);
				        }
				        $.each(node.inEdges, function(index, addName){
				            inEdges.push(addName);
				        });
		        	}
		        	
		        	chkNodeNames.push(node.name);
		        }
	        }
	    }
	}
    
    return nodes;
}

// get child nodes By nodeType
function getChildNodesByNodeType(node, type) {
    console.log("getChildNodesByNodeType");
    var nodes = [];
    var chkNodeNames = [];
    if (isNotEmpty(node) && isNotEmpty(node.outEdges)) {
    	var outEdges = [];
    	$.each(node.outEdges, function(index, edge) {
	    	outEdges.push(edge);
    	});
	    for (var idx = 0; idx < outEdges.length; idx++) {
	        var connector = findNode(outEdges[idx]);
	        if (isNotEmpty(connector)) {
		        var node = findNode(connector.targetNode);
		        if (isNotEmpty(node)) {
		        	if (checkNodeNames(chkNodeNames, node.name)) {
				        if (node.addInfo.nodeType == type) {
				            nodes.push(node);
				        }
				        $.each(node.outEdges, function(index, addName){
				            outEdges.push(addName);
				        });
		        	}
		        	
		        	chkNodeNames.push(node.name);
	        }
	        }
	    }
    }
    
    return nodes;
}

//하위 노드 추출
function getChildNode(nodeId) {
    console.log("getChildNode");
    var childNodes = [];
    var _this = {};
    var len = 0;
    
    if (isEmpty(nodeId)) {
        _this = diagram.selectionList[0];
        len = diagram.selectionList.length;
    } else {
        _this = diagram.getNode(nodeId);
        len = 1;
    }
    //선택 노드가 하나일경우
    if (len == 1 && _this._type == "node") {
        //연결 커넥터 및 하위 노드 추출
        $.each(_this.outEdges, function(index, edge) {
            var connector = findNode(edge);
            var node = findNode(connector.targetNode);
            if (isNotEmpty(node)) {
                var idx = 0;
                //순서 확인(왼쪽 > 오른쪽)
                for (var i=0; i < childNodes.length; i++) {
                    if (childNodes[i].offsetX < node.offsetX) {
                        idx++;
                    } else {
                        break;
                    }
                }
                
                //배열 삽입
                childNodes = shiftArray(childNodes, idx, node);
            }
        });
    }
    
    return childNodes;
}

//배열 삽입
function shiftArray(obj, idx, inObj) {
    console.log("shiftArray");
    var cnt = obj.length - idx;
    var sObj = obj.splice(idx, cnt);
    obj.push(inObj);
    $.merge(obj, sObj) 
    
    return obj;
}

// 노드명이 존재하는지 확인(상위 또는 하위 노드들에 대한 확인 함수의 무한루프를 방지하기 위해 사용)
function checkNodeNames(chkNodeNames, nodeName) {
    console.log("checkNodeNames");
	var check = true;
	$.each(chkNodeNames, function(index, chkName) {
		if (chkName == nodeName) {
			check = false;
		}
		
		if (!(check)) {
			return false;
		}
	});
	
	return check;
} 


// 노드 데이터 추출
// 저장 로직에 의한 제거 될 노드 먼저 추출
function getAllNodeDataClass(obj) {
    console.log("getAllNodeDataClass");
    var items = {};
    var nodeList = [];
    var connectorList = [];
    // get remove nodes
    $.each(obj._removeNodes, function(index, node) {
        if (isNotEmpty(node.addInfo.nodeId)) {
            node.addInfo.offsetX = node.offsetX;
            node.addInfo.offsetY = node.offsetY;
          
      	    nodeList.push(node.addInfo);
        }
    });
      
    // get nodes
    $.each(obj.nodes(), function(index, node) {
        if (isNotEmpty(node.addInfo.nodeId)) {
            node.addInfo.offsetX = node.offsetX;
            node.addInfo.offsetY = node.offsetY;
            
            nodeList.push(node.addInfo);
        }
    });
    
    // get remove connector
    $.each(obj._removeConnectors, function(index, connector) {
        if (isNotEmpty(connector.addInfo.nodeId)) {
            var sourceNode = "";
            if (isNotEmpty(connector.sourceNode)) {
                sourceNode = connector.sourceNode;
            }
            var targetNode = "";
            if (isNotEmpty(connector.targetNode)) {
                targetNode = connector.targetNode;
            }
            
            connector.addInfo.sourceNode = sourceNode;
            connector.addInfo.targetNode = targetNode;
          
            connectorList.push(connector.addInfo);
        }
    });
      
    // get connector
    $.each(obj.connectors(), function(index, connector) {
        if (isNotEmpty(connector)) {
            var sourceNode = "";
            if (isNotEmpty(connector.sourceNode)) {
                sourceNode = connector.sourceNode;
            }
            var targetNode = "";
            if (isNotEmpty(connector.targetNode)) {
                targetNode = connector.targetNode;
            }
            
            connector.addInfo.sourceNode = sourceNode;
            connector.addInfo.targetNode = targetNode;
            
            connectorList.push(connector.addInfo);
        }
    });
    
    items.nodeList = nodeList;
    items.connectorList = connectorList;
      
    return items;
}

// 전체 노드 및 커넥터 추출 반환 Task 저장을 위한
function getNodesAndConnectors(obj) {
    console.log("getNodesAndConnectors");
    var items = {};
    var nodeList = [];
    var connectorList = [];
    
    // 노드 추출
    $.each(obj.nodes(), function(index, node) {
        if (isNotEmpty(node.addInfo.nodeId)) {
            var item = {
                    nodeId: node.addInfo.nodeId,
                    id: node.addInfo.taskId,
                    offSetX: node.offsetX,
                    offSetY: node.offsetY
            };
            nodeList.push(item);
        }
    });
    
    // 커넥터 추출
    $.each(obj.connectors(), function(index, connector) {
        if (isNotEmpty(connector.addInfo.nodeId)) {
            var sourceNode = "";
            if (isNotEmpty(connector.sourceNode)) {
                sourceNode = connector.sourceNode;
            }
            var targetNode = "";
            if (isNotEmpty(connector.targetNode)) {
                targetNode = connector.targetNode;
            }
            
            var item = {
                    connectorId: connector.addInfo.nodeId,
                    id: connector.addInfo.taskId,
                    sourceNode: sourceNode,
                    sourcePointX: connector.sourcePoint.x,
                    sourcePointY: connector.sourcePoint.y,
                    targetNode: targetNode,
                    targetPointX: connector.targetPoint.x,
                    targetPointY: connector.targetPoint.y
            };
            
            connectorList.push(item);
        }
    });
    
    items.nodeList = nodeList;
    items.connectorList = connectorList;
    console.log(items);
    
    return items;
}

/**
 * 노드 데이터 추출 selectNode: 선택노드 obj nodeType: 노드유형 dataKey: addInfo.data 에 속에 있는
 * key명 dataKey 없을경우 addInfo.data 반환
 */
function getNodeDataByNodeType(selectNode, nodeType, dataKey) {
    console.log("getNodeDataByNodeType");
    var rtnVal;
    var node = getNodesByNodeType(selectNode, nodeType);
    if (node.length > 0) {
        node = node[0];
        if (isNotEmpty(node) && isNotEmpty(node.addInfo) && isNotEmpty(node.addInfo.data)) {
            var data = node.addInfo.data;
            if (isNotEmpty(dataKey)) {
                for(key in data) {
                    if (key == dataKey) {
                        rtnVal = data[key];
                        break;
                    }
                }
            } else {
                rtnVal = data;
            }
        }
    }
    
    return rtnVal;
}

// 선택 노드 삭제
function removeSelectedNodes(args) {
    console.log("removeSelectedNodes");
    if (diagramType == "SEG") {
        removeSegmentNode(args);
    } else if (diagramType == "LGC_COMP") {
    	removeLgcCompNodeByDeleteKey(args);
    }
}

// 추가 되는 노드 확인
function checkAddNode(args) {
    console.log("checkAddNode");
	if (isNotEmpty(args.element) && isNotEmpty(args.element.addInfo)) {
		var node = args.element.addInfo;
		// info 노드가 하나 이상이라면 || 채널 유형은 한개만 추가 할 수 있다.
		if (findNodeByNodeType(node.nodeType).length >= 1 || !checkChnlTypeOnlyOne(node.nodeType)) {
			alert(MESSAGE.campaign.onlyOneNodeCanBeAdded);
			
			// 노드를 취소한다.
			args.cancel = true;
			
			return false;
		}
	}
	
	return true;
}

// 피로도제외 여부
function getFatigueExcept() {
    console.log("getFatigueExcept");
	var rstValue = false;
	if (findNodeByNodeType("INFO").length != 0) {
		var node = findNodeByNodeType("INFO")[0].addInfo;
		if (isNotEmpty(node.data) && isNotEmpty(node.data.campaignDefaultInfo)) {
			var fatigueExceptYn = node.data.campaignDefaultInfo.fatigueExceptYn;
			
			if (fatigueExceptYn == "true") {
				rstValue = true;
			}
		}
	}
	
	return rstValue;
}

// 팝업 폼 모든 객체 Disabled
function setPopupFormAllDisabled(id) {
    console.log("setPopupFormAllDisabled");
	$("#" + id + " select").attr('disabled',true);
	$("#" + id + " input").attr('disabled',true);
	$("#" + id + " textarea").attr('disabled',true);
	$("#" + id + " .input-group-addon").remove();
	
	$.each($("#" + id + " button"), function(index, btn) {
		if(!(btn.className.match("cancel"))) {
			btn.setAttribute('disabled',true);
		}
	});
}

// 템플릿 사용/해제 버튼 text 설정
function setCampaignWorkflowTempUseBtn(flag) {
	
	// 버튼 활성
	$("#campaignWorkflowTempUseBtn").attr('disabled',false);
	
	if (flag == "1") {
		// 템플릿 해제
		$("#campaignWorkflowTempUseBtnText").text(TXTCancelTemplate);
	} else {
		// 템플릿 사용
		$("#campaignWorkflowTempUseBtnText").text(TXTUseAsTemplate);
	}
}


/* logical Component Start */
//로지컬 컴포넌트 노드 추가
function addLogicalComponentNode(args) {
    console.log("addLogicalComponentNode");
	addJoinTableRelNode(args); // function -> logicalComponentJoin.jsp
}

//커넥터 연결시 이벤트
//return true: 커넥터 생성, false: 취소
function setLgcCompAddSelection(sourceNode, targetNode) {
    console.log("setLgcCompAddSelection");
	var flag = true;
	var reqData = {
		    leftTblNode : sourceNode
		  , rightTblNode : targetNode
		  , popType : "NEW"
	}
	 
	return setJoinSettingPop(reqData);
}
//클릭 설정
function setLgcCompClick(args) {
    console.log("setLgcCompClick");
/*
  * if (args.elementType == "connector"){ var reqData = { leftTblNode :
  * diagram.getNode(args.element.sourceNode) , rightTblNode :
  * diagram.getNode(args.element.targetNode) } setJoinSettingPop(reqData); }
  */
}

//더블클릭 설정
function setLgcCompDoubleClick(args) {
    console.log("setLgcCompDoubleClick");
 if (args.elementType == "connector"){
 	var reqData = {
 		    leftTblNode : diagram.getNode(args.element.sourceNode)
 		  , rightTblNode : diagram.getNode(args.element.targetNode)
 		  , popType : "MODIFY"
 	   }
 	setJoinSettingPop(reqData);
 }
}

// 아이템 클릭시
function setLgcCompItemeClick(args) {
    console.log("setLgcCompItemeClick");
}


/* logical Component End */


/* Segment Start */

// 세그먼트 노드 추가
function addSegmentNode(args) {
    console.log("addSegmentNode");
    var selNode = diagram._selectedNode;
    
    // 선택된 노드가 있을경우
    if (isNotEmpty(selNode)) {
        // node 생성
        var node = {};
        node.name = $.ifvmGetRowID();
        node.borderWidth = 0;
        node.offsetX = Number(selNode.offsetX);
        node.offsetY = Number(selNode.offsetY + 100);
        node.ports = getDefaultPort();
            
        // NodeDataClass 생성
        var nodeData = new NodeDataClass();
        nodeData.nodeId = node.name;
        nodeData.htmlTemplateId = "segmentNodeTemplate";
        nodeData.nodeDataStatus = "I";
        nodeData.diagramType = "SEG";
        
        // data 조회
        var atribGroupColId = args.droppedElementData.id;
        var atribGroupColName = args.droppedElementData.text;
        
        nodeData.data = {
                segFilterId : node.name,
                displayName : atribGroupColName,
                filterCount : "0",
                atribGroupColId: atribGroupColId,
                dataStatus : "I",
                segmentId: segment.segmentId,
                logicalCompId: segment.logicalCompId
        }
        
        var index = args.droppedElementData.index;
        var tData = {};
        $.each(args.model.fields.dataSource, function(index, data) {
            if(data.id == atribGroupColId) {
                tData = data;
                return false;
            }
        });
        
        var colType = tData.colType;
        nodeData.nodeType = colType;
        
        // 어트리뷰트 그룹 컬럼 유형; D: dimension, M: Measure
        if (colType == "D") {
            nodeData.attributeType = "attribute_filter";
        }
        else if (colType == "M") {
            nodeData.attributeType = "attribute_member";
        }
        
        node.addInfo = nodeData;
        
        // 노드 생성
        renderNode(node);
        
        // 커넥터 생성
        createNextConnector(selNode.name, node.name);
        
        // 신규 노드 선택
        selectionNode(node.name);
        
        // 세그먼트 필터 설정 팝업 열기
        segmentFilterSetPopOpen(atribGroupColId);
    }
}

// 세그먼트 노드 드래그 완료시
function segNodeDragCompleted(args) {
    console.log("segNodeDragCompleted");
    //var node = args.element;
    var selNode = diagram._selectedNode;
    
    var node = diagram._selectedDragNode;
    
    // 현재 노드와 선택 노드 유무 확인
    if (isNotEmpty(node) && isNotEmpty(selNode)) {
        // 아이디가 같은지 확인(기본 노드 연결 안됨)
        if (node.name != selNode.name ) {
            // 현재 노드 위치 복구
            diagram._updateNode(node.name, {offsetX: node.addInfo.oldOffSetX, offsetY: node.addInfo.oldOffSetY});
            
            // 조합 필터 노드 생성
            addSegmentFilterCombiNode(node, selNode);
         }
    }
    
}

// 세그먼트 조합필터 노드 추가
function addSegmentFilterCombiNode(nowNode, selNode) {
    console.log("addSegmentFilterCombiNode");
    // 선택된 노드가 있을경우
    if (isNotEmpty(nowNode) && isNotEmpty(selNode)) {
        // node 생성
        var node = {};
        node.name = $.ifvmGetRowID();
        node.borderWidth = 0;
        node.offsetX = Math.round((Number(selNode.offsetX) + Number(nowNode.addInfo.oldOffSetX)) / 2);
        node.offsetY = Number(nowNode.addInfo.oldOffSetY) >= Number(selNode.offsetY) ? Number(nowNode.addInfo.oldOffSetY) + 100 : Number(selNode.offsetY) + 100;
        node.ports = getDefaultPort();
            
        // NodeDataClass 생성
        var nodeData = new NodeDataClass();
        nodeData.nodeId = node.name;
        nodeData.htmlTemplateId = "segmentNodeTemplate";
        nodeData.nodeDataStatus = "I";
        

        
        nodeData.data = {
                segFilterId : node.name,
                filterCount : "0",
                dataStatus : "I",
                segmentId: segment.segmentId,
                logicalCompId: segment.logicalCompId,
                combFilterAId: nowNode.name,
                combFilterBId: selNode.name
        }
        
        nodeData.nodeType = "C";
        var colType = "C";
        
        // 어트리뷰트 그룹 컬럼 유형; D: dimension, M: Measure, C: "Combination"
        nodeData.attributeType = "attribute_combi";
        
        node.addInfo = nodeData;
        
        // 노드 생성
        renderNode(node);
        
        // 커넥터 생성
        createNextConnector(nowNode.name, node.name);
        createNextConnector(selNode.name, node.name);
        
        // 신규 노드 선택
        selectionNode(node.name);
        
        // 세그먼트 필터 조합 팝업 열기
        segmentFilterCombiPopOpen(node.name);
    }
}

// 커넥터 생성
function createNextConnector(sourceNode, targetNode) {
    console.log("createNextConnector");
    var connector = {
            name: $.ifvmGetRowID(),
            sourceNode: sourceNode,
            targetNode: targetNode
    }
    
    diagram.add(connector);
}

// 메뉴 오픈 확인
function checkContextMenuOpen(args) {
    console.log("checkContextMenuOpen");
    var flag = false;
    var selNode = diagram.selectionList[0];
    if (selNode._type != "node") {
        flag = true;
    } else {
        var node = diagram.selectionList[0];
        if (node._type == "node") {
            if (selNode.addInfo.nodeType == "A") {
                segmentContextMenu.disableItemByID("MENU_filterEdit");
                segmentContextMenu.disableItemByID("MENU_remove");
            } else {
                segmentContextMenu.enableItemByID("MENU_filterEdit");
                if (node.outEdges.length > 0) {
                    segmentContextMenu.disableItemByID("MENU_remove");
                } else {
                    segmentContextMenu.enableItemByID("MENU_remove");
                }
            }
            
        }
    }

    return flag;
}

// 메뉴 클릭시
function segContextMenuClick(args) {
    console.log("segContextMenuClick");
    var selNode = diagram._selectedObject;
    
    switch (args.ID) {
    // 필터 수정
    case "MENU_filterEdit":
        if (selNode.nodeType != "A") {
            if (isNotEmpty(selNode.data.combFilterAId)) {
                // 필터 조합 설정 팝업 열기
                segmentFilterCombiPopOpen(selNode.nodeId);
            } else {
                // 세그먼트 필터 설정 팝업 열기
                segmentFilterSetPopOpen(selNode.nodeId);
            }
        }
        
        break;
    //새로고침
    case "MENU_filterReset":
        //새로고침
    	resetSegmentFilterCount(selNode.nodeId);
        
        break;
    //SQL 확인
    case "MENU_filterSql":
        //필터 sql 팝업 열기
        filterSqlPopupOpen(selNode);
        
        break; 
    // 삭제
    case "MENU_remove":
        if (confirm(MESSAGE.common.removeConfirm)) {
            // 다이어그램일 경우
            if (diagramType == "SEG") {
                if (selNode.nodeType != "A") {
                    removeSegmentNode(args);
                }
            } else {
                diagram.remove();
            }
        }
        
        break;
    // 타겟 그룹 생성
    case "MENU_targtGroup":
        //타겟그룹 생성 팝업 열기
        targetGroupNewPopupOpen();
        
        break;    

	//고객 세분화 룰 생성(고객 세그먼트 관리)
	 case "MENU_custSegRule":
        //타겟그룹 생성 팝업 열기(임시 수정필요)
        custSegmentRulePopupOpen();
        
        break;    

    default:
        return;
    }
}

// 세그먼트 노드 삭제시
function removeSegmentNode(args) {
    console.log("removeSegmentNode");
    var node = diagram.selectionList[0];
    if (node._type == "node") {
        if (node.outEdges.length > 0) {
            alert(MESSAGE.kepler.segment.error_MSG_S0001);
        } else {
            diagram.remove();
            removeFilter(node.addInfo.data);
        }
    }
}


/* Segment End */


/* syncfusion customizing Start */
function bringToFront() {
    console.log("bringToFront");
    var n = diagram.selectionList[0],
        u, t;
    if (n && n.type != "pseudoGroup") {
        var e = diagram._findOverlapNode(n),
            i = diagram._sortByZIndex(e),
            f = n.zOrder,
            r = n.zOrder;
        for (t = 0; t < i.length; t++) i[t].zOrder > r && (r = i[t].zOrder, u = i[t]);
        u && (_bringElementsToFront(f, r, n, u), diagram.addHistoryEntry({
            type: "zOrder",
            command: "front",
            start: r,
            end: f,
            nearestNode: i[t - 1],
            object: n,
            category: "internal"
        }));
    }
}

function _bringElementsToFront(n, t, i, r) {
    console.log("_bringElementsToFront");
    for (var f, u = n + 1; u <= t; u++) {
    	if (i.parent != "") {
    		var nodeItem = diagram._findObjectByIndex(u, !0);
    		if (isNotEmpty(nodeItem)) {
    			nodeItem.zOrder -= 1;
    		}
    	} else {
    		var nodeItem = diagram._findObjectByIndex(u); 
    		if (isNotEmpty(nodeItem)) {
    			nodeItem.zOrder -= 1;
    		}
    	}
    }
    i.parent ? (f = diagram.nameTable[i.parent], diagram._findChildren(f, i.name).zOrder = t) : diagram._findObjectByName(i.name).zOrder = t;
    diagram._svg.getElementById(r.name).parentNode.insertBefore(diagram._svg.getElementById(i.name), diagram._svg.getElementById(r.name).nextSibling);
    diagram._updateSelectionHandle();
}
/* syncfusion customizing End */
