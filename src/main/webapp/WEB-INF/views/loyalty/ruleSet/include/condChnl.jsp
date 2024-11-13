<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var condChnlListGrid;
var condChnlType;
var selCondChnlData;

function initPaymentPolicyData() {
	//그리드 설정
	setCondChnlListGridGrid();
}

/**
 * 구매 가맹점 그리드 출력
 */
function setCondChnlListGridGrid() {

	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	/* colNames.push("제한유형");								/* 제한 유형 */
	/* colNames.push("대상");								/* 대상 */
	colNames.push("<spring:message code='L00279'/>");	/* 스토어 코드 */
	colNames.push("<spring:message code='L00280'/>");	/* 스토어 명*/
	colNames.push('rid');
	/* colNames.push('ouTypeCd'); */
	/* colNames.push('type'); */
	/* colNames.push('prodDiv'); */

	/* colModel.push({name:'typeNm', index:'typeNm', resizable : false, align:'center', width:'80px'}); */
	/* colModel.push({name:'targetTypeNm', index:'targetTypeNm', resizable : false, align:'center', width:'80px'}); */
	colModel.push({name:'chnlNo', index:'chnlNo', resizable : false, align:'center', width:'80px', sortable: false});
	colModel.push({name:'chnlNm', index:'chnlNm', resizable : false, align:'center', width:'80px', sortable: false});
	colModel.push({name:'rid',    index:'rid', resizable : false, hidden : true,  searchable : false});
	/* colModel.push({name:'ouTypeCd',   index:'ouTypeCd',   resizable : false, hidden : true,  searchable : false}); */
	/* colModel.push({name:'type',   index:'type',   resizable : false, hidden : true,  searchable : false}); */
	/* colModel.push({name:'targetType',   index:'targetType',   resizable : false, hidden : true,  searchable : false}); */

	var jqGridOption = {
 		loadComplete : function(obj) {
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
	    	chnlPopupOpen('E');
        },
	    data: ruleSetData.rulesetCondChnlList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [10],
        sortname: 'lrc.CREATE_DATE',
		sortorder: "asc",
	    radio: true,
        tempId : 'ifvGridSimplePageTemplete'
	};

	condChnlListGrid = $("#condChnlListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/**
 * 대상경로 입력 팝업 열기
 */
function chnlPopupOpen(type) {

	condChnlType = type;

	if (type == "E") {
        var len = condChnlListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
        	selCondChnlData = condChnlListGrid.getSelectedRowData();
        }
		else {
			alert("<spring:message code='L00168'/>");
			return false;
		}
	}
	//초기화
	else {
		selCondChnlData = {};
	}
	
    $("#chnlInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="condChnlInfoPop"/>' + '?chnlOpenType=' + type,
        contentType: "ajax",
        title: '<spring:message code="L00162"/>',
        width: '500px',
        close : 'condChnlInfoPopupClose'
    });
}

//구매가맹점 정보 팝업 저장
function condChnlInfoPopupSave() {
	if (condChnlInfoPopValidation.confirm()) {
		var data = {};
		data.chnlNm = $.fn.ifvmIsEmpty($("#condChnlInfoPopDiv #chnlNm").val()) ? null : $("#condChnlInfoPopDiv #chnlNm").val();
		data.chnlNo = $.fn.ifvmIsEmpty($("#condChnlInfoPopDiv #chnlId").val()) ? null : $("#condChnlInfoPopDiv #chnlId").val();
		data.ridChnl = $.fn.ifvmIsEmpty($("#condChnlInfoPopDiv #ridChnl").val()) ? null : $("#condChnlInfoPopDiv #ridChnl").val();

		data.type = $.fn.ifvmIsEmpty($("#condChnlInfoPopDiv #type").val()) ? null : $("#condChnlInfoPopDiv #type").val();
		data.typeNm = $.fn.ifvmIsEmpty($("#condChnlInfoPopDiv #type option:selected").text()) ? null : $("#condChnlInfoPopDiv #type option:selected").text();
		data.targetType = $.fn.ifvmIsEmpty($("#condChnlInfoPopDiv #targetType").val()) ? null : $("#condChnlInfoPopDiv #targetType").val();
		data.targetTypeNm = $.fn.ifvmIsEmpty($("#condChnlInfoPopDiv #targetType option:selected").text()) ? null : $("#condChnlInfoPopDiv #targetType option:selected").text();
        // 단건 등록 설정 일 경우 한건만 등록가능
        /* if (chkGridFullCheck(condChnlListGrid.getDataRows(), $("#promSubType").val(), 0)) {
            return false;
        } */

        // 중복체크
        var popSave_strCheckedRid = condChnlType == "E" ? condChnlListGrid.getCheckedGridData()[0].rid : null;
            popSave_strCheckedRid = $.fn.ifvmIsEmpty(popSave_strCheckedRid) ? null : popSave_strCheckedRid;
        /* var popSave_getGridArry = condChnlListGrid.getDataRows(); */
        var popSave_getGridArry = ruleSetData.rulesetCondChnlList;

        for ( var i = 0 ; i < popSave_getGridArry.length ; i++ ) {

            var popSave_getGridArry_rid = popSave_getGridArry[i].rid == null ? "" : popSave_getGridArry[i].rid;

            // 신규이거나 수정이고 아이디가 다른경우
            if ( condChnlType == 'N'
                    || (condChnlType == 'E' && popSave_strCheckedRid != popSave_getGridArry_rid) ) {

                //가맹점코드와 가맹점 명이 모두 같은가?
                if ( /* popSave_getGridArry[i].ouTypeCd == data.ouTypeCd
                        &&  */popSave_getGridArry[i].chnlNo == data.chnlNo ) {
                    alert("<spring:message code='M00258'/>");
                    return false;
                }
            }
        }

		//수정 or 등록 여부 확인
		//수정
		if ($.fn.ifvmIsNotEmpty(selCondChnlData)) {
			/* selCondChnlData.ouTypeCd = data.ouTypeCd;
			selCondChnlData.ouTypeCdNm = data.ouTypeCdNm; */
			selCondChnlData.chnlNm = data.chnlNm;
			selCondChnlData.chnlNo = data.chnlNo;
			selCondChnlData.ridChnl = data.ridChnl;
			/* selCondChnlData.type = data.type;
			selCondChnlData.typeNm = data.typeNm;
			selCondChnlData.targetType = data.targetType;
			selCondChnlData.targetTypeNm = data.targetTypeNm; */

			var idx = condChnlListGrid.getRadioSelectedRowId();
			ruleSetData.rulesetCondChnlList.splice(idx-1, 1, selCondChnlData);

			//condChnlListGrid.setRowDatas(selCondChnlData);
			
		}
		//등록
		else {
			//초기데이터 존재 시 모두 삭제하고 신규등록한다.
			if(ruleSetData.rulesetCondChnlList.length === 1 && ruleSetData.rulesetCondChnlList[0].chnlNo === 'ALL') {
				condChnlListGrid.removeAll();
				ruleSetData.rulesetCondChnlList = [];
			}
			
			condChnlListGrid.addLocalTr(data);
			ruleSetData.rulesetCondChnlList.push(data);
		}

        //전역변수에 값 매핑
        //ruleSetData.rulesetCondChnlList = condChnlListGrid.getAllRowData();
		setCondChnlListGridGrid();

		//close popup
		condChnlInfoPopupClose();
	}
}

//구매가맹점 정보 팝업 닫기
function condChnlInfoPopupClose() {
	chnlInfoPopup._destroy();
}

//삭제
function chnlInfoRemove() {
	var idx = condChnlListGrid.getRadioSelectedRowId();
    var len = idx.length;
    if (len > 0) {
    	condChnlListGrid.delRowData();
    	ruleSetData.rulesetCondChnlList.remove(idx-1+((condChnlListGrid.opt.page.currentNum-1)*condChnlListGrid.jqGridOption.rowNum));
        setCondChnlListGridGrid();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

/**
 * 템플릿 다운로드
 * 채널 전체 목록을 엑셀로 다운로드한다.
 */
function chnlTemplateDown() {
	$.ifvProgressControl(true);
	$.get("<ifvm:action name='excelDownloadChannelTemplate'/>",
	function(result) {
		if ($.type(result) === "object") {
			if ($.fn.ifvmIsEmpty(result.message)) {
				$.errorChecker(result);
				$.ifvProgressControl(false);
			} else {
				alert(result.message);
				$.ifvProgressControl(false);
			}
		} else {
			location.href = "<ifvm:action name='excelDownloadChannelTemplate'/>";
			$.ifvProgressControl(false);
		}
	});
}

/**
 * 채널목록 초기화
 */
function chnlInfoReset() {
	condChnlListGrid.removeAll();
	ruleSetData.rulesetCondChnlList = [];
	
	//초기값 세팅
	var initData = {chnlNm:'전체', chnlNo:'ALL'};
	condChnlListGrid.addLocalTr(initData);
	ruleSetData.rulesetCondChnlList.push(initData);
	setCondChnlListGridGrid();
}

/**
 * 엑셀업로드
 */
function chnlTemplateUpload() {
	
	//업로드 전 초기세팅값만 존재 시 그리드 clear
	if(ruleSetData.rulesetCondChnlList.length === 1 && ruleSetData.rulesetCondChnlList[0].chnlNo === 'ALL') {
		condChnlListGrid.removeAll();
		ruleSetData.rulesetCondChnlList = [];
	}
	
	var validationCheck = false;

	// 파일 확장자 check
	if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'csv') {
		validationCheck = true;
	}
	if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xlsx'
			|| $("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xls') {
		validationCheck = true;
	}

	if (validationCheck) {
		$.ifvProgressControl(true);

		if (($("#hideFile")[0].files[0].type.split('/')[1] == 'vnd.ms-excel')
				|| $("#hideFile")[0].files[0].type.split('/')[1] == 'vnd.openxmlformats-officedocument.spreadsheetml.sheet') {

			var formData = new FormData();
			formData.append("file", $("#hideFile")[0].files[0]); //파일업로드
			formData.append("camId", $('#camId').val()); //캠페인 아이디
			formData.append("ridRuleset", $("#ridRuleset").val()); //룰셋 아이디

			$.ajax({
				url : '<ifvm:action name="excelUploadChannelTemplate"/>',
				data : formData,
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					//업로드 실패
					if (!data.success) {
						if ($.fn.ifvmIsEmpty(data.message)) {
							$.errorChecker(data);
							$.ifvProgressControl(false);
						} else {
							alert(data.message);
							$.ifvProgressControl(false);
						}
					} 
					//업로드 성공
					else {
						if(!$.fn.ifvmIsEmpty(data.channelList)) {
							$.merge(ruleSetData.rulesetCondChnlList, data.channelList)
							setCondChnlListGridGrid();
						}
						$.ifvProgressControl(false);
					}
				}
			});
		} else {
			alert("<spring:message code='M00703'/>");
			$("#hideFile").removeAttr("value");
		}
		//초기화
		$("#hideFile").val("");
	} else {
		alert("<spring:message code='M00703'/>");
		$("#hideFile").removeAttr("value");
	}
}

/**
 * 등록된 채널목록 엑셀 다운로드
 */
function chnlListDown() {
	
	var colModels = condChnlListGrid.jqGridOption.colModel;
	var colNames = condChnlListGrid.jqGridOption.colNames;
	var _colModels = [];
	var _colNames = [];
	$.each(colModels, function(i, e) {
		if(!(e.hasOwnProperty('hidden') && e.hidden) || !(e.hasOwnProperty('edittype') && e.edittype === 'radio')) {
			_colModels.push(e);
			_colNames.push(colNames[i]);
		}
	})
	
	$.ifvSyncPostJSON( '<ifvm:action name="excelExport"/>' ,{ 
		fileName : 'channelList_' + $.ifvGetTodayDate()
		, header: _colModels
		, headerName : _colNames
		, data : ruleSetData.rulesetCondChnlList
	}, function(result){
		location.href = result.message;
	});
}

$(document).ready(function() {
	initPaymentPolicyData();
	setFormAllDisabled();
	
	//저장된 대상경로 없을 경우 ALL 로 초기세팅
	if($.fn.ifvmIsEmpty(ruleSetData.rulesetCondChnlList)) {
		chnlInfoReset();
	}
	
    //신규
    $('#chnlNewBtn').on('click', function() {
    	chnlPopupOpen('N');
    });

    //삭제
    $("#chnlInfoRemoveBtn").on('click', function() {
    	chnlInfoRemove();
    });
    
    //템플릿 다운로드
    $("#chnlTemplateDownBtn").on('click', function() {
    	chnlTemplateDown();
    });
    
    //엑셀업로드
    $("#chnlTemplateUploadBtn").on('click', function() {
		$("#hideFile").trigger("click");
	});

	//엑셀업로드 파일 선택 시
	$("#hideFile").on("change", function() {
		chnlTemplateUpload();
	});
    
    //초기화
    $("#chnlInfoResetBtn").on('click', function() {
    	chnlInfoReset();
    });
    
    //엑셀 다운로드
    $("#chnlListDownBtn").on('click', function() {
    	chnlListDown();
    });
});
</script>

<style>
#hideFile {
	display: none
}
</style>

<%--

    <div class="well mg_bt0 underline form-horizontal" id="condChnlInfoDiv">
        <div class="row qt_border">
            기념일
            <label class="col-xs-2 span control-label">제한유형</label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="type" names="type" />
                </div>
            </div>

            비교연산자
            <label class="col-xs-2 span control-label">대상</label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="targetType" names="targetType"/>
                </div>
            </div>
        </div>
    </div> --%>

<div id="destinationPathWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="chnlNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='chnlInfoRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
            <button class="btn btn-sm" id='chnlTemplateDownBtn'>
                <spring:message code="M01748"/>
            </button>
            <button class="btn btn-sm" id='chnlTemplateUploadBtn'>
                <spring:message code="M01858"/>
            </button>
            <button class="btn btn-sm" id='chnlListDownBtn'>
                <spring:message code="M01218"/>
            </button>
            <ifvm:input type="file" id="hideFile" />
            <button class="btn btn-sm" id='chnlInfoResetBtn'>
                <spring:message code="L00031"/>
            </button>
        </div>
    </div>
    <div id="condChnlListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="chnlInfoPopup" class="popup_container"></div>
