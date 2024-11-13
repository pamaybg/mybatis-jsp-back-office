<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var memSearchList;

function memSearchList(){
		var jqGridOption = {
			serializeGridData : function( data ){
				data.ridTierGroup = ridTierGroup;
			},
			ondblClickRow : function(row){
			},
			onSelectCell : function (data) {
			}, 
			loadComplete : function(data){
			},
		    //url:'<ifv:action name="getTierListPop"/>',
		    datatype: 'clientSide',
	        data : memData.cust,
	        colNames:[
		              /* '<spring:message code="M01440"/>', */
		              	'<spring:message code="L00435"/>'
		              	,'<spring:message code="M02097" />'
		              	,'<spring:message code="L00343"/>'
		              	,'<spring:message code="L00342"/>'
		              	,'<spring:message code="L00311"/>'
		              	,'<spring:message code="L00324"/>'
		              	],
			    colModel:[{name:'seqNo', index:'lt.seq_no', resizable : false},
			              {name:'tierCd', index:'lt.tier_cd', resizable : false},
			              {name:'tierNm', index:'lt.tier_nm', resizable : false},
			              {name:'validStartDate', index:'lt.valid_start_date', resizable : false},
			              {name:'validEndDate', index:'lt.valid_end_date', resizable : false},
			              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false}
					      ],  
				radio:true,
				tempId : 'ifvGridOriginTemplete'
		};
	memSearchList = $("#memSearchList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	memSearchList();
	
	$("#btnSelect").on('click', function(){
		if(memSearchList.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = memSearchList.getCheckedList();
    		$("#tierNm").val(dataArr[0].tierNm).text(dataArr[0].rid);
    		memSearchPopupClose();
    	}
	});
	
	$("#btnCancel").on('click', function(){
		memSearchPopupClose();
	}); 
});
</script>

<div id='tierGrpDtlPopFormArea'>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <%-- <span><spring:message code="L01838" /></span> --%>
	        <span><spring:message code="M02098" /></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <button class="btn btn-sm" id="memberSearchBtn"><i class="fa fa-search"></i>
	            <spring:message code="M00135" />
	        </button> 
	        <button class="btn btn-sm" id="memberSearchInitBtn">
	            <spring:message code="M00278" />
	        </button> 
	    </div>
	</div>
	<div class="well form-horizontal" >
		<div class="row">
			<label class="col-sm-2 control-label"><spring:message code="L00435" /></label>
			<div class="col-sm-2 control_content">
				<div class="input-group">
				<ifv:input type="text"  id="memNm" />
				</div>
			</div>
			<label class="col-sm-2 control-label"><spring:message code="L00436" /></label>
			<div class="col-sm-2 control_content">
				<div class="input-group" >
				<ifv:input type="text"  id="hhpNo" />
				</div>
			</div>
			<label class="col-sm-2 control-label"><spring:message code="M02099" /></label>
			<div class="col-sm-2 control_content">
				<div class="input-group" >
				<ifv:input type="text"  id="cardNo" />
				</div>
			</div>
		</div>
	</div>
	<div class="pop_inner_wrap">	
		<div id="memSearchList" class="grid_bd0"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="btnSelect">     
			<i class="glyphicon glyphicon-check" ></i>    
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
			<spring:message code="M00284"/>
	    </button> 
	</div>
</div>
