<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
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
var socketListGridRowId;
var socketInfoValidation;

var getSocketInfoFrom = {
	init : function(){
 		var rowId = '<%= cleanXss(request.getParameter("rowId")) %>';
		
		$.fn.ifvmSetSelectOptionCommCode( "socketIoType", "QIM_PARAM_INOUT", null, null, true );
		$.fn.ifvmSetSelectOptionCommCode( "socketAttribute", "QIM_SOCKET_PROP", null, null, true );
		
		//상세 팝업 
 		if(rowId == 'null' || rowId == undefined){
 			socketListGridRowId = null;
 		} else {
 			socketListGridRowId = rowId;
			$("#ifSocketListPop").dataSetting(interfaceData.socketList[rowId]);
            $("input:checkbox[id='socketUseYn']").attr("checked", (interfaceData.socketList[rowId].socketUseYn == "1"));
		}
	}
}

$(document).ready(function(){
	getSocketInfoFrom.init();
	
 	//선택
	$("#addSocketInfoListBtn").on("click", function(){
		
		socketInfoValidation = $("#ifSocketListPop").ifvValidation();
		
		if (socketInfoValidation.confirm()) {
	        var data = {};
	        data.socketRid  		= $.fn.ifvmIsEmptyNull($("#socketRid").val());											//파라미터 아이디
	        data.socketColumnNm		= $.fn.ifvmIsEmptyNull($("#socketColumnNm").val());										//컬럼명
	        data.socketIoType		= $.fn.ifvmIsEmptyNull($("#socketIoType").val());										//유형
	        data.socketDataLength  	= $.fn.ifvmIsEmptyNull($("#socketDataLength").val());									//데이터길이
	        data.socketOrderBy  	= $.fn.ifvmIsEmptyNull($("#socketOrderBy").val());										//정렬순서
	        data.socketAttribute 	= $.fn.ifvmIsEmptyNull($("#socketAttribute").val());									//속성
	        data.socketDefaultValue  = $.fn.ifvmIsEmptyNull($("#socketDefaultValue").val());								//기본값
	        data.socketUseYn  		= $.fn.ifvmIsEmptyNull($("#socketUseYn").is(":checked") == true ? "1" : "0");			//활성여부
	        data.socketIoTypeMark  	= $.fn.ifvmIsEmptyNull($("#socketIoType option:selected").text());						//유형마크네임
	        data.socketAttributeMark  	= $.fn.ifvmIsEmptyNull($("#socketAttribute option:selected").text());				//유형마크네임
	        data.socketUseYnMark 	= (data.socketUseYn == '1' ) ? '<spring:message code="Q00024"/>' : '<spring:message code="Q00025"/>';	//활성여부 활성 비활성
	        
	        //수정 or 등록 여부 확인
	        if ($.fn.ifvmIsNotEmpty(socketListGridRowId)) {
	            //그리드 row 수정
	            //socketListGrid.setRowDatas(data);
	            $.extend(interfaceData.socketList[socketListGridRowId], data);
	            socketListGrid.opt.gridControl._setModel('dataSource', interfaceData.socketList);
	        }
	        else {
	            //그리드 row 추가
	            socketListGrid.opt.gridControl.addRecord(data);
	        }
	        //전역변수에 값 매핑
	        interfaceData.socketList = socketListGrid.opt.gridControl.model.currentViewData;

	        // 그리드 재설정
	        socketListInit();

	        //close popup
	        popupClose();
	    }		
		
	});
	
	//취소
	$("#cancelSocketInfoListBtn").on("click", function(){
		popupClose();
	});
	
});
</script>

<div id="ifParmList">
    <div class="pop_inner_wrap form-horizontal" id="ifSocketListPop" >
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span><spring:message code="Q00004" /></span> <!-- 기본 정보 -->
			</div>
		</div>       
        <div class="row qt_border">
        	<ifvm:inputNew type="hidden" id="socketRid" dto="socketRid" />
			<ifvm:inputNew type="text" id="socketColumnNm" dto="socketColumnNm" label="Q02901" labelClass="2" conClass="4" required="true" /> <!-- 컬럼명 -->
        	<ifvm:inputNew type="select" id="socketIoType" names="socketIoType" dto="socketIoType" label="Q02875" labelClass="2" conClass="4" required="true" /> <!-- 유형 -->
        </div>
        <div class="row qt_border">
        	<ifvm:inputNew type="text" id="socketDataLength" dto="socketDataLength" label="Q02879" labelClass="2" conClass="4" required="true" valiItem="number" /> <!-- 데이터길이 -->
        	<ifvm:inputNew type="text" id="socketOrderBy" names="socketOrderBy" dto="socketOrderBy" label="Q02899" labelClass="2" conClass="4" /> <!--정렬순서 -->
        </div>
        <div class="row qt_border">
        	<ifvm:inputNew type="select" id="socketAttribute" names="socketAttribute" dto="socketAttribute" label="Q02875" labelClass="2" conClass="4" required="true" /> <!-- 속성 -->
        	<ifvm:inputNew type="text" id="socketDefaultValue" dto="socketDefaultValue" label="Q02881" labelClass="2" conClass="4" /> <!-- 기본값 -->
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="singleCheckbox" id="socketUseYn" dto="socketUseYn" label="Q02882" labelClass="2" conClass="4" /> <!-- 활성 여부 -->
        </div>
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="addSocketInfoListBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="cancelSocketInfoListBtn">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>