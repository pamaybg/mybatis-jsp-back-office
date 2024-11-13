<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script type="text/javascript">

var rid = '<%= cleanXss(request.getParameter("rid")) %>';
rid = rid === 'null' ? null : rid;

function fnSearchCampaign() {
	$("#promotionSearchHelpPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="promotionSearchHelpNewStmp"/>?campaignTypeCode=STAMP',
        contentType: "ajax",
        title: '스탬프 캠페인 목록 조회',
        width: 1200,
        close : 'promotionSearchHelpPopupClose'
    });
}

function promotionSearchHelpPopupClose() {
	promotionSearchHelpPopup._destroy();
}

//스탬프 아이템 조회
function getStmpItemDetail() {
	$.ifvPostJSON('<ifvm:action name="getStmpItemDetail"/>', {
		rid : rid
	}, function(result) {
		if($.fn.ifvmIsNotEmpty(result)) {
			$("#stmpItemDetailForm").dataSetting(result);

			//천단위 구분자 넣을 요소 아이디 배열
			var targets = ['stmpAmt','stmpCnt'];

			$.each(targets, function(i,e) {
				$('#'+e).change();
			})
		}
	});
}

//스탬프 아이템 수정
function editLoyStmpItem() {
	var submitData = $("#stmpItemDetailForm").getSubmitData();
	submitData.ridStmp = ridStmp;
	submitData.rid = rid;
	submitData.stmpAmt = submitData.stmpAmt.replaceAll(',','');
	submitData.stmpCnt = submitData.stmpCnt.replaceAll(',','');

	$.ifvPostJSON('<ifvm:action name="editLoyStmpItem"/>'
	, submitData
	, function(result) {
		alert('<spring:message code="L00076"/>');
		stmpItemList.searchGrid({ridStmp:ridStmp});
		stmpItemDetailPopClose();
	}, function(result) {
		if(result.message === '1') {
			alert('계산유형이 단일거래인 스탬프의 경우 모든 구간의 구매횟수는 0이어야 합니다.');
		} else if(result.message === '2') {
			alert('계산유형이 누적거래인 스탬프의 경우 이전 스탬프 구간의 구매금액보다 커야합니다.');
		} else if(result.message === '3') {
			alert('계산유형이 누적거래인 스탬프의 경우 이전 스탬프 구간의 구매횟수보다 커야합니다.');
		} else if(result.message === '4') {
			alert('활성 중인 스탬프의 구간은 수정할 수 없습니다.');
		} else {
			alert('저장할 수 없습니다. 관리자에게 문의해주세요.');
		}
	});
}

function getNumber(obj){
    var num01;
    var num02;
    num01 = obj.value;
    num02 = num01.replace(/\D/g,""); //숫자가 아닌것을 제거,
                                     //즉 [0-9]를 제외한 문자 제거; /[^0-9]/g 와 같은 표현
    num01 = setComma(num02); //콤마 찍기
    obj.value =  num01;
}

function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }
    return n;
}

//천단위 구분자 설정
function setThousandSeparator() {
	//천단위 구분자 넣을 요소 아이디 배열
	var targets = ['stmpAmt','stmpCnt'];

	$.each(targets, function(i,e) {
		$('#'+e).on('change', function() {
			getNumber(this);
		});
		$('#'+e).on('keyup', function() {
			getNumber(this);
		});
	});
}

//프로모션 초기화
function fnResetCampaign() {
	if($.fn.ifvmIsNotEmpty($('#camNo').val())) {
		if(confirm('등록한 프로모션을 삭제하시겠습니까?')) {
			$.ifvPostJSON('<ifvm:action name="removeLoyStmpItemCamNo"/>', {
				rid : rid
			}, function(result) {
				alert('<spring:message code="L00076"/>');
				stmpItemList.searchGrid({ridStmp:ridStmp});
				
				$('#camNm').val('');
				$('#camNo').val('');
			});
		}
	}
}

$(document).ready(function() {

	$.ifvmLnbSetting('stmpList');

	setEnableInputAtDetail();

	setThousandSeparator();
	getStmpItemDetail();
	
	if($('#stmpStatus').val() != 'A') {
		$.ifvEnterSetting(["#stmpAmt"], editLoyStmpItem);    
		$.ifvEnterSetting(["#stmpCnt"], editLoyStmpItem);    
	}
	
	//단일거래이거나 구매금액인 경우
	if($('#calcTypeCd').val() === '01' || $('#calcTypeSubCd').val() === 'A') {
		$('#stmpItemDetailForm #stmpCnt').val(1);
		$('#stmpItemDetailForm #stmpCnt').attr('disabled',true);
	}
});

</script>

<div id="stmpItemDetailForm">
	<div class="form-horizontal underline top_well clearfix">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span>구간별 스탬프 상세</span>
			</div>
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="itemNo" dto="itemNo" label="스탬프번호" nuc="true" labelClass="2" conClass="9"  disabled="true" required="true"/>
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="stmpAmt" dto="stmpAmt" label="구매금액" nuc="true" labelClass="2" conClass="9" required="true"/>
		</div>
		<div class="row"> 
			<ifvm:inputNew type="text" id="stmpCnt" dto="stmpCnt" label="구매횟수" nuc="true" labelClass="2" conClass="9" required="true"/> 
		</div>
		<div class="row">
			<!-- 프로모션 캠페인 -->
			<ifvm:inputNew type="text" id="camNm" dto="camNm" disabled="true" required="true" label="프로모션 캠페인" nuc="true" labelClass="2" conClass="5"/>
			<!-- 프로모션 검색 -->
			<div class="control_content col-xs-2">
				<ifvm:inputNew type="button" btnType="search" text="프로모션 검색" nuc="true" id="searchCampaignBtn" btnFunc="fnSearchCampaign"/>
			</div>
			<!-- 프로모션 초기화 -->
			<div class="control_content col-xs-2">
				<ifvm:inputNew type="button" text="프로모션 초기화" nuc="true" id="resetCampaignBtn" btnFunc="fnResetCampaign"/>
			</div>
		</div>
		<ifvm:inputNew type="hidden" id="camNo" dto="camNo"/>
	</div>

	<div class="pop_btn_area">
		 <ifvm:inputNew type="button" btnType="save" btnFunc="editLoyStmpItem" text="L00074" />
		 <ifvm:inputNew type="button" btnFunc="stmpItemDetailPopClose" text="L00913" />
	</div>
</div>

<div id="promotionSearchHelpPopup" class="popup_container"></div>
