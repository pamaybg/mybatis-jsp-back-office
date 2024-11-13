(function($){
    
    $.fn.ifvSearchBox = function(options){

        this.opt = $.extend({
            select : null,
            input : null,
            btn : null,
            func : null,
            scope : null,
            selectData : null,
            watermark : ''
        }, options);

        this.init = function(){

            
            this.addClass('ifv_search_box');

            var selectInput = $("<input type='text' class='searchbox_select'>");
            this.append( selectInput );

            this.opt.select = selectInput.ifvSelectBox();                    
            this.opt.input = $("<input type='text' class='searchbox_search_input' maxlength='2048'>");
            this.opt.input.watermark( this.opt.watermark );
            this.append( this.opt.input );
            
            this.opt.btn = $("<a href='javascript:;' class='ifv_search_box_search_btn' >");
            this.opt.btn.text( ifv.commonMessage.search );
            this.append( this.opt.btn );
                    
            this.eventSetting();
        };

        this.setData = function(dataArr, returnFunc){

            this.func = returnFunc;
            
            /*var arr = [{value:'전체', key : '', selected : true }];
            arr = arr.concat(dataArr);*/
            
            if( dataArr.length > 0 ) dataArr[0].selected = true;
            
            var _this = this;
            this.opt.select.setData( dataArr, function(obj){
                //_this.returnCall();//섹렉트박스 체인지 할때마다 검색
            });

        };

        this.eventSetting = function(){
            var _this = this;
            
            this.opt.btn.click(function(e){
            	_this.returnCall(e);
            });
            
            this.opt.input.keyup(function(e){
            	if( e != null && e.keyCode == '13' ){
            		_this.returnCall(e);
            	}
            });
        };

        this.returnCall = function(e){
            //serachObj.isServer = true;	//server 서버검색일때(현재 서버검색일경우만 있어서 주석처리)
        	
        	var searchText = this.opt.select.getObj().key;
        	var encColFlag = this.opt.select.getObj().key2;
        	
        	var serachObj = {
        		searchText : searchText,
                searchWord : this.opt.input.val(),
                encColFlag : encColFlag
            };
        	this.func.call( this.scope, serachObj );
        };

        this.init();

        return this;
    };

})(jQuery);