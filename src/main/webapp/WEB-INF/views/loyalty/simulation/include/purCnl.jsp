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
              	'<spring:message code="M02078" />'
              	,'<spring:message code="L00381"/>'
              	,'<spring:message code="L00435"/>'
              	,'<spring:message code="M02079" />'
              	,'<spring:message code="M00147"/>'
              	],
	    colModel:[{name:'seqNo', index:'lt.seq_no', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false},
	              {name:'tierNm', index:'lt.tier_nm', resizable : false},
	              {name:'validStartDate', index:'lt.valid_start_date', resizable : false},
	              {name:'validEndDate', index:'lt.valid_end_date', resizable : false}
			      ],  
		radio:true,
		/* footerrow:true,
		userDataOnFooter:true, */
		tempId : 'ifvGridOriginTemplete'
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
              	'NO'
              	,'<spring:message code="L00232"/>'
              	,'<spring:message code="L00231"/>'
              	,'<spring:message code="M00450"/>'
              	,'<spring:message code="M00786"/>'
              	,'<spring:message code="M00920"/>'
              	],
	    colModel:[{name:'seqNo', index:'lt.seq_no', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false}
			      ],  
		radio:true,
		tempId : 'ifvGridOriginTemplete'
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
        <span><spring:message code="M02080" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="memberSearchBtn">
            	<spring:message code="M02081" />
        </button> 
    </div>
</div>
<div class="half_wrap top_well">
	<div class="half_content half_left">
		<div class="page_btn_area">
		    <div class="col-xs-5">
		        <span><spring:message code="M02082" /></span>
		    </div>
		    <div class="col-xs-7 searchbtn_r">
		    </div>
		</div>
		<div id="purItemList" class="white_bg grid_bd0"></div> 
	</div>
	<div class="half_content half_right">
	    <div class="page_btn_area">
			<div class="col-xs-5">
			    <span><spring:message code="M02083" /></span>
			</div>
		    <div class="col-xs-7 searchbtn_r">
		    </div>
		</div>
		<div id="billInfoList" class="white_bg grid_bd0"></div> 
	</div>
</div>