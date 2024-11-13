<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="${pageContext.request.contextPath}/resources/js/marketing/calendar_beans_v2.2.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/marketing/jquery.mask.min.js" type="text/javascript"></script>

<style>

#importResult {
    color: #2312e8;
    font-weight: bold;
}

#importResult span {
    display: inline-block;
    color: #3888aa;
    padding-left: 5px;
    font-weight: normal;
}
</style>

<script>
var segName = null;
var saveTargetObj = {};	//저장될 정보
//var memId = [];	//저장될 회원 목록
var importListPopup;
var importValidation;

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

var gridIduploadMemberInfoGrid;
var uploadMamberGridInfo = {
        colNames : [
            "<spring:message code='L00787'/>",
            "<spring:message code='M02449'/>"
        ],
        colModel : [
            {name: 'memberId', index: 'memberId', sortable: false, resizable: false},
            {name: 'successYn', index: 'successYn', resizable: false, formatter: failGridFormat}
        ],
        lgcCompId : null,
}

//세그먼트 화면 설정(기존 세그먼트가 있으면 불러온다.)
function setCampaignTargetingPop(result) {

    //세그먼트 조회
    if (result.segItem != null && result.segItem.length > 0) {
        
        if (result.segItem[0].segType == 'CND') {
            tgtId = result.targetHadInfo.id;
            
            $("#simpleRadio").prop('checked', true);
            
            $("#segmentConArea").hide();
            $("#uploadMainArea").hide();
            $("#uploadBodyArea").hide();
            $("#simpleContent").show();
            isSearched = true;
            
            simpleLoad();
            
            //조건추출 상세화면 Load
            conditionMain.conditionDetailLoad(result.segItem[0].conditionId);
        }
        //Import 
        else if (result.segItem[0].segType == 'IMP') {

            $("#uploadRadio").prop('checked', true);
            
            $("#segmentConArea").hide();
            $("#uploadConArea").show();
            $("#simpleContent").hide();

            importLoad();
            initImportData(result);
            
            setImportSaveBtn();
        }
        else {
            //타겟팅 콘텐츠 로드
            loadTargetGroupDetailCon(result.segItem[0].targetGroupId);
        }
    }
}


//타겟그룹 저장
function saveSegment(){
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
// 				$($("#quickAccordion").find('h3')[2]).trigger('click');
				$("#segConfirmWrap").show();
				$("#segConfirmName").text(result.message);
			}
			,function(result) {
			    $.messageCheckr(result.message);
			});
		} else {
			alert("<spring:message code='M00713'/>");
		}
	} else {
		alert("<spring:message code='M00710'/>");
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

/* 세그먼트 팝업 닫기 */
function segmentPopupClose(){
	segmentPopupCon.destroy();
}

//실패사유 포맷
function failGridFormat(cellValue, options, rowdata){
	var message = '';
	var sucessFlag = true; 
	
	//내부고객용
	if( $("#memType").val() == 'internal'){
		

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

	//외부고객용
	else {
		
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
function uploadMemberInfoGridFunc() {
    
    //컬럼 정보 조회
    getImportMbrGridColInfo();
    
    if ($.fn.ifvmIsEmpty(oriGridData)) {
        oriGridData = gridData;
    }

    // 1 페이지 회원정보 조회
    getImportMbrData(1);
    
	var jqGridOption = {
        serializeGridData: function(data) {

            // 회원정보 조회 & 그리드 reload
            getImportMbrData(data.page);
            gridIduploadMemberInfoGrid.setGridParam({data:gridData}).trigger("reloadGrid");
            return data;
        },
        addGridDataWhenPaging: function(data) {
            
            // 회원정보 조회 & 그리드 reload
            getImportMbrData(data.page);
            gridIduploadMemberInfoGrid.setGridParam({data:gridData}).trigger("reloadGrid");
            return data;
        }, 
        loadComplete: function(obj) {
        },
		data: gridData,
		datatype: 'clientSide', 
	    colNames: uploadMamberGridInfo.colNames,
	    colModel: uploadMamberGridInfo.colModel,
	    caption: '<spring:message code="M00684"/>',
	};
	uploadMemberInfoGrid = $("#uploadMemberInfoGrid").ifvGrid({jqGridOption : jqGridOption});
	uploadMemberInfoGrid.opt.postData = {page: 1};
	uploadMemberInfoGrid.resize();
	gridIduploadMemberInfoGrid = $("#gridIduploadMemberInfoGrid");
    gridIduploadMemberInfoGrid.setGridParam({data:gridData}).trigger("reloadGrid");
    setTimeout(function() {
        gridIduploadMemberInfoGrid.resize();
    }, 100);
	
// 	setMemberSearch();
}

/**
 * 업로드 회원정보 그리드에 출력할 컬럼 정보 조회
 *
 * 1. LC ID 조회
 * 2. Import 컬럼목록 조회
 *
 * @author jh.kim
 */
function getImportMbrGridColInfo() {
    if (uploadMamberGridInfo.colModel.length == 2 
            && $.fn.ifvmIsEmpty(uploadMamberGridInfo.lgcCompId)) {
        
        $.ifvSyncPostJSON('<ifvm:action name="getImportMbrColumnInfo"/>', {
        }, function(result) {
            
            if ($.fn.ifvmIsNotEmpty(result)) {
                // lc id 
                uploadMamberGridInfo.lgcCompId = result.lgcCompId;

                var colNum = 0;
                uploadMamberGridInfo.colNames = [];
                uploadMamberGridInfo.colModel = [];
                
                uploadMamberGridInfo.colNames[colNum] = "<spring:message code='L00787'/>"
                uploadMamberGridInfo.colModel[colNum] = {name: 'memberId', index: 'memberId', sortable: false, resizable: false};
                colNum++;
                
                result.colList.forEach(function(data) {
                    if (data.colType == 'C') {
                        uploadMamberGridInfo.colNames[colNum] = data.dpNm;
                        uploadMamberGridInfo.colModel[colNum] = {name: data.colAlias, index: data.colAlias, sortable: false, resizable: false};
                        colNum++;
                    }
                });
                uploadMamberGridInfo.colNames[colNum] = "<spring:message code='M02449'/>"
                uploadMamberGridInfo.colModel[colNum] = {name: 'successYn', index: 'successYn', resizable: false, formatter: failGridFormat};
            }
        });
    }
}

/**
 * Import 회원정보 조회
 *
 * @author jh.kim
 * @param page 조회할 페이지 번호
 */
function getImportMbrData(page) {

    var start = (page - 1) * 10;
    var end = start + 10;
    
    if ($.fn.ifvmIsNotEmpty(saveTargetObj.memberList)) {
        $.ifvSyncPostJSON('<ifvm:action name="getImportMbrData"/>', {
            page : page,
            lgcCompId : uploadMamberGridInfo.lgcCompId,
            memberList : saveTargetObj.memberList.slice(start, end)
        }, function(result) {
            var cnt = 0;
            result.memberList.forEach(function(data) {
                gridData.splice(start + cnt, 1, data);
                cnt++;
            });
        });
    }
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

//모든고객(MASS) 메인 불러오기
function massLoad(){
	$.fn.ifvmLoadUiSetting("massContent", '<ifvm:url name="stnMassMainLoad"/>');
}

//타겟그룹 메인 불러오기
function segmentLoad(){
	$.fn.ifvmLoadUiSetting("segmentContent", '<ifvm:url name="stnTargetGroupMainLoad"/>');
}

//조건추출 메인 불러오기
function conditionLoad(){
	$.fn.ifvmLoadUiSetting("conditionContent", '<ifvm:url name="stnConditionMainLoad"/>');
}

/**
 * Import 메인 불러오기 
 */
function importLoad() {
    $.fn.ifvmLoadUiSetting("importContent", '<ifvm:url name="stnImportTargetingMainLoad"/>');
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

/**
 * 타겟Import 목록 팝업 닫기
 */
function importListPopupClose() {
    importListPopup._destroy();
}

$(document).ready(function(){
	
	$("#segConfirmWrap").hide();
	
	//모든고객 load
	massLoad();
	
	//세그먼트 load
	segmentLoad();
	
	//조건추출 load
	conditionLoad();
	
	//업로드 load
	importLoad();
	
	//저장 문구 숨김
	$("#savedArea").hide();
	
	//업로드 결과 영역 최초 하이드
	$("#uploadResult").hide();
	
	$("#massConArea").hide();
	
	//템플릿 설정 조회
	templateType();
	
	//공통코드 파일 유형 조회
	fileType();
	
	//모든고객(MASS) 라디오 클릭 시
	$("#massRadio").on("click", function(){
		$("#massRadio").attr('checked', 'checked');
		$("#segmentConArea").hide();
		$("#conditionConArea").hide();
		$("#uploadConArea").hide();
		$("#massConArea").show();
	});
	
	//세그먼트 라디오 클릭 시
	$("#segmentRadio").on("click", function(){
		$("#segmentRadio").attr('checked', 'checked');
		$("#massConArea").hide();
		$("#uploadConArea").hide();
		$("#conditionConArea").hide();
		$("#segmentConArea").show();
	});
	
	//조건추출 라디오 클릭 시
	$("#conditionRadio").on("click", function(){
		$("#conditionRadio").attr('checked', 'checked');
		$("#massConArea").hide();
		$("#segmentConArea").hide();
		$("#uploadConArea").hide();
		$("#conditionConArea").show();
	});
	
    //업로드 라디오 클릭 시
    $("#uploadRadio").on("click", function() {
    	$("#uploadRadio").attr('checked', 'checked');
    	$("#massConArea").hide();
        $("#segmentConArea").hide();
        $("#conditionConArea").hide();
        $("#uploadConArea").show();
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
#conditionConArea{display:none;}
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
					<ifvm:input type="radio" names="targetMethod" values="mass" checked="true" id="massRadio" />
					<spring:message code="S00049"/>
				</label>
<!-- 				<label class="radio-inline"> -->
<%-- 					<ifvm:input type="radio" names="targetMethod" values="segment" checked="true" id="segmentRadio" /> --%>
<%-- 					<spring:message code="S00007"/> --%>
<!-- 				</label> -->
				<label class="radio-inline">
					<ifvm:input type="radio" names="targetMethod" values="condition" id="conditionRadio" />
					<spring:message code="S00008"/>
				</label>
<!-- 				<label class="radio-inline"> -->
<%-- 					<ifvm:input type="radio" names="targetMethod" values="upload" id="uploadRadio" /> --%>
<%-- 					<spring:message code="M02436"/> --%>
<!-- 				</label> -->
			</div>
		</div> 
	</div>
</div>

<!-- 모든고객(MASS) -->
<div id="massConArea">
	<div class="well form-horizontal well_wrap pad0" id="massContent"></div>
</div>

<!-- 세그먼트 -->
<div id="segmentConArea">
	<div class="well form-horizontal well_wrap pad0" id="segmentContent"></div>
</div>

<!-- 조건추출 -->
<div id="conditionConArea">
	<div class="well form-horizontal well_wrap pad0" id="conditionContent"></div>
</div>

<!-- 업로드 -->
<div id="uploadConArea">
    <div class="well form-horizontal well_wrap pad0" id="importContent"></div>
</div>

<div id="segmentPopupCon" class="popup_container"></div>
<div id="conditionPopupCon" class="popup_container"></div>
<div id="importListPopup" class="popup_container"></div>