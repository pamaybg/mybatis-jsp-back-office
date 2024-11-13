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
var pramInfoValidation;
var pramListGridRowId;

var getpramInfoFrom = {
	init : function(){
		var rowId = '<%= cleanXss(request.getParameter("rowId")) %>';
		
		$.fn.ifvmSetSelectOptionCommCode( "paramType", "QIM_PARAM_INOUT", null, null, true );
		$.fn.ifvmSetSelectOptionCommCode( "paramDataType", "QIM_DATA_TYPE", null, null, true );
		
		//생성 팝업 
		if(rowId == 'null' || rowId == undefined){
			pramListGridRowId = null;
			var listSize = interfaceData.procedureList.length;
			
			if (listSize == undefined) {
				$("#paramSeq").val("1");
			} else {
				$("#paramSeq").val(listSize + 1);
			}
		} else { //상세 팝업
			pramListGridRowId = rowId;
			$("#ifParmListPop").dataSetting(interfaceData.procedureList[rowId]);
            $("input:checkbox[id='paramUseYn']").attr("checked", (interfaceData.procedureList[rowId].paramUseYn == "1"));
            $("input:checkbox[id='paramRequiredYn']").attr("checked", (interfaceData.procedureList[rowId].paramRequiredYn == "1"));
		}
	}
}


$(document).ready(function(){
	getpramInfoFrom.init();
	
	//선택
	$("#addParmInfoListBtn").on("click", function(){
		
		pramInfoValidation = $("#ifParmListPop").ifvValidation();
		
		if (pramInfoValidation.confirm()) {
	        var data = {};
	        data.paramRid  			= $.fn.ifvmIsEmptyNull($("#paramRid").val());										//파라미터 아이디
	        
	        data.paramType  		= $.fn.ifvmIsEmptyNull($("#paramType").val());										//유형
	        data.paramSeq  			= $.fn.ifvmIsEmptyNull($("#paramSeq").val());										//순서
	        data.paramName  		= $.fn.ifvmIsEmptyNull($("#paramName").val());										//이름
	        data.paramDataType 		= $.fn.ifvmIsEmptyNull($("#paramDataType").val());									//데이터유형
	        data.paramDataLength	= $.fn.ifvmIsEmptyNull($("#paramDataLength").val());								//데이터길이
	        data.paramDefaultValue  = $.fn.ifvmIsEmptyNull($("#paramDefaultValue").val());								//기본값
	        data.paramUseYn  		= $.fn.ifvmIsEmptyNull($("#paramUseYn").is(":checked") == true ? "1" : "0");		//활성여부
	        data.paramRequiredYn  	= $.fn.ifvmIsEmptyNull($("#paramRequiredYn").is(":checked") == true ? "1" : "0");	//필수여부
	        data.paramComment  		= $.fn.ifvmIsEmptyNull($("#paramComment").val());									//설명
	        
	        data.paramTypeMark  	= $.fn.ifvmIsEmptyNull($("#paramType option:selected").text());						//유형마크네임
	        data.paramDataTypeMark  = $.fn.ifvmIsEmptyNull($("#paramDataType option:selected").text());				//데이터 유형마크네임
	        data.paramRequiredYnMark = (data.paramRequiredYn == '1' ) ? 'Y' : 'N';										//필수여부 마크네임
	        data.paramUseYnMark 	= (data.paramUseYn == '1' ) ? '<spring:message code="Q00024"/>' : '<spring:message code="Q00025"/>';	//활성여부 활성 비활성
	        
	        //수정 or 등록 여부 확인
	        if ($.fn.ifvmIsNotEmpty(pramListGridRowId)) {
	            //그리드 row 수정
        	    $.extend(interfaceData.procedureList[pramListGridRowId], data);
        	    interfaceProcedureGrid.opt.gridControl._setModel('dataSource', interfaceData.procedureList);
	        }
	        else {
	            //그리드 row 추가
	            interfaceProcedureGrid.opt.gridControl.addRecord(data);
	        }

	        //전역변수에 값 매핑
	        interfaceData.procedureList = interfaceProcedureGrid.opt.gridControl.model.currentViewData;

	        // 그리드 재설정
	        procedureListInit();

	        //close popup
	        popupClose();
	    }		
		
	});
	
	//취소
	$("#cancelParmInfoListBtn").on("click", function(){
		popupClose();
	});
	
});
</script>

<div id="ifParmList">
    <div class="pop_inner_wrap form-horizontal" id="ifParmListPop" >
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span><spring:message code="Q00004" /></span> <!-- 기본 정보 -->
			</div>
		</div>       
        <div class="row qt_border">
        	<ifvm:inputNew type="hidden" id="paramRid" dto="paramRid" />
			<ifvm:inputNew type="text" id="paramSeq" dto="paramSeq" label="Q02876" labelClass="2" conClass="4" required="true" /> <!-- 순서 -->
        	<ifvm:inputNew type="select" id="paramType" names="paramType" dto="paramType" label="Q02875" labelClass="2" conClass="4" required="true" /> <!-- 유형 -->
        </div>
        <div class="row qt_border">
        	<ifvm:inputNew type="text" id="paramName" dto="paramName" label="Q02877" labelClass="2" conClass="4" required="true" /> <!-- 이름 -->
        	<ifvm:inputNew type="select" id="paramDataType" names="paramDataType" dto="paramDataType" label="Q02878" labelClass="2" conClass="4" required="true" /> <!--데이터 유형 -->
        </div>
        <div class="row qt_border">
        	<ifvm:inputNew type="text" id="paramDataLength" dto="paramDataLength" label="Q00023" labelClass="2" conClass="4" valiItem="number"/> <!-- 데이터 길이 -->
        	<ifvm:inputNew type="text" id="paramDefaultValue" dto="paramDefaultValue" label="Q02881" labelClass="2" conClass="4" /> <!-- 기본값 -->
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="singleCheckbox" id="paramUseYn" dto="paramUseYn" label="Q02882" labelClass="2" conClass="4" /> <!-- 활성 여부 -->
            <ifvm:inputNew type="singleCheckbox" id="paramRequiredYn" dto="paramRequiredYn" label="Q02880" labelClass="2" conClass="4" /> <!-- 필수 여부 -->
        </div>
        
        <div class="row">
            <ifvm:inputNew type="textarea" id="paramComment" dto="paramComment" label="Q00018" labelClass="2" conClass="10" rows="6" /> <!-- 설명 -->
        </div>
                
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="addParmInfoListBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="cancelParmInfoListBtn">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>