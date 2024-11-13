/*!
 * Infavor NodeDataClass
 * Copyright Jung Suk kim
 * v1.0.0
 */

var NodeDataClass = (function () {

	//생성자
    function NodeDataClass() {
    	
        //노드 ID
        this.nodeId;
        
        this.nodeType;
        
        /**
         * 노드 데이터 상태
         * N : Normal
         * I : Insert
         * U : Update
         * D : Delete
         * R : Render
         */
        this.nodeDataStatus = "N";
        
        //노드 데이터 : 해당 노드의 팝업 또는 업무 데이터 
        this.data = {};
        
        //html template id
        this.htmlTemplateId;
        
        //html template 사용시 template 룰명
        this._Suffix = '_inhtml';
        
        this.oldOffSetX;
        
        this.oldOffSetY;
        
        this.diagramType;
        
    };
    
    //diagram의 현재 선택된 object set
    NodeDataClass.prototype.select = function (items) {
    	//diagram._selectedObject = $('#' + items[0].name + this._Suffix).tmplItem().data;
    	diagram._selectedObject = items[0].addInfo;
    };
    
    //선택된 data를 기준으로 화면 node data update
    NodeDataClass.prototype.update = function () {
    	var tmplItem = $('#' + this.nodeId + this._Suffix).tmplItem();
    	if (isNotEmpty(this.nodeId)){
    		tmplItem.update();
    		this.setIcon();
    	}
    };
    
    //html의 icon 변경
    NodeDataClass.prototype.setIcon = function () {
    	var html = $('#' + this.nodeId + this._Suffix +" #icon");
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