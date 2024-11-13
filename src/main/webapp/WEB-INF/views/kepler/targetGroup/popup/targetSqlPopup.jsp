<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 *
 */
function getTargetSqlDBInfo() {
    if ($.fn.ifvmIsNotEmpty(targetGroup.data)) {
        $('#dbInformId').val(targetGroup.data.dbInformId);
        $('#serviceNm').val(targetGroup.data.serviceNm);
        $('#conDbType').val(targetGroup.data.conDbType);
        $('#conIp').val(targetGroup.data.conIp);
        $('#conPort').val(targetGroup.data.conPort);
        $('#conId').val(targetGroup.data.conId);
        $('#filterSql').val(targetGroup.data.filterSql);
    }
}

/**
 * 검증
 */
function sqlValidation() {
    var rtnFlag = false;

    $('#filterSqlValidMsg').text('');

    if ($.fn.ifvmIsEmpty($('#dbInformId').val())) {
        //DB정보를 선택하세요.
        alert('<spring:message code="M02842" />');
    }
    else if ($.fn.ifvmIsEmpty($('#filterSql').val())) {
        //SQL을 입력해주세요.
        alert('<spring:message code="M02843" />');
    }
    else {
        $.ifvSyncPostJSON('<ifvm:action name="targetSqlValidation"/>', {
            dbId: $('#dbInformId').val(),
            filterSql : $('#filterSql').val()
        },
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {

                //실패
                if ($.fn.ifvmIsNotEmpty(result.message)) {
                    if (result.message == 'NOT_ONE_COLUNM') {
                        //컬럼은 회원번호 1개여야 합니다.
    					$('#filterSqlValidMsg').text('<spring:message code="M02844" />');
                    }
                    else if (result.message == 'SQL_ERROR') {
                        //쿼리 조회중 오류가 발생하였습니다.
    					$('#filterSqlValidMsg').text('<spring:message code="M02845" />');
                    }
                    else if (result.message == 'NOT_DB_INFO') {
                        //데이터베이스 정보가 없습니다.
    					$('#filterSqlValidMsg').text('<spring:message code="M02846" />');
                    }
                    else if (result.message == 'NOT_DB_ID') {
                        //DB를 선택하세요.
    					$('#filterSqlValidMsg').text('<spring:message code="M02847" />');
                    }
                    else if (result.message == 'NO_DATA') {
                        //데이터가 없습니다
    					$('#filterSqlValidMsg').text('<spring:message code="M00093" />');
                    }
                    else {
    					$('#filterSqlCount').val(result.message);
    					rtnFlag = true;
                    }
                }
                //성공
                else {
                    //성공하였습니다.
					$('#filterSqlValidMsg').text('<spring:message code="M02848" />');
					rtnFlag = true;
                }
            }
        });
	}
    return rtnFlag;
}

/**
 * 데이터베이스 목록 조회
 */
function dbListPopOpen() {
    $("#dbListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="dbListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02257" />',	//서비스 목록
        width: 600,
        close : 'dbListPopupClose'
    });
}
/**
 * 데이터베이스 목록 팝업 닫기
 */
function dbListPopupClose() {
    dbListPopup._destroy();
}

/**
 * 저장
 */
function setTargetSql() {

    // 검증 완료 되었을때 저장 가능
    if (sqlValidation() == true) {
    	targetGroup.data.id = targetGroup.targetGroupId;
        targetGroup.data.dbInformId  = $('#dbInformId').val();
        targetGroup.data.tgtGroupNm  = $('#serviceNm').val();
        targetGroup.data.serviceNm   = $('#serviceNm').val();
        targetGroup.data.filterSql   = $('#filterSql').val();
		targetGroup.data.conDbType 	= $('#conDbType').val();
		targetGroup.data.conIp 		= $('#conIp').val();
		targetGroup.data.conPort 	= $('#conPort').val();
		targetGroup.data.conId 		= $('#conId').val();
		targetGroup.data.targetGroupName = $('#targetSqlName').val();
		targetGroup.data.targetGroupDesc = $('#targetSqlDesc').val();

        setTargetSqlDtl();

        //팝업종료
        targetSqlPopupClose();
    }
}

/**
 * 데이터베이스 선택
 */
function dbSelect() {

    var len = dbListPopGrid.opt.gridControl.getSelectedRecords().length;
    
    if (len > 0) {
		var rowData = dbListPopGrid.opt.gridControl.getSelectedRecords()[0];
		$('#dbInformId').val(rowData.dbInformId);
		$('#serviceNm').val(rowData.serviceNm);
		$('#conDbType').val(rowData.conDbType);
		$('#conIp').val(rowData.conIp);
		$('#conPort').val(rowData.conPort);
		$('#conId').val(rowData.conId);

		dbListPopupClose();
    }
    else {
     	//목록을 선택해주세요.
        alert('<spring:message code="L00066"/>');
    }
}

function dbInfoReset() {
	$('#dbInformId').val('');
	$('#serviceNm').val('');
	$('#conDbType').val('');
	$('#conIp').val('');
	$('#conPort').val('');
	$('#conId').val('');
}

$(document).ready(function() {

    getTargetSqlDBInfo();

    //검증 버튼
    $('#sqlValidBtn').on('click', function() {
        sqlValidation();
    });

    //초기화 버튼
    $('#dbInfoResetBtn').on('click', function() {
        dbInfoReset();
    });

   	//DB선택 팝업 버튼
    $('#dbListPopOpenBtn').on('click', function() {
        dbListPopOpen();
    });

   	//저장 버튼
    $('#setTargetSqlBtn').on('click', function() {
        setTargetSql();
    });

    //닫기 버튼
    $('#targetSqlCancelBtn').on('click', function() {
        targetSqlPopupClose();
    })
});

</script>

<%-- DB 정보 --%>
<div id="dbInfoPopArea">
    <div class="page_btn_area" style="padding-right: 0px">
        <div class="col-xs-5">
            <span class="asterisk">*</span><span><spring:message code="M02831"/></span>
        </div>
        <div class="col-xs-7 searchbtn_r">
            <%-- 검증 --%>
            <button class="btn btn-sm" id="sqlValidBtn" objCode="sqlValidBtn_OBJ">
                <spring:message code="M00638"/>
            </button>

            <%-- DB선택 --%>
            <button class="btn btn-sm" id="dbListPopOpenBtn" objCode="dbListPopOpenBtn_OBJ">
                <spring:message code="M02830"/>
            </button>

            <%-- 초기화 --%>
            <button class="btn btn-sm" id='dbInfoResetBtn' objCode="dbInfoResetBtn_OBJ">
                <spring:message code="M00278"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal underline top_well" id="dbInfoArea">
		<ifvm:input type="hidden" id="dbInformId" />
        <div class="row qt_border">

            <%-- 서비스명 --%>
            <label class="col-xs-2 control-label"><spring:message code="M01440"/></label>
            <div class="col-xs-4 control_content">
            	<ifvm:input type="text" id="serviceNm" readonly="readonly"/>
            </div>

            <%-- DB 유형 --%>
            <label class="col-xs-2 control-label"><spring:message code="M01123"/></label>
            <div class="col-xs-4 control_content">
            	<ifvm:input type="text" id="conDbType" readonly="readonly"/>
            </div>
        </div>
        <div class="row qt_border">

            <%-- 서버 IP --%>
            <label class="col-xs-2 control-label"><spring:message code="M01125"/></label>
            <div class="col-xs-4 control_content">
            	<ifvm:input type="text" id="conIp" readonly="readonly"/>
            </div>

            <%-- 접속 PORT --%>
            <label class="col-xs-2 control-label"><spring:message code="M01126"/></label>
            <div class="col-xs-4 control_content">
            	<ifvm:input type="text" id="conPort" readonly="readonly"/>
            </div>
        </div>
        <div class="row qt_border">

            <%-- 접속 ID --%>
            <label class="col-xs-2 control-label"><spring:message code="M01127"/></label>
            <div class="col-xs-4 control_content">
            	<ifvm:input type="text" id="conId" readonly="readonly"/>
            </div>
        </div>
    </div>
</div>

<div id="targetSqlPopArea">
    <div class="page_btn_area" style="padding-right: 0px">
        <div class="col-xs-7">
            <span class="asterisk">*</span><span><spring:message code="M02832"/></span>
        </div>
    </div>
    <div id ="row">
        <span class="asterisk">*</span><span style="color: red;">SQL 입력시 단 한 개의 고유 컬럼만 입력하시면 되며, 고유 키값에 'as segkey' 를 붙혀주세요.</span>
    </div>
    <div class="well form-horizontal underline top_well" id="targetSqlArea">
        <div class="row qt_border">

        	<%-- 쿼리 --%>
            <div class="col-xs-12 control_content">
                <ifvm:input type="hidden" id="filterSqlCount" names="filterSqlCount" />
                <ifvm:input type="textarea" id="filterSql" names="filterSql" rows="12" />
            </div>
        </div>
        <div class="row qt_border">
			<label class="col-xs-12 control-label" id="filterSqlValidMsg"></label>
        </div>
    </div>
</div>

<div class="pop_btn_area">

    <%-- 저장 --%>
    <button class="btn btn-sm btn_gray" id="setTargetSqlBtn" objCode="setTargetSqlBtn_OBJ">
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00280"/>
    </button>

    <%-- 닫기 --%>
    <button class="btn btn-sm btn_lightGray2 cancel" id="targetSqlCancelBtn" objCode="targetSqlCancelBtn_OBJ">
        <spring:message code="M00441"/>
    </button>
</div>

<div id="dbListPopup" class="popup_container"></div>