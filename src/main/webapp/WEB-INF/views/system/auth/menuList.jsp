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
                            }else{
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

	  		 		    	getMenuNameLang();
	  		 		    	currMenuId = data.node.id;
	  		 		    	menuDetailInfo(data.node.id);
	  		 		    	programListInit(data.node.id);

	  		 				

	  		 		    }).bind("loaded.jstree", function (event, data) {
	  		 		    	
	  		 	            // you get two params - event & data - check the core docs for a detailed description
	  		 	            $(this).jstree("open_all");
							
	  		 	    	    var myParam = location.search.split('id=')[1];
	  		 	    	    var data;
	  		 	    	    var menuId;
	  		 	         	var sysId;

	  		 	    	   //console.log(location.search.split('id='));

	  		 	    	    if(myParam){
		  		 	      	    data = location.search.split('id=');
		  		 	    	    //console.log(data[1].split('&sys='));
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
  		  		 			    	/* sortingTree(event, data);
  		  		 			 	    $("#tree").jstree(true).refresh( $( "#"+ data.node.id ) ); */
  		  		 			 	    
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
			   //console.log($(item).attr('id'));
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

			//console.log(deleteTree);

				  $.ifvSyncPostJSON('<ifvm:action name="deleteAuthMenuList"/>',
	   		 		{array : deleteTree},
	   					 function(result){
	   		 			    if($('#systemId').attr('treeid')=='ajson0'){
	   		 			    	//location.reload();
	   		 			    	$("#tree").jstree(true).refresh(menuId);
	   		 			    }else{
	   		 			    	//location.href='<ifvm:url name="getMenuList"/>';
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
	if(!menuTree[data.node.parent].progId){
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
			/*
        	if(menuTree[item.id].menuLevel=='1')
        		updateObject.menuLevel='1';
        	else
        	    updateObject.menuLevel ='2';
        	*/
        	updateObject.menuLevel = menuTree[item.id].menuLevel;
    	}
    });

    $.ifvSyncPostJSON('<ifvm:action name="updateAuthSortMenu"/>',
		{array : updateSortArray, accountId : ifvmUserInfo.accountId},
	function(result){
     	//location.reload();
    });
}

function programListInit(menuId) {
	var jqGridOption = {
		onSelectCell : function (data) {
		},
		serializeGridData : function(data){
			data.appServiceType = ifvmUserInfo.appServiceId;
			//data.menuId = $('#systemId').attr('treeid');
			data.menuId = menuId;
		},
		loadComplete : function(obj){
			
			progTypeCheck = null;
			for(var i = 0; i<obj.rows.length; i++){
				if(obj.rows[i].progTypeCheck == 1){
					progTypeCheck = 1;
					break;
				}
			}

		},
        url : '<ifvm:action name="getAuthMenuProgList"/>',
        colNames:[
                   '<spring:message code="I02044"/>',
                   '<spring:message code="I02045"/>',
                   '<spring:message code="I02046"/>',
                   '<spring:message code="I02047"/>',
                   'id'
                   ],
        colModel:[
					{ name:'progNum', index:'p.pgm_no', resizable : false,  align:'center'  },
					{ name:'progName', index:'p.pgm_nm', resizable : false },
					{ name:'progType', index:'p.pgm_type_cd', resizable : false, align:'center' },
					{ name:'progPath', index:'p.pgm_path', resizable : false },
					{ name:'id', index:'mpr.id', hidden: true, resizable : false }
        ],
        multiselect: true,
        sortname: 'p.create_date',
        sortorder: "desc",
        rowList: $.ifvmGetSelectBoxNum()
    };
	programListGrid = $("#programListGridCon").ifvGrid({ jqGridOption : jqGridOption });
};

function searchFile(){
	
	$("#hideFile").trigger("click");
}

function init(){

    $('#addAuthMenuList').click(function(){
  	    
	    var arrayList = new Array;
      	
      	var value = menuTree[$('#systemId').attr('treeid')];
		//value.appServiceType = $('#systemId').val();
		delete value.imageId;

		/* if(value.parentMenuId =='ajson0')
	    value.parentMenuId = null; */

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
		//if(value.id.length!=24){
   	        arrayList.push(value);
		    //}

		if($('#menuName').val()==''){
    		alert('<spring:message code="I02049"/>');
    	}else{


              	 //console.log(arrayList);
              	 if(confirm('<spring:message code="I02050"/>')){

              		 if(typeof value.isNew != 'undefined' && value.isNew){
              			updateData = false;
              		 }
              		 else{
              			updateData = true;
              		 }
	  	    		  /*  if($(this).attr('insert')){
	  	    			 updateData = false;
	  	    		   }else if($(this).attr('update')){
		  	    	     updateData = true;
	  	    		   } */

                     $.ifvSyncPostJSON('<ifvm:action name="addAuthMenuList"/>',
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
                    	 		filePath : url
                    	 	}, function(result){
 	   	    		 			    //
 	   	    		 			    //window.location='<ifvm:url name="menuList"/>?id='+result.message+'&sys='+$('#systemId').val();
 	   	    						
 	   	    						//location.reload();
									qtjs.reload();
 	   	    		        });
              	      }
           	}

    });

    $('#delAuthMenuListProg').click(function(){
   	 if($(programListGrid.getCheckedGridData()).length==0){
		   alert('<spring:message code="I02051"/>');
	   }else{
		   if(confirm('<spring:message code="I02040"/>')){
				var sendDataArray = new Array;
				var sendData = null;
				
		        $(programListGrid.getCheckedGridData()).each(function(index, item){
		        	
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



	/* $('#menuName').keyup(function(){
		 if($('#systemId').attr('treeid').length >= 15){

			 if($('#'+$('#systemId').attr('treeid')+'_anchor').text()!=$(this).val()){
			     $('#addAuthMenuList').attr('disabled',false);
			 	$('#'+$('#systemId').attr('treeid')+'_anchor').css('color','red');
				 menuTree[$('#systemId').attr('treeid')].update = true;
			 }else{
				$('#addAuthMenuList').attr('disabled',true);
				$('#'+$('#systemId').attr('treeid')+'_anchor').css('color','black');
				 menuTree[$('#systemId').attr('treeid')].update = false;
			 }
		 }


		 menuTree[$('#systemId').attr('treeid')].menuName = $(this).val();

	}); */

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

	 //document.getElementById('hideFile').addEventListener('change', handleFileSelect, false);
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
          //console.log(e.currentTarget.result);

           var formData = new FormData();
 			formData.append("file", $("#hideFile")[0].files[0]);

 			//console.log($("#hideFile")[0].files[0]);

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
          //$('#hideFile').val('');  change이벤트 실행하므로 주석처리함
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
		//$("#menuListPopModal").ifvmLoad('<ifvm:url name="menuListPop"/>');
		$.ifvLoadPop({url : '<ifvm:url name="authMenuListPop"/>', params : '', close : function(){}});
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
		//$('#addAuthMenuList').attr('update',true).removeAttr('insert');
	    $('#addAuthMenuList').attr('insert',true).removeAttr('update').attr('disabled',false);
		$('#contentsWrap').css('display','');
		$('#programListGridCon').css('display','');
		$('#programListBtnMenu').css('display','');

		/* if(!menuOject.update){
	        $('#addAuthMenuList').attr('disabled',true);
		}else{
	        $('#addAuthMenuList').attr('disabled',false);
		} */
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


		//$('#menuName').val(menuOject.menuName);
		$('#menuLevel').val(menuOject.menuLevel);

		//console.log(menuOject.fileName);
		$('#fileValue').val(menuOject.fileName);

	 	if(menuOject.imageId)
	       	$('#showImg').empty().append($('<img/>').attr('src',menuOject.imageId.currentTarget.result));
	       	else if(menuOject.imageURL)
	       		$('#showImg').empty().append($('<img/>').attr('src',menuOject.imageURL));


	}/* else{
		$('#menuName').val('');
		$('#menuLevel').val('');
		$('#fileValue').val('');
		$('#showImg').empty();
	}	 */


    if(menuOject.menuLevel=='1'){
			$('#imgRow').css('display','');
    		$('#showImg').css('display','');
	}else if(menuOject.menuLevel=='2'){
    		$('#showImg').css('display','none');
    		$('#imgRow').css('display','none');
	}



}





function getMenuNameLang(){

	 $.ifvSyncPostJSON('<ifvm:action name="getMenuNameLang"/>',{},
	 function(result){
			
			$("#menuNameWrap")[0].innerHTML = "";
		 var tempHtml = '';

		 for(var i=0; i<result.rows.length; i++){

			 	tempHtml += '<div class="row qt_border"><div class="input-group">';
			 	tempHtml += '<label class="control-label col-xs-2"><spring:message code="I02036"/></label>';
			 	tempHtml += '<div class="col-xs-8"><input type="text" maxlength="100" id="menu_'+result.rows[i].langCode + '" class="form-control"></div>';
			 	tempHtml += '<label class="control-label" style="margin-left:10px">' + result.rows[i].langName + '</label></div></div>';
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

$(document).ready(function() {
	
	//$.ifvmLnbSetting('ifvm');

	init();

	$('#treeSplitWrap').split({
		orientation:'vertical',
		limit:100,
		position:'20%'
	}).css('min-height', 900);

	
	treeMenuList = new TreeMenuList();
	//programListInit();

	//찾아보기 값이 바꼈을 때
	$("#hideFile").on("change", function(e){
		handleFileSelect(e);
		//changeFile();
	});

	//tree resize했을 때 grid width 맞춰주기
	 /* $("#contentsWrap").resize(function(){
		programListGrid.setWidth($("#contentsWrap").width());
	}); */

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
/* #local{
 font-weight :bold ;
   display: block;
  float: left;
  margin-top: 10px;
  margin-left: 2px;
  color: rgb(252, 24, 24);
} */
#systemManagerContent {min-height:100%; background:#fff}
.ifileBtn {margin-left:5px; height:27px; line-height:14px;}
#hideFile{display:none;}
</style>

<style>

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
		<spring:message code="I02026" />
		<span> &gt; <spring:message code="I02027" /></span>
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


<div class="page_btn_area">
	<div class="col-sm-7">
		<span><spring:message code="I02033"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id='addAuthMenuList' text="I02029" btnType="save"/>
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

				 	<%-- <div class="input-group">
				 		<ifvm:inputNew type="text" id="menuName" label="I02036" labelClass="2" conClass="8"/>
				 		<label class="control-label"></label>
				 	</div> --%>

				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="text" id="menuLevel" maxLength="10" label="I02037" labelClass="2" conClass="9"/>
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
								<a class="btn btn_sm btn_blueLight ifileBtn authCretBtn" id='fileUploaderBtn'><spring:message code="I02034" /></a>
							</span>
						</div>
					</div>
				</div>

				<div class="row">
					<label class="col-xs-2 control-label"></label>
					<div class="col-xs-9">
						<div class="input-group file">
							<div id='showImg'></div>
						</div>
					</div>
				</div>
			</div>

			<div class="page_btn_area" id='programListBtnMenu'>
				<div class="col-xs-7">
					<span><spring:message code="I02035" /></span>
				</div>
				<div class="col-sm-5 searchbtn_r">
					<%-- <button id='menuListPopBtn' class="btn btn-sm btn_gray authCretBtn" onClick="showPop()"><i class="fa fa-plus"></i>
						<spring:message code="I02030" />
					</button> --%>
					<ifvm:inputNew type="button" id="menuListPopBtn" className="authCretBtn" btnFunc="showPop" text="I02030" btnType="plus"/>
					<%-- <button class="btn btn-sm btn_gray authDelBtn" id='delAuthMenuListProg'><i class="fa fa-minus"></i>
						<spring:message code="I02031" />
					</button> --%>
					<ifvm:inputNew type="button" id="delAuthMenuListProg" className="authDelBtn" text="I02031" btnType="minus"/>
				</div>
			</div>

			<div id="programListGridCon"></div>

		</div>
	</div><!-- contents -->
</div>

<div id="menuListPopModal"></div>
