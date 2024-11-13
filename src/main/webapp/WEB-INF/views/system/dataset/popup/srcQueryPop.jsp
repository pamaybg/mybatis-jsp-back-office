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
<div class="page_btn_area" >
    <div class="col-xs-7">
    	<ifvm:inputNew type="text" id="tblNmField" label="오브젝트명" labelClass="2" conClass="8" readonly="true"/>
    </div>
</div>

<div id="textAreaDiv">
	<ifvm:inputNew type="textarea" id="srcQueryField" rows="15" readonly="true"/>
</div>

<div class="row qt_border"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray btn_lightGray2" id="closeBtn" objCode="srcQueryPopCloseBtn_OBJ">         
		<spring:message code="닫기"/>
	</button>  
</div>


<script>
	var tblNm = '<%= cleanXss(request.getParameter("tblNm")) %>';
	
	function loadSrcQuery(tableNm){
		var url = '<ifvm:action name="getSrcQuery"/>';
		var varData = {
				tblNm : tableNm
		};
		$.ifvSyncPostJSON(url, varData, function(result){
			$('#srcQueryField').val(result.srcQuery);
		}, function(result){
			if(result.message != null) {
				alert(result.message);
			} else {
				alert('오브젝트 소스 로드 실패');
			}
		});
	}
	
	function closeSrcQueryPop(){
		srcQueryPopupContainer._destroy();
	}
	
	
	$(document).ready(function() {
		$('#tblNmField').val(tblNm);
		loadSrcQuery(tblNm);
		
		$('#closeBtn').click(function(){
			closeSrcQueryPop();	
		});
	});
	
</script>