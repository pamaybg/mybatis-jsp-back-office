<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
	   		<button type="button" class="close" onclick="$.modalClose()">&times;</button>
	   		<h4 class="modal-title"></h4>
  		</div>
   		<div class="modal-body form-horizontal" id="appDetailPopForm">
   			<div class="row qt_border">
				<ifvm:inputNew type="text" id="popAppName" names="popAppName" dto="popAppName" required="true" label="D00048" labelClass="3" conClass="8" />
   			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="radio" id="popAppOS" names="popAppOS" dto="popAppOS" required="true" label="D00049" labelClass="3" conClass="8" text="D00056|D00057" values="IOS|AND" checkIndex="1"/>
			</div>
   			<div class="row qt_border">
				<ifvm:inputNew type="text" id="popAppDistVer" names="popAppDistVer" dto="popAppDistVer" required="true" label="D00050" labelClass="3" conClass="8" />
   			</div>
   			<div class="row qt_border">
				<ifvm:inputNew type="text" id="popAppMinVer" names="popAppMinVer" dto="popAppMinVer" required="true" label="D00051" labelClass="3" conClass="8" />
   			</div>
   			<div class="row qt_border">
				<ifvm:inputNew type="text" id="popStoreUrl" names="popStoreUrl" dto="popStoreUrl" required="true" label="D00052" labelClass="3" conClass="8" />
   			</div>
   			<div class="row qt_border">
				<ifvm:inputNew type="text" id="popAppSchema" names="popAppSchema" dto="popAppSchema" required="true" label="D00053" labelClass="3" conClass="8" />
   			</div>
   			<div class="row qt_border">
				<ifvm:inputNew type="text" id="description" names="description" dto="description" required="true" label="D00088" labelClass="3" conClass="8" />
   			</div>
   		</div>
   		<div class="pop_btn_area">
			<ifvm:inputNew type="button" className="btn_gray" id="btnPopSave" btnFunc="btnPopSaveClick" text="L00074" objCode="appDetailPopSave_OBJ"/>
			<ifvm:inputNew type="button" className="btn_lightGray2" id="btnPopCancel" btnFunc="btnPopCancelClick" text="L00124" objCode="appDetailPopCancel_OBJ"/>
		</div>
 	</div>
</div>

<script>
var updateFlag;
var serviceId;
var versionId;

function appDetailPop_init(params) {
	if(params.id){
		$('.modal-title').text('<spring:message code="D00047"/>');
		updateFlag = true;
		$("input:radio[name='popAppOS']").attr('disabled', 'disabled');
	} else {
		$('.modal-title').text('<spring:message code="D00046"/>');
		updateFlag = false;
	}

	changeMobileOS();

	$('input[name="popAppOS"]').on('change', function() {

		changeMobileOS();
	});

	detailAppVer(params.id);
	serviceId = params.serviceId;
	versionId = params.id;

}

function detailAppVer(id){
	if(id != null){
		$.ifvSyncPostJSON('<ifvm:action name="getAppDetail"/>', {
			appId : id
		}, function(result) {

			if(result.appOs.toUpperCase() == "IOS"){
				$("input:radio[name='popAppOS']:radio[value='IOS']").attr("checked",true);
			}
			else{
				$("input:radio[name='popAppOS']:radio[value='AND']").attr("checked",true);
			}
			changeMobileOS();
			$('#popAppName').val(result.appName);
			$('#popAppDistVer').val(result.appDistVer);
			$('#popAppMinVer').val(result.appMinVer);
			$('#popStoreUrl').val(result.storeUrl);
			$('#popAppSchema').val(result.appSchema);
			$('#description').val(result.description);
			})
	}
}

function changeMobileOS() {
	var os = $('input[name="popAppOS"]:checked').val();
	if(os.toUpperCase() == 'IOS'){
		$('.os_info').val('').attr('id', 'popiOSCertPw').attr('name', 'popiOSCertPw').attr('dtoParam', 'popiOSCertPw');
	} else {
		$('.os_info').val('').attr('id', 'popGCMApiKey').attr('name', 'popGCMApiKey').attr('dtoParam', 'popGCMApiKey')	
	}
}

function btnPopCancelClick() {
	$.modalClose();
}

function btnPopSaveClick() {
	validation = $('#appDetailPopForm').ifvValidation();
	if(validation.confirm() === false) return;
	else{
		var storeType = "";
		var storeType = $('input[name="popAppOS"]:checked').val();
		if(storeType=='AND'){
			storeType = 'GOOGLE';
		}
		else if(storeType=='IOS'){
			storeType = 'APPLE';
		}

		$.ifvSyncPostJSON( '<ifvm:action name="insertAppVer"/>',
				{
			 	appName : $('#popAppName').val(),
				appOs : $('input:radio[name="popAppOS"]:checked').val(),
				appDistVer : $('#popAppDistVer').val(),
				appMinVer : $("#popAppMinVer").val(),
				storeType : storeType,
				appSchema : $('#popAppSchema').val(),
				os_Info	:	$('.os_info').val(),
				updateFlag : updateFlag,
				storeUrl : $('#popStoreUrl').val(),
				serviceId : serviceId,
				versionId : versionId,
				description : $('#description').val()
				},
				function(result) {

				 if(result.success == true){
					alert('<spring:message code="M00005"/>');
					location.href = '<ifvm:url name="appListUrl"/>';
				}
				else{
					alert('<spring:message code="M00029"/>');
				}
			});
	}
}

</script>