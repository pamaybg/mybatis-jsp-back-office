<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>	
</script>
<script type="text/x-jsrender" id="chnlLinkTemplate">
		<a href="<ifvm:url name="chnlDetail"/>?rid={{:ridChnl}}" style="color:#1266FF; text-decoration:underline;" >{{:chnlNm}}</a>
</script>
<script type="text/x-jsrender" id="pgmLinkTemplate">
		<a href="<ifvm:url name="chnlDetail"/>?rid={{:ridPgm}}" style="color:#1266FF; text-decoration:underline;" >{{:prodNm}}</a>
</script>

<script type="text/javascript">

var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var prodTempObj={};
var authorizationObj={};
var tetTchDtVal="";
function simpleMemRegDetailSetting(){
	if(testViewList_rid!=null){
		$.ifvSyncPostJSON('<ifvm:action name="getSimpleMemRegDetail"/>', {
			rid : testViewList_rid
		}, function(result) {

			if(result.telTchYn=="Y"){
				$("#telTchYn").attr("checked",true);
			}
			if(result.trmlSmplRegFlg =="Y"){
				$("#trmlSmplRegFlg").attr("checked",true);
			}
			if(result.activeFlg =="Y"){
				$("#activeYn").attr("checked",true);
			}
			if(result.mktAgrePrvInfo =="Y"){
				$("#mktAgrePrvInfo").attr("checked",true);
			}
			if(result.mktAgreThirdSnd =="Y"){
				$("#mktAgreThirdSnd").attr("checked",true);
			}
			$("#simpleMemRegDtlForm").dataSetting(result);
			var decodeUserPhone = result.userPhone;
			$("#userPhoneDecode").attr("disabled",true);
			if ($.fn.ifvmIsNotEmpty(testViewList_rid)) {

				fnMask();


			}
		});
		dateFormatSetting();
		tetTchDtVal = $("#telTchDt").val();
	}
	/* if($("#telTchDiv").val()=="10" || $("#telTchDiv").val()=="20"){
		$($('#cardRecvUserInfoForm').find('input')).each(function(index, item){
 			$(item).attr("disabled",true);
		});

		$($('#cardRecvUserInfoForm').find('select')).each(function(index, item){
			$(item).attr("disabled",true);
		});

		$($('#cardRecvUserInfoForm').find('textarea')).each(function(index, item){
			$(item).attr("disabled",true);
		});
	} */
}

function commCodeSetting() {
	$.ifvGetCommCodeList('select', 'telTchDiv', '<ifvm:action name="getCommCodeList2"/>', 'CARD_CALL_CD', 'loy', true, true);
}
//1000단위 정규식
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function numberFormatterSetting() {
	var numFormatVal = $("#fileUpldSucesCnt").val();
	$("#fileUpldSucesCnt").ifvNumberOnly();
	$("#fileUpldSucesCnt").val(numberWithCommas(numFormatVal));
	numFormatVal = $("#fileUpldFailCnt").val();
	$("#fileUpldFailCnt").ifvNumberOnly();
	$("#fileUpldFailCnt").val(numberWithCommas(numFormatVal));

	numFormatVal = $("#pointSucesCnt").val();
	$("#pointSucesCnt").ifvNumberOnly();
	$("#pointSucesCnt").val(numberWithCommas(numFormatVal));

	numFormatVal = $("#pointFailCnt").val();
	$("#pointFailCnt").ifvNumberOnly();
	$("#pointFailCnt").val(numberWithCommas(numFormatVal));
}

function dateFormatSetting(){
	var dateFormatVal=$("#trmlSmplRegDt").val().split(".")[0];
	$("#trmlSmplRegDt").val(dateFormatVal);

	dateFormatVal = $("#telTchDt").val().split(".")[0]
	$("#telTchDt").val(dateFormatVal);
}
function simpleMemRegListFn() {
	var url = '<ifvm:url name="simpleMemRegList"/>';
	qtjs.href(url);
}

function authorizationFn(){
	authorizationPop ={
	        id : "authorizationPopDiv"
	    };
	authorizationPop.popup = function (){

	authorizationPop.pop = $('#'+authorizationPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="authorizationPop"/>',
	            contentType: "ajax",
	           // title: '<spring:message code="L01755" />',
	            width: "300px"
	        });
	};
	authorizationPop.beforeClose = function (obj) {
	};
	authorizationPop.close = function (obj) {
		 	if(obj!=null || typeof obj!="undefined"){
		 		if(obj.authoDiv == "MOBILE"){
		 			$("#mbrName").val(obj.mobileNm);
		 			$("#mbrPhone").val(obj.mobileNum);
		 		}else if(obj.authoDiv == "MYPIN"){
		 			$("#mbrName").val(obj.mypinNm);
		 			$("#mypinNo").val(obj.mypinNum);
		 		}
		 	}
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 authorizationPop.popup();
}

function simpleMemRegInfoSaveFn(){
	var obj={};
	obj = $("#simpleMemRegDtlForm").getSubmitData();
	if($("#telTchYn").prop("checked")){
		$("#telTchYn").val("Y");
		obj.telTchYn = $("#telTchYn").val();
	}
	obj.rid = testViewList_rid;
	$.ifvSyncPostJSON('<ifvm:action name="updateSimpleMemRegInfo"/>',obj,
	function(result) {
		alert('<spring:message code="L00127" />');
		var url = '<ifvm:url name="simpleMemRegDetail"/>';
		simpleMemRegDetailSetting();
		//numberFormatterSetting();
	});
}
certiOwn = {
		id : "certiPopup",
		pop : function(){
			var url = '<ifvm:url name="certiOwnPop"/>';
   			url += '?certiCase=003&&cardNo='+$("#cardNumDecode").val()
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : url,
	            contentType : "ajax",
	            title : '<spring:message code="L00741"/>', // 회원 찾기
	            width : '500px'
	        });
		},
		beforeClose : function(obj){
			console.log(obj);
		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}
}

function fnCertiCard(){
	//회원가입여부 체크후 가입이 되어있으면 경고창 안되어있으면 팝업창 띄어줘야함
	$.ifvSyncPostJSON('<ifvm:action name="checkMemRegIsYN"/>', {
		cardNum :$("#cardNumEnc").val()
	}, function(result) {
		if(result>0){
			alert('<spring:message code="L01875"/>');//회원가입이 이미 되어있습니다.
			return;
		}else{
			certiOwn.pop();
		}
	},function(result){
	});
}
	//팝업 닫기
function certiOwnPopClose() {
	certiPopup._destroy();
}

var transactionList;
var gridTransactionList;
var cardCheckObj={};
var promoRid;
function geTtransactionSearch(){
    var ejGridOption = {
   		recordDoubleClick : function(args){
      var obj = args.data;
      rid = obj.rid;
      transactionDetailDtl();   // 상세 보기 이벤트
        },

       rowSelected : function (args) {
        	cardCheckObj=arsg.data;
        	buttonStatus();
        	promoRid = args.data.rid;
        },

       serializeGridData : function( data ){
       		var spliArr =[];
    	   data.batchCardNum = $("#cardNum").val();
       		splitArr = data.batchCardNum.split("-");
       		if(splitArr.length>1){
       			var splitCardNum="";
       			for(var i=0; i<splitArr.length;i++){
           				splitCardNum+=splitArr[i];
       			}
       			data.batchCardNum = splitCardNum;
       		}
       		data.batchTransIsYn = "Y";
            return data;
        },
        loadComplete : function(obj){
        	cardCheckObj={};
        	buttonStatus();
        },
        dataUrl : '<ifvm:action name="simpleMemTransList"/>',
        columns:[
        	{
	      		  field : 'txnUniqNo', headerText : '<spring:message code="L00554"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpt.TXN_UNIQ_NO' }/*카드번호 */
	      	  },{
	      		  field : 'apprDate', headerText : '<spring:message code="L00555"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpt.APPR_DATE' }/*승인일시 */
	      	  },{
	      		  field : 'pntTxnType2Cd', headerText : '<spring:message code="L00556"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpt.PNT_TXN_TYPE_2_CD' }/*거래상세유형 */
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center', template : "#mbrLinkTemplate",
	      		  customAttributes : {
	      			  index : 'lm.MBR_NO' }/*회원번호 */
	      	  },{
	      		  field : 'custNm', headerText : '<spring:message code="M00850"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lm.MBR_HID_NM' }/*회원명 */
	      	  },{
	      		  field : 'memDiv', headerText : '<spring:message code="L00557"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpt.MEM_DIV' }/*회원구분 */
	      	  },{
	      		  field : 'cardNoDecoding', headerText : '<spring:message code="L00414"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpt.CARD_NUM' }/*카드번호 */
	      	  },{
	      		  field : 'cardTypeCd', headerText : '<spring:message code="L00192"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpt.CARD_TYPE_CD' }/*카드종류 */
	      	  },{
	      		  field : 'pntAmt', headerText : '<spring:message code="L00582"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpt.PNT_AMT' }/*카드종류 */
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="L01018"/>', headerTextAlign : 'center', template : "#chnlLinkTemplate",
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NM' }/*충전소명 */
	      	  },{
	      		  field : 'prodNm', headerText : '<spring:message code="L00567"/>', headerTextAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'lp.PROD_NM' }/*제품명 */
	      	  },{
	      		  field : 'txnAmt', headerText : '<spring:message code="L00567"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpt.TXN_AMT' }/*거래금액 */
	      	  },{
	      		  field : 'rid', headerText : '', headerTextAlign : 'center',visible: false,
	      		  customAttributes : {
	      			  index : 'lpt.rid' }/* */
	      	  },{
	      		  field : 'ridMbr', headerText : '', headerTextAlign : 'center',visible: false,
	      		  customAttributes : {
	      			  index : 'lm.rid' }/* */
	      	  },{
	      		  field : 'ridChnl', headerText : '', headerTextAlign : 'center',visible: false,
	      		  customAttributes : {
	      			  index : 'lc.rid' }/* */
	      	  },{
	      		  field : 'ridMbrCard', headerText : '', headerTextAlign : 'center',visible: false,
	      		  customAttributes : {
	      			  index : 'lmc.rid' }/* */
	      	  },{
	      		  field : 'cprtCardCd', headerText : '', headerTextAlign : 'center',visible: false,
	      		  customAttributes : {
	      			  index : 'lmc.cprtCardCd' }/* */
	      	  },{
	      		  field : 'cardTypeCdCode', headerText : '', headerTextAlign : 'center',visible: false,
	      		  customAttributes : {
	      			  index : 'lpt.CARD_TYPE_CD' }/* */
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'apprDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
        
    };
    transactionList = $("#transactionListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridTransactionList = $("#gridTransactionList");
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
// function goGridRowMbrLink(cellvalue, options, rowObjec){
//     var id = rowObjec.ridMbr;
//     var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
//     var tag=null;

//     if(cellvalue!=null){
//         tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >'+ cellvalue + '</a>';
//     }else{
//     	tag="";
//     }
//     return tag;
// }
// function goGridRowChnlLink(cellvalue, options, rowObjec){
//     var id = rowObjec.ridChnl;
//     var url = '<ifvm:url name="channelDetail"/>?rid=' + id;
//     var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
//     return tag;
// }
// function goGridRowPgmLink(cellvalue, options, rowObjec){
//     var id = rowObjec.ridPgm;
//     var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
//     var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
//     return tag;
// }

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


function buttonStatus(){
	var promoCnt=null
	promoCnt = cardCheckObj.promoCnt;
	if(promoCnt ==0 || promoCnt ==null){
		$("#pointDtlPopBtn").attr('disabled',true);
	}else{
		$("#pointDtlPopBtn").attr('disabled',false);
	}
	(cardCheckObj.cardNoDecoding!=null && cardCheckObj.cardNoDecoding!="")  &&(cardCheckObj.cardTypeCdCode=='20'&& (cardCheckObj.cprtCardCd!='' || cardCheckObj.cprtCardCd!=null))
		? $('#unMaskBtn').attr('disabled',false) : $('#unMaskBtn').attr('disabled',true);
}


function checkboxEventSetting(){
	$('#telTchYn').click(function() {
        if ($(this).is(':checked')) {
        	$("#telTchDt").val(todayDateSetting());
        }else{
			$("#telTchDt").val(tetTchDtVal);
        }
    });
}

function todayDateSetting(){
	var Now = new Date();
	var NowTime = Now.getFullYear();
	var month = Now.getMonth() + 1
	var day  = Now.getDate();
	var hours = Now.getHours();
	var minutes = Now.getMinutes();
	var seconds = Now.getSeconds();
	if(month<10) {
		month='0'+month
	}
	if(day<10) {
		day='0'+day
	}
	if(hours<10) {
		hours='0'+hours
	}
	if(minutes<10) {
		minutes='0'+minutes
	}
	if(seconds<10) {
		seconds='0'+seconds
	}

	NowTime += '-' + month ;
	NowTime += '-' + day
	NowTime += ' ' + hours
	NowTime += ':' + minutes;
	NowTime += ':' + seconds;
	return NowTime;
}

function unMaskFn(){
	if ($.fn.ifvmIsNotEmpty(cardCheckObj.rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
            rid: testViewList_rid ,
            type: 'txn' ,
            field: 'cardNo'
        },
        function(result) {
        	var rowid = transactionList.getRadioSelectedRowId();

        });
	}
}

function fnMask(){
    $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	        rid: testViewList_rid ,
	        type: 'lmsr' ,
	        field: 'phone'
	    },
    function(result) {
    	if(result.message!=null){
    		$("#userPhoneDecode").val(result.message);
    	}
    });

    $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	        rid: testViewList_rid ,
	        type: 'lmsr' ,
	        field: 'email'
	    },
	function(result) {
		if(result.message!=null){
			$("#recvEmail").val(result.message);
		}
	});

    $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
        rid: testViewList_rid ,
        type: 'lmsr' ,
        field: 'mypin'
    },
    function(result) {
    	$("#userMypinDescrypt").val(result.message);
    });
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

function pointDtlPopFn(){
	pointDetailPop ={
	        id : "pointDetailPopDiv"
	    };
	 pointDetailPop.popup = function (){
 	pointDetailPop.pop = $('#'+pointDetailPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="pointDetailPop"/>' +"?promoRid="+promoRid,
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

$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
	commCodeSetting();
	$.ifvmLnbSetting('simpleMemRegList');
	simpleMemRegDetailSetting();
//	numberFormatterSetting();
	geTtransactionSearch();
	checkboxEventSetting();
	if(window.parent.document.getElementById('TSPhone')){
		$("#callHpNo").prop('disabled',false);
	}
})
</script>

<div class="page-title">
	<h1>
		<spring:message code="L01760"/>&gt;  <spring:message code="L00079"/>
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-4">
		<span> <spring:message code="L01756" /></span>
	</div>

	<div class="col-xs-8 searchbtn_r">
		<ifvm:inputNew type="button" id="vocDetailPopBtn" text="L00819"/><!-- 상담생성 -->
		<ifvm:inputNew type="button" btnType="save" text="L00125" id="simpleMemRegInfoSaveBtn" btnFunc="simpleMemRegInfoSaveFn" />
		<ifvm:inputNew type="button" text="L01762" id="certiBtn" btnFunc="fnCertiCard" />
		<ifvm:inputNew type="button" text="L01698" id="litBtn" btnFunc="simpleMemRegListFn" />
	</div>
	<script>
		$("#vocDetailPopBtn").click(function(){
			var url = '<ifvm:url name="vocDetailPop"/>';
			//url += '?ridMbr='+gMbrDetail.data.rid
			window.open(url, 'vocDetailPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=1200,height=740')
		})
	</script>
</div>

<div class="form-horizontal underline top_well" id="simpleMemRegDtlForm">
	<div class="half_wrap top_well">
		<div class="half_content half_left" id="approvalServerForm">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01757" /></span>
			</div>
		</div>

		<div class="row">
	    	<ifvm:inputNew type="text" id="cardNum"   dto="cardNum"   label="L01728" labelClass="2" conClass="4"  disabled="true" />
	    	<ifvm:inputNew type="hidden" id="cardNumDecode"   dto="cardNumDecode"  />
	    	<ifvm:inputNew type="hidden" id="cardNumEnc"   dto="cardNumEnc"  />
		    <ifvm:inputNew type="singleCheckbox" id="cntcDeskArdySbscYn" label="L01732" values="1" labelClass="2" conClass="4" checked="false" disabled="true"/>
	 	</div>
	 	<div class="row">
	 		<ifvm:inputNew type="singleCheckbox" id="activeYn" label="L02017" values="1" labelClass="8" conClass="3" checked="false" disabled="true"/>
	 	</div>

	 	<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01758" /></span>
			</div>
		</div>
	 	<div class="row">
			<ifvm:inputNew type="text" id="userName"   dto="userName"   label="L01740" labelClass="2" conClass="4"  disabled="true" />
			<%-- <ifvm:inputNew type="search" icon="phone" id="userPhoneDecode"   dto="userPhoneDecode"   label="L01741" labelClass="2" conClass="4"  disabled="true" /> --%>
			<ifvm:inputNew type="text" id="userPhoneDecode"   dto="userPhoneDecode" icon="phone"	disabled="true"
				label="L01741" labelClass="2" conClass="3" /><!-- 핸드폰번호 -->
			<div class="col-xs-1 middle">
				<ifvm:inputNew type="button" id="callHpNo" nuc="" btnType="phone" btnFunc="makeCallForHhpNo" className="btn-imgonly"	disabled="true"/>
			</div>
			<script>
			function makeCallForHhpNo(){
				var phoneNo = $("#userPhoneDecode").val();

				parent.localSoftMakeCall(phoneNo,null);
			}
			</script>
			<ifvm:inputNew type="hidden" id="userPhone"   dto="userPhone"   label="L01741" labelClass="2" conClass="4"  disabled="true" />
		</div>

		<div class="row">
			  <ifvm:inputNew type="text" id="recvEmail"   dto="recvEmail"   label="L01742" labelClass="2" conClass="4"  disabled="true" />
			  <ifvm:inputNew type="hidden" id="userMypinEncrypt"   dto="userMypinEncrypt"   />
			  <ifvm:inputNew type="text" id="userMypinDescrypt"   dto="userMypinDescrypt"   label="L02109" labelClass="2" conClass="4"  disabled="true" />

		</div>

		<div class="row">
			<ifvm:inputNew type="singleCheckbox" id="trmlSmplRegFlg" label="L01744" values="1" labelClass="2" conClass="4" checked="false" disabled="true"/>
	  		<ifvm:inputNew type="text" id="trmlSmplRegDt"   dto="trmlSmplRegDt"   label="L01743" labelClass="2" conClass="4"  disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="singleCheckbox" id="mktAgrePrvInfo" label="L02107" values="1" labelClass="2" conClass="4" checked="false" disabled="true"/>
			<ifvm:inputNew type="singleCheckbox" id="mktAgreThirdSnd" label="L02108" values="1" labelClass="2" conClass="4" checked="false" disabled="true"/>
		</div>
	</div>

	<div id="cardRecvUserInfoForm">
		<div class="half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="L01759" /></span>
				</div>
			</div>

			<div class="row">
				<ifvm:inputNew type="singleCheckbox" id="telTchYn" label="L01750" values="1" labelClass="2" conClass="4" checked="false"/>
			    <ifvm:inputNew type="text" id="smsTrmReslt"  dto="smsTrmReslt"   label="L01751" labelClass="2" conClass="4" disabled="true" />
		 	</div>
		 	<div class="row">
		    	<ifvm:inputNew type="select" id="telTchDiv"   dto="telTchDiv"   label="L01752" labelClass="2" conClass="4"   />
			    <ifvm:inputNew type="text" id="telTchDt"  dto="telTchDt"   label="L01753" labelClass="2" conClass="4" disabled="true" />
		 	</div>

		 	<div class="row">
		 	  <ifvm:inputNew type="textarea" id="telTchSbst"  dto="telTchSbst"   label="L01754" labelClass="2" conClass="10"   />
		 	</div>
		</div>
	</div>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-4">
		<span> <spring:message code="L00637" /></span>
	</div>
	<div class="col-xs-8 searchbtn_r">
		<ifvm:inputNew type="button"  text="L00326" id="unMaskBtn" btnFunc="unMaskFn"  disabled="true" objCode="LOY_MAS_011"/>
		<ifvm:inputNew type="button"   text="L00588" id="pointDtlPopBtn" btnFunc="pointDtlPopFn"  disabled="true"/>
	</div>
</div>
  <div id="transactionListGrid" class="white_bg grid_bd0"></div>
<script>

</script>
<div id="authorizationPopDiv" class="popup_container"></div>
<div id="certiPopup" class="popup_container"></div>
<div id="pointDetailPopDiv" class="popup_container content_container"></div>