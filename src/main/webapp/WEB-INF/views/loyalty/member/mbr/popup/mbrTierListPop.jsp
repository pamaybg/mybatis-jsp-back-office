<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tierGrpDtlPopList;

function tierGrpDtlPopList(){
		var jqGridOption = {
			serializeGridData : function( data ){
				data.ridMbr = mbr_rid;
			},
			loadComplete : function(data){
			},
		    url:'<ifvm:action name="getMbrAllTierList"/>',
		    colNames:[
	              /* '<spring:message code="M01440"/>', */
	              	'등급 코드'
	              	,'등급 명'
	              	,'rid'
	              	],
		    colModel:[
		              {name:'tierCd', index:'lt.tier_cd', resizable : false, align:'center'},
		              {name:'tierNm', index:'lt.tier_nm', resizable : false, align:'center'},
		              {name:'rid', index:'lt.rid', hidden : true}
				      ],  
			radio:true,
			sortname: 'lt.seq_no',
			/* autowidth : true ,*/ 
			sortorder: "asc",
			tempId : 'ifvGridOriginTemplete'
		};
		tierGrpDtlPopList = $("#tierGrpDtlPopList").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function() {
	tierGrpDtlPopList();
	
	$("#btnSave").on('click', function(){
		
		if(tierGrpDtlPopList.getCheckedList().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		
    		var vali = $("#mbrTierListPopWrap").ifvValidation();
    		if (vali.confirm() && confirm("등급을 변경하시겠습니까?")) {
    			
    			var dataArr = tierGrpDtlPopList.getCheckedList();
	    		var rid = dataArr[0].rid;
	    		var desc = $("#tierUpdDesc").val();
	    	    $.ifvSyncPostJSON('<ifvm:action name="editMbrTier"/>', {
	    	        rid : rid,
	    	        ridMbr : mbr_rid,
	    	        desc: desc
	    	    }, function(result) {
	    	        if ($.fn.ifvmIsNotEmpty(result)) {
	    	            if (result.success == true) {
	    	                alert('<spring:message code="M00624"/>');
	    	                gMbrDetail.loadData();
	    	                mbrTierListPop.close();
	    	                mbrDetailTab.moveTabByTabId('mbrGiftcardTxnHistListNew')
	    	            }
	    	        }
	    	    });
    		}
    	}
	});
	
	$("#btnCancel").on('click', function(){
		mbrTierListPop.close();
	}); 
});
</script>

<div id='tierGrpDtlPopFormArea'>
	<div class="pop_inner_wrap form-horizontal" id="mbrTierListPopWrap">
	    <div class="page_btn_area">
			<div class="col-xs-7">
				<span>회원 등급 변경</span>
			</div>
		</div>
		<div class="pop_inner_wrap form-horizontal row qt_border">
			<ifvm:inputNew type="textarea" id="tierUpdDesc" label="변경사유" labelClass="2" conClass="9"  nuc="true" rows="3" required="true"/>	
		</div>
		<div id="tierGrpDtlPopList"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="btnSave">     
			<i class="glyphicon glyphicon-check" ></i>    
			<spring:message code="M01855"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
			<spring:message code="M00284"/>
	    </button> 
	</div>
</div>
