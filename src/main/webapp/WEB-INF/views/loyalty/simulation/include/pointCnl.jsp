<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var pointCnlList;

function pointCnlList(){
	var jqGridOption = {
		serializeGridData : function( data ){
		},
		ondblClickRow : function(row){
		},
		onSelectCell : function (data) {
		}, 
		loadComplete : function(data){
		},
	    //url:'<ifvm:action name="getMemList"/>',
	    datatype: 'clientSide',
        data : [],
	    colNames:[
              /* '<spring:message code="M01440"/>', */
              	'<spring:message code="M02064" />'
              	,'<spring:message code="M02065" />'
              	,'<spring:message code="L00435"/>'
              	,'<spring:message code="L00232"/>'
              	,'<spring:message code="M02066" />'
              	,'<spring:message code="M02067" />'
              	,'<spring:message code="M01307"/>'
              	],
	    colModel:[{name:'seqNo', index:'lt.seq_no', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false},
	              {name:'tierNm', index:'lt.tier_nm', resizable : false},
	              {name:'validStartDate', index:'lt.valid_start_date', resizable : false},
	              {name:'validEndDate', index:'lt.valid_end_date', resizable : false},
	              {name:'validEndDate', index:'lt.valid_end_date', resizable : false},
	              {name:'tierCdStatNm', index:'c.MARK_NAME',  resizable : false}
			      ],  
		radio:true,
		tempId : 'ifvGridOriginTemplete'
	};
	pointCnlList = $("#pointCnlList").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	pointCnlList();
});

</script>



<div class="page_btn_area">
    <div class="col-xs-7">
        <%-- <span><spring:message code="L01838" /></span> --%>
        <span><spring:message code="M02068" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="memberSearchBtn">
			<spring:message code="M02069" />
		</button> 
    </div>
</div>
<div id="pointCnlList" class="white_bg grid_bd0"></div> 
