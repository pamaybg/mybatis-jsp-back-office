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
<script type="text/javascript">
var approverListGrid;
var valcheck = true;
var detail = false;
var sysdate = new Date();
var approvalDialog;
var chid = '<%= cleanXss(request.getParameter("id")) %>';
var disabledType = '<%= cleanXss(request.getParameter("type")) %>';
var saveCheck = false;         //실제 파일을 지우기 위한 체크
var aprvStore = '';
var createBy;
var isValid;
var FileData;
var approvalHtmlContents;
var html;
var saveChk = false;
var addChk = false; //결제자,참조자 추가 됬는지 체크
var approvalDetailData = {
    htmlContents: '',
    status: '',
};
var dataArray = new Array();
var aprvStore;
var count = 0;
var AprbCheck = false;
var empIdList = [];
var refempIdList = [];
var notClick = true;
var FormNewPop;

/**
 * 기안자 및 부서 세팅
 * @returns
 */
function initCreSetting() {

    $("#approvalPopupSangsinCancelBtn").hide();
    $("#approvalPopupAprvsendBtn").hide();

    $("#createDate").val(sysdate.getFullYear() + "-" + (sysdate.getMonth() + 1) + "-" + sysdate.getDate());

    // 승인업무 유형
    $.fn.ifvmSetSelectOptionCommCode("elecAprvTypeCd", "APRV_TYPE_CD", null, null, true);
	//승인업무유형 : 회원 지수 관리 고정
    $("#elecAprvTypeCd").val('06');

    // 승인상태
    $.fn.ifvmSetSelectOptionCommCode("elecAprvStatusCd", "EL_APPROVAL_STATUS_CD", null, null, true);

    getgridDataReload();
}

/**
 * 상세정보 호출
 */
function idCheck() {

    if (chid != "null") {

        //정보 세팅
        $.ifvSyncPostJSON('<ifvm:action name="getScoringDetailAprv"/>', {
            id : chid
        }, function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {

                saveChk = true;

                $("#approvalPopupAprvsendBtn").hide();
                $("#approvalPopupSangsinCancelBtn").hide();
                $("#approvalPopupSaveBtn").hide();
                $("#aprvAdd").hide();
                $("#aprvDel").hide();

                $('#btnsend').hide();
                $('#btnSave').hide();
                $('#cancle').hide();

                $("#camNm").val(result.camNm);
                $("#scrId").text(result.camId);
                $("#camContent").val(result.camDesc);

                $("#elecAprvTypeCd").val(result.elecAprvTypeCd);
                $("#elecAprvRqtrId").val(result.elecAprvRqtrId);
                $("#elecAprvRqtrNm").val(result.elecAprvRqtrNm);
                $("#elecAprvRqtrOrgId").val(result.elecAprvRqtrOrgId);
                $("#elecAprvRqtrOrgNm").val(result.elecAprvRqtrOrgNm);
                $("#createDate").val(result.createDd);
                $("#elecAprvStatusCd").val(result.elecAprvStatusCd);
                $("#elecAprvSbst").val(result.contetnt);

                html = result.contetnt;
                notClick = true;

                //작성 중
                if (result.elecAprvStatusCd == "001") {
                    $("#approvalPopupSaveBtn").show();
                    $("#approvalPopupAprvsendBtn").show();
                    $("#approvalPopupSangsinCancelBtn").show();
                    $("#aprvAdd").show();
                    $("#aprvDel").show();
                    $('#btnsend').show();   //결제상신
                    $('#cancle').show();    //작성취소
                    $('#btnSave').show();   //저장
                }
                // 결재 진행중
                else if (result.elecAprvStatusCd == "010") {
                    notClick = false;
                    aprvStore = "013";
                }
                // 작성 취소
                else if (result.elecAprvStatusCd == "002") {
                    $("#approvalPopupSaveBtn").show();
                    $("#approvalPopupAprvsendBtn").show();
                    $("#aprvAdd").show();
                    $("#aprvDel").show();
                    $('#btnSave').show();   //저장
                    $('#btnsend').show();   //결제상신
                }
                // 결재 반려
                else if (result.elecAprvStatusCd == "020") {
                    notClick = false;
                    $("#approvalPopupSaveBtn").show();
                    $("#approvalPopupAprvsendBtn").show();
                    $("#aprvAdd").show();
                    $("#aprvDel").show();

                    $('#btnsend').show();   //결제상신
                    $('#cancle').show();    //작성취소
                    $('#btnSave').show();   //저장
                }
                // 승인 완료
                else if (result.elecAprvStatusCd == "090") {
                    notClick = false;
                }
                else {
                }

                approvalDetailData.status = result.elecAprvStatusCd;
                approvalDetailData.htmlContents = result.contetnt;

                //수정 권한 트루
                detail = true;
            }
        });

        if (disabledType == "ref" || disabledType == "aprv") {

        }
    }
    else {
        AprbCheck = true;
    }

    if (detail == false) {
        var empId = $.ifvmGetUserInfo().empId;
        var empName = $.ifvmGetUserInfo().empName;
        var orgId = $.ifvmGetUserInfo().orgId;
        var orgName = $.ifvmGetUserInfo().orgName;

        //승인요청자 기본 설정
        $("#elecAprvRqtrId").val(empId);
        $("#elecAprvRqtrNm").val(empName);
        $("#elecAprvRqtrOrgId").val(orgId);
        $("#elecAprvRqtrOrgNm").val(orgName);
    }
}

//저장 버튼클릭 시 동작
function actionApproval() {

    isValid = validation.confirm();
    if (isValid) {

        // 상세 페이지일 시 수정 작업 동작
        if (detail) {

            //수정
            $.ifvSyncPostJSON('<ifvm:action name="editElapproval"/>', {
                  camId             : scoringApprovalData.scoringInfo.id
                , id                : chid
                , elecAprvTitle     : scoringApprovalData.scoringInfo.scrNm
                , elecAprvStatusCd  : $("#elecAprvStatusCd").val()
                , elecAprvTypeCd    : '06' //승인업무유형 : 회원 지수 관리 
                , elecAprvRqtrId    : $("#elecAprvRqtrId").val()
                , elecAprvRqtrOrgId : $("#elecAprvRqtrOrgId").val()
                , elecAprvStatusCd  : $("#elecAprvStatusCd").val()
                , elecAprvSbst      : $("#elecAprvSbst").val()
            }, function(result) {
                alert('<spring:message code="M00991"/>');
            });
        }
        // 상세 페이지가 아닐 시 insert 동작
        else {
            //language code
            $.ifvSyncPostJSON('<ifvm:action name="setApproval"/>', {
                  camId             : scoringApprovalData.scoringInfo.id
                , elecAprvTitle     : scoringApprovalData.scoringInfo.scrNm
                , elecAprvStatusCd  : '001'
                , elecAprvTypeCd    : '06' //승인업무유형 : 회원 지수 관리
                , elecAprvRqtrId    : $("#elecAprvRqtrId").val()
                , elecAprvRqtrOrgId : $("#elecAprvRqtrOrgId").val()
                , elecAprvStatusCd  : $("#elecAprvStatusCd").val()
                , elecAprvSbst      : $("#elecAprvSbst").val()
            }, function(result) {
                chid = result.message;
                alert('<spring:message code="M00990"/>');
                if (addChk) {
                    updateSaveAprv();
                }
            });
        }
    }
    idCheck();
}


function deleteAprvList(fromTbl, toTbl) {

    var active = 0;
    var checkedList = approverListGrid.getCheckedGridData();
    var listFlowIdList = [];
    var count = checkedList.length;

    if(checkedList.length != 0){
        for( var i = 0; i < checkedList.length; i++ ){
            listFlowIdList.push( checkedList[i].id );
        }

        var size = dataArray.length -1;
        var dataStore = new Object();
        for(var i=0;i<=size;i++){
            dataStore[size-i] = dataArray.pop();
        }

        for(var i=0;i<=size-count+1;i++){
            if(dataStore[i].id != listFlowIdList){
                dataArray.push(dataStore[i]);
            }
        }

        $.ifvSyncPostJSON('<ifvm:action name="removeItem"/>',{
            listChannelFlowId : listFlowIdList
        },function(result) {
            alert('<spring:message code="M00622"/>');
            approverListGrid.delCheckedRow();
        });
        reDefined();
    }
    else{
        alert('<spring:message code="M00285"/>');
    }
}

function getIddeleteAprvList() {
    var listFlowIdList = [];
    var checkedList = approverListGrid.getRowData();
    $.ifvSyncPostJSON('<ifvm:action name="removeItem"/>',{
        id : chid
    },function(result) {

    });
}

//페이지를 벗어날 시 Grid Data 자동 삭제
function delPageOutAprv() {
    var listFlowIdList = [];
    var gridSize = approverListGrid.getRowData().length;
    if (gridSize != 0) {
        for (var i = 0; i < gridSize; i++) {
            listFlowIdList.push(approverListGrid.getRowData()[i].id);
        }
        $.ifvSyncPostJSON('<ifvm:action name="removeItem"/>', {
            listChannelFlowId : listFlowIdList
        }, function(result) {
        });
    }
}

//페이지를 벗어날 시 Grid Data 자동 삭제
function updateSaveAprv(){
    var listFlowIdList = [];
    var gridSize = approverListGrid.getRowData().length;
    if(gridSize != 0){
        for(var i=0;i<gridSize;i++){
            listFlowIdList.push( approverListGrid.getRowData()[i].id );
        }

        $.ifvSyncPostJSON('<ifvm:action name="editItem"/>',{
             elecId : chid
            ,listChannelFlowId : listFlowIdList
        },function(result) {
        });
    }
}

//승인 완료 후 Disabled 처리
function allDisabled() {
    $("#elecAprvStatusCd").attr('disabled', 'true');
    $("#elecAprvSbst").attr('disabled', 'true');
    $("#camContent").attr('disabled', 'true');
    $("#aprvAdd").attr('disabled', 'true');
    $("#aprvDel").attr('disabled', 'true');
    $("#aprvRefAdd").attr('disabled', 'true');
    $("#aprvRefDel").attr('disabled', 'true');
    $("#fileAdd").attr('disabled', 'true');
    $("#fileRemoveBtn").attr('disabled', 'true');
}

// 승인 완료 후 Disabled 처리
function allDisabledFalse() {
    $("#elecAprvStatusCd").attr('disabled', 'false');
    $("#elecAprvSbst").attr('disabled', 'false');
    $("#camContent").attr('disabled', 'false');
    $("#aprvAdd").attr('disabled', 'false');
    $("#aprvDel").attr('disabled', 'false');
    $("#aprvRefAdd").attr('disabled', 'false');
    $("#aprvRefDel").attr('disabled', 'false');
    $("#fileAdd").attr('disabled', 'false');
    $("#fileRemoveBtn").attr('disabled', 'false');
}

//결제 승인자
function initApproverListGrid() {

    var jqGridOption = {
        data: dataArray,
        datatype: 'clientSide',
        colNames:['<spring:message code="M00953"/>',
                  '<spring:message code="M00954"/>',
                  '<spring:message code="M00955"/>',
                  '<spring:message code="M00956"/>',
                  '<spring:message code="M00957"/>',
                  '<spring:message code="M00958"/>',
                  'id',
        ],
        colModel:[
            {name:'seq',            index:'meai.ELEC_APRV_SEQ', resizable : false },
            {name:'apprvType',      index:'c1.MARK_NAME',       resizable : false },
            {name:'apprvName',      index:'c3.NAME',            resizable : false },
            {name:'apprvDept',      index:'c5.name',            resizable : false },
            {name:'elApproveStatus',index:'c2.MARK_NAME',       resizable : false },
            {name:'apvDd',          index:'meai.apv_dd',        resizable : false },
            {name:'id',             index:'meai.ID',            resizable : false, hidden:true, key:true},
        ],
        rowList : [100000],
        radio : true,
        gridview:true,
        tempId : 'approvalPopTemplete',
    };
    approverListGrid = $("#approverListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function getTotal() {
    $("#approverListGrid").find(".total_area").children().text('<spring:message code="M00172"/>' + ": " + dataArray.length + '<spring:message code="M00964"/>');
}

/**
 * 팝업 닫기
 */
function FormNewPopClose() {
    FormNewPop._destroy();
}

/**
 * 데이터를 배열에 담기(DB내의 Data를 배열에 담는 초기 세팅)
 */
function getgridDataReload() {

    var size = dataArray.length;
    for (var i = 0; i < size; i++) {
        dataArray.pop();
    }
    // 그리드 Data Setting
    if (chid != "null") {

        $.ifvSyncPostJSON('<ifvm:action name="getAprvList"/>', {
            id : chid
        }, function(result) {
            var size = result.length;

            for (var i = 0; i < size; i++) {
                AprbCheck = true;
                var dataStore = new Object();
                dataStore.seq = result[i].seq;
                dataStore.apprvType = result[i].apprvType;
                dataStore.apprvName = result[i].apprvName;
                dataStore.apprvDept = result[i].apprvDept;
                dataStore.elApproveStatus = result[i].elApproveStatus;
                dataStore.apvDd = result[i].apvDd;
                dataStore.id = result[i].id;
                dataStore.reqarvrId = result[i].apvrId;
                dataStore.reqOrgId = result[i].acId;
                dataArray.push(dataStore);
            }
        });
    }
}

//그리드 데이타 세팅 후 추가(행 추가)
function setReGrid() {
    var size = dataArray.length;

    for(var i=0;i<size;i++){
        var dataStore = new Object();

        dataStore.seq = dataArray[i].seq
        dataStore.apprvType = dataArray[i].apprvType
        dataStore.apprvName = dataArray[i].apprvName
        dataStore.apprvDept = dataArray[i].apprvDept
        dataStore.elApproveStatus = dataArray[i].elApproveStatus
        dataStore.apvDd = dataArray[i].apvDd
        dataStore.id = dataArray[i].id
        approverListGrid.addLocalTr(dataStore);
    }

}

function reDefined() {

    approverListGrid.removeAll();
    var size = dataArray.length;
    for(var i=0;i<size;i++){
        dataArray[i].apprvType = '<spring:message code="M00949"/>';
        if(i == (size-1)) dataArray[size-1].apprvType = '<spring:message code="M00972"/>';
        dataArray[i].seq = i+1;

        approverListGrid.addLocalTr(dataArray[i]);
    }
}

//결제자 추가
function setRow() {

    var size = dataArray.length;
    for(var i=0;i<size;i++){
        var dataStore = new Object();
        $.ifvSyncPostJSON('<ifvm:action name="setItemApproval"/>', {
                  aprvId : chid
                , arvrId : dataArray[i].reqarvrId
                , orgId  : dataArray[i].reqOrgId
                , apvrType : '9'
                , aprbStatus : aprvStore
        },function(result) {
        },function(result) {
            if (result.errorType == 700100) {
                alert('<spring:message code="M00993"/>'); //최대 사용자를 초과하였습니다.
            }
		});
	}

	//필수결재자 추가
	$.ifvSyncPostJSON('<ifvm:action name="setRequiredItemApproval"/>', {
		aprvId : chid
	},function(result) {
	},function(result) {
		if (result.errorType == 1) {
			alert('<spring:message code="M00995"/>'); //결재자를 추가해주세요.

			//상태 값 코드
			$.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>',{
			      elecAprvStatusCd : '002'
			    , id : chid
			}, function(result) {
			});

			idCheck();
		}
	});
}

window.onbeforeunload = function() {
    if (saveChk == false) {
        if(addChk) delPageOutAprv();
    }
}

//현재 추가된 목록 가져오기.
function getempIdList() {
    var size = dataArray.length;
    empIdList = [];
    refempIdList = [];
    for (var i = 0; i < size; i++) {
        empIdList.push(dataArray[i].reqarvrId);
    }
}

/**
 * 승인요청자 선택시
 */
function selectApprovalEmp() {

    var len = approvalEmpGrid.getCheckedGridData().length;
    if (len > 0) {
        var data = approvalEmpGrid.getCheckedGridData()[0];
        $('#elecAprvRqtrNm').val(data.empNm);
        $('#elecAprvRqtrId').val(data.id);
        $('#elecAprvRqtrOrgNm').val(data.accNm);
        $('#elecAprvRqtrOrgId').val(data.acId);

        FormNewPopClose();

        //popup 높이 맞추기
        initPopupHeight();
    }
    else {
        alert('<spring:message code="L00066"/>');
    }
}

//popup 높이 맞추기
function initPopupHeight() {
  setTimeout(function() {
      try {
          new ifvm.PopupHeight({
              popupDivId : 'dialog',
              contentsId : 'dialogPopupWrap'
          });
          cDialog.refresh();
      }
      catch(e) {
      }
  }, 500);
}

$(document).ready(function() {

    $.ifvmLnbSetting('approvalList');

    pageSetUp();

    //초기 Data 세팅
    initCreSetting();

    // 상세 조회
    idCheck();

    $("#aprvDel").on("click", function() {
        deleteAprvList();
        getTotal();
    });

    //결재 상신
    $("#btnsend").on("click", function() {
        if (dataArray.length > 0) {

            // scoring 상태 체크
            $.ifvSyncPostJSON('<ifvm:action name="scoringStatusCheck"/>', {
                scrId: scoringApprovalData.scoringInfo.id,
                useApproval: true
            }, function(result) {

            	switch(result.message) {
            	case '3':
            		//선택한 지수 관리에 연결된 노드가 있으나, 등록된 정보가 없어 지수 관리 활성을 진행 할 수 없습니다. 해당 노드를 삭제하거나, 노드의 정보를 저장 후 진행 바랍니다.
                    alert("<spring:message code='L02243' />");
                    $.ifvProgressControl(false);
            		break;
            	case '6':
            		//지수 관리는 실행유형을 선택해야 활성 할 수 있습니다.
                    alert("<spring:message code='L02244' />");
                    $.ifvProgressControl(false);
            		break;
            	case '7':
            		//지수 관리는 실행유형을 선택해야 결재 상신 할 수 있습니다.
                    alert("<spring:message code='L02245' />");
                    $.ifvProgressControl(false);
            		break;
            	case '12':
            		//전자결재 승인이 완료되지 않아 활성을 진행할 수 없습니다. 전자결재 완료 후 진행 바랍니다.
                    alert("<spring:message code='L02246' />");
                    $.ifvProgressControl(false);
            		break;
            	case '13':
            		//선택한 지수 관리에 연결된 노드가 있으나, 등록된 정보가 없어 결재 상신을 진행 할 수 없습니다. 해당 노드를 삭제하거나, 노드의 정보를 저장 후 진행 바랍니다.
                    alert("<spring:message code='L02247' />");
                    $.ifvProgressControl(false);
            		break;
            	default :
            		//결제라인 추가
                    saveChk = true;
                    var approverList = new Array();
                    dataArray.forEach(function(data) {
                        approverList.push({
                            id : data.reqarvrId,
                            seq : data.seq,
                        });
                    });

                    //결제 상신
                    $.ifvSyncPostJSON('<ifvm:action name="scoringRequestApproval"/>', {
                        recordRid : scoringApprovalData.scoringInfo.id,
                        aprvTitle : scoringApprovalData.scoringInfo.scrNm,
                        aprvType  : $('#elecAprvTypeCd').val(),
                        reqRid    : $('#elecAprvRqtrId').val(),
                        approverList : approverList,
                        rid : chid,
                    }, function(result) {
                    	
                    });

                    //상세화면 조회
                    idCheck();

                    if (AprbCheck == true) {
//                         getIddeleteAprvList();
                    }
//                     approverListGrid.removeAll();
//                     setRow();
                    getgridDataReload();
                    initApproverListGrid();
            	}
            }
            , function(result) {
            	if (result.message == '97') {
            		//지수 관리 활성에 실패하였습니다.\\n관리자에게 문의하세요.
            		alert('<spring:message code="L02242" />');
                    $.ifvProgressControl(false);
                }
            });
        }
        else {
            alert('<spring:message code="M00995"/>');
        }
    });

    //작성 취소
    $("#cancle").on("click", function() {

        //결제 승인자 초기화
        $.ifvSyncPostJSON('<ifvm:action name="removeItem"/>',{
            id : chid
        }, function(result) {
        });

        //상태 값 코드
        $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>',{
              elecAprvStatusCd : '002'
            , id : chid
        }, function(result) {
        });

        dataArray = [];
        $('#elecAprvSbst').val('');

        //$("#btnSave").click();
        initApproverListGrid();

        idCheck();
    });

    //저장
    $("#btnSave").on("click", function() {
        if (disabledType == "ref"
                || disabledType == "aprv") {
        } else {
            //생성 및 수정
            actionApproval();

            $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>',{
                elecAprvStatusCd : '001'
              , id : chid
          }, function(result) {
        	  idCheck();
          });
        }
        //현재 설정되어 있는 Grid Data delete 후 새로 등록.
        if (AprbCheck) {
            getIddeleteAprvList();
        }
        setRow();
        getgridDataReload();
        initApproverListGrid();
    });

    if ($(".popup_container #approvelDetailWrap").length > 0) {
        //팝업일 때
        //그리드 사이즈
        $(".pop_grid").addClass("pop1024_grid");
        initApproverListGrid();
    }
    else {
        initApproverListGrid();
    }

    /*
    $("#btnCampop").on("click", function() {
        if(notClick){
            $("#FormNewPop").ifvsfPopup({
                enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="camListPop"/>',
                contentType: "ajax",
                title: '<spring:message code="M00967"/>',
                width: 600,
                close : 'FormNewPopClose',
                open : function(){
                    new ifvm.PopupCenter({
                        popupDivId : 'FormNewPop'
                    });
                }
            });
        }

        FormNewPop = $("#FormNewPop").data("ejDialog");
    });
    */

    $("#aprvAdd").on("click", function() {
        $("#FormNewPop").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="empListPop"/>?id='+ chid,
            contentType: "ajax",
            title: '<spring:message code="M00981"/>',
            width: 600,
            close : 'FormNewPopClose',
            open : function(){
                new ifvm.PopupCenter({
                    popupDivId : 'FormNewPop'
                });
            }
        });

        getempIdList();
        empListPopGrid.requestData({ empId : empIdList });
    });

    validation = $("#approvalBasicInfo").ifvValidation();

});
</script>

<script id="commStatustemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="approvalPopTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        {title}
        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
            <div class="total_area">{total}</div>
        <div>
    </div>
</script>

<div id="approvelDetailWrap">
    <div class="page-title page_hidden">
        <h1>
            <spring:message code="M00937" />
            <span> &gt; <spring:message code="M00938" /></span>
        </h1>
    </div>
    <div class="page_btn_area page_border">
        <div class="col-xs-7">
            <span><spring:message code="M00939" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r" id="approvalDetailBtnDiv">
            <%-- 결제상신 --%>
            <button id="btnsend" class="btn btn-sm">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00987" />
            </button>
            <button id="cancle" class="btn btn-sm">
                <spring:message code="M00940" />
            </button>
            <%-- 저장 --%>
            <button id="btnSave" class="btn btn-sm">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00137" />
            </button>
        </div>
    </div>

    <div class="well mg_bt0 underline form-horizontal" id="approvalBasicInfo">
        <ifvm:input type="hidden" id="camNm"/>
        <div class="row qt_border">

            <%-- 승인업무유형 --%>
            <label class="col-xs-2 span control-label"><spring:message code="M02396" /></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="select" id="elecAprvTypeCd" names="elecAprvTypeCd" disabled="true"/>
            </div>

            <%-- 승인요청자 --%>
            <label class="col-xs-2 span control-label"><spring:message code="L01437" /></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="text" readonly="true" id="elecAprvRqtrNm" names="elecAprvRqtrNm" />
                <ifvm:input type="hidden" id="elecAprvRqtrId" names="elecAprvRqtrId" />
            </div>
        </div>

        <div class="row qt_border">

            <%-- 승인요청일자 --%>
            <label class="col-xs-2 span control-label"><spring:message code="M02397" /></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="date" disabled="true" id="createDate"/>
            </div>

            <%-- 승인요청자 부서 --%>
            <label class="col-xs-2 span control-label"><spring:message code="M02398" /></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="text" disabled="true" id="elecAprvRqtrOrgNm"/>
                <ifvm:input type="hidden" id="elecAprvRqtrOrgId"/>
            </div>
        </div>
        <div class="row qt_border">

            <%-- 승인상태 --%>
            <label class="col-xs-2 span control-label"><spring:message code="M00946" /></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="select" disabled="true" id="elecAprvStatusCd" names="elecAprvStatusCd"/>
            </div>
        </div>
        <div class="row">

            <%-- 설명 --%>
            <label class="col-xs-2 span control-label"><spring:message code="M00947" /></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="textarea" rows="4" id="elecAprvSbst" maxLength="200"/>
            </div>
        </div>
    </div>
    <div class="well row well_sum">
        <div class="col-xs-12">
            <div class="temp_title" id="">
                <spring:message code="M00948"/>
                <div class="pop_top_btn mg_top">
                    <button class="btn btn-sm btn_gray" id="aprvAdd">
                        <i class="fa fa-plus"></i>
                        <spring:message code="M00951"/>
                    </button>
                    <button class="btn btn-sm btn_gray" id="aprvDel">
                        <i class="fa fa-minus"></i>
                        <spring:message code="M00952"/>
                    </button>
                </div>
            </div>
            <div id="approverListGrid" class="pop_grid"></div>
        </div>
    </div>
</div>
<div id="FormNewPop"></div>
