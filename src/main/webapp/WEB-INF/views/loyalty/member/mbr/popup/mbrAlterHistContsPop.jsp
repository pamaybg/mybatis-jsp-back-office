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
<style>
    .email_preview_wrap {
        float: left;
        width: 761px;
    }
    #altContsField_tools {
        display: none;
	}
</style>

<div class="page_btn_area" >
    <div class="col-xs-9">
    	<ifvm:inputNew type="text" id="altTitleField" label="제목" labelClass="1" conClass="8" readonly="true"/>
    </div>
</div>

<div id="textAreaDiv">
	<ifvm:inputNew type="textarea" id="altContsField" rows="15" readonly="true"/>
</div>

<div class="row qt_border"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray btn_lightGray1" id="closeBtn" objCode="mbrAlterHistClose_OBJ">         
		<spring:message code="닫기"/>
	</button>  
</div>


<script>
	// url파라미터로 보낸 값들을 가져온다
	var alterHistRid = '<%= cleanXss(request.getParameter("alterHistRid")) %>';
	var title = title;
	var altContsViewObj = null; // ejRTE객체
	var contsSbst = null;	// 내용보기에서 표시될 내용
	
	// html 화면용 텍스트필드 구성 함수
	function htmlPopup(){
		$('#altContsField').ejRTE({ // textarea를 ejRTE 화
		  	height : "440px",
	        width : "100%",
	        minWidth : "10px",
	        showFooter : false,
	        showHtmlSource : false,
	        maxLength:90000000,
	        allowEditing: false,
	        tools : {
	            formatStyle : [  ],
	            font : [ ],
	            style : [ ],
	            indenting : [],
	            images : [],
	            tables : [],
	            doAction : [],
	            links : [],
	            media : [],
	            view : [ "fullScreen" ]
	        }, 
	        pasteCleanupSettings:{
	            listConversion: true,
	            cleanCSS: false,
	            removeStyles: false,
	            cleanElements: false
	        },
	        select : function() {
	            //termsContsViewfocusCHeck = 'termsConts_Iframe'
	            altContsViewfocusCHeck = 'altConts_Iframe'
	        }
		});
		altContsViewObj = $('#altContsField').data("ejRTE");
		
		// ejRTE화면 구성이 다 된 후에, 값이 뿌려져야 하므로, 200밀리초 이후쯤에 내용값을 뿌려주도록 한다
		setTimeout(function (){
		    if ($("#altContsField").length) {
		    	altContsViewObj.setHtml(contsSbst);
		    }
		}, 200);
	}//end htmlPopup
	
	// 알림 내용을 로드해오는 함수
	function loadAlterHistConts(alterHistRid){
		var url = '<ifvm:action name="getAlterHistConts"/>';
		var varData = {
				rid : alterHistRid,  // 쿼리문에 투입될 것
		};
		$.ifvSyncPostJSON(url, varData, function(result){
			contsSbst = result.contsSbst;
			// 채널유형(exechnltypecd)에 따라 보통 textarea로 뿌려줄건지, 메일특화의 ejRTE식으로 뿌려줄 것인지 분기 처리
		 	if(result.exeChnlTypeCd == 'EMAIL') {
				htmlPopup();	
			} else { // PUSH,SMS,LMS,MMS,KAKAONOTI 일 떄 => 그냥 로드
				//$("#altContsField").dataSetting(result.contsSbst);
				$('#altContsField').val(result.contsSbst);				
			}
		}, function(result){
			if(result.message != null) {
				alert(result.message);
			} else {
				alert('알림 내용 로드 실패');
			}
		});
	}//end loadAlterHistConts
	
	function closeMbrAlterHistContsPop(){
		mbrAlterHistPopupContainer._destroy();
	}
	
	// 시행
	$(document).ready(function(){
		loadAlterHistConts(alterHistRid);
		
		$('#altTitleField').val(title);

		
		$('#closeBtn').click(function(){
			closeMbrAlterHistContsPop();
		});
	});
	
</script>
