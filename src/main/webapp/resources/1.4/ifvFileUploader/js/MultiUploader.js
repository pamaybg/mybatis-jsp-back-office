
ifvMultiUpLoader = function(obj){

	this.container = obj.container;
	this.uploadBtn = obj.uploadBtn;
	this.uploadBtnImgUrl = obj.uploadBtnImgUrl;
	this.tempImgUrl = obj.tempImgUrl;
	this.btnAreaImgUrl = obj.btnAreaImgUrl;

	this.uploadform = {};
	this.uploadform.category = obj.category;
	this.uploadform.maxNumber = obj.maxNumber;

	this.uploadform.filelist = [];
	this.uploadform.xhrFileUpload = false;

	this.imgId = obj.imgId;
	this.imgContainerId = obj.imgContainerId;
	this.tempUpLoadFormId = obj.tempUpLoadFormId;
	this.tempUploadBtnId = obj.tempUploadBtnId;
	this.btnConId = obj.btnConId;
	this.rotationBtnId = obj.rotationBtnId;
	this.deleteBtnId = obj.deleteBtnId;
	this.progressId = obj.progressId;

	this.btnWidth = obj.btnWidth;
	this.btnHeight = obj.btnHeight;
	this.tempImgWidth = obj.tempImgWidth;
	this.tempImgHeight = obj.tempImgHeight;
	this.tempUploadIE = obj.tempUploadIE;

	this.imgParentId = obj.imgParentId;
	this.dropZone = obj.dropZone; 
	this.isImageEdit = false;
	this.editIndex = 0;
	this.imageIndex = 0;

	this.errFunc = obj.errFunc;
	this.successFunc = obj.successFunc;
	this.addFunc = obj.addFunc;
	this.tempUploadComplete = obj.tempUploadComplete;
	if(typeof obj.useSortable != 'undefined')
		this.useSortable = obj.useSortable;

	this.init();
	if(this.useSortable)
		this.sortableSetting();
	this.btnStyleSetting();
};

ifvMultiUpLoader.prototype = {
	container : null,
	uploadform : null,
	uploadBtn : null,
	uploadBtnImgUrl : null,
	tempUpLoadFormId : null,
	tempUploadBtnId : null,
	tempImgUrl : null,
	uploadform : null,
	btnConId : null,
	imgId : null,
	imgContainerId : null,
	rotationBtnId : null,
	deleteBtnId : null,
	progressId : null,


	isImageEdit : null,
	editIndex : null,
	imageIndex : null,
	btnWidth : null,
	btnHeight : null,
	tempImgWidth : null,
	tempUploadIE : null,
	errFunc : null,
	tempImgHeight : null,
	useSortable : true,
	imgParentId : null,
};


ifvMultiUpLoader.prototype.init = function(){
	$('body').data('datalist', new Array());

	this.uploadform.xhrFileUpload = $.support.xhrFileUpload;

	this.uploadBtn.attr('multiple', 'true');

	//해당 버튼을 사용하지 않을 경우 src를 기준으로 판단하는데,
	//부모태그에 click function이 걸릴 경우 ie에서 에러가 발생하므로 부모창 숨기기 기능 추가
	$('.btn_delete').each(function() { if($(this).attr('src') == '') $(this).parent().hide();});
};

ifvMultiUpLoader.prototype.btnStyleSetting = function(){

	this.uploadBtn.multiFilestyle({
		id : 'imgUpload',
	   image : this.uploadBtnImgUrl,
	   width : this.btnWidth,
	   height : this.btnHeight,
	   imagewidth : this.btnWidth,
	   imageheight : this.btnHeight

	});

	this.fileuploadSetting( this.uploadBtn, 0 );

	 for( var i = 0; i< this.uploadform.maxNumber; i++){

		 this.fileuploadSetting( $('#' + this.tempUploadBtnId + i), 1 );

		 $( $('#' + this.tempUploadBtnId + i) ).multiFilestyle({
			id : 'upload' + i,
		   image : this.btnAreaImgUrl,
		   imagewidth: this.tempImgWidth,
		   imageheight: this.tempImgHeight,
		   width : this.tempImgWidth,
		   height : this.tempImgHeight,
		   right : 0,
		   icon : true
	 	 });

		 $("#" + this.btnConId + i ).hide();
	 }
};

ifvMultiUpLoader.prototype.clickEditImage = function(obj){
	this.editIndex = obj.id.substr(obj.id.length - 1, 1);

};

ifvMultiUpLoader.prototype.delImage = function(obj){

	var index = obj.id.substr(obj.id.length - 1, 1);

	var i;
	for( i = index; i<this.uploadform.filelist.length; i++ ){

		if(i == this.uploadform.filelist.length - 1){

			/*ie에서 rotation시 span으로 변함 버그 대응 방법 추후 수정해서 적용필요
			 *
			 * $("#" + this.imgId + i).remove()
			var newImg = '<img id="' + this.imgId + i + '" width="61px" height="61px" src="' + this.tempImgUrl + '" class="handle"/>';
			$("#" + this.imgContainerId + i).append(newImg);*/


			$("#" + this.imgId + i).attr('src', this.tempImgUrl );

			$("#" + this.imgContainerId + i).attr('isBind', 'false');
			$('#' + this.tempUpLoadFormId + i ).show();
		}
		else{
			$("#" + this.imgId + i).attr('src', $("#" + this.imgId + (Number(i) + 1)).attr('src'));
			$("#" + this.imgContainerId + i).attr('isBind', 'true');

		}
		//$('#imgContainer' + index + 'Toolbar').hide();
	}

	for( i = 0; i<this.uploadform.maxNumber; i++ ){
		if( i < this.uploadform.filelist.length ){
			$("#" + this.imgContainerId + i).css('display','block');
		}else{
			$("#" + this.imgContainerId + i).css('display','none');
		}
	}

	this.uploadform.filelist.remove(Number(index));
	//$("#" + this.imgId + index).rotate(0);	//ie에서는 적용시 img가 span으로 변함
	$("#" + this.imgContainerId + index).attr('RotateAngle', 0);
	this.deleteEventSetting();
};

ifvMultiUpLoader.prototype.removeAll = function(){
	for( i = 0; i < this.uploadform.filelist.length; i++ ){
		/*ie에서 rotation시 span으로 변함 버그 대응 방법 추후 수정해서 적용필요
		 *
		 * $("#" + this.imgId + i).remove()
		var newImg = '<img id="' + this.imgId + i + '" width="61px" height="61px" src="' + this.tempImgUrl + '" class="handle"/>';
		$("#" + this.imgContainerId + i).append(newImg);*/

		$("#" + this.imgId + i).attr('src', this.tempImgUrl );
		$("#" + this.imgContainerId + i).attr('isBind', 'false');
		$('#' + this.tempUpLoadFormId + i ).show();
		$("#" + this.imgContainerId + i).attr('RotateAngle', 0);
	}
	
	this.uploadform.filelist = [];
	
	this.deleteEventSetting();
};

ifvMultiUpLoader.prototype.rotationImage = function(obj){

	var index = obj.id.substr(obj.id.length - 1, 1);

	var angle = $("#" + this.imgContainerId + index).attr('RotateAngle');

	if(Number(angle) == 3)
		angle = 0;
	else
		angle = Number(angle) + 1;

	$("#" + this.imgContainerId + index).attr('RotateAngle', angle);

	$("#" + this.imgId + index).rotate(angle * 90);
};

ifvMultiUpLoader.prototype.setImgArr = function(imageUrls){
	if(imageUrls.length > 0){
		var bindImages = imageUrls;

		for(var i = 0;i<bindImages.length; i++){
			var url = bindImages[i].imgOrgUrl;
			
			var fileType = url.substr(url.lastIndexOf('.')).toLowerCase();
			if(fileType != ".jpg" && fileType != ".png" &&  fileType != ".gif" &&  fileType != ".bmp" && fileType != ".jpeg"){
				$("#" + this.imgId + i).attr('src', "/resources/images/beacon/store/ico_bg_video.png");
			} else {
				$("#" + this.imgId + i).attr('src', url);
			}
			
			
			$("#" + this.imgContainerId + i).attr('isBind', 'true');
			$('#' + this.tempUpLoadFormId + i ).hide();
			var name = url.substring(url.lastIndexOf('/') + 1, url.length);

			var orgUrl = bindImages[i].imgOrgUrl;
			var orgName = orgUrl.substring(orgUrl.lastIndexOf('/') + 1, orgUrl.length);
			var file = {
					name : name,
					url : url,
					orgName : orgName,
					index : i
			};

			this.uploadform.filelist.push(file);
		}
		for( var i = 0; i<this.uploadform.maxNumber; i++ ){
			if( i < this.uploadform.filelist.length + 1 ){
				$("#" + this.imgContainerId + i).css('display','block');
			}else{
				$("#" + this.imgContainerId + i).css('display','none');
			}
		}

		if( this.successFunc != null ) this.successFunc();
	}

	this.deleteEventSetting();
};

ifvMultiUpLoader.prototype.getImgArr = function(){
	var imgArr = [];
	var obj;
	for( var i = 0; i<this.uploadform.filelist.length; i++ ){
		obj = {};
		/*obj.imgName = this.uploadform.filelist[i].name;
		obj.imgUrl = this.uploadform.filelist[i].url;
		obj.angle = $("#" + this.imgContainerId + i ).attr('RotateAngle');
		*/
		obj.fileName = this.uploadform.filelist[i].name;
		obj.rotateAngle = $("#" + this.imgContainerId + i ).attr('RotateAngle');
		obj.parentId = 'joinStep2';
		obj.category = this.uploadform.category;
		imgArr.push( obj );
	}
	return imgArr;
};

ifvMultiUpLoader.prototype.fileuploadSetting = function( uploadFormBtn, type ){

	if(!this.uploadform.xhrFileUpload)
		uploadFormBtn.attr('data-url', this.tempUploadIE );

	var _this = this;
	uploadFormBtn.fileupload({
		progress : function (e, data) {
			if( _this.progressId == null ) return;

	 		var currImageIndex = _this.uploadform.filelist.length;

	    	$("#" + _this.progressId + currImageIndex).show();

	 		var progress = parseInt(data.loaded / data.total * 100, 10);

	        $("#" + _this.progressId + currImageIndex).css('width',progress + '%');

	        if(progress == 100){
	        	$("#" + _this.progressId + currImageIndex).hide();
	        	$("#" + _this.progressId + currImageIndex).css('width','0%');
	        }
		},
	 	progressall : function (e, data) {
	 		//$("#imgLoading").show();

	 		/*if( _this.progressId == null ) return;

	 		var currImageIndex = _this.uploadform.filelist.length;

	    	$("#" + _this.progressId + currImageIndex).show();

	 		var progress = parseInt(data.loaded / data.total * 100, 10);

	        $("#" + _this.progressId + currImageIndex).css('width',progress + '%');

	        if(progress == 100){
	        	$("#" + _this.progressId + currImageIndex).hide();
	        	$("#" + _this.progressId + currImageIndex).css('width','0%');
	        }*/
	    },
	    errorMsg : "",
	    acceptFileTypes : /(\.|\/)(jpeg|jpg|png)$/i,
	    maxNumber : _this.uploadform.maxNumber,
	    maxFileSize : 5 * 1024 * 1024, //
	    dataType : 'json',
	    processCount : 0,
	    datas : {},
	    dropZone : _this.dropZone,
	    change : function(e, data) {

	    },
		done : function (e, data) {
	    	//progressShow = false;
	    	var currImageIndex;
			$.each(data.result, function (index, file) {

	            if( type == 0 ){
	            	currImageIndex = _this.uploadform.filelist.length;
	            }else{
	            	if( _this.editIndex < _this.uploadform.filelist.length ){
	            		currImageIndex = _this.editIndex;
	            	}else{
	            		currImageIndex = _this.uploadform.filelist.length;
	            	}
	            }

	            if( currImageIndex < 10 ){
	            	file.index = currImageIndex;

					//_this.uploadform.filelist.push(file);
					_this.uploadform.filelist[parseInt(currImageIndex)] = file;
					
					var fileType = file.fileName.substr(file.fileName.lastIndexOf('.')).toLowerCase();
					if(fileType != ".jpg" && fileType != ".png" &&  fileType != ".gif" &&  fileType != ".bmp" && fileType != ".jpeg"){
						$('#' + _this.imgId + currImageIndex).attr('src', "/resources/images/beacon/store/ico_bg_video.png");
					} else {
						$('#' + _this.imgId + currImageIndex).attr('src', file.url);
					}
					$('#' + _this.imgContainerId + currImageIndex).attr('isBind', 'true');
					$('#' + _this.tempUpLoadFormId + currImageIndex ).hide();

//		            isImageEdit = false;

					_this.imageIndex++;
	            }


	        });

			for( var i = 0; i<_this.uploadform.maxNumber; i++ ){
				if( i < _this.uploadform.filelist.length + 1 ){
					$("#" + _this.imgContainerId + i).css('display','block');
				}else{
					$("#" + _this.imgContainerId + i).css('display','none');
				}
			}

			_this.deleteEventSetting();

			if( _this.successFunc != null ) _this.successFunc();
			if( _this.tempUploadComplete != null ) _this.tempUploadComplete();

	    },
	    customFail: function (that){
	    	alert(that.options.errorMsg);

	    	that.options.processCount = 0;
	    	that.options.errorMsg = "";
	    },
	    add: function (e, data) {
	    	if( _this.addFunc != null ) _this.addFunc(data);
           // var that = $(this).data('fileupload');
	       var customValid = true
	       var that = $(this).data('fileupload') || $(this).data('blueimpFPFileupload');
           var options = {};
           if( that != null ) options = that.options;
           var files = data.files;

           _this.imageIndex = 0;

           if(_this.uploadform.filelist.length == _this.uploadform.maxNumber){
        	   _this.delImage();
           }
           
           // var valid = _this._validate(files);
           if(_this.customValidFunc) {
        	   var cv = _this.customValidFunc(files, data)
	           if(!cv.valid) {
	        	   $.ifvErrorPop(cv.message)
	        	   customValid = false
	           }
           }
           if(customValid) {
	           if(that != null && !that.options.errorMsg){
	            	var valid = that.options._validate(files);
	            	if(valid){
	        			data.submit();
	            	}
	            	else{
	            		$.each(files, function (index, file) {
	            			 that.options.processCount = 0;
	            			if(file.error == 'acceptFileTypes'){
	                        	//alert(file.name.split('.')[1] + '<spring:message code="beacon.common.acceptFileTypes"/>');
	                        	if( _this.errFunc != null ) _this.errFunc();
	                        }
	                        else if(file.error == 'maxFileSize'){
	                        	//alert((that.options.maxFileSize / 1024 / 1024) + ' <spring:message code="fileupload.error.maxFileSize"/>');
	                        	if( _this.errFunc != null ) _this.errFunc(file.error);
	                        }
	                    });
	            	}
	           }else if( files != null ){
	              data.submit();
	           }
           }
	    },
	    _validate: function (files) {
	        var that = this,
	        	valid = !!files.length;

	        $.each(files, function (index, file) {
	            file.error = that._hasError(file);
	            if (file.error) {
	                valid = false;
	            }
	        });

	        return valid;
	    },
	    _hasError: function (file) {
	    	if (this.maxNumber < 0) {
	            return 'maxNumber';
	        }
	    	if (!(this.acceptFileTypes.test(file.type) ||
	                this.acceptFileTypes.test(file.name))) {
	            return 'acceptFileTypes';
	        }
	        if (this.maxFileSize &&
	                file.size > this.maxFileSize) {
	        	return 'maxFileSize';
	        }
	        return null;
	    }
	});
};

ifvMultiUpLoader.prototype.deleteEventSetting = function( num ){
	var _this = this;
	for( var i = 0; i<_this.uploadform.maxNumber; i++ ){
		if( i < _this.uploadform.filelist.length ){
			_this.imgEventSetting(i);
		}else{
			_this.imgRemoveEvent(i);
		}
	}
};

ifvMultiUpLoader.prototype.imgEventSetting = function( i ){
	var _this = this;
	$("#" + _this.imgContainerId + i).mouseover(function(){
		$("#" + _this.btnConId + i ).show();
	});

	$("#" + _this.imgContainerId + i).mouseout(function(){
		$("#" + _this.btnConId + i ).hide();
	});
};

ifvMultiUpLoader.prototype.imgRemoveEvent = function(i){
	$("#" + this.imgContainerId + i).unbind();
	$("#" + this.btnConId + i ).hide();
};

ifvMultiUpLoader.prototype.removeEvent = function(){
	for( var i = 0; i<this.uploadform.maxNumber; i++ ){
		$("#" + this.imgContainerId + i).unbind();
		$("#" + this.btnConId + i ).hide();
		$("#" + this.tempUploadBtnId + i ).hide();
	}
};

ifvMultiUpLoader.prototype.sortableSetting = function(){

	var _this = this;

	this.container.sortable({

		handle : '.handle',
		cursor:"move",
		axis: "x",
		opacity: 0.5,
		//cancel : "[isBind='false']",
		items: "[isBind='true']",
		start: function(event, ui) {

	        var start_pos = ui.item.index();
	        var start_item_id = ui.item.attr('id');
	        var start_item_seq = ui.item.attr('seq');

	        ui.item.data('start_pos', start_pos);
	        ui.item.data('start_item_id', start_item_id);
	    },
		update: function (event, ui) {


			var start_pos = ui.item.data('start_pos');
			var start_item_id = ui.item.data('start_item_id');

	        var end_pos = ui.item.index();

	        var ascending = false;
	        if(Number(start_pos) > Number(end_pos))
	        	ascending = true;

	        _this.changeIndex(start_pos, '99');

	        if(ascending){
	        	for(var i = start_pos - 1;i>=end_pos;i--){
	        		var s = '';
	        		//+1
	        		_this.changeIndex(i, i + 1);
	        	}
	        }
	        else{
	        	for(var i = start_pos + 1;i<=end_pos;i++){
	        		var s = '';
	        		//-1
	        		_this.changeIndex(i, i - 1);
	        	}
	        }

	        _this.changeIndex('99', end_pos);

	        //Data 처리
	        var tmpFile = _this.uploadform.filelist[start_pos];

	        _this.uploadform.filelist.remove(start_pos);

	        _this.uploadform.filelist.splice(end_pos, 0, tmpFile);
	    }
	});

};


ifvMultiUpLoader.prototype.changeIndex = function(oldIndex, newIndex){
	$('#' + this.imgContainerId + oldIndex).attr('seq', newIndex);

    $('#' + this.imgContainerId + oldIndex).attr('id', this.imgContainerId + newIndex);
    $('#' + this.imgId + oldIndex).attr('id', this.imgId + newIndex);
    $('#' + this.btnConId + oldIndex ).attr('id', this.btnConId + newIndex );
    $('#' + this.tempUpLoadFormId + oldIndex).attr('id', this.tempUpLoadFormId + newIndex);
    $('#' + this.tempUploadBtnId + oldIndex).attr('id', this.tempUploadBtnId + newIndex);
    $('#' + this.rotationBtnId + oldIndex).attr('id', this.rotationBtnId + newIndex);
    $('#' + this.deleteBtnId + oldIndex).attr('id', this.deleteBtnId + newIndex);
    //$('#imgRotate' + oldIndex).attr('id', 'imgRotate' + newIndex);
    //$('#imgDel' + oldIndex).attr('id', 'imgDel' + newIndex);

    var i = 0;
    for( i = 0; i<this.uploadform.maxNumber; i++ ){
    	this.imgRemoveEvent(i);
    	this.imgEventSetting(i);
    }


};