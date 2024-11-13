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
var conditionDetailGrid;
var conditionColumnSetPopup;
var originJqGridOption;

//조건추출 입력 조건 세팅
function setConditionDetail() {
    
	if(conditionId != null && conditionId != "" && conditionId != "null") {
		$.ifvSyncPostJSON('<ifvm:action name="getChargingStationCondDetail"/>'
		,{camId : camId, conditionId : conditionId}
		,function(result) {
			conditionData = result;
		});
	}
	
	$("#condExtTermsDtl").val(conditionData.condExtTermsMarkName);
	$("#preFillVolLtDtl").val(conditionData.preFillVolLt);
	$("#preVisitCntDtl").val(conditionData.preVisitCnt);
	$("#memPhaseCdDtl").val(conditionData.memPhaseCdMarkName);
	$("#memTypeCdDtl").val(conditionData.memTypeCdMarkName);
	$("#segLifeCycleCdDtl").val(conditionData.segLifeCycleCdMarkName);
	$("#ageIdDtl").val(conditionData.ageIdMarkName == null ? "전체" : conditionData.ageIdMarkName);
	$("#genderCdDtl").val(conditionData.genderCdMarkName == null ? "전체" : conditionData.genderCdMarkName);
	$("#mainUseWeekdayDtl").val(conditionData.mainUseWeekdayMarkName);
}

//컬럼 설정 팝업 열기
function conditionColumnSetPopupOpen() {
	$("#conditionColumnSetPopup").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="stnConditionColumnPopup"/>',
        contentType: "ajax",
        title: '<spring:message code="M01496" />',
        width: 500,
        close : 'conditionColumnSetPopupClose'
	});
	
	conditionColumnSetPopup = $("#conditionColumnSetPopup").data("ejDialog");
}

//컬럼 설정 팝업 닫기
function conditionColumnSetPopupClose(){
	conditionColumnSetPopup.destroy();
}

//조건추출 대상자 그리드 세팅
function setConditionDetailGrid() {
	
    var jqGridOption = {
 		loadComplete : function(data){
 			//대상자 회원수 세팅
 			var cnt = data.records;
 			if(!data.rows) {	cnt = 0;	}
 			$("#mbrCountTotal").text('<spring:message code="S00032" arguments="'+cnt+'"/>');
 		},
		serializeGridData : function( data ){
			
			data.preFillVolLt = conditionData.preFillVolLt;
			data.preVisitCnt = conditionData.preVisitCnt;
			data.condExtTerms = conditionData.condExtTerms;
			data.memPhaseCd = conditionData.memPhaseCd;
			data.memTypeCd = conditionData.memTypeCd;
			data.segLifeCycleCd = conditionData.segLifeCycleCd;
			data.ageId = conditionData.ageId;
			data.genderCd = conditionData.genderCd;
			data.mainUseWeekday = conditionData.mainUseWeekday;
			
			data.camId = camId;
			data.chnlNo = chnlNo;
			return data;
         },
         url:'<ifvm:action name="getSearchMbrInfoByCondition"/>',
         colNames:['<spring:message code="L00938"/>',
         		   '<spring:message code="L00787"/>',
                   '<spring:message code="L00798"/>',
                   '<spring:message code="M02328"/>', 
                   '<spring:message code="L00324"/>', 
                   '<spring:message code="S00025"/>', 
                   '<spring:message code="L00341"/>',
                   '<spring:message code="S00024"/>',
                   '<spring:message code="S00026"/>'
                   ],
         colModel:[
             {name:'chnlNm',index:'chnl.chnl_nm', align:'center'},
             {name:'memberNum',index:'mss.member_num', align:'center'},
             {name:'memberNm',index:'mss.member_nm', align:'center'}, 
             {name:'memTypeCdMarkName',index:'c1.mark_name', align:'center'},
             {name:'memPhaseCdMarkName',index:'c2.mark_name', align:'center'},
             {name:'ageIdMarkName',index:'c3.mark_name', align:'center'},
             {name:'genderCdMarkName',index:'c4.mark_name', align:'center'},
             {name:'segLifeCycleCdMarkName',index:'c5.mark_name', align:'center'},
             {name:'mainUseWeekdayMarkName',index:'c6.mark_name', align:'center'}
         ],
         radio : false,
         sortname: 'mss.member_num',
         sortorder: 'asc',
     };
    originJqGridOption = jqGridOption;
    conditionDetailGrid = $("#conditionDetailGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//조건추출 대상자 그리드 세팅 (컬럼선택 후)
function setConditionDetailGridCustom(colModelSettings) {
	
    var jqGridOption = {
 		loadComplete : function(data){
 			//대상자 회원수 세팅
 			var cnt = data.records;
 			if(!data.rows) {	cnt = 0;	}
 			$("#mbrCountTotal").text('<spring:message code="S00032" arguments="'+cnt+'"/>');
 			conditionData.mbrCount = cnt;
 		},
		serializeGridData : function( data ){
			
			data.preFillVolLt = conditionData.preFillVolLt;
			data.preVisitCnt = conditionData.preVisitCnt;
			data.condExtTerms = conditionData.condExtTerms;
			data.memPhaseCd = conditionData.memPhaseCd;
			data.memTypeCd = conditionData.memTypeCd;
			data.segLifeCycleCd = conditionData.segLifeCycleCd;
			data.ageId = conditionData.ageId;
			data.genderCd = conditionData.genderCd;
			data.mainUseWeekday = conditionData.mainUseWeekday;
			
			data.camId = camId;
			data.chnlNo = chnlNo;
			return data;
         },
         url:'<ifvm:action name="getSearchMbrInfoByCondition"/>',
         colNames:originJqGridOption.colNames,
         colModel:colModelSettings,
         radio : false,
         sortname: 'mss.member_num',
         sortorder: 'asc',
     };
    conditionDetailGrid = $("#conditionDetailGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//조건추출 대상자 목록 엑셀 다운로드
function excelDownload() {
	
	var reqObj = {};
	
	reqObj.strOrderby = conditionDetailGrid.jqGridOption.sortname;
	reqObj.strEndPaging = 'limit 0, 99999999';
	reqObj.rows = 99999999; 
	
	reqObj.preFillVolLt = conditionData.preFillVolLt;
	reqObj.preVisitCnt = conditionData.preVisitCnt;
	reqObj.condExtTerms = conditionData.condExtTerms;
	reqObj.memPhaseCd = conditionData.memPhaseCd;
	reqObj.memTypeCd = conditionData.memTypeCd;
	reqObj.segLifeCycleCd = conditionData.segLifeCycleCd;
	reqObj.ageId = conditionData.ageId;
	reqObj.genderCd = conditionData.genderCd;
	reqObj.mainUseWeekday = conditionData.mainUseWeekday;
	reqObj.camId = conditionData.camId;
	
	listurl = conditionDetailGrid.jqGridOption.url;
	$.ifvSyncPostJSON(listurl, reqObj
	, function(result){
		$.ifvSyncPostJSON( '<ifvm:action name="excelExport"/>' ,{ 
			fileName : 'campaign_' + $.ifvGetTodayDate()
			, header: conditionDetailGrid.jqGridOption.colModel
			, headerName : conditionDetailGrid.jqGridOption.colNames 
			, data : result.rows
		}, function(result){
			qtjs.href(result.message);
		});
	});
}

//조건추출 설정 버튼 클릭 시
$('#conditionPopupOpenBtn').on('click', function(){
	conditionMain.conditionPopupOpen();
});

//엑셀 다운로드
$('#excelDownloadBtn').on('click', function(){
    excelDownload();
});

//조건추출 저장 버튼 클릭 시
$('#saveConditionBtn').on('click', function(){
	conditionMain.saveCondition();
});

//컬럼 설정 버튼 클릭 시 
$('#columnSetBtn').on('click', function(){
    conditionColumnSetPopupOpen();
});

$(document).ready(function() {
	conditionId = '<%= cleanXss(request.getParameter("conditionId")) %>';
	
	//조건추출 입력 조건 세팅
	setConditionDetail();
	//조건추출 그리드 세팅
	setConditionDetailGrid();
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="S00008" />
        &gt; <spring:message code="M00582" />
    </h1>
</div>

<div id="targetGroupDetail_area">
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="S00008" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r" id="conditionDetailBtn_area">
            <button class="btn btn-sm" id="conditionPopupOpenBtn">
                <spring:message code="S00034" />
            </button>
        </div>
    </div>
    <div>
        <div class="well form-horizontal underline">
			<!-- 조건선택영역1 기간, 충전량 ... -->
			<div id="conditionFirstArea" class="pop_inner_wrap form-horizontal">
				<div class="row group_box_line popup_contents_height" id="conditionFirstCon">
					<div class="row qt_border" style="margin-top:5px; margin-bottom:5px;">
					    <label class="col-xs-1 control-label"><spring:message code="M00607"/></label>    
					    <div class="col-xs-1 control_content">
					        <ifvm:input type="text" id="condExtTermsDtl" names="condExtTermsDtl" disabled="true"/>
					    </div>
					    <label class="col-xs-1 control-label"><spring:message code="M00944"/></label>    
					    <div class="col-xs-1 control_content">
					        <ifvm:input type="text" id="preFillVolLtDtl" names="preFillVolLtDtl" disabled="true"/>
					    </div>
					    <label class="col-xs-1 control-label" style="text-align:left;"><spring:message code="S00020"/></label>
					    <label class="col-xs-1 control-label"><spring:message code="S00021"/></label>    
					    <div class="col-xs-1 control_content">
					        <ifvm:input type="text" id="preVisitCntDtl" names="preVisitCntDtl" disabled="true"/>
					    </div>
					    <label class="col-xs-1 control-label" style="text-align:left;"><spring:message code="S00022"/></label>    
					</div>
				</div>
			</div>
			
			<div class="row qt_border"/>
			<div class="row qt_border"/>
	
			<!-- 조건선택영역2 E1등급, 고객유형 ... -->
			<div id="conditionSecondArea" class="pop_inner_wrap form-horizontal">
				<div class="row group_box_line popup_contents_height" id="conditionSecondCon">
					<div class="row qt_border" style="margin-top:5px;">
					    <label class="col-xs-1 control-label"><spring:message code="S00023"/></label>    
					    <div class="col-xs-2 control_content">
					        <ifvm:input type="text" id="memPhaseCdDtl" names="memPhaseCdDtl" disabled="true"/>
					    </div>
					    <label class="col-xs-1 control-label"><spring:message code="M02328"/></label>    
					    <div class="col-xs-2 control_content">
					        <ifvm:input type="text" id="memTypeCdDtl" names="memTypeCdDtl" disabled="true"/>
					    </div>
					    <label class="col-xs-1 control-label"><spring:message code="S00024"/></label>    
					    <div class="col-xs-2 control_content">
					        <ifvm:input type="text" id="segLifeCycleCdDtl" names="segLifeCycleCdDtl" disabled="true"/>
					    </div>
					</div>
					<div class="row qt_border" style="margin-bottom:5px;">
					    <label class="col-xs-1 control-label"><spring:message code="S00025"/></label>    
					    <div class="col-xs-2 control_content">
					    	<ifvm:input type="text" id="ageIdDtl" names="ageIdDtl" disabled="true"/>
					    </div>
					    <label class="col-xs-1 control-label"><spring:message code="V00124"/></label>    
					    <div class="col-xs-2 control_content">
					        <ifvm:input type="text" id="genderCdDtl" names="genderCdDtl" disabled="true"/>
					    </div>
					    <label class="col-xs-1 control-label"><spring:message code="S00026"/></label>    
					    <div class="col-xs-2 control_content">
					        <ifvm:input type="text" id="mainUseWeekdayDtl" names="mainUseWeekdayDtl" disabled="true"/>
					    </div>
					</div>
				</div>
			</div>
        </div>
        <!-- 대상자 목록 레이블, 엑셀다운로드 버튼 영역 -->
        <div class="page_btn_area">
		    <div class="col-xs-5">
			    <span><spring:message code="M01217"/></span>
			    <span id="mbrCountTotal" style="color:#E71D36;"></span>
		    </div>
            <div class="col-xs-7 searchbtn_r">
                <button class="btn btn-sm" id="columnSetBtn">
                    <spring:message code="M01496" />
                </button> 
                <button class="btn btn-sm" id="excelDownloadBtn">
                    <spring:message code="M01218" />
                </button> 
            </div>
		</div>
		<!-- 대상자 목록 그리드 영역 -->
        <div id="conditionDetailGrid" class="white_bg grid_bd0"></div>
        
        <div class="row qt_border"/>
        
        <div class="pop_btn_area" style="border-top:unset;" id="saveConditionBtnArea">
			<button class="btn btn-sm" id="saveConditionBtn">
				<spring:message code="L00074" />
			</button> 
	   </div>
    </div>
</div>

<div id="conditionColumnSetPopup"></div>
