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
<script type="text/javascript">
var targetGroupImportTargetListGrid;
var targetGroup = {
        targetGroupId: "",
        targetGroupType: "IMP",
        data: {}
}
var targetCnt ="";
var targetColumnLen = 0;

function initTargetGroupImportDetail() {
    var targetGroupId = '<%= cleanXss(request.getParameter("targetGroupId")) %>';
    targetGroup.targetGroupId = $.fn.ifvmIsEmpty(targetGroupId) || targetGroupId == "null" ? '' : targetGroupId;

    //타겟그룹 상세 조회
    getTargetGroupImport();
}

//타겟그룹 상세 조회
function getTargetGroupImport() {
    var targetGroupId = targetGroup.targetGroupId;

    $.ifvProgressControl(true);

    $.ifvPostJSON('<ifvm:action name="getTargetGroupImportDetail"/>', {
    	targetGroupId: targetGroupId
    },
    function(result) {
        //타겟그룹 설정
        setTargetGroupImport(result);
        targetGroup.data = result;

        getTargetGroupTargetList(false);
    },
    function(result) {
        $.errorChecker(result);
        $.ifvProgressControl(false);
    });
}

//1000단위 정규식
function numberWithCommas(x) {
    if ($.fn.ifvmIsNotEmpty(x)) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    else return 0;
}

//타겟그룹 설정
function setTargetGroupImport(data) {
	if ($.fn.ifvmIsNotEmpty(data)) {
	    $("#targetGroupImpName").val(data.targetGroupName);
	    $("#targetGroupImpDesc").val(data.targetGroupDesc);
	    $("#impFileNm").val(data.impFileNm);
	    if(data.extrYn=="Y"){
	    	$("#extrYn").prop('checked',true);
	    	$("#columnSetBtn").prop('disabled',true);
	    }
	    //대상수 조회 오류 발생시 메시지
	    if (data.targetCount == "MSG_T0001") {
	        $.ifvErrorPop('<spring:message code="M01694"/>');
	    } else {
	    	$("#targetCount").val(numberWithCommas(data.targetCount));
	    	targetCnt = data.targetCount;
	    }
	}
}

//타겟그룹 대상자 목록
function getTargetGroupTargetList(getSelectFlag) {
    var targetGroupId = targetGroup.targetGroupId;
    var targetGroupImportColList = [];

    //타겟그룹 대상자 컬럼 목록 조회
    $.ifvSyncPostJSON('<ifvm:action name="getTargetGroupImportColumnList"/>', {
        targetGroupId: targetGroupId
    },
    function(result) {
        if (result.length > 0) {
        	targetGroupImportColList = result;
        }

        $.ifvProgressControl(false);

      	//타겟그룹 대상자 그리드 설정
        setTargetGroupImportTargetListGrid(targetGroupImportColList, getSelectFlag);
    });
}

//타겟그룹 대상자 그리드 설정
function setTargetGroupImportTargetListGrid(targetGroupImportColList, getSelectFlag) {
	
/*     if (targetGroupImportColList.length < 1 && $.fn.ifvmIsNotEmpty(targetGroup.targetGroupId)) {
        //컬럼 설정 팝업 열기
       targetGroupColumnSetPopupOpen();
    } else { */
	    var targetGroupId = targetGroup.targetGroupId;
	    var columns = [];
	
	    //타겟그룹 대상자 그리드 모델 설정
	    $.each(targetGroupImportColList, function(index, col) {
			var model = {
	    		  field : col.columnName, headerText : col.displayName, headerTextAlign : 'center', textAlign : 'center',
	    		  customAttributes : { index : col.columnName }
			};
	        
	        columns.push(model);
	    });
	    
	    var ejGridOption = {
	        serializeGridData : function(data) {
	        	data.targetGroupId = targetGroupId;
	        	
	            return data;
	        },
	        recordDoubleClick : function (args) {
	        },
	        columns: columns,
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'tgi.id',
		      	  sord : 'desc',
		      	  _search : true
		        },
		        rowList : [10,25,50,100],
		        radio: false ,
		        tempId : 'ifvGridSimplePageTemplete'
	    };
	
	     if (getSelectFlag == true) {
	    	 ejGridOption.dataUrl = '<ifvm:action name="getTargetGroupImportTargetList"/>';
	     }
	     else {
	    	 ejGridOption.dataSource = [];
	    	 ejGridOption.datatype = 'clientSide';
	     }
	     
		targetGroupImportTargetListGrid = $("#targetGroupImportTargetListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
	    targetColumnLen = targetGroupImportColList.length;
   // }

    //대상수
    $("#targetCount").val();
}

//마스킹 해제
function clearMaskAction() {
    var id;
    if ($.fn.ifvmIsNotEmpty(targetGroupImportTargetListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	id = targetGroupImportTargetListGrid.opt.gridControl.getSelectedRecords()[0].memId;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(id)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskImportTgtList"/>', {
        	memId : id
          , targetGroupId: targetGroup.targetGroupId
        },
        function(result) {
        	var gridObj = targetGroupImportTargetListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('attrib01'), result.unMaskAttrib01);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('attrib02'), result.unMaskAttrib02);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('attrib03'), result.unMaskAttrib03);
        });
    }
}

//목록 이동
function targetGroupList() {
        qtjs.href('<ifvm:url name="targetGroupList"/>');
}

//컬럼 설정 팝업 열기
/* function targetGroupColumnSetPopupOpen() {
    $("#targetGroupColumnSetPopup").ifvsfPopup({
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
    targetGroupColumnSetPopup._destroy();
} */

//엑셀 다운로드
function excelDownload() {
    var targetGroupId = targetGroup.targetGroupId;
    if (targetColumnLen < 1) {
        alert('<spring:message code="M02743" />');
    }
    else {
// 	    qtjs.href('<ifvm:action name="exportExcelTargetGroupImportTargetList"/>?targetGroupId=' + targetGroupId);
    	location.href = "<ifvm:action name='exportExcelTargetGroupImportTargetList'/>?targetGroupId=" + targetGroupId;
    }
}

// 저장
function saveTargetGroupImport() {
	var targetImportValidation = $("#targetGroupImportDetail_area").ifvValidation();
	if (targetImportValidation.confirm()) {
		$.ifvProgressControl(true);
		targetGroup.data = {};
		targetGroup.data.targetGroupId = targetGroup.targetGroupId;
		targetGroup.data.targetGroupName   = $('#targetGroupImpName').val();
		targetGroup.data.targetGroupDesc = $('#targetGroupImpDesc').val();
		targetGroup.data.camId = targetGroup.camId;
		targetGroup.data.targetingHadId = targetGroup.targetingHadId;
		targetGroup.data.comprGroupTypeCd = 'NA';
		targetGroup.data.type = "IMP";
		targetGroup.data.extrYn = $("#extrYn").is(":checked")==true ? "Y" : "N";
		targetGroup.data.targetCount = targetCnt;
        //쿼리 상세내용 수정
        $.ifvPostJSON('<ifvm:action name="saveTargetGroupImport"/>', targetGroup.data,
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                if (result.success == true) {
                	targetGroup.targetGroupId = result.message;
                	targetGroup.data.id = result.message;
                	if ( !fnExcelUpload.data && typeof $("#fileName").val() == 'undefined') {   
                		var isAlert = true;
                        //캠페인 워크플로우일 경우
                        try {
                            if (workflowFlag) {
                                isAlert = false;
                                //캔버스 저장
                                saveCampaignTarget();
                            }
                        }
                        catch (e) {
                        }
                        if (isAlert == true) {
                        	alert('<spring:message code="C00094" />');
                        	$.ifvProgressControl(false);
                        	qtjs.href('<ifvm:url name="targetImportDetail"/>?targetGroupId=' + targetGroup.targetGroupId);
                        }
                	} else {
                		setTargetGroupItemUpload();
                	}
                }
            }
        },
        //실패
        function(result) {
            $.messageCheckr(result.message);
            $.ifvProgressControl(false);
        });
	}
}

//파일 업로드
function setTargetGroupItemUpload() {
	var _obj = {
		url : '<ifvm:action name = "setTargetGroupItemUpload"/>',
		fileName : $("#fileName").val(),
		data: {targetGroupId : targetGroup.targetGroupId}
	};
	
	fnExcelUpload.data.formData ={	
		param : JSON.stringify(_obj)
	}
		
   fnExcelUpload.upload();

   $.ifvProgressControl(false);
   
   try {
       if (workflowFlag) {
           isAlert = false;
           //캔버스 저장
           saveCampaignTarget();
       }
   }
   catch (e) {
   }

}

// 파일 찾기
function fileSearchFn() {
	fnExcelUpload(
		{
			url: '<ifvm:action name="setTargetGroupItemUpload"/>',
			fileName: $("#fileName").val(),
			data: {targetGroupId : targetGroup.targetGroupId},
		}, function (result) {
			if (result.success == true) {
	    		var isAlert = true;
	    		
	            //캠페인 워크플로우일 경우
	            try {
	                if (workflowFlag) {
	                	isAlert = false;
                        targetGroup.data.targetCount = result.message;

	                    //캔버스 저장
	                    saveCampaignTarget();
	                }
	            }
	            catch (e) {
	            }
	            
	            if (isAlert) {
	            	alert('<spring:message code="C00094" />');
	            	$.ifvProgressControl(false);
                	qtjs.href('<ifvm:url name="targetImportDetail"/>?targetGroupId=' + targetGroup.targetGroupId);
	            }
			} else {
				alert(result.message);
			}
			
		}, function (){
			// File 선택 후 동작 할 액션을 정의 한다.
			$('#impFileNm').val(fnExcelUpload.fileName);
	});
}

// 엑셀 다운로드
function targetListDownload(){
	$.ifvExcelDn('<ifvm:action name="exportExcelTargetGroupImportTargetList"/>','targetGroupImportTargetListGrid');	
}

// 조회
function tgtDtlListFn() {
	$.ifvProgressControl(true, null, '<spring:message code="C00150" />');
    setTimeout(function () { getTargetGroupTargetList(true); }, 100);
}

// 샘플 다운로드
function targetGroupItemSampleDown(){
	var data = {
			fileName : "targetGroup_sample_data.xlsx"
	};
	$.fn.ifvmExcelSampleDown(data);
}




function targetGroupItemSearchPop(){
	targetGroupPopup = {
	        open: function() {
	            $("#targetGroupItemSearchPopup").ifvsfPopup({
	                enableModal : true,
	                enableResize: false,
	                contentUrl: '<ifvm:url name="searchMbrNoPop"/>',
	                contentType: "ajax",
	                title: '회원번호 조회',
	                width: 900
	            });
	        },
	        close: function() {
	        	targetGroupPopup._destroy();
	        }
	    }

	targetGroupPopup.open();
}



$(document).ready(function() {
    $.ifvmLnbSetting('targetGroupImportListNew');

    initTargetGroupImportDetail();
    //템플릿 다운로드
    $('#targetGroupItemSampleDownBtn').on('click', function(){
    	targetGroupItemSampleDown();
    });    
    //저장
    $('#saveTargetGroupImportBtn').on('click', function(){
    	saveTargetGroupImport();
    });
    //목록
    $('#targetGroupListBtn').on('click', function(){
    	targetGroupList();
    });
    
    //마스킹해제
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

});

</script>

<div class="page-title">
    <h1>
        <spring:message code="S00009" />
        &gt; <spring:message code="M00582" />
    </h1>
</div>

<div id="targetGroupImportDetail_area">
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00556" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r" id="targetGroupImportDetailBtn_area">
        	<%-- <ifvm:inputNew type="button" text="I02178"  id="targetGroupItemSearchPopBtn" btnFunc="targetGroupItemSearchPop"/> --%>
        	<ifvm:inputNew type="button" text="C00167"  id="targetGroupItemSampleDownBtn" objCode="targetGroupItemSampleDownBtn_OBJ"/>
            <ifvm:inputNew type="button" text="C00164"  id="saveTargetGroupImportBtn" objCode="saveTargetGroupImportBtn_OBJ"/>
            <ifvm:inputNew type="button" text="C00166"  id="targetGroupListBtn" objCode="targetGroupListBtn_OBJ"/>
        </div>
    </div>
    <div>
        <div class="well form-horizontal underline">
            <div class="row qt_border">
            	<%-- 타겟그룹명 --%>
				<ifvm:inputNew type="text" label="M01490" labelClass="1" conClass="10" required="true" id="targetGroupImpName" />
            </div>
            <div class="row qt_border">
            	<%-- 설명--%>
                <ifvm:inputNew type="text" label="M00324" labelClass="1" conClass="10" id="targetGroupImpDesc" />
            </div>
            <div class="row qt_border">
				<ifvm:inputNew type="text" id="impFileNm" dto="impFileNm " label="M01858" labelClass="1" conClass="9" required="true" disabled="true" />
		    	<ifvm:inputNew type="button" text="L01671"  conClass="1" id="fileSearchBtn" btnFunc="fileSearchFn" objCode="fileSearchBtn_OBJ"/>
            </div>
            <div class="row qt_border">
            	<%-- 대상수 --%>
            	<ifvm:inputNew type="text" label="M01495" labelClass="1" conClass="10" id="targetCount" disabled="true" objCode="targetCount_OBJ"/>
            </div>
            <div class="row qt_border">
            	<%-- 비회원여부 --%>
                    <ifvm:inputNew type="hidden" label="L02645" labelClass="1" conClass="10" id="extrYn" objCode="singleCheckbox_OBJ"/>
            	<%--<ifvm:inputNew type="singleCheckbox" label="L02645" labelClass="1" conClass="10" id="extrYn" objCode="singleCheckbox_OBJ"/>--%>
            </div>

           	<%-- 비교군 --%>
           	<%--
            <div class="row qt_border">
                <label class="col-xs-2 control-label"><spring:message code="M00846"/></label>
                <div class="col-xs-9 control_content">
                    <ifvm:input type="text" required="true" disabled="true" id="comprGroupDtl" />
                </div>
            </div>
             --%>
        </div>
        <div class="page_btn_area">
		    <div class="col-xs-5">
			    <span><spring:message code="M01217"/></span>
		    </div>
            <div class="col-xs-7 searchbtn_r">

            	<%-- 조회 --%>
                <ifvm:inputNew type="button" text="L00030" id="tgtDtlListBtn" btnFunc="tgtDtlListFn" objCode="tgtDtlListBtn_OBJ"/>

                <%-- 컬럼 설정 --%>
              <%--   <ifvm:inputNew type="button" text="M01496" id="columnSetBtn" btnFunc="targetGroupColumnSetPopupOpen"/> --%>

                <%-- 엑셀 다운로드 --%>
               <button class="btn btn-sm" id="clearMaskBtn" objCode="clearMaskBtn_OBJ"> <!-- 마스킹해제 -->
                <spring:message code="L00326"/>
              </button>
                <ifvm:inputNew type="button" text="M01218" id="excelDownloadBtn" btnFunc="targetListDownload" objCode="excelDownloadBtn_OBJ"/>
            </div>
	    </div>
        <div id="targetGroupImportTargetListGrid" class="white_bg grid_bd0"></div>
    </div>
</div>
<div id="targetGroupColumnSetPopup"></div>
<div id="segmentViewPopup"></div>
<div id="targetGroupItemSearchPopup"></div>
