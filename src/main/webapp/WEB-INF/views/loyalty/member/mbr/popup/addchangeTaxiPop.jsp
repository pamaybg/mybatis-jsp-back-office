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
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="changeTaxiPopWrap">
		<div class="form-horizontal top_well">
			<div class="row col-xs-11">
				<ifvm:inputNew type="hidden" id="rid" dto="rid" />
				<ifvm:inputNew type="search" id="mbrNo|btnMbrNo"   dto="mbrNo" required="true"	btnFunc="mbrSearchFn"	disabled="false"
					label="L01775" labelClass="2" conClass="2" searchBlurEvent="mbrSearchHelpBlur" searchEnterEvent="mbrSearchHelpEnter" /><!-- 회원번호-->
				<script>
					function mbrSearchHelpBlur(){
						if(mbrNoTemp!=$('#changeTaxiPopWrap #mbrNo').val()){
							if($('#changeTaxiPopWrap #mbrNo').val()==""){
								$('#changeTaxiPopWrap #rid').val("");
								$('#changeTaxiPopWrap #custNm').val("");
								mbrNoTemp = "";
							}else{
								mbrSearchPopOpen('<ifvm:url name="mbrSearchHelp"/>?mbrNo='+encodeURI(encodeURIComponent($('#mbrNo').val())));
							}
						}
					}
					function mbrSearchHelpEnter(){

						if($('#changeTaxiPopWrap #mbrNo').val()==""){
							$('#changeTaxiPopWrap #rid').val("");
							$('#changeTaxiPopWrap #custNm').val("");
							mbrNoTemp = "";
						}else{
							mbrSearchPopOpen('<ifvm:url name="mbrSearchHelp"/>?mbrNo='+encodeURI(encodeURIComponent($('#changeTaxiPopWrap #mbrNo').val())));
						}

				}

					function mbrSearchFn() {
						mbrSearchPopOpen('<ifvm:url name="mbrSearchHelp"/>')
					}

					function mbrSearchPopOpen(url) {
						mbrSearchHelpPop = {
							id : "mbrSearchPopDiv"
						};
						mbrSearchHelpPop.popup = function() {
							mbrSearchHelpPop.pop = $('#' + mbrSearchHelpPop.id).ifvsfPopup({
								enableModal : true,
								enableResize : false,
								contentUrl : url,
								contentType : "ajax",
								title : "<spring:message code='L00988'/>",
								width : '700px',
							});
						};
						mbrSearchHelpPop.beforeClose = function(obj) {
							$("#changeTaxiPopWrap").dataSetting(obj);
							mbrNoTemp = obj.mbrNo;
						};
						mbrSearchHelpPop.close = function(obj) {
							if (obj != null || typeof obj != "undefined") {
								this.beforeClose(obj);
							}
							mbrSearchPopDiv._destroy();
						};
						mbrSearchHelpPop.popup();
					}
				</script>
				<ifvm:inputNew type="text" id="custNm"   dto="custNm"	disabled="true"
					label="L01776" labelClass="2" conClass="2" /><!-- 회원명-->
				<ifvm:inputNew type="select" id="memDiv"   dto="memDiv"	disabled="true"
					label="L01777" labelClass="2" conClass="2" /><!-- 회원구분-->
			</div>
			<%-- <div class="row col-xs-11">
				<ifvm:inputNew type="hidden" id="ridApv" dto="ridApv" />
				<ifvm:inputNew type="search" id="apvNm|btnApvNm"   dto="apvNm"	btnFunc="approverSearchFn"
					label="L01778" labelClass="2" conClass="2" /><!-- 승인자-->
				<script>
					function approverSearchFn() {
						approverSearchHelpOpenPop('<ifvm:url name="empSearchHelp"/>' + '?authNm=' + 'E10009')
					}

					function approverSearchHelpOpenPop(url) {
						empSearchHelpPop = {
							id : "empSearchPopDiv"
						};
						empSearchHelpPop.popup = function() {
							empSearchHelpPop.pop = $('#' + empSearchHelpPop.id).ifvsfPopup({
								enableModal : true,
								enableResize : false,
								contentUrl : url,
								contentType : "ajax",
								title : "<spring:message code='L00990'/>",
								width : '700px'
							});
						};
						empSearchHelpPop.beforeClose = function(obj) {
							$("#apvNm").val(obj.name);
							$("#ridApv").val(obj.rid);
						};
						empSearchHelpPop.close = function(obj) {
							if (obj != null || typeof obj != "undefined") {
								console.log(obj);
								if (obj.authNm == 'E10009') {
									this.beforeClose(obj);
								}
							}

							empSearchPopDiv._destroy();
						};
						empSearchHelpPop.popup();
					}
				</script>
			</div> --%>
			<div class="row col-xs-11">
				<ifvm:inputNew type="text" id="rmark"   dto="rmark"
					label="L01779" labelClass="2" conClass="10" /><!-- 비고-->
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
    <ifvm:inputNew type="button" btnType="save"	text="L01780" id="btnSave" btnFunc="gChangeTaxiPop.save" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" btnType="close"	text="L01781" btnFunc="gChangeTaxiList.addChangeTaxi.close" className="btn_lightGray2"/>
</div>
<div id="mbrSearchPopDiv" class="popup_container"></div>
<div id="empSearchPopDiv" class="popup_container"></div>

<script>
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var mbrNoTemp ="" ;
gChangeTaxiPop = {

	init : function(){
		$.ifvGetCommCodeList('select', 'changeTaxiPopWrap #memDiv', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_TYPE', 'loy', false, false, true);

		if(rid!="null"){
			var action = '<ifvm:action name="getChangeTaxiInfo"/>';
			$.ifvSyncPostJSON(action, {
				rid: rid
			}, function(result) {

				$("#changeTaxiPopWrap").dataSetting(result);

				if(result.apvStatusCd != 10){//결재요청중
					$("#changeTaxiPopWrap #btnMbrNo, #changeTaxiPopWrap #btnApvNm, #btnSave").remove();
					$("#changeTaxiPopWrap #rmark, #changeTaxiPopWrap #mbrNo").prop('disabled',true);
				}

			},function(result){

			})
		}
	},
	save : function(){
		if(gChangeTaxiList.checkedData && gChangeTaxiList.checkedData.apvStatusCd != 10){
			alert('<spring:message code="L01819"/>');
			return;
		}
		var vali = $("#changeTaxiPopWrap").ifvValidation();
		if(vali.confirm()){
			var dataObj = $("#changeTaxiPopWrap").getSubmitData();
			console.log(dataObj);
			var action = (gChangeTaxiList.checkedData) ? '<ifvm:action name="updateChangeTaxi"/>' : '<ifvm:action name="addChangeTaxi"/>';
			if(gChangeTaxiList.checkedData){
				dataObj.rid=gChangeTaxiList.checkedData.rid;
			}
			$.ifvSyncPostJSON(action, dataObj, function(result) {

				if(result.success){
					(gChangeTaxiList.checkedData) ? msg = '<spring:message code="L01260"/>' : msg ='<spring:message code="L01257"/>'
					alert(msg);
					gChangeTaxiList.addChangeTaxi.close(result);
				}
			}, function(result){
				alert(result.message);
			})
		}
	}
}

gChangeTaxiPop.init()
/* if(gChangeTaxiList.checkedData){//수정
	$("#changeTaxiPopWrap").dataSetting(gChangeTaxiList.checkedData);
	mbrNoTemp = gChangeTaxiList.checkedData.mbrNo;
	if(gChangeTaxiList.checkedData.apvStatusCd == 20){ //결제 요청 중이면 수정 불가
		$("#changeTaxiPopWrap #btnMbrNo, #changeTaxiPopWrap #btnApvNm").remove();
		$("#changeTaxiPopWrap #rmark, #btnSave").prop('disabled',true);

	}
} */
</script>