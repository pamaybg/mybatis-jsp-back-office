<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="goGridRowMbrTemplate">
	{{if ridMbr != null}}
		{{if memDivCd == "P" || memDivCd == "T" }}
			<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
		{{else}}
			<a href="<ifvm:url name="mbrGroupDetail"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
		{{/if}}
	{{/if}}
</script>

<script type="text/javascript">
var transactionList;
var gridTransactionList;
var rid=null ;


var cardCheckObj={};
var regNumber = /[^0-9]/g;

function geTtransactionSearch(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
      var obj = args.data
      rid = obj.rid;
      transactionDetailDtl();   // 상세 보기 이벤트
        },

        rowSelected : function (data) {
        	rid=data.rid;
        	cardCheckObj=data;
        	buttonStatus();
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
//                 for(var i=0; i<requestitem.length; i++){

//                 	if(requestitem[i].baseTable=="loy_mbr"){
//                 		if(requestitem[i].whereVal!=""){
//                     		data.isMbrYn="Y";
//                 		}
//                 	}
//                 	if(requestitem[i].baseTable=="loy_channel"){
//                 		if(requestitem[i].whereVal!=""){
//                     		data.isChnlYn="Y";
//                 		}
//                 	}
//                 	if(requestitem[i].baseTable=="loy_prod"){
//                 		if(requestitem[i].whereVal!=""){
//                     		data.isProdYn="Y";
//                 		}
//                 	}

//                 	if(requestitem[i].srcCol=="CARD_NUM"  && requestitem[i].whereVal !=""){
//             			//requestitem[i].whereVal= requestitem[i].whereVal.replaceAll("-","");
//             			requestitem[i].whereVal= requestitem[i].whereVal.replaceAll(regNumber,"");
//             		      $.ifvSyncPostJSON('<ifvm:action name="getRgstEncryptCardNo"/>',{cardNo : requestitem[i].whereVal},
//             		        function(result) {
//             		        	requestitem[i].whereVal = result.cardNo
//             		        })
//             		}
//                 }

//        			data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        	cardCheckObj={};
        	buttonStatus();
        },
        dataUrl : '<ifvm:action name="getTransactionList"/>',
        columns:[
	      	  {
	      		  field : 'apprNo',
	      		  headerText : '<spring:message code="L00995"/>',
	      		  headerTextAlign : 'center',
	      		  width : '125px' ,
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lpt.appr_no' }/*승인번호*/
	      	  },{
	      		  field : 'apprDate',
	      		  headerText : '<spring:message code="L00935"/>',
	      		  headerTextAlign : 'center',
	      		  width : '125px' ,
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lpt.APPR_DT' }/*승인일시*/
	      	  },{
	      		  field : 'pntTxnType1Cd', headerText : '<spring:message code="L01514"/>', headerTextAlign : 'center', width : '70px' ,
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lpt.PNT_TXN_TYPE_1_CD' }/*거래유형*/
	      	  },{
	      		  field : 'pntTxnType2Cd', headerText : '<spring:message code="L00556"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lpt.PNT_TXN_TYPE_2_CD' }/*거래상세유형*/
	      	  },{
	      		  field : 'pntAmt', headerText : '<spring:message code="L00422"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right ,format : "{0:n0}",
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lpt.PNT_AMT' }/*포인트*/
	      	  },{
	      		  field : 'custNm', headerText : '<spring:message code="M00850"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lm.MBR_HID_NM' }/*회원명*/
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center',template : "#goGridRowMbrTemplate",
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lm.MBR_NO' }/*회원번호*/
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="L00565"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NM' }/*스토어명*/
	      	  },{
	      		  field : 'txnAmt', headerText : '<spring:message code="L00951"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : "{0:n0}",
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lpt.TXN_AMT' }/*구매금액*/
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'lpt.rid' }
	      	  },{
	      		  field : 'ridMbr', headerText : 'ridMbr',visible : false ,
	      		  customAttributes : {
	      			  index : 'lm.rid' }
	      	  },{
	      		  field : 'ridMbrCard', headerText : 'ridMbrCard', visible : false ,
	      		  customAttributes : {
	      			  index : 'lmc.rid' }
	      	  },{
	      		  field : 'memDivCd', headerText : 'memDivCd', visible : false ,
	      		  customAttributes : {
	      			  index : 'memDivCd' }
	      	  },{
	      		  field : 'cardTypeCdCode', headerText : 'cardTypeCdCode', visible : false ,
	      		  customAttributes : {
	      			  index : 'lpt.CARD_TYPE_CD' }
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lpt.txn_dt',
      	  sord : 'desc',
      	  _search : false
        },
        gridDataInit: false,
        rowList : [10,25,50,100],
        radio: true
    };
    transactionList = $("#transactionListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridTransactionList = $("#gridTransactionList");
}
// var jqGridOptionInit = {
// 		  colNames:[
// 		            '<spring:message code="L00554" />',  /*거래번호 */
// 		            '<spring:message code="L00934" />',  /*거래일시 */
// 		            '<spring:message code="L01514" />',  /*거래유형 */
// 		            '<spring:message code="L00556" />',  /*거래 상세유형*/
// 		            '<spring:message code="L00355" />', /*거래금액 */
// 		            '<spring:message code="L00582" />', /*발생포인트*/
// 		            '<spring:message code="L00381" />', /*영수증번호*/
// 		            '<spring:message code="L00351" />', /*거래 상태*/
// 		            '<spring:message code="M00850" />',  /*회원명 */
// 		            '<spring:message code="M00688" />',  /*회원번호 */
// 	                '<spring:message code="L00374" />',  /*승인번호 */
// 	                '<spring:message code="L00376" />',  /*승인일시 */
// 	                '<spring:message code="L00384" />',  /*원거래승인번호 */
// 	                '<spring:message code="L00385" />',  /*원거래승인일시 */
// 	                '<spring:message code="L00565" />',  /*가맹점명 */


// 		            'rid',
// 		            'ridMbr',
// 		            'ridMbrCard',
// 		            'memDivCd',
// 		            'cardTypeCdCode'
// 		          ],
// 		 colModel:[
// 		      { name:'txnUniqNo',   index:'lpt.TXN_UNIQ_NO',  resizable : true, align:'center',    width:'180px' ,sortable: false},					/*거래번호 */
// 		      { name:'apprDate',   index:'lpt.APPR_DATE',  resizable : true, align:'center',  width:'135px' ,formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,sortable: false},
// 		      { name:'pntTxnType1Cd',   index:'lpt.PNT_TXN_TYPE_1_CD',  resizable : true, align:'center',     width:'100px' ,sortable: false},		/*거래유형 */
// 		      { name:'pntTxnType2Cd',   index:'lpt.PNT_TXN_TYPE_2_CD',  resizable : true, align:'center',     width:'100px' ,sortable: false},		/*거래상세유형 */
// 		      { name:'txnAmt',   index:'lpt.TXN_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable: false },		/*거래금액 */
// 		      { name:'pntAmt',   index:'lpt.PNT_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer' ,sortable: false},		/*발생포인트*/
// 		  	  { name:'rcptNo', 		index:'a.rcpt_no', 		resizable : true, align:'center', 	width:'90px'},										/*영수증 번호*/
// 		      { name:'txnStatNm', 	index:'c3.mark_name', 	resizable : true, align:'center', 	width:'60px'},										/*거래 상태*/
// 		      { name:'custNm',   index:'lm.MBR_HID_NM',  resizable : true, align:'center', /*formatter: goGridRowMbrLink,*/   width:'60px',sortable: false },
// 		      { name:'mbrNo',   index:'lm.MBR_NO',  resizable : true, align:'center',   formatter: goGridRowMbrLink,  width:'80px',sortable: false },/*회원번호*/
// 		      { name:'apprNo', 		index:'a.appr_no', 		resizable : true, align:'center', 	width:'90px'},										/*승인번호 */
// 		      { name:'apprDate', 		index:'a.appr_date', 	resizable : true, align:'center', 	width:'90px'},									/*승인일시 */
// 		      { name:'orgnApprNo', 	index:'lpt.orgn_appr_no', resizable : true, align:'center', 	width:'100px'},										/*원거래승인번호*/
// 		      { name:'orgnApprDate', 	index:'lpt.orgn_appr_date', resizable : true, align:'center', 	width:'100px'},								/*원거래승인일자*/
// 		      { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px',sortable: false },							/*스토어명*/

// 		      { name:'rid',    index:'lpt.rid',    hidden : true},
// 		      { name:'ridMbr',    index:'lm.rid',    hidden : true},
// 		      { name:'ridMbrCard',    index:'lmc.rid',    hidden : true},
// 		      { name:'memDivCd',    index:'memDivCd',    hidden : true},
// 		      { name:'cardTypeCdCode',    index:'lpt.CARD_TYPE_CD',    hidden : true}
// 		 ],
//         dataType:"clientSide",
//         data : {}
// 	}

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
	//상담원 일 경우는 제픔 링크 걸지 않음
	var authList = $.ifvmGetAuthInfo().authList;
	var isAuth = true;

	for(var i = 0 ; i < authList.length ;i++){
		if(authList[i].authName == 'E10004' ||authList[i].authName == 'E10005'){
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
    return cellvalue;
}


//공통 조회 조건 목록 설정
function transactionListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("transactionSearchList","PGM_L_050",gridId);
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
				betweenDay  =  (endObj.getTime() - startObj.getTime())//1000/60/60/24;
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

			if($("#rows"+index+ " .searchTextVal option:selected").attr('joinsrcclm')=="CARD_NUM"){
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

// 	if(!searchBlankCheck()){
// 		alert('<spring:message code="L01859" />');
// 		searchValidation=false;
// 	}

	if(!dateCondUniqueCheck()){
		alert('<spring:message code="L02016" />');
		searchValidation=false;
	}

// 	var filedName = 'APPR_DT'
// 	if(!dateValid(filedName)){
// 		alert('<spring:message code="L01861" />');
// 		searchValidation=false;
// 	}

// 	filedName = 'TXN_DT'
// 	if(!dateValid(filedName)){
// 		alert('<spring:message code="L01862" />');
// 		searchValidation=false;
// 	}
	if(searchValidation){

// 	    $.fn.ifvmSubmitSearchCondition("transactionSearchList", geTtransactionSearch);
	    $.fn.ifvmSubmitSearchCondition("transactionSearchList", function(){
	    	transactionList.searchGrid({item: requestitem});
	    });

	}else{
		 $("#transactionListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
// 		 $("#transactionListGrid").ifvsfGrid({ ejGridOption : ejGridOptionInit });
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


/*포인트 상세 팝업*/

 function pointDtlPop(){

		$("#pointDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="pointDtlPopList"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00477"/>',
	        width: '1000px',
	        close : 'pointDtlPopClose'
	    });
 }


//팝업 닫기
 function pointDtlPopClose() {
 	$('#pointDialog').ejDialog('destroy');
 }


/*
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
*/

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

	 var pntType = null;
	pntType = cardCheckObj.pntTxnType1Cd;
	var pointDtlPopBtnDisabled = false;

	//적일일경우만 포인트상세 버튼을 활성화 시킴. by moon.
	if(pntType != null &&  pntType != '적립'){
		pointDtlPopBtnDisabled = true;
	}


	if( pointDtlPopBtnDisabled == false ){
		$("#pointDtlPopBtn").attr('disabled',false);
	}else{
		$("#pointDtlPopBtn").attr('disabled',true);
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

	//$("#transactionListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
	geTtransactionSearch();
    //포인트 상세팝업 호출
    $("#pointDtlPopBtn").on("click",function(){
    	if(rid!=null){
    		pointDtlPop();
    	}else{
    		alert('<spring:message code="L01820" />');
    	}
    });

    $("#pointListSearchInitBtn").on("click",function(){
    	transactionListSearchInit('transactionListGrid');
    });
    //마스킹 해제
    $("#unMaskBtn").on("click",function(){
    	fnUnMak();
    })

    //공통 조회조건 추가 제어 기능
    commSearchEventFn();

});

</script>


<div class="page-title">
    <h1>
        <spring:message code="L01821" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pointListSearchBtn" btnFunc="transactionListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointListSearchInitBtn"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="transactionSearchList">
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<!--<ifvm:inputNew type="button"   text="L00326"  id="unMaskBtn" btnFunc="fnUnMak"	 disabled="true" objCode="LOY_MAS_014"/>-->
        	<ifvm:inputNew type="button" btnType="search"  text="L00588"  id="pointDtlPopBtn" disabled="true" />
        </div>
    </div>
    <div id="transactionListGrid" class="white_bg grid_bd0"></div>

</div>


 <div id="pointDialog" class="popup_container"></div>