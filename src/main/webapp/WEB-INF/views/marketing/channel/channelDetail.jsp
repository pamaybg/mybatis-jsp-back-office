<%@page trimDirectiveWhitespaces="true" %>
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
.top_well{margin-bottom:0; border-bottom:0;}
</style>

<script>

var imageFileLimitGrid;
var channelCapacityGrid;
var chid = '<%= cleanXss(request.getParameter("id")) %>';
var detail = false;  //수정 페이지 체크 true일 시 수정, false일 시 신규 생성 페이지
var valcheck = false;
var pageCheck = false; //페이지에서 아이디 값 체크
var typeCheck = false; //같은 실행 채널의 ID 값을 담는 변수
var sysdate = new Date();
var selectChilRow;
var passChk = false;

var chnlEtcInfoTab;
var selectRow;

//달력
function setChannelCalendar() {
	var startDate = $(".start_date").find('input');
	var endDate = $(".end_date").find('input');
	startDate.val($.ifvGetTodayDate());

	startDate.ifvDateChecker({
		maxDate : endDate
	});
	endDate.ifvDateChecker({
		minDate : startDate
	});

	//발송가능시간 설정
    $('#sendableStartTime').timepicker({
        showMeridian: false,
        defaultTime: '00:00:00',
        showSeconds: true,
        minuteStep: 5,
        secondStep: 1,
    });
    $('#sendableEndTime').timepicker({
        showMeridian: false,
        defaultTime: '23:59:59',
        showSeconds: true,
        minuteStep: 5,
        secondStep: 1,
    });
}

function checkIpForm() {
	var text = $("#connectionIP").val();
	//var filter = /[0-9]/;
	var ipfilter = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;

	if(text != ""){
		if (ipfilter.test(text) == true){ return true; }
		else{ alert('<spring:message code="M00511"/>'); return false;}
	}
	else{
		return true;
	}
}

function deleteImgOptionList(fromTbl, toTbl) {
	var active = 0;
	var checkedList = imageFileLimitGrid.getCheckedList();
	var listFlowIdList = [];
	if(checkedList.length != 0){
		for( var i = 0; i < checkedList.length; i++ ){
			listFlowIdList.push( checkedList[i].id );
		}
		$.ifvSyncPostJSON('<ifvm:action name="removeImgOption"/>',{
			listChannelFlowId : listFlowIdList
		},function(result) {
			alert('<spring:message code="M00012"/>');
			imageFileLimitGrid.delCheckedRow();
		});
	}
	else{
		alert('<spring:message code="M00285"/>');
	}
}

//상세 페이지인지 체크
function idCheck() {
	if (chid != "null") {
		var secretNmDis = document.getElementById('secretNm');
		secretNmDis.disabled = true;
		
		//정보 세팅
		$.ifvSyncPostJSON('<ifvm:action name="DetailgetChannel"/>', {
			id : chid
		}, function(result) {
			selectRow = chid;

				$("#channelName").val(result.chnlName);
				$("#runChannel").val(result.chnlTypeCd);
				$("#commStatus").val(result.commStatus);
				$("#channelStartDate").val(result.applyStrDate);
				$("#channelEndDate").val(result.applyEndDate);
			    $("#companyName").val(result.ptraccntId);
			    $("#companyName").text(result.ptraccntNm);
				$("#connectionID").val(result.conId);
				$("#accessPassword").val(result.conPw);
				$("#connectionIP").val(result.conIp);
				$("#connectionPORT").val(result.conPort);
			    $("#connectionURLAPI").val(result.conUrl);
				$("#described").val(result.description);
				$("#registrant").val(result.createBy);
				$("#registrationDate").val(result.createDate);
				$("#modifiers").val(result.modifyBy);
				$("#changeDate").val(result.modifyDate);
				$("#cost").val(result.ucost);
				$("#dbType").val(result.dbtype);
				$("#chnlguide").val(result.chnlGuide);
				$("#secretNm").val(result.secretNm);
                $("#sendableStartTime").val(getFormatSendableTime(true, result.sendableStartTime));
                $("#sendableEndTime").val(getFormatSendableTime(false, result.sendableEndTime));
				$("#runChannel").attr('disabled', 'true');

				if (result.chnlTypeCd == 'PUSH') {
					$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
						groupCode : 'APP_KIND'
						, enableNA : true
					}, function(result) {
						var data = result.rows[0];
						$('#applicationId').val(data.attrib01);
						$('#reqApplicationToken').val(data.attrib03);
						$('#reqApplicationId').val(data.attrib02);
					});
				}
		});
		//수정 권한 트루
		detail = true;
		pageCheck = true;
	}
}

function getFormatSendableTime(startFlag, value) {
    var rtnValue;
    if ($.fn.ifvmIsEmpty(value)) {
        if (startFlag == true)  rtnValue = '00:00:00';
        else                    rtnValue = '23:59:59';
    }
    else if (value.length == 6) {
        rtnValue = value.substr(0, 2) + ':' + value.substr(2, 2) + ':' + value.substr(4, 2);
    }
    else if (value.length == 8) {
        rtnValue = value;
    }
    return rtnValue;
}


//저장 버튼클릭 시 동작
function actionChannel() {
	isValid = validation.confirm();
	var regExp = /^[A-Za-z0-9/_+=.@-]+]*$/;
	if (!regExp.test($("#secretNm").val())) {
		$.ifvCallValidationBox($("#secretNm"), '서비스명은 영숫자와 /_+=.@- 문자만 포함해야 합니다.');
		return false;
	}
	if(isValid){
		if(checkIpForm()){
			//상세 페이지일 시 수정 작업 동작
			if(detail) {
				if (typeCheck){ alert('<spring:message code="M00509"/>'); }
				$.ifvSyncPostJSON('<ifvm:action name="editChannel"/>',{
					       id : chid
					     , chnlName : $("#channelName").val()
						 , applyStrDate : $("#channelStartDate").val()
						 , applyEndDate : $("#channelEndDate").val()
						 , commStatus : $("#commStatus").val()
						 , ptraccntId : $("#companyName").text()
						 , chnlTypeCd : $("#runChannel").val()
						 , conId : $("#connectionID").val()
						 , conPw   : $("#accessPassword").val()
						 , conIp : $("#connectionIP").val()
						 , conPort : $("#connectionPORT").val()
						 , conUrl : $("#connectionURLAPI").val()
						 , description : $("#described").val()
						 , ucost : $("#cost").val()
                         , dbtype : $("#dbType").val()
                         , sendableStartTime : $("#sendableStartTime").val().replaceAll(':', '')
                         , sendableEndTime : $("#sendableEndTime").val().replaceAll(':', '')
                         , chnlGuide : $("#chnlguide").val()
                         , secretNm : $("#secretNm").val()
						 , passwordChk : passChk
				}, function(result) {

				    //기타 추가정보 수정
				    saveEtcInfo();

				    alert('<spring:message code="M00429"/>');
				    qtjs.href('<ifvm:url name="MKTChannelList"/>');
				});
			}
			//상세 페이지가 아닐 시 insert 동작
			else {
				//같은 실행 채널이 있는지 검사
				$.ifvSyncPostJSON('<ifvm:action name="getChannelCheck"/>', {
					      chnlTypeCd : $("#runChannel").val()
				}, function(result) {
					if(result.id != null) {
						chid = result.id
						typeCheck = true;
						detail = true;

						if(confirm('<spring:message code="M00451"/>') == true) {
							 $(this).parent().click();
							 actionChannel();
					     } else {
					    	 idCheck();
					     }
					}
				});
				//같은 실행 채널이 없을 시
				if(typeCheck == false) {
					$.ifvSyncPostJSON('<ifvm:action name="setChannel"/>', {
						   chnlName : $("#channelName").val()
						 , applyStrDate : $("#channelStartDate").val()
						 , applyEndDate : $("#channelEndDate").val()
						 , commStatus : $("#commStatus").val()
						 , ptraccntId : $("#companyName").text()
						 , chnlTypeCd : $("#runChannel").val()
						 , conId : $("#connectionID").val()
						 , conPw   : $("#accessPassword").val()
						 , conIp : $("#connectionIP").val()
						 , conPort : $("#connectionPORT").val()
						 , conUrl : $("#connectionURLAPI").val()
						 , description : $("#described").val()
						 , ucost : $("#cost").val()
						 , dbtype : $("#dbType").val()
                         , sendableStartTime : $("#sendableStartTime").val().replaceAll(':', '')
                         , sendableEndTime : $("#sendableEndTime").val().replaceAll(':', '')
						 , chnlGuide : $("#chnlguide").val()
						 , secretNm : $("#secretNm").val()
                         , passwordChk : passChk
					}, function(result) {
					    //기타 추가정보 수정
					    saveEtcInfo();

						alert('<spring:message code="M00430"/>');
						qtjs.href('<ifvm:url name="MKTChannelDetail"/>?id='+  result.message);
					});
				}
			}
		}
	}

}

/**
 * 공통코드 테이블에 저장해 놓은 기타 정보 수정
 */
function saveEtcInfo() {
    if ($("#runChannel").val() == 'PUSH') {
        $.ifvSyncPostJSON('<ifvm:action name="editCommCodeExCodeAttribProperty"/>', {
              groupCode: 'APP_KIND'
            , codeName: 'E1'
            , attrib01: $('#applicationId').val()
            , attrib02: $('#reqApplicationId').val()
            , attrib03: $('#reqApplicationToken').val()
        }, function(result) {

        });
    }
}

//용량 부분 콤마 생성
// function comma(cellValue, options, rowdata) {
// 	var str ="";
// 	if(typeof(rowdata.maxVol) != "undefined"){
// 		str = String(rowdata.maxVol);
// 	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
// 	}
// 	else return str;
// }

// //이미지, 파일 제한 그리드
// function imageFileLimitGrid(chid){
// 	var jqGridOption = {
// 		onSelectCell : function (data) {
// 				selectChilRow = data.id;
// 		},
// 		serializeGridData : function( data ){
// 				data.mktChlId = chid
// 			return data;
// 		},
// 	    url:'<ifvm:action name="getImgOption"/>',
// 	    colNames:['<spring:message code="M00478"/>',
// 	              '<spring:message code="M00490"/>',
// 	              '<spring:message code="M00491"/>',
// 	              '<spring:message code="M00492"/>',
// 	              '<spring:message code="M00493"/>',
// 	              '<spring:message code="M00494"/>',
// 	              '<spring:message code="M00473"/>',
// 	              '<spring:message code="M00495"/>',
// 	              'id'
// 	              ],
// 	    colModel:[
// 	        {name:'seq',          index:'seq',             resizable : false},
// 	        {name:'upldType',     index:'upld_type',       resizable : false},
// 	        {name:'upldEtsionCd', index:'upld_etsion_cd',  resizable : false},
// 	        {name:'maxVol',       index:'max_vol',         resizable : false,formatter: comma,align:"right"},
// 	        {name:'imgResolW',    index:'img_resol_w',     resizable : false},
// 	        {name:'imgResolH',    index:'img_resol_h',     resizable : false},
// 	        {name:'modifyBy',     index:'c2.name',         resizable : false},
// 	        {name:'mDate',        index:'mcc.modify_date', resizable : false},
// 	        {name:'id',           index:'id',              resizable : false, hidden : true, searchable : false}
// 	    ],
// 	    radio : true,
// 	    sortname: 'seq',
// 		sortorder: "asc",
// 	    tempId : 'ifvGridOriginTemplete'
// 	    ,emptyRows : true
// 	};
// 	imageFileLimitGrid = $("#imageFileLimitGrid").ifvGrid({ jqGridOption : jqGridOption });

// }

// //채널별 용량 그리드
// function CapacityGrid(chid){
// 	var jqGridOption = {
// 		onSelectCell : function (data) {
// 			selectChilRow = data.id;
// 		},
// 		serializeGridData : function( data ){
// 				data.mktChlId = chid
// 			return data;
// 		},
// 	    url:'<ifvm:action name="getChannelStore"/>',
// 	    colNames:['<spring:message code="M00478"/>',
// 	              '<spring:message code="M00475"/>',
// 	              '<spring:message code="M00476"/>',
// 	              '<spring:message code="M00477"/>',
// 	              '<spring:message code="M00472"/>',
// 	              '<spring:message code="M00473"/>',
// 	              '<spring:message code="M00474"/>'],
// 	    colModel:[
// 	        {name:'seq',index:'mc.seq', resizable : false},
// 	        {name:'periodType',index:'c1.mark_name', resizable : false},
// 	        {name:'maxVol',index:'mc.max_vol', resizable : false,formatter: comma,align:"right"},
// 	        {name:'reserveVol',index:'mc.RSRV_VOL', resizable : false},
// 	        {name:'description',index:'mc.description', resizable : false},
// 	        {name:'modifyBy',index:'mc.modify_by', resizable : false},
// 	        {name:'modifyDate',index:'mc.modify_date', resizable : false}
// 	    ],
// 	    autowidth:true,
// 	    radio : true,
// 	    sortname: 'mc.seq',
// 		sortorder: "desc",
// 	    tempId : 'ifvGridOriginTemplete',
// 	    emptyRows : true
// 	};
// 	channelCapacityGrid = $("#channelCapacityGrid").ifvGrid({ jqGridOption : jqGridOption });
// }

// //소셜부가정보 그리드
// function snsAdditionalInfoGrid(chid){

// 	var jqGridOption = {
// 		onSelectCell : function (data) {
// 				selectChilRow = data.id;
// 		},
// 		serializeGridData : function( data ){
// 			data.mktChlId = chid
// 		return data;
// 		},
// 	    url:'<ifvm:action name="getSnsAdtnInfoList"/>',
// 	    colNames:['<spring:message code="M02135"/>',
// 	              '<spring:message code="M02136"/>',
// 	              '<spring:message code="M02137"/>',
// 	              '<spring:message code="M02138"/>',
// 	              '<spring:message code="M02185"/>',
// 	              'id'
// 	              ],
// 	    colModel:[
// 	        {name:'snsPageId',		index:'mcsai.sns_page_id', 		resizable : false},
// 	        {name:'appId',			index:'mcsai.app_id', 			resizable : false},
// 	        {name:'appSecurCode',	index:'mcsai.app_secur_code', 	resizable : false},
// 	        {name:'snsPageDesc',	index:'mcsai.sns_page_desc', 	resizable : false},
// 	        {name:'acesExpDt',		index:'mcsai.aces_token_dt', 	resizable : false},
// 	        {name:'id', 			index:'mcsai.id', 				resizable : false,  hidden : true,  searchable : false}
// 	    ],
// 	    radio : true,
// 	    sortname: 'mcsai.id',
// 		sortorder: "ASC",
// 	    tempId : 'ifvGridOriginTemplete',
// 	    emptyRows : true
// 	};
// 	snsAdditionalInfoGrid = $("#snsAdditionalInfoGrid").ifvGrid({ jqGridOption : jqGridOption });

// }

/* 팝업 닫기 */
function channelPopupClose(){
	channelPopCon._destroy();
}

//소셜부가정보 관리 팝업 닫기
function snsAdtnInfoPopupClose(){
	snsAdtnInfoPopCon._destroy();
}

function additionalInfoNew(){

	$('#additionalInfoNewBtn').on('click', function(){
		if(pageCheck){
			$("#snsAdtnInfoPopCon").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="snsAdtnInfoPop"/>?id='+ chid,
		        contentType: "ajax",
		        title: '<spring:message code="M02139"/>',
		        width: 400,
		        open : 'dialogHeightSetting',
		        close : 'snsAdtnInfoPopupClose'
		    });
		}
		else{
			alert('<spring:message code="M00498"/>');
		}
	});
}

function additionalInfoModifyBtn(){
	$('#additionalInfoModifyBtn').on('click', function(){
		if(snsAdditionalInfoGrid.opt.gridControl.getSelectedRecords()[0].id != ""){
			if(chid == null){
				alert('<spring:message code="M00498"/>');
			}
			else if(selectChilRow == null){
				alert('<spring:message code="M00499"/>')
			}
			else{
				$("#snsAdtnInfoPopCon").ifvsfPopup({
					enableModal : true,
			        enableResize: false,
			        contentUrl: '<ifvm:url name="snsAdtnInfoPop"/>?id='+ chid + '&chilId=' +  selectChilRow,
			        contentType: "ajax",
			        title: '<spring:message code="M00487"/>',
			        width: 400,
			        open : 'dialogHeightSetting',
			        close : 'snsAdtnInfoPopupClose'
			    });
			}
		}
	});
}

function additionalInfoDelBtn(){
	$("#additionalInfoDelBtn").on('click', function(){
		if(chid == null){
			alert('<spring:message code="M00498"/>');
		}
		else if(selectChilRow == null){
			alert('<spring:message code="M00499"/>')
		}
		else deleteAdditionalInfoDelBtnList();
	});
}

function deleteAdditionalInfoDelBtnList(fromTbl, toTbl) {
	var active = 0;
	var checkedList = snsAdditionalInfoGrid.opt.gridControl.getSelectedRecords();
	var listFlowIdList = [];
	if(checkedList.length != 0){
		for( var i = 0; i < checkedList.length; i++ ){
			listFlowIdList.push( checkedList[i].id );
		}
		if(confirm('<spring:message code="M01020"/>') == true){
			$.ifvSyncPostJSON('<ifvm:action name="deleteSnsAdtnInfo"/>',{
				listChannelFlowId : listFlowIdList
			},function(result) {
				alert('<spring:message code="M00622"/>');
				snsAdditionalInfoGrid.delCheckedRow();
			});
		}
	}
	else{
		alert('<spring:message code="M00285"/>');
	}
}

/**
 * 탭 설정
 */
function initTab() {

    chnlEtcInfoTab = $('#chnlEtcInfoTabDiv').DrawTab({
        item: [
            {label: '<spring:message code="M00488"/>', href: '/marketing/channel/include/imageFileLimitTabNew'},
            {label: '<spring:message code="M00489"/>', href: '/marketing/channel/include/channelCapacityTabNew'},
            {label: '<spring:message code="M02134"/>', href: '/marketing/channel/include/snsAdditionalInfoTab'},
        ]
    });
}

function initSetting() {

	$.ifvSyncPostJSON('<ifvm:action name="getMember"/>', {
	}, function(result) {
		if ($.fn.ifvmIsNotEmpty(result)) {
			$("#registrant").val(result.empNm);
			$("#modifiers").val(result.empNm);
		}
	});

	//실행 채널
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_CAM_CHNL_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#runChanneltemp").tmpl(result.rows);
		$("#runChannel").append(temp);
	});

	//날짜입력
	$.ifvSyncPostJSON('<ifvm:action name="getDateInfo"/>',{
	},function(result) {
		$(".end_date").find('input').val(result.message);
	});

	//상태 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'COMM_STATUS'
		, enableNA : true
	},function(result) {
		var temp = $("#commStatustemp").tmpl(result.rows);
		$("#commStatus").append(temp);
	});

	 //DB 유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'CHNL_CON_DB_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#dbtypetemp").tmpl(result.rows);
		$("#dbType").append(temp);
	});
	$("#commStatus").val(1);

	$("#changeDate").val(sysdate.getFullYear() + "-" + (sysdate.getMonth() + 1) + "-" + sysdate.getDate());
	$("#registrationDate").val(sysdate.getFullYear() + "-" + (sysdate.getMonth() + 1) + "-" + sysdate.getDate());

}

//목록 돌아가기
function goList() {
	qtjs.href('<ifvm:url name="MKTChannelList"/>');
}

$(document).ready(function(){


	$.ifvmLnbSetting('mktChannelListNew');

	setChannelCalendar();
	initSetting();

	initTab();
	validation = $("#dataForm").ifvValidation();

	$('#channelsavebtn').on('click', function(){
		actionChannel();
	});

	$('#accessPassword').change(function(){
		passChk = true;
	});

	$('#channelCompanyNameBtn').on('click', function(){
		$("#channelPopCon").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTChannelOrgPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00485"/>',
	        width: 600,
	        close : 'channelPopupClose'
	    });
	});

	idCheck();

	$("#runChannel").on('change', function() {
	    $('#pushEtcForm').hide();
	    if ($("#runChannel").val() == 'PUSH') {
	        $('#pushEtcForm').show();
	    }
	});

	$("#runChannel").change();
});

</script>

<script id="commStatustemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="runChanneltemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dbtypetemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
	<h1>
		<spring:message code="M00479"/> &gt;  <spring:message code="M00274"/>
	</h1>
</div>

<!-- 필수 영역 -->
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00327"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="channelsavebtn" objCode="channelsavebtn_OBJ">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00280"/>
		</button>
		<ifvm:inputNew type="button" id="goMktChannelListNew" btnFunc="goList" text="L00824" objCode="goMktChannelListNew_OBJ"/>
	</div>
</div>
<div class="well form-horizontal underline top_well" id="dataForm" >
	<div class="row">

        <%-- 실행채널명 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00462"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" required="true" id="channelName" maxLength="30"/>
		</div>

        <%-- 채널유형 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00463"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" required="true" id="runChannel"/>
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-1"></div>
		<div class="col-xs-10 control_content detail_row">
			<span class="detail_txt detail_row"><spring:message code="M00484"/></span>
		</div>
	</div>
	<div class="row qt_border">

        <%-- 적용일자 --%>
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00329"/></label>
		<div class="col-xs-4 control_content">
			<div class="col-xs-6 cal_frt start_date" >
				<ifvm:input type="date" required="true" id="channelStartDate"/>
			</div>
			<div class="col-xs-1 swung_dash">~</div>
			<div class="col-xs-6 cal_scd end_date" >
				<ifvm:input type="date" required="true" id="channelEndDate"/>
			</div>
		</div>

        <%-- 상태 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00317"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" required="true" id="commStatus"/>
		</div>
	</div>
	<div class="row qt_border">
        <ifvm:inputNew type="timeTerm" startDto="sendableStartTime" endDto="sendableEndTime" startId="sendableStartTime" endId="sendableEndTime" required="true" label="M02465" labelClass="1" conClass="4"/> 
		<!-- 단가(원) -->
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00507"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" required="true" id="cost" valiItem="number" maxLength="15" />
		</div>
	</div>
    <div class="row qt_border">

        <%-- 업체명 --%>
        <label class="col-xs-1 control-label"><spring:message code="M00465"/></label>
        <div class="col-xs-4 control_content">
            <div class="input-group">
                <ifvm:input type="text" disabled="true" id="companyName"/>
                <span class="input-group-addon" id="channelCompanyNameBtn" objCode="channelCompanyNameBtn_OBJ">
                    <a><i class="fa fa-search"></i></a>
                </span>
            </div>
        </div>
    </div>
</div>

<!-- 선택 영역 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span><spring:message code="M00330"/></span>
		</div>
	</div>
	<div class="well form-horizontal underline" id="selectForm" >
        <div class="row qt_border">

			<!-- DB유형 -->
			<label class="col-xs-1 control-label"><spring:message code="M00508"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" id="dbType"/>
			</div>
			<!-- 서비스이름 -->
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01440"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="secretNm" required="true" maxLength="50"/>
			</div>
		</div>
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M00468"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="connectionID" maxLength="30"/>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M00481"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="password" id="accessPassword" maxLength="30"/>
			</div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M00469"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="connectionIP" maxLength="15"/>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M00470"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="connectionPORT" maxLength="10"/>
			</div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M00471"/></label>
			<div class="col-xs-10 control_content">
				<ifvm:input type="text" id="connectionURLAPI" maxLength="100"/>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M00472"/></label>
			<div class="col-xs-10 control_content">
				<ifvm:input type="textarea" className="text_description" id="described" maxLength="200"/>
			</div>
		</div>
		
		<%-- 작성 가이드 --%>
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M00400"/></label>
			<div class="col-xs-10 control_content">
				<ifvm:input type="textarea" className="text_chnlguide" id="chnlguide" maxLength="2000"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M00473"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="registrant"/>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M00474"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" className="text-center" id="registrationDate"/>
			</div>
		</div>
		<div class="row">

			<%-- 변경자 --%>
			<label class="col-xs-1 control-label"><spring:message code="M00482"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="modifiers"/>
			</div>

			<%-- 변경일시 --%>
			<label class="col-xs-2 control-label"><spring:message code="M00483"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" className="text-center" id="changeDate"/>
			</div>
		</div>
	</div>
</div>



<!-- 선택 영역 -->
<div>
	<div class="well form-horizontal underline" id="pushEtcForm" >
		<div class="row qt_border">

			<%-- 모바일 어플리케이션ID --%>
			<label class="col-xs-1 control-label"><spring:message code="M02734"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="applicationId"/>
			</div>

			<%-- REST API 어플리케이션ID --%>
			<label class="col-xs-2 control-label"><spring:message code="M02736"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="reqApplicationId"/>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-1 control-label">&nbsp;</label>
			<div class="col-xs-4 control_content">&nbsp;</div>

			<%-- REST API 인증토큰 --%>
			<label class="col-xs-2 control-label"><spring:message code="M02735"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="reqApplicationToken"/>
			</div>
		</div>
	</div>
</div>

<div id="chnlEtcInfoTabDiv"></div>
<%--

<div class="btn-group btn-group-justified" id="channelTab">
	<a href="#imageFileLimitArea" class="btn btn-default active" data-toggle="tab"><spring:message code="M00488"/></a>
	<a href="#channelCapacityArea" class="btn btn-default" data-toggle="tab"><spring:message code="M00489"/></a>
	<a href="#snsAdditionalInfoArea" class="btn btn-default" data-toggle="tab"><spring:message code="M02134"/></a>
</div>
<div class="tab-content">
	<!-- 이미지, 파일 제한 -->
	<div id="imageFileLimitArea" class="tab-pane fade in active">
		<div class="page_btn_area" id="">
			<div class="col-xs-7">
				<span><spring:message code="M00496"/></span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				<button class="btn btn-sm" id="imageFileNewBtn">
					<i class="fa fa-plus"></i>
					<spring:message code="M00274"/>
				</button>
				<button class="btn btn-sm" id="imageFileEditBtn">
					<spring:message code="M00283"/>
				</button>
				<button class="btn btn-sm" id="imageFileDelBtn">
					<i class="fa fa-minus"></i>
					<spring:message code="M00275"/>
				</button>
			</div>
		</div>
		<div id="imageFileLimitGrid" class="grid_bd0"></div>
	</div>
	<!-- 채널별 용량 -->
	<div id="channelCapacityArea" class="tab-pane fade">
		<div class="page_btn_area" id="channelCapacity">
			<div class="col-xs-7">
				<span><spring:message code="M00461"/></span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				<button class="btn btn-sm" id="capacityPerChannelBtn">

					<i class="fa fa-plus"></i>
					<spring:message code="M00274"/>
				</button>
				<button class="btn btn-sm" id="capacityModifyBtn">
					<spring:message code="M00283"/>
				</button>
				<button class="btn btn-sm" id="capacityDelBtn">
					<i class="fa fa-minus"></i>
					<spring:message code="M00275"/>
				</button>
			</div>
		</div>
		<div id="channelCapacityGrid" class="grid_bd0"></div>
	</div>

	<!-- 소셜부가정보 -->
	<div id="snsAdditionalInfoArea" class="tab-pane fade">
		<div class="page_btn_area" id="snsAdditionalInfo">
			<div class="col-xs-7">
				<span><spring:message code="M02134"/></span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				<button class="btn btn-sm" id="additionalInfoNewBtn">

					<i class="fa fa-plus"></i>
					<spring:message code="M00274"/>
				</button>
				<button class="btn btn-sm" id="additionalInfoModifyBtn">
					<spring:message code="M00283"/>
				</button>
				<button class="btn btn-sm" id="additionalInfoDelBtn">
					<i class="fa fa-minus"></i>
					<spring:message code="M00275"/>
				</button>
			</div>
		</div>
		<div id="snsAdditionalInfoGrid" class="grid_bd0"></div>
	</div>
</div> --%>

<div id="channelPopCon" class="popup_container"></div>
<div id="snsAdtnInfoPopCon" class="popup_container"></div>

