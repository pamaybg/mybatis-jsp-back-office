<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var mbrStmpTxnHistList;
var gridIdmbrStmpTxnHistList;
var rid ;


//스탬프  현재 수
function getMbrStmpInfo() {


	 $.ifvSyncPostJSON('<ifvm:action name="getMbrStmpInfo"/>', {
		mbrRid: gMbrDetail.data.rid
	 }, function(result) {

	  if($.fn.ifvmIsNotEmpty(result)) {

	  $('#mbrStampInfoForm').dataSetting( result );
	   }

	    });

	}

//스탬프 거래이력
function getmbrStmpTxnHistListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
	      var data = mbrStmpTxnHistList.getRowData()[data-1];
	      rid = data.rid;

        },
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        data.mbrRid = gMbrDetail.data.rid;

       	 return data;
        },
        loadComplete : function(obj){
        	window.top.setParentIframeHeight();
        },
        url : '<ifvm:action name="getMbrStmpTxnHistList"/>',
        colNames:[
                   '<spring:message code="L00993" />',
                   '<spring:message code="L00994" />',
                   '<spring:message code="L00995" />',
                   '<spring:message code="L00996" />',
                   '<spring:message code="L00997" />',
                   '<spring:message code="L00998" />',
                   '<spring:message code="L00559" />',
                   '<spring:message code="L00999" />',
                   '<spring:message code="L01000" />',
                   '<spring:message code="L01001" />',
                   '<spring:message code="L01002" />',
                   '<spring:message code="L01003" />',
                   '<spring:message code="L01004" />',
                   '<spring:message code="L01005" />',
                   '<spring:message code="L01006" />',
                   '<spring:message code="L01007" />',

                   'rid'
                 ],
        colModel:[
             { name:'txnNo',   index:'a.txn_no',  resizable : true, align:'center',    width:'180px' },
             { name:'apprDt',   index:'a.appr_dt',  resizable : true, align:'center',    width:'150px'  ,formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} },
             { name:'apprNo',   index:'a.appr_no',  resizable : true, align:'center',    width:'100px' },
             { name:'txnType1Cd',   index:'a.txn_type_1_cd',  resizable : true, align:'center',    width:'100px' },
             { name:'txnType2Cd',   index:'a.txn_type_2_cd',  resizable : true, align:'center',    width:'100px' },
             { name:'acrlStamp',   index:'a.acrl_stamp',  resizable : true, align:'right',  formatter:'integer',     width:'100px' },
             { name:'useStamp',   index:'a.use_stamp',  resizable : true, align:'right',  formatter:'integer',     width:'100px' },
             { name:'giftStamp',   index:'a.gift_stamp',  resizable : true, align:'right',  formatter:'integer',    width:'100px' },
             { name:'avlStamp',   index:'a.avl_stamp',  resizable : true, align:'right',  formatter:'integer',    width:'100px' },
             { name:'mbrNo',   index:'b.mbr_no',  resizable : true, align:'center',    width:'100px' },
             { name:'custNm',   index:'c.cust_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'chnlNo',   index:'d.chnl_no',  resizable : true, align:'center',    width:'100px' },
             { name:'chnlNm',   index:'d.chnl_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'prodId',   index:'e.prod_id',  resizable : true, align:'center',    width:'100px' },
             { name:'prodNm',   index:'e.prod_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'unitCost',   index:'a.unit_cost',  resizable : true, align:'center',    width:'100px' },

             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.rid',
        autowidth : true ,
        sortorder: "desc"
    };

    mbrStmpTxnHistList = $("#mbrStmpTxnHistListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdmbrStmpTxnHistList = $("#gridIdmbrStmpTxnHistList");
}


//공통 조회 호출
function mbrStmpTxnHistListSearch() {
    $.fn.ifvmSubmitSearchCondition("mbrStmpTxnHistListSearchList", getmbrStmpTxnHistListSearch);
}

// 상세 팝업 화면 호출
/* function mbrStmpTxnHistDetailDtlPop(){

 $("#mbrStmpTxnHistDetailDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrStmpTxnHistDetail"/>' + '?rid=' + rid ,
        contentType: "ajax",
        title: 'E1 오렌지 카드',
        width: '1000px',
        close : 'mbrStmpTxnHistDetailPopClose'
    });
} */

//팝업 닫기
function mbrStmpTxnHistDetailPopClose() {
 mbrStmpTxnHistDetailDialog._destroy();



}

//고객 상세 이동
function mbrStmpTxnHistDetailDtl() {
    qtjs.href('<ifvm:url name="mbrStmpTxnHistDetail"/>' + '?rid=' + rid);
}



$(document).ready(function() {
	getMbrStmpInfo();
    mbrStmpTxnHistListSearch();
    window.top.setParentIframeHeight();
});

</script>



<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>

	<div class="form-horizontal underline top_well" id="mbrStampInfoForm" >
	  	<div class="row  qt_border">
			<ifvm:inputNew type="number" id="recpStampCnt" maxLength="50"  dto="recpStampCnt"  label="L01010" labelClass="2" conClass="2" disabled="true" className="text-right" />
			<ifvm:inputNew type="number" id="useStampCnt" maxLength="50"  dto="useStampCnt"    label="L01011" labelClass="2" conClass="2" disabled="true"  className="text-right" />
			<ifvm:inputNew type="number" id="avlStampCnt" maxLength="50"  dto="avlStampCnt"    label="L01012" labelClass="2" conClass="2" disabled="true" className="text-right" />
		</div>
	</div>


     <div id="mbrStmpTxnHistListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="mbrStmpTxnHistDetailDialog" class="popup_container"></div>



