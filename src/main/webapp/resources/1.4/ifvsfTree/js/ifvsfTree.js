(function($){
	/**
	 * 
	 * @class ifvsfTree
	 * 
	 */
	$.fn.ifvsfTree = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			this.settingItem();
			
			this.ejTreeView(this.opt);
			window[_this.attr('id')] = this.data("ejTreeView");
		};
		
		this.settingItem = function(){
			var _this = this;
			
			//전체 펼치기
			if( this.opt.expanded === true){
				if( this.opt.fields != null ){
					if( this.opt.fields.dataSource != null){
						var dataArr = this.opt.fields.dataSource;
						$.each(dataArr, function( i, val ) {
							val.expanded = true
						});	
					}
				}
			}
			
			//추가, 삭제 버튼
			if( this.opt.setBtn ){
				this.opt.beforeSelect = function(args) {
					_this.makePlusMinusBtn(args);
				}
			}
			
		};
		
		//추가, 삭제 버튼
		this.makePlusMinusBtn = function(args){
			$("[btnId=btnArea]").remove();
			var item = $("#"+ args.nodeDetails.id);
			var btns = '';
			
			btns += '<div style="position:absolute; top:0px;" btnId="btnArea">';
			if( this.opt.setBtn.add ){
				btns += '<button class="plus_minus_btn tree_btn" btnId="plus">'+ifv.commonMessage.add+'</button>';
			}
			if ( this.opt.setBtn.mod ){
				btns += '<button class="plus_minus_btn tree_btn" btnId="modify">'+ifv.commonMessage.mod+'</button>';
			}
			if ( this.opt.setBtn.del ){
				btns += '<button class="plus_minus_btn tree_btn" btnId="minus">'+ifv.commonMessage.del+'</button>';
			}
			btns += '</div>';
			
			var jbtns = $(btns);
			var tL;
			if(item.find("[role=checkbox]").length != 0){
				tL = item.find('a').width() + 20 + 35;
			} else {
				tL = item.find('a').width() + 35;
			}
			
			jbtns.css({'left' : tL });
			item.css('position', 'relative');
			item.append(jbtns);
			
			/*$("[btnId=plus]").click(function(){
				window[_this.attr('id')].addNodes([{text : "new node"}],  window[_this.attr('id')].getSelectedNode().attr('id'));
			});
			
			$("[btnId=minus]").click(function(){
				window[_this.attr('id')].removeNode(window[_this.attr('id')].getSelectedNode().attr('id'));
			});*/
		}
		
		this.init();

		return this;
	};
})(jQuery);