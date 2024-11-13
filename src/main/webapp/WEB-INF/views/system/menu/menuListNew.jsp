<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jstree/jstree.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/storeManage.css" />

<script>

var updateData;
var treeMenuList; //tree menu
var programListGrid; //프로그램 목록 grid
var menuTree = new Object;
var deleteTree = new Array;
var TreeTitle = "iCIGNAL";
var currMenuId;
var progTypeCheck;

//메뉴 이미지 세팅
var fileName = "";
var oriName = "";
var url = "";

//jstree
TreeMenuList = function(){
	this.init();
};

TreeMenuList.prototype = {
	treeDataArr : null,

	init : function(){
		this.getTreeDataSetting();
	},

	getTreeDataSetting : function(){
		 var TreeInitArray = new Array;

		 var treeTitle;
		 treeTitle = $('#systemId > option:selected').text();

		 TreeInitArray.push({ "id" : "ajson0", "parent" : "#", "text" : treeTitle});
		 this.treeDataArr = [];
		 var _this = this;
		 _this.isMoveCancel = false;
		

		  $.ifvSyncPostJSON('<ifvm:action name="getMenuListAuth"/>',
	  		 		{accountId : ifvmUserInfo.accountId},
	  					 function(result){
	  			 		 menuTree = new Object;
	  			 		 //메뉴정보 반복 get
	  		 			 $(result).each(function(index, item){
                            var TreeInitObject = new Object;
                            TreeInitObject.id=item.id;

                            if(item.parentMenuId==null || item.parentMenuId==''){
                                TreeInitObject.parent='ajson0';
                            } else {
                            	TreeInitObject.parent= item.parentMenuId;
                            }

                            TreeInitObject.text=item.menuName;
	 	  		 			TreeInitArray.push(TreeInitObject);

	 	  		 			var TreeUseObject = new Object;
	 	  		 		    TreeUseObject.menuName = item.menuName;
	 	  		 		    TreeUseObject.id = item.id;
	 	  		 		    TreeUseObject.imageURL = item.imgURL;
	 	  		 		    TreeUseObject.fileName = item.imgFile;
	 	  		 			TreeUseObject.menuNames = item.menuNameLang;
	 	  		 			TreeUseObject.parentMenuId = item.parentMenuId;
	 	  		 			TreeUseObject.isNew = false;
		 	  		 		TreeUseObject.menuLevel = item.menuLevel;
		 	  		 		TreeUseObject.progId = item.progId;
		 	  		 		TreeUseObject.privacyFlg = item.privacyFlg;
		 	  		 		TreeUseObject.mobileFlg = item.mobileFlg;

	 	  		 		    menuTree[item.id]= TreeUseObject;
			 	  			
	  		 			 });

	  		 			$('#tree').jstree({
					    	"core" : {
					    		"check_callback" : true,
					        	"data" : TreeInitArray,
					        	"multiple" : false,
					        	"themes":{
					                 "icons":false
					             }
							},
							"plugins" : ["dnd"]
	  		 		    }).bind('select_node.jstree', function (event, data) {
	  		 		      	//클릭시 수행
	  		 		    	$("[btnid=btnArea]").remove();

	  		 		    	if( data.node.original.isNew != true ){
	  		 		    		_this.makePlusMinusBtn(data.node.id);
	  		 		    	}

	  		 		    	getMenuNameLang(data.node.id);
	  		 		    	currMenuId = data.node.id;
	  		 		    	menuDetailInfo(data.node.id);
	  		 		    	programListInit(data.node.id);

	  		 		    }).bind("loaded.jstree", function (event, data) {

	  		 	            $(this).jstree("open_all");
							
	  		 	    	    var myParam = location.search.split('id=')[1];
	  		 	    	    var data;
	  		 	    	    var menuId;
	  		 	         	var sysId;

	  		 	    	    if(myParam){
		  		 	      	    data = location.search.split('id=');
		  		 	    	    menuId = data[1].split('&sys=')[0];
		  		 	    	    sysId = data[1].split('&sys=')[1];
		  		 	    	    $(this).jstree('select_node', menuId)
	  		 	    	    }
	  		 	    	    else{
	  		 	    	    	try{
		  		 	            $(this).jstree('select_node', TreeInitArray[0].id);
	  		 	    	    	}catch(e){};
	  		 	    	    }
	  		 		 }).bind("move_node.jstree", function (event, data) {  //마우스 이동 이벤트 부분 시작
	  		 			
	  		 			var check = false;
	  		 			
	  		 			if ( data.node.original.isNew == true ) {
	  						if ( data.node.original.isMove !== true ) {
	  							data.node.original.isMove = true;
	  							
	  							var tree = $('#tree').jstree(true);
	  							tree.move_node( data.node.id , data.old_parent, 'last' );
	  						}
	  						data.node.original.isMove = false;
	  						return;
	  					};

	  					if( _this.isMoveCancel == false )	//이동시
	  					{

	  						if(!data.node.original.isNew){

		  		 				if(confirm('<spring:message code="I02039"/>')){

  		  		 			 	    if(menuTree[data.parent] == undefined){
  		  		 			 	  		sortingTree(event, data);
  		  		 			 	    }
  		  		 			 	    else{
  		  		 			 	    	if(menuTree[data.parent].menuLevel == 3){
  		  		 			 	    		alert('<spring:message code="I02070"/>')
  		  		 			 	    		_this.isMoveCancel = true;

			 		    					var tree = $('#tree').jstree(true);
			 		    					tree.move_node( $("#" + data.node.id) , data.old_parent );
			 		    					check = false;
  		  		 			 	    	}
  		  		 			 	    	else{
  		  		 			 	    		sortingTree(event, data);
  		  		 			 	    		check = true;
  		  		 			 	    	}
  		  		 			 	    }
  		  		 			 	    if(check){
	  		  		 			 	  	 var children = data.node.children;
	  		  		 			 	  	 
	  			    					if( children.length > 0 && confirm( MESSAGE.storeManage.moveChildren ) === false ){
	  			    						//자식노드는 부모의 기존 부모id
	  			    						for( var i = 0; i<children.length; i++ ){
	  			    							_this.isMoveCancel = true;
	  			    							_this.moveNode( children[i], data.old_parent );
	  			    							
	  			    							var tree = $('#tree').jstree(true);
	  			    							tree.move_node( $("#" + children[i]) , data.old_parent );
	  			    						}
	  			    					}
	  		  		 			 	}
  		  		 			     }
  			    				else{
		  		  		 			//취소시 이전으로
	 		    					_this.isMoveCancel = true;
	 		    					var tree = $('#tree').jstree(true);
	 		    					tree.move_node( $("#" + data.node.id) , data.old_parent );
  		  		 			   	 }

		  		 			 }


	  					}
	  					else//이동취소해서 돌아왔을때
	  					{
	  						_this.isMoveCancel = false;
	  					}

  		 		   })
	  		 	});

	},

	makePlusMinusBtn : function( id ){
		
		$('#systemId').attr('treeId',id);
		
		//선택한 메뉴레벨 get
		if(!menuTree[id]) $('#systemId').attr('menuLevel', "0");
		else
			$('#systemId').attr('menuLevel', menuTree[id].menuLevel);
		
		var _this = this;
		var item = $("#"+ id);
		var btns = '';
		var menuOject = menuTree[id];


		try{
	    	if(menuOject.menuLevel=='1'|| menuOject.menuLevel=='2'){

	    		    btns += '<div style="position:absolute; top:0px;" btnId="btnArea"><button class="plus_minus_btn authCretBtn" btnId="plus">+<spring:message code="I02030" /></button><button class="plus_minus_btn authDelBtn" btnId="minus" style="margin-left:5px;">-<spring:message code="I02031" /></button></div>';
	    	}else if(menuOject.menuLevel=='3'){
	    		

		    	    btns += '<div style="position:absolute; top:0px;" btnId="btnArea"><button class="plus_minus_btn authDelBtn" btnId="minus" style="margin-left:5px;">-<spring:message code="I02031" /></button></div>';
	    	}
		}catch(e){}

		if($('#systemId').attr('treeid')=='ajson0'){
    		btns += '<div style="position:absolute; top:0px;" btnId="btnArea"><button class="plus_minus_btn authCretBtn" btnId="plus">+<spring:message code="I02030" /></button></div>';

    	}

	    jbtns = $(btns);

		 var tL = item.find('a').width() + 35;
		try{
			jbtns.css({'left' : tL });
		}catch(e){}

		item.css('position', 'relative');
		item.append(jbtns);

		var plusBtn = $("[btnId=plus]");
		plusBtn.click(function(){
			_this.createMenu();
		});

		var minusBtn = $("[btnId=minus]");
		minusBtn.click(function(){
			_this.deleteMenu();
		});


	},


	createMenu : function(){
		
		$('#menuName').val('');
		$('#menuLevel').val('');
		$('#fileValue').val('');
		$('#showImg').empty();

		var ref = $('#tree').jstree(true),
			sel = ref.get_selected();

		if(!sel.length) { return false; }

		var menuObject = new Object;
		menuObject.parentMenuId = $('#systemId').attr('treeId');
		 
		//현재 선택된 메뉴 레벨에 +1하여 신메뉴 레벨 세팅
 		var creMenuLevel = parseInt($('#systemId').attr('menuLevel'))+1;
 		$('#menuLevel').val(creMenuLevel);


		sel = sel[0];
		sel = ref.create_node(sel, {"type":"file", isNew : true, text: '<spring:message code="I02048" />'});
		if(sel) {
			$('#systemId').attr('treeId',sel);

			 menuObject.id =sel;
			 menuObject.menuLevel =  $('#menuLevel').val();
			 menuObject.isNew = true;
			 menuObject.menuNames = null;
			 menuObject.parentMenuId = menuObject.parentMenuId;
			 menuTree[sel] =menuObject;


			$('#tree').jstree("deselect_all");
	        $('#tree').jstree('select_node', sel);

		}
	},

	deleteMenu : function(){
		$('#menuName').val('');
		$('#menuLevel').val('');
		$('#fileValue').val('');
		$('#showImg').empty();
		

		var childrenArray = $($($('#'+$('#systemId').attr('treeId')+'_anchor').parent()).find('ul')).find('li');
		$(childrenArray).each(function(index, item){
			   var deleteObject = new Object;
			   deleteObject.menuId = $(item).attr('id');
			   delete menuTree[$(item).attr('id')];
			   deleteTree.push(deleteObject);

		});

		var deleteObject = new Object;
		deleteObject.menuId = $('#systemId').attr('treeId');
		delete menuTree[$('#systemId').attr('treeId')];
		deleteTree.push(deleteObject);



		var r = confirm('<spring:message code="I02040" />');
		if (r == true) {

			var ref = $('#tree').jstree(true),
			sel = ref.get_selected();
			if(!sel.length) { return false; }
			ref.delete_node(sel);
				  $.ifvSyncPostJSON('<ifvm:action name="deleteAuthMenuList"/>',
	   		 		{array : deleteTree},
	   					 function(result){
	   		 			    if($('#systemId').attr('treeid')=='ajson0'){
	   		 			    	$("#tree").jstree(true).refresh(menuId);
	   		 			    }else{
	   		 			    	$("#tree").jstree(true).refresh(menuId);
	   		 			    };

	   		      });
				  deleteTree = [];

		}
	}

};

function sortingTree(event, data){

	//이동하려는 상위 메뉴의 프로그램id 여부 체크
	//프로그램 정보가 연결되지 않은 메뉴로만 이동가능.
	if (data.node.parent == "ajson0") {
		menuTree[data.node.id].menuLevel = 1;
	} else if(!menuTree[data.node.parent].progId){
	//선택한 메뉴의 부모id 갯수
		var moveLevel = new Array;
		moveLevel =	[data.node.parents.length];
	//메뉴 이동시 메뉴레벨 지정
	//최상위 메뉴를 '#' 으로 고정되어 있으므로 '#' 제외한 레벨 지정.
		if(moveLevel [0] > 1)
		{menuTree[data.node.id].menuLevel = moveLevel [0] - 1;}
		}else{ 
		alert('<spring:message code="I02109"/>')
	    _this.isMoveCancel = true;

		var tree = $('#tree').jstree(true);
		tree.move_node( $("#" + data.node.id) , data.old_parent );
		check = false;
  	}

	   
	
	var updateSortArray= new Array;
	var updateObject;
    $($("#tree").jstree(true).get_json('#', { 'flat': true })).each(function(index, item){
    	updateObject = new Object;
		
    	if(item.id!='ajson0'){
    	  	updateObject.menuId = item.id;
        	updateObject.parentMenuId = item.parent;
        	updateObject.sortSeq = index;
        	updateObject.menuName = item.text
        	updateSortArray.push(updateObject);
        	updateObject.menuLevel = menuTree[item.id].menuLevel;
    	}
    });

    $.ifvSyncPostJSON('<ifvm:action name="updateAuthSortMenu"/>',
		{array : updateSortArray, accountId : ifvmUserInfo.accountId},
	function(result){});
}

function programListInit(menuId) {
	var ejGridOption = {
		serializeGridData : function(data){
			data.appServiceType = ifvmUserInfo.appServiceId;
			data.menuId = menuId;
			return data;
		},
		loadComplete : function(obj){
			progTypeCheck = null;
			for(var i = 0; i<obj.getCurrentViewData().length; i++){
				if(obj.getCurrentViewData()[i].progTypeCheck == 1){
					progTypeCheck = 1;
					break;
				}
			}
		},
        dataUrl : '<ifvm:action name="getAuthMenuProgList"/>',
        columns:[
        	  {
        		  field : 'progNum', headerText : '<spring:message code="I02044"/>', textAlign : 'center', customAttributes :{searchable : true ,index: 'p.pgm_no'}
        	  },{
          		  field : 'progName', headerText : '<spring:message code="I02045"/>', textAlign : 'center', customAttributes :{searchable : true,index: 'p.pgm_nm'} 
          	  },{
          		  field : 'progType', headerText : '<spring:message code="I02046"/>', textAlign : 'center', customAttributes :{searchable : true,index: 'cc.mark_name'}
          	  },{
          		  field : 'progPath', headerText : '<spring:message code="I02047"/>', textAlign : 'left', customAttributes :{searchable : true,index: 'p.pgm_path'}
          	  },{
          		  field : 'id', headerText : 'id', visible : false ,
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'progNum',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
    };
	programListGrid = $("#programListGridCon").ifvsfGrid({ ejGridOption : ejGridOption });
};

function searchFile(){
	
	$("#hideFile").trigger("click");
}

function init(){

    $('#addAuthMenuList').click(function(){
	    var arrayList = new Array;
      	
      	var value = menuTree[$('#systemId').attr('treeid')];
		delete value.imageId;
		delete value.imageURL;


		//메뉴명 리스트 셋팅
		var menuNameList = new Array;
		for(var i=0; i<$("#menuNameWrap").find('input').length; i++){

			if($("#menuNameWrap").find('input').eq(i).val() != null && $("#menuNameWrap").find('input').eq(i).val() != ''){
				var menuNameObj = new Object();
				menuNameObj.langCode = $("#menuNameWrap").find('input').eq(i).attr('id').split('_')[1];
				menuNameObj.langName = $("#menuNameWrap").find('input').eq(i).val();
				menuNameList.push(menuNameObj);
			}

		}
   	        arrayList.push(value);

		if($('#menuName').val()==''){
    		alert('<spring:message code="I02049"/>');
    	}else{

              	 if(confirm('<spring:message code="I02050"/>')){

              		 if(typeof value.isNew != 'undefined' && value.isNew){
              			updateData = false;
              		 }
              		 else{
              			updateData = true;
              		 }
                     $.ifvPostJSON('<ifvm:action name="addAuthMenuList"/>',
 	   	    		 		{
                    	 		menuId : value.id,
                    	 		testFileName : value.testFileName,
                    	 		fileName : fileName,
                    	 		update : updateData,
                    	 		accountId : ifvmUserInfo.accountId,
                    	 		menuNames : menuNameList,
                    	 		parentMenuId : value.parentMenuId,
                    	 		menuLevel : value.menuLevel,
                    	 		oriName : oriName,
                    	 		filePath : url,
                    	 		privacyFlg : $('#privacyFlg').prop('checked') ? 1 : 0,
								mobileFlg : $('#mobileFlg').prop('checked') ? 'Y' : 'N'
                    	 	}, function(){
									qtjs.reload();
 	   	    		        });
              	      }
           	}

    });

    $('#delAuthMenuListProg').click(function(){
   	 if($(programListGrid.opt.gridControl.getSelectedRecords()).length==0){
		   alert('<spring:message code="I02051"/>');
	   }else{
		   if(confirm('<spring:message code="I02040"/>')){
				var sendDataArray = new Array;
				var sendData = null;
				
		        $(programListGrid.opt.gridControl.getSelectedRecords()).each(function(index, item){
		        	
		    	    sendData = new Object;
		        	sendData.progId =  item.id;
		        	sendData.menuId = currMenuId;
		        	sendDataArray.push(sendData);
		        });

			 	 $.ifvSyncPostJSON('<ifvm:action name="delAuthMenuListProg"/>',{
		 		     array : sendDataArray},
				 function(result){
	 		    	   programListInit(currMenuId);
	             });
			}
	   }

    });

	$('#fileUploaderBtn').click(function(){
		if($('#systemId').attr('treeid').length >= 15){
		    $('#addAuthMenuList').attr('disabled',false);
		    menuTree[$('#systemId').attr('treeid')].update = true;
		 	$('#'+$('#systemId').attr('treeid')+'_anchor').css('color','red');
		}

		searchFile();
	});

	$('#menuLevel').attr('disabled',true);
	$('#fileValue').attr('disabled',true);
	$('#menuIcon').attr('disabled',true);

        selDiv = document.querySelector("#selectedFiles");

}

function handleFileSelect(evt) {

	var files = evt.target.files;
	if( files !== undefined ){
		var f = files[0];
		if(!f.type.match("image.*")) {
	    	return;
	    }

       var reader = new FileReader();
       reader.onload = function (e) {
           var formData = new FormData();
 			formData.append("file", $("#hideFile")[0].files[0]);
			$.ifvFilePostJSON('<ifvm:action name="tempUpload"/>', formData,
  				function(data){
   			    	
	   			    if( menuTree[$('#systemId').attr('treeid')].id >= 15){
		                    menuTree[$('#systemId').attr('treeid')].testFile = data[0].url;
		                    menuTree[$('#systemId').attr('treeid')].testFileName = data[0].name;
		                    menuTree[$('#systemId').attr('treeid')].update =true;
	   			    }else{
		                    menuTree[$('#systemId').attr('treeid')].testFile = data[0].url;
		                    menuTree[$('#systemId').attr('treeid')].testFileName = data[0].name;

	   			    }
	   			    //메뉴 이미지 세팅
	   			    fileName = data[0].fileName;
	   			    oriName = data[0].oriName;
	   			    url = data[0].url;
   				}
 			);

          menuTree[$('#systemId').attr('treeid')].fileName = f.name;

          $('#fileValue').val(f.name);

          $('#showImg').empty().append($('<img/>').attr('src',e.target.result));

        };
    	reader.readAsDataURL(f);
	}

 }


function showPop() {

	if(menuTree[$('#systemId').attr('treeid')].isNew == true){
		alert('<spring:message code="I02057"/>');
	}
	else{
		if($.fn.ifvmIsNotEmpty(programListGrid.opt.gridControl._gridRows[0])) {
			alert('<spring:message code="I02119"/>');
		}
		else {
		$.ifvLoadPop({url : '<ifvm:url name="authMenuListPopNew"/>', params : '', close : function(){}});
		}
	}
}
function menuDetailInfo(id){
	
	$('#systemId').attr('treeId',id);
	var _this = this;
	var item = $("#"+ id);
	var btns = '';
	var menuOject = menuTree[id];

	if(id=='ajson0'){
		$('#addAuthMenuList').attr('insert',true).removeAttr('update').attr('disabled',true);
		$('#contentsWrap').css('display','none');
	} else if(id.length >= 17) {
	    $('#addAuthMenuList').attr('insert',true).removeAttr('update').attr('disabled',false);
		$('#contentsWrap').css('display','');
		$('#programListGridCon').css('display','');
		$('#programListBtnMenu').css('display','');

	} else {
		$('#addAuthMenuList').attr('insert',true).removeAttr('update').attr('disabled',false);
	    $('#contentsWrap').css('display','');
		$('#programListGridCon').css('display','');
		$('#programListBtnMenu').css('display','');
	}

    if(menuOject){

    	//메뉴명 셋팅
    	if(typeof menuOject.menuNames != 'undefined' && menuOject.menuNames != null){
    		for(var i=0; i<menuOject.menuNames.length; i++){

    			$("#menu_" + menuOject.menuNames[i].langCode).val(menuOject.menuNames[i].langName);
    		}
    	}

		$('#menuLevel').val(menuOject.menuLevel);

		$('#fileValue').val(menuOject.fileName);

	 	if(menuOject.imageId)
	       	$('#showImg').empty().append($('<img/>').attr('src',menuOject.imageId.currentTarget.result));
	       	else if(menuOject.imageURL)
	       		$('#showImg').empty().append($('<img/>').attr('src',menuOject.imageURL));

	 	if(menuOject.privacyFlg === 1) {
		 	$('#privacyFlg').attr('checked', true);
	 	} else {
	 		$('#privacyFlg').attr('checked', false);
	 	}

		if(menuOject.mobileFlg == 'Y') {
			$('#mobileFlg').attr('checked', true);
		} else {
			$('#mobileFlg').attr('checked', false);
		}
	}
    if(menuOject.menuLevel=='1'){
			$('#imgRow').css('display','');
    		$('#showImg').css('display','');
	}else if(menuOject.menuLevel=='2'){
    		$('#showImg').css('display','none');
    		$('#imgRow').css('display','none');
	}



}

var setKoTempHtml = '';
setKoTempHtml += '<div class="row qt_border"><div class="input-group">';
setKoTempHtml += '<label class="control-label col-xs-2"><spring:message code="I02036"/></label>';
setKoTempHtml += '<div class="col-xs-8"><input type="text" maxlength="100" id="menu_ko" value="" class="form-control"></div>';
setKoTempHtml += '<label class="control-label" style="margin-left:10px"> 한글 </label></div></div>';
var setEnTempHtml = '';
setEnTempHtml += '<div class="row qt_border"><div class="input-group">';
setEnTempHtml += '<label class="control-label col-xs-2"><spring:message code="I02036"/></label>';
setEnTempHtml += '<div class="col-xs-8"><input type="text" maxlength="100" id="menu_en" value="" class="form-control"></div>';
setEnTempHtml += '<label class="control-label" style="margin-left:10px"> English </label></div></div>';


function getMenuNameLang(menuId){
	//아이콘 이름 초기화
	$("#menuIcon").val("")
	 $.ifvSyncPostJSON('<ifvm:action name="getMenuNameLang"/>',{
		 menuId : menuId
	 },	 function(result){
		 if(result.rows.length > 0 && result.rows[0].iconImg != null) $("#menuIcon").val(result.rows[0].iconImg.substring(result.rows[0].iconImg.lastIndexOf('/')+1));
			$("#menuNameWrap")[0].innerHTML = "";
		 var tempHtml = '';
		 
			 if(result.rows.length == 0){
				 	tempHtml += setKoTempHtml;
				 	tempHtml += setEnTempHtml;
			 } else if(result.rows.length == 1){
				 
				 for(var i=0; i<result.rows.length; i++){
						if(result.rows[i].langCode == "en"){
							tempHtml += setKoTempHtml;
						}
						
					 	tempHtml += '<div class="row qt_border"><div class="input-group">';
					 	tempHtml += '<label class="control-label col-xs-2"><spring:message code="I02036"/></label>';
					 	tempHtml += '<div class="col-xs-8"><input type="text" maxlength="100" id="menu_'+result.rows[i].langCode +'" value="'+result.rows[i].menuLangName + '" class="form-control"></div>';
					 	tempHtml += '<label class="control-label" style="margin-left:10px">' + result.rows[i].langName + '</label></div></div>';
					 	
					 	if(result.rows[i].langCode == "ko"){
					 		tempHtml += setEnTempHtml;
					 	}
				 }
				 	
			 } else{
				 for(var i=0; i<result.rows.length; i++){
					 	tempHtml += '<div class="row qt_border"><div class="input-group">';
					 	tempHtml += '<label class="control-label col-xs-2"><spring:message code="I02036"/></label>';
					 	tempHtml += '<div class="col-xs-8"><input type="text" maxlength="100" id="menu_'+result.rows[i].langCode +'" value="'+result.rows[i].menuLangName + '" class="form-control"></div>';
					 	tempHtml += '<label class="control-label" style="margin-left:10px">' + result.rows[i].langName + '</label></div></div>';
				 }
			 }
		
		 $("#menuNameWrap")[0].innerHTML += tempHtml;

     });

}



function authMenu(){

	//권한 설정
   	if($("#addAuthMenuList").attr('insert')){
  			 $("#addAuthMenuList").addClass('authCretBtn');
	   	}else if($("#addAuthMenuList").attr('update')){
	   		 $("#addAuthMenuList").addClass('authUpdateBtn');
	   	}

   	$.ifvmAdminCheck(true, true, true);

}

function searchIcon(){
	$("#menuIconPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="showMenuIcon"/>',
        contentType: "ajax",
        title: '<spring:message code="아이콘 목록"/>',
        width: 900,
        close : 'menuIconPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'menuIconPopupContainer'
        	});
        }
    });
}

function menuIconPopupClose() {
	menuIconPopupContainer._destroy();
} 

function removeIcon(){
	if(confirm('아이콘 적용 해제 하시겠습니까?')){
		$.ifvSyncPostJSON('<ifvm:action name="removeMenuIcon"/>',{menuId : currMenuId},function(result){
			alert('해제 되었습니다.');
			$("#menuIcon").val("");
		})
	}
}

$(document).ready(function() {
	
	init();

	$('#treeSplitWrap').split({
		orientation:'vertical',
		limit:100,
		position:'20%'
	}).css('min-height', 900);

	
	treeMenuList = new TreeMenuList();

	//찾아보기 값이 바꼈을 때
	$("#hideFile").on("change", function(e){
		handleFileSelect(e);
	});

	 authMenu();

});

//최초 컨텐츠 높이 정의.
$(window).on('load', function() {
	setTimeout(function() {
		var minHeight = Math.max( $("#sideMenu").height(), $(document).height() ) -234;
		$('#treeSplitWrap').css('min-height', minHeight);
	},1000);
});

</script>

<style type="text/css">
#systemManagerContent {min-height:100%; background:#fff}
.ifileBtn {margin-left:5px; height:27px; line-height:14px;}
#hideFile{display:none;}

#fileValue{
	width:89%;
}
.splitter_panel {
  position: relative;
}
.splitter_panel .vsplitter {
    background: #f4f6fa url('${pageContext.request.contextPath}/resources/images/beacon/store/splitter_arrow.png') no-repeat center;
    border-left:1px solid #aaaaaa;
    border-right:1px solid #8b8b8b;
    cursor: col-resize;
    z-index:900;
    width: 5px;
}
.splitter_panel .vsplitter:hover{
	background: #dadada url('${pageContext.request.contextPath}/resources/images/beacon/store/splitter_arrow.png') no-repeat center;
}
.splitter_panel .vsplitter:active{
	background: #f4f6fa url('${pageContext.request.contextPath}/resources/images/beacon/store/splitter_arrow2.png') no-repeat center;
}

.splitter_panel .hsplitter {
    background-color: #5F5F5F;
    cursor: row-resize;
    z-index: 800;
    height: 4px;
}
.splitter_panel .vsplitter.splitter-invisible,
.splitter_panel .hsplitter.splitter-invisible {
    background: none;
}
.splitter_panel .vsplitter, .splitter_panel .left_panel, .splitter_panel .right_panel,
.splitter_panel .hsplitter, .splitter_panel .top_panel, .splitter_panel .bottom_panel {
    position: absolute;
    overflow: auto;
}
.splitter_panel .vsplitter, .splitter_panel .left_panel, .splitter_panel .right_panel {
  height: 100%;
}
.splitter_panel .hsplitter, .splitter_panel .top_panel, .splitter_panel .bottom_panel {
  width: 100%;
}
.splitter_panel .top_panel, .splitter_panel .left_panel, .splitter_panel .vsplitter {
   top: 0;
}
.splitter_panel .top_panel, .splitter_panel .bottom_panel, .splitter_panel .left_panel, .splitter_panel .hsplitter {
   left: 0;
}
.splitter_panel .bottom_panel {
   bottom: 0;
}
.splitter_panel .right_panel {
   right: 0;
}
.splitterMask {
  position: absolute;
  left: 0;
  top: 0;
  right: 0;
  bottom: 0;
  z-index: 1000;
}

</style>

<div class="page-title">
	<h1>
		<spring:message code="I02027" />
		&gt; <spring:message code="M00273" />
	</h1>
</div>

<div class="well form-horizontal" id="disnone" style='display:none;'>
	<div class="row">
		<label class="col-xs-2 control-label"><spring:message code="I02043" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<select class="form-control" id="systemId" style="z-index:0">
					<option id="base" value="base"><spring:message code="I02032"/></option>
				</select>
			</div>
		</div>
	</div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02033"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" id='addAuthMenuList' text="I02029" btnType="save" objCode="addAuthMenuList_OBJ"/>
		</div>
	</div>
	
	<div id="treeSplitWrap" class="row store_manage">
		<!-- tree -->
		<div class="tree_menu" id="treeMenu">
			<div class="treeCon">
				<div id="tree">
	
				</div>
			</div>
		</div><!-- //tree -->
		<!-- contents -->
		<div id="systemManagerContent">
			<div style="min-width:700px;" id="contentsWrap">
				<div class="page_btn_area">
					<div class="col-xs-12">
						<span><spring:message code="I02033" /></span>
					</div>
				</div>
				<div class="well form-horizontal">
	
	
					 <div id="menuNameWrap">
	
					</div>
					<div class="row qt_border">
						<ifvm:inputNew type="text" id="menuLevel" maxLength="10" label="I02037" labelClass="2" conClass="9"/>
					</div>
					<div class="row qt_border">
						<ifvm:inputNew type="search" id="menuIcon" maxLength="10" label="메뉴 아이콘 적용" btnFunc="searchIcon" labelClass="2" conClass="7"/>
						<ifvm:inputNew type="button" id="removeIcon" btnFunc="removeIcon" text="아이콘 해제" btnType="minus" objCode="menuListIconRemove_OBJ"/>
					</div>
					<div class="row" id='imgRow'>
						<label class="col-xs-2 control-label"><spring:message code="I02038" /></label>
						<div class="col-xs-9">
							<div class="input-group file">
								 <form id="ajaxform" method="post" enctype="multipart/form-data">
										<ifvm:input type="file" id="hideFile" names="hideFile"/>
			                     </form>
								<ifvm:input type="text" id="fileValue" readonly="true" />
								<span class="pos_r">
									<button class="btn btn_sm btn_blueLight ifileBtn authCretBtn" id='fileUploaderBtn' objCode="fileUploaderBtn_OBJ">
										<spring:message code="I02034" />
									</button>
								</span>
							</div>
						</div>
					</div>
	
					<div class="row qt_border">
						<label class="col-xs-2 control-label"></label>
						<div class="col-xs-9">
							<div class="input-group file">
								<div id='showImg'></div>
							</div>
						</div>
					</div>

						<div class="row">
							<ifvm:inputNew type="singleCheckbox" id="privacyFlg" dto="privacyFlg" label="개인정보처리 메뉴 여부" values="1" labelClass="2" conClass="4" checked="false" nuc="true" desc="체크 시 AWS Workspace 에서만 접속 가능하도록 설정됩니다."/>
							<ifvm:inputNew type="singleCheckbox" id="mobileFlg" dto="mobileFlg" label="모바일 여부" labelClass="1" conClass="2" checked="false" nuc="true" />
						</div>

				</div>
	
				<div class="page_btn_area" id='programListBtnMenu'>
					<div class="col-xs-7">
						<span><spring:message code="I02035" /></span>
					</div>
					<div class="col-sm-5 searchbtn_r">
						<ifvm:inputNew type="button" id="menuListPopBtn" className="authCretBtn" btnFunc="showPop" text="I02030" btnType="plus" objCode="menuListPopBtn_OBJ"/>
						<ifvm:inputNew type="button" id="delAuthMenuListProg" className="authDelBtn" text="I02031" btnType="minus" objCode="delAuthMenuListProg_OBJ"/>
					</div>
				</div>
	
				<div id="programListGridCon"></div>
	
			</div>
		</div><!-- contents -->
	</div>
</div>
<div id="menuListPopModal"></div>

<div id="menuIconPopupContainer" class="popup_container"></div>
