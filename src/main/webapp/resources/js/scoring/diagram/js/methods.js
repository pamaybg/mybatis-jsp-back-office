/*!
 * Diagram Methods
 * Copyright dg.ryu
 * v1.0.0
 */

var cDialog;

//handler diaplay 설정
function ShowHandles(diagram, args, flag) {
    //console.log("ShowHandles");
    var handles = diagram.model.selectedItems.userHandles;
    for (var i = 0; i < handles.length; i++) {
        handles[i].visible = false;
    }

    if (args.elementType == "node" ) {
        setUserHandles(args.element.addInfo.handleList);
    } else {
    	setTimeout(function(){
    		$("#diagram_canvas_svg_adorneruserHandle_g").remove();
    	}, 100);
    }
}

//선택 노드 선색 설정
function setSelectedNode(args, type) {
	$.each(args.oldItems, function(index, item) {
		if (isNotEmpty(item._type) && item._type == "node") {
			//선택 해제
			$('#' + item.name + item.addInfo._Suffix + ' .box_normal').css('border-color', '#cccccc');
		}
	});

	$.each(args.selectedItems, function(index, item) {
		if (isNotEmpty(item._type) && item._type == "node") {
			//선택
			$('#' + item.name + item.addInfo._Suffix + ' .box_normal').css('border-color', '#55a9d0');
		}
	});
}

//handler 초기화
function createUserHandles() {
    var userHandles = [];
    //핸들 tool 설정
    var SettingTool = (function (base) {
        ej.datavisualization.Diagram.extend(SettingTool, base);
        function SettingTool(name) {
            base.call(this, name);
            this.singleAction = true;
            this.cursor = "pointer";
            this.method = '';
            this.methodType = '';
        }
        SettingTool.prototype.mouseup = function (evt) {
            //핸들 클릭시
            if(this.diagram._selectedObject){
            	//메서드 실행
            	OnMethods(this.diagram._selectedObject, this);
            }

            base.prototype.mouseup.call(this, evt);
        };

        return SettingTool;
    })(ej.datavisualization.Diagram.ToolBase);


    //최초 8방위 모두 기본 핸들을 생성한다.
    var UserHandlePositions = ["topleft", "topcenter", "topright", "middleleft", "middleright", "bottomleft", "bottomcenter", "bottomright"];
    for (var i=0; i < 8; i++) {
        var settingTool = ej.datavisualization.Diagram.UserHandle();
        var name = UserHandlePositions[i];
        settingTool.name = name;
        settingTool.position = UserHandlePositions[i];
        settingTool.visible = false;

        settingTool.tool = new SettingTool(name);
        settingTool.size = 30;
        settingTool.backgroundColor = "#4D4D4D";
        settingTool.enableMultiSelection = false;
        settingTool.pathData = "M22.0542,27.332C20.4002,27.332,19.0562,25.987,19.0562,24.333C19.0562,22.678,20.4002,21.333,22.0542,21.333C23.7082,21.333,25.0562,22.678,25.0562,24.333C25.0562,25.987,23.7082,27.332,22.0542,27.332 M30.6282,22.889L28.3522,22.889C28.1912,22.183,27.9142,21.516,27.5272,20.905L29.1392,19.293C29.3062,19.126,29.3062,18.853,29.1392,18.687L27.7032,17.251C27.6232,17.173,27.5152,17.125,27.3982,17.125C27.2862,17.125,27.1782,17.173,27.0952,17.251L25.4872,18.863C24.8732,18.476,24.2082,18.201,23.5002,18.038L23.5002,15.762C23.5002,15.525,23.3092,15.333,23.0732,15.333L21.0422,15.333C20.8062,15.333,20.6122,15.525,20.6122,15.762L20.6122,18.038C19.9072,18.201,19.2412,18.476,18.6292,18.863L17.0192,17.252C16.9342,17.168,16.8242,17.128,16.7162,17.128C16.6052,17.128,16.4972,17.168,16.4112,17.252L14.9752,18.687C14.8952,18.768,14.8492,18.878,14.8492,18.99C14.8492,19.104,14.8952,19.216,14.9752,19.293L16.5872,20.905C16.2002,21.516,15.9242,22.183,15.7642,22.889L13.4852,22.889C13.2502,22.889,13.0572,23.08,13.0572,23.316L13.0572,25.35C13.0572,25.584,13.2502,25.777,13.4852,25.777L15.7612,25.777C15.9242,26.486,16.2002,27.15,16.5872,27.764L14.9752,29.374C14.8092,29.538,14.8092,29.813,14.9752,29.979L16.4112,31.416C16.4912,31.494,16.6022,31.541,16.7162,31.541C16.8272,31.541,16.9382,31.494,17.0192,31.416L18.6252,29.805C19.2412,30.191,19.9072,30.467,20.6122,30.63L20.6122,32.906C20.6122,33.141,20.8062,33.333,21.0422,33.333L23.0732,33.333C23.3092,33.333,23.5002,33.141,23.5002,32.906L23.5002,30.63C24.2082,30.467,24.8732,30.191,25.4872,29.805L27.0952,31.416C27.1812,31.499,27.2892,31.541,27.3982,31.541C27.5102,31.541,27.6202,31.499,27.7032,31.416L29.1392,29.979C29.2202,29.899,29.2662,29.791,29.2662,29.677C29.2662,29.563,29.2202,29.453,29.1392,29.374L27.5312,27.764C27.9142,27.149,28.1912,26.486,28.3522,25.777L30.6282,25.777C30.8652,25.777,31.0552,25.584,31.0552,25.35L31.0552,23.316C31.0552,23.08,30.8652,22.889,30.6282,22.889";
        userHandles.push(settingTool);
    }

    return userHandles;
}

//handler 설정
function setUserHandles(handleList) {
    if (isNotEmpty(handleList)) {
        $.each(handleList, function(index, handle) {
            var position;
            if (handle.positionTypeCode == "TOP_LEFT") {
                position = ej.datavisualization.Diagram.UserHandlePositions.TopLeft;
            } else if (handle.positionTypeCode == "TOP_CENTER") {
                position = ej.datavisualization.Diagram.UserHandlePositions.TopCenter;
            } else if (handle.positionTypeCode == "TOP_RIGHT") {
                position = ej.datavisualization.Diagram.UserHandlePositions.TopRight;
            } else if (handle.positionTypeCode == "MIDDLE_LEFT") {
                position = ej.datavisualization.Diagram.UserHandlePositions.MiddleLeft;
            } else if (handle.positionTypeCode == "MIDDLE_RIGHT") {
                position = ej.datavisualization.Diagram.UserHandlePositions.MiddleRight;
            } else if (handle.positionTypeCode == "BOTTOM_LEFT") {
                position = ej.datavisualization.Diagram.UserHandlePositions.BottomLeft;
            } else if (handle.positionTypeCode == "BOTTOM_CENTER") {
                position = ej.datavisualization.Diagram.UserHandlePositions.BottomCenter;
            } else if (handle.positionTypeCode == "BOTTOM_RIGHT") {
                position = ej.datavisualization.Diagram.UserHandlePositions.BottomRight;
            } else {
                position = ej.datavisualization.Diagram.UserHandlePositions.TopRight;
            }
            var enableMultiSelection = handle.enableMultiSelection == 0 ? false : true;

            //노드가 가진 해당 위치의 핸들을 찾아 속성 변경 및 핸들 표시
            $.each(diagram.model.selectedItems.userHandles, function(index, userHandle) {
                if (position == userHandle.position) {
                	var fillColor = diagram._selectedObject.fillColor;
                    //name 변경시 오류 발생
                    //userHandle.name = handle.handleName;
                    userHandle.visible = true;
                    userHandle.tool.handleName = handle.handleName;
                    userHandle.tool.method = handle.method;
                    userHandle.tool.methodType = handle.methodTypeCode;
                    userHandle.size = 30;
                    userHandle.backgroundColor = handle.backgroundColor;
                    userHandle.enableMultiSelection = enableMultiSelection;
                    userHandle.pathData = handle.imagePathData;
                    userHandle.description = handle.handleDesc;
                }
            });
        });

	    //set tooltip handles
	    //handle 의 생성후 tooltip 생성
	    setTimeout(function(){
	    	//setImageHandles();
	        $.each(diagram.model.selectedItems.userHandles, function(index, userHandle) {
	             $('#' + userHandle.name + "_shape").hover(function(){
	                // Hover over code
	                var description = userHandle.description;
	                $(this).data('tipText', description).removeAttr('title');
	                $('<p class="tooltip"></p>')
	                .text(description)
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
	        });

	        //update handles
	        if (isNotEmpty(diagram.selectionList[0])) {
	        	diagram.updateUserHandles(diagram.selectionList[0]);
	        }
	    }, 50);

    }
}

//handle 을 이미지로 변환
function setImageHandles() {
	var _svguserHandle = $("#diagram_canvas_svg_adorneruserHandle_g");
	var svguserHandles = [];
	$.each(_svguserHandle.children(), function(index, children) {

		if (children.nodeName == "circle") {
			var foreignObject = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
			foreignObject.setAttribute("id", children.id);
			foreignObject.setAttribute("class", "backrect");//children.getAttribute("class"));
			foreignObject.setAttribute("x", children.getAttribute("cx"));
			foreignObject.setAttribute("y", children.getAttribute("cy"));
			foreignObject.setAttribute("r", children.getAttribute("r"));
			foreignObject.setAttribute("width", "50");
			foreignObject.setAttribute("height", "50");
			foreignObject.setAttribute("fill", "black");//children.getAttribute("fill"));
			foreignObject.setAttribute("stroke", "white");//children.getAttribute("stroke"));
			foreignObject.setAttribute("stroke-width", "0");//children.getAttribute("stroke-width"));
			foreignObject.setAttribute("opacity", "1");
			foreignObject.setAttribute("stroke-dasharray", "");
			foreignObject.setAttribute("title", children.getAttribute("title"));

			svguserHandles.push(foreignObject);
		}

		else if (children.nodeName == "path") {
			var foreignObject = document.createElementNS('http://www.w3.org/2000/svg', 'image');
			foreignObject.setAttribute("id", children.id);
			foreignObject.setAttribute("class", children.getAttribute("class"));
			foreignObject.setAttribute("width", "30");
			foreignObject.setAttribute("height", "30");
			foreignObject.setAttribute("opacity", "1");
			foreignObject.setAttribute("preserveAspectRatio", "none");
			foreignObject.setAttribute("xmlns:xlink", "http://www.w3.org/1999/xlink");
			foreignObject.setAttribute("xlink:href", "/resources/images/marketing/diagram/min_icon_basic.png");
			foreignObject.setAttribute("transform", children.getAttribute("transform"));

			//$("#diagram_canvas_svg").append(foreignObject);
			svguserHandles.push($(foreignObject)[0]);
		}
	});

	_svguserHandle.html("");
	$.each(svguserHandles, function(index, obj) {
		_svguserHandle.append(obj);
	});

	_svguserHandle.html(_svguserHandle.html());
}

//handler 클릭시 노드 기본 메서드 호출
function OnMethods(item, handle) {
	workflow.alertFlag = true;
	//캠페인 기본정보와 연결 확인
	var scoringInfo = item.nodeType == "INFO" ? item : {};
	if (isEmpty(scoringInfo) && isNotEmpty(getParentNodesByNodeType(diagram.selectionList[0], "INFO")[0])) {
		scoringInfo = getParentNodesByNodeType(diagram.selectionList[0], "INFO")[0].addInfo;
	}

	if (isNotEmpty(scoringInfo)) {
		//캠페인 기본정보 저장 확인(캠페인기본정보 이외의 노드일 경우)
		if (isEmpty(scoringInfo.actualTaskId) && item.nodeType != "INFO") {
			alert(MESSAGE.scoring.saveCampaign);
			return false;
		} else {
			//캠페인 상태 설정
			if (isNotEmpty(scoringInfo.data) && isNotEmpty(scoringInfo.data.scoringDefaultInfo)) {
				scoring.statusCode = scoringInfo.data.scoringDefaultInfo.scrStatusCd;
			}
		}

		//캠페인 ID/상태 설정
        scoring.id = scoringInfo.actualTaskId;

        //현재 노드 캠페인 ID 설정
        diagram._selectedObject.scoringId = scoringInfo.actualTaskId;
	} else {
		//현재 노드 캠페인 ID 설정
        diagram._selectedObject.scoringId = "";

		alert(MESSAGE.scoring.notConnectedCampaign);

		return false;
	};

    var method = handle.method;
    var methodType = handle.methodType;
    //메서드 / 메서드 유형 확인
    if (isNotEmpty(method) && isNotEmpty(methodType)) {
        //팝업
        if (methodType == "POPUP") {
            cDialog = $("#dialog").data("ejDialog");
            if (isNotEmpty(cDialog)) {
                cDialog.destroy();
            }

            //팝업 설정
            var option = {
                    contentType: "ajax",
                    contentUrl: method,
                    enableResize: false,
                    enableModal: true,
                    Close: "onDialogClose",
                    beforeOpen: function(args) {

                        /**
                         * 1. targeting popup 실행시 main과 content에 height가 추가되 이상현상이 발생
                         * 2. open 후 화면이 위로 밀리는현상이 발생
                         * 3. 이를 방지하기 위해 main과 content style 초기화한다.
                         */
                        $("#main").attr("style", "");
                        $("#content").attr("style", "");

                    },
                    open: function (args) {
                        //set width
                        this.setModel({width: stringToNumber(this.model.width)});
                        if(args.model.customFunc)
                        	window[args.model.customFunc]();
                        //set height
                        /*new ifvm.PopupHeight({
                            popupDivId : 'dialog',
                            contentsId : 'dialogPopupWrap'
                        });

                        //set center
                        new ifvm.PopupCenter({
                            popupDivId : 'dialog'
                        });*/

                        //$("#dialog").resize();    //이중팝업시 ejscroll 에러로 인해 주석처리함

                        //캠페인 수정 가능 여부
                        if (isNotEmpty(scoring.id)) {
                            //캠페인 상태 저장여부에 의한 각 obj disabled 여부
                            if (!checkNodeUnauthrized(scoring.id, item.nodeType)) {
                                //roi, monitoring 제외
                                if (!(handle.handleName == "roiAnalysisPop" || handle.handleName == "monitoringPop")) {
                                    setPopupFormAllDisabled("dialog");
                                }

                                //캠페인 기본정보 팝업 일 경우 비고는 저장 가능
                                if (handle.handleName == "infoPop") {
                                    //비고
                                    $("#description").attr('disabled',false);
                                    //저장버튼
                                    $("#scoringInfoPopSaveBtn").attr('disabled',false);
                                }

                                //오퍼 일 경우 상세 보기 가능
                                if (handle.handleName == "offerPop") {
                                    $("#benefitsPopEditBtn").attr("disabled", false);
                                }
                            };
                        }

                        //

                        //메뉴 설정(팝업 오픈시 메뉴가 바뀌는 현상이 발생)
                        //$.ifvmLnbSetting('campaignList');
                    }
            };
            //승인 팝업 일 경우 width 설정
            if (handle.handleName == "approvalPop") {
                option.width = 1024;
            }
            //타겟팅 팝업 일 경우
            else if (handle.handleName == "targetingPop"|| handle.handleName == "ruleSetPop") {
                option.width = 1090;
            }
            //콘텐츠 팝업 일 경우
            else if (handle.handleName == "contentsDesignPop") {
                option.width = 1030;
            }
            //오퍼 팝업 일 경우
            else if (handle.handleName == "offerPop") {
                option.width = 1024;
            }
            //쿠폰 팝업 일 경우
            else if (handle.handleName == "camCouponPop") {
                option.width = 800;
            }
            //캠페인 기본정보
            else if (handle.handleName == "infoPop") {
                option.width = 660;
            }
            //캠페인 기본정보
            else if (handle.handleName == "schedulingPop") {
                option.width = 900;
            }
            else if(handle.handleName == "ruleInfoPop") {
            	option.customFunc = 'ruleInfoGridResize'
            }
            //scoring Action정보
            else if(handle.handleName == "scoringActionInfoPop") {
            	option.customFunc = 'actionInfoGridResize'
            }
            //scoring Rule정보
            else if(handle.handleName == "scoringRuleInfoPop") {
            	option.customFunc = 'ruleInfoGridResize'
            }

            $("#dialog").ejDialog(option);

            cDialog = $("#dialog").data("ejDialog");
        } else {

        }
    }
}

//캠페인 상태와 노드에 따른 저장여부 확인
function checkNodeUnauthrized(campaignId, nodeType) {
	var saveFlag = false;
    $.ifvSyncPostJSON(URLcheckCampaignStatusSaveFlag, {
        id: campaignId,
        nodeType: nodeType
	    },
	    function(result) {
	    	//callback
	    	saveFlag = result;
	    }
    );

    return saveFlag;
}

//dialog 닫을시 현재 내용 삭제
function onDialogClose(args) {
    cDialog.destroy();
}

//node data 업데이트
function updateNodeData(args, prop){
    var selectedObject = diagram._selectedObject;
    if (selectedObject) {
        var name = selectedObject.name.toString();
        if (name !== "connector") {
            switch (prop) {
            case "title":
                selectedObject.title = args.value;
                break;
            }
        }

        selectedObject.update();
    }
}

//drop 노드 설정
function setDropOnNode(args) {
	var node = diagram.getNode(args.name);
	var name = node.name;
	var option = {};

	//현재 노드의 addInfo nodeData설정
	var nodeData = new NodeDataClass();
	nodeData = setNewNodeDataClass(node.addInfo);
	nodeData.nodeName = node.name;
	nodeData.taskId = node.name;
	node.addInfo = nodeData;

	if( isNotEmpty(node._type) && node._type == "node" ) {
		//html 또는 image 노드 렌더
		if ( isNotEmpty(node.addInfo.htmlTemplateId) ) {
			if (checkDropTriggerNode(node.addInfo)) {
				node.offsetX = diagram._onTargetNode.offsetX;
				node.offsetY = diagram._onTargetNode.offsetY + 100;
			}

			renderNode(node);
			//option.width= 242;
			//option.height = 60;
			//diagram.updateNode(name, option);
		}

		//캠페인유형이 트리거이면 드래그한 노드의 하위에 생성 및 커넥터 연결
		if (checkDropTriggerNode(node.addInfo)) {
			option.offsetX = diagram._onTargetNode.offsetX;
			option.offsetY = diagram._onTargetNode.offsetY + 100;

			diagram.updateNode(name, option);

			createConnector("onMouseenterConnect", node);
		}

		//노드 유형이 INFO가 아닌경우 연결 커넥터 생성
		else if (!(node.addInfo.nodeType == "INFO")) {
			//소스 및 타겟 커넥터가 없을 경우 생성
			if (node.inEdges.length == 0 && node.outEdges.length == 0 && diagram.nodes().length > 0) {
				//Next connect 생성
				createConnector("NextConnect", node);
			}
		}

        $('#' + node.name + "_html").mouseenter(function(args){
            //console.log("OnMouseenter : " + node.name );
            diagram._onMouseenterNode = diagram.getNode(node.name);
            //console.log(diagram._onMouseenterNode);
        })

        $('#' + node.name + "_html").mouseleave(function(args){
            //console.log("OnMouseleave : " + node.name );
            diagram._onMouseenterNode = {};
        })
	}

	//선택 초기화
    diagram._clearSelection();

	return node;
}

//이벤트 트리거 노드 드랍 확인
function checkDropTriggerNode(node) {
	var flag = false;

	var _type = getCampaignTypeCode();
	if ((_type == "TRIGGER" || _type == "SCR") && (node.nodeType == "ETCOND" || node.nodeType == "ETACT" || node.nodeType == "SCRCOND" || node.nodeType == "SCRACT" || checkChnlNode(node.nodeType))) {
		flag = true;
	}

	return flag;
}

//이벤트 트리거 노드 확인
function checkEventTriggerNode(node) {
	var flag = false;

	if (node.nodeType == "ETCOND" || node.nodeType == "ETACT") {
		flag = true;
	}

	return flag;
}

//룰셋 노드 확인
function checkRuleSetNode(node) {
	var flag = false;

	if (node.nodeType == "RULESET") {
		flag = true;
	}

	return flag;
}

//html node 렌더 (edit:2016.01.04)
function renderNode(node){
	var addInfo = node.addInfo;

    //노드 Data의 htmlTemplateId 가지고 있을 경우만 html node 렌더
	//아래 node처럼 강제로 html 생성시 ie에서는 보이지 않는현상이 발생
	//diagram html shape node 생성 후 해당 html안에 template 생성후 교체함
    if (isNotEmpty(addInfo.htmlTemplateId)) {
		var itemSet = {
			name: addInfo.nodeName,
			width: 242,
			height: 60,
			type: ej.datavisualization.Diagram.Shapes.Html,
			templateId : "htmlTemplate", //임시 template 설정 후 실제 template로 변경
			borderWidth: node.borderWidth,
			labels: [{ readOnly: true, offset: {x: 0.5, y:1} }],
			constraints : node.constraints,
			offsetX: node.offsetX, offsetY: node.offsetY,
			addInfo: addInfo,
			ports: node.ports
		};

		//렌더시 삭제되는 node는 diagram._removeNodes 에 쌓이면 안된다.
		node.addInfo.taskDataStatus = "R";
		diagram.remove(node);

		//상태를 다시 Normal로 변경한다.
		node.addInfo.taskDataStatus = "N";
		diagram.add(itemSet);

		//template 설정
		$('#' + addInfo.nodeName + "_html").html("");
		var tmpl = $("#"+addInfo.htmlTemplateId).tmpl(addInfo);
		$('#' + addInfo.nodeName + "_html").html(tmpl);

		//template update
		addInfo.update();
    }
}

//html node 렌더 - ie에서 실행시 해당 노드에 적용이 안됨
function renderNode2(nodeData){
    //노드 Data의 htmlTemplateId 가지고 있을 경우만 html node 렌더
    if (isNotEmpty(nodeData.htmlTemplateId)) {
        var tmpl = $("#"+nodeData.htmlTemplateId).tmpl(nodeData);
        var foreignObject = document.createElementNS('http://www.w3.org/2000/svg', 'foreignObject');
        //var foreignObject = document.createElement('foreignObject');
        foreignObject.setAttribute("id", nodeData.nodeName + "_shape");
        foreignObject.setAttribute("width", "242");
        foreignObject.setAttribute("height", "60");
        foreignObject.setAttribute("style", "pointer-events:none");
        foreignObject.setAttribute("fill", "white");
        foreignObject.setAttribute("stroke", "black");
        foreignObject.setAttribute("stroke-width", "0");
        foreignObject.setAttribute("stroke-dasharray", "");

        $('#' + nodeData.nodeName + "_shape").remove();

        var _rectArr = $('#' + nodeData.nodeName).children();
        var _rect = {};
        var _port = [];
        $.map( _rectArr, function(val, i) {
            if(i === 0){
                _rect = val;
            }
            else{
                _port.push(val);
            }
        });

        if (isNotEmpty(_rect)) {
        	_rect.width.baseVal.value = 242;
        	_rect.height.baseVal.value = 60;
        }

        $('#' + nodeData.nodeName).html($(foreignObject)[0]);
        $('#' + nodeData.nodeName).prepend(_rect);
        $('#' + nodeData.nodeName).append(_port);
        $('#' + nodeData.nodeName + "_shape").append(tmpl);

    }
}

//동적 node 생성
function createNode(type, fNode){
    var node = {};
    if (type) {
        if (type.match("Start")) {
            node = createIntelligentShape(type, fNode);
            node.ports.push(createPort("Hexagon", .74, 1));

            //add Node
            diagram.add(node);
        } else {
            fNode = {};
            node = createIntelligentShape(type, fNode);

            if (isNotEmpty(node)) {
            	//add Node
                diagram.add(node);
                node = diagram.getNode(node.name);

                //drop 노드 설정
                setDropOnNode(node);
            }
        }
    }

    return node;
}

//동적 connector 생성
function createConnector(type, fNode){
    var connect = {};
    if (type) {
        if (type.match("StartConnect") || type.match("NextConnect")) {
            connect = createIntelligentShape(type, fNode);
        }
        else if (type.match("onMouseenterConnect")) {
        	connect = createIntelligentShape(type, fNode);
        }

        if (isNotEmpty(connect)) {
            diagram.add(connect);
        }
    }

    return connect;
}

//shape 생성
function createIntelligentShape(name, fNode) {
    var node = {};
    node.ports = [];
    node.ports.push(createPort(name, .5, .5));
    node.name = name;
    node.width = 40;
    node.height = 40;
    node.fillColor = "white";
    node.borderWidth = 1.5;

    //Start 노드의 Connect
    if (name.match("StartConnect")) {
    	var sourceNode = diagram.nodes()[diagram.nodes().length-1].name;
        node = {
            name: "StartConnect", // + ej.datavisualization.Diagram.Util.randomId(),
            segments: [{ type: "orthogonal" }],
            sourceNode: sourceNode, targetNode: fNode.name,
            lineWidth: 2, targetDecorator: { shape: "arrow" },
            lineColor:"#666666",
            labels: [{ readOnly: true}],
            cornerRadius: 10,
            constraints: connectorConstraints
        };
    }

    //노드 생성시 이전 노드와의 Connect
    else if (name.match("NextConnect")) {
        //연결 순서에 따른 source node를 구한다.
        var sNode = getConnectSourceNode(fNode);
        if (isNotEmpty(sNode)) {
        	sourceNode = sNode.name;

        	//source node의 out connectors 설정
        	setConnectSourceNodeOutEdges(sNode, fNode);

        	//캠페인 ID 설정
        	fNode.addInfo.scoringId = sNode.addInfo.scoringId;
        } else {
        	return null;
        }

        //커넥터 생성
        var item = getPaletteItemByName("next");
        if (item) {
            var name = $.ifvmGetRowID();//item.name + ej.datavisualization.Diagram.Util.randomId();

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
    }

    else if (name.match("onMouseenterConnect")) {
        //연결 순서에 따른 source node를 구한다.
        var sNode = diagram._onTargetNode;
        if (isNotEmpty(sNode)) {
        	sourceNode = sNode.name;

        	//source node의 out connectors 설정
        	//setOnMouseenterConnectSourceNodeOutEdges 호출 시 sourceNode(=추가할 노드)의 외곽에 있는 노드와 connector 가 자동으로 설정된다. 스코어링 성격 상 제외처리.
        	//setOnMouseenterConnectSourceNodeOutEdges(sNode, fNode);

        	//캠페인 ID 설정
        	fNode.addInfo.scoringId = sNode.addInfo.scoringId;
        } else {
        	return null;
        }

        //커넥터 생성
        var item = getPaletteItemByName("next");
        if (item) {
            var name = $.ifvmGetRowID();//item.name + ej.datavisualization.Diagram.Util.randomId();

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
    }

    //Start 노드
    else if (name.match("Start")) {
        var points = _renderStart(node);
        node.name = "Start", // + ej.datavisualization.Diagram.Util.randomId(),
        node.width = 100;
        node.height = 50;
        node.shape = "path";
        node.pathData = points;
        node.fillColor = "#33AACA";
        node.borderWidth = 0;
        node.offsetX = fNode.offsetX;
        node.offsetY = fNode.offsetY - 100;
        node.labels = [{ readOnly: true, text:"Start", fontColor:"white", fontSize:14}];
        //node.ports = getDefaultPort();
        node.constraints = constraints;
    }

    //그외 노드 찾아 생성
    else {
        var item = getPaletteItemByType(name);
        if (item) {
        	//node 설정
        	node.name = $.ifvmGetRowID();
            node.width = item.width;
            node.height = item.height;
            node.borderWidth = item.borderWidth;
            node.borderColor = item.borderColor;
            node.fillColor = item.fillColor;
            node.type = item.type;
            node.shape = item.shape;
            node.pathData = item.pathData;
            node.htmlTemplateId = item.htmlTemplateId;
            node.source = item.source;
            node.offsetX = isEmpty(fNode.offsetX) ? 200 : fNode.offsetX;
            node.offsetY = isEmpty(fNode.offsetY) ? 200 : fNode.offsetY - 100;
            node.labels = item.labels;
            node.ports = item.ports;
            node.constraints = item.constraints;
            node.addInfo = item.addInfo;
        } else {
            return null;
        }
    }

    return node;
}

//연결 순서에 따른 source node 찾기
function getConnectSourceNode(fnode){
	var tSeq = fnode.addInfo.connectSeq;
	var rNode = {};
	for (var i=1; i < tSeq; i++) {
		$.each(diagram.nodes(), function(index, node) {
			if (node.addInfo.connectSeq == tSeq-i && !checkDropTriggerNode(node.addInfo)) {
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

//source node의 out connectors 설정
function setConnectSourceNodeOutEdges(sNode, fNode) {
	$.each(sNode.outEdges, function(index, edge) {
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

//source node의 out connectors 설정
function setOnMouseenterConnectSourceNodeOutEdges(sNode, fNode) {
	if (checkDropTriggerNode(sNode.addInfo)) {
		$.each(sNode.outEdges, function(index, edge) {
			var connector = diagram.getNode(edge);

			if (isNotEmpty(connector) && isNotEmpty(connector.targetNode)) {
				var targetNode = diagram.getNode(connector.targetNode);

				if (isNotEmpty(fNode)) {
					var sourceNode = fNode.name;
					connector.sourceNode = sourceNode;
					diagram.updateConnector(connector.name, { sourceNode: sourceNode });
				}
			}
		});
	}
}


//diagram에서 node 찾기
function findNode(name){
    return diagram.getNode(name);
}

//diagram에서 node 찾기
function findNodeByNodeType(type){
	var rNodes = [];
	$.each(diagram.nodes(), function(index, node) {
		if (node.addInfo.nodeType == type) {
			rNodes.push(node);
		}
	});

    return rNodes;
}

//diagram에서 node명으로 node선택
function selectionNode(name){
    var node = diagram.getNode(name);
    diagram.addSelection(node);
}

//diagram에서 connector 찾기
function findConnector(name){
    var rtnConnector = null;
    $.each(diagram.connectors(), function(index, connector) {
       if(connector.name === name) {
           rtnConnector = connector;
       }
    });

    return rtnConnector;
}

//diagram json data 반환
function getDiagramData(){
    var diagramData = diagram.save();

    return JSON.stringify(diagramData);
}

//json data를 diagram에 셋팅
function setDiagramData(data){
    diagram.load(JSON.parse(data));

    $.each(diagram.nodes(), function(index, node) {
        var nodeData = new NodeDataClass();
        nodeData.setData(node.addInfo);
        node.addInfo = nodeData;
        setDropOnNode(node);
    });
}

//포트 생성
function createPort(name, x, y) {
    var port = { name: name + ej.datavisualization.Diagram.Util.randomId(), offset: { x: x, y: y } };
    return port;
}

//기본 포트 추출
function getDefaultPort(name) {
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

//노드 및 커넥터 생성
function getTaskNodes(data, type) {
    var items = [];
    var nodes = [];
    var connectors = [];
    var ids = [];

    $.each(data.nodeList, function(index, item) {
        //temp 유형일 경우 아이디 생성
        if (type == "TEMP") {
            var oldid = item.id;
            item.id = $.ifvmGetRowID();

            var obj = {
                oldid: oldid,
                newid: item.id
            };

            ids.push(obj);
        }

        //유형별 노드
        nodes.push(getNodeByType("T_NODE", item));
    });

    $.each(data.connectorList, function(index, item) {
        //temp 유형일 경우 source, target node id 변경
        if (type == "TEMP") {
            item.id = $.ifvmGetRowID();

            $.each(ids, function(index, data) {
                if (data.oldid == item.sourceNode) {
                    item.sourceNode = data.newid;
                }
                if (data.oldid == item.targetNode) {
                    item.targetNode = data.newid;
                }
            });
        }

        // connector 유형
        connectors.push(getNodeByType("T_CONNECTOR", item));
    });

    items.nodes = nodes;
    items.connectors = connectors;

    return items;
}

//전체 기본 노드 셋팅
function setDefaultNodes(items) {
	var nodes = [];
	$.each(diagram.nodes(), function(index, node) {
		nodes.push(node);
	});

	//task 노드 설정
    $.each(nodes, function(index, node) {
        //var fNode = setDropOnNode(node);
    	renderNode(node);

    	var fNode = diagram.getNode(node.name);
    	diagram._clearSelection();
    	diagram.addSelection(fNode);
    	bringToFront();
    });

    //task 커넥터 설정(task 노드 설정시 커넥터가 삭제됨으로 다시 추가 생성)
    if (isNotEmpty(items.connectors)) {
	    $.each(items.connectors, function(index, connector) {
	    	diagram.add(connector);
	    });

	    //remove connectors 초기화
	    diagram._removeConnectors = [];
    }

	//노드 위치 상단으로 이동
    $.each(nodes, function(index, node) {
    	var fNode = diagram.getNode(node.name);
    	diagram._clearSelection();
    	diagram.addSelection(fNode);
    	bringToFront();
    });

    //선택 초기화
    diagram._clearSelection();
}

//전체 노드 및 커넥터 추출 반환 Task 저장을 위한
function getNodesAndConnectors(obj) {
    var items = {};
    var nodeList = [];
    var connectorList = [];

    //노드 추출
    $.each(obj.nodes(), function(index, node) {
        if (isNotEmpty(node.addInfo.nodeId)) {
            var item = {
                    nodeId: node.addInfo.nodeId,
                    taskNodeName: node.addInfo.nodeName,
                    id: node.addInfo.taskId,
                    offSetX: node.offsetX,
                    offSetY: node.offsetY
            };
            nodeList.push(item);
        }
    });

    //커넥터 추출
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
                    taskConnectorName: connector.addInfo.nodeName,
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

    return items;
}

//diagram 초기화
function setDiagramClear() {
    diagram.clear();
}

function getPaletteItemByName(name) {
    var item = false;
    $.each(symbolpalette.model.palettes, function(index, palette) {
        $.each(palette.items, function(index, items) {
            if (items.name == name) {
                item = items;
            }
        });
    });
    return item;
}

function getPaletteItemByType(type) {
    var item = false;
    $.each(symbolpalette.model.palettes, function(index, palette) {
        $.each(palette.items, function(index, items) {
            if (items.addInfo.nodeType == type) {
                item = items;
            }
        });
    });
    return item;
}

//diagram size 설정
function setDiagramSize(showpropeditor) {
	if($('#sample-header').length == 0) {
		return;
	}
	console.log("setDiagramSize");
    var width = $(window).width() - $("#main-left").width();
    //var pwidth = $("#symbolpalette").width();
    var mwidth = $("#sideMenu").width();
    //if (!showpropeditor)
    //    pwidth = 0;
    $("#main-right").css("width", width - mwidth);

    var pixels = $("#header").height() + $(".page_btn_area").height() + $('#sample-header')[0].getBoundingClientRect().height;
    var screenHeight = $(window).height();
    var height = screenHeight  - pixels;
    $("#main-right").css("height", height);

    if (isNotEmpty(diagram)) {
    	diagram.updateViewPort();
    }
}

//diagram palette size 설정
function setPaletteSize() {
	if($("#symbolpalette").length == 0) return;
	console.log("setPaletteSize");
    //너비
    //var width = $(document).width() - $("#main-left").width();
    //$("#main-right").css("width", width);
    //높이
    var pixels = $("#header").outerHeight() + $(".page-title").outerHeight() + $(".page_btn_area").outerHeight() + $("#sample-header").outerHeight();
    var screenHeight = $(window).height();
    var height = screenHeight  - pixels;
    
    var paletteId;
    var paletteHeight;
    //palette
    if (isNotEmpty(symbolpalette)) {
	    symbolpalette.setHeight(height + "px");
	    paletteId = '#symbolpalette';
	    paletteHeight = 206;
    }

    //mini palette
    else if (isNotEmpty(minimizedPalette)) {
	    minimizedPalette.setHeight(height + "px");
	    paletteId = '#minimizedPalette';
	    paletteHeight = 66;
	    //mini palette scroller
    }
    
    var scrollerObj  = $(paletteId).data("ejScroller");
    if(scrollerObj) {
    	setTimeout(function() {
    		scrollerObj.setModel({
        		width: paletteHeight
        		, height: height
        	});	
    	}, 250);
//	    scrollerObj.destroy();
//	    $(paletteId).ejScroller({
//	        height: height,
//	        width: paletteHeight
//	    });
    }
}

//comment 설정
function setPaletteCommentDiv() {
    var nDiv;
    var pDiv;
    $.each(symbolpalette.model.palettes, function(index, palette){
        $.each(palette.items, function(index, item){

            var desc = isEmpty(item.addInfo.nodeDesc) ? "no description." : item.addInfo.nodeDesc;

            nDiv = document.createElement("div");
            nDiv.setAttribute("class", "e-comment-container");
            nDiv.innerHTML = desc;

            pDiv = $("#symbolpalette #" + item.name + "_paletteItem");
            pDiv.css("width", "100%");
            pDiv.css("height", "45px");
            pDiv.append(nDiv);

            aDiv = $("#" + item.name + "_anchor");
            aDiv.css("float", "left");

            //이미지 backRect fill none 처리 안 할시 흰색 배경이 보임.
            if (item._shape == "image") {
            	$("#symbolpalette #" + item.name + "_backRect")[0].setAttribute("fill", "none");
            }
        });
    });

    //set tooltip mini palette
    $.each(minimizedPalette.model.palettes, function(index, palette){
        $.each(palette.items, function(index, item){
            var description = item.addInfo.nodeDesc;
            if (isNotEmpty(description)) {
                 $('#minimizedPalette #' + item.name + "_paletteItem").hover(function(){
                    // Hover over code
                    $(this).data('tipText', description).removeAttr('title');
                    $('<p class="tooltip"></p>')
                    .text(description)
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

            //이미지 backRect fill none 처리 안 할시 흰색 배경이 보임.
            if (item._shape == "image") {
            	$("#minimizedPalette #" + item.name + "_backRect")[0].setAttribute("fill", "none");
            }
        });
    });
}

//change palette
function changePalette() {
    if ($("#symbolpalette").css("display") == "none") {
        $("#edit_splitter_palette").removeClass("edit_splitter_rightArrow");
        $("#edit_splitter_palette").addClass("edit_splitter_leftArrow");

        $("#minimizedPalette").hide();
        $("#symbolpalette").show();
        $("#main-left").animate({ width: '206px' }, 300, function() {
            setPaletteSize();
            setDiagramSize();
        });

    } else {
        $("#edit_splitter_palette").removeClass("edit_splitter_leftArrow");
        $("#edit_splitter_palette").addClass("edit_splitter_rightArrow");

        $("#main-left").animate({ width: '66px' }, 300, function () {
            $("#symbolpalette").hide();
            $("#minimizedPalette").show();
            //$("#minimizedPalette").css("width", "75px");
            //$("#minimizedPalette").css("height", "100%");
            setPaletteSize();
            setDiagramSize();
        });
    }
}

function setToolTip(isLoad) {
    var paletteItems;
    if (isLoad)
        paletteItems = $(".e-paletteItem");
    else
        paletteItems = $("#maxi_search_content")[0].childNodes;
    for (m = 0; m < paletteItems.length; m++) {
        var title = "";
        var wWord = ((paletteItems[m].id).split("_")[0]);
        if (wWord) {
            if (wWord.split(/(?=[A-Z])/)[0])
                title += " " + wWord.split(/(?=[A-Z])/)[0];
            if (wWord.split(/(?=[A-Z])/)[1])
                title += " " + wWord.split(/(?=[A-Z])/)[1];
            if (wWord.split(/(?=[A-Z])/)[2])
                title += " " + wWord.split(/(?=[A-Z])/)[2];
            if (wWord.split(/(?=[A-Z])/)[3])
                title += " " + wWord.split(/(?=[A-Z])/)[3];
            if (wWord.split(/(?=[A-Z])/)[4])
                title += " " + wWord.split(/(?=[A-Z])/)[4];
        }
        paletteItems[m].setAttribute("title", title);
    }
}

//get task data status code return
//I: Insert
//U: Update
function getTaskStatusCode(obj) {
    var status = "I";
    if (obj.length) {
        $.each(obj, function(index, data) {
            if (isNotEmpty(data.id) || isNotEmpty(data.rid)) {
                status = "U";
                return status;
            }
        });
    } else {
        if (isNotEmpty(obj.id) || isNotEmpty(obj.rid)) {
            status = "U";
            return status;
        }
    }

    return status;
}

//get nodes By nodeType
function getNodesByNodeType(node, type) {
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

//get parent nodes By nodeType
function getParentNodesByNodeType(node, type) {
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

//get child nodes By nodeType
function getChildNodesByNodeType(node, type) {
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

//노드명이 존재하는지 확인(상위 또는 하위 노드들에 대한 확인 함수의 무한루프를 방지하기 위해 사용)
function checkNodeNames(chkNodeNames, nodeName) {
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

//set nodeDataClass
function setNewNodeDataClass(data) {
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

//노드 데이터 추출
//저장 로직에 의한 제거 될 노드 먼저 추출
function getAllNodeDataClass(obj) {
  var nodeList = [];
  //get remove nodes
  $.each(obj._removeNodes, function(index, node) {
      if (isNotEmpty(node.addInfo.nodeId)) {
          /*var item = {
                  nodeId: node.addInfo.nodeId,
                  nodeName: node.addInfo.nodeName,
                  nodeType: node.addInfo.nodeType,
                  taskId: node.addInfo.taskId,
                  taskType: node.addInfo.taskType,
                  taskDataStatus: node.addInfo.taskDataStatus,
                  actualTaskId: node.addInfo.actualTaskId,
                  sourceNode: node.addInfo.sourceNode,
                  data: node.addInfo.data,

          };*/

          /* watch 사용시
          if (isNotEmpty(item.data.watchers)) {
              delete item.data.watchers;
          }*/

    	  nodeList.push(node.addInfo);
      }
  });

  //get nodes
  $.each(obj.nodes(), function(index, node) {
      if (isNotEmpty(node.addInfo.nodeId)) {
          /*var item = {
                  nodeId: node.addInfo.nodeId,
                  nodeName: node.addInfo.nodeName,
                  nodeType: node.addInfo.nodeType,
                  taskId: node.addInfo.taskId,
                  taskType: node.addInfo.taskType,
                  taskDataStatus: node.addInfo.taskDataStatus,
                  actualTaskId: node.addInfo.actualTaskId,
                  sourceNode: node.addInfo.sourceNode,
                  data: node.addInfo.data
          };*/

          /* watch 사용시
           * if (isNotEmpty(item.data.watchers)) {
              delete item.data.watchers;
          }*/

    	  //set Campaign ID
    	  var scoringInfo = getNodesByNodeType(node, "INFO");
    	  if (isNotEmpty(scoringInfo)) {
    	      node.addInfo.scoringId = scoringInfo[0].addInfo.actualTaskId;
    	  }

          nodeList.push(node.addInfo);
      }
  });

  return nodeList;
}

//node data 설정
function setNodeDataByTaskId(data){
    $.each(data, function(index, data) {
    	//노드를 찾아 데이서 설정
    	var node = diagram.getNode(data.taskId);
    	if (isNotEmpty(node)){
    		node.addInfo.taskType = data.taskTypeCode;    //테스크유형
            node.addInfo.actualTaskId = data.actualTaskId;    //실제업무 ID
            node.addInfo.scoringId = data.scoringId;    //캠페인 ID
            node.addInfo.oldScoringId = data.scoringId;    //이전 캠페인 ID
            node.addInfo.scoringWfRelId = data.id;    //캠페인 워크플로우 관계 ID
            node.addInfo.title = data.nodeTypeCodeName;

            if (isNotEmpty(data.text)) {
            	node.addInfo.text = data.text;
            }

            //데이터
            if (isNotEmpty(data.data)) {
                node.addInfo.data = data.data;
            }

            //html template update
            node.addInfo.update();

            //유형에 맞게 설정한다.
            if(data.taskTypeCode == "INFO") {
            	scoring.id =  data.actualTaskId;
            	scoring.statusCode =  data.data.scoringDefaultInfo.scrStatusCd;
            	scoring.templateUseFlag = data.data.scoringDefaultInfo.scrTempUseYn == "true" ? "1" : "0";

                //워크플로우 버튼 text 설정
                setCampaignWorkflowTempUseBtn(scoring.templateUseFlag);
            }

            //노드 데이터 유무에 따른 커넥터 선색 설정
            /*if (isEmpty(data.enterTime)) {
	            if (node.inEdges.length > 0) {
	            	$.each(node.inEdges, function(index, edge) {
	            		diagram.updateConnector(edge, {lineColor: "#f36a5a"});
	            	});
	            }
            }*/
    	}
    });
}

//선택 노드 삭제
function removeSelectedNodes(args) {
	removeFlag = true;
	$.each(diagram.model.selectedItems.children, function(index, node) {
		//캠페인 기본정보는 삭제할 수 없다.
		if (node.addInfo.nodeType == "INFO") {
			removeFlag = false;
			alert(MESSAGE.scoring.canNotRemoveScoringInfo);

			return false;
		}

		//캠페인 작업중이 아닐때는 삭제할 수 없다.
		var campaignInfo = getNodesByNodeType(diagram.getNode(node.name), "INFO")[0];
		if (isNotEmpty(campaignInfo) && isNotEmpty(campaignInfo.addInfo.data) && isNotEmpty(campaignInfo.addInfo.data.campaignDefaultInfo)) {
			var statusCode = campaignInfo.addInfo.data.campaignDefaultInfo.campaignStatusCode;
			if (isNotEmpty(statusCode) && statusCode != "W") {
				removeFlag = false;
				alert(MESSAGE.scoring.notWorkingCampaign);

				return false;
			}
		}
	});

	//삭제여부 확인
	if (removeFlag) {
		var tNodes = [];
		var sourceNode = "";
		//삭제대상의 연결된 하위 node 확인
		$.each(diagram.model.selectedItems.children, function(index, node) {
			if (isNotEmpty(node._type) && node._type == "node") {

				if (node.inEdges.length > 0) {
					var cnctr = diagram.getNode(node.inEdges[0]);

					//삭제 노드에 포함되어있는지 확인
					$.each(diagram.model.selectedItems.children, function(index, node) {
						if (node.name != cnctr.sourceNode) {
							sourceNode = cnctr.sourceNode;
						}
					});

					var outEdges = Object.create(node.outEdges);
					$.each(outEdges, function(index, edge) {
						var connector = diagram.getNode(edge);
						if (isNotEmpty(connector)) {
							tNodes.push(connector);
						}
					});
				}
			}
		});


		$.each(tNodes, function(index, connector) {
			diagram.updateConnector(connector.name, { sourceNode: sourceNode });
		});

		//선택 대상 삭제
		diagram.remove();

		//삭제대상의 연결된 하위 node 의 connector 새로 생성
		/*$.each(tNodes, function(index, node) {
			var fNode = diagram.getNode(node);
			if (isNotEmpty(fNode)) {
				createConnector("NextConnect", fNode);
			}
		});*/

	}

	diagram._clearSelection();
}

//캠페인 신규 생성시 설정
function setNewCampaignWorkflowNode() {
    //캠페인 기본정보 생성
	var node = null;
	if (findNodeByNodeType("INFO").length == 0) {
		node = createNode("INFO");
		node = diagram.getNode(node.name);
	} else {
		node = findNodeByNodeType("INFO")[0];
	}

	//selection node
	diagram._clearSelection();
	diagram.addSelection(node);

    //캠페인 기본정보 팝업
    var handle = {};
    handle.methodType = "POPUP";
    handle.method = PAGE_CONTEXT_PATH + LINK_URL.SCORING_INFO_POP;
    OnMethods(node.addInfo, handle);
}

/**
 ***** 중요 ******
 * 추가 노드 확인
 */
function checkAddNode(args) {
	if (isNotEmpty(args.element) && isNotEmpty(args.element.addInfo)) {
		var node = args.element.addInfo;
		var checkFlag = false;
		var campaignTypeCode = getCampaignTypeCode();

		//info 노드가 하나 이상이라면 || 채널 유형은 한개만 추가 할 수 있다.
		if (!checkDropTriggerNode(node) && findNodeByNodeType(node.nodeType).length >= 1 ) {
			alert(MESSAGE.scoring.onlyOneNodeCanBeAdded);

			//노드를 취소한다.
			args.cancel = true;

		    return false;
		}

		//캠페인 유형이 트리거 이면 Rule, Action, 채널 노드는 여러개 등록 가능
		//연결될 노드 위에 드래그 했는지 확인
		if (checkDropTriggerNode(node)) {
			if ($.fn.ifvmIsEmpty(diagram._onMouseenterNode)) {
				//alert(MESSAGE.scoring.selectTriggerType);

				args.cancel = true;

				return false;
			} else {
				diagram._onTargetNode = diagram._onMouseenterNode;
			}
		}
	}

	return true;
}

/**
 * 캠페인 기본정보의 이벤트 여부가 Y인가 ?
 */
function chkEventYn() {

	var rtnFlag = false;

	//기본정보 유형
	var nodes = findNodeByNodeType("INFO");

	//데이터 및 유형 확인
	if ($.fn.ifvmIsNotEmpty(nodes)) {
		var node = nodes[0];
		if ($.fn.ifvmIsNotEmpty(node.addInfo.data)) {
			if ($.fn.ifvmIsNotEmpty(node.addInfo.data.campaignDefaultInfo)) {
				rtnFlag = (node.addInfo.data.campaignDefaultInfo.eventYn == '1');
			}
		}
	}
	return rtnFlag;
}

//채널유형 확인
function checkChnlNode(nodeType) {
	var flag = false;

	$.each(getChnlTypeList(), function(index, type) {
		//해당 노드가 채널인지 확인
		if (type == nodeType) {
			flag = true;

			//each break;
			return true;
		}
	});

	return flag;
}

//채널 한개만 등록 했는지 확인
function checkChnlTypeOnlyOne(nodeType) {
	var chkRst = false;
	var chkLen = 0;

	$.each(getChnlTypeList(), function(index, type) {
		//해당 노드가 채널인지 확인
		if (!chkRst && type == nodeType) {
			chkRst = true;
		}
		//채널 노드 개수 확인
		if (findNodeByNodeType(type).length > 0) {
			chkLen++;
		}
	});

	if (chkRst && chkLen > 0) {
		return false;
	}

	return true;
}

//채널 유형 목록 조회
var wf_chnlTypeList = [];
function getChnlTypeList() {
	if ($.fn.ifvmIsEmpty(wf_chnlTypeList)) {
	    $.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCondLIst.do',{
	        groupCode : "MKT_CAM_CHNL_TYPE_CD"
	        , enableNA : true
	    },function(result) {
		    $.each(result.rows, function(index, code) {
		    	wf_chnlTypeList.push(code.codeName);
		    });
	    });
	}

    return wf_chnlTypeList;
}

//캠페인에 등록되어 있는 채널유형 반환
function getChnlType() {
	var chnlType = "";
	$.each(getChnlTypeList(), function(index, type) {
		if (findNodeByNodeType(type).length > 0) {
			chnlType = type;

			return false;
		}
	});

	return chnlType;
}

//피로도제외 여부
function getFatigueExcept() {
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

//팝업 폼 모든 객체 Disabled
function setPopupFormAllDisabled(id) {
	$("#" + id + " select").attr('disabled',true);
	$("#" + id + " input").attr('readonly',true);
	$("#" + id + " input.datepicker").attr('disabled',true);
	$("#" + id + " textarea").attr('readonly',true);
	$("#" + id + " .input-group-addon").remove();

	$.each($("#" + id + " button"), function(index, btn) {
		if(!(btn.className.match("cancel"))) {
			btn.setAttribute('disabled',true);
		}
	});
}

//템플릿 사용/해제 버튼 text 설정
function setCampaignWorkflowTempUseBtn(flag) {

	//버튼 활성
	$("#campaignWorkflowTempUseBtn").attr('disabled',false);

	if (flag == "1") {
		//템플릿 해제
		$("#campaignWorkflowTempUseBtnText").text(TXTCancelTemplate);
	} else {
		//템플릿 사용
		$("#campaignWorkflowTempUseBtnText").text(TXTUseAsTemplate);
	}
}

/**
 * 노드 데이터 추출
 * selectNode: 선택노드 obj
 * nodeType: 노드유형
 * dataKey: addInfo.data 에 속에 있는 key명
 * dataKey 없을경우 addInfo.data 반환
 */
function getNodeDataByNodeType(selectNode, nodeType, dataKey) {
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

//가까운순으로 노드를 추출
function getNearNodes(node) {
	//전체 노드
	var nodes = Object.create(diagram.nodes());

	//전체 노드에서 해당 node 제외
	$.each(nodes, function(index, _this) {
		if (_this.name == node.name) {
			nodes.splice(index, 1);

			return false;
		}
	});

	//정렬 가까운 노드가 먼저 나오도록
	nodes.sort(function (a, b) {
		var _a = getNodeDistance(node, a);
		var _b = getNodeDistance(node, b);

		console.log(a.addInfo.nodeType + ":" + _a + ", " + b.addInfo.nodeType + ":" + _b);

    	return _a < _b ? -1 : _a > _b ? 1 : 0;
    });

	return nodes;
}

//노드간의 거리 추출
function getNodeDistance(n1, n2) {
	var _x1 = n1.offsetX;
	var _y1 = n1.offsetY;
	var _x2 = n2.offsetX;
	var _y2 = n2.offsetY;

	var distance = Math.sqrt(Math.pow(Math.abs(_x2 - _x1), 2) + Math.pow(Math.abs(_y2 - _y1), 2));

	return distance;
}

//캠페인 유형코드 추출
function getCampaignTypeCode() {
	var campaignTypeCode = "";

	//기본정보 유형
	var nodes = findNodeByNodeType("INFO");

	//데이터 및 유형 확인
	if ($.fn.ifvmIsNotEmpty(nodes)) {
		var node = nodes[0];
		if ($.fn.ifvmIsNotEmpty(node.addInfo.data)) {
			if ($.fn.ifvmIsNotEmpty(node.addInfo.data.scoringDefaultInfo)) {
				campaignTypeCode = node.addInfo.data.scoringDefaultInfo.type;
			}
		}
	}

	return campaignTypeCode;
}

//캠페인 프로모션여부 확인
function getCampaignPromotionFlag() {
	var rtnValue = "";

	//기본정보 유형
	var nodes = findNodeByNodeType("INFO");

	//데이터 및 유형 확인
	if ($.fn.ifvmIsNotEmpty(nodes)) {
		var node = nodes[0];
		if ($.fn.ifvmIsNotEmpty(node.addInfo.data)) {
			if ($.fn.ifvmIsNotEmpty(node.addInfo.data.campaignDefaultInfo)) {
				rtnValue = node.addInfo.data.campaignDefaultInfo.promYn;
			}
		}
	}

	var rtnFlag = false;

	if (rtnValue == "1") {
		rtnFlag = true;
	}

	return rtnFlag;
}

/* syncfusion customizing  Start */
function bringToFront() {
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
    for (var f, u = n + 1; u <= t; u++) {
    	if (i.parent != "") {
    		if (isNotEmpty(diagram._findObjectByIndex(u, !0))) {
    			diagram._findObjectByIndex(u, !0).zOrder -= 1;
    		}
    	} else {
    		//console.log(isNotEmpty(diagram._findObjectByIndex(u)));
    		if (isNotEmpty(diagram._findObjectByIndex(u))) {
    			diagram._findObjectByIndex(u).zOrder -= 1;
    		}
    	}
    	//i.parent != "" ? _findObjectByIndex(u, !0).zOrder -= 1 : _findObjectByIndex(u).zOrder -= 1;
    }
    i.parent ? (f = diagram.nameTable[i.parent], diagram._findChildren(f, i.name).zOrder = t) : diagram._findObjectByName(i.name).zOrder = t;
    diagram._svg.getElementById(r.name).parentNode.insertBefore(diagram._svg.getElementById(i.name), diagram._svg.getElementById(r.name).nextSibling);
    diagram._updateSelectionHandle();
}
/* syncfusion customizing  End */
