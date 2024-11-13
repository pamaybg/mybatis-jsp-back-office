<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
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

var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var baseRid;				//기본채널 RID
var validationPop;

$(document).ready(function(){
	validationPop = $("#clubChnlLimitForm").ifvValidation();
	init();
});

function init(){
	getSelectData();
	getPopEvent();
	getBasicChnl();
	if(!isNewTab){
		getList();
		setDisplay();
	}
}

function getBasicChnl(){
	$("#basicChnl").val( $("#clubForm #chnlNm").val());
}

//이벤트
function getPopEvent(){

	$("#btnCancelPop").click(function(){
		tabChnlPopClose();
	});

	$("#btnSavePop").click(function(){
		if(validationPop.confirm()) actionSavePop();
	})

	$("#parChNmPop").on("change", function(){
		//채널
		$.ifvSyncPostJSON('<ifvm:action name="getChnlPop"/>',{
			chnlNo : $("#parChNmPop").val()
			, enableNA : true
		},function(result) {
			$("#chnlPop").empty();
			var temp = $("#chnlPopTemp").tmpl(result.rows);
			$("#chnlPop").append(temp);
		});
	});

}

function actionSavePop(){
	if(isNewTab){
		if(!isValidationPop()){
			return false;
		}
	}
	savePopSubmit();
}

function isValidationPop(){

	var bool = false;
	//중복체크
	$.ifvSyncPostJSON('<ifvm:action name="chkdup"/>',{
		rid : $("#clubChnlLimitForm #ridChnl").val(),
		chnlNo : $("#clubChnlLimitForm #chnlPop").val()
	},function(result){
		var msg = "이미 등록된 채널번호 [@기본-"+$("#chnlPop").val()+"] 입니다."
		if(result != 0){
			alert(msg);
		}else{
			bool = true;
		}
	});

	return bool;
}

function savePopSubmit(){

	var obj = getObject();
	$.ifvSyncPostJSON(isNewTab ? '<ifvm:action name="addLoyClubChnl"/>' :  '<ifvm:action name="updateLimitPop"/>',obj
	,function(result){
		if(result.success){
			alert('<spring:message code="L00127"/>');
			tabChnlPopClose();
			getTabChnlList();
		}else{
			alert('실패');
		}
	});
}

function getObject(){

	var obj = {};

	if(isNewTab){
		obj = {
			ridClub : rid,
			/* ridLinkChnl : $("#parChNmPop").val(), */
			ridChnl : $("#clubChnlLimitForm #ridChnl").val(),
			limitYn : $("#limitPop").val()
		}
	}else{
		obj = {
			rid	    : tabRid, //부모화면 tabChnlList의 row 선택 시 저장된다.
			ridChnl : $("#clubChnlLimitForm #ridChnl").val(),
			limitYn : $("#limitPop").val(),
		}
	}

	return obj;
}

//콤보박스 데이터
function getSelectData(){
	$.fn.ifvmSetSelectOptionCommCode("limitPop", "YES_NO_FLAG", null, null, true);

}

function getList(){
	url = '<ifvm:action name="getChnlLimitPop"/>'
	$.ifvSyncPostJSON(url, {
		ridClub : rid,
		rid 	  : tabRid
		, enableNA : true
	}
	,function(result) {
		var data = result.rows[0];
		fnSetData(data);
	});
}

function fnSetData(data){
	$("#clubChnlLimitForm #chnlPop").val(data.chnlNo);
	$("#clubChnlLimitForm #ridChnl").val(data.ridChnl);
	$("#clubChnlLimitForm #chnlPopNm").val(data.chnlNm);
	$("#clubChnlLimitForm #limitPop").val(data.limitYn);

}

function setDisplay(){
	$("#parChNmPop").attr("disabled",true);
}



function chnlLimitFn(){
	$("#chnlLimitSearchPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="clubChnlPop"/>',
        contentType: "ajax",
        title: '채널 정보',
        width: '700px',
        close : 'clubChnlPopupClose'
    });

}




function clubChnlPopupClose(obj){
	if(typeof obj !="undefined" && obj.type !="close"){
		$("#clubChnlLimitForm #chnlPop").val(obj.chnlNo);
		$("#clubChnlLimitForm #ridChnl").val(obj.rid);
		$("#clubChnlLimitForm #chnlPopNm").val(obj.chnlNm);
	}
	chnlLimitSearchPop._destroy();
}

</script>



<div class="pop_inner_wrap form-horizontal" >
	<div id="clubChnlLimitForm" class="content">
		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">
				<ifvm:inputNew type="text" id="basicChnl" dto="basicChnl" label="기본채널" labelClass="3" conClass="7" disabled="true" nuc="true" required="true" />
				</div>
			</div>
		</div>
<%-- 		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">


				<ifvm:inputNew type="select" id="parChNmPop" dto="parChNmPop" label="연관채널" labelClass="3" conClass="7" nuc="true" required="true" />
				</div>
			</div>
		</div> --%>
		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">
				<ifvm:inputNew type="search" id="chnlPop|chnlLimitSearchBtn" required="true"
						names="chnlPop" hidId="ridChnl" hidDto="ridChnl" dto="chnlPop"
						disabled="false" btnFunc="chnlLimitFn" label="채널" nuc ="true"
						labelClass="3" conClass="7" />
				</div>
			</div>
		</div>

		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">
				<ifvm:inputNew type="text" id="chnlPopNm" dto="chnlPopNm" label="채널명"  labelClass="3" conClass="7" nuc="true"  disabled="true" required="true"/>
				</div>
			</div>
		</div>


		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">
				<ifvm:inputNew type="select" id="limitPop" dto="limitPop" names ='limitPop' label="제한여부" labelClass="3" conClass="7" nuc="true" />
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="btnSavePop"			text="저장"		 id="btnSavePop"		nuc="true" />
	<ifvm:inputNew type="button" btnType="btnCancelPop"			text="취소"		 id="btnCancelPop"	nuc="true" />
</div>


<div id="chnlLimitSearchPop" class ="popup_container"></div>