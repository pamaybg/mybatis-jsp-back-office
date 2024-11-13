<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var prodListPopGrid; 
var dataId = "";

function prodListPopGrid(){
	var jqGridOption = {
		onSelectRow : function (data) {
			dataId = "";
			dataId = data.rid;
		},
	    url:'<ifvm:action name="getProdListPop"/>',
	    colNames:[ 
	              	'<spring:message code="M02124" />'
	              	,'<spring:message code="L00232"/>'
	              	,'<spring:message code="M02125" />'
	              	,'<spring:message code="L00290"/>'
	              	,'<spring:message code="L00291"/>'
	              	,'<spring:message code="L00288"/>'
	              	,'rid'
	              	],
	    colModel:[
	              {name:'prodId', 	index:'lp.PROD_ID', 	resizable : false, 		align:"center"},
	              {name:'prodNm', 	index:'lp.PROD_NM', 	resizable : false},
	              {name:'prodAmt', 	index:'lp.PROD_AMT', 	resizable : false, 		align:"right", 		formatter:"integer"},
	              {name:'brdNm', 	index:'lbc.BRD_NM', 	resizable : false},
	              {name:'catNm', 	index:'lpc.CAT_NM', 	resizable : false},
	              {name:'chnlNm', 	index:'lc.CHNL_NM', 	resizable : false},
	              {name:'rid', 		index:'lp.rid', 		hidden : true}
			      ],  
        sortname: 'lp.rid',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
        };
	prodListPopGrid = $("#prodListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function() {
    prodListPopGrid();

    // 저장 클릭시
    $('#prodListPopSaveBtn').on('click', function() {
        if (prodListPopGrid.getCheckedGridData() == '') {
            alert('<spring:message code="M00285"/>');
        }
        else {
        	if(offerid != null && offerid != "" && offerid != "null"){
        		$.ifvSyncPostJSON('<ifvm:action name="insertOfferProd"/>',{
            		rid : dataId
            		, offerid : offerid
            	},function(result) {
            		
            		if(result.message == '1'){
            			
            			applyProductList();
                        formNewPopClose();
            		}else if(result.message == '2'){
            			alert('<spring:message code="M02247"/>');
            		}else{
            			alert('<spring:message code="M02248"/>');
            		}
            	});
        	}else{
        		alert('<spring:message code="M02249"/>');
        	}
        }
    });

    // 취소 클릭시
    $('#prodListPopCancelBtn').on('click', function() {
    	formNewPopClose();
    });
});

</script>

<div id="prodListPopCon">
	<div class="pop_inner_wrap">
		<div id="prodListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="prodListPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="prodListPopCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>