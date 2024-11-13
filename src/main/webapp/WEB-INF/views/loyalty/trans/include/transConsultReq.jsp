<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var stampTxnList;
var gridIdstampTxnList;
var rid ;

//스탬프 거래리스트
function getstampTxnListSearch() {
    var jqGridOption = {
        ondblClickRow : function(data) {
            var obj = stampTxnList.getRowData()[data-1];
            rid = obj.rid;
            stampTxnDetailDtl();   // 상세 보기 이벤트
        },
        onSelectRow : function (data) {
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj) {
        },
        url : '<ifvm:action name="getStampTxnList"/>',
        colNames:[
                   '<spring:message code="L00554" />',  /*거래번호 */
                   '<spring:message code="L00555" />',  /*승인일시 */
                   '<spring:message code="L00556" />',  /*거래 상세유형*/
                   '<spring:message code="M00688" />',  /*회원번호 */
                   '<spring:message code="M00850" />',  /*회원명 */
                   '<spring:message code="L00557" />',  /*회원구분 */
                   '<spring:message code="L00180" />', /*회원등급 */
                   '<spring:message code="L00558" />', /*발생스탬프*/
                   '<spring:message code="L00559" />', /*사용스탬프 */
                   '<spring:message code="L00560" />', /*선물스탬프 */
                   '<spring:message code="L00561" />', /*가용스탬프 */
                   '<spring:message code="L00562" />', /*선물회원번호 */
                   '<spring:message code="L00563" />', /*선물회원명 */
                   '<spring:message code="L00564" />', /*가맹점코드 */
                   '<spring:message code="L00565" />', /*가맹점명 */
                   '<spring:message code="L00566" />', /*제품코드 */
                   '<spring:message code="L00567" />', /*제품명 */
                   '<spring:message code="L00568" />', /*스탬프금액 */

                   'rid'
        ],
        colModel:[
             { name:'txnNo',      index:'lst.txn_no',  resizable : true, align:'center',    width:'100px' },
             { name:'apprDt',     index:'lst.appr_dt',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'txnType2Cd', index:'lst.txn_type_2_cd',  resizable : true, align:'center',  formatter:'integer',   width:'100px' },
             { name:'mbrNo',      index:'lm.mbr_no',  resizable : true, align:'center',    width:'120px', formatter: goGridRowMbrLink },
             { name:'custNm',     index:'cst.CUST_NM',  resizable : true, align:'center',    width:'120px' },
             { name:'custNm',     index:'cst.CUST_NM',  resizable : true, align:'center',    width:'120px' },
             { name:'tierCd',     index:'lt.TIER_CD',  resizable : true, align:'center',    width:'120px' },
             { name:'useStamp',   index:'lst.acrl_stamp',  resizable : true, align:'center',    width:'120px' },
             { name:'giftStamp',  index:'lst.use_stamp',  resizable : true, align:'center',    width:'120px' },
             { name:'avlStamp',   index:'lst.gift_stamp',  resizable : true, align:'center',    width:'120px' },
             { name:'mbrNo2',     index:'lst.avl_stamp',  resizable : true, align:'center',    width:'120px' },
             { name:'custNm2',    index:'lm2.MBR_NO',  resizable : true, align:'center',    width:'120px' },
             { name:'chnlNo',     index:'cst.CUST_NM',  resizable : true, align:'center',    width:'120px' },
             { name:'chnlNm',     index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px' },
             { name:'proId',      index:'lp.PROD_ID',  resizable : true, align:'center',    width:'120px' },
             { name:'prodNm',     index:'lp.PROD_NM',  resizable : true, align:'center',    width:'120px' },
             { name:'unitCost',   index:'a.birth',  resizable : true, align:'center',    width:'120px' },
             { name:'birth',      index:'lst.unit_cost',  resizable : true, align:'center',    width:'120px' },
             { name:'rid',        index:'lst.rid',    hidden : true}
        ],
    };

    stampTxnList = $("#stampTxnListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdstampTxnList = $("#gridIdstampTxnList");
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}


//공통 조회 조건 목록 설정
function stampTxnListSearchInit() {

    $.fn.ifvmSetCommonCondList("stampTxnListSearchList","tesst");
}

//공통 조회 호출
function stampTxnListSearch() {
    $.fn.ifvmSubmitSearchCondition("stampTxnListSearchList", getstampTxnListSearch);
}

// 상세 팝업 화면 호출
function stampTxnDetailDtlPop(){

 $("#stampTxnDetailDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="stampTxnDetail"/>',
        contentType: "ajax",
        title: '<spring:message code="L02043" />',
        width: "1000px",
        close : 'stampTxnDetailPopClose'
    });
}

//팝업 닫기
function stampTxnDetailPopClose() {
 $('#stampTxnDetailDialog').ejDialog('destroy');
}

//고객 상세 이동
function stampTxnDetailDtl() {
 	var url = '<ifvm:url name="stampTxnDetail"/>';
 	if(rid !=null){
 		url = url + '?rid=' + rid;
 	}
 	qtjs.href(url);

}

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    stampTxnListSearchInit();

    stampTxnListSearch();
    //조회
    $('#stampTxnListSearchBtn').on('click', function(){
     stampTxnListSearch();
    });

    //초기화
    $("#stampTxnListSearchInitBtn").on('click', function(){
     stampTxnListSearchInit();
    });

});

</script>

	<div>
        <div class="col-xs-5 searchbtn_r"></div>
    	<div id="stampTxnListGrid" class="white_bg grid_bd0"></div>
	</div>

<div id="stampTxnDetailDialog" class="popup_container"></div>
