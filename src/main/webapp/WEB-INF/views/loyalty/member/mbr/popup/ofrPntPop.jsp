<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var pntListGrid;

$(document).ready(function() {
    getPntSearch();   
    
    $("#ofrPntPopValidDateModify").click(function(){
    	ofrPntPopValidDateModifyPopup();
	});
    
    
});

function ofrPntPopValidDateModifyPopup() {
	if ($.fn.ifvmIsEmpty(pntListGrid.opt.gridControl.getSelectedRecords()[0])) {
		 alert('<spring:message code="목록을 선택해주세요."/>');
		 return;
   }
	$("#ofrPntPopValidDateModifyPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrPntPopValidDateModifyPop"/>',
        contentType: "ajax",
        title: '포인트 유효기간변경',
        width: 800,
        close : 'ofrPntPopValidDateModifyClosePop'
	});
}

function ofrPntPopValidDateModifyClosePop() {
	ofrPntPopValidDateModifyPop._destroy();
}

/**
 * 프로모션 목록 조회
 */
function getPntSearch() {
    var ejGridOption = {
        serializeGridData : function(data) {
        	data.ridMbr= mbr_rid;        
            return data;
        },
        loadComplete : function(obj) {
        	
        },rowSelected : function(args){
			ofrNo = args.data.ofrNo;
			ofrNm = args.data.ofrNm;
			validStartDt = args.data.validStartDt; 
			validEndDt = args.data.validEndDt;
			rid        = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getOfrPntList"/>',
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
	        },{
	            field : 'acrlDesc',
	            headerText : '비고',
	            headerTextAlign : 'center',
	            textAlign : 'left',
	            width : '180px',
	            customAttributes : {
	                index : 'acrlDesc'
	            }
	        },{
	    		  field : 'rid', headerText : 'rid',visible : false 
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
        radio : true,
    };
    pntListGrid = $("#pntListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

</script>
<div>
	<div class="page_btn_area" >
    <div class="col-xs-7">
	</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="ofrPntPopValidDateModify" text="유효기간변경"  objCode="ofrPntPopValidDateModify_OBJ"/>
        </div>
    </div>
    <div id="pntListGrid" class="white_bg grid_bd0">
   </div>
</div>

<div id="ofrPntPopValidDateModifyPop" class="popup_container"></div>

<%-- <div class ="row qt_border" id="csDiv">
	<label class="col-xs-1 control-label">CS지급사유</label>
	<div class="col-xs-6">
		<ifvm:input type="textarea" id="csDesc" disabled="true" rows="5"/>
	</div>
</div> --%>
