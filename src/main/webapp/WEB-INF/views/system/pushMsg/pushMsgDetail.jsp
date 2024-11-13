<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 이미지 업로드 -->
<%@ include file="/WEB-INF/views/layouts/default/sessionScript.jsp" %>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/common/imgUpload.js'></script>

<style>
#rvSub {display: none;}
</style>

<div class="page-title">
    <h1>
		<spring:message code="D00001" />
        &gt; <spring:message code="D00015" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span><spring:message code="D00018" /></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnSave" btnFunc="btnSaveClick" btnType="save" text="L00074" objCode="pushMsgDetailSave_OBJ"/>
			<ifvm:inputNew type="button" id="goPushMsgList" btnFunc="btnListClick" text="D00024" objCode="goPushMsgList_OBJ"/>
	    </div>
	</div>
	
	<div class="well form-horizontal" id="pushMsgForm">
		<div class="row qt_border">
			<ifvm:inputNew type="radio" id="pushLang" names="pushLang" dto="pushLang" required="true" label="M00237" labelClass="2" conClass="3" text="D00083|D00084|D00085" values="ko|en|zh" checkIndex="1"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="radio" id="pushType" names="pushType" dto="pushType" required="true" label="D00019" labelClass="2" conClass="4" text="D00020|D00021|M00391" values="rt|rv|te" checkIndex="1"/>
			<div class="col-xs-5" id="rvSub">
				<ifvm:inputNew type="date" id="pushRvDate" names="pushRvDate" dto="pushRvDate" label="D00028" labelClass="3" conClass="3"/>
				<ifvm:inputNew type="time" id="pushRvTime" names="pushRvTime" dto="pushRvTime" label="D00029" labelClass="3" conClass="3"/>
			</div>
		</div>
		<div class="row qt_border" id="pushTargetDiv">
			<ifvm:inputNew type="select" id="pushTarget" names="pushTarget" dto="pushTarget" required="true" label="D00022" labelClass="2" conClass="9" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="pushTitle" names="pushTitle" dto="pushTitle" required="true" label="D00007" labelClass="2" conClass="9" maxLength="500" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="pushContent" names="pushContent" dto="pushContent" required="true" label="D00023" labelClass="2" conClass="9" rows="5" maxLength="2000"/>
		</div>
		<div class="row qt_border">
			<!-- 이미지 업로드 -->
			<div class="row" id="imageSetting">
				<label class="col-xs-2 control-label"><spring:message code="D00010"/></label>
				<div class="col-sm-9" style="font-size:0; line-height:0;">
					<div class="picture_area" id="backImage">
					</div>
				</div> 
			</div>
		</div>
		<div id="senderWrap" class="row qt_border">
			<label class="col-xs-2 control-label">전체 대상자 수</label>
			<div id="wrap1" class="col-xs-1 control_content">
				<ifvm:input type="text" id="totalSender" disabled="true"/>
			</div>
			<label class="col-xs-2 control-label">발송 대기자 수</label>
			<div id="wrap2" class="col-xs-1 control_content">
				<ifvm:input type="text" id="waitSender" disabled="true" />
			</div>
			<label class="col-xs-2 control-label">발송 완료자 수</label>
			<div id="wrap3" class="col-xs-1 control_content">
				<ifvm:input type="text" id="completeSender" disabled="true"/>
			</div>
		</div>
		<div class="row qt_border target_select_area" style="display:none;">
			<div class="row qt_border">
				<label class="col-xs-2 control-label"><span class="asterisk">*</span>발송 대상자 선택</label>
				<div class="col-xs-4 searchbtn_r">
					<button class="btn btn-sm" onClick="javascript:clearMaskAction(parentGrid)" objCode="pushMsgDetailClearMask1_OBJ"><spring:message code="L00326"/></button>
				</div>
			</div>
			<div class="row qt_border">
				<label class="col-xs-2 control-label"></label>
				<div id="parentGrid" class="col-xs-4"></div>
				<div class="col-xs-1 move_list">
					<div style="width:50px">
						<button onClick="javascript:moveCheckedParent()" class="next_btn" objCode="pushMsgDetailMoveCheckPar_OBJ"></button>
						<button onClick="javascript:moveParent()" class="last_btn" objCode="pushMsgDetailMovePar_OBJ"></button>
						<button onClick="javascript:moveCheckedChild()" class="prev_btn" objCode="pushMsgDetailMoveCheckChild_OBJ"></button>
						<button onClick="javascript:moveChild()" class="first_btn" objCode="pushMsgDetailMoveChild_OBJ"></button>
					</div>
				</div>
				<div id="childGrid" class="col-xs-4" ></div>
			</div>
			<div class="row qt_border">
				<label class="col-xs-2 control-label"></label>
				<div class="col-xs-6">
					<div class="desc_dot detail_txt_def">한번에 최대 100명 까지만 발송 가능합니다.</div>
					<div class="desc_dot detail_txt_def">푸시 발송 불가 대상자(푸시토큰이 없는 회원)는 목록에 노출되지 않습니다.</div>
				</div>
			</div>
		</div>
		<div class="row qt_border test_result_area" style="display:none;">
			<div class="row qt_border">
				<div class="col-xs-11 searchbtn_r">
					<button class="btn btn-sm" onClick="javascript:clearMaskAction(testResultGrid)" objCode="pushMsgDetailClearMask2_OBJ"><spring:message code="L00326"/></button>
				</div>
			</div>
			<div class="row qt_border">
				<label class="col-xs-2 control-label">테스트 발송 목록</label>
				<div id="testResultGrid" class="col-xs-9"></div>
			</div>
		</div>
	</div>
</div>
<script id="logoImageTemplatePop" type="text/x-jquery-tmpl">
<div id='logoImgContainerPop${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
	<form id='logoUploadFormPop${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
		<input id="logoUploadPop${'${'}index}" type="file" name="file" data-url="<ifvm:action name="tempUpload"/>" onclick="javascript:backImage.clickEditImage(this);" title='수정'>
	</form>
	<div class="btns" id="logoPostPopPicBtns${'${'}index}">
		<a id="logoImgRotation${'${'}index}" href="javascript:;" onclick="javascript:backImage.rotationImage(this);" title='이미지 회전'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png' class="btn_delete" /></a>
		<a id="logoImgDelPop${'${'}index}" href="javascript:;" onclick="javascript:backImage.delImage(this);" title='이미지 삭제'><img src='${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png' class="btn_delete" /></a>
	</div>
	<img id='logoImgPop${'${'}index}' width="96px" height="96px" src='${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif' class="handle" />
	<div class="upload_progress_container" id="progress2${'${'}index}"></div>
</div>
</script>

<script id="selectPushTypeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>
<script>
var validation;
var updateFlag = false;
var pushMsgId = $.ifvGetParam('rid');
var parentGrid = null;
var childGrid = null;
var testResultGrid = null;
var maxRowCnt = 100;
var backImage = null;

if(pushMsgId == undefined ){
	updateFlag = false;
}
else{
	
	updateFlag = true;
}

function moveCheckedParent() {
 	var checkedParentRows = parentGrid.getCheckedGridData();
	var childRows = childGrid.getRowData();
	
	veritySelectedRowsEmpty(checkedParentRows.length);
	
	var notDuplRows = getNotDuplRows(childRows, checkedParentRows);
	addTrFunc( childGrid, notDuplRows );
	setViewChildTotalCnt();
	verifyMaxRowCntExceeded(notDuplRows.length, childRows.length);
}

function moveParent() {
 	var checkedParentRows = parentGrid.getRowData();
	var childRows = childGrid.getRowData();
	
	var notDuplRows = getNotDuplRows(childRows, checkedParentRows);
	addTrFunc( childGrid, notDuplRows );
	setViewChildTotalCnt();
	verifyMaxRowCntExceeded(notDuplRows.length, childRows.length);
}

function moveCheckedChild() {
	var checkedChildRows = childGrid.getCheckedGridData();
	
	veritySelectedRowsEmpty(checkedChildRows.length);
	
	childGrid.delCheckedRow();
	setViewChildTotalCnt();
}

function moveChild() {
	childGrid.removeAll();
	setViewChildTotalCnt();
}

function veritySelectedRowsEmpty(checkedRowCnt) {
	if (checkedRowCnt == 0) {
		alert('선택된 레코드가 없습니다.');	// spring:message code="S05458" /
		return false;
	}
	else return true;
}

function setViewChildTotalCnt() {
	$('#childGridTotal').text('전체 : ' + childGrid.getRowData().length + '건');
}

function verifyMaxRowCntExceeded(notDuplRowCnt, childRowCnt) {
	if (maxRowCnt < notDuplRowCnt + childRowCnt ) {
		alert("한번에 최대 " + maxRowCnt + "명 까지만 가능합니다.");
	}
}
	
function getNotDuplRows(targetRows, checkedRows) {
	var notDuplRows = [];
	$(checkedRows).each(function(index, checkedRow){
		var isDupl = false;
		$(targetRows).each(function(index2, targetRow){
			if(checkedRow['rid'] == targetRow['rid']) {
				isDupl = true;
			}
		});

		if (!isDupl) {
			notDuplRows.push(checkedRow);
		}
	});

	return notDuplRows;
}

function existCheckedRows(checkedRows) {
	if (checkedRows == null || checkedRows.length == 0) return false;
	else return true;
}

function addTrFunc( table, list ){
	var dataRow = table.getRowData();
	var currRowCnt = dataRow.length;

	for( var i = 0; i < list.length && currRowCnt < maxRowCnt; i++, currRowCnt++ ){	//추가 row
		table.addLocalTr(list[i]);
	}
};

function setDateAndTime() {
	var date = $('#pushRvDate');
	date.val($.ifvGetTodayDate());
	date.ifvDateChecker({});

	var time = $('#pushRvTime');
	time.timepicker({
		//기본시간설정
		defaultTime : '00:00',
		//시간표시방식
		timeFormat: 'H:i',
		//오전 오후 표시
		showMeridian : false
	});
}


$(document).ready(function() {
	$("#senderWrap").hide();
	$.ifvmLnbSetting('pushMsgList');
	
	//이미지 업로드
	backImage = backImageSetting(pushMsgId, "backImage");
	
	setDateAndTime();
	getCommonCode();
	
	var textObj = [
	           	{text : '<spring:message code="D00025"/>', color: 'blue'}
	           	,{text : '<spring:message code="D00026"/>', color: 'gray'}
	           	,{text : '<spring:message code="D00027"/>', color: 'gray'}
	           	,{text : '<spring:message code="D00087"/>', color: 'gray'}
	           	];

	$('input[name="pushType"]').on('change', function() {
		//예약 발송인 경우 - 예약 설정 컴포넌트 노출
		if(this.value == 'rv') {
			$('#rvSub').show();
		} else {
			$('#rvSub').hide();
		}

		//테스트 발송인 경우 - '발송 타입 선택' 컴포넌트 숨김 및 '푸시 대상자 직접 선택' 컴포넌트 노출
		if(this.value == 'te') {
			$('#pushTargetDiv').hide();
			$('.target_select_area').show();
		} else {
			$('#pushTargetDiv').show();
			$('.target_select_area').hide();
		}
	});
	
	if(updateFlag){
		pushMsgDetail(pushMsgId);
	} else {
		//신규 등록인 경우, 테스트 발송 관련 grid 로딩 
		makeParentGrid();
		makeChildGrid();
	}
});

//마스크해제
function clearMaskAction(targetGrid) {

	var v_rid;
	if ($.fn.ifvmIsNotEmpty(targetGrid.getCheckedGridData()[0])) {
		v_rid = targetGrid.getCheckedGridData()[0].rid;
		
	}
	
	if ($.fn.ifvmIsNotEmpty(v_rid)) {
	
		$.ifvSyncPostJSON('<ifvm:action name="clearMaskMbr"/>', {
			rid: v_rid
		},
		function(result) {
			var rowid = targetGrid.getCheckedRowIds()[0];
			targetGrid.opt.grid.setCell( rowid, 'custNm' , result.mbrNm );  // 고객명 세팅
			targetGrid.opt.grid.setCell( rowid, 'hhpNo' , result.hhpNo ); //
			targetGrid.opt.grid.setCell( rowid, 'emailAddr' , result.emailAddr ); //
		});
	}  
}

function btnSaveClick() {
	validation = $('#pushMsgForm').ifvValidation();
	if(validation.confirm() === false) {
		return;
	}
	
	var testerList = [];
	//이미지 업로드
	var backImageArr = backImage.getImageList();
	
	if ($(':radio[name="pushType"]:checked').val() == "te") {
		var childGridLength = childGrid.getRowData().length;
		if (childGridLength == 0) {
			alert("테스트 발송 대상자를 최소한 1명 이상 선택해야 합니다.");
			return;
		} else {
			for (var i=0; i < childGridLength; i++) {
				testerList.push(childGrid.getRowData()[i].rid);
			}
		}
	}

	var sendObj = {
		 	sendDate : getSendDate(),
			pushLang : $(':radio[name="pushLang"]:checked').val(),
			pushType : $(':radio[name="pushType"]:checked').val(),
			pushTarget : $('#pushTarget').val(),
			pushTitle : $('#pushTitle').val(),
			pushContent : $('#pushContent').val(),
			updateFlag : updateFlag,
			pushMsgId : pushMsgId,
			pushMembers : testerList,
			subImages  : backImageArr
	}
	
	$.ifvSyncPostJSON( '<ifvm:action name="insertPushMsg"/>',
			sendObj,
			function(result) {
				if(result.success == true){
					alert('<spring:message code="M00005"/>');
					location.href = '<ifvm:url name="pushMsgListUrl"/>';
				}
				else{
					alert('<spring:message code="M00029"/>');
				}
			}
	);
}

function getSendDate() {
	var sendDate = "";
	if($(':radio[name="pushType"]:checked').val() == "rv") {
		sendDate = to_date($('#pushRvDate').val()) + to_time($('#pushRvTime').val());
	}

	return sendDate;
}

function btnListClick() {
	location.href = '<ifvm:url name="pushMsgListUrl"/>';
}


function getCommonCode() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'LOY_PUSH_TARGET_MBR_TYPE'
		,schemas : 'com'
		, enableNA : false
	}, function(result) {
		for (var i=0; i<result.rows.length; i++) {
			if (result.rows[i].codeName != "NA") {
				result.rows[i].codeName = result.rows[i].codeName;
			}
		}
		var temp = $("#selectPushTypeTemplate").tmpl(result.rows);
		$("#pushTarget").append(temp);
	});
}

function to_date(date){
	var Date = date.split('-');
	var rtnValue = "";
	for(var i=0; i<Date.length; i++){
		rtnValue = rtnValue + Date[i];
	}
	return rtnValue;
}
function to_time(time){
	var Time = time[0] + time[1] + time[3] + time[4]
	return Time;
}

function pushMsgDetail(id){
	$.ifvSyncPostJSON('<ifvm:action name="getPushMsgDetail"/>', {
		pushMsgId : pushMsgId,
	}, function(result) {
		$("#senderWrap").show();
		//수정모드인 경우 저장 기능 비활성화. 2017.7.31. 박광민
		$('#btnSave').attr('disabled','disabled');
		$("input[name=pushLang]").attr('disabled','disabled');
		$("input[name=pushType]").attr('disabled','disabled');
		$('#pushTarget').attr('disabled','disabled');
		$('#pushTitle').attr('disabled','disabled');
		$('#pushContent').attr('disabled','disabled');
		var summary = result.summary.split("/");
		var wait = summary[0] * 1;
		var complete = summary[1] * 1;
		var sum = wait + complete; 
		$("#totalSender").val(sum);
		$("#waitSender").val(summary[0]);
		$("#completeSender").val(summary[1]);
		$('#pushTitle').val(result.pushTitle);
		$('#pushContent').val(result.pushContent);
		if(result.pushLang == "ko"){
			$("input:radio[name='pushLang']:radio[value='ko']").attr("checked",true);				
		}
		else if(result.pushLang == "en"){
			$("input:radio[name='pushLang']:radio[value='en']").attr("checked",true);
		}
		else{
			$("input:radio[name='pushLang']:radio[value='zh']").attr("checked",true);
		}

		switch (result.pushType) {
			case "rt" : 
				$("input:radio[name='pushType']:radio[value='rt']").attr("checked",true);
				break;
			case "rv" :
				$('#rvSub').show();
				$("input:radio[name='pushType']:radio[value='rv']").attr("checked",true);
				$('#pushRvDate').val(result.sendDate);
				$('#pushRvTime').val(result.sendTime);
				break;
			case "te" :
				$("input:radio[name='pushType']:radio[value='te']").attr("checked",true);
				makeTestPushResultGrid(pushMsgId);
				$('.test_result_area').show();
				break;
		}
		
		$('#pushTarget').val(result.pushTarget);

		
		$("#wrap1").css("padding-left", "10px");
		$("#wrap2").css("padding-left", "10px");
		$("#wrap3").css("padding-left", "10px");
		
		//이미지 업로드
		if(result.imageUrl != ''){
			backImage.setImgArrList(result.images);
		}
	})
}


function makeTestPushResultGrid(pushMsgId) {
 	var jqGridOption = {
		serializeGridData : function( data ){
			data.pushMsgId = pushMsgId;
			return data;
		},
		loadComplete : function( obj ){
		},
		url : '<ifvm:action name="getTestPushResultList"/>',
		colNames:[
				'회원명', //회원명
				'핸드폰번호', //핸드폰번호
				'아이디', //아이디
				'회원번호', //회원번호
				'이메일', //이메일
				'발송상태', //발송상태
				'rid'
		],
		colModel:[
				{ name:'custNm', index:'MBRV.custNm',  align : 'left'},
				{ name:'hhpNo', index:'MBRV.hhpNo', align : 'center' },
				{ name:'webId', index:'MBRV.webId', align : 'left' },
				{ name:'mbrNo', index: 'MBRV.mbrNo', align : 'center' },
				{ name:'emailAddr', index: 'MBRV.emailAddr', align : 'left' },
				{ name:'sendStatus', index: 'MBRV.sendStatus', searchable : false, align : 'center' },
				{ name:'rid', hidden:true }
		],
		sortname: 'MBRV.sendStatus',
		sortorder: "desc",
		radio: true,
		tempId : 'testPushResultGridTemplete',
		height : 'auto'
	};
 	testResultGrid = $("#testResultGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function makeParentGrid() {
	var jqGridOption = {
		serializeGridData : function( data ){
		},
		loadComplete : function( obj ){
		},
		url : '<ifvm:action name="getPushMemberList"/>',
		colNames:[
				'회원명', //회원명
				'핸드폰번호', //핸드폰번호
				'아이디', //아이디
				'회원번호', //회원번호
				/* '푸시토큰여부', */
				'이메일', //이메일
				'rid'
		],
		colModel:[
				{ name:'custNm', index:'MBR.CUST_NM', align : 'left', encCol : true},
				{ name:'hhpNo', index:'MBR.HHP_NO', align : 'center' },
				{ name:'webId', index:'MBR.WEB_ID', align : 'left' },
				{ name:'mbrNo', index: 'MBR.MBR_NO', align : 'center' },
				{ name:'emailAddr', index: 'MBR.EMAIL_ADDR', align : 'left', encCol : true},
				{ name:'rid', hidden:true }
		],
		sortname: 'MBR.create_date',
		sortorder: "desc",
		multiselect: true,
		tempId : 'propertiesGridTemplete',
		height : 'auto'
	};
	parentGrid = $("#parentGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function makeChildGrid() {
	var jqGridOption = {
		serializeGridData : function( data ){
		},
		datatype : 'clientSide',
		loadComplete : function( obj ){
		},
		colNames:[
				'회원명', //회원명
				'핸드폰번호', //핸드폰번호
				'아이디', //아이디
				'회원번호', //회원번호
				'이메일', //이메일
				'rid'
		],
		colModel:[
				{ name:'custNm', index:'MBR.custNm',  align : 'left' },
				{ name:'hhpNo', index:'MBR.hhpNo', searchable : false,  align : 'center' },
				{ name:'webId', index:'MBR.webId', searchable : false, align : 'left' },
				{ name:'mbrNo', index: 'MBR.mbrNo', align : 'center' },
				{ name:'emailAddr', index: 'MBR.EMAIL_ADDR', align : 'left' },
				{ name:'rid', hidden:true, key : true }
		],
		multiselect: true,
		rowList : [50],
		tempId : 'noSearchGridTemplete',
		height : 'auto'
	};
	childGrid = $("#childGrid").ifvGrid({ jqGridOption : jqGridOption });
}
</script>

<script id="propertiesGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="filter_area">
			<div class="left pos_l0">
				{searchBox}
			</div>
		</div>
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
		</div>
		<div class="total_area">{total}</div>
	</div>
</script>

<script id="noSearchGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="filter_area">
		</div>
		<div class="grid_con" style="overflow-x:hidden;overflow-y:auto;max-height:320px;">
			{grid}
		</div>
		<div class="page">
		</div>
	</div>
	<div class="total_area" id="childGridTotal">{total}</div>
</script>

<script id="testPushResultGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="filter_area">
			<div class="left pos_l0">
				{searchBox}
			</div>
		</div>
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
		</div>
		<div class="total_area">{total}</div>
	</div>
</script>