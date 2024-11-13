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
#hideFile {display:none}
#importResult {color: #2312e8; font-weight: bold;}
#importResult span {display: inline-block; color: #3888aa; padding-left: 5px; font-weight: normal;}
</style>
<script>

var targetImport = {
        camId: '',
        viewType: '',
        segId: '',
        saveTargetObj: {},
        data: {}
}

var importListPopup;
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

function initIdsType() {
    if (targetImport.viewType == 'LIST') {
        $('#importSaveBtn').show();
        
        if ($.fn.ifvmIsNotEmpty(targetImport.camId)) {
        	$("#fileDownload").attr('disabled', 'disabled');
        	$("#searchFile").attr('disabled', 'disabled');
        	$("#targetRemoveBtn").attr('disabled', 'disabled');
        	$("#targetAddBtn").attr('disabled', 'disabled');
        }
    }
    else if (targetImport.viewType == 'COPY') {
        $('#importSaveBtn').hide();
        targetImport.copyFlag = true;
    }
}

function initTargetImportDetail() {
    var targetingId = '<%= cleanXss(request.getParameter("targetingId")) %>';
    var type = '<%= cleanXss(request.getParameter("type")) %>';
    var campaignId = '<%= cleanXss(request.getParameter("campaignId")) %>';

    targetImport.segId 	  = $.fn.ifvmIsEmpty(targetingId) || targetingId == "null" ? '' : targetingId;
    targetImport.camId    = $.fn.ifvmIsEmpty(campaignId)  || campaignId == "null"  ? '' : campaignId;
    targetImport.viewType = $.fn.ifvmIsEmpty(type) || type == "null" ? '' : type;
    
    //타겟 Import 조회
    getTargetImport();
}

/**
 * 타겟 Import 조회
 */
function getTargetImport() {
    var targetingId = targetImport.segId;

    var copyFlag = true;

    if ($.fn.ifvmIsNotEmpty(targetingId)) {

        // 임시저장 테이블에 데이터가 존재하는지 확인
        $.ifvPostJSON('<ifvm:action name="getTgtUploadTmpCount"/>', {
            ridTgtHad : targetImport.segId
        },
        function(result) {

            if (targetImport.viewType != 'LIST') {
                if (!checkNodeUnauthrized(campaign.id, 'TARGET')) {
                    copyFlag = true;
                    setPopupFormAllDisabled("dialog");
                    $('#dialog input[type=radio]').attr('disabled', 'disabled');
                }
                else if ($.fn.ifvmIsNotEmpty(result)) {
                    if (Number(result.count) > 0) {
                        if (confirm("<spring:message code='M02809'/>")) {
                            copyFlag = false;
                        }
                    }
                }
            }

            if ($.fn.ifvmIsNotEmpty(targetingId)) {
                $.ifvProgressControl(true);
                $.ifvPostJSON('<ifvm:action name="getTargetImportDtl"/>', {
                    segId: targetingId,
                    copyFlag: copyFlag
                },
                function(result) {

                    //타겟그룹 설정
                    initImportData(result);
                    targetImport.data = result;

                    initIdsType();
                },
                function(result) {
                    $.errorChecker(result);
                    $.ifvProgressControl(false);
                });
            }
            else {
                initIdsType();
                $.ifvProgressControl(false);
            }
        });
    }
}

/**
 * 상세 정보 출력
 */
function initImportData(result) {
    if ($.fn.ifvmIsNotEmpty(result)) {
        $("#uploadMainArea").hide();
        $("#uploadBodyArea").show();

        $("#uploadResult").show();

        //결과화면 출력
        $("#savedArea").show();
        $("#segNameTxt").text(result.segItem[0].segName);

        if (targetImport.viewType == 'LIST') {
	        targetImport.camId = result.segItem[0].camId;
        }

        //최종저장 시 사용 객체
        targetImport.saveTargetObj.dupCnt = result.dupCnt;
        targetImport.saveTargetObj.camId = result.segItem[0].camId;
        targetImport.saveTargetObj.segName = result.segItem[0].segName;
        targetImport.saveTargetObj.allUploadCnt = result.targetCustCnt;
        targetImport.saveTargetObj.fileName = result.segItem[0].fileName;
        targetImport.saveTargetObj.successCnt = result.agreeCust;
        targetImport.saveTargetObj.failCnt = result.segItem[0].fileFailCnt;

        $('#importTgtNm').val(result.segItem[0].segName);

        //파일 순서 결정
        if( $('#memType').val() != 'internal') {
            result.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
        }

        $("#importResult").html(targetImport.saveTargetObj.fileName);
        $("#importType").html($("#fileType").val());

        gridData = null;
        $("#uploadMemberInfoGrid").empty();

        uploadMemberInfoGridFunc();

        //업로드 결과 건수 조회
        var resultGridList = new Array();
        var resultAllCnt = {};
        var resultSuccessCnt = {};
        var resultFailCnt = {};

        resultAllCnt.name = "<spring:message code='M00700'/>";
        resultAllCnt.uploadCnt = result.targetCustCnt;

        resultSuccessCnt.name = "<spring:message code='M00701'/>";
        resultSuccessCnt.uploadCnt = result.agreeCust;

        resultFailCnt.name = "<spring:message code='M00702'/>";
        resultFailCnt.uploadCnt = result.segItem[0].fileFailCnt;

        resultGridList.push(resultAllCnt);
        resultGridList.push(resultSuccessCnt);
        resultGridList.push(resultFailCnt);

        uploadData = resultGridList;
    }
}

//실패사유 포맷
function failGridFormat(cellValue, options, rowdata) {
    var message = '';
    var sucessFlag = true;

    // 내부고객용
    if (rowdata.memberYn != null && rowdata.memberYn == 0) {

        if (message.length > 0) {
            message += ',';
        }
        message += "<spring:message code='M01017'/>";

        // 비동의일 때 이미지
        var imgFullPath = "<ifvm:image name='upload_red'/>";
        sucessFlag = false;
    }
    else if (rowdata.failFlag != null && rowdata.failFlag == '1') {

        // tm수신동의여부
        if (message.length > 0) {
            message += ',';
        }
        message += "<spring:message code='M01017'/>";

        // 비동의일 때 이미지
        var imgFullPath = "<ifvm:image name='upload_red'/>";
        sucessFlag = false;
    }

    if (sucessFlag) {
        message += "<spring:message code='M00253'/>";
        var imgFullPath = "<ifvm:image name='upload_green'/>";
    }

    var tempHtml = "<img src='" + imgFullPath + "' alt='' />";
    tempHtml += "<span class='grid_inner_text'>" + message + "</span>";

    return tempHtml;
}

//업로드 회원정보 그리드
function uploadMemberInfoGridFunc() {

    //컬럼 정보 조회
    getImportMbrGridColInfo();
	oriGridData = gridData;

    // 1 페이지 회원정보 조회
    var jqGridOption = {
        serializeGridData: function(data) {
            data.ridTgtHad = targetImport.segId;
			data.lgcCompId = uploadMamberGridInfo.lgcCompId;
            return data;
        },
        addGridDataWhenPaging: function(data) {
			data.lgcCompId = uploadMamberGridInfo.lgcCompId;
            return data;
        },
        loadComplete: function(obj) {
            $("#importCnt").html(uploadMemberInfoGrid.opt.data.records + '<spring:message code="C00036"/>');
        },
        url: '<ifvm:action name="getTargetImportTmpList"/>',
        colNames: uploadMamberGridInfo.colNames,
        colModel: uploadMamberGridInfo.colModel,
        sortname : 't1.item_seq',
        sortorder : "asc",
        multiselect: true,
        isHorizontalScroll : true
    };

    uploadMemberInfoGrid = $("#uploadMemberInfoGrid").ifvGrid({jqGridOption : jqGridOption});
    uploadMemberInfoGrid.resize();
    gridIduploadMemberInfoGrid = $("#gridIduploadMemberInfoGrid");
    gridIduploadMemberInfoGrid.setGridParam({data:gridData}).trigger("reloadGrid");
    setTimeout(function() {
        gridIduploadMemberInfoGrid.resize();
    }, 100);
}

var importTargetColPopup;

//컬럼 설정 팝업 열기
function importTargetColPopupOpen() {
    $("#importTargetColPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetGroupColumnSetPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01496" />',
        width: '600px',
        close : 'targetGroupColumnSetPopupClose'
    });
}

//컬럼 설정 팝업 닫기
function targetGroupColumnSetPopupClose(){
    importTargetColPopup._destroy();
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

        var colNum = 0;

        $.ifvSyncPostJSON('<ifvm:action name="getImportMbrColumnInfo"/>', {
        }, function(result) {

            if ($.fn.ifvmIsNotEmpty(result)) {
                // lc id
                uploadMamberGridInfo.lgcCompId = result.lgcCompId;

                uploadMamberGridInfo.colNames = [];
                uploadMamberGridInfo.colModel = [];

                uploadMamberGridInfo.colNames[colNum] = "memId"
                uploadMamberGridInfo.colModel[colNum] = {name: 'memId', index: 'memId', hidden: true};
                colNum++;

                result.colList.forEach(function(data) {
                    if (data.colType == 'C') {
                        uploadMamberGridInfo.colNames[colNum] = data.dpNm;
                        uploadMamberGridInfo.colModel[colNum] = {name: data.colAlias, index: data.colAlias, sortable: false, resizable: false};
                        colNum++;
                    }
                });
            }
        });
    }
}

/**
 * 파일 다운로드
 */
function tgt_fileDownload() {
	location.href= '<ifvm:url name="fileDownload"/>/internalCustomer.csv';
}

/**
 * 파일 검색 클릭 후 파일 선택 시 실행
 */
function tgt_fileSelected() {

    $("#savedArea").hide();
    var validationCheck = false;

    // 파일 확장자 check
    if ($("#fileType").val() == 'CSV') {
        if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'csv') {
            validationCheck = true;
        }
    }
    else {
        if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xlsx'
                || $("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xls') {
            validationCheck = true;
        }
    }

    if (validationCheck) {
    	$.ifvProgressControl(true);

        if (($("#hideFile")[0].files[0].type.split('/')[1] == 'vnd.ms-excel')
                || $("#hideFile")[0].files[0].type.split('/')[1] == 'vnd.openxmlformats-officedocument.spreadsheetml.sheet') {

            memId = [];

            var formData = new FormData();
            //파일업로드
            formData.append("file", $("#hideFile")[0].files[0]);
            //회원 구분
            formData.append("memType", $('#memType').val());
            //파일유형
            formData.append("uploadFileType", $("#fileType").val());
            //타겟 방법
            formData.append("tgtType", $(':radio[name="targetMethod"]:checked').val());

            var fatiExceptYn = '0';

            //피로도 체크 여부 확인
            if ($("input:checkbox[id='fatigueExcept']").is(":checked")) {
                fatiExceptYn = '1';
            }

            //피로도 제외 여부
            formData.append("fatiExceptYn", fatiExceptYn);

            //채널 유형
            if(typeof $("#chnlType").val() == 'undefined'
                    || $("#chnlType").val() == null
                    || $("#chnlType").val() == 'null'
                    || $("#chnlType").val() == '') {
                formData.append("chnlType", "");
            }
            else if($("#chnlType").val() == 'EMAIL') {
                formData.append("chnlType", "EMAIL");
            }
            else if($("#chnlType").val() == 'PUSH') {
                formData.append("chnlType", "PUSH");
            }
            else if($("#chnlType").val() == 'SMS') {
                formData.append("chnlType", "SMS");
            }
            else {
                formData.append("chnlType", "MMS");
            }

            formData.append("appServiceId", appServiceId);
            formData.append("country", country);
            formData.append("lang", lang);
            formData.append("camId", targetImport.camId);
            formData.append("addData", "0");	//추가 데이터 여부
            formData.append("ridTgtHad", targetImport.segId);
            formData.append("segName", $("#importTgtNm").val());

            $.ajax({
                url: '<ifvm:action name="setImportFileUpload"/>',
                data: formData,
                processData: false,
                contentType: false,
                type: 'POST',
                success: function(data) {

                    // 확장자 오류
                    if (data.uploadValidCheck == 'EXT') {
                        alert("<spring:message code='M00703'/>");
                        $("#hideFile").removeAttr("value");
                    }
                    // 파일용량 오류
                    else if (data.uploadValidCheck == 'SIZE') {
                        alert("<spring:message code='M02506'/>");
                        $("#hideFile").removeAttr("value");
                    }
                    else {
                        $("#uploadResult").show();
                        initIdsType();

                        if ($.fn.ifvmIsEmpty(data.memberList)) {
                            data.memberList = [];
                        }

                        if (data.errorType == 200410) {
                            location.href = '<ifvm:url name="MKTLogin"/>';
                        }
                        //최종저장 시 사용 객체
                        targetImport.saveTargetObj.dupCnt = data.dupCnt;
                        //targetImport.saveTargetObj.allUploadCnt = data.allUploadCnt;
                        targetImport.saveTargetObj.targetCustCnt = data.targetCustCnt;
                        targetImport.saveTargetObj.fileName = data.fileName;
                        targetImport.saveTargetObj.agreeCust = data.agreeCust;
                        targetImport.saveTargetObj.failCnt = data.failCnt;
                        targetImport.saveTargetObj.fatiCnt = data.fatiCnt;
                        targetImport.saveTargetObj.prmsCnt = data.prmsCnt;

                        //파일 순서 결정
                        if( $('#memType').val() != 'internal') {
                            data.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
                        }

                        $("#importResult").html(targetImport.saveTargetObj.fileName + " <span id='fileConfirmTextArea'><spring:message code='M00687'/></span>");
                        $("#importType").html($("#fileType").val());

                        gridData = null;
                        $("#uploadMemberInfoGrid").empty();

                        //업로드 결과 회원 정보 조회
                        $("#importTgtNm").val(data.segName);
                        targetImport.segId = data.targetId;

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
                    }
                }
            });
        }
        else {
            alert("<spring:message code='M00703'/>");
            $("#hideFile").removeAttr("value");
        }
        //초기화
        $("#hideFile").val("");
    }
    else {
        alert("<spring:message code='M00703'/>");
        $("#hideFile").removeAttr("value");
    }
}

/**
 * import 엑셀 다운로드
 */
function importExcelDownload() {
    var param = "targetId=" + targetImport.segId;
	param += "&lgcCompId=" + uploadMamberGridInfo.lgcCompId;
    location.href = '<ifvm:action name="exportExcelTargetImportTargetList"/>?' + param;
}

/**
 * 선택된 대상자목록 삭제
 *
 * @author hy.jun
 */
function targetRemove() {

	var selectDataList = uploadMemberInfoGrid.getCheckedGridData();
	var memberList = new Array();

	if (selectDataList.length > 0) {
	    if (confirm("<spring:message code='M00127'/>")) {
		    for (var i = 0 ; i < selectDataList.length ; i++) {
		        memberList.push({memberId: selectDataList[i].memId});
		    }

		    $.ifvSyncPostJSON( '<ifvm:action name="removeFileTargetTmpDtlList"/>', {
		          camId     : targetImport.camId
		        , ridTgtHad : targetImport.segId
		        , memberList: memberList
		    }, function(result) {
		       	alert("<spring:message code='M00255'/>")
		        uploadMemberInfoGridFunc();
		    });
	    }
	}
	else {
	   	alert("<spring:message code='M00285'/>");
	}
}

/**
 * 추가업로드 버튼 클릭 시 파일선택창 load
 *
 * @author hy.jun
 */
function targetAdd() {
	$("#hideFile2").trigger("click");
}

/**
 * 추가업로드 파일 선택 시
 *
 * @author hy.jun
 */
function tgt_fileSelected_added() {
    $("#savedArea").hide();
    var validationCheck = false;

    // 파일 확장자 check
    if ($("#fileType").val() == 'CSV') {
        if ($("#hideFile2")[0].files[0].name.split('.')[1].toLowerCase() == 'csv') {
            validationCheck = true;
        }
    }
    else {
        if ($("#hideFile2")[0].files[0].name.split('.')[1].toLowerCase() == 'xlsx'
                || $("#hideFile2")[0].files[0].name.split('.')[1].toLowerCase() == 'xls') {
            validationCheck = true;
        }
    }

    if (validationCheck) {
    	$.ifvProgressControl(true);

        if (($("#hideFile2")[0].files[0].type.split('/')[1] == 'vnd.ms-excel')
                || $("#hideFile2")[0].files[0].type.split('/')[1] == 'vnd.openxmlformats-officedocument.spreadsheetml.sheet') {

            memId = [];

            var formData = new FormData();
            //파일업로드
            formData.append("file", $("#hideFile2")[0].files[0]);
            //회원 구분
            formData.append("memType", $('#memType').val());
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
            if (typeof $("#chnlType").val() == 'undefined'
                || $("#chnlType").val() == null
                || $("#chnlType").val() == 'null'
                    || $("#chnlType").val() == '') {
                formData.append("chnlType", "");
            }
            else if ($("#chnlType").val() == 'EMAIL') {
                formData.append("chnlType", "EMAIL");
            }
            else if ($("#chnlType").val() == 'PUSH') {
                formData.append("chnlType", "PUSH");
            }
            else if ($("#chnlType").val() == 'SMS') {
                formData.append("chnlType", "SMS");
            }
            else {
                formData.append("chnlType", "MMS");
            }

            formData.append("appServiceId", appServiceId);
            formData.append("country", country);
            formData.append("lang", lang);
            formData.append("camId", targetImport.camId);
            formData.append("addData", "1");	//추가 데이터 여부
            formData.append("ridTgtHad", targetImport.segId);
            formData.append("segName", $("#importTgtNm").val());

            $.ajax({
                url: '<ifvm:action name="setImportFileUpload"/>',
                data: formData,
                processData: false,
                contentType: false,
                type: 'POST',
                success: function(data) {
                    $("#uploadResult").show();

                    if ($.fn.ifvmIsEmpty(data.memberList)) {
                        data.memberList = [];
                    }

                    if (data.errorType == 200410) {
                        location.href = '<ifvm:url name="MKTLogin"/>';
                    }

                    //최종저장 시 사용 객체에 추가업로드개수 +
                    targetImport.saveTargetObj.dupCnt = Number(targetImport.saveTargetObj.dupCnt) + Number(data.dupCnt);
                    targetImport.saveTargetObj.allUploadCnt = Number(targetImport.saveTargetObj.allUploadCnt) + Number(data.allUploadCnt);
                    targetImport.saveTargetObj.targetCustCnt = Number(targetImport.saveTargetObj.targetCustCnt + Number(data.targetCustCnt));
                    targetImport.saveTargetObj.failCnt = Number(targetImport.saveTargetObj.failCnt) + Number(data.failCnt);

                    //파일 순서 결정
                    if( $('#memType').val() != 'internal') {
                        data.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
                    }

                    targetImport.segId = data.targetId;

                    uploadMemberInfoGridFunc();

                    //기존 업로드 결과 조회
                    var resultGridList = uploadData;
                    var resultAllCnt = uploadData[0];
                    var resultSuccessCnt = uploadData[1];
                    var resultFailCnt = uploadData[2];

                    //기존 업로드 결과 + 추가 업로드 결과
                    resultAllCnt.uploadCnt = Number(resultAllCnt.uploadCnt) + Number(data.targetCustCnt);
                    resultSuccessCnt.uploadCnt = Number(resultSuccessCnt.uploadCnt) + Number(data.agreeCust);
                    resultFailCnt.uploadCnt = Number(resultFailCnt.uploadCnt) + Number(data.failCnt);

                    resultGridList.push(resultAllCnt);
                    resultGridList.push(resultSuccessCnt);
                    resultGridList.push(resultFailCnt);

                    uploadData = resultGridList;
                }
            });
        }
        else {
            alert("<spring:message code='M00703'/>");
            $("#hideFile2").removeAttr("value");
        }
        //초기화
        $("#hideFile2").val("");
    }
    else {
        alert("<spring:message code='M00703'/>");
        $("#hideFile2").removeAttr("value");
    }
}

//저장
function saveTargetImport() {
    var validationCheck = importValidation.confirm();
    if (validationCheck == true) {
        $.ifvProgressControl(true);

        initIdsType();

        targetImport.saveTargetObj.camId = targetImport.camId;
        targetImport.saveTargetObj.targetId = targetImport.segId;
        targetImport.saveTargetObj.segName = $("#importTgtNm").val();
        targetImport.saveTargetObj.segType = 'IMP';
        targetImport.saveTargetObj.fileType = $("#fileType").val();
        targetImport.saveTargetObj.memType = $("#memType").val();
        targetImport.saveTargetObj.copyFlag = targetImport.copyFlag;

        //퀵캠페인 / 캠페인워크플로우 분기
        if (typeof campaignSubjectsPopData != "undefined"
                    && $.fn.ifvmIsNotEmpty(campaignSubjectsPopData.campaignChnlType)) {
            //캠페인 워크플로우에서의 세그먼트 유형
            targetImport.saveTargetObj.segType = campaignSubjectsPopData.campaignSegType;
            targetImport.saveTargetObj.chnlType = campaignSubjectsPopData.campaignChnlType;
        }

        $.ifvPostJSON('<ifvm:action name="setTargetImport"/>', targetImport.saveTargetObj,
        // 성공
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                segName = result.message;

                $("#savedArea").show();
                $("#segNameTxt").text(segName);

                //캠페인 워크플로우일 경우
                try {
                    if (workflowFlag) {
                        //캔버스 저장
                        campaignTargetingPopSave();
                    }
                }
                catch (e) {
                }

                alert('<spring:message code="C00094"/>');
            }

            $.ifvProgressControl(false);

            //리스트 화면 이동
            if (targetImport.viewType == 'LIST') {
                location.href =  '<ifvm:url name="targetGroupList"/>';
            }
        },
        //실패
        function(result) {
            $.messageCheckr(result.message);
            $.ifvProgressControl(false);
        });
    }
}

function chkCamStatus() {
	if (!checkNodeUnauthrized(campaign.id, 'TARGET')) {
	    //roi, monitoring 제외
	    setPopupFormAllDisabled("dialog");
	};
}

$(document).ready(function() {
    $.ifvmLnbSetting('targetGroupListNew');

    initTargetImportDetail();

	//추가 업로드 file 태그 숨김처리
	$("#hideFile2").hide();

    //템플릿 파일 다운로드 버튼 클릭 시
    $("#fileDownload").on('click', function() {
        tgt_fileDownload();
    });
    //Import 검색 클릭 시
    $("#searchFile").on("click", function() {
        $("#hideFile").trigger("click");
    });
    //Import 검색 클릭 후 파일 선택 시 실행
    $("#hideFile").on("change", function() {
        tgt_fileSelected();
    });

    //저장버튼 클릭 시
    $("#targetSaveBtn").on('click', function() {
        saveTargetImport();
    });
    $("#targetSaveBtn").hide();

    $('#importSaveBtn').on('click', function() {
        saveTargetImport();
    });

    //엑셀 다운로드
    $('#importExcelDownloadBtn').on('click', function() {
        importExcelDownload();
    });

    //대상자 선택 삭제 버튼 클릭 시
    $('#targetRemoveBtn').on('click', function() {
    	targetRemove();
    });

    //대상자 추가 업로드 버튼 클릭 시
    $('#targetAddBtn').on('click', function() {
    	targetAdd();
    });

    //대상자 추가 업로드 대상 파일 선택 후
    $("#hideFile2").on("change", function() {
        tgt_fileSelected_added();
    });

    // validation 설정
    importValidation = $("#uploadBodyArea").ifvValidation();
});

</script>

<ifvm:input type="hidden" id="memType" values="internal"/>
<ifvm:input type="hidden" id="fileType" values="CSV"/>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="M02436"/></span>
    </div>
    <div class="col-xs-5 searchbtn_r">

        <%-- 템플릿 다운로드 --%>
        <button class="btn btn-sm" id="fileDownload">
            <spring:message code="M01748"/>
        </button>

        <%-- Import 실행 --%>
        <button class="btn btn-sm" id="searchFile">
            <spring:message code="M02437"/>
        </button>
        <ifvm:input type="file" id="hideFile"/>
        <button class="btn btn-sm" id="targetSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>

        <%-- 저장 --%>
        <button class="btn btn-sm" id="importSaveBtn" style="display: none">
            <spring:message code="L00074"/>
        </button>

        <%-- 목록 --%>
        <button class="btn btn-sm" id="importMainOpenBtn" style="display: none">
            <spring:message code="L00824"/>
        </button>
    </div>
</div>

<div class="well form-horizontal well_wrap">
    <div class="row qt_border">

        <%-- 타겟팅명 --%>
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02438"/></label>
        <div class="col-xs-8 control_content">
            <ifvm:input type="text" required="true" id="importTgtNm"/>
        </div>
    </div>
    <div class="row qt_border">

        <%-- Import 유형 --%>
        <label class="col-xs-2 control-label"><spring:message code="M02439"/></label>
        <label class="col-xs-6 control-label text-left" id="importType"></label>
    </div>
    <div class="row qt_border">

        <%-- Import 결과 --%>
        <label class="col-xs-2 control-label"><spring:message code="M02440"/></label>
        <label class="col-xs-6 control-label text-left detail_txt" id="importResult"></label>
    </div>
    <div class="row qt_border">

        <%-- Import 건수 --%>
        <label class="col-xs-2 control-label"><spring:message code="M02441"/></label>
        <label class="col-xs-6 control-label text-left" id="importCnt"></label>
    </div>
</div>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="M01217"/></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="targetRemoveBtn">
            <spring:message code="S00046" />
        </button>
        <button class="btn btn-sm" id="targetAddBtn">
            <spring:message code="S00047" />
        </button>
        <ifvm:input type="file" id="hideFile2"/>
        <button class="btn btn-sm" id="importExcelDownloadBtn">
            <spring:message code="M01218" />
        </button>
    </div>
</div>
<div id="uploadMemberInfoGrid"></div>

<div id="importTargetColPopup" class="popup_container"></div>