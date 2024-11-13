<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="${pageContext.request.contextPath}/resources/js/jstree/jstree.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/js/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />

<div class="col-xs-3 control_content">
      <ifvm:input type="select" id="prodSearch" names="prodSearch"/>
</div>
<div class="col-xs-3 control_content">
		<ifvm:input type="text" id="prodType" names="prodType" maxLength="50" />
</div>
<button class="btn btn-sm btn_lightGray2 cancel" id="prodSearchBtn">
        <spring:message code="M00568"/>
</button>
<article class="popup_wrap">
	<div class="content">
		<article>
			<header>
				<h3>상품 목록</h3>
			</header>
			<div id="treeContent" class="content" style="overflow-y: auto">
				<div id="prodTree" style="height:400px" ></div>
			</div>
		</article>
	</div>
</article>

<div class="pop_btn_area">
	<ifvm:inputNew
        type="button"
        btnType="select"
        text="선택"
        id="prodPopSel"
        nuc="true"
	 />
	 
	<ifvm:inputNew 
        type="button"
        btnType="cancel"
        text="닫기"
        id="prodPopClose"
        nuc="true"
        btnFunc="prodTreeClose"
	/>
</div>

<script type="text/javascript">
	var camId = diagram._selectedObject.actualTaskId;
	var treeData = {};
	$(document).ready(function() {
		campaignProdList();
		$.fn.ifvmSetSelectOptionCommCode("prodSearch", "MKT_RESP_PROD", null, null, true);
		 $('#prodPopSel').on('click', function() {
			 prodTreeSelect();
		    });
		//지점 search 선택 클릭 시
		 $('#prodSearchBtn').on('click', function(){
		     prodSearch();
		    });
	});

	function campaignProdList(){
		$.ifvSyncPostJSON('<ifvm:action name="getProdTreeList"/>', {
			treeData: treeData,
			camId : camId
	    },
	    function(result) {
			var array = [],
			rows = result.length;
           //gprodTree.rows = rows;
			for ( var i=0 ; i <rows ; i++) {
			    var row = result[i];
                array.push({
                    "id": row.id,
                    "parent": !row.parent ? "#" : row.parent,
                    "text": row.text,
                    "name":row.name,
                    "prodId":row.prodId,
                    type : row.type
                });
                treeData[row.id] = row;
            }
            $('#prodTree').jstree({
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
            $('#prodTree').on('loaded.jstree',function () {
                 var array = gProdTree.rows;
                if ( array ){
                    for ( var i=0 ; i <  array.length ; i ++){
                        $('#prodTree').jstree('select_node',array[i]);
                    }
                } 
            });
        });
	}
	
	function prodTreeClose(){
		prodNewPopDialog._destroy();
	}
	
	function prodSearch(){
		var prodTree = $('<div id="prodTree" style="height:400px"/>');
		
		$('#treeContent').empty().append(prodTree);
		var values = {};
		if($("#prodType").val() != ""){
			values.camId = camId
			if($("#prodSearch").val() == 'PRODID'){
				values.prodId = $("#prodType").val();
			}
			else{
				values.name = $("#prodType").val();
			}
			$.ifvSyncPostJSON('<ifvm:action name="getProdTreeSearchList"/>', values,
			    function(result) {
			    	var array = [],
						rows = result.length;
			    	
			    	for ( var i=0 ; i <rows ; i++) {
					    var row = result[i];
		                array.push({
		                    "id": row.id,
		                    "parent": !row.parent ? "#" : row.parent,
		                    "text": row.text,
		                    "name":row.name,
		                    "prodId":row.prodId,
		                     type : row.type
		                });
		                treeData[row.id] = row;
		            }
			    	prodTree.jstree({
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
			    	prodTree.on('loaded.jstree',function () {
		            	var array = gProdTree.rows;
		                if ( array ){
		                    for ( var i=0 ; i <  array.length ; i ++){
		                        $('#prodTree').jstree('select_node',array[i-1]);
		                    }
		                } 
		            });
			    });
		}
		else
			campaignProdList();
		}
	
</script>
