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
<script>
var condChnlInfoPopValidation;
var condChnlListPopup;
var chnlOpenType = '<%= cleanXss(request.getParameter("chnlOpenType")) %>';

function initCondChnlInfoPop() {
	/* $.fn.ifvmSetSelectOptionCommCode("type", "RULESET_TYPE", null, null, true);
	$("select[name='type'] option[value='EX']").remove(); */
	/* $.fn.ifvmSetSelectOptionCommCode("targetType", "RULESET_TARGET_TYPE", null, null, true); */
	//채널유형
	condChnlInfoPopValidation = $("#condChnlInfoPopDiv").ifvValidation();
}

/* function condChnlSeachPopupSave(){
		$("#condChnlInfoPopDiv #chnlId").val($("#condChnlListPop #chnlCd").val())
		$("#condChnlInfoPopDiv #chnlNm").val($("#condChnlListPop #chnlNm").val())
		$("#condChnlInfoPopDiv #chnlRid").val($("#condChnlListPop #ridChnl").val());
		condChnlListPopClose();
} */

function condChnlListPopClose(){
	condChnlListPopup._destroy();
}

/* function condChnlSearchBtnInit(){
	if($("#condChnlInfoPopDiv #targetType").val()=='ALL'){
		$("#chnlSearchBtn").addClass("hidden");
		$("#condChnlInfoPopDiv #chnlId").val("");
		$("#condChnlInfoPopDiv #chnlNm").val("");
		$("#condChnlInfoPopDiv #chnlRid").val("");

	}else{
		$("#chnlSearchBtn").removeClass("hidden");
	}
} */

function initCondChnlInfoPopData(data){
	/* $("#condChnlInfoPopDiv #type").val(data.ouTypeCd); */
	$("#condChnlInfoPopDiv #chnlNm").val(data.chnlNm);
	$("#condChnlInfoPopDiv #chnlId").val(data.chnlNo);
	$("#condChnlInfoPopDiv #ridChnl").val(data.ridChnl);

	/* $("#condChnlInfoPopDiv #type").val(data.type); */

	/* $("#condChnlInfoPopDiv #targetType").val(data.targetType); */
	/* condChnlSearchBtnInit(); */

}

//채널 목록 팝업 닫기
function condChnlListPopupClose() {
	condChnlListPopup._destroy();
}

//채널 목록 팝업 선택
function condChnlListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(condChnlListPopGrid.getCheckedList())) {
		var selData = condChnlListPopGrid.getCheckedList()[0];
		$("#condChnlInfoPopDiv #chnlNm").val(selData.chnlNm);	//채널명
		$("#condChnlInfoPopDiv #chnlId").val(selData.chnlNo);	//채널코드
		$("#condChnlInfoPopDiv #ridChnl").val(selData.rid);	    //rid
		/* $("#condChnlSearchPop #ouTypeCd").val(selData.ouTypeCd); */

		//close popup
		condChnlListPopupClose();
	} else {
		alert("<spring:message code='L00173'/>");

		return false;
	}
}

$(document).ready(function() {
	initCondChnlInfoPop();

	/* condChnlSearchBtnInit(); */
	//저장 클릭시
    $('#condChnlInfoPopSaveBtn').on('click', function(){
    	condChnlInfoPopupSave();
    });

    //닫기 클릭시
    $('#condChnlInfoPopCancelBtn').on('click', function(){
    	condChnlInfoPopupClose();
    });

    $("#chnlSearchBtn").removeClass("hidden");
	$('#chnlSearchBtn').on('click', function(){
		$("#condChnlListPopup").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="condChnlListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00172"/>',
	        width: '600px',
	        close : 'condChnlListPopupClose'
	    });
	});

	/* $("#condChnlInfoPopDiv #targetType").on('change',function(){
		condChnlSearchBtnInit();
	}) */

	if(chnlOpenType=='E'){
		initCondChnlInfoPopData(selCondChnlData);
	}



});
</script>

	<div class="pop_inner_wrap form-horizontal" id="condChnlInfoPopDiv" >
		<%-- <div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>제한유형</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="select"  required="true" id="type" names="type" />
                </div>
            </div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>대상</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                 	<ifvm:input type="select"  required="true" id="targetType" names="targetType" />
                </div>
            </div>
		</div> --%>

		<div class="row qt_border">
	       <label class="col-xs-3 control-label"><spring:message code="L00279"/></label>
	        <div class="col-xs-9 control_content">
	            <div class="input-group">
		            <ifvm:input type="text" id="chnlId" readonly="true"/>
					<span class="input-group-addon" id="chnlSearchBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
					<ifvm:inputNew type="hidden" id="chnlRid" maxLength="50"  dto="chnlRid"     labelClass="0" conClass="2" />
				</div>
	        </div>
		</div>

		<div class="row qt_border">
	       <label class="col-xs-3 control-label"><spring:message code="L00280"/></label>
	        <div class="col-xs-9 control_content">
	            <div class="input-group">
		            <ifvm:input type="text" id="chnlNm" readonly="true"/>
				</div>
	        </div>
		</div>



	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="condChnlInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm" id="condChnlInfoPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>

<div id="condChnlListPopup" class="popup_container"></div>

