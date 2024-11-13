ifvbSimpleUploader = function(obj){
	
	this.container = obj.container;
	this.uploadBtn = obj.uploadBtn;
	this.uploadBtnImgUrl = obj.uploadBtnImgUrl || '';
	
	this.uploadform = {};
	this.uploadform.category = obj.category;
	this.uploadform.maxNumber = obj.maxNumber;
	
	this.uploadform.filelist = [];
	this.uploadform.xhrFileUpload = false;
	
	this.imgId = obj.imgId;
	this.imgContainerId = obj.imgContainerId;
	this.tempImgUrl = obj.tempImgUrl;
	
	this.btnWidth = obj.btnWidth;
	this.btnHeight = obj.btnHeight;
	
	this.errFunc = obj.errFunc;
	this.successFunc = obj.successFunc;
	this.addFunc = obj.addFunc;
	this.tempUploadIE = obj.tempUploadIE;
	
	this.domain = obj.domain;

	this.init();
	this.btnStyleSetting();
	
};

ifvbSimpleUploader.prototype = {
	container : null,
	uploadform : null,
	uploadBtn : null,
	uploadBtnImgUrl : null,
	tempUpLoadFormId : null,
	tempUploadBtnId : null,
	tempImgUrl : null,
	uploadform : null,
	imgId : null,
	imgContainerId : null,
	isImageEdit : null,
	editIndex : null,
	imageIndex : null,
	btnWidth : null,
	btnHeight : null,
	tempImgWidth : null,
	tempImgHeight : null,
	errFunc : null,
	successFunc : null,
	tempUploadIE : null,
	fileData : null
}; 


ifvbSimpleUploader.prototype.init = function(){
	$('body').data('datalist', new Array());
	this.uploadform.xhrFileUpload = $.support.xhrFileUpload;
};

ifvbSimpleUploader.prototype.btnStyleSetting = function(){
	
	this.uploadBtn.multiFilestyle({
		id : 'imgUpload', 
	   image : this.uploadBtnImgUrl,
	   width : this.btnWidth,
	   height : this.btnHeight,
	   imagewidth : this.btnWidth,
	   imageheight : this.btnHeight,
	   
	});
	
	this.fileuploadSetting( this.uploadBtn );
	
};


ifvbSimpleUploader.prototype.delImage = function(){
	
	$("#" + this.imgId ).attr('src', this.tempImgUrl );
			
	this.fileData = null;
	
	this.uploadform.filelist.remove(Number(0));
};

ifvbSimpleUploader.prototype.setImage = function( urlObj ){
	
	var url = urlObj.imgOrgUrl;
	$("#" + this.imgId).attr('src', url);
	$("#" + this.imgContainerId ).attr('isBind', 'true');

	var name = url.substring(url.lastIndexOf('/') + 1, url.length);
	
	var orgUrl = urlObj.imgOrgUrl;
	var orgName = orgUrl.substring(orgUrl.lastIndexOf('/') + 1, orgUrl.length);
	var file = {
			name : name,
			url : url,
			orgName : orgName,
	};
	this.fileData = file;
	this.uploadform.filelist.push(file);
};

ifvbSimpleUploader.prototype.removeEvent = function(){
	this.uploadBtn.hide();
};


ifvbSimpleUploader.prototype.getFileData = function(){
	
	if( this.fileData == null ) return null;
	
	var obj = {};
	obj.fileName = this.fileData.name;
	obj.rotateAngle = $("#" + this.imgContainerId ).attr('RotateAngle');
	
	return obj;
};

ifvbSimpleUploader.prototype.rotationImage = function(){
	
	
	var angle = $("#" + this.imgContainerId ).attr('RotateAngle');
	
	if(Number(angle) == 3)
		angle = 0;
	else
		angle = Number(angle) + 1;
	
	$("#" + this.imgContainerId).attr('RotateAngle', angle);
	
	$("#" + this.imgId).rotate(angle * 90);
};

//getYmConnectionUrl
ifvbSimpleUploader.prototype._done = function(data){
	if( this.successFunc != null ) this.successFunc(data);
	//이미지경로 세팅을 위해 변경
	$('#' + this.imgId).attr('src', this.domain == null ? '' : this.domain + data.result[0].url );
	$('#' + this.imgContainerId ).attr('isBind', 'true');
	this.fileData = data.result[0];
};

ifvbSimpleUploader.prototype.fileuploadSetting = function( uploadFormBtn ){
	
	if(!this.uploadform.xhrFileUpload)
		uploadFormBtn.attr('data-url', this.tempUploadIE );
	
	var _this = this;
	uploadFormBtn.fileupload({
	 	progressall: function (e, data) {
	 		/* $("#imgLoading").show();
	 		
	 		var currImageIndex = uploadform.filelist.length;
			
	 		if(!progressShow)
	    		$("#progressBox" + currImageIndex).show();
			
	 		var progress = parseInt(data.loaded / data.total * 100, 10);
	 		
	        $('#uploadprogressbar' + currImageIndex).css('width',progress + '%');
	        if(progress == 100){
	        	$("#progressBox" + currImageIndex).hide();
	        	$('#uploadprogressbar' + currImageIndex).css('width','0%');
	        } */
	    },
	    errorMsg : "",
	    acceptFileTypes: /(\.|\/)(gif|jpeg|jpg|png)$/i,
	    maxNumber : _this.uploadform.maxNumber,
	    maxFileSize : 5 * 1024 * 1024, //
	    dataType: 'json',
	    processCount : 0,
	    datas : {},
	    change: function(e, data) {
	    	 
	    },
		done: function (e, data) {
			_this._done(data);
	    },
	    customFail: function (that){
	    	alert(that.options.errorMsg);
	
	    	that.options.processCount = 0;
	    	that.options.errorMsg = "";
	    },
	    add: function (e, data) {
    	   if( _this.addFunc != null ) _this.addFunc(data);
           var that = $(this).data('fileupload');
           var options = {};
           if( that != null ) options = that.options;
           var files = data.files;
           
           _this.imageIndex = 0;
        
           if(_this.uploadform.filelist.length == _this.uploadform.maxNumber){
        	   _this.delImage();
           }
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







