<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var transactionGrid;
var pntTxnDateType = 'A'; // A 최신  B 과거

function transactionList(){
    var jqGridOption = {
           serializeGridData : function( data ){
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
            	if($("#detail_memRid").val() == ""){
            		data.mbrRidFlag = "1";
            	}else{
            		data.defaultMbrRid = $("#detail_memRid").val();
            	}
            	data.pntTxnDateType = pntTxnDateType;
            	
                return data;
            },
            loadComplete : function(data) {
				parent.setParentIframeHeight();
			},
            url : '<ifvm:action name="getTransactionListByRidMbr"/>',
            colNames:[
	                   '<spring:message code="L00554" />',  /*거래번호 */
	                   '<spring:message code="L00555" />',  /*승인일시 */
	                   '<spring:message code="L00556" />',  /*거래 상세유형*/

	                   '<spring:message code="L00414" />', /*카드번호 */
	                   '<spring:message code="L00918" />',
	                   '<spring:message code="L00919" />',
	                   '<spring:message code="L00582" />', /*발생포인트*/
	                   '<spring:message code="L00583" />', /*사용포인트 */
	                   '<spring:message code="L00584" />', /*선물포인트 */
	                   '<spring:message code="L00567" />', /*제품명 */
	                   '<spring:message code="L00355" />', /*거래금액 */
	                   '<spring:message code="L00564" />', /*가맹점코드 */
	                   '<spring:message code="L00565" />', /*가맹점명 */

	                   '<spring:message code="L00971" />', /*프로모션 항목 유무 */
	                   'rid',
	                   'ridMbr',
	                   'ridMbrCard',
	                   'mbrType',
	                   'cprtCardCd'
	                 ],
	        colModel:[
	             { name:'txnUniqNo',   index:'lpt.TXN_NUM',  resizable : true, align:'center',    width:'180px',sortable:false  },
	             { name:'apprDate',   index:'lpt.APPR_DATE',  resizable : true, align:'center',  width:'135px' ,formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"},sortable:false  },
	             { name:'pntTxnType2Cd',   index:'lpt.PNT_TXN_TYPE_2_CD',  resizable : true, align:'center',     width:'100px' ,sortable:false },

	             { name:'cardNoDecoding',   index:'lpt.CARD_NUM',  resizable : true, align:'center',    width:'150px' ,sortable:false  },
	             { name:'cardKndNm',   index:'cc4.mark_name',  resizable : true, align:'center',    width:'100px' ,sortable:false },
	             { name:'cprtCard',   index:'d.mark_name',  resizable : true, align:'center',    width:'100px' ,sortable:false },
	             { name:'pntAmt',   index:'lpt.PNT_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer' ,sortable:false },
	             { name:'usePnt',   index:'lpt.USE_PNT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable:false  },
	             { name:'giftPnt',   index:'lpt.GIFT_PNT',  resizable : true,align:'right',    width:'80px',formatter:'integer' ,sortable:false },
	             { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center',    width:'100px' ,sortable:false },
	             { name:'txnAmt',   index:'lpt.TXN_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable:false  },
	             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'80px' ,sortable:false },
	             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px' ,sortable:false },

	             { name:'promoCnt',   index:'promoCnt',  resizable : true, align:'center',    width:'120px',formatter: promoIsYn ,sortable:false },
	             { name:'rid',    index:'lpt.rid',    hidden : true},
	             { name:'ridMbr',    index:'lm.rid',    hidden : true},
	             { name:'ridMbrCard',    index:'lmc.rid',    hidden : true},
	             { name:'mbrType',    index:'lck.mbr_type',    hidden : true},
	             { name:'cprtCardCd',    index:'lmc.cprt_card_cd',    hidden : true}
	        ],
            sortname: 'apprDate',
    		sortorder: "desc",
//            	radio: true
        };
    
    
    transactionGrid = $("#transactionGridList").ifvGrid({ jqGridOption : jqGridOption });
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플 
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;
    
    if(cellvalue!=null){
//         tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id; 
//     var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id; 
//     var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    return tag;
}

function goGridRowProdLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridProd;
//     var url = '<ifvm:url name="productDetail"/>' + '?rid=' + id;
    var tag=null;
    if(cellvalue!=null){
//         tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}

function promoIsYn(cellvalue, options, rowObjec){
	var isYn;
	var promoCnt=null
	promoCnt = rowObjec.promoCnt;
	
	if(promoCnt !=0  && promoCnt !=null){
		isYn="Y"
	}else{
		isYn="N";
	}
	return isYn;
	
}
$(document).ready(function(){
	transactionList();
});
</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="V00041"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
   		<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('transactionGridList')" objCode="COM_EXC_001" />
 	</div>
</div>
<div id="transactionGridList" class="white_bg grid_bd0"></div>    