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
<div class="page-title">
    <h1>
        <spring:message code="등급 그룹"/>
        &gt;  <spring:message code="상세"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	        <span><spring:message code="등급 그룹 상세"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	    	<%-- <ifvm:inputNew type="button" id="goSave" btnFunc="tierBatchCall" text="등급 심사" objCode="tierGroupDetailNewBatchCall_OBJ"/>
	    	<ifvm:inputNew type="button" id="goSave" btnFunc="tierInitCall" text="등급초기화" objCode="tierGroupDetailNewInitCall_OBJ"/> --%>
			<ifvm:inputNew type="button" btnType="check" id="goSave" btnFunc="tierGroupDetail.save" text="I00745" objCode="tierGroupDetailNewInitSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="tierGroupDetail.goList" text="L00824" objCode="tierGroupDetailNewList_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="tierGroupDetail" >
			<div class="row  qt_border">
				<ifvm:inputNew type="select" id="tiersGrpCd" dto="tiersGrpCd" names="tiersGrpCd"  label="등급그룹명" labelClass="1" conClass="3" required="true"/>
				<ifvm:inputNew type="hidden" id="tiersGrpNm" dto="tiersGrpNm" names="tiersGrpNm" conClass="1" />
				<ifvm:inputNew type="search" disabled="true" id="pgmNm" dto="pgmNm" btnFunc="tierLoyPgmPop" label="로열티프로그램" labelClass="1" conClass="3" required="true"/>
				<ifvm:inputNew type="hidden"  id="pgmRid" dto="pgmRid" conClass="1" required="true" disabled="true"/>
				<ifvm:inputNew type="select" id="loyMbrTypeCd" dto="loyMbrTypeCd" names="loyMbrTypeCd" label="회원유형" labelClass="1" conClass="1" maxLength="15"  required="true"/>
				<ifvm:inputNew type="search" id="brdNm" dto="brdNm" label="브랜드" btnFunc="tierBrandListPop" labelClass="1" conClass="1" required="true"/>
				<ifvm:inputNew type="hidden" id="brdRid" dto="brdRid" conClass="1" disabled="true" required="true"/>

			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="search" id="mbrDsNm" dto="mbrDsNm" label="대상그룹" labelClass="1" conClass="3" btnFunc="DataSetPop" disabled="true" required="true"/>
				<ifvm:inputNew type="hidden" id="dataSetRid" dto="dataSetRid" conClass="1" disabled="true" required="true"/>
				<ifvm:inputNew type="select" id="mbrTierCol" dto="mbrTierCol" names="mbrTierCol" label="등급그룹유형" labelClass="1" conClass="2" maxLength="15" />
				<ifvm:inputNew type="date" id="vaildStartDt" dto="vaildStartDt" maxLength="5" label="유효시작일" labelClass="1" conClass="2" required="true"/>
				<ifvm:inputNew type="select" id="statCd" dto="statCd" names="statCd" label="상태" labelClass="1" conClass="1" maxLength="15"   required="true"/>
			</div>
			
		   <div class="row qt_border">
			   <ifvm:inputNew type="textarea" maxLength="150" id="tgComment" dto="tgComment" label="설명" labelClass="1" conClass="11" rows="5"/>
			</div>
			
			<ifvm:inputNew type="hidden" id="cateMbr" conClass="1"  disabled="true"/> 
		</div>
	</div>
	<div id="tierGroupDetailNewTabArea"></div>

<div id="dataSetListPop" class="popup_container"></div>
<div id="loyPgmListPop" class="popup_container"></div>
<div id="brandListPop" class="popup_container"></div>

<script type="text/javascript">
var pgmRid = '<%= cleanXss(request.getParameter("pgmRid")) %>';
var dataSetRid = '<%= cleanXss(request.getParameter("dataSetRid")) %>';
var tierGroupDetail_rid = '<%= cleanXss(request.getParameter("rid")) %>';
tierGroupDetail_rid = tierGroupDetail_rid == 'null' ? null : tierGroupDetail_rid;
var tierGroupDetail_isNew = '<%= cleanXss(request.getParameter("tierGroupDetail_isNew")) %>';  //신규 여부. 신규: true, 수정 : false
var tierGrpStatCd= '<%= cleanXss(request.getParameter("tierGrpStatCd")) %>';
var mbrTierCol= '<%= cleanXss(request.getParameter("mbrTierCol")) %>';
var CateMbr = '<%= cleanXss(request.getParameter("CateMbr")) %>';
var tierGroupDetailNewTabArea = $('#tierGroupDetailNewTabArea').DrawTab({
	item: items
	/* [
		{label: '<spring:message code="등급"/> ', href: '<ifvm:url name="tierListNewPage"/>'},  
		{label: '<spring:message code="심사 정책"/> ', href: '<ifvm:url name="tierGroupJobList"/>'},  
	] */
});

var tierGroupDetail={
		init : function(){
			$("#cateMbr").val("MBR");
			$.fn.ifvmSetSelectOptionCommCode("tiersGrpCd", "LOY_MBR_TIER_GRP_TYPE_CD", null, null, false);
			$.fn.ifvmSetSelectOptionCommCode("loyMbrTypeCd", "LOY_TIERS_GRP_TG_MBR_TYPE_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("mbrTierCol", "LOY_MBR_TIER_TYPE_COL_CD", null, null, true);

			this.action();

	    	if (tierGroupDetail_rid === null){
	    		tierGrpStatCd=null;
				$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", 'W', null, true);
				$("#statCd").attr('disabled', true);
	    		tierGroupDetail_isNew = true;
	    		tierGroupDetailNewTabArea.disabledTab([0,1]);	
	    	}
			else
				tierGroupDetail_isNew = false;
			if (!tierGroupDetail_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getTierGroupDetailNew"/>', {
					rid : tierGroupDetail_rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#tierGroupDetail").dataSetting(result);
						$("#mbrDsNm").val(result.dsNm);
						pgmRid = result.pgmRid;
						$("#pgmRid").val(result.pgmRid);
						dataSetRid= result.dataSetRid;
						$("#dataSetRid").val(result.dataSetRid);
						tierGrpStatCd = result.statCd;
						mbrTierCol = result.mbrTierCol;
						//$("#brdRid").val(result.brdRid);
						//$("#brdNm").val(result.brdNm);

					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#tierGroupDetail").ifvValidation();
			//유효성 체크
			if(validation.confirm()){
				 /*  if(tierGrpStatCd == 'A') {
					if($('#statCd').val()=='W') {
						alert("작성중으로 돌아갈수 없습니다.");
						return;
					}
				} else if(tierGrpStatCd == 'S') {
					if($('#statCd').val()=='W') {
						alert("작성중으로 돌아갈수 없습니다.");
						return;
					}
				} else if(tierGrpStatCd == 'W') {
					if($('#statCd').val()=='S') {
						alert("작성중에서 중지로 돌아갈수 없습니다.");
						return;
					}
				} */

				var url = tierGroupDetail_isNew? '<ifvm:action name="savetierGroup"/>' : '<ifvm:action name="modifytierGroup"/>';
				var varData = null;
				varData = $("#tierGroupDetail").getSubmitData();
				varData.rid = tierGroupDetail_rid;
				varData.dsNm = $('#mbrDsNm').val();
				varData.pgmRid = pgmRid;
				varData.dataSetRid = dataSetRid;

				$.ifvSyncPostJSON(url, varData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
					qtjs.href('<ifvm:url name="tierGroupListNewPage"/>');
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		},//SAVE END
		goList : function(){
			//location.href = '<ifvm:url name="srcTgtList"/>';
			qtjs.href('<ifvm:url name="tierGroupListNewPage"/>');
		}
		,action : function(){
			$("#tiersGrpCd").change(function(){
				var target = $(this)[0];
				//ifvGlobal["tiersGrpId"] = target[target.selectedIndex].getAttribute("codeid");
				var val = target.options[target.selectedIndex].text;
				$("#tiersGrpNm").val(val)

			})
		}
	}
//달력셋팅
function setValidCalendar() {	
	var vaildStartDt = $("#vaildStartDt");

	vaildStartDt.val($.ifvGetTodayDate());

	vaildStartDt.ifvDateChecker({
		
	});
}

/* function tierBatchCall() {
	$.ifvSyncPostJSON('<ifvm:action name="tierBatchCall"/>', {
    }, function(result) {
		if (result.success == true)
			alert("등급 심사완료");
		else
			alert("등급 심사가 실패하였습니다.");
	});
} 

function tierInitCall() {
	$.ifvSyncPostJSON('<ifvm:action name="tierInitCall"/>', {
    }, function(result) {
		if (result.success == true)
			alert("등급 초기화 완료");
		else
			alert("등급 초기화가 실패하였습니다.");
	});
}*/


function tierLoyPgmPop() {
	$("#loyPgmListPop").ifvsfPopup({
		enableModal : true,
	    enableResize: false,
	    contentUrl: '<ifvm:url name="loyPgmListPopup"/>',
	    contentType: "ajax",
	    title: '<spring:message code="L02716"/>',
	    width: '600px',
	    close : 'loyPgmListClosePop',
	});
}

function DataSetPop() {
	$("#dataSetListPop").ifvsfPopup({
		enableModal : true,
	    enableResize: false,
	    contentUrl: '<ifvm:url name="dataSetListPop"/>',
	    contentType: "ajax",
	    title: '대상그룹 등록',
	    width: '800px',
	    close : 'dataSetListClosePop',
	});
}

function tierBrandListPop() {
	$("#brandListPop").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: '<ifvm:url name="brandPop"/>',
		contentType: "ajax",
		title: '브랜드 조회',
		width: '800px',
		close : 'tierBrandListClosePop',
	});
}

function loyPgmListClosePop() {
	loyPgmListPop._destroy();
}

function dataSetListClosePop() {
	dataSetListPop._destroy();
}

function tierBrandListClosePop() {
	brandListPop._destroy();
}

$(document).ready(function(){
	setValidCalendar();//달력셋팅
	tierGroupDetail.init();
});

</script>