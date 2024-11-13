<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link href="${pageContext.request.contextPath}/resources/js/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jstree/jstree.min.js"></script>


<style>
#showImg{
	margin-top: 10px;
}

#showImg img{
	padding:3px;
	border:1px solid #ccc;
}

#local{
 font-weight :bold ;
   display: block;
  float: left;
  margin-top: 10px;
  margin-left: 2px;
  color: rgb(252, 24, 24);
}

#systemManagerContent {min-height:100%; background:#fff}
.ifileBtn {margin-left:5px; height:27px; line-height:14px;}
#hideFile{display:none;}	
#tree { margin-top: 10px; margin-left: 10px;}
#contentsWrap {min-width: 700px;}
</style>

<script type="text/javascript">
var treeMenuList; //tree menu
var programListGrid; //프로그램 목록 grid
var menuTree = new Object;
var deleteTree = new Array;

function systemSelect(select){
	 $.ifvSyncPostJSON('<ifvm:action name="getAccountId"/>',{
		 
	 },
	 function(result){	   	
		 	for(var i=0;i<result.length;i++){
		 		select.append($('<option/>').text(result[i].name).val(result[i].id));	 
		 		
		 		
		 	}
		 	
		 
	    	/*  $(result.rows).each(function(index, item){	 
	    		 select.append($('<option/>').text(item.and_app_name)
	    				  .val(item.id));	 
	    	 }); */
           	
	    	var chkSession = $.ifvmGetUserInfo().appServiceId;
	    	if(chkSession!='null' || chkSession!=null ) 
	    		//select.val(chkSession);
	    	 	
	           var myParam = location.search.split('id=')[1];
	 	    	  if(myParam){
	 		    	    //console.log(location.search.split('id='));
	 		    	    var data = location.search.split('id=');
	 		    	    //console.log(data[1].split('&sys='));
	 		    	    //var menuId = data[1].split('&sys=')[0];
	 		    	    var sysId = data[1].split('&sys=')[1];
	 		    	    
	 		    	    //select.val(sysId); 	 	    		  
	 	    	  }

	    		select.change(function(){
	    		
	 	    	  if(myParam){
		    		location.search = location.search.substring(0, location.search.indexOf('?'));
		    		firstLoad = true;
	    		}

		 		deleteTree = new Array; 		 
	    		$('#tree').jstree("destroy");
	    		treeMenuList = new TreeMenuList();
	    	});
	 });
}



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

		  
		  $.ifvSyncPostJSON('<ifvm:action name="getMenuList"/>',
	  		 		{accountId : $('#systemId').val()},
	  					 function(result){	
	  			 		 menuTree = new Object; 		 			  
	  		 			
	  		 			 $(result).each(function(index, item){
                            var TreeInitObject = new Object;                            
                            TreeInitObject.id=item.id;
                            
                            if(item.parentMenuId==null || item.parentMenuId=='null'){
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
	 	  		 		    
	 	  		 		    if(item.menuLevel=='1')
	 	  		 		    TreeUseObject.menuLevel ='LEVEL 1'; 
	 	  		 		    
	 	  		 		    else
		 	  		 		TreeUseObject.menuLevel ='LEVEL 2'; 
	 	  		 		   
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
	  		 		    	_this.makePlusMinusBtn(data.node.id);
	  		 	            
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
		  		 	            $(this).jstree('select_node', TreeInitArray[1].id);	  	
	  		 	    	    	}catch(e){};
	  		 	    	    }
	  		 		 }).bind("move_node.jstree", function (event, data) {
                            
	  		 			     if(confirm('<spring:message code="M00212"/>')){
	  		 			    	sortingTree(event, data); 	 
	  		 			     }else{
	  		 			    	$("#tree").jstree(true).refresh();
	  		 			   }
	  		 		   })
	  		 	}); 
			
	},
	
	makePlusMinusBtn : function( id ){		
		$('#systemId').attr('treeId',id);
		var _this = this;
		var item = $("#"+ id);
		var btns = '';
		var menuOject = menuTree[id];
		
		if(id=='ajson0'){
			$('#addMenuList').attr('insert',true).removeAttr('update').attr('disabled',true);
			$('#contentsWrap').css('display','none');
		} else if(id.length >= 17) {
			$('#addMenuList').attr('update',true).removeAttr('insert').attr('disabled',true);
			$('#updateMenuList').css('display','');
		    $('#contentsWrap').css('display','');
			$('#programListGrid').css('display','');
			$('#programListBtnMenu').css('display','');
			
			if(!menuOject.update){
		        $('#addMenuList').attr('disabled',true); 		
			}else{
		        $('#addMenuList').attr('disabled',false); 		
			}
		} else {
			$('#addMenuList').attr('insert',true).removeAttr('update').attr('disabled',false);
		    $('#contentsWrap').css('display','');
			$('#updateMenuList').css('display','none');
			$('#programListGrid').css('display','none');
			$('#programListBtnMenu').css('display','none');
		}
		
		var jbtns;
		try{
    	if(menuOject.menuLevel=='LEVEL 1'){
    		$('#imgRow').css('display','');
    		$('#showImg').css('display','');
		    btns += '<div style="position:absolute; top:0px;" btnId="btnArea"><button class="plus_minus_btn" btnId="plus">+<spring:message code="C00085" /></button><button class="plus_minus_btn" btnId="minus" style="margin-left:5px;">-<spring:message code="M00232" /></button></div>';		
    	}else if(menuOject.menuLevel=='LEVEL 2'){
    		$('#showImg').css('display','none');
    		$('#imgRow').css('display','none');
    	    btns += '<div style="position:absolute; top:0px;" btnId="btnArea"><button class="plus_minus_btn" btnId="minus" style="margin-left:5px;">-<spring:message code="M00232" /></button></div>';		
    	}
    	 
    
    	
		}catch(e){}
		
		if($('#systemId').attr('treeid')=='ajson0'){
    		btns += '<div style="position:absolute; top:0px;" btnId="btnArea"><button class="plus_minus_btn" btnId="plus">+<spring:message code="C00085" /></button><button class="plus_minus_btn" btnId="minus" style="margin-left:5px;">-<spring:message code="M00232" /></button></div>';		
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
		
	
		
		if(menuOject){
			$('#menuName').val(menuOject.menuName);
			$('#menuLevel').val(menuOject.menuLevel);

			//console.log(menuOject.fileName);
			$('#fileValue').val(menuOject.fileName);
			
		 	if(menuOject.imageId)
		       	$('#showImg').empty().append($('<img/>').attr('src',menuOject.imageId.currentTarget.result)); 
		       	else if(menuOject.imageURL) 
		       		$('#showImg').empty().append($('<img/>').attr('src',menuOject.imageURL));
		    
			
		}else{
			$('#menuName').val('');
			$('#menuLevel').val('');
			$('#fileValue').val('');
			$('#showImg').empty();
		}			
			
	    programListInit();
	},
	

	createMenu : function(){
		//console.log('CREATEMENU');
		$('#menuName').val('');
		$('#menuLevel').val('');
		$('#fileValue').val('');
		$('#showImg').empty();
		
		var ref = $('#tree').jstree(true),
			sel = ref.get_selected();
		
		if(!sel.length) { return false; }
			
		 var menuObject = new Object;
		 menuObject.parentMenuId = $('#systemId').attr('treeId');

		if($('#systemId').attr('treeid')=='ajson0')
			   $('#menuLevel').val('LEVEL 1');
			else
			   $('#menuLevel').val('LEVEL 2');
		
		sel = sel[0];
		sel = ref.create_node(sel, {"type":"file", text: '<spring:message code="M00204" />'});
		if(sel) {
			$('#systemId').attr('treeId',sel);			      
			
			 menuObject.id =sel;
			 menuObject.menuLevel =  $('#menuLevel').val();
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
		
		//console.log($($($('#'+$('#systemId').attr('treeId')+'_anchor').parent()).find('ul')).find('li'));	
		
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

		
		
		var r = confirm('<spring:message code="M00127" />');
		if (r == true) {
			
			var ref = $('#tree').jstree(true),
			sel = ref.get_selected();
			if(!sel.length) { return false; }
			ref.delete_node(sel);
			
			//console.log(deleteTree);
			
				  $.ifvSyncPostJSON('<ifvm:action name="deleteMenuList"/>',
		    		 		{array : deleteTree}, 
		    					 function(result){
		    		 			    if($('#systemId').attr('treeid')=='ajson0'){
		    		 			    	//location.reload();
		    		 			    	qtjs.reload();
		    		 			    }else{
		    		 			    	location.href='<ifvm:url name="getMenuList"/>';
		    		 			    	qtjs.href('<ifvm:url name="getMenuList"/>');
		    		 			    };
		    		 			
		    		             }); 	 
			   				
		}
	}
	
};



function sortingTree(event, data){
	
	if(menuTree[data.parent]==undefined){
		menuTree[data.node.id].menuLevel ='LEVEL 1';
	}else{
		menuTree[data.node.id].menuLevel ='LEVEL 2';
	}	
	
	
	var updateSortArray= new Array;
	var updateObject;
    $($("#tree").jstree(true).get_json('#', { 'flat': true })).each(function(index, item){
    	updateObject = new Object;
    	//console.log(item);    	
    	//console.log(menuTree[item.id]);
    	
    	if(item.id!='ajson0'){
    	  	updateObject.menuId = item.id;
        	updateObject.parentMenuId = item.parent;        	
        	updateObject.sortSeq = index;
        	updateSortArray.push(updateObject);	        	
        	
        	if(menuTree[item.id].menuLevel=='LEVEL 1')
        		updateObject.menuLevel='1';
        	else
        	    updateObject.menuLevel ='2';
    	}	
    });
       
	//console.log(updateSortArray);
   
  	      $.ifvSyncPostJSON('<ifvm:action name="updateSortMenu"/>',
		 		{array : updateSortArray}, 
					 function(result){
 			 			     //location.reload();
						 qtjs.reload();
		             }); 	   
 				
	
}


function programListInit() {
	var jqGridOption = {
		onSelectCell : function (data) {
		},
		serializeGridData : function(data){
			data.appServiceType = $('#systemId').val();
			data.menuId = $('#systemId').attr('treeid');
		},
		loadComplete : function(obj){			 
		},
        url : '<ifvm:action name="getMenuProgList"/>',
        colNames:[ 
                   '<spring:message code="M00187"/>',
                   '<spring:message code="M00179"/>',
                   '<spring:message code="M00176"/>',
                   '<spring:message code="M00180"/>',
                   '<spring:message code="M00182"/>',
                   'progId'
                   ],
        colModel:[
            { name:'applyType', index:'aa.applyType', resizable : false, align : 'center' },
            { name:'progNum', index:'aa.progNum', resizable : false, key: true, align:'center'  },
            { name:'progName', index:'aa.progName', resizable : false },
            { name:'progType', index:'aa.progType', resizable : false, align:'center' },
            { name:'progPath', index:'aa.progPath', resizable : false },
            { name:'progId', index:'aa.progId', hidden: true, resizable : false }
        ],
        multiselect: true,
        sortname: 'aa.progNum',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    }; 
	programListGrid = $("#programListGrid").ifvGrid({ jqGridOption : jqGridOption });
};


function searchFile(){
	$("#hideFile").trigger("click");
}

/* function changeFile(){
	var value = $("#hideFile").val();
	var array = value.split("\\");
	$("#fileValue").val(array[array.length-1]);
} */


function init(){
	
	    $('#addMenuList').click(function(){
	  	    	
    	    var arrayList = new Array;
	      	
	      	var value = menuTree[$('#systemId').attr('treeid')];
    		//value.appServiceType = $('#systemId').val();
    		delete value.imageId;

    		if(value.parentMenuId =='ajson0')
		    delete value.parentMenuId;
	    	
    		delete value.imageURL;
    		
    		//if(value.id.length!=24){
       	        arrayList.push(value);
   		    //}	    	

    		if($('#menuName').val()==''){
	    		alert('<spring:message code="M00213"/>');
	    	}else{
	    			   
	    			 var updateData;
	              	 //console.log(arrayList);
	              	 if(confirm('<spring:message code="M00214"/>')){
	              		 
	  	    		   if($(this).attr('insert')){
	  	    			 updateData = false;
	  	    		   }else if($(this).attr('update')){
		  	    	     updateData = true;		 
	  	    		   }

	                     $.ifvSyncPostJSON('<ifvm:action name="addMenuList"/>',
	 	   	    		 		{update : updateData, accountId : $('#systemId').val()  ,array : arrayList }, 
	 	   	    					 function(result){
	 	   	    		 			    //
	 	   	    		 			    window.location='<ifvm:url name="menuList"/>?id='+result.message+'&sys='+$('#systemId').val();
	 	   	    		             }); 
	              	      }
	           	}

	    });
	
	    $('#delMenuListProg').click(function(){
	    	 	    	
	   	 if($(programListGrid.getCheckedGridData()).length==0){
			   alert('<spring:message code="M00206"/>');
		   }else{
			   if(confirm('<spring:message code="M00208"/>')){
					var sendDataArray = new Array;
					var sendData = null;
			        $(programListGrid.getCheckedGridData()).each(function(index, item){
			    	    sendData = new Object;
			        	sendData.progId =  item.progId; 
			        	sendDataArray.push(sendData);
			        });		 
					 
				 	 $.ifvSyncPostJSON('<ifvm:action name="delMenuListProg"/>',{
				 		     array : sendDataArray}, 
							 function(result){
				 		    	   programListInit();	
				             });
				}
		   }
	    	
	    });
	    
	    
	    
		$('#menuName').keyup(function(){
			 
			 if($('#systemId').attr('treeid').length >= 15){
				 
				 if($('#'+$('#systemId').attr('treeid')+'_anchor').text()!=$(this).val()){
				     $('#addMenuList').attr('disabled',false); 
				 	$('#'+$('#systemId').attr('treeid')+'_anchor').css('color','red');
					 menuTree[$('#systemId').attr('treeid')].update = true;
				 }else{
					$('#addMenuList').attr('disabled',true); 
					$('#'+$('#systemId').attr('treeid')+'_anchor').css('color','black');
					 menuTree[$('#systemId').attr('treeid')].update = false;
				 }
			 } 
             
			 
			 menuTree[$('#systemId').attr('treeid')].menuName = $(this).val(); 
			 
		});
		
		$('#fileUploaderBtn').click(function(){
			if($('#systemId').attr('treeid').length==24){	
			    $('#addMenuList').attr('disabled',false); 
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
   			    
	   			    if( menuTree[$('#systemId').attr('treeid')].id==24){
		                    menuTree[$('#systemId').attr('treeid')].testFile = data[0].url;
		                    menuTree[$('#systemId').attr('treeid')].testFileName = data[0].name;
		                    menuTree[$('#systemId').attr('treeid')].update =true;
	   			    }else{
		                    menuTree[$('#systemId').attr('treeid')].testFile = data[0].url;
		                    menuTree[$('#systemId').attr('treeid')].testFileName = data[0].name;
	
	   			    }	            			    
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
 
function menuPopupClose() {
	$('#menuListPopModal').ejDialog('destroy');
}

$(document).ready(function() {

	//팝업생성
	$('#menuListPopBtn').on('click', function() {

		$("#menuListPopModal").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="menuListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00186"/>',
	        width: 600,
	        close : 'menuPopupClose'
	    });
	});
	
	init();
	systemSelect($('#systemId'));
	
	
	$('#treeSplitWrap').split({
		orientation:'vertical',
		limit:100,
		position:'15%'
	}).css('min-height', 900);
	
	treeMenuList = new TreeMenuList();
	programListInit();
	
	//찾아보기 값이 바꼈을 때
	$("#hideFile").on("change", function(e){
		handleFileSelect(e);
		//changeFile();
	});
	
	//tree resize했을 때 grid width 맞춰주기
	/* $("#contentsWrap").resize(function(){
		programListGrid.setWidth($("#contentsWrap").width());
	}); */
	

	
});


// 최초 컨텐츠 높이 정의.
/* $(window).on('load', function() {
	setTimeout(function() {
		var minHeight = Math.max( $("#sideMenu").height(), $(document).height() ) -234;
		$('#treeSplitWrap').css('min-height', minHeight);
	},1000);
}); */
</script>
<style type="text/css">

</style>


<div class="page-title">
	<h1>
		<spring:message code="M00156" /> 
		<span> &gt; <spring:message code="M00197" /></span>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00135" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button class="btn btn-sm"><i class="fa fa-search"></i>
			<spring:message code="M00135" />
		</button> 
	</div>
</div>
<div class="well form-horizontal">
	<div class="row">
		<label class="col-xs-2 control-label"><spring:message code="M00174" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<%-- <ifvm:input type="select" id='systemId' disabled = "true"/> --%>
				<ifvm:input type="select" id='systemId' />
			</div>
		</div>
	</div>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00198" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">

		<button class="btn btn-sm" id='addMenuList'><i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00137" />
		</button> 
	
		
	</div>
</div>

<div id="treeSplitWrap">
	<!-- tree -->
	<div class="tree_menu" id="treeMenu">
		<div class="treeCon">
			<div id="tree">
				
			</div>
		</div>
	</div><!-- //tree -->
	<!-- contents -->
	<div id="systemManagerContent">
		<div id="contentsWrap">
			<div class="page_btn_area bd_top0">
				<div class="col-xs-12">
					<span><spring:message code="M00199" /></span>
				</div>
			</div>
			<div class="well form-horizontal well_sum">
				<div class="row qt_border">
					<label class="col-xs-2 control-label"><spring:message code="M00200" /></label>
					<div class="col-xs-9">
						<div class="input-group">
							<ifvm:input type="text" id='menuName'/>
						</div>
					</div>
				</div>
				<div class="row qt_border">
					<label class="col-xs-2 control-label"><spring:message code="M00201" /></label>
					<div class="col-xs-9">
						<div class="input-group">
							<ifvm:input type="text" id='menuLevel' />
						</div>
					</div>
				</div>
				<div class="row" id='imgRow'>
					<label class="col-xs-2 control-label"><spring:message code="M00202" /></label>
					<div class="col-xs-9">
						<div class="input-group file">
						
							 <form id="ajaxform" method="post" enctype="multipart/form-data">							
									<ifvm:input type="file" id="hideFile" names="hideFile"/>
		                     </form>   
									
							
							<ifvm:input type="text" id="fileValue" readonly="true" />
							<span class="pos_r">
								<a class="btn btn_sm btn_blueLight ifileBtn" id='fileUploaderBtn'><spring:message code="M00203" /></a>
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
					<span><spring:message code="M00177" /></span>
				</div>
				<div class="col-sm-5 searchbtn_r">
					<button id='menuListPopBtn' class="btn btn-sm btn_gray"><i class="fa fa-plus"></i>
						<spring:message code="M00166" />
					</button> 
					<button class="btn btn-sm btn_gray" id='delMenuListProg'><i class="fa fa-minus"></i>
						<spring:message code="M00165" />
					</button> 
				</div>
			</div>
			
			<div id="programListGrid" class="grid_bd0"><!-- 프로그램 목록 --></div>
		
		</div>
	</div><!-- contents -->
</div>	

<div id="menuListPopModal" class="popup_container"></div><!-- 프로그램 목록 팝업 -->