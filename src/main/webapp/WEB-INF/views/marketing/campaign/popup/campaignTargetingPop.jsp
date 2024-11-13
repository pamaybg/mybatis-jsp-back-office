<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
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
#hideFile {display:none}
#uploadMemberInfoGrid .grid_con{height:173px; overflow-x:hidden; overflow-y:auto;}
/* #tempTable1:before, #tempTable1:after, #tempTable2:before, #tempTable2:after {content: ' '; display: table; clear: both;} */
.campaign_load_contents .ui-th-ltr, .campaign_load_contents .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr:first-child {border-left: 1px solid #dddddd;}
#searchTypeL {width: 150px; float: left; height: 25px; margin-right: 3px;}
#searchKeyL {width: 200px; float: left; height: 25px;}
.target_body {border: 0px; display: none;}
</style>

<script>
var camId = "";             //캠페인 아이디
var workflowFlag = true;    //세그먼트 저장시 사용
var targetGroupListPopupData = "" //타겟그룹리스트팝업의 데이터
var getCampaignId = '<%= cleanXss(request.getParameter("id")) %>';	

/**
 * Init
 */
function campaignTargetingPopInit() {
    //pageSetUp();

    //cDialog.model.title = '<spring:message code="M00823"/>';
    //$("#dialog_title").append('<spring:message code="M00823"/>');
    
    cDialog.model.title = '대상자';
    $("#dialog_title").append('대상자');
    cDialog.model.width = "1090";
    cDialog.model.close = "closeCampaignTargetingPop";

    setTimeout(function() {
        cDialog.refresh();
    }, 1000);
}

/**
 * dialog close
 */
function closeCampaignTargetingPop(args) {
    cDialog._destroy();
}

/**
 * Init Data
 */
function campaignTargetingPopInitData() {

    //reset value
    var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");

    if ($.fn.ifvmIsNotEmpty(campaignInfo)) {
        camId = campaignInfo[0].addInfo.actualTaskId;
    }
    //get campaign info
    if (isNotEmpty(camId)) {
        $.ifvProgressControl(true);
        $.ifvPostJSON('<ifvm:action name="getCampaignTarget"/>',{
        	campaignId : camId
        }, function(result) {

            setCampaignTargetingPop(result);

        } , function(result) {
            $.messageCheckr(result.message);
            $.ifvProgressControl(false);
        });
    }
}

/**
 * 세그먼트 화면 설정(기존 세그먼트가 있으면 불러온다.)
 */
function setCampaignTargetingPop(result) {
    if (result != null) {
    	var tgtType = result.campaignTargetTypeCode;

        //Import
        if (tgtType== 'IMP') {
            $("#uploadRadio").prop('checked', true);

            $("#segmentConArea").hide();
            $("#uploadConArea").show();
            $("#sqlConArea").hide();
            $("#simpleConArea").hide();

            importLoad();
            targetImportMain.targetImportDetailLoad(result.tgtGroupId);
        } else if (tgtType == 'SQL') {
            $("#sqlRadio").prop('checked', true);

            $("#segmentConArea").hide();
            $("#uploadConArea").hide();
            $("#simpleConArea").hide();
            $("#sqlConArea").show();

            sqlLoad();
            targetSqlMain.targetSqlDetailLoad(result.tgtGroupId);
		} else if (tgtType == 'SEG') {
			$("#segmentRadio").prop('checked', true);
			
            $("#segmentConArea").show();
            $("#uploadConArea").hide();
            $("#sqlConArea").hide();
            $("#simpleConArea").hide();

            segmentLoad();
            loadTargetGroupDetailCon(result.tgtGroupId);
		} else if (tgtType == 'CND') {
			$("#simpleRadio").prop('checked', true);
			
            $("#segmentConArea").hide();
            $("#uploadConArea").hide();
            $("#sqlConArea").hide();
            $("#simpleConArea").show();

           	simpleLoad();
           	loadsimpleTargetingDetailCon(result.tgtGroupId);
        } 
        
        if (result.controlGroupUnitCode == "C" || result.controlGroupUnitCode == "R") {
        	if(result.controlGroupUnitCode == "C"){
        		$("#segmentConRadio").prop('checked', true);
        	}else if(result.controlGroupUnitCode == "R"){
    			$("#percentRadio").prop('checked', true);
        	}
        	$(".conTrolGroupMethodText").hide();
            $("#segmentMethodText").show();
            $("#segmentMethodText").val(result.controlGroupAmt);
                     
        }else if (result.controlGroupUnitCode == "T") {
			$("#targetGroupRadio").prop('checked', true);
            $("#segmentMethodText").hide();
        	$(".conTrolGroupMethodText").show();
			
        	$("#ctrlGroupId").val(result.ctrlGroupId);
            $("#conTrolGroupMethodText").val(result.tgtGroupNm);

        }
        
    }
    else {
        $.ifvProgressControl(false);
        $("#percentRadio").prop('checked', true);
        $("#percentRadio").attr('checked', 'checked');

        $("#segmentMethodText").show();
        $(".conTrolGroupMethodText").hide();

        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
            groupCode : 'MKT_TARGET_PER'
            , enableNA : true
        }, function(result) {

            const codeToInt = result.rows[0].codeName;
            $("#segmentMethodText").val(codeToInt);

        });

        if(empType != 'H'){
            $("#simpleRadio").prop('checked', true);

            $("#segmentConArea").hide();
            $("#uploadConArea").hide();
            $("#sqlConArea").hide();
            $("#simpleConArea").show();

            simpleLoad();
        }
    }
}

/**
 * 세그먼트 화면 Load
 */
function loadTargetGroupDetailCon(targetGroupId) {

    //타겟그룹이 있을경우 타겟그룹 상세 화면 로드
    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
        segmentLoad();
        targetGroupMain.saveBtnHide = true;

        //타겟그룹 상세화면 Load
        targetGroupMain.targetGroupDetailLoad(targetGroupId);
    }
    else {
        $.ifvProgressControl(false);
    }
}

/**
 * Import 화면 Load
 */
function loadTargetImportDetailCon(targetGroupId) {

    //타겟 Import가 있을경우 타겟Import 상세 화면 로드
    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
        importLoad();
        targetImportMain.saveBtnHide = true;

        //타겟그룹 상세화면 Load
        targetImportMain.targetImportDetailLoad(targetGroupId);
    }
}

/**
 * SQL 화면 Load
 */
function loadTargetImportDetailCon(targetGroupId) {

    //타겟 Import가 있을경우 타겟Import 상세 화면 로드
    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
    	sqlLoad();
    	targetSqlMain.saveBtnHide = true;
		
        //타겟그룹 상세화면 Load
        targetSqlMain.targetSqlDetailLoad(targetGroupId);
    }
}

/**
 * 조건추출 화면 Load
 */
function loadsimpleTargetingDetailCon(targetGroupId) {

    //타겟그룹이 있을경우 타겟그룹 상세 화면 로드
    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
        simpleLoad();
        simpleTargetingMain.saveBtnHide = true;

        //타겟그룹 상세화면 Load
        simpleTargetingMain.simpleTargetingDetailLoad(targetGroupId);
    }
    else {
        $.ifvProgressControl(false);
    }
}

//팝업 높이 설정
function setPopHeight() {
    setTimeout(function() {
      //popup 높이 맞추기
        new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });

        cDialog.refresh();
    }, 100);
}

//저장
function campaignTargetingSaveBtn() {
    var targetingType = $('input:radio[name="targetMethod"]:checked').val();
    var targetingConType = $('input:radio[name="conTrolGroupMethod"]:checked').val();
    var saveFlag = false;
    
    camId = campaign.id;
    //targeting 방법에 따른 저장
    //세그먼트
    if (targetingType == "segment") {
        $("#targetGroupMainSaveBtn").trigger("click");
    }
    //Import
    else if (targetingType == "upload") {
        $("#saveTargetGroupImportBtn").trigger("click");
    }
    //Simple
    else if (targetingType == "simple") {
        $("#simpleTargetingSave").trigger("click");
    }
    //타겟SQL *********************************
    else if (targetingType == "sql") {
        $('#targetSqlDtlSaveBtn').trigger("click");
    }
    
}

//캔버스 저장
function campaignTargetingPopSave() {
     diagram._selectedObject.taskType = diagram._selectedObject.nodeType;
     diagram._selectedObject.taskDataStatus = "U";

    //set actual task ID
    diagram._selectedObject.actualTaskId = campaign.id;

    //set campaign ID
    diagram._selectedObject.campaignId = campaign.id;

    //set old campaign ID
    diagram._selectedObject.oldCampaignId = campaign.id;

    //set alertFlag(현재 팝업에서 저장 alert창이 발생하여 중복 발생하지 않기 위해..)
    workflow.alertFlag = false;

    //save workflow
    saveWorkflow();

    //popup Close
    closeCampaignTargetingPop();
    
    if(campaign.id != null){
    	$.ifvProgressControl(false);
    	qtjs.href('<ifvm:url name="campaignWorkFlow"/>?type=MKT&id='+campaign.id);
    } else {
    	$.ifvProgressControl(false);
   		location.reload();
    }
}

//취소
function campaignTargetingCancelBtn() {
    closeCampaignTargetingPop();
}



//타겟그룹 저장
function saveCampaignTarget() {
	$.ifvProgressControl(true);
    if (camId != null && camId.length > 0 && camId != "null") {
        $('#campaignTargetingSaveBtn').hide()
        //타겟그룹 아이디 확인
        var targetGroupId = "";
        var isTargetGroup = targetGroup;
        if ($.fn.ifvmIsNotEmpty(isTargetGroup)) {
            if ($.fn.ifvmIsNotEmpty(targetGroup.targetGroupId))
            targetGroupId = targetGroup.targetGroupId;
        }

        if ($.fn.ifvmIsNotEmpty(targetGroupId)) {

            saveSegObj = {};
            saveSegObj.targetGroupId = targetGroupId;
            var targetingType = $('input:radio[name="targetMethod"]:checked').val();
            var targetName;
            //세그먼트
            if (targetingType == "segment") {
            	targetName = $("#targetGroupName").val();
            }
            //Import
            else if (targetingType == "upload") {
            	targetName = $("#targetGroupImpName").val();
            }
            //Simple
            else if (targetingType == "simple") {
            	targetName = $("#targetingName").val();
            	targetGroup.data.targetCount = targetCount;
            }
            //타겟SQL *********************************
            else if (targetingType == "sql") {
            	targetName = $("#targetSqlName").val();
            }else{
            	targetName = null;
            }
            saveSegObj.segName = targetName;
            saveSegObj.camId = camId;
            saveSegObj.segType = targetGroup.targetGroupType;
            saveSegObj.chnlType = $("#chnlType").val();
            saveSegObj.targetCustCnt = targetGroup.data.targetCount;
            
            if (targetGroup.data.comprGroupTypeCode != "undefined") {
            	saveSegObj.ctrlGroupUnitCd = targetGroup.data.comprGroupTypeCode;
            	saveSegObj.ctrlGroupAmt = targetGroup.data.comprGroupDtl;
            }

            //퀵캠페인 / 캠페인워크플로우 분기
            if (typeof campaignSubjectsPopData != "undefined"
                    && $.fn.ifvmIsNotEmpty(campaignSubjectsPopData.campaignChnlType)) {
                //캠페인 워크플로우에서의 세그먼트 유형
                saveSegObj.segType = campaignSubjectsPopData.campaignSegType;
                saveSegObj.chnlType = campaignSubjectsPopData.campaignChnlType;
            }
            
            
            // ctrl_group_unit_cd 비교군 유형
            saveSegObj.ctrlGroupUnitCd = $(":input:radio[name=conTrolGroupMethod]:checked").val();
            if(saveSegObj.ctrlGroupUnitCd == 'C' || saveSegObj.ctrlGroupUnitCd == 'R'){
                // ctrl_group_amt
                saveSegObj.ctrlGroupAmt = $(":input:text[name=conTrolGroupMethod]").val();
                
            }else if(saveSegObj.ctrlGroupUnitCd == 'T'){
            	// ctrl_group_id
	            saveSegObj.ctrlGroupId = $("#ctrlGroupId").val();
            }
            
            
            
            //타겟팅 저장
            $.ifvPostJSON('<ifvm:action name="saveCampaignTarget"/>',saveSegObj
                ,function(result) {

                alert("<spring:message code='M00267'/>");
                $("#segConfirmWrap").show();
                $("#segConfirmName").text(result.message);

                //캠페인 워크플로우일 경우
                if (workflowFlag) {
                    //캔버스 저장
                    campaignTargetingPopSave();
                }
                $.ifvProgressControl(false);
            }, function(result) {
                $.messageCheckr(result.message);
                $.ifvProgressControl(false);
            });
        }
        else {
            alert("<spring:message code='M00713'/>");
        }
    }
    else {
        alert("<spring:message code='M00710'/>");
    }
}



//공통코드 파일 유형 조회
function fileType() {
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
        groupCode : 'MKT_FILE_TYPE'
        , enableNA : true
    }, function(result) {

        var temp = $("#fileTypeTemplate").tmpl(result.rows);
        $("#fileType").append(temp);

    });
}

//세그먼트 템플릿 설정 코드 조회
function templateType() {
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
        groupCode : 'MKT_CAL_TYPE'
        , enableNA : true
    }, function(result) {

        var temp = $("#templateTypeTemplate").tmpl(result.rows);
        $("#templateTypeWrap").append(temp);

    });
};

/* 팝업 닫기 */
function segmentPopupClose() {
    segmentPopupCon.destroy();
}


function setMemberSearch() {
    var searchTypeL = $('#searchTypeL option:selected').val();
    var searchKeyL = $('#searchKeyL').val();

    if (searchKeyL == '') {
        gridData = oriGridData;
        uploadMemberInfoGridFunc();
    }
    else {
        gridData = [];

        $.each(oriGridData, function(index, data) {
            //회원 번호
            if (searchTypeL == '0') {
                if (data.memberId.indexOf(searchKeyL) > -1) {
                    gridData.push(data);
                }
            }
            //실패 사유
            else if (searchTypeL == '1') {
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

function enterCheck(evt) {
    var code = evt.which?evt.which:event.keyCode;
    if (code == 13) {
        setMemberSearch();
        return false;
    }
}

function nonSelectedListInit(nonSelectedList, tempData) {
    var objList = [];

    for (var k=0; k<tempData.attrValue.length; k++) {

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
       // tempId : 'listGridTemplete'
    };

    return $("#" + nonSelectedList).ifvGrid({ jqGridOption : jqGridOption });
}

function selectedListInit(selectedList, tempData) {
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
        //tempId : 'listGridTemplete'
    };

    return $("#" + selectedList).ifvGrid({ jqGridOption : jqGridOption });
}

/**
 * 타겟그룹 메인 불러오기
 */
function segmentLoad() {
    $.fn.ifvmLoadUiSetting("segmentContent", '<ifvm:url name="targetGroupMainLoad"/>');
    setPopHeight();
}

/**
 * Import 메인 불러오기
 */
function importLoad() {
    $.fn.ifvmLoadUiSetting("importContent", '<ifvm:url name="importTargetingMainLoad"/>');
    setPopHeight();
}

/**
 * 타겟SQL 메인 불러오기
 */
function sqlLoad() {
    $.fn.ifvmLoadUiSetting("sqlContent", '<ifvm:url name="targetSqlMainLoad"/>');
    setPopHeight();
}

/**
 * 조건추출 메인 불러오기
 */
function simpleLoad() {
    $.fn.ifvmLoadUiSetting("simpleContent", '<ifvm:url name="simpleTargetingLoad"/>');
    setPopHeight();
}

//load시 필요없는 항목 제거
function loadUiSetting() {
    $('.campaign_load_contents #header').remove();
    $('.campaign_load_contents #sideMenu').remove();
    $('.campaign_load_contents .page-title').remove();
    $("#contentsMessage .btn").addClass("btn_gray");
}

function addrSearchHelpBlur() {
}
function addrSearchHelpBtn() {
   searchStorePopInit();
}
function addrSearchHelpEnter() {
   searchStorePopInit();
}
function searchStorePopInit() {
   $("#targetGroupList").ifvsfPopup({
      enableModal : true,
      enableResize : false,
      contentUrl : '<ifvm:url name="targetGroupListPop"/>',
      contentType : "ajax",
      title : '<spring:message code="M01494"/>',
		width : 850,
		maxWidth : 2000,
		maxHeight : 2000,
		open : function() {
			searchCheck = 'y';
			new ifvm.PopupCenter({
				popupDivId : 'targetGroupList'
			});
		}
   });
}


function searchStorePopData() {
	
	var targetGroupListPopupData = targetGroupListPopGrid.getCheckedList();
	if(targetGroupListPopupData.length > 0){
		$('#ctrlGroupId').val(targetGroupListPopupData[0].targetGroupId);
		$('#conTrolGroupMethodText').val(targetGroupListPopupData[0].tgtGroupNo);
		targetGroupList._destroy();
	}else{
		alert('<spring:message code="L00066"/>');
	}
}
function searchStorePopClose() {
	targetGroupList._destroy();
}

$(document).ready(function() {

    $("#segmentConArea").show();
    segmentLoad();

    campaignTargetingPopInit();

    $("#segConfirmWrap").hide();

    //저장 문구 숨김
    $("#savedArea").hide();

    //업로드 결과 영역 최초 하이드
    $("#uploadResult").hide();

    //템플릿 설정 조회
    templateType();

    //공통코드 파일 유형 조회
    fileType();

    //매장&본사 체크
    if(empType != 'H'){
        $("#targetingContrastArea").attr('hidden', 'true');
        $('#segLabel').hide();
        $('#uploadLabel').hide();
    }

    //세그먼트 라디오 클릭 시
    $("#segmentRadio").on("click", function() {
        $("#segmentRadio").attr('checked', 'checked');
        $("#segmentConArea").show();
        $("#sqlConArea").hide();
        $("#uploadConArea").hide();
        $("#simpleConArea").hide();
        segmentLoad();
        setPopHeight();
    });

    //Import 라디오 클릭 시
    $("#uploadRadio").on("click", function() {
        $("#uploadRadio").attr('checked', 'checked');
        $("#segmentConArea").hide();
        $("#sqlConArea").hide();
        $("#uploadConArea").show();
        $("#simpleConArea").hide();

        importLoad();
        setPopHeight();
    });

    //Simple 라디오 클릭 시
    $("#simpleRadio").on("click", function() {
        $("#simpleRadio").attr('checked', 'checked');
        $("#segmentConArea").hide();
        $("#sqlConArea").hide();
        $("#uploadConArea").hide();
        $("#simpleConArea").show();

        simpleLoad();
        setPopHeight();
    });
    
    //SQL 라디오 클릭 시
    $('#sqlRadio').on('click', function() {
        $("#sqlRadio").attr('checked', 'checked');
        $("#segmentConArea").hide();
        $("#sqlConArea").show();
        $("#uploadConArea").hide();
        $("#simpleConArea").hide();
		
        sqlLoad();
        setPopHeight();
    });

    // if($("input:radio[id='segmentConRadio']").is(":checked")){
    //
    //     $("#segmentMethodText").val(0);
    //
    //     $(".conTrolGroupMethodText").hide();
    //     $("#segmentMethodText").show();
    //
    // }


    //대상수 라디오 클릭 시
    $("#segmentConRadio").on("click", function() {
    	
        $("#segmentConRadio").attr('checked', 'checked');
        $("#segmentMethodText").val(0);
        $(".conTrolGroupMethodText").hide();
        $("#segmentMethodText").show();

    });
    
    //비율 라디오 클릭 시
    $("#percentRadio").on("click", function() {
    	
        $("#percentRadio").attr('checked', 'checked');

        $(".conTrolGroupMethodText").hide();
        $("#segmentMethodText").show();

        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
            groupCode : 'MKT_TARGET_PER'
            , enableNA : true
        }, function(result) {

            const codeToInt = result.rows[0].codeName;
            $("#segmentMethodText").val(codeToInt);

        });

    });
    
    //타겟그룹 라디오 클릭 시
    $("#targetGroupRadio").on("click", function() {
    	
        $("#targetGroupRadio").attr('checked', 'checked');

        $("#segmentMethodText").hide();
        $(".conTrolGroupMethodText").show();
        
    }); 
 
    
    //저장 클릭시
    $('#campaignTargetingSaveBtn').on('click', function() {
        campaignTargetingSaveBtn();
    });

    //취소 클릭시
    $('#campaignTargetingCancelBtn').on('click', function() {
        campaignTargetingCancelBtn();
    });

    campaignTargetingPopInitData();
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


<div id="dialogPopupWrap">
    <input type="hidden" id="chnlType" value="">
    <input type="checkbox" id="fatigueExcept" style="visibility:hidden">

    <div class="pop_inner_wrap form-horizontal">
        <div class="row group_box_line popup_contents_height" id="targetingContents">
        
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

                            <label class="radio-inline" id="segLabel">
                                <ifvm:input type="radio" names="targetMethod" values="segment" checked="true" id="segmentRadio" />
                                <spring:message code="M01494"/>
                            </label>
                            <label class="radio-inline" id="uploadLabel">
                                <ifvm:input type="radio" names="targetMethod" values="upload" id="uploadRadio" />
                                <spring:message code="M02436"/>
                            </label>
<%--							<label class="radio-inline">--%>
<%--                                <ifvm:input type="radio" names="targetMethod" values="sql" id="sqlRadio" />--%>
<%--                                <spring:message code="M02856"/>--%>
<%--                            </label>--%>
                            <label class="radio-inline" id="simpleLabel">
                                <ifvm:input type="radio" names="targetMethod" values="simple" id="simpleRadio" />
                                <spring:message code="M02499"/>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <label class="col-xs-7">(당사에 회원 가입한 고객의 성별, 연령과 같은 기본적인 정보를 기준으로 선택)</label>
                </div>
            </div>            
            <!-- 대조군 -->
			<div id="targetingContrastArea">
                <div class="page_btn_area">
                    <div class="col-xs-12">
                        <span><spring:message code="M02952"/></span>
                    </div>
                </div>
                <div class="well form-horizontal well_sum">
                    <div class="row">
                        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00665"/></label>
                        <div class="col-xs-10 control_content">

                            <label class="radio-inline">
                                <ifvm:input type="radio" names="conTrolGroupMethod" values="C" id="segmentConRadio" />
                                <spring:message code="M01495"/>
                            </label>
                            
                            <label class="radio-inline">
                                <ifvm:input type="radio" names="conTrolGroupMethod" values="R" checked="true" id="percentRadio" />
                                <spring:message code="M01492"/>
                            </label>
                            
							<label class="radio-inline">
                                <ifvm:input type="hidden" names="conTrolGroupMethod" values="T" id="targetGroupRadio"/>
<%--                                 <spring:message code="M01494"/>--%>
                            </label>
                             <label class="sementMethodText">
                                <ifvm:inputNew type="text" names="conTrolGroupMethod" values="" id="segmentMethodText" />
                             </label>
                            
                             <label class="conTrolGroupMethodText">
           						 <ifvm:inputNew type="hidden" id="conTrolGroupMethodText" hidId="ctrlGroupId"  names="conTrolGroupMethod"  dto="conTrolGroupMethodText"
           						 	btnFunc="addrSearchHelpBtn" searchBlurEvent="addrSearchHelpBlur" searchEnterEvent="addrSearchHelpEnter"  />
                             </label>
                            
                        </div>
                    </div>
                </div>
            </div>
            
            
            <!-- 세그먼트 -->
            <div id="segmentConArea" class="target_body">
                <div class="well form-horizontal well_wrap pad0" id="segmentContent"></div>
            </div>

            <!-- 업로드 -->
            <div id="uploadConArea" class="target_body">
                <div class="well form-horizontal well_wrap pad0" id="importContent"></div>
            </div>
            
            <!-- SQL -->
<%--            <div id="sqlConArea" class="target_body">--%>
<%--                <div class="well form-horizontal well_wrap pad0" id="sqlContent"></div>--%>
<%--            </div>--%>
		
			<!-- 조건 추출 -->
            <div id="simpleConArea" class="target_body">
                <div class="well form-horizontal well_wrap pad0" id="simpleContent"></div>
            </div>
            
            <div id="segmentPopupCon" class="popup_container"></div>
            
        </div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="campaignTargetingSaveBtn" objCode="campaignTargetingSaveBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <button class="btn btn-sm btn_lightGray2 cancel" id="campaignTargetingCancelBtn" objCode="campaignTargetingCancelBtn_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

	<div id="conditionPopupCon"></div>
	<div id="targetGroupList"class="popup_container"></div>