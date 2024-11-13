<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

 
<%-- <script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/lib/jquery.jqJSONPGrid.src.js'></script> --%>
<script type="text/javascript">

var storeNameModal;
var storeId;
var storeName;
var storeType;
var storeMarkType;

function storeNameModal(){
	
	var jqGridOption = {
		onSelectCell : function (data) {
			storeId = data.storeId;
			storeName = data.storeName;
			storeType = data.storeTypeCode;
			storeMarkType = data.storeType;
			
			$.ifvSyncPostJSON('<ifvm:action name="beSetStore"/>',{
				  storeId : data.storeId
				, storeName : data.storeName
				, storeType : data.storeTypeCode
				, storeMarkType : data.storeType
				
				// < ↵ > 인식 오류로 인한 주석처리  
				//, storeDesc : data.storeDesc
			
				, memId : data.memId }
			,function(result) {
			});
			storeNameModalSelected( data );
		},
		serializeGridData : function( data ){
			return data;
		},
		/* ajaxGridOptions: { contentType: 'application/json; charset=utf-8', type: 'GET' },
		mtype : 'GET',
        crossDomain: true,		
        ignoreCase: true,	        
		datatype: 'jsonp', */
        url : '<ifvm:action name="getBeaconGetStoreList"/>',
        colNames:[ '<spring:message code="M01314" />',
		        '<spring:message code="M01316" />',
		        '<spring:message code="M01317" />',
		        '<spring:message code="M01315" />'],
        colModel:[
            { name:'storeName', index:'b.storeName' },
            { name:'storeType', index:'b.storeType' },
            { name:'parGroupName', index: 'b.parGroupName'},
            { name:'storeDesc', index:'b.storeDesc' }
        ],
		   
        sortname: 'b.createDate',
        sortorder: "desc",
        tempId : "ifvGridOriginTemplete",
        caption: '<spring:message code="M01313" />',
        radio : true,
        //loadonce: true
    };
 	storeNameModal = $("#storeNameGrid").ifvJSONPGrid({ jqGridOption : jqGridOption }); 
  	//storeNameModal = $("#storeNameGrid").ifvGrid({ jqGridOption : jqGridOption });
};


$(document).ready(function(){
	storeNameModal();	
	
	if(ifvmUserInfo.orgName != null ) $('#orgName2').val( ifvmUserInfo.orgName);
	
	//선택 클릭시
    $("#storeNamePopSelect").on('click', function(){
    	if(storeId != null){
    		$("#txtStore").text(storeId);
        	$("#txtStore").val(storeName);
        	$("#storeType").text(storeType);
    		$("#storeType").val(storeMarkType);
    		formNewPopClose();
    	}
    	else{
    		alert('<spring:message code="M00499"/>');
    	}
    });
	
	
	//취소 클릭시
    $("#storeNamePopClose").on('click', function(){
    	formNewPopClose();	
    });
});

</script>


<div id="storeNamePopWrap">
	<div class="pop_inner_wrap">
	 	<header class="temp_title">
			<spring:message code="M01318" />
		</header>
		<div class="header_filter">
			<div class="row">
				<label class="col-xs-2 control-label text-right en_line">
					<spring:message code="M01319" />
				</label>
				<div class="col-xs-3">
					<ifvm:input type="text" id="orgName2" disabled="disabled" />
				</div>
			</div>
		</div>	
		<div id="storeNameGrid" class="con_size"></div>
	</div>	
			
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="storeNamePopSelect">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="storeNamePopClose">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>