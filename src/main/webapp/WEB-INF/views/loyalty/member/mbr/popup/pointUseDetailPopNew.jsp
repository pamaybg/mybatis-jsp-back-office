<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style type="text/css">
#promoListGrid {
 min-height: 235px;

}
</style>
<script type="text/javascript">

var promoListGrid;

$(document).ready(function() {
    getPromoListSearch();    
    //$("#txnUniqNo")[0].innerHTML="거래고유번호 : " + txnUniqNo;
    $("#txnUniqNumber").val(txnUniqNo);
    $("#txnDtlDesc").val(txnDtlDesc);
});

/**
 * 프로모션 목록 조회
 */
function getPromoListSearch() {
    var ejGridOption = {
        serializeGridData : function(data) {
            /* var pointRid = promoRid;*/
            data.rid = txnRid;
            if (typeof defaultArchive != "undefined" && defaultArchive != "null") {
                data.defaultArchive = defaultArchive;
            }
            return data;
        },
        loadComplete : function(obj) {
        	/* //거래유형이 CS일경우에만 
            if(pointTxnDetail == 'CS' ){
            	$("#csDesc").val(promoList.opt.data.rows[0].acrlDesc);
            }else{
            	$('#csDiv').prop('hidden',true);
            } */
        },
        dataUrl : '<ifvm:action name="getPointUseTxnList"/>',
        columns : [
	        // 오퍼명
	        {
	            field : 'ofrNo',
	            headerText : '<spring:message code="오퍼번호"/>',
	            headerTextAlign : 'center',
	            textAlign : 'center',
	            width : '100',
	            customAttributes : {
	                index : 'ofrNo'
	                ,searchable:true
	            }
	        },
	        // 오퍼명
	        {
	            field : 'ofrNm',
	            headerText : '<spring:message code="오퍼명"/>',
	            headerTextAlign : 'center',
	            textAlign : 'left',
	            width : '200',
	            customAttributes : {
	                index : 'ofrNm'
	            }
	        },
	        // 차감 포인트
	        {
	            field : 'rdmAmt',
	            headerText : '<spring:message code="차감 포인트"/>',
	            headerTextAlign : 'center',
	            width : '80',
	            textAlign : 'right',
	            format : '{0:n0}',
	            customAttributes : {
	                index : 'rdmAmt'
	            }
	        },
	        // 마이너스포인트 상태
	        {
	            field : 'mnsPntStatNm',
	            headerText : '<spring:message code="마이너스포인트 상태"/>',
	            headerTextAlign : 'center',
	            textAlign : 'center',
	            width : '100',
	            customAttributes : {
	      			  index : 'mnsPntStatCd' 
	      		}
	        },
	         // 거래일시
	        {
	            field : 'txnDate',
	            headerText : '<spring:message code="거래일시"/>',
	            headerTextAlign : 'center',
	            textAlign : 'center',
	            width : '130px',
	            customAttributes : {
	                index : 'txnDate'
	            }
	        }
	   ],
        requestGridData : {
            nd : new Date().getTime(),
            rows : 10,
            sidx : 'txnDate', 
            sord : 'desc',
            _search : false
        },
        rowList : [ 10, 25, 50, 100 ],
        radio : false,
    	tempId : 'ifvGridTxnUniqNoTemplete'
    };
    promoListGrid = $("#promoListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

</script>
<div>
    <div id="promoListGrid" class="white_bg grid_bd0"></div>
</div>
<div class="form-horizontal top_well" id="pntTxnDetailPop">
		<br>
		<div class="row qt_border">
			<div class="col-xs-12">
				<ifvm:inputNew type="text" id="txnUniqNumber" names="txnUniqNumber" dto="txnUniqNumber" label="거래고유번호" labelClass="1" conClass="11" disabled="true" />
			</div>
		</div>
		<div class="row qt_border">
			<div class="col-xs-12">
				<ifvm:inputNew type="textarea" id="txnDtlDesc" names="txnDtlDesc" dto="txnDtlDesc" label="비고" labelClass="1" conClass="11" rows="4" disabled="true"/>
			</div>
		</div>
</div>
<%-- <div class ="row qt_border" id="csDiv">
	<label class="col-xs-1 control-label">CS지급사유</label>
	<div class="col-xs-6">
		<ifvm:input type="textarea" id="csDesc" disabled="true" rows="5"/>
	</div>
</div> --%>
