(function($) {
	$.fn.ifvTab = function(options){
		this.options = $.extend({
			item: []
			, term : 30
			, tabWidth : 0
			, moveWidth : 0
			, template : {
					wrap: '<div class="tab-mask"></div>',
					list: '<div class="tab-list-mask"><ul class="tab-list"></ul></div>',
					listItem: '<li><a></a></li>',
					scrollControl: '<div class="scroll-control"><button type="button" class="scroll-prev"></button><button type="button" class="scroll-next"></button></div>',
					hideTabWrap: '<div class="hide-tab"><button type="button" class="btn-open-tab"><i class="fa fa-chevron-down" aria-hidden="true"></i></button></div>',
					hideTabList: '<ul class="hide-tab-list"></ul>',
					hideTabListItem: '<li><a></a></li>',
					tabContent : '<div class="tab-contents"></div>'
				}
		}, options);

		this.baseSetting = function() {
			this.options.tabContainer = $(this.options.template.wrap).appendTo($(this));
			this.options.tabListMask = $(this.options.template.list).appendTo(this.options.tabContainer);
			this.options.tabList = this.options.tabListMask.find('.tab-list');

			for(var i = 0; i < this.options.item.length; i++) {
				$(this.options.template.listItem).appendTo(this.options.tabList);
				this.options.tabList.find('> li').eq(i).find('a').attr({'href':this.options.item[i].href}).html(this.options.item[i].label);
				this.options.tabWidth += $('.tab-list > li').eq(i).outerWidth();
			}

			$(this.options.tabList).css({'width':this.options.tabWidth,'margin-left':0});
			this.options.tabContent = $(this.options.template.tabContent).appendTo($(this));
		}

		this.scrollingSetting = function(){
			this.options.hideTabContainer = $(this.options.template.hideTabWrap).appendTo(this.options.tabContainer);
			this.options.hideTabList = $(this.options.template.hideTabList).appendTo(this.options.hideTabContainer);
			for(var i = 0; i < this.options.item.length; i++) {
				$(this.options.template.hideTabListItem).appendTo(this.options.hideTabList);
				this.options.hideTabList.find('> li').eq(i).find('a').attr({'href':this.options.item[i].href}).html(this.options.item[i].label);
			}

			this.options.scrollController = $(this.options.template.scrollControl).appendTo(this.options.tabListMask);

		}

		this.moveHighlightTab = function(idx) {
			var itemOffsetLeft = this.options.tabList.find('> li').eq(idx).offset().left + this.options.tabList.find('> li').eq(idx).outerWidth() - parseInt(this.options.tabList.css('margin-left'),10) - $(this).offset().left;

			if($(this.options.tabListMask).width() < itemOffsetLeft){
				$(this.options.tabList).css({
					'margin-left': this.options.tabListMask.width() - itemOffsetLeft + 'px'
				});
			} else {
				this.options.tabList.css({
					'margin-left': '0px'
				});
			}
		}

		this.eventSetting = function(){
			var _this = this;
			this.options.tabList.find('> li > a').off().on('click', function(e) {
				e.preventDefault();
				var itemIdx = $(this).parent().index();
				_this.options.tabList.find('> li.on').removeClass('on');
				$(this).parent().addClass('on');
				_this.options.hideTabList.find('> li.on').removeClass('on');
				_this.options.hideTabList.find('> li').eq(itemIdx).addClass('on');
				_this.contentSetting($(this).attr('href'));
			});

			this.options.hideTabContainer.find('button').off().on('click', function() {
				_this.options.hideTabList.toggle();
			});

			this.options.hideTabList.find('> li > a').off().on('click', function(e) {
				e.preventDefault();
				var itemIdx = $(this).parent().index();
				_this.options.hideTabList.find('> li.on').removeClass('on');
				$(this).parent().addClass('on');
				_this.options.tabList.find('> li').eq(itemIdx).find('> a').trigger('click');
				_this.moveHighlightTab(itemIdx);
				_this.options.hideTabList.hide();
			});

			this.options.tabListMask.hover(
				function() {
					_this.options.scrollController.show();
				},
				function() {
					_this.options.scrollController.hide();
				}
			);

			this.options.scrollController.find('.scroll-next').off().on('click', function(e) {
				e.stopPropagation();
				var totalW = _this.options.tabListMask.outerWidth() - parseInt(_this.options.tabList.css('margin-left'));
				if(_this.options.tabList.outerWidth() <= totalW) {
					return;
				} else {
					_this.options.tabList.css({
						'margin-left': (parseInt(_this.options.tabList.css('margin-left')) - _this.options.term) + 'px'
					});
				}
			});

			this.options.scrollController.find('.scroll-prev').off().on('click', function(e) {
				e.stopPropagation();
				if(parseInt(_this.options.tabList.css('margin-left')) !== 0) {
					var ml = parseInt(_this.options.tabList.css('margin-left')) + _this.options.term < 0 ? parseInt(_this.options.tabList.css('margin-left')) + _this.options.term : 0;
					_this.options.tabList.css({
						'margin-left': ml + 'px'
					});
				}
			});
		}

		this.contentSetting = function(url) {
			var _this = this;
			this.options.tabContent.empty().html("").load(url);
			/*$.ifvCachedHtml( url ).done( function(script, textStatus){
				_this.options.tabContent.empty().html("").append(script);
				//if( window[fileName + '_init'] != null ) window[fileName + '_init']();
			});*/
		}

		this.moveTabIndex = function(idx) {
			this.options.hideTabList.find('> li.on').removeClass('on');
			this.options.hideTabList.find('> li').eq(idx).addClass('on');

			this.options.tabList.find('> li.on').removeClass('on');
			this.options.tabList.find('> li').eq(idx).addClass('on');
			this.contentSetting(this.options.tabList.find('> li.on > a').attr('href'));

			this.moveHighlightTab(idx);
			this.options.hideTabList.hide();
			//this.options.hideTabList.children('li').eq(idx).children('a').trigger('click');
		}

		this.resizeEvent = function() {
			if($(this).width() < this.options.tabList.width()) {
				this.options.tabContainer.css({'padding-right' : '26px'});
				this.options.hideTabContainer.find('button').show();
				this.eventSetting();
				this.moveHighlightTab(this.options.tabList.find('li.on').index());
			} else {
				this.options.tabContainer.css({'padding-right' : '0px'});
				this.options.tabList.css({'margin-left' : '0px'});
				this.options.hideTabContainer.find('button').hide();
				this.options.hideTabList.hide();
				this.options.tabListMask.off();
				this.options.tabContainer.off();
			}
		}

		this.resizeEventSetting = function() {
			var _this = this;
			this.options.resizeTimeout = '';

			window.onresize = function() {
				var __this = _this;
			    clearTimeout(_this.options.resizeTimeout);
			    _this.options.resizeTimeout = setTimeout(function() {
			    	__this.resizeEvent();
			    }, 100);
			};

		}

		//disabled tab 추가
		this.disabledTab = function(idxArr) {
			var $disabledItem = $(this).find(".tab-list");
			for(var i = 0; i<idxArr.length; i++) {
				var tabIdx = idxArr[i];
				$disabledItem.find("> li").eq(tabIdx).addClass("disabled");
			}
		}

		this.abledTab = function(idxArr) {
			var $disabledItem = $(this).find(".tab-list");
			for(var i = 0; i<idxArr.length; i++) {
				var tabIdx = idxArr[i];
				$disabledItem.find("> li").eq(tabIdx).removeClass("disabled");
			}
		}

		this.disabledTabAll = function() {
			$(this).find(".tab-list li").addClass('disabled');
		}

		this.abledTabAll = function() {
			$(this).find(".tab-list li").removeClass('disabled');
		}

		/* 2018-02-05 sjbaek 현재 액티브 탭 index 반환 */
		this.getActiveIndex = function() {
			return this.find('.tab-list li.on').index();
		}

		/* 2018-02-05 sjbaek 현재 액티브인 탭 reload */
		this.reloadCurrentTab = function() {
			this.moveTabIndex(this.getActiveIndex());
		}

		this.init = function() {
			this.baseSetting();
			this.scrollingSetting();
			this.eventSetting();
			this.resizeEventSetting();
			this.resizeEvent();
			this.moveTabIndex(0);
		}

		this.init();

		return this;
	}
})(jQuery);