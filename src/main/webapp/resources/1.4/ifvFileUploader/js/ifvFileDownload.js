document.write('<link href="'+ frameworkUrl +'ifvFileUploader/css/ifvFileDownload.css" rel="stylesheet" type="text/css" />');


(function($){
	/*
	 * ifvFileUploadItem
	 */
	$.fn.ifvFileDownload = function(options){
		this.opt = $.extend({
			tempId : 'ifvDownloadItemTemplete', itemArr : null, fileArr : null, deleteUrl : null
		}, options );
		
		this.init = function(){
			this.uiSetting();
		};
		
		this.uiSetting = function(){
			for( var i = 0; i < this.opt.fileArr.length; i++ ){
				var html = $("#" + this.opt.tempId ).html();
				var ui = $(html);
				var item = ui.ifvFileDownloadItem({ data : this.opt.fileArr[i], deleteUrl : this.opt.deleteUrl });
				this.append( item );
			}
		};
		
		this.init();
		return this;
	};
	
	$.fn.ifvFileDownloadItem = function(options){
		this.opt = $.extend({
			data : null, name : null, size : null, deleteBtn : null, deleteUrl : null
		}, options );
		
		this.init = function(){
			this.uiSetting();
			this.eventSetting();
		};
		
		this.uiSetting = function(){
			this.opt.name = this.find('[ifvId=name]');
			this.opt.size = this.find('[ifvId=size]');
			this.opt.deleteBtn = this.find('[ifvId=deleteBtn]');
			
			this.opt.name.text( this.opt.data.name );
			this.opt.size.text( $.ifvFormatBytes( this.opt.data.size ) );
		};
		
		this.eventSetting = function(){
			var _this = this;
			this.opt.name.click(function(){
				
				//jquery.fileDownload
				$.fileDownload( _this.data.url, {
			        preparingMessageHtml: "잠시만 기다려주세요.",
			        failMessageHtml: "문제가 발생하였습니다. 다시한번 시도해주세요."
			    });
			});
			
			this.opt.deleteBtn.click(function(){
				
				$.ifvAlert("첨부파일을 삭제하시면 복구가 불가능합니다.<br/>첨부파일을 삭제하시겠습니까?", function(){
					
					$.ifvPostJSON(_this.opt.deleteUrl, {id : _this.opt.data.id }, function(result){
						_this.remove();
					});
					
				});
				
			});
		};
		
		
		this.init();
		return this;
	};

})(jQuery);