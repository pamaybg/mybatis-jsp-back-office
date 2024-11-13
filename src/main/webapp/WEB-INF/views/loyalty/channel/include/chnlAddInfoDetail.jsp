<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
        <spring:message code="L00648"/>
        &gt;  <spring:message code="M00169"/>
    </h1>
</div>

<div class="page_btn_area" id="headForm">
    <div class="col-xs-7">
        <span><spring:message code="L00333"/></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" id="chnlAddGoSave" btnFunc="getChnlAddInfoDetail.save" text="I00745" objCode="chnlAddInfoDetailChnlAddGoSave_OBJ"/>
    </div>
</div>

<div class="form-horizontal underline top_well" id="chnlAddInfoDetailForm" >
	<div class="row  qt_border">
		<label class="col-xs-1 control-label"><spring:message code="사업자번호"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="text" id="bizrNo" maxLength="13" dto="bizrNo" />
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="법인번호"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="jurirNo" names="jurirNo" dto="jurirNo" maxLength="10"/>
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="관할지역(부서)"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="area" maxLength="10" dto="area"/>
		</div>

		<label class="col-xs-1 control-label"><spring:message code="판매방식"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="select" id="saleMethCd" names="saleMethCd" dto="saleMethCd"/>
		</div>

	</div>
	
	<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message code="대표자명"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:input type="text" maxLength="15" id="reprNm" dto="reprNm"/>
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="담당자명"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="charger" maxLength="5" dto="charger"/>
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="전화번호"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="telNo" dto="telNo" maxLength="11"/>
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="FAX번호"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="fax" dto="fax" maxLength="11"/>
		</div>
	</div>
	
		<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message code="우편번호"/></label>
		<div class="col-xs-2 control_content">
			<div class="input-group">
			<ifvm:input type="text" disabled="true" maxLength="15" id="zip" dto="zip"/>
				<span class="input-group-addon" id="btnAdresSearchPop">
					<a id="searchAdrBtn"><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="시/도"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="sido" disabled="true" dto="sido"/>
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="구/군"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="gugun" disabled="true" dto="gugun"/>
		</div>
		
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message code="기본주소"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" maxLength="300" disabled="true" id="adres" dto="adres"/>
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="위도값"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="latitude" disabled="true" dto="latitude"/>
		</div>
		
		<label class="col-xs-1 control-label"><spring:message code="경도값"/></label>
		<div class="col-xs-2 control_content">
			<ifvm:inputNew type="text" id="longitude" disabled="true" dto="longitude"/>
		</div>
<%--		<ifvm:inputNew type="button" id="callKakoApi" nuc="true" text="생성" conClass="1" objCode="chnlAddInfocallKakaoApi_OBJ"/>--%>
		
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message code="상세주소"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" id="bunji" dto="bunji"/>
		</div>
		
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message code="영업시간"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="textarea" maxLength="150" id="salesTime" dto="salesTime" rows="5"/>
		</div>
		
	</div>
	
	</div>
	
<script>
var channelAddInfoDetail_isNew;
var ChnlAddInfoRid = null
var getChnlAddInfoDetail={
		init : function(){
	    	if (channelDetail_rid === null){
	    		channelDetail_isNew = true;
				$("#chnlAddGoSave").prop("disabled", true);
				$("#callKakoApi").prop("disabled", true);
				//$("#btnAdresSearchPop").prop("disabled", true);
				$("#chnlAddInfoDetailForm").find('input').prop('disabled', true);
				$("#salesTime").prop('disabled', true);
				$.fn.ifvmSetSelectOptionCommCode("saleMethCd", "LOY_SALE_METH_CD", null, null, false);
	    	}
			else
				channelDetail_isNew = false;
			if (!channelDetail_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getChnlAddInfoDetailNew"/>', {
					rid : channelDetail_rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#chnlAddInfoDetailForm").dataSetting(result);
						$.fn.ifvmSetSelectOptionCommCode("saleMethCd", "LOY_SALE_METH_CD", result.saleMethCd, null, false);
						ChnlAddInfoRid = result.rid;
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#chnlAddInfoDetailForm").ifvValidation();
			//유효성 체크
			if(validation.confirm()){
				ChnlAddInfoRid = ChnlAddInfoRid == 'null' ? null : ChnlAddInfoRid;
				if (ChnlAddInfoRid === null)
					channelAddInfoDetail_isNew = true;
				else
					channelAddInfoDetail_isNew = false;
				
				var url = channelAddInfoDetail_isNew? '<ifvm:action name="saveChnlAddInfoDetail"/>' : '<ifvm:action name="modifyChnlAddInfoDetail"/>';
				var varData = null;
				varData = $("#chnlAddInfoDetailForm").getSubmitData();
				varData.rid     = ChnlAddInfoRid;
				varData.chnlRid = channelDetail_rid;
				$.ifvSyncPostJSON(url, varData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
						getChnlAddInfoDetail.init();
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		}
	}
	

	
function callKakoApi(){	
	var adres = $("#adres").val()+" "+ $("#bunji").val();
	if($.fn.ifvmIsNotEmpty(adres)){
		$.ifvSyncPostJSON('<ifvm:action name="callKakaoApi"/>', { 
			adres : adres
		}, function(result) {                         
			if ($.fn.ifvmIsNotEmpty(result)) {
				if(result.success){
					$('#latitude').val(result.latitude);
					$('#longitude').val(result.longitude);
				}
			}
		}, function(result) {
			alert('KAKO MAP API [잘못된주소]');
		});                                           
	}else{
		alert('주소가 입력되지 않았습니다.');
	}
}

function adresSearchPop() {
	$('#adrDtlSearchPop').ifvsfPopup({
		enableModal : true,
		enableResize : false,
		contentUrl : '<ifvm:url name="adrSearchPop"/>',
		contentType : "ajax",
		title : '주소 검색',
		width : '1000px'
	});
}

$(document).ready(function() {
	getChnlAddInfoDetail.init();
	
	//위도 경도 생성시
    $('#callKakoApi').on('click', function(){
    	callKakoApi();
    });
	
  //주소 검색 시
    $('#btnAdresSearchPop').on('click', function(){
    	if(channelDetail_rid==null) {
    		alert("채널을 등록해주세요.");
    		return;
    	}
    	adresSearchPop();
    });
  
    $("input[vali-type=number]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    });
});


</script>

<div id="adrDtlSearchPop" class="popup_container"></div>