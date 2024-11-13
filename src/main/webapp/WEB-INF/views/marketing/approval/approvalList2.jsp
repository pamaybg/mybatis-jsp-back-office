<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function testPopupOpen() {
   var contUrl = '/marketing/approval/popup/testPopup4';
    $("#testPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: contUrl,
        contentType: "ajax",
        title: '가나다라마바사',
        width: '600px',
        maxHeight: null,
        close : 'testPopupClose'
    });
}

function testPopupClose() {
   testPopup._destroy();
}

var transactionList;
var gridTransactionList;
var rid=null ;
var cardCheckObj={};

function geTtransactionSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var obj = transactionList.getRowData()[data-1];
      rid = obj.rid;
      transactionDetailDtl();   // 상세 보기 이벤트
        },

        onSelectRow : function (data) {
        	rid=data.rid;
        	cardCheckObj=data;
        	buttonStatus();
        },
        onSelectRow : function (data) {
        	rid=data.rid;
        	cardCheckObj=data;
        	buttonStatus();
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
                for(var i=0; i<requestitem.length; i++){
                	if(requestitem[i].baseTable=="loy_mbr"){
                		if(requestitem[i].whereVal!=""){
                    		data.isMbrYn="Y";
                		}
                	}
                	if(requestitem[i].baseTable=="loy_channel"){
                		if(requestitem[i].whereVal!=""){
                    		data.isChnlYn="Y";
                		}
                	}
                	if(requestitem[i].baseTable=="loy_prod"){
                		if(requestitem[i].whereVal!=""){
                    		data.isProdYn="Y";
                		}
                	}

                }

       			data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        	cardCheckObj={};
        	buttonStatus();
        },
        url : '<ifvm:action name="getTransactionList"/>',
        colNames:[
                   '<spring:message code="L00554" />',  /*거래번호 */
                   '<spring:message code="L00555" />',  /*승인일시 */
                   '<spring:message code="L00556" />',  /*거래 상세유형*/
                   '<spring:message code="M00688" />',  /*회원번호 */
                   '<spring:message code="M00850" />',  /*회원명 */
                   '<spring:message code="L00557" />',  /*회원구분 */
                   '<spring:message code="L00187" />',  /*회원등급 */
                   '<spring:message code="L00414" />', /*카드번호 */
                   '<spring:message code="L00192" />', /*카드종류 */
                   '제휴사 코드', /*제휴사코드  */
                   '<spring:message code="L00919" />', /*제휴사 */
                   '<spring:message code="L00582" />', /*발생포인트*/
                   '<spring:message code="L00583" />', /*사용포인트 */
                   '<spring:message code="L00584" />', /*선물포인트 */
                   '<spring:message code="L00971" />', /*프로모션 포인트 */
                   '<spring:message code="L00567" />', /*제품명 */
                   '<spring:message code="L00355" />', /*거래금액 */
                   '<spring:message code="L00788" />', /*가맹점코드 */
                   '<spring:message code="L00789" />', /*가맹점명 */

                   'rid',
                   'ridMbr',
                   'ridMbrCard',
                   'memDivCd',
                   'cardTypeCdCode'
                 ],
        colModel:[
             { name:'txnUniqNo',   index:'lpt.TXN_UNIQ_NO',  resizable : true, align:'center',    width:'180px' ,sortable: false},
             { name:'apprDate',   index:'lpt.APPR_DATE',  resizable : true, align:'center',  width:'135px' ,formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,sortable: false},
             { name:'pntTxnType2Cd',   index:'lpt.PNT_TXN_TYPE_2_CD',  resizable : true, align:'center',     width:'100px' ,sortable: false},
             { name:'mbrNo',   index:'lm.MBR_NO',  resizable : true, align:'center',   formatter: goGridRowMbrLink,  width:'80px',sortable: false },
             { name:'custNm',   index:'lm.MBR_HID_NM',  resizable : true, align:'center', /*formatter: goGridRowMbrLink,*/   width:'60px',sortable: false },
             { name:'memDiv',   index:'lpt.MEM_DIV',  resizable : true, align:'center',    width:'80px',sortable: false },
             { name:'memGrade',   index:'lpt.MEM_GRADE',  resizable : true, align:'center',    width:'80px' ,sortable: false},
             { name:'cardNoDecoding',   index:'lpt.CARD_NUM',  resizable : true, align:'center',    width:'150px' ,sortable: false},
             { name:'cardTypeCd',   index:'lpt.CARD_TYPE_CD',  resizable : true, align:'center',    width:'80px' ,sortable: false},
             { name:'cprtCardCd',   index:'cprtCardCd',  hidden: true},
             { name:'cprtCardCdName',   index:'cprtCardCdName',  resizable : true, align:'center',    width:'80px' ,sortable: false},
             { name:'pntAmt',   index:'lpt.PNT_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer' ,sortable: false},
             { name:'usePnt',   index:'lpt.USE_PNT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable: false },
             { name:'giftPnt',   index:'lpt.GIFT_PNT',  resizable : true,align:'right',    width:'80px',formatter:'integer',sortable: false },
             { name:'promoCnt',   index:'promoCnt',  resizable : true, align:'right',    width:'120px' ,sortable: false, formatter : 'integer'},
             { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center',  formatter :goGridRowProdLink ,  width:'100px',sortable: false },
             { name:'txnAmt',   index:'lpt.TXN_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable: false },
             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'80px',sortable: false },
             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px',sortable: false },
             { name:'rid',    index:'lpt.rid',    hidden : true},
             { name:'ridMbr',    index:'lm.rid',    hidden : true},
             { name:'ridMbrCard',    index:'lmc.rid',    hidden : true},
             { name:'memDivCd',    index:'memDivCd',    hidden : true},
             { name:'cardTypeCdCode',    index:'lpt.CARD_TYPE_CD',    hidden : true}
        ],
        sortname: 'apprDate',
		sortorder: "desc",
       	radio: true
    };
    transactionList = $("#transactionListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridTransactionList = $("#gridTransactionList");
}
var jqGridOptionInit = {
		  colNames:[
	                   '<spring:message code="L00554" />',  /*거래번호 */
	                   '<spring:message code="L00555" />',  /*승인일시 */
	                   '<spring:message code="L00556" />',  /*거래 상세유형*/
	                   '<spring:message code="M00688" />',  /*회원번호 */
	                   '<spring:message code="M00850" />',  /*회원명 */
	                   '<spring:message code="L00557" />',  /*회원구분 */
	                   '<spring:message code="L00187" />',  /*회원등급 */
	                   '<spring:message code="L00414" />', /*카드번호 */
	                   '<spring:message code="L00192" />', /*카드종류 */
	                   '<spring:message code="L00919" />', /*제휴사 */
	                   '<spring:message code="L00582" />', /*발생포인트*/
	                   '<spring:message code="L00583" />', /*사용포인트 */
	                   '<spring:message code="L00584" />', /*선물포인트 */
	                   '<spring:message code="L00971" />', /*프로모션 포인트 */
	                   '<spring:message code="L00567" />', /*제품명 */
	                   '<spring:message code="L00355" />', /*거래금액 */
	                   '<spring:message code="L00788" />', /*가맹점코드 */
	                   '<spring:message code="L00789" />', /*가맹점명 */

	                   'rid',
	                   'ridMbr',
	                   'ridMbrCard',
	                   'cardTypeCdCode'
	                 ],
	        colModel:[
	             { name:'txnUniqNo',   index:'lpt.TXN_UNIQ_NO',  resizable : true, align:'center',    width:'180px' ,sortable: false},
	             { name:'apprDate',   index:'lpt.APPR_DATE',  resizable : true, align:'center',  width:'135px' ,formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,sortable: false},
	             { name:'pntTxnType2Cd',   index:'lpt.PNT_TXN_TYPE_2_CD',  resizable : true, align:'center',     width:'100px' ,sortable: false},
	             { name:'mbrNo',   index:'lm.MBR_NO',  resizable : true, align:'center',   formatter: goGridRowMbrLink,  width:'80px',sortable: false },
	             { name:'custNm',   index:'lm.MBR_HID_NM',  resizable : true, align:'center', /*formatter: goGridRowMbrLink,*/   width:'60px',sortable: false },
	             { name:'memDiv',   index:'lpt.MEM_DIV',  resizable : true, align:'center',    width:'80px',sortable: false },
	             { name:'memGrade',   index:'lpt.MEM_GRADE',  resizable : true, align:'center',    width:'80px' ,sortable: false},
	             { name:'cardNoDecoding',   index:'lpt.CARD_NUM',  resizable : true, align:'center',    width:'150px' ,sortable: false},
	             { name:'cardTypeCd',   index:'lpt.CARD_TYPE_CD',  resizable : true, align:'center',    width:'80px' ,sortable: false},
	             { name:'cprtCardCdName',   index:'cprtCardCdName',  resizable : true, align:'center',    width:'80px' ,sortable: false},
	             { name:'pntAmt',   index:'lpt.PNT_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer' ,sortable: false},
	             { name:'usePnt',   index:'lpt.USE_PNT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable: false },
	             { name:'giftPnt',   index:'lpt.GIFT_PNT',  resizable : true,align:'right',    width:'80px',formatter:'integer',sortable: false },
	             { name:'promoCnt',   index:'promoCnt',  resizable : true, align:'center',    width:'120px' ,sortable: false,formatter : 'integer'},
	             { name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center',  formatter :goGridRowProdLink ,  width:'100px',sortable: false },
	             { name:'txnAmt',   index:'lpt.TXN_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable: false },
	             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'80px',sortable: false },
	             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px',sortable: false },
	             { name:'rid',    index:'lpt.rid',    hidden : true},
	             { name:'ridMbr',    index:'lm.rid',    hidden : true},
	             { name:'ridMbrCard',    index:'lmc.rid',    hidden : true},
	             { name:'cardTypeCdCode',    index:'lpt.CARD_TYPE_CD',    hidden : true}
	        ],
        dataType:"clientSide",
        data : {}
	}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	if( rowObjec.memDivCd == 'P' ||rowObjec.memDivCd == 'T' ){
	    var id = rowObjec.ridMbr;
	    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
	    var tag=null;
	}else{
		 var id = rowObjec.ridMbr;
	    var url = '<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + id;
	    var tag=null;

	}

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
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

function goGridRowProdLink(cellvalue, options, rowObjec){
	//콜센터 사용자일 경우는 제픔 링크 걸지 않음
	var authList = $.ifvmGetAuthInfo().authList;
	var isAuth = true;

	for(var i = 0 ; i < authList.length ;i++){
		if(authList[i].authName == 'E10005'){
			isAuth = false;
		}
	}
	var id = rowObjec.ridProd;
    var url = '<ifvm:url name="productDetail"/>' + '?rid=' + id;
    var tag=null;
    if(cellvalue!=null && isAuth){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag=cellvalue;
    }
    return tag;
}


//공통 조회 조건 목록 설정
function transactionListSearchInit() {
    $.fn.ifvmSetCommonCondList("transactionSearchList","PGM_L_050");
    searchInitialize();
}

function dateValid(filedName){  //날짜 한달 이상 조회 못하게 validation
	var betweenDay 	=  0
	var dateValid =true;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == filedName ){
			if($(this).parents('.SearchCondition').css("display")	!="none"){
				var startDt = $(this).parents('.SearchCondition').find('.changeTypeAreaCode .start_date input').val()
				var endDt = $(this).parents('.SearchCondition').find('.changeTypeAreaCode .end_date input').val();
				var dateArray = startDt.split("-");
				var startObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);
				dateArray = endDt.split("-");
				var endObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);
				betweenDay  =  (endObj.getTime() - startObj.getTime())/1000/60/60/24;
			}
		}
	})
	if(betweenDay>30){
		dateValid = false;
	}
	return dateValid;
}

function searchBlankCheck(){
	var blankCheck=false;
	var searchCondSize= $('.changeTypeAreaCode').size();
	var displayRowNum=[];
	var txnCheck=0;
	$($('.row.qt_border.SearchCondition')).each(function(index,item){
		if($("#rows"+index).css("display") !="none"){
			if($("#rows"+index).children(".changeTypeAreaCode").find('.smart-form').size()!=0){ //date
				if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_frt.start_date").children(".smart-form").children(".input").children("input").val() !=""
					&& $("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_scd.end_date").children(".smart-form").children(".input").children("input").val() !="" ){
					txnCheck++;
				}
			}
			if($("#rows"+index+ " .searchTextVal option:selected").attr('joinsrcclm')=="TXN_NUM"){
				if($("#rows"+index+ " .changeTypeAreaCode input").val()!=""){
					txnCheck++;
				}
			}
		}
	})  //빈값 처리
	if(txnCheck>0){
		blankCheck=true;
	}
	return blankCheck;
}
function searchInitialize(){
	$(".SearchCondition .searchCondition option[value='LIKE']").remove();
	$(".SearchCondition .searchCondition option[value='NOT']").remove();
	$(".datepicker").val("");
}

function commSearchEventFn(){
    $('.itemPlusBtn').live('click', function(){
   	 searchInitialize();
    })
    $('.itemMinusBtn').live('click', function(){
   	 searchInitialize();
    })
    $('.searchTextVal').live('change', function(){
   	 searchInitialize();
    });
}

//공통 조회 호출
function transactionListSearch() {
	var searchValidation =true ;

	if(!searchBlankCheck()){
		alert('<spring:message code="L01859" />');
		searchValidation=false;
	}

	if(!dateCondUniqueCheck()){
		alert('<spring:message code="L02016" />');
		searchValidation=false;
	}

	var filedName = 'APPR_DT'
	if(!dateValid(filedName)){
		alert('<spring:message code="L01861" />');
		searchValidation=false;
	}

	filedName = 'TXN_DT'
	if(!dateValid(filedName)){
		alert('<spring:message code="L01862" />');
		searchValidation=false;
	}
	if(searchValidation){
	    $.fn.ifvmSubmitSearchCondition("transactionSearchList", geTtransactionSearch);
	}else{
		 $("#transactionListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
	}
}

//고객 상세 이동
function transactionDetailDtl() {
 	var url = '<ifvm:url name="transactionDetail"/>';
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	qtjs.href(url);
}

function fnPointDetailPop(){
	 pointDetailPop ={
		        id : "pointDetailPopDiv"
		    };
	 pointDetailPop.popup = function (){
	 	pointDetailPop.pop = $('#'+pointDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointDetailPop"/>' +"?promoRid="+rid,
		            contentType: "ajax",
		            title: '<spring:message code="L02044" />',
		            width: "1000px"
		        });
		};
		pointDetailPop.beforeClose = function (obj) {
		};
		pointDetailPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 pointDetailPop.popup();
}

function dateCondUniqueCheck(){
	var uniqueCheck = [];
	var uniqueValid=true;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if(  $(this).val()=="DATE" &&   $(this).parents('.SearchCondition').css("display")	!="none"){
			$(this).attr('joinsrcclm');
			uniqueCheck.push($(this).attr('joinsrcclm'));
		}
	})
	for(var i=0; i<uniqueCheck.length; i++){
		for(var j=0; j<i;j++){
			if(uniqueCheck[i]==uniqueCheck[j]){
				uniqueValid=false;
			}
		}
	}
	return uniqueValid;
}

function buttonStatus(){
	var promoCnt=null
	promoCnt = cardCheckObj.promoCnt;

	if(promoCnt ==0 || promoCnt ==null){
		$("#pointDtlPopBtn").attr('disabled',true);
	}else{
		$("#pointDtlPopBtn").attr('disabled',false);
	}

	rid!=null&&(cardCheckObj.cardTypeCdCode=='20'&& cardCheckObj.cprtCardCd!='' && cardCheckObj.cprtCardCd !=null)
		? $('#unMaskBtn').attr('disabled',false) : $('#unMaskBtn').attr('disabled',true);
}

function fnUnMak(){
	if ($.fn.ifvmIsNotEmpty(rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	            rid: rid ,
	            type: 'txn' ,
	            field: 'cardNo'
	        },
	        function(result) {
	        	var rowid = transactionList.getRadioSelectedRowId();
	        	if(result.message!=null){
	        		transactionList.opt.grid.setCell( rowid, 'cardNoDecoding' , result.message );
	        	}
	        });
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
		$("#unMaskBtn").remove();
	}
}
$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
    //공통 조회 조건 목록 설정
    transactionListSearchInit();
    $("#transactionListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
    //포인트 상세
    $("#pointDtlPopBtn").on("click",function(){
    	if(rid!=null){
        	fnPointDetailPop();
    	}else{
    		alert('<spring:message code="L01820" />');
    	}
    });

    //마스킹 해제
    $("#unMaskBtn").on("click",function(){
    	fnUnMak();
    })

    //공통 조회조건 추가 제어 기능
    commSearchEventFn();

});

</script>

<div id="">
    <div   class="well form-horizontal well_sum">
        <div class="campaign_load_contents">
            <div class="page_btn_area border_bottom_zero">
                <div class="col-xs-7">
                    <span><spring:message code="L01833"/></span>
                </div>
                <div class="col-xs-5 searchbtn_r">
               <ifvm:inputNew type="button" btnType="select" text="테스트1" btnFunc="testPopupOpen" nuc="true" />
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 시작 -->


<div class="page-title">
    <h1>
        <spring:message code="L00890"/><!-- KPI분석 -->
        &gt; <spring:message code="L00081"/><!-- 캠페인 결과 및 성과 -->
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span><!-- 조회조건 -->
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pointListSearchBtn" btnFunc="transactionListSearch"/><!-- 검색 -->
            <ifvm:inputNew type="button"   text="M00278"  id="pointListSearchInitBtn" btnFunc="transactionListSearchInit"/><!-- 초기화 -->
        </div>
    </div>
	<div class="well form-horizontal well_bt5" id="transactionSearchList"></div>
</div>
<!-- 조회결과 -->
<div>

</div>
<!-- 끝 -->

<div id="testPopup" class="popup_container"></div>