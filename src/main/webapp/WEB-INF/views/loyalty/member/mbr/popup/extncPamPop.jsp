<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var exTncGrid;

$(document).ready(function() {
    getExtncSearch();    
});

/**
 * 프로모션 목록 조회
 */
function getExtncSearch() {
    var ejGridOption = {
        serializeGridData : function(data) {
        	data.ridMbr= mbr_rid;        
            return data;
        },
        loadComplete : function(obj) {
        
        },
        dataUrl : '<ifvm:action name="getExtncList"/>',
        columns : [
	        // 오퍼번호
	        {
	            field : 'ofrNo',
	            headerText : '<spring:message code="오퍼번호"/>',
	            headerTextAlign : 'center',
	            textAlign : 'center',
	            width :'90px',
	            customAttributes : {
	                index : 'ofrNo'
	                ,searchable:true
	            }
	        },
	        // 오퍼명
	        {
	            field : 'ofrNm',
	            headerText : '오퍼명',
	            headerTextAlign : 'center',
	            textAlign : 'left',
	            width : '220px',
	            customAttributes : {
	                index : 'ofrNm'
	                ,searchable:true
	            }
	        },
	        // 적립일
	        {
	            field : 'acrlDate',
	            headerText : '적립일자',
	            headerTextAlign : 'center',
	            textAlign : 'center',
	            width : '110px',
	            customAttributes : {
	                index : 'acrlDate'
	            }
	        },
	        // 유효시작일
	        {
	            field : 'validStartDt',
	            headerText : '유효시작일',
	            headerTextAlign : 'center',
	            textAlign : 'center',
	            width : '100px',
	            customAttributes : {
	                index : 'validStartDt'
	            }
	        },
	        {
	            field : 'validEndDt',
	            headerText : '유효종료일',
	            headerTextAlign : 'center',
	            textAlign : 'center',
	            width : '100px',
	            customAttributes : {
	                index : 'validEndDt'
	            }
	        },
	        // 적립금
	        {
	            field : 'acrlAmt',
	            headerText : '적립금',
	            headerTextAlign : 'center',
	            textAlign : 'right',
	            format : '{0:n0}',
	            width : '90px',
	            customAttributes : {
	                index : 'acrlAmt'
	            }
	        },
	        // 잔액
	    	{
	            field : 'blanc',
	            headerText : '잔액',
	            headerTextAlign : 'center',
	            textAlign : 'right',
	            format : '{0:n0}',
	            width : '90px',
	            customAttributes : {
	                index : 'blanc'
	            }
	        }
        ],
        requestGridData : {
            nd : new Date().getTime(),
            rows : 10,
            sidx : 'validEndDt', 
            sord : 'asc',
            _search : false
        },
        rowList : [ 10, 25, 50, 100 ],
        radio : false,
    };
    exTncGrid = $("#exTncGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

</script>
<div>

    <div id="exTncGrid" class="white_bg grid_bd0">
   </div>
</div>
<%-- <div class ="row qt_border" id="csDiv">
	<label class="col-xs-1 control-label">CS지급사유</label>
	<div class="col-xs-6">
		<ifvm:input type="textarea" id="csDesc" disabled="true" rows="5"/>
	</div>
</div> --%>
