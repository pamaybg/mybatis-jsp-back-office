<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
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
<%--
	IE 11에서 탭이동 시 스크립트가 깨지는 문제 때문에
	탭처럼 보이지만, 탭을 클릭 시 페이지 재호출 형식으로 변환함.
 --%>

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/logicalComponent.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" />
<jsp:include page="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/template.jsp" />

<script>
// 탭 관련 URL
var joinUrl = '${pageContext.request.contextPath}/kepler/logicalComponent/include/logicalComponentJoin';	    //조인 설정
var attrUrl = '${pageContext.request.contextPath}/kepler/logicalComponent/include/logicalComponentAttribute';	//Attribute Group 설정

// 팝업 공통 컨테이너 변수
var logicalComponentPopupContainer;

// 현재 탭 확인용 변수
var isCurJoinTab = true;

// 로지컬 컴포넌트 화면 공통 변수
var lgcCompData = {
	 mode : ""
 	,lgcCompId : ""
	,lgcCompNm : ""
	,lgcDesc : ""
	,isAnalysisSegmentUsed : false
	,isAnalysisUsed : false
	,isSegmentUsed : false
	,dbInformId : ""
	,lgcSql : ""
	,sqlValue : ""
};

// 조인 설정 공통 변수
var joinCommonData = {
	 dbInformId : ""
	,accodionTreeList : new Array()
	,curJoinPopData : new Array()
	,tableRelList : new Array()
	,joinPopupDataList : new Array()
	,atribGroupList : new Array()
	,atribGroupColumnList : new Array()
	,tblList : new Array()
}

// 메시지 변수
var lgcCompMsg = {
	M01439 : "<spring:message code='M01439' />"
}

// 서버에서 로지컬 컴포넌트 상세 조회
function getLgcCompDetail(lgcCompId){
	$.ifvSyncPostJSON(
		'<ifv:action name="getLogicalComponentDetail"/>'
	    ,{ lgcCompId : lgcCompId }
		,function(result) {
			// 로지컬 컴포넌트 데이터 및 화면 세팅
			setLogicalComponent({
				 mode : "EDIT"
				,lgcCompId : result.lgcCompId
				,lgcCompNm : result.lgcCompNm
				,lgcDesc   : result.lgcDesc
				,isAnalysisSegmentUsed : result.analysisSegmentUsed
				,isAnalysisUsed : result.analysisUsed
				,isSegmentUsed : result.segmentUsed
				,dbInformId : result.dbInformId
				,lgcSql : result.lgcSql
			});

			// 조인 설정 데이터 세팅
			joinCommonData.dbInformId = result.dbInformId
			joinCommonData.tableRelList = result.joinTableRelList;
			joinCommonData.joinPopupDataList = result.joinColumnList;
         }
    );
	return true;
}

// 서버에 보낼 로지컬 컴포넌트 데이터 가져오기
function getLogicalComponentData(){

	var reqDto = {
	 	 lgcCompId : lgcCompData.lgcCompId
		,lgcCompNm : lgcCompData.lgcCompNm
		,lgcDesc : lgcCompData.lgcDesc
		,dbInformId : joinCommonData.dbInformId
		,dbInformIdChange : false
		,joinTableRelList : null
		,joinColumnList : null
		,atribGroupList : null
		,atribGroupColumnList : null
		,sqlValue :null
	};

	// 현재 탭이 조인 설정일 때
	if(isCurJoinTab){
		var dbInformIdChange = false;
		if(joinCommonData.dbInformId !== lgcCompData.dbInformId){
			dbInformIdChange = true;
		}

		reqDto.dbInformIdChange = dbInformIdChange;
		reqDto.joinTableRelList = getAllJoinTableRelList();
		reqDto.joinColumnList = getAllJoinColumnList();

		reqDto.joinColumnGrpList = getAllJoinColumnGrpList();
	}
	// 현재 탭이 어트리뷰트 그룹 설정일 때
	else {
		reqDto.dbInformIdChange = false;
		reqDto.atribGroupList = getAtribGroupList();
		reqDto.atribGroupColumnList = getAtribGroupColumnList();
	}

	return reqDto;
}

// 서버에서 가져온 로지컬 컴포넌트 데이터 설정
function setLogicalComponent(data){

	lgcCompData = data;

	$("#inputLogicalComponentName").val(data.lgcCompNm);
	$("#inputLogicalComponentDescription").val(data.lgcDesc);
}

// 로지컬 컴포넌트 데이터 체크
function lgcDataCheck(reqDto) {

	if(reqDto.lgcCompNm == null || reqDto.lgcCompNm == ""){
		alert("<spring:message code='M01432'/>");
		return false;
	}

	if(isCurJoinTab){
		if(reqDto.joinTableRelList == null || reqDto.joinTableRelList.length == 0){
			alert("<spring:message code='M01503'/>");
			return false;
		}

		// Fact 또는 Aggregation 테이블 존재여부 확인
		var isExistsFactAgg = false;
		reqDto.joinTableRelList.forEach(function(tbl){
			var tblType = tbl.tblAlias.substring(0, 1);
			if(tblType === "F" || tblType === "A"){
				isExistsFactAgg = true;
			}
		});
		if(!isExistsFactAgg){
			alert("<spring:message code='M01672'/>");
			return false;
		}
	}

	return true;
}

// 로지컬 컴포넌트 저장
function addLogicalComponent(){

	lgcCompData.lgcCompNm = $("#inputLogicalComponentName").val();
	lgcCompData.lgcDesc = $("#inputLogicalComponentDescription").val();

	var reqDto = getLogicalComponentData();
	if(!lgcDataCheck(reqDto)){
		return;
	}

	// Show Loading Circle
	$.ifvProgressControl(true);

	$.ifvPostJSON(
		  '<ifv:action name="addLogicalComponent"/>'
	    , reqDto
		, function(result) {
			 /*  if(result.success==true){
				  alert('저장되었습니다');
			  }
			  else(alert('저장실패')); */
	    	alert(result.message);

	    	// Release Loading Circle
        	$.ifvProgressControl(false);

       		var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId=' + reqDto.lgcCompId + "&tab=join";
           	qtjs.href(url);
         }
		, function(result) {
			$.errorChecker(result);

      		// Release Loading Circle
        	$.ifvProgressControl(false);
         }
    );
}

//로지컬 컴포넌트 다른 이름으로 저장
function addLogicalComponentSaveAs(){

	var reqDto = getLogicalComponentData();
	if(!lgcDataCheck(reqDto)){
		return;
	}

	// Show Loading Circle
	$.ifvProgressControl(true);

	// Call Service
	reqDto.tempLgcCompId = $.ifvmGetRowID();
	$.ifvPostJSON(
		  '<ifv:action name="addLogicalComponentSaveAs"/>'
	    , reqDto
		, function(result) {
      	  	alert(result.message);

        	// Release Loading Circle
        	$.ifvProgressControl(false);

    		var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId=' + reqDto.tempLgcCompId +"&tab=join";
        	qtjs.href(url);
         }
		, function(result) {
			alert(convertMessage(result.message));

			// Release Loading Circle
			$.ifvProgressControl(false);
         }
    );
}

// 로지컬 컴포넌트 수정
function editLogicalComponent(){

	lgcCompData.lgcCompNm = $("#inputLogicalComponentName").val();
	lgcCompData.lgcDesc = $("#inputLogicalComponentDescription").val();

	var reqDto = getLogicalComponentData();
	if(!lgcDataCheck(reqDto)){
		return;
	}

	// Show Loading Circle
	$.ifvProgressControl(true);
	var compId = '<%= cleanXss(request.getParameter("lgcCompId")) %>';
	var url;
	if(compId.length!=0) {
		url = '<ifv:action name="editLogicalComponent"/>';
	} else {
		url = '<ifv:action name="addLogicalComponent"/>';
	}
	// Call Service
 	$.ifvPostJSON(
		  url
	    , reqDto
		, function(result) {
//      	  	lgcCompData = {
//       	  		 mode : "EDIT"
//       	  	 	,lgcCompId : reqDto.lgcCompId
//       	  		,lgcCompNm : reqDto.lgcCompNm
//       	  		,lgcDesc : reqDto.lgcDesc
//       	  		,isAnalysisSegmentUsed : result.analysisSegmentUsed
//       	  		,dbInformId : reqDto.dbInformId
//       	  		,lgcSql : result.lgcSql
//       	  	}

//      	  	// 현재 탭이 조인 설정인 경우
//       	  	if(isCurJoinTab){
//       	  		afterEditLogicalComponent(reqDto);
//       	  	}
//       		// 현재 탭이 어트리뷰트 그룹 설정인 경우
//       	  	else {
//       	  		afterEditLogicalComponentAttribute(reqDto);
//       	  	}

      	  	alert(result.message);

      		// Release Loading Circle
      		$.ifvProgressControl(false);

      	  	var url = "";
      	  	if (isCurJoinTab) {
				url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId=' + reqDto.lgcCompId +"&tab=join";
      	  	} else {
				url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId=' + reqDto.lgcCompId +"&tab=attr";
      	  	}
           	qtjs.href(url);
			location.reload();
         }
		, function(result) {
			alert(convertMessage(result.message));

			// Release Loading Circle
			$.ifvProgressControl(false);
          }
    );
}

// 어트리뷰트 그룹 컬럼명 수정
function editLogicalComponentAttributeGroupColumnName(){

	var reqDto = getLogicalComponentData();

	// Show Loading Circle
	$.ifvProgressControl(true);

	// Call Service
 	$.ifvPostJSON(
		  '<ifv:action name="editLogicalComponentAttributeGroupColumnName"/>'
	    , reqDto
		, function(result) {
     	  	afterEditLogicalComponentAttribute(reqDto);

      	  	alert(result.message);

      		// Release Loading Circle
      		$.ifvProgressControl(false);
         }
		, function(result) {
			alert(convertMessage(result.message));

			// Release Loading Circle
			$.ifvProgressControl(false);
          }
    );
}

// 로지컬 컴포넌트 삭제
function removeLogicalComponent(){

	if(lgcCompData.isAnalysisSegmentUsed){
		alert("<spring:message code='M01439'/>");
		return;
	}

	// Show Loading Circle
	$.ifvProgressControl(true);

	$.ifvPostJSON(
		'<ifv:action name="removeLogicalComponent"/>'
	    ,{
			lgcCompId : lgcCompData.lgcCompId
		}
		,function(result) {
			alert(result.message);
			var url = '<ifv:url name="logicalComponentListNew"/>';
	    	qtjs.href(url);
         }
		,function(result) {
			alert(convertMessage(result.message));
         }
    );

	// Release Loading Circle
	$.ifvProgressControl(false);
}

//저장 후 데이터 셋 변경
function afterEditLogicalComponent(reqDto){

	$("#btnModify").show();
	$("#btnSaveAs").show();
	$("#btnRemove").show();
	$("#btnSave").hide();

	getLgcCompDetail(reqDto.lgcCompId);

	// 테이블 관계 노드 설정
	if(joinCommonData.tableRelList != null
			|| joinCommonData.tableRelList !== undefined){
		diagram.clear();
		setJoinTableRelNode();		  // 노드 생성
		setDefaultTblAliasSequence(); // 시퀀스 초기화
	}

	// 커넥터 설정
	if(joinCommonData.joinPopupDataList != null
			|| joinCommonData.joinPopupDataList !== undefined){
		setJoinColumnConnector();     // 커넥터 생성
	}
}

// 로지컬 컴포넌트 화면 팝업 종료
function logicalComponentPopClose() {
	logicalComponentPopupContainer._destroy();
}

// 화면 초기화
function logicalComponent_Init(){
	var reqLgcCompId = '<%= cleanXss(request.getParameter("lgcCompId")) %>';
	var tab = '<%= cleanXss(request.getParameter("tab")) %>';


	// 조인 설정 및 어트리뷰트 탭 설정
	$("#logicalTab").ifvsfTab({
		 tabId : ["logicalJoinTab", "logicalAttributeGroupTab"]
		,msgCode : ["<spring:message code='M01429' />"
				   ,"<spring:message code='M01430' />"]
	});

	if(reqLgcCompId === null || reqLgcCompId === ''){
		lgcCompData = {
				 mode : "NEW"
				,lgcCompId : $.ifvmGetRowID()
				,lgcCompNm : ""
				,lgcDesc   : ""
				,cmpltYn   : "0"
				,isAnalysisSegmentUsed : false
				,dbInformId : ""
				,lgcSql : ""
			};

		$("#btnSave").show();
		$("#btnListView").show();

		// 조인설정 탭 활성화
		if(tab === 'join'){
			isCurJoinTab = true;
			$.ifvCachedHtml( joinUrl ).done( function(script){
				$("#logicalJoinTab").html( script );
			});
		}
	} else {
		$("#lgcDetailLabel").text("<spring:message code='M01426' /> > <spring:message code='M00259' />");

		getLgcCompDetail(reqLgcCompId);

		$("#btnModify").show();
		$("#btnSaveAs").show();
		$("#btnRemove").show();
		$("#btnSqlView").show();
		$("#btnSegRptView").show();
		$("#btnListView").show();

		// 조인설정 탭 활성화
		if(tab === 'join'){
			isCurJoinTab = true;
			$.ifvCachedHtml( joinUrl ).done( function(script){
				$("#logicalJoinTab").html( script );
			});
		}
		// 어트리뷰트 탭 활성화
		else if(tab === 'attr'){
			isCurJoinTab = false;
			$.ifvCachedHtml( attrUrl ).done( function(script){
				$("#logicalAttributeGroupTab").html( script );
			});
			$("a[href='#logicalAttributeGroupTab']").click();
		}
		// Parameter 명이 잘못 된 경우
		else {
			alert("<spring:message code='M01677'/>");

			var url = '<ifv:url name="logicalComponentList"/>';
        	qtjs.href(url);
		}
	}
}

// 화면 이벤트 핸들러 초기화
function logicalComponent_Handler(){

	$("a[href='#logicalJoinTab']").click(function(e){

		// 자기 탭 클릭 시
		if(isCurJoinTab){
			return false;
		}

		// 저장 후, 이동 필요여부 확인
		if(isNeedAtribTabSaveAlert()){
			if(confirm("<spring:message code='M01669' />")){
				isCurJoinTab = true;
				var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId='+lgcCompData.lgcCompId+"&tab=join";
	        	qtjs.href(url);
	        	return false;
	 		} else {
				return false;
			}
		} else {
			isCurJoinTab = true;
			var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId='+lgcCompData.lgcCompId+"&tab=join";
        	qtjs.href(url);
        	return false;
		}
	});

	$("a[href='#logicalAttributeGroupTab']").click(function(){

		// 자기 탭 클릭 시
		if(!isCurJoinTab){
			return false;
		}

		// 최초 저장이 이루어지지 않은 경우
		if(lgcCompData.mode === "NEW"){
			alert("<spring:message code='M01674' />");
			return false;
		}

		// 저장 필요여부 판단후, 필요없을 시 탭이동만 함.
		if(isNeedTabSaveAlert()){
			// 수정 내용이 존재할 때.
			if(confirm("<spring:message code='M01669' />")){
				var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId='+lgcCompData.lgcCompId+"&tab=attr";
	        	qtjs.href(url);

				return false;
			} else {
				return false;
			}
		} else {
			// 수정 내용이 존재하지 않을 때
			var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId='+lgcCompData.lgcCompId+"&tab=attr";
        	qtjs.href(url);
        	return false;
		}
	});

	$("#btnSqlView").click(function() {
		$("#logicalComponentPopupContainer").ifvsfPopup({
			enableModal : true
	        ,enableResize: false
	        ,allowKeyboardNavigation : false
	        ,contentUrl: '<ifv:url name="logicalComponentSqlPop"/>'
	        ,contentType: "ajax"
	        ,title: '<spring:message code="M01192" />'
	        ,width: 700
	        ,close : 'logicalComponentPopClose'
	    });
	});

	$("#btnSaveAs").click(function () {
		$("#logicalComponentPopupContainer").ifvsfPopup({
			enableModal : true
	        ,enableResize: false
	        ,allowKeyboardNavigation : false
	        ,contentUrl: '<ifv:url name="logicalComponentSaveAsPop"/>'
	        ,contentType: "ajax"
	        ,title: '<spring:message code="M01428" />'
	        ,width: 600
	        ,close : 'logicalComponentPopClose'
	    });
	});

	$("#btnSave").click(function () {
		if(confirm("<spring:message code='M01437' />")){
			addLogicalComponent();
		}
	});

	$("#btnModify").click(function () {
		/* kj.kang
		if(lgcCompData.isAnalysisSegmentUsed){
			if(isCurJoinTab){
				alert("<spring:message code='M01439' />")
			} else {
				// 로지컬 컴포넌트를 사용 중이고, 어트리뷰트 그룹 칼럼 수정인 경우 칼럼명만 수정 가능
				if(confirm("<spring:message code='M01680' />")){
					editLogicalComponentAttributeGroupColumnName();
				}
			}
		} else {
			if(confirm("<spring:message code='M01437' />")){
				editLogicalComponent();
			}
		}
		*/
		if(lgcCompData.isAnalysisSegmentUsed && isCurJoinTab){
			alert("<spring:message code='M01439' />");
			return;
		}
		if(confirm("<spring:message code='M01437' />")){
			editLogicalComponent();
		}
	});

	$("#btnRemove").click(function () {
		if(confirm("<spring:message code='M01436' />")){
			removeLogicalComponent();
		}
	});

	$("#btnSegRptView").click(function () {

		$("#logicalComponentPopupContainer").ifvsfPopup({
			enableModal : true
	        ,enableResize: false
	        ,allowKeyboardNavigation : false
	        ,contentUrl: '<ifv:url name="logicalComponentUsedSegRptListPop"/>'
	        ,contentType: "ajax"
	        ,title: '<spring:message code="M01681" />'
	        ,width: 650
	        ,close : 'logicalComponentPopClose'
	    });
	});

	$("#btnListView").click(function () {
		if(confirm("<spring:message code='M01513' />")){
    		var url = '<ifv:url name="logicalComponentListNew"/>';
        	qtjs.href(url);
		}
	});
}

// 코드로 Return 된 Msg 체크
function convertMessage(msg){
	var rtnMsg = msg;

	if(msg === "MSG_1004"){
		rtnMsg = "<spring:message code='M00032' />";
	}

	return rtnMsg;
}

$(document).ready(function() {

    $.ifvmLnbSetting('logicalComponentListNew');

	logicalComponent_Init();
	logicalComponent_Handler();

});

</script>

<div class="page-title">
	<h1 id="lgcDetailLabel">
		<spring:message code="M01426" /> &gt; <spring:message code="M00136" />
	</h1>
</div>
<div>
<div class="page_btn_area">
	<div class="col-xs-4">
		<span><spring:message code="M01426" /></span>
	</div>
	<div class="col-xs-8 searchbtn_r">
        <button id="btnSaveAs" class="btn btn-sm" style="display: none;" objCode="lcdbtnSaveAs_OBJ">
        	<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M01428" />
        </button>
<%--        <button id="btnSave" class="btn btn-sm" style="display: none;" objCode="lcdbtnSave_OBJ">--%>
<%--        	<i class="glyphicon glyphicon-check"></i>--%>
<%--			<spring:message code="M00137" />--%>
<%--        </button>--%>
        <button id="btnModify" class="btn btn-sm" style="display: none;" objCode="lcdbtnModify_OBJ">
        	<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00137" />
        </button>
        <button id="btnRemove" class="btn btn-sm" style="display: none;" objCode="lcdbtnRemove_OBJ">
        	<i class="fa fa-minus"></i>
			<spring:message code="M00165" />
        </button>
        <button id="btnSqlView" class="btn btn-sm" style="display: none;" objCode="lcdbtnSqlView_OBJ">
			<spring:message code="M01192" />
        </button>
        <button id="btnSegRptView" class="btn btn-sm" style="display: none;" objCode="lcdbtnSegRptView_OBJ">
			<spring:message code="M01681" />
        </button>
        <button id="btnListView" class="btn btn-sm" style="display: none;" objCode="lcdbtnListView_OBJ">
			<spring:message code="M00002" />
        </button>
    </div>
</div>
<div class="well form-horizontal mb0">
	<div class="row qt_border">
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M01427" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifv:input id="inputLogicalComponentName" type="text" maxLength="25" />
			</div>
		</div>
	</div>
	<div class="row">
		<label class="col-xs-1 control-label"><spring:message code="M00324" /></label>
		<div class="col-xs-11 control_content">
			<div class="input-group">
				<ifv:input id="inputLogicalComponentDescription" type="textarea" maxLength="100"/>
			</div>
		</div>
	</div>
</div>
</div>

<div id="logicalTab"></div>
<div id="logicalComponentPopupContainer" class="popup_container"></div>