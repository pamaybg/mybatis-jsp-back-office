<%@page trimDirectiveWhitespaces="true" %>
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
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script>

var progId = '<%= cleanXss(request.getParameter("progId")) %>';
if( progId == 'null' ) progId = null;
var validation;
var objAuthList;
var objAuthGridID;
var objID;
var mainPgmId = null;
var mainPgmNm;
var parPgmId = null;
var parPgmNm;
var DBmainPgmId;
var DBparPgmId;

/* 팝업창을 담을 변수  */
var objAuthPopup;	
var objDialog;
//파라메터 설정
function setParameter() {
	var dashboardId = $.ifvGetParam( "dashboardId" );
	var dashboardNm = decodeURI($.ifvGetParam( "dashboardNm" ));
	var dashboardType = $.ifvGetParam("dashboardType");

	var dashboardPath = "";
	if (dashboardType === "LAYOUT_VIEW") {
		dashboardPath = "<ifvm:url name='dashboardView' />";
	} else {
		dashboardPath = "<ifvm:url name='dashboardListView' />";
	}
	dashboardPath += "?dashboardId=" + dashboardId + ".jsp";
	dashboardPath = dashboardPath.substr( 1 );

	var analysisId = $.ifvGetParam( "analysisId" );
	var analysisNm = decodeURI($.ifvGetParam( "analysisNm" ));
	var analysisEmbedType = $.ifvGetParam( "analysisEmbedType" );
	var analysisPath = "<ifvm:url name='analysisView' />" + "?analysisId=" + analysisId + "&analysisEmbedType=" + analysisEmbedType + ".jsp";
	analysisPath = analysisPath.substr( 1 );

	/* kj.kang 추가 :: 대시보드에서 해당 페이지 호출 시, 대시보드 관련 정보를 INPUT BOX에 세팅해줌. */
	if( $.fn.ifvmIsNotEmpty( dashboardId ) ) {
		$("#progNo").val(dashboardId);
		
		if( $.fn.ifvmIsNotEmpty(dashboardNm) ) {
			$("#progName").val(dashboardNm);
		}

		if( $.fn.ifvmIsNotEmpty(dashboardPath) ) {
			$("#progPath").val(dashboardPath);
		}

	}

	if( $.fn.ifvmIsNotEmpty( analysisId ) ) {
		$("#progNo").val(analysisId);

		if( $.fn.ifvmIsNotEmpty(analysisNm) ) {
			$("#progName").val(analysisNm);
		}

		if( $.fn.ifvmIsNotEmpty(analysisPath) ) {
			$("#progPath").val(analysisPath);
		}
	}
}

function getCommonCode(){
	//대상자 구분 코드 가져오기
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : "ADMIN_PROG_TYPE"
	},function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#progType").append(temp);
	});
};


//저장 버튼 클릭시 수정
function updateProgDetail(){
	if( validation.confirm() == true ){
		var menuCheck = null;
		if($('input:checkbox[id="menuChkYn"]').is(":checked") == true){
			menuCheck = 'Y'
		}else{
			menuCheck = 'N'
		}

		//아무 이벤트 없이 저장을 눌렀을때
		if($('#mainPgmId').val() != ""  && mainPgmId == null){
			mainPgmId = DBmainPgmId;
		}
		if($('#parPgmId').val() != "" && parPgmId == null){
			parPgmId = DBparPgmId;
		}

	    var jsonData = {
			progId : progId,
			progNo : $("#progNo").val(),
			progName : $("#progName").val(),
			progType : $("#progType").val(),
			progPath : $("#progPath").val(),
			mainPgmId : $("#mainPgmId").val(),
			parPgmId : $("#parPgmId").val(),
			tabLabelName : $("#tabLabelName").val(),
			tabSeq : $("#tabSeq").val(),
			menuChkYn : menuCheck,
		}
		if( progId == null ){ //신규
			url = '<ifvm:action name="insertProgramDetail"/>';
			if(confirm('<spring:message code="I01881"/>') === false) return;
		}else{					//수정
			url = '<ifvm:action name="updateProgramDetail"/>';
			jsonData.progId = progId;
			if(confirm('<spring:message code="I01882"/>') === false) return;
		}

		$.ifvSyncPostJSON( url, jsonData, function(result) {
			if(result.success == true){
				alert('<spring:message code="I00741"/>');
				qtjs.href('<ifvm:url name="progListNew"/>');
			}
			else{
				alert('<spring:message code="I00742"/>');
			}
		}, null, null, "#btnSave" );
	}
};

function progList(){
	if( progId != null ){
		$.ifvSyncPostJSON('<ifvm:action name="progListDetail"/>',{
			prgId : progId,
		},
		function(result) {
			$('#progCreater').val(result.progCreater);
			$('#progCreateDate').val(result.progCreateDate.substring(0,19));
			$('#progNo').val(result.progNo);
			$('#progName').val(result.progName);
			$('#progType').val(result.progType).attr("selected", "selected");
			$('#tabLabelName').val(result.tabLabelName);
			$('#tabSeq').val(result.tabSeq);
			$('#progPath').val(result.progPath);
			$('#mainPgmId').val(result.mainPgmId);
			$('#mainPgmNm').val(result.mainPgmNm);
			$('#parPgmId').val(result.parPgmId);
			$('#parPgmNm').val(result.parPgmNm);
			$("#menuChkYn").prop("checked", "Y" === result.menuChkYn ? true : false);
			DBmainPgmId = result.mainPgmId;
			DBparPgmId = result.parPgmId;
			
			if($('#progType').val()=='TAB') {
				$("#tabLabelName").attr('disabled', false);
				$("#tabSeq").attr('disabled', false);
			} else {
				$("#tabLabelName").attr('disabled', true);
				$("#tabSeq").attr('disabled', true);
			}
		});
	}

};

function authProgDetail(){
	if(progId != null){
		$("#btnSave").addClass('authUpdateBtn');
	}
	else{
		$("#btnSave").addClass('authCretBtn');
	}
	$.ifvmAdminCheck(false, true, true);
}


//목록 돌아가기
function goList() {
	qtjs.href('<ifvm:url name="progListNew"/>');
}

/* 메인프로그램 선택 */
function getMainPopup(){
	$("#mainPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="detailProgramList"/>',
        contentType: "ajax",
        title: '<spring:message code="I02117"/>',
        width: 900,
        close : 'mainPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }
    });
}

/* 상위 프로그램 선택 */
 function getParPopup(){
	 $("#parPopupContainer").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="detailLowProgList"/>',
	        contentType: "ajax",
	        title: '<spring:message code="I02118"/>',
	        width: 900,
	        close : 'parPopupClose',
	    	open : function(){
	    		new ifvm.PopupCenter({
	        		popupDivId : 'popupContainer'
	        	});
	        }
	  });
}


function mainPopupClose() {
	mainPopupContainer._destroy();

}

function parPopupClose() {
	parPopupContainer._destroy();

}

$(document).ready(function() {
	$.ifvmLnbSetting('progListNew');

	getCommonCode();

	setParameter();

	/* if( progId != null ){
		$("#titleDetailName").html('&gt; <spring:message code="I00195"/>');
	} */

	progList();

	pageSetUp();

	validation = $("#formArea").ifvValidation();

	authProgDetail();
	
	$("#mainPgmIdBtn").on('click',function(){
		getMainPopup();
	});
	
	$("#parPgmIdBtn").on('click',function(){
		getParPopup();
	});
	
	$("#progType").change(function() {
		if($('#progType').val()=='TAB') {
			$("#tabLabelName").attr('disabled', false);
			$("#tabSeq").attr('disabled', false);
		} else {
			$("#tabLabelName").attr('disabled', true);
			$("#tabLabelName").val('');
			$("#tabSeq").attr('disabled', true);
			$("#tabSeq").val('');
		}
	})
 });

</script>

<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
	<h1>
		<spring:message code="I02054"/>
		&gt; <spring:message code="I00195"/>
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02035"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew id="btnSave" type="button" className="authUpdateBtn" btnFunc="updateProgDetail" text="I00745" btnType="save" objCode="updateProgDetail_OBJ"/>
			<ifvm:inputNew type="button" id="goProgListNew" btnFunc="goList" text="L00824" objCode="goProgListNew_OBJ"/>
		</div>
	</div>


	<div class="well" id="formArea" style="margin-bottom:0;">
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="progNo" required="true" maxLength="100" label="I02044" labelClass="1" conClass="3"/>
			</div>
		</div>

		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="progName" required="true" maxLength="100" label="I02045" labelClass="1" conClass="3"/>
			</div>
		</div>



		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="select"  id="progType" dto="progType" names="progType" label="I02046" labelClass="1" conClass="3"/>
				<ifvm:inputNew type="text" id="tabLabelName"  label="탭 라벨" disabled="true" labelClass="1" conClass="2"/>
				<ifvm:inputNew type="number" id="tabSeq" className="text-right" label="탭 순서" disabled="true" labelClass="1" conClass="2"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text"  id="mainPgmNm" maxLength="100" disabled="true" label="I02114" labelClass="1" conClass="3"/>
				<ifvm:inputNew type="hidden"  id="mainPgmId" maxLength="100" disabled="true" label="I02114" labelClass="1" conClass="3"/>
				<span class="input-group-addon" style="padding : 4px;" id="mainPgmIdBtn">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text"  id="parPgmNm" maxLength="100" disabled="true" label="I02115" labelClass="1" conClass="3"/>
				<ifvm:inputNew type="hidden"  id="parPgmId" maxLength="100" disabled="true" label="I02115" labelClass="1" conClass="3"/>
				<span class="input-group-addon" style="padding : 4px;" id="parPgmIdBtn">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="singleCheckbox"  id="menuChkYn" names="menuChkYn" maxLength="100" label="I02116" labelClass="1" conClass="3"/>
			</div>
		</div>

		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" required="true" id="progPath" maxLength="1000" label="I02047" labelClass="1" conClass="8"/>
			</div>
		</div>

		<div class="row qt_border" id="choice">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="progCreater" maxLength="300" disabled="true" label="I02055" labelClass="1" conClass="3"/>
				<ifvm:inputNew type="text" id="progCreateDate"  label="I02056" disabled="true" labelClass="1" conClass="3"/>
			</div>
		</div>

	</div>

</div>

<div id="mainPopupContainer" class="popup_container"></div>
<div id="parPopupContainer" class="popup_container"></div>
