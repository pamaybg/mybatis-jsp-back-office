<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jstree/jstree.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />

<style>
#showImg{
	margin-left : 5px;
	margin-top: 10px;
}
</style>


<script type="text/javascript">
var treeMenuList; //tree menu
var programListGrid; //프로그램 목록 grid
var dataGroupListGrid; //권한그룹 목록 grid
var ownerGroupUserGrid; //권한 그룹유저 grid
var TreeArray = new Array;
var deleteTree = new Array;
var authGpId;		//권한 그룹 아이디 화면 or Data


/* //권한그룹 유형
function groupTypeSelect(select){
	
	 $.ifvSyncPostJSON('<ifvm:action name="getAuthGroupType"/>',
			 {groupCode : 'AUTH_GROUP_TYPE'},	 
			 function(result){
			      	 //
			    	 $(result.rows).each(function(index, item){	 
			    		 //console.log(item);
			    		 $(select).append($('<option/>').text(item.markName)
			    				  .val(item.commId));	 
			    	 });   
	});
}
 */
//system
function systemSelect(select){
	 $.ifvSyncPostJSON('<ifvm:action name="getSystem"/>',
	 {id:'SYS_SELECT'}, 
	 function(result){
	      	 //
	    	 $(result.rows).each(function(index, item){	 
	    		 //console.log(item);
	    		select.append($('<option/>').text(item.and_app_name)
	    		.val(item.id));	 
	    	 });
           	
	    	var chkSession = $.ifvmGetUserInfo().appServiceId;
	    	 
	    	if(chkSession!='null' || chkSession!=null ) 
                   select.val(chkSession);
	    	   	
	        var myParam = location.search.split('id=')[1];
	        
	    		select.on('change', function(){
	 	    	  if(myParam){
		    		location.search = location.search.substring(0, location.search.indexOf('?'));
		    		firstLoad = true;
	    		}
	    		
	 	    	TreeArray = new Array;
	 	    	$('#tree').jstree("destroy");
	    		treeMenuList = new TreeMenuList();	    
	    		
	    		ownerGroupInit();
	    	}); 	
	 });
}

var ownerGroupGrid, ownerListGrid;


//화면권한 그룹
function ownerGroupInit() {
	var jqGridOption = {
		onSelectCell : function (data) {
					
			$('#authGroupName').attr('ownerGroupId',data.id);
			ownerListInit();
			TreeArray = new Array;
			deleteTree = new Array; 		 
    		$('#tree').jstree("destroy");
    		treeMenuList = new TreeMenuList();
    		
		},
		serializeGridData : function(data){
		    data.appServiceType = $('#systemId').val();
		    data.searchGroupName = $('#authGroupName').val();
		    data.authGroupType = $("#groupType option:selected").val();
		    
		    return data;
		},
		loadComplete : function(obj){
					//console.log(obj.rows.length);
					if(obj.rows.length==0){
						$('#addMenuList').attr('disabled',true);
						$('#addOwnerList').attr('disabled',true);
						$('#delOwnerList').attr('disabled',true);
					}else{
						$('#addMenuList').removeAttr('disabled');
						$('#addOwnerList').removeAttr('disabled');
						$('#delOwnerList').removeAttr('disabled');
	    			    $($($('#gridIdownerGroupGrid').find('tr')[1]).find('td')[1]).trigger('click');	 		    			    
					}
				
			    	ownerListInit();
			
		},
        url : '<ifvm:action name="getOwnerGroup"/>',
        colNames:[ 'id',
                   '<spring:message code="M00191" />',
                   '<spring:message code="M00190" />',
                   '<spring:message code="M00181" />'
                   ],
        colModel:[
  			{ name:'id', width:55, hidden : true},
            { name:'authNum', key : true, index:'aa.authNum', resizable : false, align :'center'},
            { name:'authGroupName', index:'aa.authGroupName', resizable : false },
            { name:'useFlag', index:'aa.useFlag', resizable : false, width:80, align:"center", formatter: "checkbox", formatoptions: {disabled : true} }
        ],
        sortname: 'authNum',
        sortorder: "desc",
        tempId : 'ownerListGridTemp',
        width : '100%'
    }; 
	ownerGroupGrid = $("#ownerGroupGrid").ifvGrid({ jqGridOption : jqGridOption });
};


//화면권한 사용자
function ownerListInit() {
	var jqGridOption = {
		onSelectCell : function (data) {
		},
		serializeGridData : function(data){
		    data.appServiceType = $('#systemId').val();
		    data.authGroupId = $('#authGroupName').attr('ownerGroupId');

		   },
		loadComplete : function(obj){
		
		},
        url : '<ifvm:action name="getOwnerList"/>',
        colNames:[ 'employId',
                   '<spring:message code="M00194" />',
                   '<spring:message code="M00193" />',
                   '<spring:message code="M00181" />'
                   ],
        colModel:[
            {name :'employId', index:'aa.employId', hidden : true, key : true},  
            { name:'employName', index:'aa.employName', resizable : false },
            { name:'employEmail', index:'aa.employEmail', resizable : false },
            { name:'useFlag', index:'aa.useFlag', resizable : false, width:80, align:"center", formatter: "checkbox", formatoptions: {disabled : true} }
        ],
        multiselect: true,
        sortname: 'aa.employEmail',
        sortorder: "desc",
        tempId : 'ownerListGridTemp'

    }; 
	ownerListGrid = $("#ownerListGrid").ifvGrid({ jqGridOption : jqGridOption });
};

function ownerPopupClose() {
	$('#ownerListModal').ejDialog('destroy');	
}

function dataOwnerPopupClose() {
	$('#dataOwnerListModal').ejDialog('destroy');	
}

var TreeArray = new Array;
var TreeMap = new Object;
var firstLog = true;
var changedLog = false;
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
	 
		 
		  $.ifvSyncPostJSON('${pageContext.request.contextPath}/marketing/manage/getAuthMenuNeo.do',
	  		 		{ appServiceType : $('#systemId').val(),
			          authGroupId : $('#authGroupName').attr('ownerGroupId') },
	  					 function(result){	
			        	  
			        	  /*
			        	   * Remove Duplicates  
			        	   */ 
			        	   
			        	   //console.log(result.length);
			        	   $(result).each(function(index, item){			        		   
			        		   if(index<result.length-1){
			        			   if(result[index].id!=result[index+1].id){
			        				   TreeArray.push(item);
				        		   }				        		
			        			}else{
			        				 if(result[index-1].id!=result[index].id){
				        				   TreeArray.push(item);
					        		   }			        			
			        				}		        	
			        	   });
						
			        	 
			        	   
	  		 			 $(TreeArray).each(function(index, item){
                            var TreeInitObject = new Object;                            
                            TreeInitObject.id=item.id;
                            
                            if(item.parentMenuId==null || item.parentMenuId=='null'){
                                TreeInitObject.parent='ajson0';
                            }else{
                            	TreeInitObject.parent= item.parentMenuId;
                            }
                            
                            TreeInitObject.text=item.menuName;
	 	  		 			TreeInitArray.push(TreeInitObject);
	 	  		 			
	                        TreeMap[item.id]= item; 	  		 		    	
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
	  		 			      "keep_selected_style" : false
	  		 				},
	  		 			    "plugins" : [ "checkbox" ]
	  		 		    }).bind('select_node.jstree', function (event, data) {

	  		 		    }).bind("loaded.jstree", function (event, data) {
	  		 	            $(this).jstree("open_all");
	  		 	            
	  		 	            //console.log(TreeArray);
	  		 	            $(TreeArray).each(function(index, item){
	  		 	            	//console.log(item.id+'\t'+item.menuId+'\t'+item.menuName+'\t'+item.progId);
	  		 	            	//console.log(item);
	  		 	            	
  		 	            		$('#'+item.id+'_anchor').css('color','red');

	  		 	            	/*
	  		 	            	 * parentMenu Check
	  		 	            	 */
	  		 	            	
	  		 	                if(item.parentMenuId=='ajson0'){

	  		 	                	var childExists = false;
	  		 	                	$(TreeArray).each(function(index2, item2){
			  		 	            	//console.log(item.menuId+'\t'+item.menuName+'\t'+item.progId);
	  		 	                		if(item.menuId==item2.parentMenuId){
	  		 	                			childExists = true;
	  		 	                		}
	  		 	                	});
	  		 	                	
	  		 	                if(!childExists){
	  		 	                  	if(item.menuId!=null){
			  		 	            		$('#'+item.id+'_anchor').css('color','').trigger('click');	  		  		  		 	            
		  		 	            		}
	  		 	                 	
		  		 	            	 if(item.progId==null){
					  		 	            $('#'+item.id+'_anchor').css('color','red');
		  		 	            	    }
	  		 	                	}
	  		 	                }
	  		 	            	
	  		 	            	
	  		 	            	/*
	  		 	            	 * childMenu Check
	  		 	            	 */
	  		 	            	 
	  		 	                if(item.parentMenuId!='ajson0'){
	  		 	             	if(item.menuId!=null){
		  		 	            	//console.log(item.menuId+'\t'+item.menuName+'\t'+item.progId);
		  		 	            	
		  		 	            	if(item.progId!=null)		 	          
			  		 	            $('#'+item.parentMenuId+'_anchor').css('color','');
		  		 	            	
			  		 	            	$('#'+item.id+'_anchor').css('color','');
	  		  		 	            	$('#'+item.menuId+'_anchor').trigger('click');	  		  		 	            	  		  		 	            
	  		 	            		}
	  		 	            	}
	  		 	            
	  		 	            	 if(item.progId!=null){  		 	          
				  		 	            $('#'+item.parentMenuId+'_anchor').css('color','');
				  		 	            $('#'+item.id+'_anchor').css('color','');
	  		 	             	 }else{
				  		 	            $('#'+item.id+'_anchor').css('color','red');
	  		 	             	 } 	  		 	            	
	  		 	            });
	  		 	            
	  		 	             var checkforUpdate = <%=request.getAttribute("ownerListUpdate")%>;			  		 
			  		 		 
	  		 	             
	  		 	             if(firstLog){
	 		    			    $($($('#gridIdownerGroupGrid').find('tr')[1]).find('td')[1]).trigger('click');	 		    			    
	 		    			     
	 		    			    if(checkforUpdate!=null){
	 			  		 	    	var myParam = location.search.split('id=')[1];
	 			  		 	    	 //console.log(myParam);
	 			  		 	    	$($('#gridIdownerGroupGrid').find('tr')).each(function(index, item){
	 			  		 	    		 //console.log($($(item).find('td')[0]));
	 			  		 	    		 if($($(item).find('td')[0]).text()==myParam){
	 			  		 	    		      $($(item).find('td')[1]).trigger('click');
	 			  		 	    	     }
	 			  		 	    	});			  		 	    	 
	 			  		 		 };
	 		    			    firstLog = false;	 	  		 			    
	  		 	             }		
 	  		 		    })
	  		 	}); 
	    }
};

//DATA 권한 그룹 목록 그리드
function dataGroupListInit() {
	
	var jqGridOption = {
		serializeGridData : function(data){
			data.type = $("#groupType option:selected").val();				//권한그룹 타입
			data.authGroupName = $('#authGroupName').val();	//권한그룹명 조회란 입력한 데이터
		},
 		onSelectCell : function (data) {
			authGpId = data.id;								//권한그룹아이디 저장해뒀다가 권한그룹User조회시 사용
			ownerGroupUserInit();							//권한그룹 유저 초기화
		}, 

        url : '<ifvm:action name="getDataAuthGroup"/>',
        colNames:[ 
                   '<spring:message code="M01242" />',
                   '<spring:message code="M01243" />',
                   '<spring:message code="M01244" />',
                   '<spring:message code="M01245" />',
                   '<spring:message code="M01246" />',
                   '<spring:message code="M01247"/>',
                   'id'
                   ],
        colModel:[   
            { name:'authNum', index:'ag.auth_num', resizable : false },
            { name:'authGroupName', index:'ag.auth_group_name', resizable : false },
            { name:'dataGroupType', index:'c1.mark_name', resizable : false, align : 'center' },
            { name:'baseDept', index:'a1.name', resizable : false, align : 'center' },
            { name:'deptLevel', index:'c2.mark_name', resizable : false, align : 'center' },
            { name:'flag', index:'ag.flag', resizable : false, width:80, align:"center", formatter: "checkbox", formatoptions: {disabled : true}  },
            { name:'id', index:'ag.id', hidden:true }
        ],
        multiselect: true,
        sortname: 'ag.auth_num',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete2'

    }; 
	dataGroupListGrid = $("#dataGroupListGrid").ifvGrid({ jqGridOption : jqGridOption });
};

//권한 그룹 사용자 그리드
function ownerGroupUserInit() {
	var jqGridOption = {
		serializeGridData : function(data){
			data.id = authGpId; //선택한 권한그룹에 해당하는 목록 조회
		},
        url : '<ifvm:action name="getDataOwnerList"/>',
        colNames:[ 
                   '<spring:message code="M01249" />',
                   '<spring:message code="M01248" />',
                   '<spring:message code="M01250" />',
                   'authUsrId'
                   ],
        colModel:[    
            { name:'userName', index:'e.name', resizable : false },
            { name:'userId', index:'e.email', resizable : false },
            { name:'dept', index:'a.name', resizable : false },
            { name:'authUsrId', hidden : true,resizable : false }
        ],
        multiselect: true,
        sortname: 'e.email',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete2'

    }; 
	ownerGroupUserGrid = $("#ownerGroupUserGrid").ifvGrid({ jqGridOption : jqGridOption });
};

$(document).ready(function() {
	systemSelect($('#systemId'));
	//groupTypeSelect('#groupType');

	//권한그룹 유형
    $.fn.ifvmSetSelectOptionCommCode("groupType", "AUTH_GROUP_TYPE");
    $('#groupType').children("[value='']").remove();	//첫번째 빈 Option 삭제
 
	ownerGroupInit();
	dataGroupListInit();
	ownerGroupUserInit();

	//권한그룹 삭제
	$('#delDataAuthGroupBtn').on('click',function(){
		
		var sendDataArray = new Array;
		var sendData = null;
        $(dataGroupListGrid.getCheckedGridData()).each(function(index, item){
  
    	    sendData = new Object;
        	sendData.id =  item.id; 		//권한그룹 id
        	sendDataArray.push(sendData);
        });		 		  
		
		if(sendDataArray.length==0){
			alert('<spring:message code="M00206"/>');
		}else{
			if(confirm('<spring:message code="M00208"/>')){								  
			 	 $.ifvSyncPostJSON('<ifvm:action name="delDataAuthGroupList"/>',{
			 		     array : sendDataArray}, 
						 function(result){
			 		    	dataGroupListInit();
			 		    	ownerGroupUserInit();
			     }); 
			 }
		  }		
	});
	
	//화면권한 사용자 추가
	$('#addOwnerList').on('click', function(){
		//팝업생성
		$("#ownerListModal").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="ownerListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00589"/>',
	        width: 600,
	        close : 'ownerPopupClose'
	    });
	});	
	
	//Data권한 사용자 추가
	$('#addGroupUser').on('click', function(){

		//var checkedList = dataGroupListGrid.getCheckedList();
		
		if(authGpId != "" && authGpId != null){
			//팝업생성
			$("#dataOwnerListModal").ejDialog({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="dataOwnerListPop"/>',
		        contentType: "ajax",
		        title: '<spring:message code="M00589"/>',
		        width: 600,
		        close : 'dataOwnerPopupClose'
		    });
		}else{
			alert('<spring:message code="M00206"/>');
		}
	});	
	
	//화면권한 사용자 삭제
	$('#delOwnerList').on('click', function(){
		var sendDataArray = new Array;
		var sendData = null;
        $(ownerListGrid.getCheckedGridData()).each(function(index, item){
    	    sendData = new Object;
        	sendData.employId =  item.employId; 
        	sendDataArray.push(sendData);
        });		 		  
		
		if(sendDataArray.length==0){
			alert('<spring:message code="M00206"/>');
		}else{
			if(confirm('<spring:message code="M00208"/>')){								  
			 	 $.ifvSyncPostJSON('<ifvm:action name="delOwnerList"/>',{
			 		     array : sendDataArray}, 
						 function(result){
			 		    	   ownerListInit();	
			     }); 
			 }
		  }		
  	});
	
	//data권한 사용자 삭제
	$('#delGroupUser').on('click', function(){

		var sendDataArray = new Array;
		var sendData = null;


        $(ownerGroupUserGrid.getCheckedGridData()).each(function(index, item){
    	    sendData = new Object;
        	sendData.authUsrId =  item.authUsrId;
        	sendDataArray.push(sendData);
        });		 		  

		if(sendDataArray.length==0){
			alert('<spring:message code="M00206"/>');
		}else{
			if(confirm('<spring:message code="M00208"/>')){								  
			 	 $.ifvSyncPostJSON('<ifvm:action name="delDataAuthOwnerList"/>',{
			 		     array : sendDataArray, authGroupId : sendData.authGroupId}, 
						 function(result){
			 		    	ownerGroupUserInit();	
			     }); 
			 }
		  }		
  	});
	$('#searchBtn').on('click', function(){
		ownerGroupInit();
		dataGroupListInit();
	});

	
	$('#treeSplitWrap').split({
		orientation:'vertical',
		limit:100,
		position:'60%'
	}).css('min-height', 900);
	
	treeMenuList = new TreeMenuList();

	$('#authGroupName').on('keyup', function(){
	    if(e.keyCode == 13){
			ownerGroupInit();	 
		}
	});
	
	$('#addMenuList').on('click', function(){
		//console.log($("#tree").jstree("get_checked",null,true));
	    var arrayData = new Array;
	    var arrayTree = new Object;
	    var arrayItem;
	    
		$($("#tree").jstree("get_checked",null,true)).each(function(index, item){				
		      //console.log(TreeMap[item]);
		      if(TreeMap[item]!=undefined){

		    	  if(TreeMap[item].parentMenuId!='ajson0'){
		    		   if(TreeMap[item].parentMenuId!=null){
				    	    //console.log(TreeMap[TreeMap[item].parentMenuId].menuName+'\t'+TreeMap[TreeMap[item].parentMenuId].id);
				    	 	arrayItem = new Object;
				    	 	arrayItem.authGroupId = $('#authGroupName').attr('ownergroupid');
				    	 	arrayItem.empId = ifvmUserInfo.empId;
				    	 	arrayItem.menuId = TreeMap[TreeMap[item].parentMenuId].id;
				    	 	arrayItem.appServiceType= $('#systemId').val();
				    	 	arrayTree[TreeMap[TreeMap[item].parentMenuId].menuName] = arrayItem;
		    		   }
		    	   }
		    	  		
				  	  	arrayItem = new Object;
				    	arrayItem.authGroupId = $('#authGroupName').attr('ownergroupid');
				    	arrayItem.empId = ifvmUserInfo.empId;
				    	arrayItem.menuId = item;
				    	arrayItem.appServiceType= $('#systemId').val();
				    	arrayTree[TreeMap[item].menuName] = arrayItem;
		      }
		});

				
	   $.each(arrayTree,function(key,value){
		   //console.log(key+'\t'+value.menuId+'\t'+value.authGroupId);
		   arrayData.push(value);		   
	   });
		
       var removeAll = false;
	   if(arrayData.length==0){
		        arrayData.push({authGroupId : $('#authGroupName').attr('ownergroupid')});   
	        	removeAll = true;	        		        	        
	    }else{
		    	removeAll= false;
	    } 
	 
	  if(confirm('<spring:message code="M00207"/>')){			
		  $.ifvSyncPostJSON('<ifvm:action name="addOwnerProgList"/>',
			 		{array : arrayData, remove : removeAll}, 
						 function(result){	
			 			       qtjs.href('${pageContext.request.contextPath}/marketing/manage/ownerListUpdate?id='+result.message;			 			    		   );
			             }); 
		}
	});

	//권한 그룹 유형 변경시
	$("#groupType").on("change", function(){
		var groupCode = $('#groupType').val();

		//groupCode가 DATA인 권한그룹유형은 DATA목록 
		if( groupCode == 'DATA'){
			dataGroupListInit();
			$("#screenOwnerArea").hide();
			$("#dataOwnerArea").show();
		}else {
			ownerGroupInit();
			ownerListInit();
			$("#screenOwnerArea").show();
			$("#dataOwnerArea").hide();
		}
	});

	
	
});
/* 

// 최초 컨텐츠 높이 정의.
$(window).on('load', function() {
	setTimeout(function() {
		var minHeight = Math.max( $("#sideMenu").height(), $(document).height() ) -234;
		$('#treeSplitWrap').css('min-height', minHeight);	
		$('.vsplitter').remove();
	},1000);
}); */

</script>

<script id="ownerListGridTemp" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="filter_area">
			<div class="right">
				{rowsBox}
			</div>
		</div>
	
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
			<div class="total_area">{total}</div>	
		<div>
	</div>
</script>

<style type="text/css">
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
#dataOwnerArea{display:none;}
</style>


<div class="page-title">
	<h1>
		<spring:message code="M00156" /> 
		<span> &gt; <spring:message code="M00158" /></span>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00135" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button class="btn btn-sm" id='searchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00135" />
		</button> 
	</div>
</div>
<div class="well form-horizontal">
	<div class="row">
	<%-- 	<label class="col-xs-2 control-label"><spring:message code="M00174" /></label> --%>
		<div class="col-xs-3"  style="display:none" >
			<div class="input-group">
				<ifvm:input type="select" id="systemId"/>
			</div>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="M00587" /></label>
		<div class="col-xs-3">
			<div class="input-group">
				<ifvm:input type="select" id="groupType" names= "groupType"/>
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00190" /></label>
		<div class="col-xs-3">
			<div class="input-group">
				<ifvm:input type="text" className="form-control" id="authGroupName" />
			</div>
		</div>
	</div> 
</div>

<!-- 화면 권한일 때 -->
<div id="screenOwnerArea">
	<div class="page_btn_area">
		<div class="col-xs-7">
		</div>
		<div class="col-sm-5 searchbtn_r">
			<button class="btn btn-sm" id='addMenuList'><i class="glyphicon glyphicon-check"></i>
				<spring:message code="M00137" />
			</button> 
		</div>
	</div>
	
	<div id="treeSplitWrap">
		<!-- contents -->
		<div id="systemManagerContent">
			<div id="contentsWrap">
				<div class="page_btn_area bd_top0">
					<div class="col-xs-12">
						<span><spring:message code="M00195"/></span>
					</div>
				</div>
			    <div id="ownerGroupGrid" class="grid_bd0"></div>
				
				
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span><spring:message code="M00196"/></span>
					</div>
					<div class="col-xs-5 searchbtn_r">
						<button class="btn btn-sm btn_gray" id="addOwnerList"><i class="fa fa-plus"></i>
							<spring:message code="M00166" />
						</button> 
						<button class="btn btn-sm btn_gray" id="delOwnerList"><i class="fa fa-minus"></i>
							<spring:message code="M00165" />
						</button> 
					</div>
				</div>
				
				<div id="ownerListGrid" class="grid_bd0"></div>
			
			</div>
		</div><!-- contents -->
			<!-- tree -->
		<div class="tree_menu" id="treeMenu">
			<div class="treeCon">
				<div id="tree">
				</div>
			</div>
		</div><!-- //tree -->
	</div>	
</div>

<!-- DATA권한 일 때 -->
<div id="dataOwnerArea" class="row data_wrap">
	<div class="data_left">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="M01240"/></span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				<button class="btn btn-sm btn_gray" id="delDataAuthGroupBtn"><i class="fa fa-minus"></i>
					<spring:message code="M00165" />
				</button> 
			</div>
		</div>
	    <div id="dataGroupListGrid" class="grid_bd0"></div>
    </div>
    <div class="data_center"></div>
    <div class="data_right">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="M01241"/></span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				<button class="btn btn-sm btn_gray" id="addGroupUser"><i class="fa fa-plus"></i>
					<spring:message code="M00166" />
				</button> 
				<button class="btn btn-sm btn_gray" id="delGroupUser"><i class="fa fa-minus"></i>
					<spring:message code="M00165" />
				</button> 
			</div>
		</div>
	    <div id="ownerGroupUserGrid" class="grid_bd0"></div>
    
    </div>
    
</div>

<div id="ownerListModal" class="popup_container"></div><!-- 프로그램 목록 팝업 -->
<div id="dataOwnerListModal" class="popup_container"></div><!-- 직원 목록 팝업 -->