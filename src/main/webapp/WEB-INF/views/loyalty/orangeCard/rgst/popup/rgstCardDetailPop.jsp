<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>

var testViewList_rid = rid;

var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
var manualDtlValidation;
var cardDtlList;
var ridPntTxn = null ;
var cardPopObj;

function getCardDtlListSearch(){
  var jqGridOption = {
  		serializeGridData : function( data ){
	       		data.rid = testViewList_rid
	            return data;
	        },
	        onSelectRow : function (data) {
	        	cardPopObj=data;
	        	ridPntTxn=data.ridPntTxn;
	        	unMaskPopBtnStatus();
	        	popBtnValid();
	        },
	        loadComplete : function(obj){
	        	cardPopObj={};
	        	unMaskPopBtnStatus();
	        },
	        url : '<ifvm:action name="getPointTransHistory"/>',
	        colNames:[
	                   '<spring:message code="L00554" />',  /*거래번호 */
	                   '<spring:message code="L00604" />',  /*거래일시 */
	                   '<spring:message code="L00555" />',  /*승인일시*/
	                   '<spring:message code="L00556" />',  /*거래상세유형 */
	                   '<spring:message code="L00414" />',  /*카드번호 */
	                   '<spring:message code="L00582" />',  /*발생포인트 */
	                   '<spring:message code="L00583" />',  /*사용포인트 */
	                   '<spring:message code="L00584" />',  /*선물포인트 */
	                   '<spring:message code="L00468" />',  /*가용포인트 */
	                   '<spring:message code="L00567" />',  /*제품명 */
	                   '<spring:message code="L00355" />',  /*거래금액 */
	                   '<spring:message code="L00564" />',  /*가맹점코드 */
	                   '<spring:message code="L00565" />',  /*가맹점명 */
	                   '<spring:message code="L00585" />',  /*동호회번호 */
	                   '<spring:message code="L00586" />',  /*동호회명 */
	                   '<spring:message code="L00587" />',  /*동호회포인트 */
	                   '<spring:message code="L00971" />', /*프로모션 포인트 */
	                   '<spring:message code="L00562" />',  /*선물회원번호 */
	                   '<spring:message code="L00563" />',  /*선물회원명 */

	                   'rid',
	                   'ridPntTxn',
	                   'cardTypeCd',
	                   'cprtCardCdCode'
	                 ],
	        colModel:[
	            { name:'txnUniqNo',   index:'lpt.TXN_UNIQ_NO',  resizable : true, align:'center',    width:'100px' },
	            { name:'txnDate',   index:'lpt.TXN_DT',  resizable : true, align:'center',    width:'150px' , formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} },
	            { name:'apprDate',   index:'lpt.APPR_DT',  resizable : true, align:'center',    width:'150px', formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} },
	            { name:'pntTxnType2Cd',   index:'cc1.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
	            { name:'cardNo',   index:'lmc.CARD_NO',  resizable : true, align:'center',    width:'150px' },
	            { name:'pntAmt',   index:'lpt.PNT_AMT',  resizable : true, align:'right',    width:'80px' ,formatter : 'integer'},
	            { name:'usePnt',   index:'lpt.USE_PNT',  resizable : true, align:'right',    width:'80px' ,formatter : 'integer'},
	            { name:'giftPnt',   index:'lpt.GIFT_PNT',  resizable : true, align:'right',    width:'80px' ,formatter : 'integer'},
	            { name:'totalPntVal',   index:'lpt.TOTAL_PNT_AVL',  resizable : true, align:'right',    width:'80px', formatter : 'integer' },
	            { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center',    width:'100px' },
	            { name:'txnAmt',   index:'lpt.TXN_AMT',  resizable : true, align:'right',    width:'80px',formatter : 'integer' },
	            { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'100px' },
	            { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'100px' },
	            { name:'groupNo',   index:'lc2.CHNL_NO',  resizable : true, align:'center',    width:'100px' },
	            { name:'groupNm',   index:'lc2.CHNL_NM',  resizable : true, align:'center',    width:'100px' },
	            { name:'groupPnt',   index:'lpt.GROUP_PNT',  resizable : true, align:'right',    width:'100px' ,formatter : 'integer' },
	            { name:'promoCnt',   index:'promoCnt',  resizable : true, align:'right',    width:'100px',formatter : 'integer' },
	            { name:'mbrNo',   index:'lm.MBR_NO',  resizable : true, align:'center',    width:'100px', formatter: goGridRowMbrLink },
	            { name:'cusNm',   index:'lm.MBR_HID_NM',  resizable : true, align:'center',    width:'100px' },


	            { name:'rid',   index:'lmc.rid', hidden : true},
	            { name:'ridPntTxn',   index:'lpt.rid', hidden : true  },
	            { name:'cardTypeCd',   index:'lck.MBR_TYPE', hidden : true  },
	            { name:'cprtCardCdCode',   index:'lmc.CPRT_CARD_CD', hidden : true  },
	        ],
	        sortname: 'lpt.rid',
			 sortorder: "desc",
	       	radio: true
	    };

  cardDtlList = $("#cardDtlListGrid").ifvGrid({ jqGridOption : jqGridOption });
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}


function saveCardInfo(){
	var submitData=$("#unRgstCardDtlForm").getSubmitData();
	submitData.cardRid=rid;
	submitData.popProdNm=$("#popProdNm").val();
	$.ifvSyncPostJSON('<ifvm:action name="updateCardInfo"/>',
			 submitData
		 , function(result) {
		 alert("<spring:message code='C00094'/>");
		 		$.ifvReload();
		    },function(result){
            });
}

function fnPromotionList(){
	rgstPromoDetailPop ={
		        id : "rgstPromoDetailPopDiv"
		    };
	rgstPromoDetailPop.popup = function (){
		 rgstPromoDetailPop.pop = $('#'+rgstPromoDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointDetailPop"/>'+"?promoRid="+ridPntTxn,
		            contentType: "ajax",
		            title: "<spring:message code='L00599'/>",
		            width: "1000px"
		        });
		};
		rgstPromoDetailPop.beforeClose = function (obj) {
		};
		rgstPromoDetailPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 rgstPromoDetailPop.popup();
}

function unMaskPopBtnStatus(){
 	if( cardPopObj.cardTypeCd=='20' && (cardPopObj.cardNo !=null && cardPopObj.cardNo !='') &&(cardPopObj.cprtCardCdCode!='' && cardPopObj.cprtCardCdCode!=null)  ){
 		$('#unMaskPopBtn').attr('disabled',false);
 	}else{
 		$('#unMaskPopBtn').attr('disabled',true);
 	}
	 /* (cardPopObj.cardNo !=null && cardPopObj.cardNo !='')    && (cardPopObj.cardTypeCd=='20'&&cardPopObj.cprtCardCdCode!='' )||cardPopObj.cardTypeCd=='30'
		? $('#unMaskPopBtn').attr('disabled',false) : $('#unMaskPopBtn').attr('disabled',true); */
}

function unMaskPopFn(){
	if ($.fn.ifvmIsNotEmpty(testViewList_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
            rid: ridPntTxn ,
            type: 'txn' ,
            field: 'cardNo'
        },
        function(result) {
        	var rowid = cardDtlList.getRadioSelectedRowId();
        	if(result.message!=null){
        		cardDtlList.opt.grid.setCell( rowid, 'cardNo' , result.message );
        	}
        });
	}
}

function popBtnValid(){
	var promoCnt=null
	promoCnt = cardPopObj.promoCnt;
	if(promoCnt ==0 || promoCnt ==null){
		$("#btnPromotionList").attr('disabled',true);
	}else{
		$("#btnPromotionList").attr('disabled',false);
	}
}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#unMaskPopBtn").remove();
	}

}
$(document).ready(function(){
	//마스킹해제 권한 체크
	//checkButtnAuth();
 	$.ifvmLnbSetting('testViewList');
 	getCardDtlListSearch();

 	$("#cardInfoSave").on("click",function(){
 		saveCardInfo();
 	});
 	$("#btnPromotionList").on("click",function(){
 		fnPromotionList();
 	})
});
</script>

<script id="userIdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="userCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>


<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L00637"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button"   text="L00326"  id="unMaskPopBtn" btnFunc="unMaskPopFn" disabled="true" objCode="rgstunMaskPopBtn_OBJ"/>
     	<ifvm:inputNew type="button"  btnType="search" text="M00169"  id="btnPromotionList" btnFunc="fnPromotionList" disabled="true" objCode="rgstbtnPromotionList_OBJ"/>
 	</div>
</div>
    <div id="cardDtlListGrid" class="white_bg grid_bd0"></div>
<script>
</script>

<div id="testViewListPopupContainer" class="popup_container"></div><!-- 팝업 -->
 <div id="rgstPromoDetailPopDiv" class="popup_container content_container"></div>
