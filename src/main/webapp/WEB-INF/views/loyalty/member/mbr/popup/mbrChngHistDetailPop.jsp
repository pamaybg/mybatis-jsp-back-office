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

<div class="form-horizontal underline top_well" id="mbrChngHistDetailForm">
    <div class="row qt_border">
        <div class="col-xs-6 control_content">
            <ifvm:inputNew type="text" id="changeDate" label="변경일시" labelClass="2" conClass="9" disabled="true"/>
        </div>
        <div class="col-xs-6 control_content">
            <ifvm:inputNew type="text" id="changeCol" label="변경컬럼" labelClass="2" conClass="9" disabled="true"/>
        </div>
    </div>
    <div class="row qt_border">
        <div class="col-xs-6 control_content">
            <ifvm:inputNew type="textarea" id="preChange" label="변경전" labelClass="2" conClass="9" rows="5" disabled="true"/>
        </div>
        <div class="col-xs-6 control_content">
            <ifvm:inputNew type="textarea" id="postChange" label="변경후" labelClass="2" conClass="9" rows="5" disabled="true"/>
        </div>
    </div>
    <div class="row qt_border">
        <div class="col-xs-6 control_content">
            <ifvm:inputNew type="textarea" id="note" label="비고" labelClass="2" conClass="9" rows="3" disabled="true"/>
        </div>
        <div class="col-xs-6 control_content">
            <ifvm:inputNew type="text" id="modifyBy" label="수정자" labelClass="2" conClass="9" disabled="true"/>
        </div>
    </div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray btn_lightGray1" id="closeBtn" objCode="mbrChngHistDetailClose_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>


<script>
	var createDate = '<%= cleanXss(request.getParameter("createDate")) %>';
	var chgColNm = '<%= cleanXss(request.getParameter("chgColNm")) %>';
	var bchngData = '<%= cleanXss(request.getParameter("bchngData")) %>';
	var achngData = '<%= cleanXss(request.getParameter("achngData")) %>'; 
	var rMark = '<%= cleanXss(request.getParameter("rMark")) %>';
	var modifyBy = '<%= cleanXss(request.getParameter("modifyBy")) %>';

	
	function loadDataIntoField(){
		// null이면 공백으로 바꿔준다(안그러면 필드에 'null'로 나와버림)
		var _createDate = (createDate == null || createDate == 'null') ? '' : createDate;
		var _chgColNm =  (chgColNm == null || chgColNm == 'null') ? '' : chgColNm;
		var _bchngData = (bchngData == null || bchngData == 'null') ? '' : bchngData;
		var _achngData = (achngData == null || achngData == 'null') ? '' : achngData;
		var _rMark = (rMark == null || rMark == 'null') ? '' : rMark;
		var _modifyBy = (modifyBy == null || modifyBy == 'null') ? '' : modifyBy;
		
		$('#changeDate').val(_createDate);
		$('#changeCol').val(_chgColNm);
		$('#preChange').val(_bchngData);
		$('#postChange').val(_achngData);
		$('#note').val(_rMark);
		$('#modifyBy').val(_modifyBy);
	}
	
	function closeChngHistDetailPop() {
		chngHistDetailPopContainer._destroy();
	}
	
	
	$(document).ready(function(){
		loadDataIntoField();

		$('#closeBtn').click(function(){
			closeChngHistDetailPop();
		});	
	});

</script>