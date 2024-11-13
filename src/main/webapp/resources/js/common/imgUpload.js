//이미지 업로드
function backImageSetting(_imgParentId, _containerId){
	var _this = this;
	var tmpArr = new Array();
	for(var i=0; i<1; i++){
		tmpArr.push({ index : i });
	}
	
	backImage = null;
	$("#"+_containerId).html("");
	
	var template = $('#logoImageTemplatePop').tmpl(tmpArr);
	$("#"+_containerId).append(template);
	
	backImage = new ifvMultiUpLoader({
		container : $("#"+_containerId),
		uploadBtn : $('#logoUploadPop'),
		tempUpLoadFormId : 'logoUploadFormPop',
		tempUploadBtnId : 'logoUploadPop',
		imgId : 'logoImgPop',
		btnConId : 'logoPostPopPicBtns',
		imgContainerId : 'logoImgContainerPop',
		rotationBtnId : 'logoImgRotation',
		deleteBtnId : 'logoImgDelPop',
		progressId : 'progress2',
		tempImgUrl : '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif',
		tempUploadIE : '<ifvm:action name="tempUploadIE"/>',
		imgParentId : _imgParentId,
		'maxNumber' : 1,
		'tempImgWidth' : 96, 
		'tempImgHeight' : 96,
		width:96,
		errFunc : function(type){
			var str = null;
			if( type == "maxNumber" ){
				str = '<spring:message code="M02143"/>';
			}else{
				str = '<spring:message code="M02144"/>';
			}
			new ifvConfirm({
				btnTxt1 : '확인',
				btnTxt2 : false,
				isSuccess : false,
				text : str
			});
		}
	});
	
	return backImage;
};
//이미지 삭제
function imageRemove(_this) {
	var idx = _this.id.substr(_this.id.length - 1, 1);
	var obj = backImage.getImgArr()[idx];
	backImage.delImage(_this);
} 