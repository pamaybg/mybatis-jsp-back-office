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

var targetSqlValidation;

var targetSqlDtlGrid;
var targetColumnLen = 0;

var targetGroup = {
        targetGroupId: "",
        targetGroupType: "SQL",
        data: {}
}

/**
 * 타겟SQL 첫화면 조회
 */
function initTargetGroupDetail() {

    var targetGroupId = '<%= cleanXss(request.getParameter("targetGroupId")) %>';
    targetGroup.targetGroupId = $.fn.ifvmIsEmpty(targetGroupId) || targetGroupId == "null" ? '' : targetGroupId;
    targetGroup.targetGroupId = targetGroup.targetGroupId;

    //타겟그룹 상세 조회
    getTargetGroup();
}

/**
 * 타겟그룹 상세 조회
 */
function getTargetGroup() {
    var targetGroupId = targetGroup.targetGroupId;

    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
	    $.ifvProgressControl(true);

        $.ifvPostJSON('<ifvm:action name="getTargetSqlDetail"/>', {
            targetGroupId: targetGroupId
        },
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {

                //타겟그룹 설정
                targetGroup.data = result;

                setTargetSqlDtl();
            }
        },
        function(result) {
            $.errorChecker(result);
            $.ifvProgressControl(false);
            $('#targetSqlOpenBtn').hide();
        });
    } else {
    	getTargetGroupTargetList(false);
    }
}

/**
 * 상세정보 보여주기
 */
function setTargetSqlDtl() {
    if ($.fn.ifvmIsNotEmpty(targetGroup.data)) {
        var data = targetGroup.data;
        $("#targetSqlName").val(data.targetGroupName);
        $("#targetSqlDesc").val(data.targetGroupDesc);
        $("#filterText").val(data.dpCond);

        //대상수 조회
        getTargetCount();

        getTargetGroupTargetList(false);
    }
}

/**
 * 대상수 조회
 */
function getTargetCount() {
    if ($.fn.ifvmIsNotEmpty(targetGroup.data)
            && $.fn.ifvmIsNotEmpty(targetGroup.data.dbInformId)
            && $.fn.ifvmIsNotEmpty(targetGroup.data.filterSql)) {

        $.ifvSyncPostJSON('<ifvm:action name="getTargetSqlCount"/>', {
            dbId: targetGroup.data.dbInformId,
            filterSql : targetGroup.data.filterSql
        },
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                targetGroup.data.cnt = result.message;
                targetGroup.data.targetCount = result.message;
                $('#targetSqlCount').val(numberWithCommas(result.message));
            }
            else {
                $.ifvErrorPop('<spring:message code="M01694"/>');
            }
        });
    }
}

/**
 * 1000단위 정규식
 */
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 * 타겟그룹 대상자 목록
 */
 function getTargetGroupTargetList(getSelectFlag) {
     var targetGroupId = targetGroup.targetGroupId;
     var targetGroupColList = [];

     //타겟그룹 대상자 컬럼 목록 조회
     $.ifvSyncPostJSON('<ifvm:action name="getTargetGroupColumnList"/>', {
         targetGroupId: targetGroupId
     },
     function(result) {
         if (result.length > 0) {
         	targetGroupColList = result;
         }

         $.ifvProgressControl(false);

       	//타겟그룹 대상자 그리드 설정
         setTargetGroupTargetListGrid(targetGroupColList, getSelectFlag);
     });
 }

/**
 * 타겟그룹 대상자 그리드 설정
 */
//타겟그룹 대상자 그리드 설정
 function setTargetGroupTargetListGrid(targetGroupColList, getSelectFlag) {

     if (targetGroupColList.length < 1 && $.fn.ifvmIsNotEmpty(targetGroup.targetGroupId)) {
         //컬럼 설정 팝업 열기
         targetGroupColumnSetPopupOpen();
     } else {
	
	     var targetGroupId = targetGroup.targetGroupId;
	     var dbInformId = targetGroup.data.dbInformId;
	     var columns = [];
	
	    //타겟그룹 대상자 그리드 모델 설정
	    $.each(targetGroupColList, function(index, col) {
			if(col.displayName == "회원번호"){
				var model = {
			    		  field : col.columnName, headerText : col.displayName, headerTextAlign : 'center', textAlign : 'center', template : "<span style=\"color : blue;cursor:pointer; text-decoration: underline; \">{{:" + col.columnName + "}}</span>",  
			    		  customAttributes : { index : col.columnName }
					};
			}else{
				var model = {
			    		  field : col.columnName, headerText : col.displayName, headerTextAlign : 'center', textAlign : 'center',  
			    		  customAttributes : { index : col.columnName }
					};
			}
	        
	        columns.push(model);
	    });
	
	    var ejGridOption = {
	            serializeGridData : function(data) {
	            	data.targetGroupId = targetGroupId;
	            	
	                return data;
	            },
	            recordClick : function (args) {
	            	if(args.columnName=='회원번호'){
		            	var data = args.cellValue;
		        	  	// goMbrDetail(data);
	            	}
	            },
	            columns: columns,
	            allowSorting : true,
	            requestGridData : {
	    	      	  nd   : new Date().getTime(),
	    	      	  rows : 10,
	    	      	  sidx : 'C0001',
	    	      	  sord : 'desc',
	    	      	  _search : true
	    	        },
	    	        rowList : [10,25,50,100],
	    	        radio: true ,
	    	        tempId : 'ifvGridSimplePageTemplete'
	        };
	
	     if (getSelectFlag == true) {
	    	 ejGridOption.dataUrl = '<ifvm:action name="getTargetSqlTargetList"/>';
	     }
	     else {
	    	 ejGridOption.dataSource = [];
	    	 ejGridOption.datatype = 'clientSide';
	     }
	
	     targetSqlDtlGrid = $("#targetSqlDtlGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
	     targetColumnLen = targetGroupColList.length;
     }

     //대상수
     $("#targetCount").val();
 }
 
/**
 * 목록 이동
 */
function targetGroupList() {
        location.href = '<ifvm:url name="targetGroupList"/>';
}

function goMbrDetail(id) {
    //개인정보 조회 이력남기기
    var url = null;
    
    $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true);
  //    qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + id);
     $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : '',
     mbrNo : id
    }, function(result){
     if(result.custTypeCd != null){
      if(result.custTypeCd == 'C'){
          //개인정보 조회 이력남기기(법인)
              url = '<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + result.mbRid;
        } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
          //개인정보 조회 이력남기기(개인/임직원)
              url = '<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid; 
        }
     }
    });   
     window.open(url, "_blank");  
}

//컬럼 설정 팝업 열기
function targetGroupColumnSetPopupOpen() {
    $("#targetGroupColumnSetPopup").ifvsfPopup({
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
    targetGroupColumnSetPopup._destroy();
}

/**
 * SQL 설정 팝업 열기
 */
function targetSqlOpen() {
    $("#targetSqlPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetSqlPopup"/>',
        contentType: "ajax",
        title: '<spring:message code="M02849" />',
        width: 680,
        close : 'targetSqlPopupClose'
    });
}

/**
 * SQL 설정 팝업 닫기
 */
function targetSqlPopupClose() {
    targetSqlPopup._destroy();
}

/**
 * 엑셀 다운로드
 */
function excelDownload() {
	$.ifvExcelDn('<ifvm:action name="exportExcelTargetSqlTargetList"/>',
			'targetSqlDtlGrid', {targetGroupId : targetGroup.targetGroupId});
}

/**
 * 저장
 */
function targetSqlSave() {
    // 검증 완료 되었을때 저장 가능

    targetSqlValidation = $("#targetSqlDetail_area").ifvValidation();

    if ($.fn.ifvmIsEmpty(targetGroup.data.dbInformId)
            || $.fn.ifvmIsEmpty(targetGroup.data.filterSql)) {
        //SQL 정보를 확인하세요
        alert('<spring:message code="M02858" />');
    }
    else if (targetSqlValidation.confirm()) {

        $.ifvProgressControl(true);
        targetGroup.data.id = targetGroup.targetGroupId;
        targetGroup.data.targetGroupId = targetGroup.targetGroupId;
        targetGroup.data.tgtGroupNm   = $('#targetSqlName').val();
        targetGroup.data.tgtGroupDesc = $('#targetSqlDesc').val();
        targetGroup.data.comprGroupTypeCd = 'NA';
        targetGroup.data.type = 'SQL';
        targetGroup.data.segFilterId  = "";
        
        if (targetGroup.type == 'COPY') {
           targetGroup.data.targetGroupId = '';
           targetGroup.data.id = '';
        }

        //쿼리 상세내용 수정
        $.ifvPostJSON('<ifvm:action name="saveTargetSql"/>', targetGroup.data,
        function(result) {

            if ($.fn.ifvmIsNotEmpty(result)) {
                if (result.success == true) {
                    var isAlert = true;
                    targetGroup.data.id = result.message;
                    targetGroup.targetGroupId = result.message;

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
                    
                    // 성공시 기존 로직
                    if (isAlert) {
                    	alert('<spring:message code="C00094" />');
                    	$.ifvProgressControl(false);
                    	qtjs.href('<ifvm:url name="targetSqlDetail"/>?targetGroupId=' + result.message);
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

$(document).ready(function() {
    $.ifvmLnbSetting('targetGroupList');

    initTargetGroupDetail();

    //목록
    $('#targetGroupListBtn').on('click', function(){
        targetGroupList();
    });

    //타겟팅대상자 목록 조회 버튼
    $('#tgtSqlDtlListBtn').on('click', function(){
        $.ifvProgressControl(true, null, '<spring:message code="C00150" />');
        setTimeout(function () { getTargetGroupTargetList(true); }, 100);
    });

    //엑셀 다운로드
    $('#excelDownloadBtn').on('click', function() {
        excelDownload();
    });

    //SQL 상세
    $('#targetSqlOpenBtn').on('click', function() {
        targetSqlOpen();
    });

    //저장버튼
    $('#targetSqlDtlSaveBtn').on('click', function() {
        targetSqlSave();
    });

    //validation 설정
    targetSqlValidation = $("#targetSqlDetail_area").ifvValidation();
});

</script>

<%-- <div class="page-title">
    <h1>
        <spring:message code="M01494" />
        &gt; <spring:message code="M00582" />
    </h1>
</div> --%>

<div id="targetSqlDetail_area">
<div class="well" style="margin-bottom:10px;">
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00556" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r" id="targetSqlDetailBtn_area">

        	<!-- SQL 설정 -->
            <button class="btn btn-sm" id="targetSqlOpenBtn" objCode="targetSqlOpenBtn_OBJ">
                <i class="fa fa-search"></i><spring:message code="M02849" />
            </button>

            <%-- 저장 --%>
            <button class="btn btn-sm" id="targetSqlDtlSaveBtn" objCode="targetSqlDtlSaveBtn_OBJ">
                <spring:message code="L00074" />
            </button>
            
            <!-- 목록 -->
            <button class="btn btn-sm" id="targetGroupListBtn" objCode="targetGroupListBtn_OBJ">
                <spring:message code="M00002" />
            </button>

        </div>
    </div>
    
	<div class="well form-horizontal well_wrap">
		<div class="row qt_border">
	
			<%-- 타겟팅명 --%>
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02438"/></label>
			<div class="col-xs-9 control_content">
		    	<ifvm:input type="text" required="true" id="targetSqlName" />
		    </div>
		</div>
		<div class="row qt_border">
	
			<%-- 설명 --%>
			<label class="col-xs-2 control-label"><spring:message code="M00324"/></label>
			<div class="col-xs-9 control_content">
	    		<ifvm:input type="text" id="targetSqlDesc" />
	    	</div>
		</div>
		<div class="row qt_border">
	
			<%-- 대상수 --%>
			<label class="col-xs-2 control-label"><spring:message code="M01495"/></label>
			<div class="col-xs-9 control_content">
	    		<ifvm:input type="text" required="true" disabled="true" id="targetSqlCount" />
			</div>
		</div>
	</div>
</div>

	
<div class="well">
	<div class="page_btn_area">
		<div class="col-xs-5">
			<span><spring:message code="M01217"/></span>
		</div>
		<div class="col-xs-7 searchbtn_r">
	
			<%-- 조회 --%>
			<button class="btn btn-sm" id="tgtSqlDtlListBtn" objCode="tgtSqlDtlListBtn_OBJ">
			    <spring:message code="L00030" />
			</button>
			
            <%-- 컬럼 설정 --%>
            <ifvm:inputNew type="button" text="M01496" id="columnSetBtn" btnFunc="targetGroupColumnSetPopupOpen" objCode="columnSetBtn_OBJ"/>
	
			<%-- 엑셀 다운로드 --%>
			<button class="btn btn-sm" id="excelDownloadBtn" objCode="excelDownloadBtn_OBJ">
			    <spring:message code="M01218" />
			</button>
		</div>
	</div>
     <!-- 그리드 -->
	<div id="targetSqlDtlGrid" class="white_bg grid_bd0"></div>
</div>

<div id="targetGroupColumnSetPopup"></div>
<div id="targetSqlPopup" class="popup_container"></div>
