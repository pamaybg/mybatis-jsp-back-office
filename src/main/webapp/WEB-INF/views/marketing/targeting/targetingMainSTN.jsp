<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="${pageContext.request.contextPath}/resources/js/marketing/calendar_beans_v2.2.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/marketing/jquery.mask.min.js" type="text/javascript"></script>

<script>
var segName = null;
var saveTargetObj = {};	//저장될 정보
//var memId = [];	//저장될 회원 목록

var segmentPopupCon;

var saveSegObj = {};
var memberList = null;
var targetCustCnt = null;
var agreeCust = null;
var fatiCnt = null;
var prmsCnt = null;
var dupCnt = null;

//파일 저장 변수
var uploadMemberInfoGrid; 
var uploadResultNumberGrid;
var gridData;
var oriGridData;
var uploadData;
var nodeId = [];
var tableObj = [];
var memIds = [];
isRefresh = true;


//세그먼트 저장 변수
var segNameFlag;

//타겟그룹 저장
function saveSegment(){
    $.ifvProgressControl(true);
    
	if(camId != null && camId.length > 0 && camId != "null"){
		
	    //타겟그룹 아이디 확인
	    var targetGroupId = "";
	    var isTargetGroup = targetGroup;
		if ($.fn.ifvmIsNotEmpty(isTargetGroup)) {
		    if ($.fn.ifvmIsNotEmpty(targetGroup.targetGroupId))
			targetGroupId = targetGroup.targetGroupId;
		}
		
		if($.fn.ifvmIsNotEmpty(targetGroupId)){
				
		    saveSegObj = {};
	    	saveSegObj.targetGroupId = targetGroupId;
			saveSegObj.segName = $("#targetGroupName").val();
			saveSegObj.camId = camId;
			saveSegObj.segType = 'SEG';
			saveSegObj.chnlType = $("#chnlType").val();
			saveSegObj.targetCustCnt = targetGroup.data.targetCount;
			saveSegObj.ctrlGroupUnitCd = targetGroup.data.comprGroupTypeCode;
			saveSegObj.ctrlGroupAmt = targetGroup.data.comprGroupDtl;
			
			//퀵캠페인 / 캠페인워크플로우 분기
			if (typeof campaignSubjectsPopData != "undefined" 
			        && $.fn.ifvmIsNotEmpty(campaignSubjectsPopData.campaignChnlType)) {
			    //캠페인 워크플로우에서의 세그먼트 유형
                saveSegObj.segType = campaignSubjectsPopData.campaignSegType;
                saveSegObj.chnlType = campaignSubjectsPopData.campaignChnlType;
            }
			
			//타겟팅 저장
			$.ifvPostJSON('<ifvm:action name="setSegment"/>',saveSegObj
				,function(result) {
				
				alert("<spring:message code='M00267'/>");
				$("#segConfirmWrap").show();
				$("#segConfirmName").text(result.message);
				
				$.ifvProgressControl(false);
				
				//캠페인 워크플로우일 경우
				if (workflowFlag) {
				    //캔버스 저장
				    campaignTargetingPopSave();
				}
			}
			,function(result) {
			    $.messageCheckr(result.message);
			    $.ifvProgressControl(false);
			});
		} else {
			alert("<spring:message code='M00713'/>");
			$.ifvProgressControl(false);
		}
	} else {
		alert("<spring:message code='M00710'/>");
		$.ifvProgressControl(false);
	}
}
//저장
function saveTarget(){
    $.ifvProgressControl(true);
	if(camId != null && camId != '' && camId != 'null'){
		if(saveTargetObj.memberList != null && saveTargetObj.memberList.length > 0){
			
			saveTargetObj.camId = camId;
			saveTargetObj.segType = 'IMP';
			saveTargetObj.fileType = $("#fileType").val();
			saveTargetObj.memType = $(':radio[name="memType"]:checked').val();
			
			//퀵캠페인 / 캠페인워크플로우 분기
            if (typeof campaignSubjectsPopData != "undefined" 
                        && $.fn.ifvmIsNotEmpty(campaignSubjectsPopData.campaignChnlType)) {
                //캠페인 워크플로우에서의 세그먼트 유형
                saveTargetObj.segType = campaignSubjectsPopData.campaignSegType;
                saveTargetObj.chnlType = campaignSubjectsPopData.campaignChnlType;
            }
			
			$.ifvPostJSON('<ifvm:action name="setSegment"/>',saveTargetObj
			,function(result) {
				segName = result.message;
				
				$("#savedArea").show();
				$("#segNameTxt").text(segName);
				
				alert("<spring:message code='M00990'/>");
				
				$.ifvProgressControl(false);
				
				//캠페인 워크플로우일 경우
				if (workflowFlag) {
				    //캔버스 저장
				    campaignTargetingPopSave();
				}
			}
			,function(result) {
			    $.messageCheckr(result.message);
			    $.ifvProgressControl(false);
			});
			
		}
		else{
			alert("<spring:message code='M00708'/>");
			$.ifvProgressControl(false);
		}
	}
	else{
		alert("<spring:message code='M00710'/>");
		$.ifvProgressControl(false);
	}
}

//공통코드 파일 유형 조회
function fileType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_FILE_TYPE'
		, enableNA : true
	},function(result) {
		
		var temp = $("#fileTypeTemplate").tmpl(result.rows);
		$("#fileType").append(temp);
		
	});
}; 

//세그먼트 템플릿 설정 코드 조회
function templateType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_CAL_TYPE'
		, enableNA : true
	},function(result) {
		
		var temp = $("#templateTypeTemplate").tmpl(result.rows);
		$("#templateTypeWrap").append(temp);
		
	});
}; 

/* 팝업 닫기 */
function segmentPopupClose(){
	segmentPopupCon.destroy();
}

//실패사유 포맷
function failGridFormat(cellValue, options, rowdata){
	var message = '';
	var sucessFlag = true; 
	
	//내부고객용
	if($(':radio[name="memType"]:checked').val() == 'internal'){
		
	
		var message = '';
		var sucessFlag = true; 
		
		//내부고객용
			if(rowdata.memberYn != null && rowdata.memberYn == 0){
				
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M01017'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
				
			}
			
			else if(rowdata.failFlag != null && rowdata.failFlag == '1'){
				
				//tm수신동의여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M01017'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
			} 
			
	}
	else{	//외부고객용
		
		if(rowdata.duplicateDeleteYn != null && rowdata.duplicateDeleteYn == 1){
			
			//중복 삭제 여부
			if(message.length > 0){
				message += ',';
			}
			message += "<spring:message code='M00692'/>";
			
			//비동의일 때 이미지
			var imgFullPath = "<ifvm:image name='upload_red'/>";
			sucessFlag = false; 
		}
	
		if($("#chnlType").val() != 'EMAIL'){ //sms, mms, lms 등 체크
			
			if(rowdata.hpYn != null && rowdata.hpYn != 1){
				
				//핸드폰번호유무여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M00695'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
			}
		}
		else{ //이메일 체크
			
			if(rowdata.emailYn != null && rowdata.emailYn != 1){
				
				//이메일주소유무여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M00698'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
			}
			else if(rowdata.permissionCheckDeleteYn != null && rowdata.permissionCheckDeleteYn == 1){
				
				//이메일주소유무여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M01017'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
				
			}
		
			if(rowdata.memNameYn != null && rowdata.memNameYn != 1){
				
				//이메일주소유무여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M00850'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
			}
		
		}
		
	}
	
	if(sucessFlag){
		message += "<spring:message code='M00253'/>";
		var imgFullPath = "<ifvm:image name='upload_green'/>";
	}
	
	var tempHtml = "<img src='" + imgFullPath + "' alt='' />";
	tempHtml += "<span class='grid_inner_text'>"+ message +"</span>";
	
	return tempHtml;
	 
}

//업로드 회원정보 그리드
function uploadMemberInfoGridFunc(){
    if ($.fn.ifvmIsEmpty(oriGridData)) {
        oriGridData = gridData;
    }
    
	var jqGridOption = {
		data : gridData,
		datatype: 'clientSide',
	    colNames:['<spring:message code="M00688"/>',
	              '<spring:message code="M00689"/>', 
	              'mobileFlag', 'emailFlag', 'smsConFlag',  'emailConFlag'],
	    colModel:[
	        {name:'memberId',index:'memberId', resizable : false},
	        {name:'memFlag',index:'memFlag', resizable : false, formatter: failGridFormat},
	        {name:'mobileFlag',index:'mobileFlag', resizable : false, hidden : true},
	        {name:'emailFlag',index:'emailFlag', resizable : false, hidden : true},
	        {name:'smsConFlag',index:'smsConFlag', resizable : false, hidden : true},
	        {name:'emailConFlag',index:'emailConFlag', resizable : false, hidden : true}
	    ],
	    rowList : [10],
	    tempId : 'uploadMemInfoTemplete',
	    //tempId : 'ifvGridOriginTemplete',
	    caption : '<spring:message code="M00684"/>'
	};
	uploadMemberInfoGrid = $("#uploadMemberInfoGrid").ifvGrid({ jqGridOption : jqGridOption });
	uploadMemberInfoGrid.opt.postData= {page: 1};
	
	//setMemberSearch();
}

function setMemberSearch() {
	var searchTypeL = $('#searchTypeL option:selected').val();
	var searchKeyL = $('#searchKeyL').val();

	if(searchKeyL == '') {
	    gridData = oriGridData;
	    uploadMemberInfoGridFunc();
	} else {
	    gridData = [];
	    
	    $.each(oriGridData, function(index, data) {
	        //회원 번호
	        if(searchTypeL == '0') {
	            if (data.memberId.indexOf(searchKeyL) > -1) {
	                gridData.push(data);
	            }
	        } 
	        //실패 사유
	        else if(searchTypeL == '1') {
	            var formatter = failGridFormat(null, null, data);
	            var str = formatter.replace(/(<([^>]+)>)/gi, "");
	            if (str.indexOf(searchKeyL) > -1) {
	                gridData.push(data);
	            }
	        }
	    });
	    
	    uploadMemberInfoGridFunc();
	    $('#searchTypeL').val(searchTypeL);
	    $('#searchKeyL').val(searchKeyL);
	}
}

function enterCheck(evt){
	var code = evt.which?evt.which:event.keyCode;
	if(code == 13){
	
		setMemberSearch();
		return false;
	}
}

//업로드 결과 건수 그리드
function uploadResultNumberGridFunc(){
	var jqGridOption = {
		data : uploadData,
		datatype: 'clientSide',
	    colNames:['<spring:message code="M00690"/>',
	              '<spring:message code="M00691"/>'],
	    colModel:[
	        {name:'name',index:'', resizable : false},
	        {name:'uploadCnt',index:'', resizable : false}
	    ],
	    sortname: '',
		sortorder: "desc",
	    tempId : 'uploadResultTemplete',
	    caption : '<spring:message code="M00685"/>'
	};
	
	uploadResultNumberGrid = $("#uploadResultNumberGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function nonSelectedListInit(nonSelectedList, tempData){
 	
	 var objList = [];
	
	for(var k=0; k<tempData.attrValue.length; k++){
		
		var obj = {};
		obj.id = tempData.attrId[k];
		obj.name = tempData.attrValue[k];
		obj.condCode = tempData.condCode[k];
		
		objList.push(obj);
		
	} 
	
	var jqGridOption = {
		data : objList,
		datatype: 'clientSide',
        colNames:[ 'id', 'condCode', '<spring:message code="M00662"/>'],
        colModel:[
            { name:'id', sortable : false, resizable : false, hidden : true }, 
            { name:'condCode', sortable : false, resizable : false, hidden : true }, 
            { name:'name', sortable : false, resizable : false }, 
        ],
        multiselect: true,
        ajaxGridOptions : { async : false },
        width : 350,
        rowList : [100],
        tempId : 'listGridTemplete'
    };
		
	return $("#" + nonSelectedList).ifvGrid({ jqGridOption : jqGridOption }); 
}

function selectedListInit(selectedList, tempData){
	
	var jqGridOption = {
		data : tempData,
		datatype: 'clientSide',
        colNames:[ 'id', 'condCode', '<spring:message code="M00661"/>'],
        colModel:[
            { name:'id', sortable : false, resizable : false, hidden : true }, 
            { name:'condCode', sortable : false, resizable : false, hidden : true }, 
            { name:'name', sortable : false, resizable : false }
        ],
        multiselect: true,        
        width : 350,
        ajaxGridOptions : { async : false },
        rowList : [100],
        tempId : 'listGridTemplete'
    };
	
	return $("#" + selectedList).ifvGrid({ jqGridOption : jqGridOption });
}

//타겟그룹 메인 불러오기
function segmentLoad(){
	$.fn.ifvmLoadUiSetting("segmentContent", '<ifvm:url name="targetGroupMainLoadSTN"/>');
}

//load시 필요없는 항목 제거
function loadUiSetting(){
	$('.campaign_load_contents #header').remove();
	$('.campaign_load_contents #sideMenu').remove();
	$('.campaign_load_contents .page-title').remove();
	$("#contentsMessage .btn").addClass("btn_gray");
}

//파일 다운로드
function tgt_fileDownload() {
	if($(':radio[name="memType"]:checked').val() == 'internal'){
		location.href = '<ifvm:url name="fileDownload"/>/internalCustomer.csv';
	}
	else{
		location.href = '<ifvm:url name="fileDownload"/>/externalCustomer.csv';
	}
}
//파일 검색 클릭 후 파일 선택 시 실행
function tgt_fileSelected() {
	$("#savedArea").hide();
	
	var validationCheck = false;
	
	if($("#fileType").val() == 'CSV'){
		if($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'csv'){
			validationCheck = true;
		}
	}
	else{
		if($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xlsx' || $("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xls'){
			validationCheck = true;
		}
	}
	
	if(validationCheck){
		
		if(($("#hideFile")[0].files[0].type.split('/')[1]=='vnd.ms-excel') || $("#hideFile")[0].files[0].type.split('/')[1]== 'vnd.openxmlformats-officedocument.spreadsheetml.sheet'){
				
			memId = [];

				var formData = new FormData();
				//파일업로드
				formData.append("file", $("#hideFile")[0].files[0]);  
				//회원 구분
				formData.append("memType", $(':radio[name="memType"]:checked').val());
				//파일유형
				formData.append("uploadFileType", $("#fileType").val());
				//타겟 방법
				formData.append("tgtType", $(':radio[name="targetMethod"]:checked').val());
				
				var fatiExceptYn = '0';
				
				//피로도 체크 여부 확인
				if($("input:checkbox[id='fatigueExcept']").is(":checked")){
					fatiExceptYn = '1';
				}
				
				//피로도 제외 여부
				formData.append("fatiExceptYn", fatiExceptYn);
				
				//채널 유형
				
				if(typeof $("#chnlType").val() == 'undefined' || $("#chnlType").val() == null || $("#chnlType").val() == 'null' || $("#chnlType").val() == ''){
					formData.append("chnlType", "");	
				}
				else if($("#chnlType").val() == 'EMAIL'){
					formData.append("chnlType", "EMAIL");
				}
				else if($("#chnlType").val() == 'PUSH'){
					formData.append("chnlType", "PUSH");
				}
				else if($("#chnlType").val() == 'SMS'){
					formData.append("chnlType", "SMS");
				}
				else{
					formData.append("chnlType", "MMS");
				}
				

				
				formData.append("appServiceId", appServiceId);
				formData.append("country", country);
				formData.append("lang", lang);

				$.ajax({
					url: '<ifvm:action name="setFileUpload"/>',
					data: formData,
					processData: false,
					contentType: false,
					type: 'POST',
						success: function(data){
						    
					    $("#uploadResult").show();

						if(data.errorType == 200410){
							qtjs.href('<ifvm:url name="MKTLogin"/>');
						}
						//최종저장 시 사용 객체
						saveTargetObj.dupCnt = data.dupCnt;
						//saveTargetObj.allUploadCnt = data.allUploadCnt;
						saveTargetObj.targetCustCnt = data.targetCustCnt;
						saveTargetObj.fileName = data.fileName;
						saveTargetObj.memberList = data.memberList;
						//saveTargetObj.successCnt = data.successCnt;
						saveTargetObj.agreeCust = data.agreeCust;
						saveTargetObj.failCnt = data.failCnt;
						saveTargetObj.fatiCnt = data.fatiCnt;
						saveTargetObj.prmsCnt = data.prmsCnt;
						
						//파일 순서 결정
						if( $(':radio[name="memType"]:checked').val() != 'internal'){
							data.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
						}
						
						$("#fileConfirmTextArea").text("<spring:message code='M00687'/>");
						gridData = null;
						$("#uploadMemberInfoGrid").empty();
						
						//업로드 결과 회원 정보 조회
						gridData = data.memberList;
						uploadMemberInfoGridFunc();
						
						//업로드 결과 건수 조회
						var resultGridList = new Array();
						var resultAllCnt = {};
						var resultSuccessCnt = {};
						var resultFailCnt = {};
						
						
						resultAllCnt.name = "<spring:message code='M00700'/>";
						resultAllCnt.uploadCnt = data.targetCustCnt;
						
						resultSuccessCnt.name = "<spring:message code='M00701'/>";
						resultSuccessCnt.uploadCnt = data.agreeCust;
						
						resultFailCnt.name = "<spring:message code='M00702'/>";
						resultFailCnt.uploadCnt = data.failCnt;
						
						resultGridList.push(resultAllCnt);
						resultGridList.push(resultSuccessCnt);
						resultGridList.push(resultFailCnt);
						
						uploadData = resultGridList;
						
						uploadResultNumberGridFunc();
					}
				});  
				
		}else{
			alert("<spring:message code='M00703'/>");
			$("#hideFile").removeAttr("value");
		}	
		
		//초기화
		$("#hideFile").val("");
		
	}
	else{
		alert("<spring:message code='M00703'/>");
		$("#hideFile").removeAttr("value");
	}
}

$(document).ready(function(){
	
	$("#segConfirmWrap").hide();
	
	//세그먼트 load
	segmentLoad();
	
	//저장 문구 숨김
	$("#savedArea").hide();
	
	//업로드 결과 영역 최초 하이드
	$("#uploadResult").hide();
	
	//템플릿 설정 조회
	templateType();
	
	//공통코드 파일 유형 조회
	fileType();
	
	
	//저장버튼 클릭 시
	$("#targetSaveBtn").on('click', function(){
		saveTarget();
	});
	
	//파일 다운로드 버튼 클릭 시 
	$("#fileDownload").on('click', function(){
	    tgt_fileDownload();
	});
	
	//파일 검색 클릭 시
	$("#searchFile").on("click", function(){
		$("#hideFile").trigger("click");
	});
	//세그먼트 라디오 클릭 시
	$("#segmentRadio").on("click", function(){
		$("#segmentRadio").attr('checked', 'checked');
		$("#segmentConArea").show();
		$("#uploadConArea").hide();
	});
	//업로드 라디오 클릭 시
	$("#uploadRadio").on("click", function(){
		$("#uploadRadio").attr('checked', 'checked');
		$("#segmentConArea").hide();
		$("#uploadConArea").show();
	});
	
	//파일 검색 클릭 후 파일 선택 시 실행
	$("#hideFile").on("change", function(){
	    tgt_fileSelected();
	});
});


</script>

<script id="templateTypeTemplate" type="text/x-jQuery-tmpl">
	<div class="col-xs-3 text-center">
		<label class="radio-inline">
			{{if codeName == 'UNION'}}	
			<ifvm:input type="radio" names="templateSet" values="${'${'}codeName}" className="segment_template_radio" checked="true" />
			<img src="<ifvm:image name='set_union'/>" alt="" />
			{{/if}}
			{{if codeName == 'INTERSECTION'}}	
			<ifvm:input type="radio" names="templateSet" values="${'${'}codeName}" className="segment_template_radio"/>
			<img src="<ifvm:image name='set_intersection'/>" alt="" />
			{{/if}}
			{{if codeName == 'A_DIFF_SET'}}	
			<ifvm:input type="radio" names="templateSet" values="${'${'}codeName}" className="segment_template_radio"/>
			<img src="<ifvm:image name='set_a'/>" alt="" />
			{{/if}}
			{{if codeName == 'B_DIFF_SET'}}	
			<ifvm:input type="radio" names="templateSet" values="${'${'}codeName}" className="segment_template_radio"/>
			<img src="<ifvm:image name='set_b'/>" alt="" />
			{{/if}}
		</label>
	</div>
</script>

<script id="fileTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="uploadMemInfoTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}

		<div class="filter_area">
			<div class="left">
				<select id="searchTypeL">
					<option value="0"><spring:message code="M00688"/></option>
					<option value="1"><spring:message code="M00689"/></option>
				</select>
				<input type="text" id="searchKeyL" onkeypress="enterCheck(event)"/>
				<a href="javascript:setMemberSearch();" id="searchBtnL" class="ifv_search_box_search_btn">검색</a>
			</div>
		</div>
	
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
			<div class="total_area">{total}</div>	
		<div>
	</div>
</script
>
<script id="uploadResultTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>


<script id="listGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>

<!-- For Targeting Template -->
<script id="ifvUiCheck" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_check" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10 control_content">
		{{each(key, val) attrValue}}
			<div class="row form-horizontal col-xs-6" style="padding-bottom : 0px;">
				<ifvm:input type="radio" id="${'${'}attrId[key]}" values="${'${'}attrCode[key]}" names="${'${'}seq}check"/><label>${'${'}val}</label>
			</div>
		{{/each}}
		</div>
	</div>
</script>

<script id="ifvUiDdlb" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_ddlb" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10">
			<select class="form-control" id="${'${'}condVal}">
			{{each(key, val) attrValue}}
				<option id="${'${'}key}" value="${'${'}attrId[key]}" condName="${'${'}attrCode[key]}">${'${'}val}</option>
			{{/each}}
			</select>
		</div>
	</div>
</script>

<script id="ifvUiRadio" type="text/x-jQuery-tmpl">
	<div class="col-sm-12 qt_border seg_box seg_radio" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<div class="row form-horizontal qt_border col-xs-12" style="padding-bottom : 0px"><label>${'${'}rable}</label></div>
		{{each(key, val) attrValue}}
			{{if key%2 == 0}}
				<div class="row form-horizontal col-xs-6" style="padding-bottom : 0px">
				<ifvm:input type="radio"  names="${'${'}seq}radio" id="${'${'}attrId[key]}" values="${'${'}attrCode[key]}"/><label>${'${'}val}</label><br />
				{{if attrValue.length-1 == key}}
					</div>
					</div>
				{{/if}}
				{{else}}
					<ifvm:input type="radio"  names="${'${'}seq}radio" id="${'${'}attrId[key]}" values="${'${'}attrCode[key]}"/><label>${'${'}val}</label>
					</div>
				{{if attrValue.length-1 == key}}
					</div>
				{{/if}}
			{{/if}}
		{{/each}}
	</div>
</script>

<script id="ifvUiMultia" type="text/x-jQuery-tmpl">
	<div class="col-sm-12 qt_border seg_box seg_multia" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<div class="row form-horizontal qt_border col-xs-12" style="padding-bottom : 0px"><label>${'${'}rable}</label></div>
		

		{{each(key, val) attrValue}}
			{{if key%2 == 0}}
				<div class="row form-horizontal col-xs-6" style="padding-bottom : 0px">
				<input type="checkbox" id="${'${'}attrId[key]}" names="${'${'}seq}multiA" values="${'${'}attrCode[key]}"/><label>${'${'}val}</label><br />
				{{if attrValue.length-1 == key}}
					</div>
					</div>
				{{/if}}
				{{else}}
					<input type="checkbox" id="${'${'}attrId[key]}" names="${'${'}seq}multiA" values="${'${'}attrCode[key]}"/><label>${'${'}val}</label>
					</div>
				{{if attrValue.length-1 == key}}
					</div>
				{{/if}}
			{{/if}}
		{{/each}}

		
	</div>
</script>

<script id="ifvUiNumber" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_num" id="${'${'}seq}" condition = "${'${'}condName}" attrId="${'${'}attrId}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10 control_content">
			<div class="col-sm-6 pd0 cal_frt">
				<div class="input">
					<ifvm:input type="number" id="fromNumTemp" names="request" className="text-right"/>
				</div>
			</div>
			<div class="col-sm-1 swung_dash text-center">~</div>
			<div class="col-sm-6 pd0 cal_scd">
				<div class="input">
					<ifvm:input type="number" id="toNumTemp" names="request" className="text-right"/>
				</div>
			</div>
		</div>
	</div>
</script>

<script id="ifvUiTerm" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_term" id="${'${'}seq}" condition = "${'${'}condName}" attrId="${'${'}attrId}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10 control_content">
			<div class="col-sm-6 pd0 cal_frt">
				<div class="input">
					<ifvm:input type="date" id="${'${'}rowId}FromDate" readonly="true"/>
				</div>
			</div>
			<div class="col-sm-1 swung_dash text-center">~</div>
			<div class="col-sm-6 pd0 cal_scd">
				<div class="input">
					<ifvm:input type="date" id="${'${'}rowId}ToDate" readonly="true"/>
				</div>
			</div>
		</div>
	</div>
</script>

<script id="ifvUiMonthTerm" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_term" id="${'${'}seq}" condition = "${'${'}condName}" attrId="${'${'}attrId}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10 control_content">
			<div class="col-sm-6 pd0 cal_frt">
				<div class="input">
					<ifvm:input type="text" id="${'${'}rowId}FromDate" readonly="true"/>
				</div>
			</div>
			<div class="col-sm-1 swung_dash text-center">~</div>
			<div class="col-sm-6 pd0 cal_scd">
				<div class="input">
					<ifvm:input type="text" id="${'${'}rowId}ToDate" readonly="true"/>
				</div>
			</div>
		</div>
	</div>
</script>

<script id="ifvUiMultib" type="text/x-jQuery-tmpl">
	<div class="col-sm-12 qt_border seg_box seg_multib" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<div class="row form-horizontal qt_border col-xs-12" style="padding-bottom : 0px"><label>${'${'}rable}</label></div>
		<div class="col-sm-12 qt_border">
			<table>
				<tbody>
					<tr>
						<td style="width:47%; vertical-align:top;">
							<div id="${'${'}seq}NonSelectedList"></div>
						</td>
						<td class="move_list" style="width:6%;">
							<button onClick="javascript:moveSelectRow(${'${'}seq});" class="next_btn"></button>
							<button onClick="javascript:allMoveNonTable(${'${'}seq});" class="last_btn"></button>
							<button onClick="javascript:moveNoRow(${'${'}seq});" class="prev_btn"></button>
							<button onClick="javascript:allMoveTable(${'${'}seq});" class="first_btn"></button>
						</td>
						<td style="width:47%; vertical-align:top;">
							<div id="${'${'}seq}SelectedList"></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>	
	</div>

</script>

<style>
#uploadConArea{display:none;}
#hideFile {display:none}
#uploadMemberInfoGrid .grid_con{height:173px; overflow-x:hidden; overflow-y:auto;}
/* #tempTable1:before, #tempTable1:after, #tempTable2:before, #tempTable2:after {content: ' '; display: table; clear: both;} */
.campaign_load_contents .ui-th-ltr, .campaign_load_contents .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr:first-child {border-left: 1px solid #dddddd;}
#searchTypeL {width: 150px; float: left; height: 25px; margin-right: 3px;}
#searchKeyL {width: 200px; float: left; height: 25px;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M00619"/>
	</h1>
</div>
<div id="targetingConArea">
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span><spring:message code="M00621"/></span>
		</div>
	</div>
	<div class="well form-horizontal well_sum">
		<div class="row">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00665"/></label>	
			<div class="col-xs-10 control_content">
			
				<label class="radio-inline">
					<ifvm:input type="radio" names="targetMethod" values="segment" checked="true" id="segmentRadio" />
					<spring:message code="M01494"/>
				</label>
				
				<label class="radio-inline">
					<ifvm:input type="radio" names="targetMethod" values="condExt"  id="condExtRadio" />
					<spring:message code="M02428"/>
				</label>
				
				
				<label class="radio-inline">
					<ifvm:input type="radio" names="targetMethod" values="upload" id="uploadRadio" />
					<spring:message code="M00667"/>
				</label>
			</div>
		</div> 
	</div>
</div>

<!-- 세그먼트 -->
<div id="segmentConArea">
	<div class="well form-horizontal well_wrap pad0" id="segmentContent"></div>
</div>

<!-- 업로드 -->
<div id="uploadConArea">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00667"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray" id="fileDownload">
				<spring:message code="M00704"/>
				<%-- <a href= '<ifvm:url name="fileDownload"/>/sample.csv'></a> --%>
			</button> 
			<button class="btn btn-sm btn_gray" id="searchFile">         
				<spring:message code="M00681"/>
			</button> 
				<ifvm:input type="file" id="hideFile"/>
			<button class="btn btn-sm btn_gray" id="targetSaveBtn">    
				<i class="glyphicon glyphicon-check"></i>     
				<spring:message code="M00280"/>
			</button>  
		</div>
	</div>
		
	<div class="well form-horizontal well_wrap">
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00682"/></label>	
			<div class="col-xs-2 control_content">
				<ifvm:input type="select" id="fileType"/> 
			</div>
			
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00705"/></label>
			<div class="col-xs-3 control_content">
				<label class="radio-inline">
					<ifvm:input type="radio" names="memType" values="internal" checked="true" id="internalMem" />
					<spring:message code="M00706"/>
				</label>
				<label class="radio-inline">
					<ifvm:input type="radio" names="memType" values="external" id="externalMem" />
					<spring:message code="M00707"/>
				</label>
			</div>
			
			
		</div>
		<div class="row">
			<label class="col-xs-2 control-label"><spring:message code="M00683"/></label>	
			<div class="col-xs-10 control_content">
				<span class="detail_txt" id="fileConfirmTextArea"><spring:message code="M00686"/></span> 
			</div>
		</div>
		
    <!-- 파일 업로드 결과 영역 -->
	<div id="uploadResult">
			<div class="row">
				<div class="col-xs-6">
					<div id="uploadMemberInfoGrid"></div>
				</div>
				<div class="col-xs-6 upload_grid_right">
					<div id="uploadResultNumberGrid"></div>
					<div class="multi_description" id="savedArea">
						<p><spring:message code="M00676"/></p>
						<p>(<spring:message code="M00677"/>: <span id="segNameTxt"></span>)</p>
					</div>
				</div>
			</div>
	</div>
	</div>
</div>


<div id="segmentPopupCon" class="popup_container"></div>