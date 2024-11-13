<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
        
        //최종저장 시 사용 객체
        saveTargetObj.dupCnt = result.dupCnt;
        saveTargetObj.segName = result.segItem[0].segName;
        saveTargetObj.allUploadCnt = result.targetCustCnt;
        saveTargetObj.targetCustCnt = result.targetCustCnt;
        saveTargetObj.fileName = result.segItem[0].fileName;
        saveTargetObj.memberList = result.memberList;
        saveTargetObj.successCnt = result.agreeCust;
        saveTargetObj.failCnt = result.segItem[0].fileFailCnt;
        
        $('#importTgtNm').val(result.segItem[0].segName);
        
        //파일 순서 결정
        if( $('#memType').val() != 'internal') {
            result.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
        }
        
        $("#importResult").html(saveTargetObj.fileName);
        $("#importType").html($("#fileType").val());
        $("#importCnt").html(result.memberList.length + '<spring:message code="C00036"/>');
        
        //$("#fileConfirmTextArea").text("<spring:message code='M00687'/>");
        gridData = null;
        $("#uploadMemberInfoGrid").empty();
        
        //업로드 결과 회원 정보 조회
        gridData = result.memberList;
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
        multiselect: true,
        forceClientSorting: true
    };
    uploadMemberInfoGrid = $("#uploadMemberInfoGrid").ifvGrid({jqGridOption : jqGridOption});
    uploadMemberInfoGrid.opt.postData = {page: 1};
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
        width: 400,
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
    	$.ifvProgressControl(true);
        $.ifvPostJSON('<ifvm:action name="getImportMbrData"/>', {
            page : page,
            lgcCompId : uploadMamberGridInfo.lgcCompId,
            memberList : saveTargetObj.memberList.slice(start, end)
        }, function(result) { //callback
            var cnt = 0;
            result.memberList.forEach(function(data) {
                gridData.splice(start + cnt, 1, data);
                cnt++;
            });
            $.ifvProgressControl(false);
        }, function(result) { //errorCallback
        	$.ifvProgressControl(false);
        });
    }
}

//파일 다운로드
function tgt_fileDownload() {
    if($('#memType').val() == 'internal'){
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

/**
 * 타겟Import 목록에서 불러오기 선택 
 */
function importListSelect() {
	
    var len = importListPopGrid.getCheckedGridData().length;
    
    if (len > 0) {
        var selectData = importListPopGrid.getCheckedGridData()[0];
        
        $.ifvPostJSON('<ifvm:action name="getQuickCampaign"/>',{ 
            camId : selectData.camId 
        }
        ,function(result) {
            //get chnl type
//            $("#chnlType").val(getChnlType());
            //피로도 제외여부
//            if (getFatigueExcept()) {
//                $("input:checkbox[id='fatigueExcept']").attr("checked", true);
//            }
            setCampaignTargetingPop(result);
        }
        ,function(result) {
            $.messageCheckr(result.message);
        });
        importListPopupClose();
    }
    else {
        alert('<spring:message code="L00066"/>');
    }
}

function setImportSaveBtn() {
	if(!(camStatusCd == 'A' //활성
				|| camStatusCd == 'I' //비활성
				|| camStatusCd == 'S' //중지
				|| camStatusCd == 'C' //취소
				|| camStatusCd == 'E' //완료
				|| camStatusCd == '010' //결재진행중
				|| camStatusCd == '090' //승인완료 
				|| camStatusCd == '091')){ //강제승인
	    $("#targetSaveBtn").remove();
	    //저장 버튼 추가
		$($("#uploadBodyArea .page_btn_area .searchbtn_r")[0]).append('<button class="btn btn-sm btn_gray" id="targetSaveBtn"><i class="glyphicon glyphicon-check"></i>저장</button>');
	    
	    //저장버튼 클릭 시
	    $("#targetSaveBtn").on('click', function() {
	        saveTarget();
	    });
	}
}

//파일 검색 클릭 후 파일 선택 시 실행
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
            if($("input:checkbox[id='fatigueExcept']").is(":checked")){
                fatiExceptYn = '1';
            }
            
            //피로도 제외 여부
            formData.append("fatiExceptYn", fatiExceptYn);
            
            //채널 유형
            if(typeof $("#chnlType").val() == 'undefined' 
                    || $("#chnlType").val() == null 
                    || $("#chnlType").val() == 'null' 
                    || $("#chnlType").val() == ''){
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
		    
		                    if (data.errorType == 200410) {
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
		                    if( $('#memType').val() != 'internal') {
		                        data.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
		                    }
		                    
		                    $("#importResult").html(saveTargetObj.fileName + " <span id='fileConfirmTextArea'><spring:message code='M00687'/></span>");
		                    $("#importType").html($("#fileType").val());
		                    $("#importCnt").html(data.memberList.length + '<spring:message code="C00036"/>');
		                    
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
    var pattern = /<img[^>]*\/><span[^>]*>([^>]*)<\/span>$/g;
    gridData.forEach(function(rowData) {
        var _html = failGridFormat('', '', rowData);
        var arry;
        while ((arry = pattern.exec(_html)) != null) {
            rowData.successYn = arry[1];
        }
    });
    
    $.ifvSyncPostJSON( '<ifvm:action name="excelExport"/>', { 
          fileName : 'campaign_' + $.ifvGetTodayDate()
        , header: uploadMemberInfoGrid.jqGridOption.colModel
        , headerName : uploadMemberInfoGrid.jqGridOption.colNames 
        , data : gridData
    }, function(result) {
        qtjs.href(result.message);
    });
}

/**
 * 선택된 대상자목록 삭제
 *
 * @author hy.jun
 */
function targetRemove() {
	var selectlist = uploadMemberInfoGrid.getCheckedRowIds();
	var selectlist2 = selectlist;
	
	if(selectlist.length == 0) {
		alert('<spring:message code="C00113"/>');
		return false;
	}

	var currentPageNum = uploadMemberInfoGrid.opt.page.currentNum - 1;
	if(currentPageNum > 0) {
		selectlist2 = [];
		selectlist.forEach(function(idx) {
			idx = Number(idx) + Number(currentPageNum * 10);
			selectlist2.push(String(idx));
		})
	}
	
	
	var gridData2 = [];
	for( var j=0; j<gridData.length; j++ ) {
		if( selectlist2.indexOf( String(j + 1) ) < 0 ){
			gridData2.push( gridData[j] );
		}
	}
	
	gridData = gridData2;
	uploadMemberInfoGrid.delCheckedRow();
	saveTargetObj.memberList = gridData; 
	saveTargetObj.targetCustCnt = gridData.length; //충전소캠페인 목록 컬럼 중 고객수 컬럼 노출로 인해 추가
	uploadMemberInfoGridFunc();
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
            if(typeof $("#chnlType").val() == 'undefined' 
                    || $("#chnlType").val() == null 
                    || $("#chnlType").val() == 'null' 
                    || $("#chnlType").val() == ''){
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
                    success: function(data) {
                    $("#uploadResult").show();
    
                    if (data.errorType == 200410) {
                        qtjs.href('<ifvm:url name="MKTLogin"/>');
                    }
                    //최종저장 시 사용 객체에 추가업로드개수 +
                    saveTargetObj.dupCnt = Number(saveTargetObj.dupCnt) + Number(data.dupCnt);
                    saveTargetObj.allUploadCnt = Number(saveTargetObj.allUploadCnt) + Number(data.allUploadCnt);
                    saveTargetObj.targetCustCnt = Number(saveTargetObj.targetCustCnt + Number(data.targetCustCnt));
                    saveTargetObj.failCnt = Number(saveTargetObj.failCnt) + Number(data.failCnt);

                    //최종저장 시 사용 객체에 추가업로드내역 add (saveTargetObj)
                    //대상자목록 그리드 그릴때 사용되는 객체에 추가업로드내역 add (gridData)
					for(var a=0; a<data.memberList.length; a++) {
// 	                    saveTargetObj.memberList.unshift(data.memberList[a]);
	                    gridData.unshift(data.memberList[a]); //saveTargetObj.memberList 에 반영 시 gridData에도 반영이 일어나는 현상으로 인해 주석처리
					}
                    
                    //파일 순서 결정
                    if( $('#memType').val() != 'internal') {
                        data.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
                    }
                    
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

$(document).ready(function() {
	//추가 업로드 file 태그 숨김처리
	$("#hideFile2").hide();
	
    if ($.fn.ifvmIsNotEmpty(saveTargetObj.fileName)) {
        $("#uploadMainArea").hide();
        $("#uploadBodyArea").show();
    }
    else {
        $("#uploadMainArea").show();
        $("#uploadBodyArea").hide();
    }
    
    //Import 목록 버튼
    $("#importMainOpenBtn").on("click", function() {
        $("#uploadMainArea").show();
        $("#uploadBodyArea").hide();
    });
    //Import 불러오기 팝업 오픈 버튼
    $("#importListOpenBtn").on("click", function() {
        $("#importListPopup").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="stnImportListPopup"/>',
            contentType: "ajax",
            title: '<spring:message code="M01494"/>',
            width: 800,
            close : 'importListPopupClose'
        });
    });
    //Import 버튼 
    $("#importNewPageOpenBtn").on("click", function() {
        $("#uploadMainArea").hide();
        $("#uploadBodyArea").show();
        
        uploadMemberInfoGridFunc();
    });

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
        setImportSaveBtn();
    });

    //저장버튼 클릭 시
    $("#targetSaveBtn").on('click', function() {
        saveTarget();
    });
    $("#targetSaveBtn").hide();

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
        setImportSaveBtn();
    });
    
    // validation 설정
    importValidation = $("#uploadBodyArea").ifvValidation();
});

</script>

<div id="uploadMainArea">
    <div class="page_btn_area">
        <div class="col-xs-12">
            <span><spring:message code="M01494"/></span>
        </div>
    </div>
    <div class="user_main_area">
        <div class="main_area main1">
            <p class="user_txt user_tit"><spring:message code="M02444"/></p>
            <p class="user_txt user_desc"><spring:message code="M02446"/></p>
            <button class="user_btn_list" id="importListOpenBtn">
                <spring:message code="M02448"/>
            </button>
        </div>
        <div class="main_area main2">
            <p class="user_txt user_tit"><spring:message code="M02445"/></p>
            <p class="user_txt user_desc"><spring:message code="M02447"/></p>
            <button class="user_btn_list" id="importNewPageOpenBtn">
                <spring:message code="M02436"/>
            </button>
        </div>
    </div>
</div>
<div id="uploadBodyArea">
    <ifvm:input type="hidden" id="memType" values="internal"/>
    <ifvm:input type="hidden" id="fileType" values="CSV"/>
    
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M02436"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        
            <%-- 템플릿 다운로드 --%>
            <button class="btn btn-sm btn_gray" id="fileDownload">
                <spring:message code="M01748"/>
            </button>
            
            <%-- Import 실행 --%>
            <button class="btn btn-sm btn_gray" id="searchFile">         
                <spring:message code="M02437"/>
            </button>
            <ifvm:input type="file" id="hideFile"/>
            <button class="btn btn-sm btn_gray" id="targetSaveBtn">
                <i class="glyphicon glyphicon-check"></i>     
                <spring:message code="M00280"/>
            </button>
            
            <%-- 목록 --%>
            <button class="btn btn-sm btn_gray" id="importMainOpenBtn">
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
</div>

<div id="importListPopup" class="popup_container"></div>
<div id="importTargetColPopup" class="popup_container"></div>