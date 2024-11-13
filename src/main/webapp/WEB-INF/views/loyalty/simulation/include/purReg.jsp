<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var purItemList;
var billInfoList;

function purItemList(){
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
              	'NO'
              	,'<spring:message code="L00232"/>'
              	,'<spring:message code="L00200"/>'
              	,'<spring:message code="M00918"/>'
              	,'<spring:message code="M00786"/>'
              	,'<spring:message code="M00920"/>'
              	],
	    colModel:[{name:'seqNo', index:'lt.seq_no', align: "center", width: "50px"},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false},
	              {name:'tierNm', index:'lt.tier_nm', resizable : false},
	              {name:'validStartDate', index:'lt.valid_start_date', align: "right", resizable : false},
	              {name:'validEndDate', index:'lt.valid_end_date', align: "right", width: "50px"},
	              {name:'tierCdStatNm', index:'c.MARK_NAME', align: "right", resizable : false}
			      ],  
		radio:true,
		/* footerrow:true,
		userDataOnFooter:true, */
		tempId : 'gridTemplete'
	};
	purItemList = $("#purItemList").ifvGrid({ jqGridOption : jqGridOption });
}

function billInfoList(){
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
              	'<spring:message code="M02084" />'
              	,'<spring:message code="M02085" />'
              	,'<spring:message code="M02086" />'
              	],
	    colModel:[{name:'seqNo', index:'lt.seq_no', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false}
			      ],  
		radio:true,
		tempId : 'gridTemplete'
	};
	billInfoList = $("#billInfoList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	purItemList();
	billInfoList();
});

</script>


<script id="gridTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        <div class="grid_con">
            {grid}
        </div>
    </div>
</script>

<div class="page_btn_area">
    <div class="col-xs-7">
        <%-- <span><spring:message code="L01838" /></span> --%>
        <span><spring:message code="M02087" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="memberSearchBtn">
            	<spring:message code="M02088" />
        </button> 
        <button class="btn btn-sm" id="memberSearchInitBtn">
            <spring:message code="M00278" />
        </button> 
    </div>
</div>
<div class="half_wrap top_well">
	<div class="half_content half_left">
		<div class="page_btn_area">
		    <div class="col-xs-5">
		        <%-- <span><spring:message code="L01838" /></span> --%>
		        <span><spring:message code="M02089" /></span>
		    </div>
		    <div class="col-xs-7 searchbtn_r">
		        <button class="btn btn-sm" id="memberSearchBtn">
		        	<spring:message code="M00364" />
		        </button> 
		        <button class="btn btn-sm" id="memberSearchInitBtn">
		                        <spring:message code="M02090" />
		        </button> 
		        <button class="btn btn-sm" id="memberSearchInitBtn">
		                        <spring:message code="M02091" />
		        </button> 
		        <button class="btn btn-sm" id="memberSearchInitBtn">
		             <spring:message code="M00572" />
		        </button> 
		    </div>
		</div>
		<div id="purItemList" class="white_bg grid_bd0"></div> 
	</div>
	<div class="half_content half_right">
		<div class="page_btn_area">
			<div class="col-xs-5">
			       <%-- <span><spring:message code="L01838" /></span> --%>
			    <span><spring:message code="M02092" /></span>
			    
			</div>
		    <div class="col-xs-7 searchbtn_r">
		     	<button class="btn btn-sm" id="memberSearchBtn">
		        	<spring:message code="M02093" />
		        </button> 
		    </div>
		</div>
	    <div class="form-horizontal">
	    	<div class="row qt_border"></div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00850" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="text" id="bnftCreateBy" disabled="true" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00343" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="select" id="bnftCreateBy" disabled="true" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00342" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="text" id="bnftCreateBy" disabled="true" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00180" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="select" id="bnftCreateBy" disabled="true" />
		        </div>
		    </div>
	    </div>
	    <div class="page_btn_area">
			<div class="col-xs-5">
			       <%-- <span><spring:message code="L01838" /></span> --%>
			    <span><spring:message code="M02094" /></span>
			</div>
		    <div class="col-xs-7 searchbtn_r">
		     	<button class="btn btn-sm" id="memberSearchBtn">
		        	<spring:message code="M02095" />
		        </button> 
		    </div>
		</div>
		<div id="billInfoList" class="white_bg grid_bd0"></div> 
	</div>
</div>