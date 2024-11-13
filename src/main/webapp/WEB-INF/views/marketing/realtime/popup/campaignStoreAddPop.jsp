<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="${pageContext.request.contextPath}/resources/js/jstree/jstree.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />

<div class="col-xs-3 control_content">
      <ifvm:input type="select" id="storeTypeSearch" names="storeTypeSearch"/>
</div>
<div class="col-xs-3 control_content">
		<ifvm:input type="text" id="storeType" names="storeType" maxLength="50" />
</div>
<button class="btn btn-sm btn_lightGray2 cancel" id="storeTypeSearchBtn">
        <spring:message code="M00568"/>
</button>
<article class="popup_wrap">
	<div class="content">
		<article>
			<header>
				<h3>대상 지점 선택</h3>
			</header>
			<div id="treeContent" class="content" style="overflow-y: auto">
				<div id="storeTree" style="height:400px" ></div>
			</div>
		</article>
	</div>
</article>

<div class="pop_btn_area">
	<ifvm:inputNew
        type="button"
        btnType="select"
        text="선택"
        id="cmmStorePopSel"
        nuc="true"
	 />
	 
	<ifvm:inputNew 
        type="button"
        btnType="cancel"
        text="닫기"
        id="cmmStorePopClose"
        nuc="true"
        btnFunc="commStoreTreeClose"
	/>
</div>

<script type="text/javascript">
	var chnlNo = null;
	var treeData = {};
	$(document).ready(function() {
		
		campaignStoreList();
        
		$.fn.ifvmSetSelectOptionCommCode("storeTypeSearch", "MKT_CAM_STORE_SEARCH", null, null, true);
		
		
		 $('#cmmStorePopSel').on('click', function() {
			 commStoreTreeSelect();
		    });
		//지점 search 선택 클릭 시
		 $('#storeTypeSearchBtn').on('click', function(){
		     storeTypeSearch();
		    });
	});

	function campaignStoreList(){
		$.ifvSyncPostJSON('<ifvm:action name="getStoreTreeList"/>', {
			treeData: treeData,
			camId : campaignId
	    },
	    function(result) {
			var array = [],
			rows = result.length;
           //gStoreTree.rows = rows;
			for ( var i=0 ; i <rows ; i++) {
			    var row = result[i];
                array.push({
                    "id": row.storeId,
                    "parent": !row.upperStoreId ? "#" : row.upperStoreId,
                    "text": row.chnlNo + " " + row.storeNm,
                    "name":row.storeNm,
                    storeTypeCd : row.storeTypeCd
                });
                treeData[row.storeId] = row;//STORE_ID
            }
            $('#storeTree').jstree({
                "core" : {
                    "check_callback" : true,
                    "data" : array,
                    "multiple" : true,
                    "themes":{
                        "icons":false
                    }
                },
                "checkbox":{
                    "keep_selected_style" : false
                },
                "plugins" : [ "checkbox" ]
            });
            $('#storeTree').on('loaded.jstree',function () {
                 var array = gStoreTree.rows;
                if ( array ){
                    for ( var i=0 ; i <  array.length ; i ++){
                        $('#storeTree').jstree('select_node',array[i]);
                    }
                } 
            });
        });
	}
	
	function commStoreTreeClose(){
		addStorePopup._destroy();
	}
	
	function storeTypeSearch(){
		var storeTree = $('<div id="storeTree" style="height:400px"/>');
		
		$('#treeContent').empty().append(storeTree);
		var values = {};
		if($("#storeType").val() != ""){
			if($("#storeTypeSearch").val() == 'CHNLNO')
				values.chnlNo = $("#storeType").val();
			else
				values.storeNm = $("#storeType").val();
		
			$.ifvSyncPostJSON('<ifvm:action name="getStoreTreeSearchList"/>', values,
			    function(result) {
			    	var array = [],
						rows = result.length;
			    	
			    	for ( var i=0 ; i <rows ; i++) {
					    var row = result[i];
		                array.push({
		                    "id": row.storeId,
		                    "parent": !row.upperStoreId ? "#" : row.upperStoreId,
		                    "text": row.chnlNo + " " + row.storeNm,
		                    "name":row.storeNm,
		                    storeTypeCd : row.storeTypeCd
		                });
		                treeData[row.storeId] = row;//STORE_ID
		            }
			    	storeTree.jstree({
		                "core" : {
		                    "check_callback" : true,
		                    "data" : array,
		                    "multiple" : true,
		                    "themes":{
		                        "icons":false
		                    }
		                },
		                "checkbox":{
		                    "keep_selected_style" : false
		                },
		                "plugins" : [ "checkbox" ]
		            });
			    	storeTree.on('loaded.jstree',function () {
		            	var array = gStoreTree.rows;
		                if ( array ){
		                    for ( var i=0 ; i <  array.length ; i ++){
		                        $('#storeTree').jstree('select_node',array[i-1]);
		                    }
		                } 
		            });
			    });
		}
		else
			campaignStoreList();
		}
	
</script>
