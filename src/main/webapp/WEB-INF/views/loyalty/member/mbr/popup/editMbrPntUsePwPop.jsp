<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>

.warning_box {
	padding: 15px 15px;
	color: red
}

</style>
<script>
var promotionSearchHelpPopup = null;

/**
 * input Select 공통코드 option 생성(상위객체 연동)
 * name : select box 객체명
 * groupCode : 그룹코드
 * selectCode : 초기선택코드
 * parName : 상위 select box 객체명
 * noBlank : 최상위 빈값 설정여부
 */
$.fn.ifvmSetSelectOptionCommCodeSync2 = function(name, groupCode, selectCode, parName, noBlank) {
	var _name = name;
	var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
	var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;
	var _parName = $.fn.ifvmIsNotEmpty(parName) ? parName : null;
	var _commCodeList = [];

	//공통코드 목록 조회
	$.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCondLIst.do',{
        groupCode : groupCode
        , enableNA : true
    },function(result) {
    	if($.fn.ifvmIsNotEmpty(result.rows)) {
    		_commCodeList = result.rows;
    	}
    });

	//select 설정
	function setSelect() {
		if ($.fn.ifvmIsNotEmpty(_name)) {
			if ($.fn.ifvmIsNotEmpty(_parName)) {
				var _parValue = $("[name='" + _parName + "']").val();
				var _parCodeId = $("[name='" + _parName + "'] [value='"+_parValue+"']").attr("codeid");

				//초기화
				$("select[name='"+ _name +"']").empty();

		        if(!_noBlank) {
				    $("<option></option>")
				    .text("")
				    .attr("codeId", "")
				    .attr("value", "")
				    .appendTo("select[name='"+ _name +"']");
		        }

			    $.each(_commCodeList, function(index, code) {
			    	//par 코드 확인
			    	if (_parCodeId == code.parCodeId) {
			    		if(code.codeName === '160' /* || code.codeName === '260' */ || code.codeName === '261' || code.codeName === '262') {
						    var option =
						    	$("<option></option>")
						    	.text(code.markName)
						    	.attr("codeId", code.codeId)
						    	.attr("value", code.codeName)
						    	.attr("attrib01", code.attrib01)
						    ;
						    //selectCode 가 있을경우 기본 선택
						    if ( _selectCode == code.codeName) {
						    	option.attr("selected", "selected");
						    }
	
						    //noBlank 이며 selectcode가 없을때 첫번째 값 선택
						    if (index == 0 && _noBlank && _selectCode == "") {
						    	option.attr("selected", "selected");
						    }
	
						    option.appendTo("select[name='"+ _name +"']");
			    		}
			    	}
			    });
			}
		}
	}

	setSelect();

	//parName 객체 변경시
	$("[name='" + _parName + "']").on('change', function() {
		 setSelect();
    });
	
	//2018.11.30 hy.jun - parName 객체 option 목록 변경될 시
// 	$("[name='" + _parName + "']").bind('DOMSubtreeModified', function() {
// 		setSelect();
// 	});
};

var fn_mbrVocPop = {

    getDaisoPoint: function() {
    	$.ifvSyncPostJSON('<ifvm:action name="getPontBalanceB2c"/>', {
    	    rid : mbr_rid
    	}, function(result) {
    	    if (result.p_UsePnt == '') $('#vocPointPopInfo #usePnt').val("0");
    	    else $('#vocPointPopInfo #usePnt').val($.fn.ifvmDecimalWithCommas(result.p_UsePnt));
    	});
    },
    save: function() {

    	$.ifvProgressControl(true);
    	
    	//validation 체크
    	var isRcpt = false;
    	if($('#vocPointPopInfo').is(':visible')) {
    		var mbrVocValidation = $("#vocPointPopInfo").ifvValidation();
    		if (!mbrVocValidation.confirm()) {
    			$.ifvProgressControl(false);
    			return false;
    		}
    	}
    	if($('#rcptAftrRgstDetailForm').is(':visible')) {
    		isRcpt = true;
    		
    		var rcptAftrRgstValidation = $("#rcptAftrRgstDetailForm").ifvValidation();
    		if (!rcptAftrRgstValidation.confirm()) {
    			$.ifvProgressControl(false);
    			return false;
    		}
    	}
    	
        // validation 체크
//         var mbrVocValidation = $("#vocPointPopInfo").ifvValidation();
//     	if (mbrVocValidation.confirm()) {
            var tgtData = $("#vocPointPopInfo").getSubmitData();
        	tgtData.ridMbr = mbr_rid;
        	tgtData.mbrNo = $('#mbrNo').val();
        	tgtData.pntAmt = tgtData.pntAmt.replaceAll(",","");
        	if(isRcpt) {
        		tgtData.rcptData = $("#rcptAftrRgstDetailForm").getSubmitData(); //영수증 관련 데이터
        		tgtData.isRcpt = isRcpt; //영수증을 이용한 적립 여부
        	}

        	//포인트 거래유형이 [적립]이면서, 금액이 1,000포인트를 넘으면 메시지 창 표시
//         	if (tgtData.pntTxnType_1Cd == '100' && Number(tgtData.pntAmt) > 1000) {
//         		$.ifvProgressControl(false);
//     			alert('<spring:message code="L02317"/>');
//     			alert('입력한 적립 포인트가 1,000 초과입니다. 1,000 초과는 [포인트 수동일괄등록] 화면에서 등록하시면 됩니다.');
// 				return ;
//         	}

        	//저장
        	$.ifvSyncPostJSON('<ifvm:action name="addVocPntTxn"/>'
        	, tgtData
        	, function(result) {
        		if (result.success) {
        			alert('<spring:message code="L02031"/>');

        			getPointTxnListListSearch(pntTxnDateType);
        			vocPopup.close();
        			
        			$.ifvProgressControl(false);
        		}
        	}, function(result) {
        		if($.fn.ifvmIsNotEmpty(result.message)) {
	        		alert(result.message);
        		} else {
        			alert('에러가 발생하였습니다. 관리자에게 문의해주세요.');
        		}
        		
        		$.ifvProgressControl(false);
        	});
        	
//     	} else {
//     		$.ifvProgressControl(false);
//     	}
    },
    commCodeSetting: function() {
		/* $.ifvGetCommCodeList('select', 'pntTxnType_1Cd', '<ifvm:action name="getCommCodeList2"/>', 'PNT_TXN_TYPE', null, false, false, true);
		$.ifvGetCommCodeList('select', 'pntTxnType_2Cd', '<ifvm:action name="getCommCodeList2"/>', 'PNT_TXN_DTL_TYPE', null, false, false, true); */
		
		//포인트 거래유형
	    $.fn.ifvmSetSelectOptionCommCode("pntTxnType_1Cd", "PNT_TXN_TYPE", null, null, true);

	    //포인트 거래상세유형
	    $.fn.ifvmSetSelectOptionCommCodeSync2("pntTxnType_2Cd", "PNT_TXN_DTL_TYPE", null, 'pntTxnType_1Cd', true);
	    //거래상세유형 VOC만 출력 (160 or 260)
    	$('#pntTxnType_2Cd option').each(function(i, e) {
    		if(!($(e).val() === '160' || $(e).val() === '260')) {
    			$(e).remove();
    		}
    	});
    },
    close: function() {
        vocPopup.close();
    },
}

function fnSearchCampaign() {
	$("#promotionSearchHelpPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="promotionSearchHelpNew"/>?pntAccntMidTypeCd=160', /* 노출 프로모션 캠페인 제한 -> 지급계정 중분류 'CS' */
        contentType: "ajax",
        title: '프로모션 캠페인 목록 조회',
        width: 1200,
        close : 'promotionSearchHelpPopupClose'
    });
}

function promotionSearchHelpPopupClose() {
	promotionSearchHelpPopup._destroy();
}

/**
 * 프로모션 선택 시 변경 이벤트
 */
function chgEvntVal_PntAccntDetailTypeCd() {
    if($('#vocPointPopInfo #pntAccntDetailTypeCd').val() === '160020A01') { //구매 영수증 사후 적립
    	$('#rcptAftrRgstDetailForm').show();
    	
    	$('#vocPointPopInfo #vocDesc').val('영수증 사후적립은 CS 사유를 처리요청 시 자동으로 생성합니다.');
    	$('#vocPointPopInfo #vocDesc').attr('disabled', true);
    	$('#vocPointPopInfo #vocDesc').attr('required', false);
    } else {
    	$('#rcptAftrRgstDetailForm').hide();
    	
    	$('#vocPointPopInfo #vocDesc').val('');
    	$('#vocPointPopInfo #vocDesc').attr('disabled', false);
    	$('#vocPointPopInfo #vocDesc').attr('required', true);
    }
}

/**
 * 영수증 검색 
 */
function callGetReceiptDetail() {
	
	$.ifvProgressControl(true);
	
	rcptAftrRgstDetailForm = $("#rcptAftrRgstDetailForm").ifvValidation();
	if (rcptAftrRgstDetailForm.confirm() == true) {
		$.ifvSyncPostJSON('<ifvm:action name="callGetReceiptDetailVoc"/>', {
			ss_num : $('#inputRcptNo').val()
			, sale_day : $('#inputSalesDt').val()
			, shop_cod : $('#shop_cod').val()
		}, function(result) {
			$.ifvProgressControl(false);
			
			if(!result.fail) {
				var rslt = result.header;
				
				//기적립건 미존재 - 사후적립대상O
				$('#viewRcptFromB2CBtn2').attr('disabled', true);
				$('#reqAcrlBnt').attr('disabled', false);
				$('#rcptAftrRgstDetailForm').dataSetting(rslt);
				//다이소 소수점 무조건 버린다. (단, 서버단에선 포인트 소수점까지 반영되어있음)
				$('#vocPointPopInfo #pntAmt').val(rslt.pntAmt.split('.')[0]); //기본적립 프로모션 캠페인으로 서버에서 산출한 적립예정포인트
				
				var txnDate = rslt.txnDt;
				var txnTime = rslt.txnTm.substring(0,4); //초단위 제거
				var payAmt = parseInt(rslt.cashAmt.replaceAll(',','')) + parseInt(rslt.cardAmt.replaceAll(',','')) + parseInt(rslt.coupon.replaceAll(',',''));
				
				$('#txnDate').val(txnDate);
				$('#txnTime').val(txnTime);
				$('#payAmt').val($.fn.ifvmNumberWithCommas(payAmt));
				
				//바코드번호 -> 영수증번호 변환결과 세팅
				$('#inputRcptNo').val(rslt.receipNo);
				
				//입력한 영수증정보 조작할수없도록 모두 disabled
				$('#inputRcptNo').attr('disabled', true);
				$('#inputSalesDt').attr('disabled', true);
				$('#callGetReceiptDetailBtn').attr('disabled', true);
				$('#channelSearchHelpBtn').removeAttr('onClick');
				
				alert('적립 가능한 영수증입니다. 적립요청버튼을 클릭해 적립을 진행하세요.');
				
				$('#mbrVocPopSaveBtn').attr('disabled', false);
			} else {
				$('#mbrVocPopSaveBtn').attr('disabled', true);
				
				if(confirm('영수증 정보 조회 중 에러가 발생하였습니다. 다시 시도하시겠습니까?')) {
					$.ifvProgressControl(false);
					callGetReceiptDetail();
				}
			}
		}, function(result) {
			$.ifvProgressControl(false);
			$('#mbrVocPopSaveBtn').attr('disabled', true);
			
			//입력값 전체 초기화
			$('#rcptAftrRgstDetailForm input').each(function(i, e) {
				$(e).val('');
			});
			$('#shop_cod').val('');
			$('#posNum').val('');
			$('#ridChnl').val('');
			
			//기적립건 존재 - 사후적립대상X or 잘못된 프로모션 or 적립포인트 0원
			if($.fn.ifvmIsNotEmpty(result.message)) {
				alert(result.message);
			} else {
				alert('영수증 조회 중 에러가 발생하였습니다. 관리자에게 문의해주세요.');
			}
		});
	}
	
	$.ifvProgressControl(false);
}

/**
 * 영수증 보기 팝업 open
 */
function viewRcptFromB2CFn2(obj) {
   	var ss_num = obj.inputRcptNo;
   	var sale_day = obj.inputSalesDt;
   	var shop_cod = obj.chnlNo;
   	
   	$("#viewRcptFromB2C2").ifvsfPopup({
   		enableModal : true,
           enableResize: false,
           contentUrl: '<ifvm:url name="viewRcptFromB2C"/>?ss_num='+ss_num+'&sale_day='+sale_day+'&shop_cod='+shop_cod,
           contentType: "ajax",
           title: '영수증 보기',
           width: 440,
           close : 'viewRcptFromB2C2Close'
	});
}

/**
 * 영수증 보기 팝업 close
 */
function viewRcptFromB2C2Close() {
	viewRcptFromB2C2._destroy();
}

/**
 * 채널 검색 팝업 open
 */
function channelSearchFn() {
   	$("#channelSearchHelpPopup").ifvsfPopup({
   		enableModal : true,
           enableResize: false,
           contentUrl: '<ifvm:url name="channelSearchHelpRcptAftr"/>',
           contentType: "ajax",
           title: '가맹점 조회',
           width: 900,
           close : 'channelSearchHelpPopupClose'
	});
}

/**
 * 채널 검색 팝업 close
 */
function channelSearchHelpPopupClose() {
	channelSearchHelpPopup._destroy();
}

function channelSearchHelpEnter() {
	
}

function channelSearchHelpBlur() {
	
}

/**
 * 채널 검색 팝업 close
 */
function mbrSearchHelpPopupClose() {
	mbrSearchHelpPopup._destroy();
}

/**
 * 포인트 1회 적립제한금액 안내문구 세팅
 */
function setCsPntAcrlLimitNotice() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'CS_PNT_ACRL_LIMIT'
	},function(result){
		if(result.rows.length != 1) {
			alert('공통코드 CS_PNT_ACRL_LIMIT 는 1개만 등록되어있어야 합니다.');
		} else {
			var attrib01 = result.rows[0].attrib01;
			$('.warning_box').text('※ 포인트 적립시 ' + $.fn.ifvmDecimalWithCommas(attrib01) + ' 포인트 초과는 처리되지 않습니다.');
		}
	});
}

/**
 * 포인트사용비밀번호 변경
 */
function fnEditMbrPntUsePwSave() {
	validation = $("#editMbrPntUsePwForm").ifvValidation();
	if(validation.confirm()){
		var data = $('#editMbrPntUsePwForm').getSubmitData();
		if(data.pntUsePw === data.pntUsePwCnfrm) {
			$.ifvSyncPostJSON('<ifvm:action name="editMbrPntUsePw"/>', {
				ridMbr : mbr_rid
				, mbrNo : $('#mbrNo').val()
				, pntUsePw : data.pntUsePw
			}, function(result) {
				alert(result.message);
				editMbrPntUsePwPop.close();
			}, function(result) {
				alert(result.message);
			});
		} else {
			$.ifvCallValidationBox($("#pntUsePwCnfrm"),"입력한 비밀번호가 일치하지 않습니다.");
			return false;
		}
	}
}

/**
 * 취소
 */
function fnEditMbrPntUsePwClose() {
	editMbrPntUsePwPop.close();
}

$(document).ready(function() {

});

</script>

<div class="form-horizontal underline top_well clearfix" id="editMbrPntUsePwForm">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span>회원 포인트사용비밀번호 변경</span>
			</div>
		</div>
		<div class="row">
			<label class="control-label col-xs-4">
        	<span class="asterisk">*</span>신규 비밀번호</label>
			<div class="control_content col-xs-8">
	        	<input type="password" id="pntUsePw" dtoparam="pntUsePw" required="true" maxlength="4" autocomplete="new-password">
	        </div>
		</div>
		<div class="row">
			<label class="control-label col-xs-4">
        	<span class="asterisk">*</span>신규 비밀번호 확인</label>
			<div class="control_content col-xs-8">
	        	<input type="password" id="pntUsePwCnfrm" dtoparam="pntUsePwCnfrm" required="true" maxlength="4" autocomplete="new-password">
	        </div>
		</div>
		<div class="row"/>
</div>

<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="save"	text="저장" nuc="true" id="editMbrPntUsePwSave" btnFunc="fnEditMbrPntUsePwSave" className="btn_lightGray2"/>
   <ifvm:inputNew type="button" btnType="close"	text="L00913" id="editMbrPntUsePwClose" btnFunc="fnEditMbrPntUsePwClose" className="btn_lightGray2"/>
</div>