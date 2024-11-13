<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<script>

var chnlAddInfo_rid = channelDetail_rid;
var chnlAddInfo_isNew = true;  //신규 여부. 신규: true, 수정 : false

var chnlAddInfo_validation;
var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
/* var acrlRuleCdTemp; */
/* var adjRuleCdTemp; */
var parChnlNoTemp;

$(function() {

    // 공통코드
    /*
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
        groupCode : 'POINT_CONTRACT',
        enableNA : true
    }, function(result) {
        var temp = $("#pointContTypeTemp").tmpl(result.rows);
        $("#pointContType").append(temp);
    });

    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
        groupCode : 'BC_STATUS',
        enableNA : true
    }, function(result) {
        var temp = $("#mbrbsStatusCd2Temp").tmpl(result.rows);
        $("#mbrbsStatusCd2").append(temp);
    });

    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
        groupCode : 'MARKET_PLACE',
        enableNA : true
    }, function(result) {
        var temp = $("#trdareTemp").tmpl(result.rows);
        $("#trdare").append(temp);
    });
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
        groupCode : 'STATION_SPACE',
        enableNA : true
    }, function(result) {
        var temp = $("#plotgNfpyTemp").tmpl(result.rows);
        $("#plotgNfpy").append(temp);
    });

    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
        groupCode : 'COMPETITION_INTEN',
        enableNA : true
    }, function(result) {
        var temp = $("#cmpetLevelTemp").tmpl(result.rows);
        $("#cmpetLevel").append(temp);
    });

    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
        groupCode : 'SPOINT_ACC_METHOD_TYPE',
        enableNA : true
    }, function(result) {
        var temp = $("#stnPointAplyMethTemp").tmpl(result.rows);
        $("#stnPointAplyMeth").append(temp);
    });

    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
        groupCode : 'PARTNER_STORE_CREATE_TYPE',
        enableNA : true
    }, function(result) {
        var temp = $("#lowMbrbsCretDivNmTemp").tmpl(result.rows);
        $("#lowMbrbsCretDivNm").append(temp);
    });
	 */
	/* 매장운영상태 */
	$.ifvGetCommCodeList('select', 'chnlActStatCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_CHNL_ACT_TYPE_CD', 'loy', false, false, true);
	/* 평수 */
	$.ifvGetCommCodeList('select', 'chnlPyeong', '<ifvm:action name="getCommCodeList2"/>', 'LOY_CHNL_PYEONG', 'loy', false, false, true);
	/* 유통구분 */
	$.ifvGetCommCodeList('select', 'ctg', '<ifvm:action name="getCommCodeList2"/>', 'LOY_CHNL_DIST_DIV', 'loy', false, false, true);

    if ($.fn.ifvmIsNotEmpty(chnlAddInfo_rid) && chnlAddInfo_rid != "null") {
        chnlAddInfoDataLoad(chnlAddInfo_rid);
    }
    // 신규일경우 로그인 세선의 프로그램을 세팅함.
    else {
        var userInfo = $.ifvmGetUserInfo();
    }

    numberFormatter();
    
    //모든 input & 저장버튼 비활성화
    if($.fn.ifvmIsNotEmpty(chnlAddInfo_rid) && chnlAddInfo_rid != "null" && !$('#chnlNo').val().startsWith('CH')) {
		$('#loyaltychannelincludechnlAddInfo input').each(function(i, e) {
			$(e).attr('disabled', true);
		});
		
		$('#loyaltychannelincludechnlAddInfo select').each(function(i, e) {
			$(e).attr('disabled', true)
		});
		
		$('#loyaltychannelincludechnlAddInfo textarea').each(function(i, e) {
			$(e).attr('disabled', true)
		});
		
		$('#chnlAddInfoBtnSave').attr('disabled', true);
    }
});

$(document).ready(function() {
	/*
	function changeFraudMbrbsActnDiv(){
		var fraudMbrbsActnDiv = $("#fraudMbrbsActnDiv").val();
	    if (fraudMbrbsActnDiv == "BL3020" || fraudMbrbsActnDiv == "BL4020" ) {//부정의심 : BC판매량 > E1판매량
	    	$("#mbrbsStatusCd2").val("30");
	    }
	    else if (fraudMbrbsActnDiv == "BL3030" || fraudMbrbsActnDiv == "BL4030" ) {//부정확신 : E1판매량=0 & BC판매량>0
	    	$("#mbrbsStatusCd2").val("20");//해지
	  	}
	    else {
	    	$("#mbrbsStatusCd2").val("10"); //정상
	    }
	} */

	$.ifvmLnbSetting('channelListNew');

	//영업시간시간
    $('#chnlOpenTime').timepicker({
		timeFormat : 'H:i',
		showMeridian : true
    });

	//영업종료시간
	$('#chnlCloseTime').timepicker({
		timeFormat : 'H:i',
		showMeridian : true
	});

    $("#chnlAddInfoBtnList").click(function() {
        qtjs.href('<ifvm:url name=""/>');
    });

    chnlAddInfo_validation = $("#chnlAddInfoForm").ifvValidation();

    $("input[vali-type=number]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    });
    
    //새창에서 지도보기
    $("#viewDaumMap").click(function() {
    	viewDaumMap();
    });

	/* $("#fraudMbrbsActnDiv").change(function(){
		changeFraudMbrbsActnDiv();

	})
	$("#fraudDiv").change(function() {
	    // 부정가맹점 조치구분
	    $.fn.ifvGetHierarchySelect("fraudMbrbsActnDiv", '<ifvm:action name="getHierarchyCommCodeList"/>', 'PARTNER_BL_RESULT', $("#fraudDiv").val(), false);
	}) */
});

/* 팝업 닫기 */
function chnlAddInfoPopupClose() {
	chnlAddInfoPopupContainer._destroy();
}

//초기 설정 함수
/*
function detailInit() {
    if($.fn.ifvmIsNotEmpty(chnl_rid) && chnl_rid != "null") chnlAddInfoDataLoad(chnl_rid);
}
 */

function chnlAddInfoDataLoad(chnlAddInfo_rid) {
    // 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.
    chnlAddInfo_isNew = false;

    $.ifvSyncPostJSON('<ifvm:action name="getChnlAddInfo"/>', {
        rid : chnlAddInfo_rid
    }, function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {

            //$.fn.ifvGetHierarchySelect("fraudDiv", '<ifvm:action name="getHierarchyCommCodeList"/>', 'PARTNER_BL_TYPE', '2', false);
            //$.fn.ifvGetHierarchySelect("fraudMbrbsActnDiv", '<ifvm:action name="getHierarchyCommCodeList"/>', 'PARTNER_BL_RESULT', result.fraudDiv, false);

            $('#chnlAddInfoForm').dataSetting(result);

            /* $('#acrlRuleCd').val(result.acrlRuleCd); */
            /* $('#adjRuleCd').val(result.adjRuleCd); */
            /* acrlRuleCdTemp = result.acrlRuleCd; */
            /* adjRuleCdTemp = result.adjRuleCd; */
            parChnlNoTemp = result.parChnlNo;
            $($('#chnlAddInfoForm').find('input')).each(function(index, item) {
                if ($(this).attr('type') == "checkbox") {
                    if (result[$(item).attr('id')] == 'Y') {
                        $(this).attr('checked', true);
                    }
                }
            });

            /* if (result.ouTypeCd == '2') {
                $('#acrlRuleCd').attr("disabled", true);
                $('#adjRuleCd').attr("disabled", true);
                $("#adjRuleCdSearch").addClass('hidden');
                $("#acrlRuleCdSearch").addClass('hidden');
            }

            if ((result.ouTypeCd == '4' && result.stnDiv == '442') || result.ouTypeCd == '8' || result.ouTypeCd == '9') {
                $('#parMbrbsYn').attr("disabled", false);
                $('#lowMbrbsCretDivNm').attr("disabled", false);
                $('#parChnlNo').attr("disabled", false);
                $("#parChnlNoSearch").removeClass('hidden');
            }
            else {
                $('#parMbrbsYn').attr("disabled", true);
                $('#lowMbrbsCretDivNm').attr("disabled", true);
                $('#parChnlNo').attr("disabled", true);
                $("#parChnlNoSearch").addClass('hidden');
            }

            if (result.ouTypeCd == '4' && result.stnDiv == '2794') {
                $('#lowMbrbsCd').attr("disabled", false);
                $('#parRunOnlineYn').attr("disabled", false);

            }
            else {
                $('#lowMbrbsCd').attr("disabled", true);
                $('#parRunOnlineYn').attr("disabled", true);
            } */



                /* $("#adjRuleCdSearch").addClass('hidden'); */
                /* $("#acrlRuleCdSearch").addClass('hidden'); */
                /* $("#parChnlNoSearch").addClass('hidden'); */
                /* $('#fraudMbrbsActnDesc').attr("disabled", true); */
                /* $($('#chnlAddInfoForm').find('input')).each(function(index, item) {
                    $(this).attr("disabled", true);
                });
                $($('#chnlAddInfoForm').find('select')).each(function(index, item) {
                    $(this).attr("disabled", true);
                });
                $($('#chnlAddInfoForm').find('checkbox')).each(function(index, item) {
                    $(this).attr("disabled", true);
                }); */
        }
    });
}

//지도 보기
function viewDaumMap() {
	if($.fn.ifvmIsNotEmpty($('#chnlAddInfoForm #latitude').val())
			&& $.fn.ifvmIsNotEmpty($('#chnlAddInfoForm #longitude').val())) {
		var url = "http://map.daum.net/link/map/";
		url = url
			+ $('#channelDetailForm #chnlNm').val()
			+ ',' + $('#chnlAddInfoForm #latitude').val()
			+ ',' + $('#chnlAddInfoForm #longitude').val();
		window.open(url, "_blank");
	}
	else {
		alert('<spring:message code="L02339"/>');
	}
}

function chnlAddInfoSaveSubmit() {
    $.ifvSyncPostJSON(chnlAddInfo_isNew ? '<ifvm:action name="saveChnlAddInfo"/>' : '<ifvm:action name="editChnlAddInfo"/>'
    , getchnlAddInfoObjForSubmit()
    , function(result) {
		alert('<spring:message code="L00127"/>');
		if (chnlAddInfo_isNew) {
		    chnlAddInfo_rid = result.message;
		}
    });
}

function getchnlAddInfoObjForSubmit() {
    var submitData = $("#chnlAddInfoForm").getSubmitData();
    submitData.rid = chnlAddInfo_rid;
    /* submitData.mbrbsStatusCd = submitData.mbrbsStatusCd2; */

    $($('#chnlAddInfoForm').find('input')).each(function(index, item) {
    	if ($(this).attr('type') == "checkbox") {
    		submitData[$(item).attr('id')] = $(this).prop('checked') ? "Y" : "N";
    	}

        if ($(this).attr('id') === 'chnlOpenTime' && $.fn.ifvmIsNotEmpty($(this).val())) {
        	var vals = $(this).val().split(' ');
        	submitData[$(item).attr('id')] = vals[0].replace(':','');
        	submitData[$(item).attr('id')+'Meridiem'] = vals[1].toUpperCase();
        }

        if ($(this).attr('id') === 'chnlCloseTime') {
        	var vals = $(this).val().split(' ');
        	submitData[$(item).attr('id')] = vals[0].replace(':','');
        	submitData[$(item).attr('id')+'Meridiem'] = vals[1].toUpperCase();
        }
    });

    return submitData;
}

/**
 * 저장 버튼클릭 시 동작
 */
function chnlAddInfoActionSave() {
    if (chnlAddInfo_validation.confirm()) {
    	if(!$.fn.ifvmIsEmpty(chnlAddInfo_rid)) {
        	chnlAddInfoSaveSubmit();
    	} else {
    		alert('<spring:message code="M00510"/>');
    	}
    }
}

/*================================= 적립기준  서치핼프 ================================= */
function acrlStandardSearchHelpBlur() {
    if (acrlRuleCdTemp != $('#acrlRuleCd').val()) {
        if ($('#acrlRuleCd').val() == "") {
            $('#ridAcrlRule').val("");
            $('#acrlRuleTypeCd').val("");
        }
        else {
            openAcrlStandardSearchHelp('<ifvm:url name="pointSearchHelp"/>?typeCd=A&ruleCd=' + encodeURI(encodeURIComponent($('#acrlRuleCd').val())));
        }
    }
}

function acrlStandardSearchHelpBtn() {
    openAcrlStandardSearchHelp('<ifvm:url name="pointSearchHelp"/>?typeCd=A');
}

function acrlStandardSearchHelpEnter() {

    if ($('#acrlRuleCd').val() == "") {
        $('#ridAcrlRule').val("");
        $('#acrlRuleTypeCd').val("");
    }
    else {
        openAcrlStandardSearchHelp('<ifvm:url name="pointSearchHelp"/>?typeCd=A&ruleCd=' + encodeURI(encodeURIComponent($('#acrlRuleCd').val())));
    }
}

function openAcrlStandardSearchHelp(url) {
    ;
    pointSearchHelpPop = {
        id : "chnlAddInfoPopupContainer"
    };
    pointSearchHelpPop.popup = function() {
        pointSearchHelpPop.pop = $('#' + pointSearchHelpPop.id).ifvsfPopup({
            enableModal : true,
            enableResize : false,
            contentUrl : url,
            contentType : "ajax",
            title : '적립기준 조회',
            width : '700px',
            close : pointSearchHelpPop.close
        });
    };
    pointSearchHelpPop.beforeClose = function(obj) {
    };
    pointSearchHelpPop.close = function(obj) {
        if (obj != null && obj.type != "close") {
            $("#acrlRuleCd").val(obj.ruleCd);
            acrlRuleCdTemp = obj.ruleCd;
            $("#acrlRuleTypeCd").val(obj.ruleTypeCd);
            $("#ridAcrlRule").val(obj.rid);

        }
        else {
            $("#acrlRuleCd").val(acrlRuleCdTemp);
        }
        pointSearchHelpPop.beforeClose(obj);
        chnlAddInfoPopupContainer._destroy();
    };
    pointSearchHelpPop.popup();

}



/*================================= 정산기준  서치핼프 ================================= */
function adjStandardSearchHelpBlur() {
    if (adjRuleCdTemp != $('#adjRuleCd').val()) {
        if ($('#adjRuleCd').val() == "") {
            $('#ridAdjRule').val("");
            $('#adjRuleTypeCd').val("");
        }
        else {
            openAdjStandardSearchHelp('<ifvm:url name="pointSearchHelp"/>?typeCd=B&ruleCd=' + encodeURI(encodeURIComponent($('#adjRuleCd').val())));
        }
    }
}

function adjStandardSearchHelpBtn() {
    openAdjStandardSearchHelp('<ifvm:url name="pointSearchHelp"/>?typeCd=B');
}

function adjStandardSearchHelpEnter() {

    if ($('#adjRuleCd').val() == "") {
        $('#ridAdjRule').val("");
        $('#adjRuleTypeCd').val("");
    }
    else {
        openAdjStandardSearchHelp('<ifvm:url name="pointSearchHelp"/>?typeCd=B&ruleCd=' + encodeURI(encodeURIComponent($('#adjRuleCd').val())));
    }
}

function openAdjStandardSearchHelp(url) {

    pointSearchHelpPop = {
        id : "chnlAddInfoPopupContainer"
    };
    pointSearchHelpPop.popup = function() {
        pointSearchHelpPop.pop = $('#' + pointSearchHelpPop.id).ifvsfPopup({
            enableModal : true,
            enableResize : false,
            contentUrl : url,
            contentType : "ajax",
            title : '정산기준 조회',
            width : '700px',
            close : pointSearchHelpPop.close
        });
    };
    pointSearchHelpPop.beforeClose = function(obj) {
    };
    pointSearchHelpPop.close = function(obj) {
        if (obj != null && obj.type != "close") {
            $("#adjRuleCd").val(obj.ruleCd);
            adjRuleCdTemp = obj.ruleCd;
            $("#adjRuleTypeCd").val(obj.ruleTypeCd);
            $("#ridAdjRule").val(obj.rid);

        }
        else {
            $("#adjRuleCd").val(adjRuleCdTemp);
        }
        pointSearchHelpPop.beforeClose(obj);
        chnlAddInfoPopupContainer._destroy();
    };
    pointSearchHelpPop.popup();

}





/*================================= 상위가맹점기준  서치핼프 ================================= */
function parChnlSearchHelpBlur() {

	if( parChnlNoTemp!= $('#parChnlNo').val() ){
		if($('#parChnlNo').val()==""){
			$('#parRid').val("");
			$('#parChnlNm').val("");
		}else{
			openParChnlSearchHelp('<ifvm:url name="channelSearchHelp"/>?ouTypeCd=B&chnlNo='+encodeURI(encodeURIComponent($('#parChnlNo').val())));
		}
	}
}

function parChnlSearchHelpBtn() {
	openParChnlSearchHelp('<ifvm:url name="channelSearchHelp"/>?ouTypeCd=B');
}

function parChnlSearchHelpEnter() {

	if($('#parChnlNo').val()==""){
		$('#parRid').val("");
		$('#parChnlNm').val("");
	}else{
		openParChnlSearchHelp('<ifvm:url name="channelSearchHelp"/>?ouTypeCd=B&chnlNo='+encodeURI(encodeURIComponent($('#parChnlNo').val())));
	}
}

function openParChnlSearchHelp(url) {

	channelSearchHelpPop ={
	        id : "channelSearchHelpPopupContainer"
	    };
	channelSearchHelpPop.popup = function (){
		channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: url ,
		            contentType: "ajax",
		            title: '상위가맹점  조회',
		            width: '700px',
		            close: channelSearchHelpPop.close

		        });
		};
		channelSearchHelpPop.beforeClose = function (obj) {
		};
		channelSearchHelpPop.close = function (obj) {
			;
			 if(obj!=null&&obj.type!="close"){
		        	$("#parChnlNo").val(obj.chnlNo);
		        	$("#parChnlNm").val(obj.chnlNm);
		        	parChnlNoTemp = obj.chnlNo
		        	$("#parRid").val(obj.rid);

		     }else{
		    	 $("#parChnlNo").val(parChnlNoTemp);
		     }


		    channelSearchHelpPop.beforeClose(obj);
	        channelSearchHelpPopupContainer._destroy();
		 };
		 channelSearchHelpPop.popup();
}

function numberFormatter() {
    var numFormatVal = $("#hyndCardApdAcuRate").val();
    $("#hyndCardApdAcuRate").ifvFloatOnly('2');
    $('#hyndCardApdAcuRate').blur();
}

//1000단위 정규식
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    //소수점 제거할시에는 Math.round(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 사용하면됩니다.
}

</script>

<script id="pointContTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>
<script id="mbrbsStatusCd2Temp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>
<script id="trdareTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>
<script id="plotgNfpyTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>
<script id="cmpetLevelTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>
<script id="fraudDivTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- <script id="stnPointAplyMethTemp" type="text/x-jquery-tmpl"> -->
<%-- <option value="${'${'}codeName}">${'${'}markName}</option> --%>
<!-- </script> -->

<script id="lowMbrbsCretDivNmTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page_btn_area" id="headForm">
 	<div class="col-xs-7">
 	</div>
 	<div class="col-xs-5 searchbtn_r">
 		<ifvm:inputNew type="button" btnType="save" text="L00125" id="chnlAddInfoBtnSave"  btnFunc="chnlAddInfoActionSave" />
 	</div>
</div>

<div class="form-horizontal underline top_well" id="chnlAddInfoForm" >
	<div class="half_wrap top_well">
		<div class="half_content half_left">
		  	<div class="row qt_border">
			  	<%-- 유통구분 --%>
				<ifvm:inputNew type="select" id="ctg" maxLength="50" dto="ctg" label="L02286" labelClass="2" conClass="4" />
				<%-- 영업시간 --%>
				<ifvm:inputNew type="time" id="chnlOpenTime" names="chnlOpenTime" dto="chnlOpenTime" label="L02287" labelClass="2" conClass="2" />
		        <div class="col-xs-1 swung_dash">~</div>
		        <ifvm:inputNew type="time" id="chnlCloseTime" names="chnlCloseTime" dto="chnlCloseTime" labelClass="0" conClass="2" />
		  	</div>
		 	<div class="row qt_border">
				<%-- 매장운영상태 --%>
		    	<ifvm:inputNew type="select" id="chnlActStatCd" maxLength="50" dto="chnlActStatCd" label="L02335" labelClass="2" conClass="4" />
		    	<%-- 평수 --%>
		    	<ifvm:inputNew type="select" id="chnlPyeong" maxLength="50" dto="chnlPyeong" label="L02291" labelClass="2" conClass="4" />
		 	</div>
		 	<div class="row qt_border">
		    	<%-- 위도 / 경도 --%>
		        <ifvm:inputNew type="text" id="latitude" maxLength="23" dto="latitude" label="L02279" labelClass="2" conClass="3" readonly="true"/>
		        <ifvm:inputNew type="text" id="longitude" maxLength="23" dto="longitude" labelClass="0" conClass="3" readonly="true"/>
		        <div class="control_content col-xs-3">
					<button class="btn btn-sm" id="viewDaumMap"><spring:message code="L02280"/></button>
				</div>
		 	</div>
		 	<%--
		 	<div class="row qt_border">
		 		<ifvm:inputNew type="select" id="mbrbsStatusCd2" maxLength="50"  dto="mbrbsStatusCd2"    label="L00627" labelClass="3" conClass="3" />
				<ifvm:inputNew type="select" id="pointContType" maxLength="50"  dto="pointContType" label="L00626" labelClass="3" conClass="3" />
		 	</div>
			<div class="row  qt_border">
				<ifvm:inputNew type="search" id="acrlRuleCd|acrlRuleCdSearch" names="acrlRuleCd" hidId="ridAcrlRule" hidDto="ridAcrlRule" dto="acrlRuleCd" disabled="false"
					btnFunc="acrlStandardSearchHelpBtn" searchBlurEvent="acrlStandardSearchHelpBlur" searchEnterEvent="acrlStandardSearchHelpEnter" label="L00624"  labelClass="3" conClass="3" />
				<ifvm:inputNew type="text" id="acrlRuleTypeCd" maxLength="50"  dto="acrlRuleTypeCd"    disabled="true"  labelClass="3" conClass="6" />
			</div>
			<div class="row  qt_border">
				<ifvm:inputNew type="search" id="adjRuleCd|adjRuleCdSearch" names="adjRuleCd" hidId="ridAdjRule" hidDto="ridAdjRule" dto="adjRuleCd" disabled="false"
				  	btnFunc="adjStandardSearchHelpBtn" searchBlurEvent="adjStandardSearchHelpBlur" searchEnterEvent="adjStandardSearchHelpEnter" label="L00622"  labelClass="3" conClass="3" />
				<ifvm:inputNew type="text" id="adjRuleTypeCd" maxLength="50"  dto="adjRuleTypeCd"   disabled="true"  labelClass="3" conClass="6" />
			</div>
			<div class="row  qt_border">
				<ifvm:inputNew type="text" id="hyndCardApdAcuRate" maxLength="50"  dto="hyndCardApdAcuRate"    label="L00752" labelClass="3" conClass="3" />
				<ifvm:inputNew type="singleCheckbox" id="runOnlineYn" label="L00751" values="Y" labelClass="3" conClass="3" checked="false" />
			</div>
		 	<div class="row  qt_border">
		 		<ifvm:inputNew type="text" id="rmark" maxLength="50"  dto="rmark"    label="M00600" labelClass="3" conClass="9" />
		 	</div>
			 --%>
		</div>
		<div class="half_content half_right">
		  	<div class="row qt_border">
		  		<%-- 익일운영여부 --%>
		        <ifvm:inputNew type="singleCheckbox" id="nextDayOperYn" dto="nextDayOperYn" label="L02342" values="Y" labelClass="4" conClass="1" checked="false" disabled="false"/>
		    	<%-- 주차가능여부 --%>
		        <ifvm:inputNew type="singleCheckbox" id="chnlParkingYn" dto="chnlParkingYn" label="L02343" values="Y" labelClass="3" conClass="1" checked="false" disabled="false"/>
		  	</div>
		  	<div class="row qt_border">
				<%-- 포토카드자판기설치여부 --%>
				<ifvm:inputNew type="singleCheckbox" id="chnlPhotocardYn" dto="chnlPhotocardYn" label="L02340" values="Y" labelClass="4" conClass="1" checked="false" disabled="false"/>
			 	<%-- 주차메모 (label) --%>
       			<label class="col-xs-3 control-label">주차메모</label>
		  	</div>
		  	<div class="row qt_border">
			 	<%-- 네임스티커자판기설치여부 --%>
       			<ifvm:inputNew type="singleCheckbox" id="chnlNamestickerYn" dto="chnlNamestickerYn" label="L02341" values="Y" labelClass="4" conClass="1" checked="false" disabled="false"/>
       			<%-- 주차메모 --%>
       			<label class="col-xs-2 control-label"></label>
       			<ifvm:inputNew type="textarea" id="chnlShpPardes" dto="chnlShpPardes" label="" nuc="true" labelClass="0" conClass="4" rows="2" maxLength="30"/>
       			
		  	</div>
		  	<div class="row qt_border">
				<%-- 포토스티커여부 --%>
				<ifvm:inputNew type="singleCheckbox" id="chnlPtstkYn" dto="chnlPtstkYn" label="포토스티커여부" nuc="true" values="Y" labelClass="4" conClass="2" checked="false" disabled="false"/>
		  	</div>
		</div>
	</div>
</div>
<%--
<div>
	<div class="half_content half_right">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span>분석정보</span>
			</div>
		</div>
		<div class="row  qt_border">
			<ifvm:inputNew type="select" id="trdare" maxLength="50"  dto="trdare"    label="L00757" labelClass="3" conClass="3" />
			<ifvm:inputNew type="select" id="plotgNfpy" maxLength="50"  dto="plotgNfpy"    label="L00758" labelClass="3" conClass="3" />
		</div>
		<div class="row  qt_border">
		 	<ifvm:inputNew type="select" id="cmpetLevel" maxLength="50"  dto="cmpetLevel"    label="L00759" labelClass="3" conClass="3" />
		</div>
		<div class="row  qt_border">
		 	<ifvm:inputNew type="singleCheckbox" id="indvTaxiUnionStn" label="L00760" values="Y" labelClass="3" conClass="1" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="sinkYn" label="L00764" values="Y" labelClass="3" conClass="1" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="airgunYn" label="L00771" values="Y" labelClass="3" conClass="1" checked="false" />
		</div>
		<div class="row  qt_border">
		 	<ifvm:inputNew type="singleCheckbox" id="autoCwYn" label="L00761" values="Y" labelClass="3" conClass="1" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="vacumYn" label="L00765" values="Y" labelClass="3" conClass="1" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="selfWashYn" label="L00768" values="Y" labelClass="3" conClass="1" checked="false" />
		</div>
		<div class="row  qt_border">
		 	<ifvm:inputNew type="singleCheckbox" id="matwashYn" label="L00762" values="Y" labelClass="3" conClass="1" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="foyerYn" label="L00766" values="Y" labelClass="3" conClass="1" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="tierPYn" label="L00769" values="Y" labelClass="3" conClass="1" checked="false" />
		</div>
		<div class="row  qt_border">
			<ifvm:inputNew type="singleCheckbox" id="factoryYn" label="L00763" values="Y" labelClass="3" conClass="1" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="poslYn" label="L00767" values="Y" labelClass="3" conClass="1" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="vendingYn" label="L00770" values="Y" labelClass="3" conClass="1" checked="false" />
		</div>
   	</div>
</div>
<div class="half_wrap top_well">
	<div class="half_content half_left">
		<div class="page_btn_area" id="headForm">
			<div class="col-xs-12">
				<span>제휴 채널 정보</span>
			</div>
		</div>
		<div class="row  qt_border">
			<ifvm:inputNew type="singleCheckbox" id="parMbrbsYn" label="L00619" values="Y" labelClass="3" conClass="3" checked="false" disabled="false"/>
			<ifvm:inputNew type="select" id="lowMbrbsCretDivNm"	   maxLength="50"  dto="lowMbrbsCretDivNm"    label="L00779" labelClass="3" conClass="3" disabled="false" />
		</div>
	 	<div class="row  qt_border">
	 		<ifvm:inputNew type="search" id="parChnlNo|parChnlNoSearch" names="parChnlNo" hidId="parRid" hidDto="parRid" dto="parChnlNo" disabled="false"
		     btnFunc="parChnlSearchHelpBtn" searchBlurEvent="parChnlSearchHelpBlur" searchEnterEvent="parChnlSearchHelpEnter" label="L00780"  labelClass="3" conClass="3" />
			<ifvm:inputNew type="text" id="parChnlNm" maxLength="50"  dto="parChnlNm"    labelClass="0" conClass="6"  disabled="false" />
	 	</div>
	 	<div class="row  qt_border">
	 		<ifvm:inputNew type="text" id="lowMbrbsCd" maxLength="50"  dto="lowMbrbsCd"    label="L00781" labelClass="3" conClass="3" disabled="false"/>
	 		<ifvm:inputNew type="singleCheckbox" id="parRunOnlineYn" label="L00782" values="Y" labelClass="3" conClass="3" checked="false" disabled="false"/>
	 	</div>
	</div>
</div>
<div class="half_content half_right">
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span>부정채널 정보</span>
		</div>
	</div>
	<div class="row  qt_border">
		 <ifvm:inputNew type="select" id="fraudDiv" maxLength="50"  dto="fraudDiv"    label="L00776" labelClass="3" conClass="9" />
	</div>
	<div class="row  qt_border">
		 <ifvm:inputNew type="select" id="fraudMbrbsActnDiv" maxLength="50"  dto="fraudMbrbsActnDiv"    label="L00777" labelClass="3" conClass="9" />
	</div>
	<div class="row  qt_border">
		 <ifvm:inputNew type="textarea" id="fraudMbrbsActnDesc"  dto="fraudMbrbsActnDesc"    label="L00778" labelClass="3" conClass="9" />
	</div>
</div>
<div class="half_wrap top_well">
	<div class="half_content half_left">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span>채널  포인트 운영정보</span>
			</div>
		</div>
		<div class="row  qt_border">
		    <ifvm:inputNew type="singleCheckbox" id="pointConvYn" label="L00772" values="Y" labelClass="3" conClass="3" checked="false" disabled="false"/>
		 	<ifvm:inputNew type="select" id="stnPointAplyMeth" maxLength="50"  dto="stnPointAplyMeth"  disabled="false"  label="L00773" labelClass="3" conClass="3" />
		</div>
		<div class="row  qt_border">
			<ifvm:inputNew type="text" id="stnPointAplyUnit" maxLength="50"  dto="stnPointAplyUnit"   disabled="false"  label="L00774" labelClass="3" conClass="3" />
			<ifvm:inputNew type="text" id="stnPointBaseAcuPoint" maxLength="50"  dto="stnPointBaseAcuPoint"   disabled="false"  label="L00775" labelClass="3" conClass="3" />
		</div>
 	</div>
</div>
 	<ifvm:inputNew type="hidden" id="rid" maxLength="50"  dto="rid"    labelClass="0" conClass="6"   />
 	<ifvm:inputNew type="hidden" id="ouTypeCd" maxLength="50"  dto="ouTypeCd"    labelClass="0" conClass="6"   />
 --%>

<div id="chnlAddInfoTabArea">
 	<div class="btn-group btn-group-justified" id="tabType">
 	</div>
</div>

<script>

$('#chnlAddInfoTabArea .btn.btn-default.btn-tab').on('click', function() {
 	chnlAddInfoChangeContent($(this).attr('id'), 'chnlAddInfoTabContent');
});

function chnlAddInfoChangeContent(type, tab) {
 	var cUrl;
 	switch(type) {
	default :
  		break;
	}
 	$.ifvCachedHtml( cUrl ).done( function(script, textStatus){
  		var cTab = $("#" + tab);
  		$('#chnlAddInfoTabContent').empty();
  		$('#chnlAddInfoTabArea .btn.btn-default.btn-tab').removeClass('active');
  		$('#' + type).addClass('active');
  		cTab.empty();
  		cTab.html('');
  		cTab.append( script );
  		var fileName = cUrl.split('/').pop();
  		if( window[fileName + '_init'] != null ) window[fileName + '_init']();
	});
}

</script>

<div id="chnlAddInfoPopupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="channelSearchHelpPopupContainer" class="popup_container"></div><!-- 팝업 -->
