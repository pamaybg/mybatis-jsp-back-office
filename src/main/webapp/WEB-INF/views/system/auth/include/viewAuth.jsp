<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jstree/jstree.min.js"></script>


<style>

div#tree.jstree-default .jstree-clicked {
    border-radius: 0;
    box-shadow: none;
    color: #000;
}
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

<script>
var selectedMenuId=null;
var selectedMenuList = new Array;
var treeMenuList; //tree menu
var menuTree = new Object;
var TreeInitArray = new Array;
var progNoAccessList = new Array;
var getMenuId = null;


function menuDetailInfo(id){
	
	
	$("#contentsWrap").show();
	var menuOject = menuTree[id];
	
    if(typeof menuOject != 'undefined' && menuOject != null){
		
    	//메뉴명 셋팅	
    	if(typeof menuOject.menuNames != 'undefined' && menuOject.menuNames != null){
    		for(var i=0; i<menuOject.menuNames.length; i++){
    			
    			$("#menu_" + menuOject.menuNames[i].langCode).val(menuOject.menuNames[i].langName);
    		}
    	}
		
		$('#menuLevel').val(menuOject.menuLevel);
		
	 	if(menuOject.imageURL != null){
	 		$('#showImg').empty().append($('<img/>').attr('src',menuOject.imageURL));
	 	}
	 	
	 	if(menuOject.menuLevel=='1'){
			if(ifvmUserInfo.admFlag == '1'){
				$('#imgRow').css('display','');
	    		$('#showImg').css('display',''); 
			}		
		}else if(menuOject.menuLevel=='2'){
			if(ifvmUserInfo.admFlag == '1'){
	    		$('#showImg').css('display','none');
	    		$('#imgRow').css('display','none'); 
			}
	 	}
	 	
   	}	
    
}
	

function getMenuNameLang(menuId){
	
	 $.ifvSyncPostJSON('<ifvm:action name="getMenuNameLang"/>',{
		 menuId : menuId
	 }, function(result){
			
			$("#menuNameWrap")[0].innerHTML = "";
		 var tempHtml = '';
		 
		 for(var i=0; i<result.rows.length; i++){		
			 	tempHtml += '<div class="row qt_border"><div class="input-group">';
			 	tempHtml += '<label class="control-label col-xs-2"><spring:message code="I02036"/></label>';
			 	tempHtml += '<div class="col-xs-8"><input type="text" maxlength="100" disabled="true" id="menu_'+result.rows[i].langCode + '" value="'+result.rows[i].menuLangName + '" class="form-control"></div>';
			 	tempHtml += '<label class="control-label" style="margin-left:10px">' + result.rows[i].langName + '</label></div></div>';
		 }

		 $("#menuNameWrap")[0].innerHTML += tempHtml;
		
    }); 	
	 
}

TreeMenuList = function(){
	this.init();
};

TreeMenuList.prototype = {
	
	init : function(){
		this.getTreeDataSetting();
	},
	
	getTreeDataSetting : function(){
					
		 
		 var _this = this; 
		 
		 //메뉴 리스트 조회
		 $.ifvSyncPostJSON('<ifvm:action name="getAuthMenuList"/>',
				{	authId : authId
				},
			function( result ){
				selectedMenuList = [];
				
				//메뉴 체크
				TreeInitArray.push({ "id" : "ajson0", "parent" : "#", "text" : 'MENU LIST'});
				
				for(var i=0; i<result.length; i++){
					
					if(result[i].checkedMenuId != null && result[i].checkedMenuId != 'null'){
						selectedMenuList.push(result[i].checkedMenuId)
					}
					
					if(result[i].parentMenuId==null || result[i].parentMenuId=='null'){
						TreeInitArray.push({"id": result[i].menuId, "parent" : "ajson0", "menuName" : result[i].menuName, "text" : result[i].menuName});	
                   }else{
                	   TreeInitArray.push({"id": result[i].menuId, "parent" : result[i].parentMenuId, "menuName" : result[i].menuName, "text" : result[i].menuName});	
                   }
					
					var TreeUseObject = new Object;
	  		 		    TreeUseObject.menuName = result[i].menuName;
	  		 		    TreeUseObject.id = result[i].menuId;
	  		 		    TreeUseObject.imageURL = result[i].imgURL;
	  		 			TreeUseObject.menuNames = result[i].menuNameLang;
	  		 			TreeUseObject.parentMenuId = result[i].parentMenuId;
	  		 			
	  		 		    if(result[i].menuLevel=='1')
	  		 		    TreeUseObject.menuLevel ='1'; 
	  		 		    
	  		 		    else
 	  		 			TreeUseObject.menuLevel ='2'; 
	  		 		   
	  		 		    menuTree[result[i].menuId]= TreeUseObject;	
	  		 		    
					
				}
				
				
			});
		 
	   	
			$('#tree').jstree({
		    	"core" : {
		    		"check_callback" : true,
		        	"data" : TreeInitArray,
		        	"multiple" : true,
		        	"themes":{
		                 "icons":false
		             }
				},
				"checkbox":{
			      "keep_selected_style" : false,
			      "three_state"	: false
				},
			    "plugins" : [  "checkbox" ]
		    }).bind('select_node.jstree', function (event, data) {
			 		
 		    		if(data.node.id != 'ajson0'){
						    

					} 
	 		    	
		    }).bind("loaded.jstree", function (event, data) {
	 	           $(this).jstree("open_all");

		 	   	 	for(var i = 0; i<selectedMenuList.length; i++){
		 		 		$("#tree").jstree('select_node', selectedMenuList[i]);
		 		 	}
	 		});
	}
	
}

//메뉴에대한 프로그램 리스트 나오게하기
function programListInit(menuId) {
	var ejGridOption = {
		recordClick : function(args){
			programId = args.data.id;
    	},
		serializeGridData : function(data){
			data.appServiceType = ifvmUserInfo.appServiceId;
			data.authId =  authId;
			data.menuId = menuId;
			return data;
		},
        dataUrl : '<ifvm:action name="getProgramAccessList"/>',
        columns:[
        	    {
        		  field : 'progNum', headerText : '<spring:message code="I02044"/>', headerTextAlign : 'center', textAlign : 'center',
        	  },{
          		  field : 'progName', headerText : '<spring:message code="I02045"/>', headerTextAlign : 'center', textAlign : 'center',
          	  },{
          		  field : 'progType', headerText : '<spring:message code="I02046"/>', headerTextAlign : 'center', textAlign : 'center',
          		  customAttributes : {
          			  index : 'progTypeCd' }
          	  },{
          		  field : 'progPath', headerText : '<spring:message code="I02047"/>', headerTextAlign : 'center', textAlign : 'center',
          	  }, {
          		  field : 'programId', headerText : 'id', visible : false , 
          	  } 
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'progNum',
      	  sord : 'desc',
      	  _search : false
  
        },
        rowList : [10,25,50,100],
        radio: false,
        tempId : 'ifvGridSimplePageTemplete',
    };
	programListGrid = $("#programListGridCon").ifvsfGrid({ ejGridOption : ejGridOption });
};
	
$(document).ready(function() {
	
	
	
	treeMenuList = new TreeMenuList();
	
	$("#contentsWrap").hide();
	
	$('#treeSplitWrap').split({
		orientation:'vertical',
		limit:100,
		position:'20%'
	}).css('min-height', 500);
	
	$("#viewSaveBtn").click(function(){
		
		if(authId != null && authId != ''){
			
			var checkTree = $('#tree').jstree("get_selected");
			 var resultTree = [];
			 var menuList = [];
			 
			 for(j=0; j<checkTree.length; j++){
				 if(checkTree[j] != "ajson0"){
					 menuList.push(checkTree[j]);
				 }
			 }
			 
			 var jsonData = {	
					menuIdList : menuList,
					authId : authId
				}
			 
			 if(confirm('<spring:message code="I01881"/>') === false) return;
			 
			 var _callBack = function(result){
				if(result.success == true){
					 if(result.message) alert(result.message);
					 else alert('<spring:message code="I00741"/>');
				} else{
					if(result.message) alert(result.message);
					else alert('<spring:message code="I00742"/>');
				}
			 };
			 
			 $.ifvSyncPostJSON( '<ifvm:action name="setViewAuthList"/>', jsonData, _callBack.bind(this),   _callBack.bind(this), null, "#btnSave" );
			 
		}
		else{
			alert('<spring:message code="I02103"/>');		
		}
		
	});
	
	//all checked
	$("#tree").on("click", ".jstree-anchor", function(e, data) {
			
			var id = $(this).parent().attr('id');
			getMenuNameLang(id);
			menuDetailInfo(id);
			 programListInit(id); 
			
		   if(this.id.indexOf('ajson0') == 0){
			   
			   var count = 0;
			   
			   for(var i=0; i<$('#tree').jstree("get_selected").length; i++){
					
					if($('#tree').jstree("get_selected")[i] == 'ajson0'){
						count += 1;
					}
				}
			   
			   if(count > 0){
				   $("#tree").jstree("check_all");
			   }
			   else{
				   $("#tree").jstree("uncheck_all");
			   }
			   
			   
		   }
			   
	});
	
	$.ifvmAdminCheck(true,true,true);
	
});


</script>
 
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="I02096" /></span>
	</div>
	
	 <div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="viewSaveBtn" className="authUpdateBtn" text="I02029" btnType="save" objCode="viewSaveBtn_OBJ"/>
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
	
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="I02033" /></span>		
			</div>
		</div>
		
		<div style="min-width:700px;" id="contentsWrap">
			<div class="well form-horizontal">
				<div id="menuNameWrap">
					
				</div> 
				<div class="row qt_border">
					<ifvm:inputNew type="text" id="menuLevel" disabled="true" maxLength="10" label="I02037" labelClass="2" conClass="8"/>
				</div> 
				<div class="row" id='imgRow'>
					<label class="col-xs-2 control-label"><spring:message code="I02038" /></label>
					<div class="col-xs-9">
						<div class="input-group file">
							<div id="showImg"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
 		<div class="page_btn_area">
		    <div class="col-xs-7">
		        <span><spring:message code="I02114"/></span>
		    </div> 
		</div> 
		<div id="programListGridCon"></div>
	</div><!-- contents -->
</div>
