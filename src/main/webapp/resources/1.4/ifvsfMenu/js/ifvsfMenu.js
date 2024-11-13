
(function($){
	/**
	 * 
	 * @class ifvsfContextMenu
	 * 
	 */
	$.fn.ifvsfContextMenu = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		
		this.opt = $.extend({
			menuType: ej.MenuType.ContextMenu,
			selectedNode : null
		}, options);
		
		this.init = function(){
			this.setTreeMenu();
			
			this.ejMenu(this.opt);
			window[_this.attr('id')] = this.data("ejMenu");
		};
		
		//tree랑 연결했을 때 노드에서만 menu가 나오도록 설정
		this.setTreeMenu = function(){
			if(this.opt.treeMenu == true){
				
				if(this.opt.beforeOpen){	//custom event가 있을 경우
					var originBeforeOpen = this.opt.beforeOpen;
				}
				
				this.opt.beforeOpen = function(args){
					if (!$(args.target).hasClass("e-text")){
		                args.cancel = true;
					} else {
						this.option().selectedNode = $(args.target);
						
						if(originBeforeOpen){
							originBeforeOpen(args);
						}
		            }
					
				}
			}
		};
		
		
		this.init();

		return this;
	};
})(jQuery);