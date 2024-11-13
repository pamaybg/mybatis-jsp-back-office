/*!
 * Infavor NodeDataClass
 * Copyright Jung Suk kim
 * v1.0.0
 */

var NodeDataClass = (function () {

	//생성자
    function NodeDataClass() {
    	//노드 또는 커넥터의 아이디
    	this.nodeId = '';
    	//노드명 또는 커넥터명
    	this.nodeName = '';
    	//html template 사용시 title
        this.title = '';
        //html template 사용시 text
        this.text = '';
        //html template 사용시 title 배경색
        this.titleColor = '#FF0000';
        //html template fillColor
        this.fillColor = '';
        //연결순서
        this.connectSeq = 0;
        
        //객체유형
        this.nodeType = '';
        
        //테스크 ID - load시 taskId
        this.taskId = '';
        //테스크 유형 : 업무 유형 MKT_WF_NODE_TYPE
        this.taskType = '';
        //실제업무 ID
        this.actualTaskId = '';
        //scoring ID
        this.scoringId = '';
        //이전 scoring ID
        this.oldScoringId = '';
        //scoring - 워크플로우 관계 ID
        this.scoringWfRelId = '';
        
        /*
         * 테스크 데이터 상태
         * N : Normal
         * I : Insert
         * U : Update
         * D : Delete
         * R : Render
         */
        this.taskDataStatus = "N";
        
        //노드 데이터 : 해당 노드의 팝업 또는 업무 데이터 
        this.data = {};
        
        //노드 설명
        this.nodeDesc = '';
        
        //노드에 연결되 소스 노드
        this.sourceNode = '';
        //html template 사용시 template 아이디
        this.htmlTemplateId = '';
        //쉐이프 유형중 image 사용시 image path
        this.imageSource = '';
		
        //html template 사용시 template 룰명
        this._Suffix = '_inhtml';
		
        //노드 또는 커넥터의 핸들 목록
		this.handleList = [];
		
		//watch js 통한 nodeDataClass 값 변환 catch
		/*watch(this, function() {
			//data 유무 확인 watch로 인해 내부에 watch 관련 function들이 존재해 별도 확인을 함
			var dataFlag = false;
			for (key in this.data) {
			    if (this.data[key] != undefined) {
			    	dataFlag = true;
			    }
			}
			//data 에 따른 title 배경색 변환
			if (dataFlag) {
				this.titleColor = '#ddd';
        	} else {
        		this.titleColor = '#FF0000';
        		this.text = 'no data';
        	}
			
			//html template 값 update
			var $tmplItem = $('#' + this.name + this._Suffix).tmplItem();
	    	if ($.fn.ifvmIsNotEmpty($('#' + this.name + this._Suffix)) && $.fn.ifvmIsNotEmpty($tmplItem.data)){
	    		$tmplItem.update();
	    	}
		});*/
    };
    
    //diagram의 현재 선택된 object set
    NodeDataClass.prototype.select = function (items) {
    	//diagram._selectedObject = $('#' + items[0].name + this._Suffix).tmplItem().data;
    	diagram._selectedObject = items[0].addInfo;
    };
    
    //선택된 data를 기준으로 화면 node data update
    NodeDataClass.prototype.update = function () {
    	var $tmplItem = $('#' + this.nodeName + this._Suffix).tmplItem();
    	if (isNotEmpty(this.nodeName)){
    		$tmplItem.update();
    		this.setIcon();
    	}
    };
    
    //html의 icon 변경
    NodeDataClass.prototype.setIcon = function () {
    	var html = $('#' + this.nodeName + this._Suffix +" #icon");
    	if (isNotEmpty(this.imageSource) && isNotEmpty(html)) {
    		html.css('background-image', 'url(' + this.imageSource + ')');
    	}
    };
    
    //동적으로 생성된 node의 data set
    NodeDataClass.prototype.setData = function (addInfo) {
    	$.extend(this, addInfo);
    };
    
   

    return NodeDataClass;
})();