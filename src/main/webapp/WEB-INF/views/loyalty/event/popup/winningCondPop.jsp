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
<div id="winningCondForm">
	<div class="form-horizontal underline top_well">
		<div class="page_btn_area">
			<div class="col-xs-9">
				<span>기본정보</span>
			</div>
			<div class="col-xs-3">
				<ifvm:inputNew type="button" id="winCondSaveBtn" btnType="save" text="L00074" btnFunc="winCondSave"/>
				<ifvm:inputNew type="button" id="abstrBtn" text="추출" nuc="true"/>
				<ifvm:inputNew type="button" id="winConfirmBtn" text="당첨확정" nuc="true"/>
			</div>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="rowId" labelClass="2" conClass="3" label="ROW ID" nuc="true" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="voteCnt" labelClass="2" conClass="3" label="응모 건수" nuc="true" disabled="true"/>
			<ifvm:inputNew type="text" id="applicantCnt" labelClass="2" conClass="3" label="응모자 수" nuc="true" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="winningCnt" labelClass="2" conClass="3" label="당첨 인원" nuc="true" required="true"/>
			<ifvm:inputNew type="text" id="extrResult" labelClass="2" conClass="3" label="추출 결과" nuc="true" disabled="true"/>
		</div>
		<div class="row qt_border">
		<label class="col-xs-2 control-label">조건설정</label>
			<div class="col-xs-10 control_content">
				<ifvm:inputNew type="radio" id="condSetting" text="전체|성별|연령대|성별&연령대" values="all|gender|age|genderAge" nuc="true" checkIndex="1" 
				labelClass="2" conClass="12"/>
			</div>
		</div>
	</div>
</div>
<div id="winningCondTabArea" style="margin-top:20px"></div>

<script>

	var rid ='<%= cleanXss(request.getParameter("rid")) %>';
	var winningCondTab;
	
	function getWinningCond(){
		$.ifvSyncPostJSON('<ifvm:action name="getWinningCond"/>',{
			rid : rid
		},function(result){
			$('#voteCnt').val(result.voteCnt);
			$('#applicantCnt').val(result.apllicantCnt);
		});
	}
	
	/**
	 * 탭 설정
	 */
	function initTab() {
	    /* 탭 */
	    winningCondTab = $('#winningCondTabArea').DrawTab({
	        item: [
	            {label: '성별', href: '/loyalty/event/include/genderSettingTab'},
	            {label: '연령대', href: ''},
	            /* {label: '성별&연령대', href: ''}, */
	        ]
	    });
	}
	
	$(document).ready(function() {
		//탭설정
		initTab();
		getWinningCond();
	});
</script>