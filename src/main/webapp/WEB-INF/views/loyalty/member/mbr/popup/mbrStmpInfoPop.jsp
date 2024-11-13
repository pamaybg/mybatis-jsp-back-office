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
var mbrStmpInfoTab;

var ridStmp = '<%=cleanXss(request.getParameter("ridStmp"))%>';
ridStmp = ridStmp === 'null' ? null : ridStmp;

var stmpInfoObj = {
	initStmpInfo : function(data) {
		this.getStmpDetail();
		this.initStmpTab();
	},
	//스탬프 상세조회
	getStmpDetail : function(data) {
		$.ifvPostJSON('<ifvm:action name="getLoyStmpDetail2"/>', {
			rid : ridStmp
		}, function(result) {
			
			$.fn.ifvmSetSelectOptionCommCode("stmpStatus", "LOY_STMP_SATUS_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("applyChnlCd", "LOY_STMP_APPLY_CHNL_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("calcTypeCd", "LOY_STMP_CALC_TYPE_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCodeSync("calcTypeSubCd", "LOY_STMP_CALC_TYPE_SUB_CD", null, 'calcTypeCd', true);
			
			$("#mbrTgtYn").append("<option value='N'>N</option>");
			$("#mbrTgtYn").append("<option value='Y'>Y</option>");
			
			$("#stmpDetailForm").dataSetting(result);
			$('#stmpDt').val(result.stmpStartDt + ' ~ ' + result.stmpEndDt);
			
			$('#calcTypeCd').change();
			$("#stmpDetailForm").dataSetting(result);
		});
	},
	//스탬프 상세 탭 초기화
	initStmpTab : function(data) {
		mbrStmpInfoTab = $('#stmpTabArea').DrawTab({
			item : [
			{	label : '구간별 스탬프', 	href : '<ifvm:url name="stmpInfoItemList"/>'	},
			{	label : '적용 채널', 		href : '<ifvm:url name="stmpInfoStoreList"/>'	},
			]
		});
	}
}

$(document).ready(function(){
	stmpInfoObj.initStmpInfo();
});

</script>

<div class="form-horizontal underline top_well" id="stmpDetailForm">
	<div class="row qt_border">
		<!-- 스탬프명 -->
		<ifvm:inputNew type="text" id="stmpNm" dto="stmpNm" label="스탬프명" nuc="true" labelClass="1" conClass="3" disabled="true"/>
		<!-- 스탬프번호 -->
		<ifvm:inputNew type="text" id="stmpNo" dto="stmpNo" label="스탬프번호" nuc="true" labelClass="2" conClass="2" disabled="true"/>
		<!-- 상태 -->
		<ifvm:inputNew type="text" id="stmpStatusNm" names="stmpStatusNm" dto="stmpStatusNm" label="상태" nuc="true" labelClass="2" conClass="1" disabled="true"/>
	</div>
	<div class="row qt_border">
		<!-- 행사기간 -->
		<ifvm:inputNew type="text" id="stmpDt" dto="stmpDt" label="행사기간" labelClass="1" conClass="3" nuc="true" disabled="true"/>
		<!-- 개수 -->
		<ifvm:inputNew type="text" id="stmpCnt" dto="stmpCnt" label="개수" nuc="true" labelClass="2" conClass="2" disabled="true"/>
		<!-- 적용채널 -->
		<ifvm:inputNew type="text" id="applyChnlCdNm" names="applyChnlCdNm" dto="applyChnlCdNm" label="적용채널" nuc="true" labelClass="2" conClass="1" disabled="true"/>
	</div>
	<div class="row qt_border">
		<!-- 기준유형 -->
		<ifvm:inputNew type="select" id="calcTypeCd" names="calcTypeCd" dto="calcTypeCd" label="계산유형" nuc="true" labelClass="1" conClass="1" disabled="true"/>
		<!-- 기준유형 -->
		<ifvm:inputNew type="select" id="mbrTgtYn" names="mbrTgtYn" dto="mbrTgtYn" label="특정회원여부" nuc="true" labelClass="1" conClass="1" disabled="true"/>
		<!-- 기준유형 상세 -->
		<ifvm:inputNew type="select" id="calcTypeSubCd" names="calcTypeSubCd" dto="calcTypeSubCd" label="계산유형 상세" nuc="true" labelClass="2" conClass="2" disabled="true"/>
		<!-- 구매횟수 최소금액 -->
		<ifvm:inputNew type="text" id="purCntMinAmt" dto="purCntMinAmt" label="구매횟수 최소금액" nuc="true" labelClass="2" conClass="1" disabled="true"/>
	</div>
</div>

<div id="stmpTabArea">
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>