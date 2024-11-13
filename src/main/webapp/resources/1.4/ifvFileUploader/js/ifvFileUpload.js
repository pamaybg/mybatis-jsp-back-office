document.write('<link href="'+ frameworkUrl +'ifvFileUploader/css/ifvFileUpload.css" rel="stylesheet" type="text/css" />');


(function($){
	
	/*
	 * ifvFileUpload
	 */
	$.fn.ifvFileUpload = function(options){
		this.opt = $.extend({
			maxNumber : 5, itemIndex : null, tempId : null, itemTempId : null, itemsCon : null,
			saveDataArr : null, tempUpload : null, tempUploadIE : null, itemArr : null, addBtnId : null, addBtn : null, progressBarId : null
		}, options );
		
		this.init = function(){
			
			this.addClass('ifv_fileupload');
			
			this.opt.itemIndex = 0;
			this.opt.itemArr = [];
			
			this.uiSetting();
			this.uploadEventSetting();
			this.uploadSetting();
			this.eventSetting();
		};
		
		this.uiSetting = function(){
			var html;
			if( this.opt.tempId != null ){
				html = $("#" + this.opt.tempId ).html();
			}else{
				html = $("#ifvUploadTemplete" ).html();
			}
			
			var ui = $(html);
			this.append(ui);
			this.opt.progressBar = ui.find('[ifvId=progressBar]');
			this.opt.addBtn = ui.find('[ifvId=addBtn]');
			this.opt.removeBtn = ui.find('[ifvId=removeBtn]');
			this.opt.itemsCon = ui.find('[ifvId=itemsCon]');
			this.opt.allCheckbox = ui.find('[ifvId=allCheckbox]');
		};
		
		this.eventSetting = function(){
			var _this = this;
			this.opt.removeBtn.click(function(){
				_this.removeItem();
				
				return false;
			});
			
			this.opt.allCheckbox.change(function(){
				var check = this.checked;
				_this.allChecked(check);
			});
		};
		
		this.makeItem = function( fileData ){
			if( this.opt.itemArr.length < this.opt.maxNum ){
				
				var html;
				if( this.opt.tempId != null ){
					html = $("#" + this.opt.itemTempId ).html();
				}else{
					html = $("#ifvUploadItemTemplete" ).html();
				}
				
				var ui = $(html);
				var item = ui.ifvFileUploadItem({
					scope : this,
					fileData : fileData,
					removeFunc : this.removeItems,
					itemIndex : this.opt.itemIndex++
				});
				this.opt.itemsCon.append(ui);
				this.opt.itemArr.push( item );	
			}
		};
		
		this.removeItem = function(){
			for( var i = this.opt.itemArr.length - 1; i > -1; i-- ){
				if( this.opt.itemArr[i].getChecked() == true ){
					this.opt.itemArr[i].removeItem();
				}	
			}
		};
		
		this.removeItems = function( item ){
			for( var i = 0; i < this.opt.itemArr.length; i++ ){
				if( this.opt.itemArr[i] == item ){
					this.opt.itemArr.splice( i , 1 );
					break;
				}
			}
			if( this.opt.itemArr.length == 0 ){
				this.opt.allCheckbox.attr('checked', false );
			}
		};
		
		this.getData = function(){
			var dataArr = [];
			for( var i = 0; i < this.opt.itemArr.length; i++ ){
				dataArr.push( this.opt.itemArr[i].getData() );
			}
			return dataArr;
		};
		
		this.uploadComplete = function( data ){
			var result = data.result;
			for( var i = 0; i < this.opt.itemArr.length; i++ ){
				if( data.files[0].itemIndex == this.opt.itemArr[i].getItemIndex() ){
					this.opt.itemArr[i].uploadComplete(result);
					break;
				}
			}
		};
		
		this.progress = function( data ){
			for( var i = 0; i < this.opt.itemArr.length; i++ ){
				if( data.files[0].itemIndex == this.opt.itemArr[i].getItemIndex() ){
					this.opt.itemArr[i].progress(data);
					break;
				}
			}
		};
		
		this.uploadSetting = function(){
			//jqeury.fileupload
			//this.opt.inputFile.fileupload( this.uploadOptions );
			
			if( !$.support.xhrFileUpload ){
				this.opt.addBtn.attr('data-url', this.opt.tempUploadIE );
			}else{
				this.opt.addBtn.attr('data-url', this.opt.tempUpload );
			}
			this.opt.addBtn.fileupload( this.uploadOptions );
		};
		
		this.uploadEventSetting = function(){
			
			var _this = this;
			this.uploadOptions.progress =  function (e, data) {
				_this.progress( data );
			},
			
			this.uploadOptions.progressall =  function (e, data) {
				if( _this.opt.progressBar != null ){
					var progress = parseInt(data.loaded / data.total * 100, 10);
			    	_this.opt.progressBar.css('width', progress + '%' );	
				}
		    	
				if( progress >= 100 ){
					_this.opt.progressBar.width(0);
				}
		    };
		    
		    this.uploadOptions.change = function(e, data) {
		    	if( _this.opt.progressBar != null ){
		    		_this.opt.progressBar.width(0);
		    	}
		    };
		    
		    this.uploadOptions.done = function (e, data) {
		    	
		    	_this.uploadComplete( data );
		    };
		    
		    this.uploadOptions.customFail = function (that){
		    	
		    };
		    this.uploadOptions.add = function (e, data) {
		    	
		    	_this.makeItem( data );
		    	//data.submit();
		    };
		    this.uploadOptions._validate = function (files) {
		    	
		    };
		    this.uploadOptions. _hasError = function (file) {
		    	
		    };
		};
		
		this.upload = function(){
			for( var i = 0; i<this.opt.itemArr.length; i++ ){
				this.opt.itemArr[i].upload();	
			}
		};
		
		this.allChecked = function( value ){
			for( var i = 0; i<this.opt.itemArr.length; i++ ){
				this.opt.itemArr[i].setChecked(value);
			}
		};
		
		this.uploadOptions = {
			errorMsg : "",
		    acceptFileTypes : /(\.|\/)(gif|jpeg|jpg|png)$/i,
		    maxNumber : 5,
		    maxFileSize : 5 * 1024 * 1024, //
		    dataType: 'json',
		    processCount : 0,
		    datas : {}
		};
		
		this.init();
		return this;
	};
	
	
	/*
	 * ifvFileUploadItem
	 */
	$.fn.ifvFileUploadItem = function(options){
		this.opt = $.extend({
			fileName : null, img : null, deleteBtn : null, deleteUrl : null,
			saveData : null, fileData : null, removeFunc : null, scope : null,
			itemIndex : null
		}, options );
		
		this.init = function(){
			this.uiSetting();
			this.eventSetting();
			this.preview();
		};
		
		this.uiSetting = function(){
			this.opt.fileName = this.find('[ifvId=fileName]');
			this.opt.img = this.find('[ifvId=img]');
			
			this.opt.cancelBtn = this.find('[ifvId=cancelBtn]');
			this.opt.progressBar = this.find('[ifvId=progressBar]');
			this.opt.size = this.find('[ifvId=size]');
			this.opt.checkbox = this.find('[ifvId=checkbox]');
			/*this.opt.deleteBtn = this.find('[ifvId=deleteBtn]');
			this.opt.deleteBtn.hide();*/
		};
		
		this.getChecked = function(){
			return this.opt.checkbox[0].checked;
		};
		
		this.setChecked = function( value ){
			this.opt.checkbox.attr('checked', value );
		};
		
		this.eventSetting = function(){
			var _this = this;
			
			if( this.opt.cancelBtn != null ){
				this.opt.cancelBtn.click(function(){
					_this.removeItem();
					return false;
				});
			}
			
			/*this.opt.deleteBtn.click(function(){
				_this.deleteFile();
				return false;
			});*/
			
			/*this.opt.uploadBtn.click(function(){
				_this.upload();
				return false;
			});*/
		};
		
		this.deleteFile = function(){
			var _this = this;
			$.ikPostJSON( this.opt.deleteUrl, this.opt.saveData, function(){
				_this.removeItem();
			});
		};
		
		this.removeItem = function(){
			this.remove();
			this.opt.removeFunc.call( this.opt.scope, this );
		};
			
		this.getData = function(){
			var obj = {};
			obj.imgName = this.opt.saveData.name;
			obj.imgUrl = this.opt.saveData.url;
			obj.angle = 0;
			return obj;
		};
		
		this.uploadComplete = function( result ){
			
			/*this.opt.deleteBtn.show();
			this.opt.uploadBtn.hide();
			this.opt.cancelBtn.hide();*/
			
			this.opt.saveData = result;
		};
		
		this.preview = function(){
			var file = this.opt.fileData.files[0];
			this.opt.fileName.text(file.name);
			this.opt.size.text( $.ifvFormatBytes(file.size) );
			this.typeCheck();
			this.upload();
			//this.previewImage();
		};
		
		this.typeCheck = function(){
			var file = this.opt.fileData.files[0];
			
			if( file.type == null ) return;
			
			var checker = file.type.split('/')[0]; 
			switch( checker ){
				case "application" :
					
					break;
					
				case "image" :
							
					break;
			}
		};
		
		this.previewImage = function() {
	
			var _this = this;
			
			var ua = window.navigator.userAgent;
			var file = this.opt.fileData.files[0];
			
			if (ua.indexOf("MSIE") > -1) {// ie일때
				this.opt.fileData.select();
	
				try {
					var src = document.selection.createRange().text; 
					this.opt.img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
							+ src + "', sizingMethod='scale')"; // 이미지 로딩,
																// sizingMethod는
																// div에 맞춰서
																// 사이즈를 자동조절
																// 하는 역할
				} catch (e) {
					alert('ie_preview_error_');
				}
	
			} else { // ie가 아닐때
	
				if (window.FileReader) { // FireFox, Chrome, Opera
					var reader = new FileReader();
					reader.onloadend = function(e) {
						_this.opt.img.attr( 'src', e.target.result );
					};
					reader.readAsDataURL(file);
				} else { // safari is not supported FileReader
					 alert('not supported FileReader');
					
				}
			}// if
		};
		
		this.getItemIndex = function(){
			return this.opt.itemIndex;
		};
		
		this.upload = function(){
			this.opt.fileData.files[0].itemIndex = this.opt.itemIndex; 
			this.opt.fileData.submit();
		};
		
		this.progress =  function ( data) {
			if( this.opt.progressBar != null ){
				var progress = parseInt(data.loaded / data.total * 100, 10);
		    	this.opt.progressBar.css('width', progress + '%' );	
			}
	    };
	    
		this.init();
		
		return this;
	};
	
	

})(jQuery);