<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#mmZzitemCd{
	cursor: not-allowed;
    background-color: #eee !important;
    opacity: 1;
    }
#goodsName{
	cursor: not-allowed;
    background-color: #eee !important;
    opacity: 1;
    }
</style>
<script type="text/javascript">
var mbrVocList;
var rid ;
var mbrvoc_rid = null;
var rowData = null;

function prodDetialInfoFun(data){
    $.ifvSyncPostJSON('<ifvm:action name="getMbrVocListDesc"/>', {
    	srNo: data
    },
    function(result) {
    	//         $('#buyChnl').val(result.srcProdId);
        $('#prodId').val(result.prodId);
        $('#mmZzitemCd').val(result.mmZzitemCd);
        $('#goodsName').val(result.goodsName);
        $('#prodNm').val(result.prodNm);
        $('#conslSbst').val(result.conslSbst);
        $('#reContent').val(result.reContent);
    });
}

//E1 오렌지 카드
function getmbrVocListSearch(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
            var data = args.data.rid;
	      
	      prodDetialInfoFun(data);
	      
        },
        rowSelected : function (args) {
            var data = args.data.srNo;
            $('#prodId').val('');
            $('#mmZzitemCd').val('');
            $('#prodNm').val('');
            $('#conslSbst').val('');
            $('#reContent').val('');
            prodDetialInfoFun(data);
            
            
            $("#mmZzitemCd").focus();

//         	mbrvoc_rid = args.data.rid;
//         	fnButtonStatus();
//         	rowData = null;
// 	    	rowData = data;

        	//마스킹해제 버튼 disabled 처리
// 	    	$("#unmaskBtn").attr("disabled",null);
// 	    	$("#tabCallConNo, #msgConNo, #tabCallHpNo, #msgHpNo, #sendEmail").attr("disabled",true);
        },
       serializeGridData : function( data ){
            //data.ridCust = gMbrDetail.data.ridCust;
            data.rid = mbr_rid;
            data.intRidMbr = mbr_rid;
            data.mbrStatCd = $("#mbrStatCd").val();
            return data;
        },
        loadComplete : function(data){
//          	$('#mbrVocRequestBtn').attr('disabled',true);
//         	$("#tabCallConNo, #msgConNo, #tabCallHpNo, #msgHpNo, #sendEmail").attr("disabled",true);

//         	var cvdata = data.getCurrentViewData();
        	
//         	if(cvdata.length == 1){
//         		data.selectRows(0,0);
// 				getConsultDetail(cvdata[0]);

				//마스킹해제 버튼 disabled 처리
// 		    	$("#unmaskBtn, #tabCallConNo, #msgConNo, #tabCallHpNo, #msgHpNo, #sendEmail").attr("disabled",null);
// 			} 
        },
        dataUrl : '<ifvm:action name="getMbrVocList"/>',
        columns:[
        	  {
         		  field : 'srNo', headerText : '상담번호',width:'6%', headerTextAlign : 'center',customAttributes : {searchable : true}
         	  }
         	  ,{
           		  field : 'cnslgTypeCdlNm', headerText : '상담유형(대)',width:'8%',textAlign : 'center', headerTextAlign : 'center',customAttributes : {index : 'cnslgTypeCdl',searchable : true}
           	  }
         	  ,{
           		  field : 'cnslgTypeCdmNm', headerText : '상담유형(중)',width:'8%',textAlign : 'center', headerTextAlign : 'center',customAttributes : {index : 'cnslgTypeCdm',searchable : true}
           	  }
         	  ,{
           		  field : 'prodId', headerText : '상품코드',width:'10%',textAlign : 'center', headerTextAlign : 'center',customAttributes : {searchable : true}
           	  },/*{
                  field : 'goodsName', headerText : '상품명',width:'200px',textAlign : 'left', headerTextAlign : 'center',customAttributes : {searchable : true}
              },*/{
                 field : 'cnslgTitle', headerText : '제목',width:'22%',textAlign : 'left', headerTextAlign : 'center',customAttributes : {searchable : true}
             }
         	  ,{
           		  field : 'srTrtStatusNm', headerText : '상태',textAlign : 'center', width:'6%',headerTextAlign : 'center',customAttributes : {index : 'srTrtStatus'}
           	  }
         	  ,{
           		  field : 'rcpDt', headerText : '접수일자',width:'10%' ,textAlign : 'center', headerTextAlign : 'center',
           	  }
         	  ,{
           		  field : 'endDt', headerText : '완료일자',width:'10%',textAlign : 'center', headerTextAlign : 'center',
           	  }
         	  ,{
           		  field : 'writer', headerText : '답변자',width:'6%',textAlign : 'center', headerTextAlign : 'center',customAttributes : {searchable : true}
           	  }
         	  ,{
           		  field : 'rid', headerText : 'rid' ,visible : false,
           	  }
                
            ],
            requestGridData : {
            	  nd   : new Date().getTime(),
            	  rows : 10,
            	  sidx : '1',
            	  sord : 'desc',
            	  _search : false
              },
              rowList : [10,25,50,100],
              radio: true,
              isHorizontalScroll: false
    };

    mbrVocList = $("#mbrVocListGrid").ifvsfGrid({ ejGridOption  : ejGridOption });
}
// function summaryComment(cellvalue, options, rowObject){
// 	if(cellvalue){
// 		var rtnVal = ""
// 		if(cellvalue.length >10){
// 			rtnVal = cellvalue.substring(0,10);
// 			rtnVal += "..."
// 		}else{
// 			rtnVal = cellvalue;
// 		}
// 		return rtnVal;
// 	}
// 	else{
// 		return "";
// 	}
// }
/* var vocDetailPop = {
	id : "mbrVocDetailDialog",
	pop : function(){
		$("#"+this.id).ifvsfPopup({
            enableModal : true,
            enableResize : false,
            contentUrl : '<ifvm:url name="mbrVocRequest"/>',
            contentType : "ajax",
            title : '<spring:message code="L00819"/>', // 상담생성
            width: '1200px',
        });
	},
	beforeClose : function(obj){

	},
	close: function(obj){
		if(obj){
			this.beforeClose(obj)
		}
		var _popObj = eval(this.id)
		_popObj._destroy();
	}
} */

// function vocDetailPop(_rid){
// 	var checkedList = mbrVocList.opt.gridControl.getSelectedRecords ()
// 	if(checkedList.length != 1){
// 		alert('<spring:message code="L01393" />');
// 		return;
// 	}
// 	var url = '<ifvm:url name="consultDetail"/>';
// 	if(_rid){
// 		url += '?rid='+_rid;
// 	}else{
// 		url += '?rid='+mbrVocList.opt.gridControl.getSelectedRecords ()[0].rid;
// 	}
// 	url += '&ridCust='+custRid;
// 	url += '&custNm=';
// 	qtjs.href(url);
// 	//window.open(url, 'vocDetailPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=1200,height=740')

// }


// function fnMbrVocRequestClose(){
// 	mbrVocDetailDialog._destroy();
// }

// function fnButtonStatus(){
// 	mbrvoc_rid!=null ? $('#mbrVocRequestBtn').attr('disabled',false) : $('#mbrVocRequestBtn').attr('disabled',true);
// }

//상담요청 상세
// function getConsultDetail(data){
// 	$.ifvSyncPostJSON('<ifvm:action name="getConsultDetail"/>',{
// 		rid : data.rid
// 	},function(result) {
// 		if(result != null){
// 			$("#detail_srNo").val(result.srNo);
// 			$("#detail_contactInfo").val(result.cntcDesk);
// 			$("#detail_memRid").val(result.ridMbr);
// 			$("#detail_ridCust").val(result.ridCust);
// 			$("#detail_memNo").val(result.memNo);
// 			$("#detail_phoneNo").val(result.memPtblNo);
// 			$("#detail_memName").val(result.memNm);
// 			$("#detail_email").val(result.emailAddr);
// 			$("#detail_consultTitle").val(result.cnslgTitle);
// 			$("#detail_consultContent").val(result.cnslgSbst);
// 			$("#detail_consultType1st").val(result.cnslgTypeCdL);
// 			$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", true);
// 			$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
// 			$("#detail_consultType2nd").val(result.cnslgTypeCdM);
// 			$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
// 			$("#detail_consultType3rd").val(result.cnslgTypeCdS);
// 			$("#detail_receptionMethod").val(result.rcpMeth);
// 			$("#detail_franchiseRid").val(result.ridChnl)
// 			$("#detail_franchiseCode").val(result.chnlNo);
// 			$("#detail_franchiseName").val(result.chnlNm);
// 			$("#detail_affiliatedCom").val(result.cprtVndrCd);
// 			if(result.cprtVndrHhoConvFail == "Y"){
// 				$("#detail_affiliatedComFail").prop("checked",true);
// 			}else{
// 				$("#detail_affiliatedComFail").prop("checked",false);
// 			}
// 			$("#detail_processSituation").val(result.srTrtStatusNm);
// 			$("#detail_receptionist").val(result.createBy);
// 			$("#detail_receptionDate").val(result.rcpDt);
// 			$("#detail_personInChargeName").val(result.crmuserName);
// 			$("#detail_transferDate").val(result.trcDt);
// 			$("#detail_endDate").val(result.endDt);
// 			$("#detail_callId").val(result.callId);
// 			//setDetailRowHighlight();
// 		}

// 	});
// }

// function init(){
// 	$.fn.ifvmSetSelectOptionCommCode("detail_consultType1st", "SR_AREA_L", null, null, false);
// 	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", false);
// 	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", false);

// 	$.ifvGetCommCodeList('select', 'detail_receptionMethod', '<ifvm:action name="getCommCodeList"/>', 'CALL_TYPE', 'voc', false, true, true);
// 	$.ifvGetCommCodeList('select', 'detail_affiliatedCom', '<ifvm:action name="getCommCodeList"/>', 'ALLIANCE_COMPANY_TYPE', 'voc', false, true, true);

// 	$("#unmaskBtn").attr("disabled",true);
// }

//SR정보 마스킹 해제
// function clickUnmaskBtn(){
// 	if($("#detail_contactInfo").val() != ""){
// 		//연락처 마스킹 해제
// 		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
// 	           rid: rowData.rid ,
// 	           type: 'voc' ,
// 	           field: 'cntcDesk'
// 	       },
// 	       function(result) {
// 	       	$("#detail_contactInfo").val(result.message);
// 	       	if(window.parent.document.getElementById("TSPhone")){
// 	       		$("#tabCallConNo").attr("disabled",null);
// 	       	}
// 	    	$("#msgConNo").attr("disabled",null);
// 	       });
// 	}

// 	if($("#detail_phoneNo").val() != ""){
// 		//휴대폰번호 마스킹 해제
// 		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
// 	           rid: rowData.rid ,
// 	           type: 'voc' ,
// 	           field: 'memPtblNo'
// 	       },
// 	       function(result) {
// 	       	$("#detail_phoneNo").val(result.message);
// 	       	if(window.parent.document.getElementById("TSPhone")){
// 		       	$("#tabCallHpNo").attr("disabled",null);
// 	       	}
// 	    	$("#msgHpNo").attr("disabled",null);
// 	       });
// 	}

// 	if($("#detail_email").val() != ""){
// 		//이메일 마스킹 해제
// 		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
// 	           rid: rowData.rid ,
// 	           type: 'voc' ,
// 	           field: 'emailAddr'
// 	       },
// 	       function(result) {
// 	       	$("#detail_email").val(result.message);
// 	       	$("#sendEmail").attr("disabled",null);
// 	       });
// 	}

// 	$("#unmaskBtn").attr("disabled",true);
// }

//소프트폰 전화걸기 함수
// function makeCallForContactInfoDetail(){
// 	var contactInfo = $("#detail_contactInfo").val();

// 	parent.localSoftMakeCall(contactInfo,null);
// }
// function makeCallForHhpNoDetail(){
// 	var phoneNo = $("#detail_phoneNo").val();

// 	parent.localSoftMakeCall(phoneNo,null);
// }

//문자메시지&이메일 전송 팝업
// function showTransChnlPopForConNo() {
// 	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#detail_contactInfo").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rowData.rid;

// 	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
// }
// function showTransChnlPopForHpNo() {
// 	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#detail_phoneNo").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rowData.rid;

// 	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
// }
// function showTransChnlPopForEmail() {
// 	var url = "/loyalty/common/winpop/transChnlPop?sendType=email&email=" + $("#detail_email").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rowData.rid;

// 	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
// }

$(document).ready(function() {
	getmbrVocListSearch();
// 	init();
// 	window.top.setParentIframeHeight();

});

</script>

<style>
	.heightForm{
		height:230px;
	}
	.middle {
	  	vertical-align: middle;
	  	text-align: left;
	}
</style>


<div class="page_btn_area">
	<div class="col-xs-5">
		<span><spring:message code="고객문의" /></span>
	</div>
</div>
<div class="row" style="color: red; ">
    * 고객문의 이력을 선택하면 상세내용으로 이동합니다.
</div>
<div id="mbrVocListGrid" class="white_bg grid_bd0"></div>
<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="D00009" /></span>
    </div>
</div>
<div class="form-horizontal top_well underline" id="prodDetialInfo"> <!-- 상담 상세내용 그리드 컨테이너 -->
    <div class="row">
          <div class="col-xs-12">
           <ifvm:inputNew type="text" id="mmZzitemCd" label="상품코드"  labelClass="1" conClass="3" readonly ="true"/>
           <ifvm:inputNew type="text" id="goodsName" label="상품명"  labelClass="1" conClass="3" disabled="true" readonly ="true"/>
          </div>
    </div>
    </br>
    <div class="row">
        <div class="col-xs-12">
           <ifvm:inputNew type="textarea" id="conslSbst" label="질문 내용"  labelClass="1" conClass="10"  disabled="true" rows="5" maxLength="5000"/>
        </div>
    </div>
        </br>
    <div class="row">
        <div class="col-xs-12">
           <ifvm:inputNew type="textarea" id="reContent" label="답변 내용"  labelClass="1" conClass="10"  disabled="true" rows="5" maxLength="5000"/>
        </div>
    </div>
</div>
<%-- <!-- SR정보 -->
<div class="top_well row">
	<div class="col-xs-6">
		<div class="page_btn_area">
			<div class="col-xs-3">
				<span><spring:message code="V00030"/></span>
			</div>
			<div class="col-xs-9 searchbtn_r">
				<ifvm:inputNew type="button" id="unmaskBtn"  text="L00326" btnType="" btnFunc="clickUnmaskBtn" objCode="COM_MSK_001"/>
			</div>
		</div>
		<div class="form-horizontal well heightForm underline">
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_srNo" label="V00016" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="detail_contactInfo" label="V00009" labelClass="2" conClass="3" disabled="true"/>
				<div class="col-xs-2 middle">
					<ifvm:inputNew type="button" id="tabCallConNo" nuc="" btnType="phone" btnFunc="makeCallForContactInfoDetail" className="btn-imgonly"/>
					<ifvm:inputNew type="button" id="msgConNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForConNo" className="btn-imgonly"/>
				</div>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="hidden" id="detail_ridCust" />
				<ifvm:inputNew type="hidden" id="detail_memRid" />
				<ifvm:inputNew type="search" id="detail_memNo" names="detail_memNo" objCode="SRCH" dto="detail_memNo" btnFunc="showMemNoPop" label="V00004" labelClass="2" conClass="3" />
				<ifvm:inputNew type="text" id="detail_memNo" label="V00004" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="detail_phoneNo" label="V00006" labelClass="2" conClass="3" disabled="true"/>
				<div class="col-xs-2 middle">
					<ifvm:inputNew type="button" id="tabCallHpNo" nuc="" btnType="phone" btnFunc="makeCallForHhpNoDetail" className="btn-imgonly"/>
					<ifvm:inputNew type="button" id="msgHpNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForHpNo" className="btn-imgonly"/>
				</div>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="search" id="detail_memName" names="detail_memName" objCode="SRCH" dto="detail_memName" btnFunc="showMemNamePop" label="V00005" labelClass="2" conClass="3" />
				<ifvm:inputNew type="text" id="detail_memName" label="V00005" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="detail_email" label="V00008" labelClass="2" conClass="3" disabled="true"/>
				<div class="col-xs-2 middle">
					<ifvm:inputNew type="button" id="sendEmail" nuc="" btnType="envelope-o" btnFunc="showTransChnlPopForEmail" className="btn-imgonly"/>
				</div>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_consultTitle" label="V00018" labelClass="2" conClass="8" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="textarea" id="detail_consultContent" label="V00019" labelClass="2" conClass="8" disabled="true" rows="5"/>
			</div>
		</div>
	</div>

	<!-- SR유형 -->
	<div class="col-xs-3 pl10">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="V00031"/></span>
			</div>
		</div>
		<div class="form-horizontal well heightForm underline">
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType1st" names="detail_consultType1st" label="V00010" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType2nd" names="detail_consultType2nd" label="V00011" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType3rd" names="detail_consultType3rd" label="V00012" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_receptionMethod" label="V00020" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="search" id="detail_franchiseCode" names="detail_franchiseCode" objCode="SRCH" dto="detail_franchiseCode" btnFunc="showFranchiseCodePop" label="V00021" labelClass="4" conClass="6" />
				<ifvm:inputNew type="text" id="detail_franchiseCode" label="V00021" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="search" id="detail_franchiseName" names="detail_franchiseName" objCode="SRCH" dto="detail_franchiseName" btnFunc="showFranchiseNamePop" label="V00022" labelClass="4" conClass="6" />
				<ifvm:inputNew type="text" id="detail_franchiseName" label="V00022" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_affiliatedCom" label="V00023" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
	            <ifvm:inputNew type="singleCheckbox" id="detail_affiliatedComFail" label="V00024" values="1" labelClass="4" conClass="6" checked="false" disabled="true"/>
			</div>
		</div>
	</div>
	<!-- 처리현황 -->
	<div class="col-xs-3 pl10">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="V00032"/></span>
			</div>
		</div>
		<div class="form-horizontal well heightForm underline">
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_processSituation" label="V00007" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_receptionist" label="V00025" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_receptionDate" label="V00017" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="hidden" id="detail_personInChargeRid" required="true"/>
				<ifvm:inputNew type="hidden" id="detail_personInChargeUserId" />
				<ifvm:inputNew type="search" id="detail_personInChargeName" names="detail_personInChargeName" objCode="SRCH" dto="detail_personInChargeName" btnFunc="" label="V00026" labelClass="3" conClass="6" required="true"/>
				<ifvm:inputNew type="text" id="detail_personInChargeName" label="V00026" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_transferDate" label="V00027" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_endDate" label="V00028" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_callId" label="V00029" labelClass="3" conClass="6" disabled="true"/>
			</div>
		</div>
<%-- 	</div> 
</div>--%>

<div id="mbrVocDetailDialog" class="popup_container"></div>

