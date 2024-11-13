/*!
 * Diagram Methods
 * Copyright dg.ryu
 * v1.0.0
 */

var cDialog;
var userHandles = [];
var diagramType;

function keplerDiagramMethods() {
    
}

keplerDiagramMethods.prototype = {

     showHandles : function(args, flag) {
        //handler diaplay 설정
        //console.log("ShowHandles");
        var handles = KPRDiagram.model.selectedItems.userHandles;
        for (var i = 0; i < handles.length; i++) {
            handles[i].visible = false;
            
            if (args.elementType == "node" && diagramType == "LGC_COMP" && handles[i].name != "JoinSet") {
                handles[i].visible = true;
            }
            
            if (args.elementType == "connector" && diagramType == "LGC_COMP" && handles[i].name == "JoinSet") {
                handles[i].visible = true;
            }
        }
    },
    
    // 핸들 생성
    createUserHandles : function() {
        
        var _this = this;
        
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
                node = this.KPRDiagram.selectionList[0];
                this._currentPossibleConnection = node;
                // this._possibleConnectionPort = node.ports[0];
                base.prototype.mousedown.call(this, evt);
                this._showAllPorts();
                this.KPRDiagram.addSelection(node);
                this._sourcePossibleConnection = node;
                targetNode = null;
            };
    
            LinkTool.prototype.mouseup = function (evt) {
                
                // 대상노드 확인
                if ($.fn.ifvmIsNotEmpty(this._targetPossibleConnection)) {
                    targetNode = this._targetPossibleConnection.name;
                }
                
                this.KPRDiagram._updateEdges(this);
                this._showAllPorts(true);
                base.prototype.mouseup.call(this, evt);
                
                if (targetNode) {
                    
                    var flag = true;
                    // 로지컬 컴포넌트일경우
                    if (diagramType == "LGC_COMP") {
                        // 커넥션 설정
                        flag = _this.setLgcCompAddSelection(node, KPRDiagram.getNode(targetNode));
                    }
                    
                    if (flag) {
                        // 대상 노드 연결
                        this.KPRDiagram.addSelection(targetNode);
                    
                        // node data class 생성
                        var connectorName = this.KPRDiagram.selectionList[0].children[0];
                        var connector = KPRDiagram.getNode(connectorName);
                        // 유형: 커넥터, addInfo 설정 X
                        if (connector.type=="connector" && $.fn.ifvmIsEmpty(connector.addInfo)) {
                            var nodeData = new keplerNodeDataClass();
                            nodeData.nodeId = connectorName;
                            nodeData.nodeType = "connector";
                            connector.addInfo = nodeData;
                        }
                    } else {
                        // 커넥터 삭제
                        if (KPRDiagram.selectionList[0]._type != "node")
                            this.KPRDiagram.remove();
                    }
                } else {
                    // 대상 노드 없을 경우 커넥터 삭제
                    if (KPRDiagram.selectionList[0]._type != "node")
                        this.KPRDiagram.remove();
                }
                
                this.KPRDiagram._clearSelection();
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
                setTableNodeDetailPopup(KPRDiagram.selectionList[0].addInfo.nodeId); // function -> logicalComponentJoin.jsp
                
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
             		    leftTblNode : KPRDiagram.getNode(KPRDiagram.selectionList[0].sourceNode)
             		  , rightTblNode : KPRDiagram.getNode(KPRDiagram.selectionList[0].targetNode)
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
        
        return userHandles;
    },
    
    // KPRDiagram size 설정
    setDiagramSize : function(showpropeditor) {
        var width = $(window).width() - $("#analysis_tree").width();
        $("#main-right").css("width", width);
        
        var pixels = $("#header").outerHeight() + $(".page_btn_area").outerHeight() + $("#analysis_top").outerHeight();
        var screenHeight = $(window).outerHeight();
        var height = screenHeight  - pixels-60;
        $(".dashboard_wrap").css("height", height);
        
        if ($.fn.ifvmIsNotEmpty(KPRDiagram)) {
            KPRDiagram.updateViewPort();
        }
    },
    
    // drop 노드 추가
    addDropNode : function(args) {
        var _this = this;
        if (diagramType == "SEG") {
            _this.addSegmentNode(args);
        } else {
            _this.addLogicalComponentNode(args);
        }
    },
    
    // html node 렌더 (edit:2016.01.04)
    renderNode : function(node){
        var _this = this;
        var addInfo = node.addInfo;
        
        // 노드 Data의 htmlTemplateId 가지고 있을 경우만 html node 렌더
        // 아래 node처럼 강제로 html 생성시 ie에서는 보이지 않는현상이 발생
        // KPRDiagram html shape node 생성 후 해당 html안에 template 생성후 교체함
        if ($.fn.ifvmIsNotEmpty(addInfo.htmlTemplateId)) {
            var itemSet = { 
                name: node.name,
                type: ej.datavisualization.Diagram.Shapes.Html,
                templateId : addInfo.htmlTemplateId,
                borderWidth: node.borderWidth,
                // minWidth: "250", maxWidth: "300", maxHeight: "200",
                labels: [{ readOnly: true, offset: {x: 0.5, y:1} }],
                constraints : _this.getNodeConstraints(),
                offsetX: node.offsetX, offsetY: node.offsetY,
                addInfo: addInfo,
                ports: node.ports
            };
            
            KPRDiagram.add(itemSet);
            
            var addNode = KPRDiagram.getNode(node.name);
            var width = $('#' + addNode.addInfo.nodeId + addNode.addInfo._Suffix).width()+5;
            var height = $('#' + addNode.addInfo.nodeId + addNode.addInfo._Suffix).height()+5;
            var option = {width: width, height: height };
            
            KPRDiagram.updateNode(node.name, option);
            
            $('#' + node.name + "_html").mouseenter(function(args){
                //console.log("OnMouseenter : " + node.name );
                KPRDiagram._selectedNode = KPRDiagram.getNode(node.name);
            })
            
            $('#' + node.name + "_html").mouseleave(function(args){
                //console.log("OnMouseleave : " + node.name );
                KPRDiagram._selectedNode = {};
            })
            
            //노드 위에 노드를 드랍할때 이벤트를 얻기 위해 사용
            //jquery ui 
            $('#' + node.name + "_html").draggable();
            $('#' + node.name + "_html").droppable({
                drop: function( event, ui ) {
                    //console.log("nodeOnNode : " + node.name );
                    KPRDiagram._selectedNode = KPRDiagram.getNode(node.name);
                    
                    if (diagramType == "SEG") {
                        _this.segNodeDragCompleted();
                    }
                }
            });
            
            //set tooltip
            if (diagramType == "SEG" || diagramType =="TGT_GROUP") {
                $('#' + node.name + "_html").hover(function(){
                    // Hover over code
                    var html = $('#' + node.name + "_html #attribute").clone();
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
            
            KPRDiagram._clearSelection();
        }
    },
    
    //전체 노드 노드 위에 노드를 드랍할때 이벤트 얻기 위해 사용
    setDroppableEvent : function() {
        var _this = this;
        
        $.each(KPRDiagram.nodes(), function(index, node) {
            $('#' + node.name + "_html").mouseenter(function(args){
                //console.log("OnMouseenter : " + node.name );
                KPRDiagram._selectedNode = node;
            })
            
            $('#' + node.name + "_html").mouseleave(function(args){
                //console.log("OnMouseleave : " + node.name );
                KPRDiagram._selectedNode = {};
            })
            
            
            $('#' + node.name + "_html").draggable();
            $('#' + node.name + "_html").droppable({
                drop: function( event, ui ) {
                    //console.log("nodeOnNode : " + node.name );
                    KPRDiagram._selectedNode = node;
                    
                    if (diagramType == "SEG") {
                        _this.segNodeDragCompleted();
                    }
                }
            });
        });
    },
    
    // 선택 노드 선색 설정
    setSelectedNode : function(args, type) {
        $.each(KPRDiagram.nodes(), function(index, item) {
            if ($.fn.ifvmIsNotEmpty(item._type) && item._type == "node") {
                // 선택 해제
                $('#' + item.name + item.addInfo._Suffix).css('border', '');
            }
            
            $('#' + item.name + '_html').css('z-index', '0');
        });
        
        $.each(args.selectedItems, function(index, item) {
            if ($.fn.ifvmIsNotEmpty(item._type) && item._type == "node") {
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
    },
    
    // 조인연결 설정
    setConnectJoin : function(args) {
        if (args.newItems.length == 1 && args.oldItems.length) {
            if (args.newItems[0]._type == "node" && args.oldItems[0]._type == "node") {
                
                var name = $.ifvmGetRowID();
                var nodeData = new keplerNodeDataClass();
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
                
                KPRDiagram.add(node);
            }
        }
    },
    
    // set nodeDataClass
    setNewNodeDataClass : function(data) {
        var nodeData = new keplerNodeDataClass();
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
        nodeData.connectSeq = $.fn.ifvmStringToNumber(data.connectSeq);
        
        $.each(data.handleList, function(index, handle) {
            nodeData.handleList.push(handle);
        });
        
        return nodeData;
    },
    
    // shape 생성
    createIntelligentShape : function(name, fNode) {
        var _this = this;
        
        var node = {};
        node.ports = [];
        node.ports.push(_this.createPort(name, .5, .5));
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
            
            var nodeData = new keplerNodeDataClass();
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
    },
    
    // 연결 순서에 따른 source node 찾기
    getConnectSourceNode : function(fnode){
    	var tSeq = fnode.addInfo.connectSeq;
    	var rNode = {};
    	for (var i=1; i < tSeq; i++) {
    		$.each(KPRDiagram.nodes(), function(index, node) {
    			if (node.addInfo.connectSeq == tSeq-i) {
    				rNode = node;
    				
    				return false;
    			}
    		});
    		
    		if ($.fn.ifvmIsNotEmpty(rNode)) {
    			break;
    		}
    	}
    	
    	return rNode;
    },
    
    // source node의 out connectors 설정
    setConnectSourceNodeOutEdges : function(fNode) {
        var _this = this;
        
    	$.each(fNode.outEdges, function(index, edge) {
    		var connector = KPRDiagram.getNode(edge);
    		
    		if ($.fn.ifvmIsNotEmpty(connector) && $.fn.ifvmIsNotEmpty(connector.targetNode)) {
    			var targetNode = KPRDiagram.getNode(connector.targetNode);
    			var newSourceNode = _this.getConnectSourceNode(targetNode);
    			
    			if ($.fn.ifvmIsNotEmpty(newSourceNode)) {
    				var sourceNode = newSourceNode.name;
    				connector.sourceNode = sourceNode;
    				KPRDiagram.updateConnector(connector.name, { sourceNode: sourceNode });
    			}
    		}
    	});
    },
    
    // diagram에서 node 찾기
    findNode : function(name){
        return KPRDiagram.getNode(name);
    },
    
    // diagram에서 node 찾기
    findNodeByNodeType : function(type){
    	var rNode = [];
    	$.each(KPRDiagram.nodes(), function(index, node) {
    		if (node.addInfo.nodeType == type) {
    			rNode.push(node);
    		}
    	}); 
    	
        return rNode;
    },
    
    // diagram에서 node명으로 node선택
    selectionNode : function(name){
        // 기존 선택 노드 해제
        KPRDiagram._clearSelection();
        
        var node = KPRDiagram.getNode(name);
        // 노드 선택
        KPRDiagram.addSelection(node);
    },
    
    // diagram에서 connector 찾기
    findConnector : function(name){
        var rtnConnector = null;
        $.each(KPRDiagram.connectors(), function(index, connector) { 
           if(connector.name === name) {
               rtnConnector = connector;
           }
        });
        
        return rtnConnector;
    },
    
    // KPRDiagram json data 반환
    getDiagramData : function(){
        var diagramData = KPRDiagram.save();
        
        return JSON.stringify(diagramData);
    },
    
    // json data를 diagram에 셋팅
    setDiagramData : function(data){
        KPRDiagram.load(JSON.parse(data));
    
        $.each(KPRDiagram.nodes(), function(index, node) {
            var nodeData = new keplerNodeDataClass();
            nodeData.setData(node.addInfo);
            node.addInfo = nodeData;
            setDropOnNode(node);
        });
    },
    
    // 포트 생성
    createPort : function(name, x, y) {
        var port = { name: name + ej.datavisualization.Diagram.Util.randomId(), offset: { x: x, y: y } };
        return port;
    },
    
    // node Constraints 추출
    getNodeConstraints : function() {
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
    },
    
    // connector Constraints 추출
    getConnectorConstraints : function() {
        
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
    },
    
    // 기본 포트 추출
    getDefaultPort : function(name) {
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
    },
    
    // KPRDiagram 초기화
    setDiagramClear : function() {
        KPRDiagram.clear();
    },
    
    // get nodes By nodeType
    getNodesByNodeType : function(node, type) {
        var _this = this;
        
    	var nodes = [];
    	if ($.fn.ifvmIsNotEmpty(node)) {
    		var parentNodes = _this.getParentNodesByNodeType(node, type);
    	    var childNodes = _this.getChildNodesByNodeType(node, type);
    	    nodes = $.merge(parentNodes, childNodes);
    	    
    	    if (node.addInfo.nodeType == type) {
    	    	nodes.push(node);
    	    }
    	}
        
    	return nodes;
    },
    
    // get parent nodes By nodeType
    getParentNodesByNodeType : function(node, type) {
        var _this = this;
        
    	var nodes = [];
    	var chkNodeNames = [];
    	if ($.fn.ifvmIsNotEmpty(node) && $.fn.ifvmIsNotEmpty(node.inEdges)) {
    	    var inEdges = [];
    	    $.each(node.inEdges, function(index, edge) {
    	    	inEdges.push(edge);
        	});
    	    for (var idx = 0; idx < inEdges.length; idx++) {
    	        var connector = _this.findNode(inEdges[idx]);
    	        if ($.fn.ifvmIsNotEmpty(connector)) {
    		        var node = _this.findNode(connector.sourceNode);
    		        if ($.fn.ifvmIsNotEmpty(node)) {
    		        	if (_this.checkNodeNames(chkNodeNames, node.name)) {
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
    },
    
    // get child nodes By nodeType
    getChildNodesByNodeType : function(node, type) {
        var _this = this;
        
        var nodes = [];
        var chkNodeNames = [];
        if ($.fn.ifvmIsNotEmpty(node) && $.fn.ifvmIsNotEmpty(node.outEdges)) {
        	var outEdges = [];
        	$.each(node.outEdges, function(index, edge) {
    	    	outEdges.push(edge);
        	});
    	    for (var idx = 0; idx < outEdges.length; idx++) {
    	        var connector = _this.findNode(outEdges[idx]);
    	        if ($.fn.ifvmIsNotEmpty(connector)) {
    		        var node = _this.findNode(connector.targetNode);
    		        if ($.fn.ifvmIsNotEmpty(node)) {
    		        	if (_this.checkNodeNames(chkNodeNames, node.name)) {
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
    },
    
    //하위 노드 추출
    getChildNode : function(nodeId) {
        var _this = this;
        
        var childNodes = [];
        var nodes = {};
        var len = 0;
        
        if ($.fn.ifvmIsEmpty(nodeId)) {
            nodes = KPRDiagram.selectionList[0];
            len = KPRDiagram.selectionList.length;
        } else {
            nodes = KPRDiagram.getNode(nodeId);
            len = 1;
        }
        //선택 노드가 하나일경우
        if (len == 1 && nodes._type == "node") {
            //연결 커넥터 및 하위 노드 추출
            $.each(nodes.outEdges, function(index, edge) {
                var connector = _this.findNode(edge);
                var node = _this.findNode(connector.targetNode);
                if ($.fn.ifvmIsNotEmpty(node)) {
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
                    childNodes = _this.shiftArray(childNodes, idx, node);
                }
            });
        }
        
        return childNodes;
    },
    
    //배열 삽입
    shiftArray : function(obj, idx, inObj) {
        var cnt = obj.length - idx;
        var sObj = obj.splice(idx, cnt);
        obj.push(inObj);
        $.merge(obj, sObj) 
        
        return obj;
    },
    
    // 노드명이 존재하는지 확인(상위 또는 하위 노드들에 대한 확인 함수의 무한루프를 방지하기 위해 사용)
    checkNodeNames : function(chkNodeNames, nodeName) {
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
    },
    
    
    // 노드 데이터 추출
    // 저장 로직에 의한 제거 될 노드 먼저 추출
    getAllNodeDataClass : function(obj) {
        var items = {};
        var nodeList = [];
        var connectorList = [];
        // get remove nodes
        $.each(obj._removeNodes, function(index, node) {
            if ($.fn.ifvmIsNotEmpty(node.addInfo.nodeId)) {
                node.addInfo.offsetX = node.offsetX;
                node.addInfo.offsetY = node.offsetY;
              
          	    nodeList.push(node.addInfo);
            }
        });
          
        // get nodes
        $.each(obj.nodes(), function(index, node) {
            if ($.fn.ifvmIsNotEmpty(node.addInfo.nodeId)) {
                node.addInfo.offsetX = node.offsetX;
                node.addInfo.offsetY = node.offsetY;
                
                nodeList.push(node.addInfo);
            }
        });
        
        // get remove connector
        $.each(obj._removeConnectors, function(index, connector) {
            if ($.fn.ifvmIsNotEmpty(connector.addInfo.nodeId)) {
                var sourceNode = "";
                if ($.fn.ifvmIsNotEmpty(connector.sourceNode)) {
                    sourceNode = connector.sourceNode;
                }
                var targetNode = "";
                if ($.fn.ifvmIsNotEmpty(connector.targetNode)) {
                    targetNode = connector.targetNode;
                }
                
                connector.addInfo.sourceNode = sourceNode;
                connector.addInfo.targetNode = targetNode;
              
                connectorList.push(connector.addInfo);
            }
        });
          
        // get connector
        $.each(obj.connectors(), function(index, connector) {
            if ($.fn.ifvmIsNotEmpty(connector)) {
                var sourceNode = "";
                if ($.fn.ifvmIsNotEmpty(connector.sourceNode)) {
                    sourceNode = connector.sourceNode;
                }
                var targetNode = "";
                if ($.fn.ifvmIsNotEmpty(connector.targetNode)) {
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
    },
    
    // 전체 노드 및 커넥터 추출 반환 Task 저장을 위한
    getNodesAndConnectors : function(obj) {
        var items = {};
        var nodeList = [];
        var connectorList = [];
        
        // 노드 추출
        $.each(obj.nodes(), function(index, node) {
            if ($.fn.ifvmIsNotEmpty(node.addInfo.nodeId)) {
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
            if ($.fn.ifvmIsNotEmpty(connector.addInfo.nodeId)) {
                var sourceNode = "";
                if ($.fn.ifvmIsNotEmpty(connector.sourceNode)) {
                    sourceNode = connector.sourceNode;
                }
                var targetNode = "";
                if ($.fn.ifvmIsNotEmpty(connector.targetNode)) {
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
        //console.log(items);
        
        return items;
    },
    
    /**
     * 노드 데이터 추출 selectNode: 선택노드 obj nodeType: 노드유형 dataKey: addInfo.data 에 속에 있는
     * key명 dataKey 없을경우 addInfo.data 반환
     */
    getNodeDataByNodeType : function(selectNode, nodeType, dataKey) {
        var _this = this;
        
        var rtnVal;
        var node = _this.getNodesByNodeType(selectNode, nodeType);
        if (node.length > 0) {
            node = node[0];
            if ($.fn.ifvmIsNotEmpty(node) && $.fn.ifvmIsNotEmpty(node.addInfo) && $.fn.ifvmIsNotEmpty(node.addInfo.data)) {
                var data = node.addInfo.data;
                if ($.fn.ifvmIsNotEmpty(dataKey)) {
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
    },
    
    // 선택 노드 삭제
    removeSelectedNodes : function(args) {
        var _this = this;
        
        if (diagramType == "SEG") {
            _this.removeSegmentNode(args);
        } else if (diagramType == "LGC_COMP") {
        	removeLgcCompNodeByDeleteKey(args);
        }
    },
    
    // 추가 되는 노드 확인
    checkAddNode : function(args) {
        var _this = this;
        
    	if ($.fn.ifvmIsNotEmpty(args.element) && $.fn.ifvmIsNotEmpty(args.element.addInfo)) {
    		var node = args.element.addInfo;
    		// info 노드가 하나 이상이라면 || 채널 유형은 한개만 추가 할 수 있다.
    		if (_this.findNodeByNodeType(node.nodeType).length >= 1 || !checkChnlTypeOnlyOne(node.nodeType)) {
    			alert(MESSAGE.campaign.onlyOneNodeCanBeAdded);
    			
    			// 노드를 취소한다.
    			args.cancel = true;
    			
    			return false;
    		}
    	}
    	
    	return true;
    },
    
    // 피로도제외 여부
    getFatigueExcept : function() {
        var _this = this;
        
    	var rstValue = false;
    	if (_this.findNodeByNodeType("INFO").length != 0) {
    		var node = _this.findNodeByNodeType("INFO")[0].addInfo;
    		if ($.fn.ifvmIsNotEmpty(node.data) && $.fn.ifvmIsNotEmpty(node.data.campaignDefaultInfo)) {
    			var fatigueExceptYn = node.data.campaignDefaultInfo.fatigueExceptYn;
    			
    			if (fatigueExceptYn == "true") {
    				rstValue = true;
    			}
    		}
    	}
    	
    	return rstValue;
    },
    
    // 팝업 폼 모든 객체 Disabled
    setPopupFormAllDisabled : function(id) {
    	$("#" + id + " select").attr('disabled',true);
    	$("#" + id + " input").attr('disabled',true);
    	$("#" + id + " textarea").attr('disabled',true);
    	$("#" + id + " .input-group-addon").remove();
    	
    	$.each($("#" + id + " button"), function(index, btn) {
    		if(!(btn.className.match("cancel"))) {
    			btn.setAttribute('disabled',true);
    		}
    	});
    },
    
    // 템플릿 사용/해제 버튼 text 설정
    setCampaignWorkflowTempUseBtn : function(flag) {
    	
    	// 버튼 활성
    	$("#campaignWorkflowTempUseBtn").attr('disabled',false);
    	
    	if (flag == "1") {
    		// 템플릿 해제
    		$("#campaignWorkflowTempUseBtnText").text(TXTCancelTemplate);
    	} else {
    		// 템플릿 사용
    		$("#campaignWorkflowTempUseBtnText").text(TXTUseAsTemplate);
    	}
    },
    
    /* logical Component Start */
    //로지컬 컴포넌트 노드 추가
    addLogicalComponentNode : function(args) {
    	addJoinTableRelNode(args); // function -> logicalComponentJoin.jsp
    },
    
    //커넥터 연결시 이벤트
    //return true: 커넥터 생성, false: 취소
    setLgcCompAddSelection : function(sourceNode, targetNode) {
    	var flag = true;
    	var reqData = {
    		    leftTblNode : sourceNode
    		  , rightTblNode : targetNode
    		  , popType : "NEW"
    	}
    	 
    	return setJoinSettingPop(reqData);
    },
    
    //클릭 설정
    setLgcCompClick : function(args) {
    /*
      * if (args.elementType == "connector"){ var reqData = { leftTblNode :
      * KPRDiagram.getNode(args.element.sourceNode) , rightTblNode :
      * KPRDiagram.getNode(args.element.targetNode) } setJoinSettingPop(reqData); }
      */
    },
    
    //더블클릭 설정
    setLgcCompDoubleClick : function(args) {
     if (args.elementType == "connector"){
     	var reqData = {
     		    leftTblNode : KPRDiagram.getNode(args.element.sourceNode)
     		  , rightTblNode : KPRDiagram.getNode(args.element.targetNode)
     		  , popType : "MODIFY"
     	   }
     	setJoinSettingPop(reqData);
     }
    },
    
    // 아이템 클릭시
    setLgcCompItemeClick : function(args) {
        
    },
    
    
    /* logical Component End */
    
    
    /* Segment Start */
    
    // 세그먼트 노드 추가
    addSegmentNode : function(args) {
        var _this = this;
        
        var selNode = KPRDiagram._selectedNode;
        
        // 선택된 노드가 있을경우
        if ($.fn.ifvmIsNotEmpty(selNode)) {
            // node 생성
            var node = {};
            node.name = $.ifvmGetRowID();
            node.borderWidth = 0;
            node.offsetX = selNode.offsetX;
            node.offsetY = selNode.offsetY + 100;
            node.ports = _this.getDefaultPort();
                
            // NodeDataClass 생성
            var nodeData = new keplerNodeDataClass();
            nodeData.nodeId = node.name;
            nodeData.htmlTemplateId = "segmentNodeTemplate";
            nodeData.nodeDataStatus = "I";
            
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
            _this.renderNode(node);
            
            // 커넥터 생성
            _this.createNextConnector(selNode.name, node.name);
            
            // 신규 노드 선택
            _this.selectionNode(node.name);
            
            // 세그먼트 필터 설정 팝업 열기
            segmentFilterSetPopOpen(atribGroupColId);
        }
    },
    
    // 세그먼트 노드 드래그 완료시
    segNodeDragCompleted : function(args) {
        var _this = this;
        
        //var node = args.element;
        var selNode = KPRDiagram._selectedNode;
        
        var node = KPRDiagram._selectedDragNode;
        
        // 현재 노드와 선택 노드 유무 확인
        if ($.fn.ifvmIsNotEmpty(node) && $.fn.ifvmIsNotEmpty(selNode)) {
            // 아이디가 같은지 확인(기본 노드 연결 안됨)
            if (node.name != selNode.name ) {
                // 현재 노드 위치 복구
                KPRDiagram._updateNode(node.name, {offsetX: node.addInfo.oldOffSetX, offsetY: node.addInfo.oldOffSetY});
                
                // 조합 필터 노드 생성
                _this.addSegmentFilterCombiNode(node, selNode);
            }
        }
    },
    
    // 세그먼트 조합필터 노드 추가
    addSegmentFilterCombiNode : function(nowNode, selNode) {
        var _this = this; 
        
        // 선택된 노드가 있을경우
        if ($.fn.ifvmIsNotEmpty(nowNode) && $.fn.ifvmIsNotEmpty(selNode)) {
            // node 생성
            var node = {};
            node.name = $.ifvmGetRowID();
            node.borderWidth = 0;
            node.offsetX = Math.round((selNode.offsetX + nowNode.addInfo.oldOffSetX) / 2);
            node.offsetY = nowNode.addInfo.oldOffSetY >= selNode.offsetY ? nowNode.addInfo.oldOffSetY + 100 : selNode.offsetY + 100;
            node.ports = _this.getDefaultPort();
                
            // NodeDataClass 생성
            var nodeData = new keplerNodeDataClass();
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
            _this.renderNode(node);
            
            // 커넥터 생성
            _this.createNextConnector(nowNode.name, node.name);
            _this.createNextConnector(selNode.name, node.name);
            
            // 신규 노드 선택
            _this.selectionNode(node.name);
            
            // 세그먼트 필터 조합 팝업 열기
            segmentFilterCombiPopOpen(node.name);
        }
    },
    
    // 커넥터 생성
    createNextConnector : function(sourceNode, targetNode) {
        var connector = {
                name: $.ifvmGetRowID(),
                sourceNode: sourceNode,
                targetNode: targetNode
        }
        
        KPRDiagram.add(connector);
    },
    
    // 메뉴 오픈 확인
    checkContextMenuOpen : function(args) {
        var flag = false;
        var selNode = KPRDiagram.selectionList[0];
        if (selNode._type != "node") {
            flag = true;
        } else {
            var node = KPRDiagram.selectionList[0];
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
    },
    
    // 메뉴 클릭시
    segContextMenuClick : function(args) {
        var _this = this;
        
        var selNode = KPRDiagram._selectedObject;
        
        switch (args.ID) {
        // 필터 수정
        case "MENU_filterEdit":
            if (selNode.nodeType != "A") {
                if ($.fn.ifvmIsNotEmpty(selNode.data.combFilterAId)) {
                    // 필터 조합 설정 팝업 열기
                    segmentFilterCombiPopOpen(selNode.nodeId);
                } else {
                    // 세그먼트 필터 설정 팝업 열기
                    segmentFilterSetPopOpen(selNode.nodeId);
                }
            }
            
            break;
            // 타겟 그룹 생성
        case "MENU_filterReset":
            //필터 sql 팝업 열기
        	resetSegmentFilterCount(selNode.nodeId);
            
            break;   
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
                        _this.removeSegmentNode(args);
                    }
                } else {
                    KPRDiagram.remove();
                }
            }
            
            break;
        // 타겟 그룹 생성
        case "MENU_targtGroup":
            //타겟그룹 생성 팝업 열기
            targetGroupNewPopupOpen();
            
            break;    
        default:
            return;
        }
    },
    
    // 세그먼트 노드 삭제시
    removeSegmentNode : function(args) {
        var node = KPRDiagram.selectionList[0];
        if (node._type == "node") {
            if (node.outEdges.length > 0) {
                alert(MESSAGE.kepler.segment.error_MSG_S0001);
            } else {
                KPRDiagram.remove();
                removeFilter(node.addInfo.data);
            }
        }
    },
    
    
    /* Segment End */
    
    
    /* syncfusion customizing Start */
    bringToFront : function() {
        var _this = this;
        
        var n = KPRDiagram.selectionList[0],
            u, t;
        if (n && n.type != "pseudoGroup") {
            var e = KPRDiagram._findOverlapNode(n),
                i = KPRDiagram._sortByZIndex(e),
                f = n.zOrder,
                r = n.zOrder;
            for (t = 0; t < i.length; t++) i[t].zOrder > r && (r = i[t].zOrder, u = i[t]);
            u && (_this._bringElementsToFront(f, r, n, u), KPRDiagram.addHistoryEntry({
                type: "zOrder",
                command: "front",
                start: r,
                end: f,
                nearestNode: i[t - 1],
                object: n,
                category: "internal"
            }));
        }
    },
    
    _bringElementsToFront : function(n, t, i, r) {
        for (var f, u = n + 1; u <= t; u++) {
        	if (i.parent != "") {
        		if ($.fn.ifvmIsNotEmpty(KPRDiagram._findObjectByIndex(u, !0))) {
        			KPRDiagram._findObjectByIndex(u, !0).zOrder -= 1;
        		}
        	} else {
        		if ($.fn.ifvmIsNotEmpty(KPRDiagram._findObjectByIndex(u))) {
        			KPRDiagram._findObjectByIndex(u).zOrder -= 1;
        		}
        	}
        	// i.parent != "" ? _findObjectByIndex(u, !0).zOrder -= 1 :
            // _findObjectByIndex(u).zOrder -= 1;
        }
        i.parent ? (f = KPRDiagram.nameTable[i.parent], KPRDiagram._findChildren(f, i.name).zOrder = t) : KPRDiagram._findObjectByName(i.name).zOrder = t;
        KPRDiagram._svg.getElementById(r.name).parentNode.insertBefore(KPRDiagram._svg.getElementById(i.name), KPRDiagram._svg.getElementById(r.name).nextSibling);
        KPRDiagram._updateSelectionHandle();
    }
}
/* syncfusion customizing End */
