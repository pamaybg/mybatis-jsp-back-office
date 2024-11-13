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

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script>

var channelDetail_rid = '<%= cleanXss(request.getParameter("rid")) %>';
channelDetail_rid = channelDetail_rid == 'null' ? null : channelDetail_rid;
var channelDetail_isNew = true;  //신규 여부. 신규: true, 수정 : false

var channelDetail_validation;
var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID

$(function() {

	$.ifvmLnbSetting('channelListNew');

	/*채널유형*/
    $.ifvGetCommCodeList('select', 'chnlTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_CHNL_TYPE_CD', 'loy', false, false, true);
	/*채널하위유형*/
	$.ifvGetCommCodeList('select', 'chnlTypeSubCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_CHNL_SUB_TYPE_CD', 'loy', false, false, true);
	/*상태*/
	$.ifvGetCommCodeList('select', 'chnlStatCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_CHNL_STAT_CD', 'loy', false, false, true);

	//시작일자 & 종료일자
	setValidCalendar();

    if ($.fn.ifvmIsNotEmpty(channelDetail_rid) && channelDetail_rid != "null") {
        channelDetailDataLoad(channelDetail_rid);
    }
    // 신규일경우 로그인 세선의 프로그램을 세팅함.
    else {
        var userInfo = $.ifvmGetUserInfo();
		
        $("#channelGetStoreCd").prop("disabled", true);
    }
    
    $('#chnlTypeCd').change(function() {
 		$("input:checkbox[id='acrlPsblYn']").prop("disabled", false);
		$("input:checkbox[id='usePsblYn']").prop("disabled", false);
    });
    
    $('#chnlTypeSubCd').change(function() {
    	if( $('#chnlTypeSubCd option:selected').val() == 'P3' ) {
    		$("input:checkbox[id='acrlPsblYn']").prop("checked", false);
    		$("input:checkbox[id='usePsblYn']").prop("checked", true);
    		
    		$("input:checkbox[id='acrlPsblYn']").prop("disabled", true);
    		$("input:checkbox[id='usePsblYn']").prop("disabled", false);
    		
    	} else if ( $('#chnlTypeSubCd option:selected').val() == 'P4' ) {
    		$("input:checkbox[id='acrlPsblYn']").prop("checked", true);
    		$("input:checkbox[id='usePsblYn']").prop("checked", false);
    		
    		$("input:checkbox[id='acrlPsblYn']").prop("disabled", false);
    		$("input:checkbox[id='usePsblYn']").prop("disabled", true);
    		
    	} else {
    		$("input:checkbox[id='acrlPsblYn']").prop("checked", false);
    		$("input:checkbox[id='usePsblYn']").prop("checked", false);
    		
    		$("input:checkbox[id='acrlPsblYn']").prop("disabled", false);
    		$("input:checkbox[id='usePsblYn']").prop("disabled", false);
    	}
    });
    
});

/**
 * 화면 input 비활성 세팅
 */
function disabledSetting() {
	if(!$('#chnlNo').val().startsWith('CH')) {
		if($('#chnlTypeCd').val() === 'S') { //채널유형 판매
			$('#channelDetailForm input').each(function(i, e) {
				if(!($(e).attr('id') === 'mbrJoinPsblYn' || $(e).attr('id') === 'receiptPrintYn'|| $(e).attr('id') === 'acrlPsblYn' || $(e).attr('id') === 'usePsblYn' )) {
					$(e).attr('disabled', true)
				}
			});

			$('#channelDetailForm select').each(function(i, e) {
				$(e).attr('disabled', true)
			});
		}
	}
}

//시분 셋팅
function setTimepicker() {
	var startTime = $("#chnlOpenTime");
	var endTime = $("#chnlCloseTime");
	startTime.timepicker({
		defaultTime: "00:00",
		timeFormat: "H:i",
		showMeridian: false
	});
	endTime.timepicker({
		defaultTime: "23:59",
		timeFormat: "H:i",
		showMeridian: false
	});
}

function callKakoApi(){
	var adrDtl = $("#adrDtl").val();
	
	if($.fn.ifvmIsNotEmpty(adrDtl)){
		$.ifvSyncPostJSON('<ifvm:action name="callKakaoApi"/>', { 
			adrDtl : adrDtl
		}, function(result) {                         
			if ($.fn.ifvmIsNotEmpty(result)) {
				if(result.success){
					$('#latitude').val(result.latitude);
					$('#longitude').val(result.longitude);
				}
			}
		}, function(result) {
			alert('KAKO MAP API [잘못된주소]');
		});                                           
	}else{
		alert('주소가 입력되지 않았습니다.');
	}
}

$(document).ready(function() {

	$.ifvmLnbSetting('channelListNew');

    $("#channelDetailBtnSave").click(function() {
        channelDetailActionSave();
    });

    $("#channelDetailBtnList").click(function() {
        qtjs.href('<ifvm:url name="channelListNew"/>');
    });

    channelDetail_validation = $("#channelDetailForm").ifvValidation();

    $("input[vali-type=number]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    });

    //화면 input 비활성 세팅
    disabledSetting();
	
    //시분 셋팅
    setTimepicker();

	$('#channelGetStoreCd').click(function() {
		getStoreCd();
	});
	
	$('#callKakoApi').click(function() {
		callKakoApi();
	});
});

function channelDetailDataLoad(channelDetail_rid) {
    channelDetail_isNew = false; // 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.
    $.ifvSyncPostJSON('<ifvm:action name="getChannelDefaultInfo"/>', {
        rid : channelDetail_rid
    }, function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            $('#channelDetailForm').dataSetting(result);
            $($('#channelDetailForm').find('input')).each(function(index, item) {
                if ($(this).attr('type') == "checkbox") {
                    if (result[$(item).attr('id')] == 'Y') {
                        $(this).attr('checked', true);
                    }
                    else {
                    	$(this).attr('checked', false);
                    }
                }
            });
            
            if( $.fn.ifvmIsNotEmpty($('#storeCd').val()) ) {
            	$('#channelGetStoreCd').hide()
        	}

        }
    });
}

/*
 submit을 위한 form 데이터 파라미터 세팅
 */
function getchannelDetailObjForSubmit() {
    var submitData = $("#channelDetailForm").getSubmitData();
    submitData.rid = channelDetail_rid;
    submitData.latitude = $('#latitude').val();
    submitData.longitude = $('#longitude').val();
    
    $($('#channelDetailForm').find('input')).each(function(index, item) {
        if ($(this).attr('type') == "checkbox") {
        	submitData[$(item).attr('id')] = $(this).prop('checked') ? "Y" : "N";
        }
    });

    return submitData;
}

//저장 버튼클릭 시 동작
function channelDetailActionSave() {
    if (channelDetail_validation.confirm()) {
        channelDetailSaveSubmit();
    }
}
function channelDetailSaveSubmit() {
    $.ifvSyncPostJSON(channelDetail_isNew ? '<ifvm:action name="saveChannelDetail"/>' : '<ifvm:action name="editChannelDetail"/>'
    , getchannelDetailObjForSubmit()
    , function(result) {
        alert('<spring:message code="L00127"/>');
        if (channelDetail_isNew) {
            channelDetail_rid = result.message;
        }
        qtjs.href('<ifvm:url name="channelDetail"/>' + '?rid=' + channelDetail_rid);
    }, function(result) {
        $.errorChecker(result);
    });
}

function makeCallForTelNo() {
	var phoneNo = $("#telNo").val();
	parent.localSoftMakeCall(phoneNo,null);
}

function makeCallForHpNo(){
	var phoneNo = $("#hpNo").val();
	parent.localSoftMakeCall(phoneNo,null);
}

/**
 * 주소 검색
 */
function adrDtlSearchFn() {
	/*
    $('#adrDtlSearchPop').ifvsfPopup({
		enableModal : true,
		enableResize : false,
		contentUrl : '<ifvm:url name="adrSearchPop"/>',
		contentType : "ajax",
		title : '주소 검색',
		width : '700px'
	});
	 */

	/**
	 * 2018.12.18 hy.jun
	 * daum 주소검색 팝업이 한번에 생성되지 않는 버그가 있어 try-catch 추가하여 한번 더 시도하도록 수정.
	 */
	try {
		execDaumPostcode();
	} catch(e) {
		execDaumPostcode();
	}
}

function adrSearchHelpEnter() {

}

function execDaumPostcode() {

    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var rFullAddr = '';	//도로명주소
            var jFullAddr = '';	//지번

            var extraAddr = ''; //조합형 주소 변수

            rFullAddr = data.roadAddress;
            jFullAddr = data.jibunAddress;

            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
            rFullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			jFullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $("#zipCd").val(data.postcode);
            $("#adrDtl").val(jFullAddr);
            $("#roadNmAdrZipCd").val(data.zonecode);
            $("#roadNmAdr").val(rFullAddr);

            //위경도 추가조회하는 api 호출 필요
            callGetAddrXYApi();

        }
    }).open();
}

function adrSearchHelpBlur() {

}

function setValidCalendar() {
    var sbscDd = $("#sbscDd");
    var trmnDd = $("#trmnDd");
    sbscDd.ifvDateChecker({});
    trmnDd.ifvDateChecker({});
}

/**
 * 위경도 검색 api 호출
 */
function callGetAddrXYApi() {

	var adr = $("#adrDtl").val();
	if($.fn.ifvmIsEmpty(adr)) {
		adr = $("#roadNmAdr").val();
	}

	if($.fn.ifvmIsEmpty(adr)) {
		alert('주소가 입력되지 않았습니다.');
	} else {
		$.ifvSyncPostJSON('<ifvm:action name="callGetAddrXYApi"/>', {
	        query : adr
	        , page : 1
	        , size : 30
	    }, function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)) {
	        	$('#latitude').val(result.latitude); //위도
	        	$('#longitude').val(result.longitude); //경도
	        }
    	});
	}
}

function getStoreCd() {
	
	//채널하위유형이 제휴스토어일 경우만 스토어코드 생성가능
	if($.fn.ifvmIsNotEmpty(channelDetail_rid)) {
		if( $('#chnlTypeSubCd').val() == 'P3' && $('#chnlStatCd').val() == 'A') {
			channelDetailSaveSubmit();
			
			$.ifvSyncPostJSON('<ifvm:action name="getStoreCd"/>', {
		        rid : channelDetail_rid
		    }, function(result) {
		        channelDetailDataLoad(channelDetail_rid);
			});
		} else {
			alert('채널하위유형 또는 상태에 따라 스토어코드를 생성할 수 없습니다.');
		}
	} else {
		alert('채널상세를 먼저 입력해주세요.');
	}
	
}

</script>

<div class="page-title">
    <h1>
        <spring:message code="L00648"/>
        &gt;  <spring:message code="M00169"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	    	<%-- 채널 상세 --%>
	        <span><spring:message code="M02462"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <%-- 저장 --%>
	        <button class="btn btn-sm" id="channelDetailBtnSave" objCode="channelDetailBtnSave_OBJ"><spring:message code="L00074"/></button>
	        <%-- 목록 --%>
	        <button class="btn btn-sm" id="channelDetailBtnList" objCode="channelDetailBtnList_OBJ"><spring:message code="M00002"/></button>
	    </div>
	</div>

	<div class="form-horizontal underline top_well" id="channelDetailForm" >
		<div class="half_content half_left qt_border">
			<div class="form-horizontal top_well underline" >
				<div class="row">
			    	<%-- 채널상호 --%>
			        <ifvm:inputNew type="text" id="chnlNo" maxLength="50" dto="chnlNo" label="L00613" labelClass="2" conClass="2" readonly="true"/>
					<ifvm:inputNew type="text" id="chnlRealNm" maxLength="50" dto="chnlRealNm" labelClass="0" conClass="8" />
				</div>
				<div class="row">
					<%-- 약어명 --%>
					<ifvm:inputNew type="text" id="chnlNm" maxLength="50" dto="chnlNm" required="true" label="L00129" labelClass="2" conClass="4" />
				</div>
				<div class="row">
			    	<%-- 주소 --%>
			    	<ifvm:inputNew type="text" id="adrDtl" maxLength="300" dto="adrDtl" label="M00574" labelClass="2" conClass="10"/>
				</div>
				<div class="row">
					<%-- 위도/경도 --%>
			        <ifvm:inputNew type="text" id="latitude" dto="latitude" label="위도/경도" nuc="true" labelClass="2" conClass="2" />
			        <ifvm:inputNew type="text" id="longitude" dto="longitude" conClass="2" />
			        <ifvm:inputNew type="button" id="callKakoApi" nuc="true" text="생성" conClass="2" objCode="callKakoApi_OBJ"/>
				</div>
				<div>
					<%-- 시작일자 --%>
					<ifvm:inputNew type="time" id="chnlOpenTime" dto="chnlOpenTime" label="영업 시작시간" nuc="true" labelClass="2" conClass="4" />
					<%-- 종료일자 --%>
					<ifvm:inputNew type="time" id="chnlCloseTime" dto="chnlCloseTime" label="영업 종료시간" nuc="true" labelClass="2" conClass="4" />
				</div>
				<div class="row">
					<%-- 대표자 --%>
			        <ifvm:inputNew type="text" id="reprNm" maxLength="50" dto="reprNm" label="M01797" labelClass="2" conClass="4" />
			        <%-- 사업자번호 --%>
					<ifvm:inputNew type="text" id="bizrNo" maxLength="50" dto="bizrNo" label="L00597" labelClass="2" conClass="4" valiItem="number"/>
				</div>
				<div class="row">
			    	<%-- 전화번호 --%>
			        <ifvm:inputNew type="text" id="telNo" dto="telNo" label="L00400" labelClass="2" conClass="4" />
			        <%-- 팩스번호 --%>
			        <ifvm:inputNew type="text" id="faxNo" maxLength="50" dto="faxNo" label="M00578" labelClass="2" conClass="4" />
				</div>
			</div>
	   	</div>
		<div class="half_content half_right">
			<div class="form-horizontal top_well underline" >
				<div class="row">
					<%-- 시작일자 --%>
					<ifvm:inputNew type="date" id="sbscDd" dto="sbscDd" label="M02621" labelClass="2" conClass="4" />
					<%-- 종료일자 --%>
					<ifvm:inputNew type="date" id="trmnDd" dto="trmnDd" label="M02622" labelClass="2" conClass="4" />
				</div>
				<div class="row">
					<%-- 채널유형 --%>
			        <ifvm:inputNew type="select" id="chnlTypeCd" maxLength="50" dto="chnlTypeCd" label="L01098" labelClass="2" conClass="4" />
					<%-- 상태 --%>
			        <ifvm:inputNew type="select" id="chnlStatCd" maxLength="50" dto="chnlStatCd" label="L00627" labelClass="2" conClass="4" />
				</div>
				<div class="row">
			        <%-- 채널하위유형 --%>
					<ifvm:inputNew type="select" id="chnlTypeSubCd" maxLength="50" dto="chnlTypeSubCd" label="L00278" labelClass="2" conClass="4" />
					<%-- 스토어코드 --%>
					<ifvm:inputNew type="text" id="storeCd" dto="storeCd" label="L00788" labelClass="2" conClass="4" readonly="true"/>
				</div>
				<div class="row">
					<%-- 등록일자 --%>
					<ifvm:inputNew type="date" id="createDate" dto="createDate" label="M00222" labelClass="2" conClass="4" readonly="true" disabled="true"/>
					<%-- 등록자 --%>
					<ifvm:inputNew type="text" id="createByNm" dto="createByNm" label="M00221" labelClass="2" conClass="4" readonly="true"/>
				</div>
				<div class="row">
					<%-- 포인트 적립 가능 여부 --%>
					<ifvm:inputNew type="singleCheckbox" id="acrlPsblYn" dto="acrlPsblYn" label="L02305" values="Y" labelClass="3" conClass="2" checked="false" disabled="false"/>
					<%-- 포인트 사용 가능 여부 --%>
					<ifvm:inputNew type="singleCheckbox" id="usePsblYn" dto="usePsblYn" label="L02336" values="Y" labelClass="3" conClass="2" checked="false" disabled="false"/>
				</div>
			</div>
	   	</div>
	    <div class="row"></div>
	    <div class="row"></div>
	    <div class="row"></div>
	</div>
</div>
<div id="channelDetailTabArea"></div>
<div id="channelDetailDialog" class="popup_container"></div>

<script type="text/javascript">
var channelDetailTabArea = $('#channelDetailTabArea').DrawTab({
	item: [
		{label: '<spring:message code="L02304"/> ', href: '<ifvm:url name="chnlTxnMemListNew"/>'},  /* 관련회원 */

	]
});

</script>

<div id="adrDtlSearchPop" class="popup_container"></div>

