<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
	var manageTabList;
	
	getManageTabList = {
		init : function(){
			getManageTabList.search();
		},
		search : function(){
			this.loadData();
		},
		jqGridOption : {
	        serializeGridData : function( data ){

	        },
	        ondblClickRow : function (rowNo) {
	        	
	        },
	        onSelectRow : function (data) {
	        	
	        },
	        loadComplete : function(result){

	        },
	        url : '<ifvm:action name="getManageTabList"/>',
	        colNames:[
	                  '<spring:message code="M02727"/>',
	                  '<spring:message code="M02728"/>',
	                  '<spring:message code="M02729"/>',
	                  'rid'
	                ],
	       colModel:[
	           { name:'tabSort', 	    index:'a.tab_sort', 		width:'20px', 	align: 'center', 	resizable : false },
	           { name:'tabNm', 			index:'a.tab_nm', 			width:'100px', 	align: 'lefft', 	resizable : false },
	           { name:'tabLinkUrl', 	index:'a.tab_link_url', 	width:'200px', 	align: 'left', 	resizable : false },
	           { name:'rid', 			index:'a.rid', 				hidden : true }
	       ],
	        sortname: 'a.tab_sort',
	        autowidth : true , 
	        sortorder: "ASC",
	        multiselect : true,
	        tempId : 'ifvGridOriginTemplete'
	    },
	    loadData : function(){
	    	manageTabList = $("#manageTabListGrid").ifvGrid({ jqGridOption : getManageTabList.jqGridOption });
	    },
	    deleteManageTabList : function(){
	    	var checkedList = manageTabList.getCheckedList();
			var manageTabIdList = [];
			for( var i = 0; i < checkedList.length; i++ ){
				manageTabIdList.push( checkedList[i].rid );	
			}
			
			if(manageTabIdList.length > 0){
				if( confirm('<spring:message code="I01500"/>') == true ){ //삭제하시겠습니까?
				
					$.ifvSyncPostJSON('<ifvm:action name="deleteManageTabList"/>',{
						rids : manageTabIdList,
					},
					function(result) {
						alert('<spring:message code="I00726"/>'); //삭제되었습니다.
						getManageTabList.init();
					});
				}
			}else{
				alert('<spring:message code="I00728"/>'); //목록을 선택해주세요.
			}
	    },
	    setManageTab : function(){
	    	
	    },
	    modifyManageTab : function(){
	    	if(manageTabList.getCheckedGridData().length == 0){
	    		alert('<spring:message code="I00728"/>'); //목록을 선택해주세요.
	    	}else if(manageTabList.getCheckedGridData().length == 1){
	    		addManageTab.pop();
	    	}else if(manageTabList.getCheckedGridData().length > 1){
	    		alert('<spring:message code="V00204"/>'); //한 개의 목록을 선택해주세요.
	    	}
	    }
	};
	
	$(document).ready(function(){
		getManageTabList.init();
	});
</script>
<div class="page-title">
	<h1>
		<spring:message code="M02730"/>
	</h1>
</div>
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M02730"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" id="addBtn" text="L00027" btnFunc="addManageTab.pop" />
        	<ifvm:inputNew type="button" id="modifyBtn" text="M00259" btnFunc="getManageTabList.modifyManageTab" />
        	<script>
        	var addManageTab = {
				id : "addManageTabPop",
				pop : function(){
					if(manageTabList.getCheckedGridData().length == 1){
						var url = '<ifvm:url name="addManageTabPop"/>'+'?ridManageTab='+manageTabList.getCheckedGridData()[0].rid;
					}else if(manageTabList.getCheckedGridData().length == 0){
						var url = '<ifvm:url name="addManageTabPop"/>';
					}

					$("#"+this.id).ifvsfPopup({
			            enableModal : true,
			            enableResize : false,
			            contentUrl : url,
			            contentType : "ajax",
			            title : '<spring:message code="M02731"/>', // 탭 관리 팝업
			            width : '500px'
			        });
				},
				beforeClose : function(obj){

				},
				close: function(obj){
					if(obj){
						this.beforeClose(obj)
					}
					var _popObj = eval(this.id)
					_popObj._destroy();
					getManageTabList.init();
				}
			}
           	</script>
           	<ifvm:inputNew type="button" id="deleteBtn" text="L00029" btnFunc="getManageTabList.deleteManageTabList" />
        </div>
    </div>
    <div id="manageTabListGrid" class="white_bg grid_bd0"></div>
</div>

<!-- 신규/수정 탭 관리 팝업  -->
<div id="addManageTabPop" class="popup_container"></div>