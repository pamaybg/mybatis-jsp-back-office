<%@page trimDirectiveWhitespaces="true" %>
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

var chnl_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var isNew = true;  //신규 여부. 신규: true, 수정 : false 

var validation;
var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID 


/* 팝업 닫기 */
function popupClose(){
	popupContainer._destroy();
}

function dataLoad(chnl_rid) {
	isNew = false;	// 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.
	
	$.ifvSyncPostJSON('<ifvm:action name="getChnlDetail"/>', {
		rid: chnl_rid
	}, function(result) {
		if($.fn.ifvmIsNotEmpty(result)) {
			/*  */
			$("#chnlNo").val(result.chnlNo); //채널번호
			$("#ridPgm").text(result.ridPgm); //프로그램
			$("#ridPgm").val(result.pgmNm); 
			
			$("#chnlNm").val(result.chnlNm); //채널명
			$("#chnlStatCd").val(result.chnlStatCd); //상태
			
			$("#parRid").text(result.parRid); //상위채널
			$("#parRid").val(result.parChnlNm); 
			
			$("#parKeySeq").text(result.parKeySeq); //상위채널
			$("#parKeySeq").val(result.parChnlNm); 
			
			$("#parRidTop").text(result.parRidTop); //최상위채널
			$("#parRidTop").val(result.topChnlNm);
						
			$("#parKeySeqTop").text(result.parKeySeqTop); //최상위채널
			$("#parKeySeqTop").val(result.topChnlNm); 
			
			$("#chnlTypeCd").val(result.chnlTypeCd); //채널유형
			$("#chnlTypeSubCd").val(result.chnlTypeSubCd); //채널세부유형
			
			$.fn.ifvmSetChekBoxValue("mbrJoinPsblYn", result.mbrJoinPsblYn);  //가입채널
			$.fn.ifvmSetChekBoxValue("acrlPsblYn", result.acrlPsblYn); //포인트 적립
							
			$("#ridTerms").text(result.ridTerms); //가입약관
			$("#ridTerms").val(result.termsNm); 			
			$.fn.ifvmSetChekBoxValue("usePsblYn", result.usePsblYn); //포인트 사용
			
		}
			
	   });
	
}


function saveSubmit(){	
	$.ifvSyncPostJSON(isNew ? '<ifvm:action name="addChnl"/>' : '<ifvm:action name="editChnl"/>', getObjForSubmit()	
	, function(result) {
		alert('<spring:message code="L00127"/>');
		if(isNew)chnl_rid = result.message;
		qtjs.href('<ifvm:url name="chnlDetail"/>' + '?rid=' + chnl_rid);
	});
}

/*
 submit을 위한 form 데이터 파라미터 세팅
 */
function getObjForSubmit(){
	var v_obj = {};
	//회원가입여부
	var v_mbrJoinPsblYn = $.fn.ifvmIsNotEmpty($("#mbrJoinPsblYn").attr("checked")) ?  "Y" : "N";
	
	//포인트 적립 가능여부
	var v_acrlPsblYn = $.fn.ifvmIsNotEmpty($("#acrlPsblYn").attr("checked")) ?  "Y" : "N";
	
	//포인트 사용 가능여부
	var v_usePsblYn = $.fn.ifvmIsNotEmpty($("#usePsblYn").attr("checked")) ?  "Y" : "N";

	if(isNew) {
		v_obj = {
				   ridPgm 			      :  $("#ridPgm").text()  
				 , chnlNm 				  :  $("#chnlNm").val()
				 
				 , chnlStatCd 			  :  $("#chnlStatCd").val()
				 
				 , parRid                 :  $("#parRid").text()
				 , parRidTop              :  $("#parRidTop").text()
				 , parKeySeq              :  $("#parKeySeq").text()
				 , parKeySeqTop           :  $("#parKeySeqTop").text()				 
				 , chnlTypeCd 			  :  $("#chnlTypeCd").val()
				 , chnlTypeSubCd          :  $("#chnlTypeSubCd").val()
				 , mbrJoinPsblYn          :  v_mbrJoinPsblYn
				 , acrlPsblYn             :  v_acrlPsblYn
				 , ridTerms               :  $("#ridTerms").text()				 
				 , usePsblYn              :  v_usePsblYn
				 
		};
		
	}else {
		v_obj = {				 
				   rid 					  :  chnl_rid
				 , ridPgm 			      :  $("#ridPgm").text()  
			 	 , chnlNm 				  :  $("#chnlNm").val()
			 	 , chnlStatCd 			  :  $("#chnlStatCd").val()
			 	 , parRid                 :  $("#parRid").text()
				 , parRidTop              :  $("#parRidTop").text()
                 , parKeySeq              :  $("#parKeySeq").text()
				 , parKeySeqTop           :  $("#parKeySeqTop").text()					 
				 , chnlTypeCd 			  :  $("#chnlTypeCd").val()
				 , chnlTypeSubCd          :  $("#chnlTypeSubCd").val()	
				 , mbrJoinPsblYn          :  v_mbrJoinPsblYn
				 , acrlPsblYn             :  v_acrlPsblYn
				 , ridTerms               :  $("#ridTerms").text()				 
				 , usePsblYn              :  v_usePsblYn
				 
		};
	}
	
	return v_obj;
	
}

//저장 버튼클릭 시 동작
function actionSave() {
 	if(validation.confirm())  saveSubmit();
}


$(function(){
	
	//상태
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_CHNL_STAT_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#chnlStatCdTemp").tmpl(result.rows);
		$("#chnlStatCd").append(temp);
	});

	//채널유형코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_CHNL_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#chnlTypeCdTemp").tmpl(result.rows);
		$("#chnlTypeCd").append(temp);
	});

	//채널서브유형 코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_CHNL_SUB_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#chnlTypeSubCdTemp").tmpl(result.rows);
		$("#chnlTypeSubCd").append(temp);
	});

	if($.fn.ifvmIsNotEmpty(chnl_rid) && chnl_rid != "null") {
		dataLoad(chnl_rid);
	}else {  //신규일경우 로그인 세선의 프로그램을 세팅함.
		var userInfo = $.ifvmGetUserInfo();
	
		$("#ridPgm").text(userInfo.loyProgramId); //프로그램
		$("#ridPgm").val(userInfo.loyProgramNm); 
	}
	
});


//적립가능여부 변경
function editChnlAcrlPsblYn(acrlPsblYn){
	
	$.ifvSyncPostJSON('<ifvm:action name="editChnlAcrlPsblYn"/>',			
			{ ridChnl : chnl_rid , acrlPsblYn  :  acrlPsblYn } ,			
			function(result) {
				alert('<spring:message code="L00127"/>');
				qtjs.href('<ifvm:url name="chnlDetail"/>' + '?rid=' + chnl_rid);
	        });
	
}


//적립가능여부 이력 삭제
function removeChnlAcrlHist() {
	
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(tabContent.getCheckedGridData()[0])) {
    	v_rid = tabContent.getCheckedGridData()[0].rid;
    }
    
    
    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        if (confirm('<spring:message code="L00086"/>')) {
            $.ifvProgressControl(true);
            
            // 삭제
            $.ifvPostJSON('<ifvm:action name="removeChnlAcrlHist"/>', {
                rid: v_rid
            },
            function(result) {
                alert('<spring:message code="L00085"/>');
                
                var getPage = getGridPage();
                //목록
                chnlAcrlHistList(getPage);
                
                $.ifvProgressControl(false);
            },
            function(result) {                
                $.errorChecker(result);                
                $.ifvProgressControl(false);
            });
        }
    } 
}


//pos 삭제
function removeChnlPos() {
	
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(tabContent.getCheckedGridData()[0])) {
    	v_rid = tabContent.getCheckedGridData()[0].rid;
    }
    
    
    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        if (confirm('<spring:message code="L00086"/>')) {
            $.ifvProgressControl(true);
            
            // 삭제
            $.ifvPostJSON('<ifvm:action name="removeChnlPos"/>', {
                rid: v_rid
            },
            function(result) {
                alert('<spring:message code="L00085"/>');
                
                var getPage = getGridPage();
                getChnlPosList(getPage);
                
                $.ifvProgressControl(false);
            },
            function(result) {                
                $.errorChecker(result);                
                $.ifvProgressControl(false);
            });
        }
    } 
}

//페이지 구하기
function getGridPage() {
    var rtnVal = 1;
    var page = tabContent.opt.data.page;
    var total = tabContent.opt.data.records;
    if (total % page > 0) {
        rtnVal = page;
    }
    
    return rtnVal;
}

var chnlLvlNo;
var parRidTop;
$(document).ready(function(){
	
	
	$.ifvmLnbSetting('chnlList');
		
	/* 프로그램 조회 팝업  */
	$('#btnFundRidPgmPop').on('click',
	     function(){
			var targetFields = { name: "pgmNm", rid: "ridPgm" };
			//var searchCond = { ridPgm: ridPgm };
		    //$.fn.ifvmPopupOpen('popupContainer', 'ridPgm', '<ifvm:url name="pgmPop"/>',  '<spring:message code="L00077"/>',600);
		    $.fn.ifvmSearchHelpOpen(targetFields, null, 'popupContainer', '<ifvm:url name="pgmPop"/>', '<spring:message code="L00077"/>', 600);
    });
	
	/* 상위채널 조회 팝업  */
	$('#btnFundParRidPop').on('click',
	     function(){
			if($('#parRidTop').val() == ''){
				alert('<spring:message code="L00463"/>');
			}else{
				parRidTop = $('#parRidTop').text();
				chnlLvlNo = null;
				$.fn.ifvmPopupOpen('popupContainer', 'parRid', '<ifvm:url name="chnlPop"/>',  '<spring:message code="L00126"/>',860);	
			}
    });
	
	
	/* 최상위채널 조회 팝업  */
	$('#btnFundParRidTopPop').on('click',
	     function(){
			chnlLvlNo = '1';
			parRidTop = null;
		     $.fn.ifvmPopupOpen('popupContainer', 'parRidTop', '<ifvm:url name="chnlPop"/>',  '<spring:message code="L00126"/>',860);
    });
	
			
	$("#btnSave").click(function(){
		actionSave();
    });
	
	$("#btnList").click(function(){
		qtjs.href('<ifvm:url name="chnlList"/>');
    });
	
	/*적립가능여부이력 탭 -> 가능 버튼*/
	$("#possibleBtn").click(function(){
		if (confirm('<spring:message code="L00424"/>')) {
			editChnlAcrlPsblYn('Y');
		}
    });
	
	/*적립가능여부이력 탭 -> 불가능 버튼*/
    $("#impossibleBtn").click(function(){
    	if (confirm('<spring:message code="L00425"/>')) {
			editChnlAcrlPsblYn('N');
		}
    });
	
	
	
	
	/*적립가능여부이력 탭 -> 이력삭제 버튼*/
    $("#removeChnlAcrlHistBtn").click(function(){
			removeChnlAcrlHist();
    });
	
	
	/*POS 탭 -> 신규 버튼*/
    $("#addChnlPosBtn").click(function(){
    	
		objChnlPosPop = $("#chnlPosDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="chnlPosPop"/>?' + 'chnl_rid=' + chnl_rid ,
	        contentType: "ajax",
	        title: '<spring:message code="L00348"/>',
	        width: '400px',
	        close : 'chnlPosPopClose'
	    });
		
    });
	
	/*POS 탭 -> 삭제 버튼*/
    $("#removeChnlPosBtn").click(function(){
    		removeChnlPos();
    });

	validation = $("#chnlBasicForm").ifvValidation();
	
	$("input[vali-type=number]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    });
});

</script>


<script id="chnlTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<script id="chnlTypeSubCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="chnlStatCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>




<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="L00135"/>
		&gt;  <spring:message code="L00078"/>
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-7">
		<span><spring:message code="L00135"/></span><span><spring:message code="L00079"/></span>
	</div>
	
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="btnSave" objCode="chnlDetailbtnSave_OBJ"><i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00125"/>
		</button> 
		<button class="btn btn-sm" id="btnList" objCode="chnlDetailbtnList_OBJ"><spring:message code="M00002"/></button>
	</div>
</div>


<div class="form-horizontal underline top_well" id="chnlBasicForm" >
	<div class="row  qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00128"/></label>	
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" disabled="true" id="chnlNo"/>
		</div>
		
		<!--프로그램명  -->
		<label class="col-xs-2 control-label"><spring:message code="L00077"/></label>
		<div class="col-xs-3 control_content">
		   <div class="input-group">
			<ifvm:input type="text"  id="ridPgm"/>
			<span class="input-group-addon" id="btnFundRidPgmPop">
					<a><i class="fa fa-search"></i></a>
			</span>
		   </div>
		</div>
	
	</div> 
	<div class="row  qt_border">	
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00129"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" required="true" id="chnlNm" maxLength="100"/>
		</div>
		
		<label class="col-xs-2 control-label"><spring:message code="L00090"/></label><!-- 상태 -->
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" id="chnlStatCd"/>
		</div>
		
	</div>	
	
	<div class="row">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00131"/></label>
		<div class="col-xs-4 control_content">
			<div class="input-group">
				<ifvm:input type="text" required="true" disabled="true" id="parRidTop"/>
				<span class="input-group-addon" id="btnFundParRidTopPop">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="L00130"/></label><!-- 상위채널명 -->
		<div class="col-xs-4 control_content">
			<div class="input-group">
				<ifvm:input type="text" disabled="true" id="parRid"/>
				<span class="input-group-addon" id="btnFundParRidPop">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
	</div>

	<!--채널유형 -->
	<div class="row">
		<label class="col-xs-2 control-label"><spring:message code="L00132"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" id="chnlTypeCd"/>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="L00133"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" id="chnlTypeSubCd"/>
		</div>
	</div>

    <!--가입채널 , 포인트 적립 -->
	<div class="row">
		<label class="col-xs-2 control-label"><spring:message code="L00312"/></label>			
		<div class="col-xs-4 control_content">
		   	<label class="checkbox-inline">
		       	<ifvm:input type="checkbox" id="mbrJoinPsblYn"/>
		   	</label>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="L00451"/></label>			
		<div class="col-xs-4 control_content">
		   	<label class="checkbox-inline">
		       	<ifvm:input type="checkbox" disabled="true" id="acrlPsblYn"/>
		   	</label>
		</div>
	</div>
	
  <!--가입약관명, 포인트 사용 -->
	<div class="row">
	    <label class="col-xs-2 control-label"><spring:message code="L00452"/></label>
	    <div class="col-xs-4 control_content">	
		    <div class="input-group">
			   <ifvm:input type="text"  id="ridTerms"/>
			   <span class="input-group-addon" id="btnFundRidTermsPop">
					<a><i class="fa fa-search"></i></a>
			</span>
		   </div>
		</div>
		
		<label class="col-xs-2 control-label"><spring:message code="L00453"/></label>			
		<div class="col-xs-4 control_content">
		   	<label class="checkbox-inline">
		       	<ifvm:input type="checkbox" id="usePsblYn"/>
		   	</label>
		</div>
	</div>

	
</div>

<div id="tabArea">
	<div class="btn-group btn-group-justified" id="tabType">
		<a href="javascript:;" class="btn btn-default btn-tab active" id="chnlAcrlHistList"><spring:message code="L00454"/></a>
		<a href="javascript:;" class="btn btn-default btn-tab" id="chnlPosList">POS</a>
	</div>
	<!-- 탭 컨텐츠 -->
 <div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span id="tabName"></span>
        </div>
        <div class="col-xs-5 searchbtn_r" id="chnlAcrlHistBtnArea">
            <button class="btn btn-sm" id="possibleBtn" objCode="chnlDetailpossibleBtn_OBJ"><spring:message code="L00309"/></button>
            <button class="btn btn-sm" id="impossibleBtn" objCode="chnlimpossibleBtn_OBJ"><spring:message code="L00335"/></button>  
            <button class="btn btn-sm" id="removeChnlAcrlHistBtn" objCode="removeChnlAcrlHistBtn_OBJ"><i class="fa fa-minus"></i><spring:message code="L00394"/></button>            
        </div>
        
        <div class="col-xs-5 searchbtn_r" id="chnlPosBtnArea">
            <button class="btn btn-sm" id="addChnlPosBtn" objCode="addChnlPosBtn_OBJ"><i class="fa fa-plus"></i><spring:message code="L00078"/></button>  
            <button class="btn btn-sm" id="removeChnlPosBtn" objCode="removeChnlPosBtn_OBJ"><i class="fa fa-minus"></i><spring:message code="L00080"/></button>            
        </div>
    </div>
    <div id="tabContent" class="white_bg grid_bd0"></div>     
    <div id="chnlPosDialog" class="popup_container"></div>
</div> 

</div>

<script>

$('#tabArea .btn.btn-default.btn-tab').on('click', function() {
	changeContent($(this).attr('id'), 'tabContent');
});


function changeContent(type, tab) {
	var cUrl;
		
	switch( type ){
	
	case 'chnlAcrlHistList' :		
		cUrl = '<ifvm:url name="chnlAcrlHistList"/>';
		$('#tabName').text('<spring:message code="L00455"/>');
		
		$('#chnlAcrlHistBtnArea').show();
		$('#chnlPosBtnArea').hide();
		
		if(isNew){ //신규일때 버튼 비활성화
			$('#possibleBtn').prop('disabled', true); //가능 버튼 disable
			$('#impossibleBtn').prop('disabled', true); //불가능 버튼 disable
			$('#removeChnlAcrlHistBtn').prop('disabled', true); //이력삭제 버튼 disable
		}
			
		
		break;
		
	case 'chnlPosList' :
		cUrl = '<ifvm:url name="chnlPosList"/>';
		$('#tabName').text('POS');
		
		$('#chnlPosBtnArea').show();
		$('#chnlAcrlHistBtnArea').hide();
		
		if(isNew){ //신규일때 버튼 비활성화
			$('#addChnlPosBtn').prop('disabled', true); //신규 버튼 disable
			$('#removeChnlPosBtn').prop('disabled', true); //삭제 버튼 disable
		}

		break;
	default :		
		break;
	}
	
	$.ifvCachedHtml( cUrl ).done( function(script, textStatus){
		var cTab = $("#" + tab); 
		
		$('#tabContent').empty();
		$('#tabArea .btn.btn-default.btn-tab').removeClass('active');
		$('#' + type).addClass('active');
		
		cTab.empty();
		cTab.html('');
		cTab.append( script );
		
		var fileName = cUrl.split('/').pop();
		
		
		if( window[fileName + '_init'] != null ) window[fileName + '_init']();
		
	});
}

</script>

<script>
$(function() {
	 changeContent('chnlAcrlHistList', 'tabContent');
});
</script>
<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->
