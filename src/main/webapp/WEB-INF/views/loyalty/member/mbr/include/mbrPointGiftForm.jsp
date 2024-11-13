<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal top_well" id="mbrPointGiftForm">
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="mbrNo"  disabled="true" label="양도회원" title="양도회원번호" labelClass="2" conClass="3" />
		<ifvm:inputNew type="text" id="custNm" disabled="true" conClass="3" title="양도회원" />
		<ifvm:inputNew type="search" id="chnlNm" label="채널" labelClass="1" required="true" title="채널" conClass="3" btnFunc="searchChnl" />
		<ifvm:inputNew type="hidden" id="chnlNo"  conClass="2" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="tgtMbrNo"  label="양도대상회원"  labelClass="2" title="양도대상회원번호" conClass="3" disabled="true" required="true" />
		<ifvm:inputNew type="search" id="tgtCustNm" btnFunc="searchMbr"  title="양도대상회원" conClass="3" disabled="true" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="avlPoint"  label="양도가능포인트" labelClass="2" title="양도가능포인트" conClass="4" disabled="true" />
		<label class="control-label col-xs-2">
		<span class="asterisk">*</span>
			양도할포인트
		</label>
		<div class="control_content col-xs-4">
			<input type="text" id="giftPoint" onchange="checkAvlPoint(this)" />
		</div>
		<%-- <ifvm:inputNew type="text" id="giftPoint" label="양도할포인트" labelClass="2" title="양도할포인트" conClass="4"  /> --%>
	</div>
	<%-- <div class="row qt_border">
		<ifvm:inputNew type="select" id="feeLevyCd" names="feeLevyCd"  label="양도수수료" labelClass="2" title="양도수수료" conClass="4" />
		<div class="control_content col-xs-2" style="text-align: end;">
			<button class="btn btn-sm" id="countFeeBtn" objCode="" style="color: white;">
				<spring:message code="수수료계산" />
			</button>
			<input type="checkbox" id="countFeeCheckBox">
		</div>
		<ifvm:inputNew type="text" id="countFee"  title="수수료계산" conClass="3" disabled="true" /><span>USD</span>
	</div>
	<div class="row qt_border">
		<label class="control-label col-xs-2">수수료결제</label>
		<div class="control_content col-xs-4">
			<button class="btn btn-sm" id="payFeeBtn" objCode="" style="color: white;">
				<spring:message code="수수료결제" />
			</button>
			<input type="checkbox" id="payFeeCheckBox">
		</div>
		<ifvm:inputNew type="text" id="feeRcptNo" label="수수료영수증" labelClass="2" title="수수료영수증" conClass="4" className="text-center" disabled="true" />
	</div> --%>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="giftComment" label="사유" required="true" labelClass="2" title="사유" conClass="10" rows="4" />
	</div>
	<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_lightGray2" id="Gfitbtn" objCode="" style="color: white;">
		<spring:message code="양도하기" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="popCancelbtn" objCode="" style="color: white;">
		<spring:message code="M00441" />
	</button>
</div>

<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">
var giftForm;
var pointPlcy = null;

var mbrPointGiftForm = function(){
	var _inputField = $("#mbrPointGiftForm input");
	var _selectField =$("#mbrPointGiftForm select");
	var _textareaField = $("#mbrPointGiftForm textarea");
	var _validation;
	this.textField =[], // input 필드값
	this.selectField =[], // select 필드값
	this.textareaField =[], // textareaField 필드값
	this.pointPlcy = [],
	this.init = function(){
		this.action();
		this.loadForm();
		this.getField();
		this.setSelectField();
		this.getUsePurMax();
		_validation = $('#mbrPointGiftForm').ifvValidation();
	},
	this.loadForm = function(){
		this.hideArea();
		$("#mbrPointGiftForm #mbrNo").val(mbrNo);
		$("#mbrPointGiftForm #custNm").val($("#cust_nm").val());
		$("#mbrPointGiftForm #avlPoint").val($("#avlPoint").val().replace(/.$/, ''));
		$("#giftPoint").ifvNumberOnly();
	},
	this.hideArea = function(){
		var hideArr = ['countFeeCheckBox','payFeeCheckBox']
		for(var i=0;i<hideArr.length; i++){
			$("#"+hideArr[i]).hide();	
		}
	},
	this.countFee = function(){
		var feeLevyCd = $("#feeLevyCd").val();
		var cf = parseInt($("#giftPoint").val().replace(/,/g,""));
		
		if(cf > this.pointPlcy.useDayMax){
			alert("1일 최대 사용 포인트는" +this.pointPlcy.useDayMax+"입니다.");
		}else{
			if(cf > this.pointPlcy.usePerMax){
				alert("1회 최대 사용 포인트는" +this.pointPlcy.usePerMax+"입니다.");
			}else{
				if(this.pointPlcy.usePoint > this.pointPlcy.useDayMax){
					alert("1일 최대 사용치를 넘었습니다.")
				}else{
					if(feeLevyCd == "01"){
						//$("#countFee").val($.fn.ifvmNumberWithCommas(cf * this.pointPlcy.giftFeeCntAmt));
						$("#countFee").val( this.pointPlcy.giftFeeCntAmt);
					}else if(feeLevyCd == "02"){
						//$("#countFee").val($.fn.ifvmNumberWithCommas(cf * this.pointPlcy.giftFeeMileageAmt));
						$("#countFee").val(this.pointPlcy.giftFeeMileageAmt);
					}
					$('#countFee').css("text-align", "right");
					$("#countFeeCheckBox").prop("checked",true)
				}
			}
		}
	},
	this.payFee = function(){ //랜덤 숫자 10자리 (임시)
		var receipt = Math.floor(Math.random() * 10000000000) +1;
		$("#feeRcptNo").val(receipt);
		$("#payFeeCheckBox").prop("checked",true)
	},
	this.giftPointToMbr = function(){
		this.getField();
		this.getUsePurMax(); //사용정책
		var url = '<ifvm:action name="setMbrPointGiftProc"/>';
		if(_validation.confirm()){
			$.ifvSyncPostJSON(url,this.getFieldVal(),function(result){ 
				this.afterSave(result);
			}.bind(this), function(result){
				this.afterSave(result);
			}.bind(this));
		}
	},
	this.getFieldVal = function(){
		if(_validation.confirm()){
			var _data = {}
			this.textField.forEach(function(a){
				_data[a] = $("#mbrPointGiftForm #"+a).val().replaceAll(",", "")
			});
			this.selectField.forEach(function(b){
				_data[b] = $("#mbrPointGiftForm #"+b).val()
			});
			this.textareaField.forEach(function(c){
				_data[c] = $("#mbrPointGiftForm #"+c).val()
			});
			
			_data['pntPwd'] = pntPwd;
			_data['rid'] = mbr_rid;
			return _data;
		}
	},
	this.getField = function(){ 
		for(var i=0;i<_inputField.length; i++){
			this.textField[i] = _inputField[i].id;
			if(_inputField[i].id != "countFeeCheckBox" && _inputField[i].id != "payFeeCheckBox") 
				$("#mbrPointGiftForm #"+ _inputField[i].id).attr("required",true);
		}
		for(var i=0;i<_selectField.length; i++){this.selectField[i] = _selectField[i].id;	}
		for(var i=0;i<_textareaField.length; i++){
			this.textareaField[i] = _textareaField[i].id;	
			$("#mbrPointGiftForm #"+ _textareaField[i].id).attr("required",true);
		}
	},
	this.setSelectField = function(values){
		var feeLevyCd = ( values && values.feeLevyCd ) ? values.feeLevyCd : null;
		$.fn.ifvmSetSelectOptionCommCode("feeLevyCd", "LOY_GIFT_FEE_LEVY_CD", feeLevyCd, null, true);	
	},
	this.afterSave = function(result){  //저장후
		if(result.success){
			if(result.message) alert(result.message);
			else alert('<spring:message code="양도되었습니다."/>');
			//this.close();
			mbrDetail();
			$.fn.ifvmPopupClose();
			mbrPointHistListGrid._doAjax();
		}else{
			if(result.message) alert(result.message);
			else alert('<spring:message code="양도 실패"/>');
		}
	},
	this.getUsePurMax = function(){
		$.ifvPostJSON('<ifvm:action name="getMbrUsePurMax"/>',{rid : mbr_rid, pgmRid : pgmRid},function(result){ 
			this.pointPlcy = result;
			pointPlcy = result;
		}.bind(this));
	},
	this.close = function(){
		$.fn.ifvmPopupClose();
	},
	this.action = function(){
		$("#Gfitbtn").click(function(){
			this.giftPointToMbr();
		}.bind(this));
		
		$("#popCancelbtn").click(function(){
			$.fn.ifvmPopupClose();
		}.bind(this));
		
		$("#countFeeBtn").click(function(){
			
			if($("#giftPoint").val() == "") alert("양도할 포인트를 넣으세요.")
			else if($("#giftPoint").val()  < 1) alert("양도할 포인트가 없습니다");
			else this.countFee();
		}.bind(this));
		
		$("#payFeeBtn").click(function(){
			if($("#countFeeCheckBox").is(":checked")){
				this.payFee();
			}else{
				alert("수수료 계산 먼저 진행하세요.");
			}
			
		}.bind(this));
		
		$("#feeLevyCd").change(function(){
			$("#countFee").val("")
			$("#countFeeCheckBox").prop("checked",false)
			$("#payFee").val("")
			$("#payFeeCheckBox").prop("checked",false)
			$("#feeRcptNo").val("")
		}.bind(this));
	}
}

function searchMbr(){
	$.fn.ifvmPopupOpen('popupContainer', pgmRid,
            '<ifvm:url name="searchTgtMbrPop"/>',
            '회원 조회', 800);
}

function searchChnl(){
	$.fn.ifvmPopupOpen('popupContainer', pgmRid,
            '<ifvm:url name="mbrPgmChnlListPop"/>',
            '채널 조회', 800);
}

function checkAvlPoint(obj){
	var point = parseInt(obj.value.replace(/,/g,""));
	
	if(point > parseInt($("#mbrPointGiftForm #avlPoint").val().replace(/,/g,""))){
		alert("양도가능 포인트 한도를 넘었습니다.");
		$("#giftPoint").val($("#mbrPointGiftForm #avlPoint").val());
	}else if(point < pointPlcy.useHudl){
		alert("최소 사용 포인트는 "+pointPlcy.useHudl+" 입니다.");
		$("#giftPoint").val(0);
	}else if(!Number.isInteger(point/pointPlcy.useUnit)){
		$("#giftPoint").val($.fn.ifvmNumberWithCommas(Math.floor(point/pointPlcy.useUnit) * pointPlcy.useUnit));
	}
}




$(document).ready(function(){
	
	giftForm = new mbrPointGiftForm();
	giftForm.init();
	
});

</script>