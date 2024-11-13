(function($){
	//전체 미사용
	$.fn.calendarInputAll = function(options){
		var _this = $.extend({
			todayList : null,
			notTodayList : null,
			notTodayOver : null,
			returnFunc : null,
			notTodayInner : null,
			maxDate : null,
			defaultDate : null, 
			minYear : 2000,
			maxYear : new Date().getFullYear() + 5
		}, options);
		
		this.init = function(){
			for( var i = 0; i<this.length; i++ ){
				$(this[i]).calendarInput(_this);
			}
		};
		
		this.init();
		
		return this;
	};
	
	$.fn.calendarInput = function(options){
		var _this = $.extend({
			calander : null,
			yearSelecter : null,
			monthSelecter :null,
			dayContainer : null,
			closeBtn : null,
			dateObjArr : null,
			inputText : null,
			date : null,
			btn : null,
			todayBtn : null,
			todayList : null,
			info : null,
			date : null,
			positionList : null,
			width : null,
			notTodayOver : null,
			notTodayInner : null,
			saveKey : null,
			returnFunc : null,
			active : true,
			notToday : false,
			defaultDate : null,
			span : null,
			maxDate : null,
			minYear : 2000,
			maxYear : new Date().getFullYear() + 5
		}, options);
		
		var that = this;
		
		this.init = function(){
			if( this.find('img').length > 0 ) return;
			_this.active = true;
			
			_this.info = new $.calendarInfo(_this);
			
			_this.inputText = this;
			_this.inputText.width(82);

			_this.span = document.createElement('span');
			_this.span.className = 'ik_calendar_con';
			this.before( _this.span );
			$(this).appendTo(_this.span);

			
			if( _this.width != null ) _this.inputText.width( _this.width );
			
			this.makeBtn();
			this.makeCalendar();
			this.changeDate();
			this.todayCheck();
			this.positonCheck();
			
			this.inputEventSetting();
		};
		
		this.inputEventSetting = function(){
			var that = this;
			$(_this.inputText).blur(function(){
				var txt = _this.inputText.val();
				
				if( txt.trim() == '' ){
					_this.inputText.attr('key', '' );
					return;
				}
				
				var format = /^(19[7-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
				if(!format.test(txt)){
					that.rollBackDay();
					return false;
				}
				
				var txtArr = txt.split('-');
				var year = txtArr[0];
				var mon = txtArr[1];
				var day = _this.info.getDaysInMonth(year, mon);
				if( txtArr[2] > day ){
					that.rollBackDay();
					return false;
				}
				
				var reg = /[-]/g;
				txt = txt.replace(reg,'');
				_this.inputText.attr('key', txt );
			});
		};
		
		this.rollBackDay = function(){
			alert('정확한 날짜 형식을 써주세요.');
			_this.inputText.val( _this.info.getToday("-") );
			_this.inputText.attr('key', _this.info.getTodayKey() );
		};
		
		this.todayCheck = function(){
			if( _this.notToday == true ) return;
			
			if( _this.notTodayList != null ){
				var check = -1;
				for( var i = 0; i < _this.notTodayList.length; i++ ){
					if( _this.notTodayList[i] == _this.inputText.attr('id') ){
						check = i;
					}
				}
				if( check == -1 ){
					_this.inputText.val( _this.info.getToday("-") );
					_this.inputText.attr('key', _this.info.getTodayKey() );
				}
			}else{
				if( _this.date != null ){
					_this.inputText.val( this.dateConverting( _this.date, '-' ) );
					_this.inputText.attr('key', _this.date );
				}else{
					_this.inputText.val( _this.info.getToday("-") );
					_this.inputText.attr('key', _this.info.getTodayKey() );
				}
			}
			
			if( _this.defaultDate != null ){
				_this.inputText.attr('key', _this.defaultDate );
				_this.inputText.val($.ikDateForm(_this.defaultDate));
			}
		};
		
		this.positonCheck = function(){
			if( _this.positionList != null ){
				for( key in _this.positionList ){
					if( _this.inputText.attr('id') == _this.positionList[key].id ){
						if( _this.positionList[key].position.left != null ) _this.calander.style.left = _this.positionList[key].position.left + 'px';
						if( _this.positionList[key].position.top != null ) _this.calander.style.top =_this.positionList[key].position.top + 'px';
					}
				}
			}
		};
		
		this.dateConverting = function(date, div ){
			var str = String(date);
			var yyyy = str.substring(0, 4);
			var mm = str.substring(4, 6);
			var dd = str.substring(6, 8);
			
			return yyyy + div + mm + div + dd;
		};
		
		this.makeBtn = function(){
			_this.btn = document.createElement('a');
			//_this.btn.src = './resources/images/calendar.png';
			_this.btn.setAttribute('alt','달력');
			_this.btn.className = 'c_btn';
			
			$(_this.btn).click(function(){
				if( _this.active == true ){
					that.calandarShow();
				}
			});
			
			_this.span.appendChild(_this.btn);
		};
		
		this.deActive = function(){
			_this.active = false;
		};
		
		this.active = function(){
			_this.active = true;
		};
		
		this.makeCalendar = function(){
			
			_this.calander = document.createElement('div');
			_this.calander.className = 'ik_calendar';
			
			var htmlStr = "";
			htmlStr += '<div class="select_area">';
			htmlStr += '	<ul class="date_select">';
			htmlStr += '       <li class="year"><input type="text" /></li>';
			htmlStr += '       <li class="month"><input type="text" /></li>';
			htmlStr += '       <li class="today"><a href="javascript:;" class="btn_gray_22">오늘</a></li>';
			htmlStr += '    </ul>';
			htmlStr += '    <a href="javascript:;" class="close_btn"></a>';
			htmlStr += '</div>';
			
			htmlStr += '<ul class="weekliy">';
			htmlStr += '    <li class="red">일</li>';
			htmlStr += '    <li>월</li>';
			htmlStr += '    <li>화</li>';
			htmlStr += '    <li>수</li>';
			htmlStr += '    <li>목</li>';
		    htmlStr += '    <li>금</li>';
		    htmlStr += '    <li class="blue">토</li>';
		    htmlStr += '</ul>';
		    
		    htmlStr += '<ul class="day_container"></ul>';
		    _this.calander.innerHTML = htmlStr;
		    
		    var span = $(_this.span);
		    span.append(_this.calander);
		    
		    _this.yearSelecter = span.find('.year input').ifvSelectBox();
		    _this.monthSelecter = span.find('.month input').ifvSelectBox();
		    _this.dayContainer = span.find('.day_container');
		    
		    _this.closeBtn = span.find('.close_btn');
		    _this.todayBtn = span.find('.btn_gray_22');
		   
		    _this.yearSelecter.setValue(_this.info.getCurrentYear());
		    _this.monthSelecter.setValue(_this.info.getCurrentMonth());
		    
		    this.selectDataInit();
		    
		    this.eventSetting();
		};
		
		this.eventSetting = function(){
			
			_this.closeBtn.click(function(){
		    	$(_this.calander).hide("fast");
		    });
			
			_this.todayBtn.click(function(){
		    	_this.info.init();
		    	_this.yearSelecter.setValue(_this.info.getCurrentYear());
			    _this.monthSelecter.setValue(_this.info.getCurrentMonth());
			    _this.notToday = false;
			    	
			    that.todayCheck();
			    that.changeDate();
		    });
		};
		
		
		this.changeDate = function(){
			_this.yearSelecter.setValue(_this.info.getCurrentYear());
			_this.monthSelecter.setValue(_this.info.getCurrentMonth());
			    
			_this.dateObjArr = _this.info.getCalendarInfo();
			
			_this.dayContainer.html('');
			
			var currentDate = _this.info.getCurrentDate();
			
			for( var i = 0; i<_this.dateObjArr.length; i++ ){
				if( _this.dateObjArr[i].state == 'current' ){
					var li = document.createElement('li');
					li.innerHTML = _this.dateObjArr[i].day;
					_this.dayContainer.append(li);
					
					if(  _this.dateObjArr[i].isToday ) $(li).addClass('today');
					
					this.dateEventSetting( li, _this.dateObjArr[i] );
					
				}else{
					var li = document.createElement('li');
					_this.dayContainer.append(li);
				}
			};
		};
		
		this.dateEventSetting = function( item, obj ){
			
			$(item).click(function(){
				_this.saveKey = _this.inputText.attr('key');

				
				var str = obj.year + "-" + _this.info.twoCheck(obj.month) + "-" + _this.info.twoCheck(obj.day);
				var keyStr = obj.year + _this.info.twoCheck(obj.month) + _this.info.twoCheck(obj.day);

				var vali = _this.inputText.attr('vali'); 

				var min = _this.inputText.attr('min-date'); 
				var max = _this.inputText.attr('max-date'); 
				
				if( min != null && keyStr < min ){
					alert($.ikDateForm(min) + '이후으로 선택해주세요.');
					return;
				}

				if( max != null && keyStr > max ){
					alert($.ikDateForm(max) + '이전으로 선택해주세요.');
					return;
				}

				if( vali == 'inner' && keyStr > _this.info.getTodayKey() ){
					alert('오늘날짜 이후로는 선택이 안됩니다.');
					return;
				}
				
				if( vali == 'over' && keyStr < _this.info.getTodayKey() ){
					alert('오늘날짜 이전으로는 선택이 안됩니다.');
					return;
				}
				that.allClear();
				_this.inputText.val(str);
				_this.inputText.attr('key', obj.year + _this.info.twoCheck(obj.month) + _this.info.twoCheck(obj.day) );
				$(_this.calander).hide("fast");
				$(item).addClass('select');
				if( _this.returnFunc ) _this.returnFunc();
			});
		};
		
		//기존날짜로 되돌리기
		this.revert = function(){
			_this.inputText.val(str, $.ikDateForm( _this.saveKey) );
			_this.inputText.attr('key', _this.saveKey );
		};
		
		this.allClear = function(){
			var arr = _this.dayContainer.children();
			for( var i = 0; i < arr.length; i++ ){
				$(arr[i]).removeClass('select');
			}
		};
		
		this.calandarShow = function(){
			if( _this.inputText.val() != '' ){
				var year = _this.inputText.val().split('-')[0];
				var month = _this.inputText.val().split('-')[1];
				
				_this.info.setCurrentYear(year);
				_this.info.setCurrentMonth(month);
			}
			
			$(_this.calander).show();
			
			this.changeDate();
		};
		
		this.selectDataInit = function(){
			var yearData = _this.info.getYearData(_this.maxDate);
			_this.yearSelecter.setData(yearData, function(obj){
				_this.info.setCurrentYear(obj.value);
				that.changeDate();
			});
			
			var monthData = _this.info.getMonthData();
			_this.monthSelecter.setData(monthData, function(obj){
				_this.info.setCurrentMonth(obj.value);
				that.changeDate();
			});
		};
		
		this.init();
		
		return this;
	};
	
	/*
	 * calendarInfo
	 */
	$.calendarInfo = function(options){
		
		var _this = $.extend({
			date : null,
			currentYear : null,
			currentMonth : null,
			currentDate : null,
			minYear : null,
			maxYear : null
			
		}, options);
		
		
		var that = this;
		
		this.init = function(){
			_this.date = new Date();
			this.dateSetting();
		};
		
		this.dateSetting = function(){
			_this.currentYear = _this.date.getFullYear();
			_this.currentMonth = _this.date.getMonth() + 1;
			_this.currentDate = _this.date.getDate();
		};
		
		this.setCurrentYear = function(year){
			_this.currentYear = year;
		};
		
		this.setCurrentMonth = function(month){
			_this.currentMonth = month;
		};
		
		this.setCurrentDate = function(date){
			_this.currentDate = date;
		};
		
		this.getCurrentYear = function(){
			return _this.currentYear;
		};
		
		this.getCurrentMonth = function(){
			return _this.currentMonth;
		};
		
		this.getCurrentDate = function(month){
			return _this.currentDate;
		};
		
		this.nextDay = function(){
			var theBigDay = new Date(_this.currentYear, _this.currentMonth-1, _this.currentDate);
			_this.date = new Date(theBigDay.setDate(_this.currentDate + 1));
			this.dateSetting();
		};
		
		this.befortDay = function(){
			var theBigDay = new Date(_this.currentYear, _this.currentMonth-1, _this.currentDate);
			_this.date = new Date(theBigDay.setDate(_this.currentDate - 1));
			this.dateSetting();
		};
		
		this.nextMonth = function(){
			if( _this.currentMonth == 12 ){
				_this.currentYear += 1;
				_this.currentMonth = 1;
			}else{
				_this.currentMonth += 1;
			}
		};
		
		this.befortMonth = function(){
			if( _this.currentMonth == 1 ){
				_this.currentYear -= 1;
				_this.currentMonth = 12;
			}else{
				_this.currentMonth -= 1;
			}
		};
		
		this.getCalendarInfo = function()
		{
			
			var yy = _this.currentYear;
			var mm = _this.currentMonth;
			
	        var num=this.getDaysInMonth(yy,mm)-1;
	        
	        var lastMonthDayNum = this.getLastMonthDay();
		    var dd=1;
			var dataA = [];
		    var startDay = this.getStartDay();
		    
		    var weekNum = Math.ceil((num + startDay) / 7);
		    var length = weekNum * 7;
		    var nextNum = 1;

		    if(length - startDay < lastMonthDayNum)
		    	length += 1;
		    
		    for(var i=0;i<length;++i){
		    	if( i < startDay )
		    	{
		    		var lastDay = ( lastMonthDayNum - startDay + 1 ) + i;
		    		dataA[i] = {year : yy, month : mm, day : lastDay, state : 'before' };
		    	}
		    	else if( i > num + startDay )
		    	{
		    		dataA[i] = {year : yy, month : mm, day : nextNum, state : 'after' };
		    		nextNum++;
		    	}
		    	else
		    	{
		    		dataA[i] = {year : yy, month : mm, day : dd, state : 'current' };
		    		dd++;
		    		
		    		if( this.checkToday( dataA[i] ) ){
			    		dataA[i].isToday = true;
			    	}
		    	}
		    	
		    	if( i%7 == 0 ) dataA[i].isSunday = true;
		    	if( i%7 == 6 ) dataA[i].isSaturday = true;
			}
		    
			return dataA;
		};
		
		this.getLastMonthDay = function(){
			
			var year;
			var month;
			
			if( _this.currentMonth == 1 ){
				year = _this.currentYear - 1;
				month = 12;
			}else{
				year = _this.currentYear;
				month = _this.currentMonth - 1;
			}
			
			return this.getDaysInMonth(year, month);
		};
		
		this.checkToday = function( dateObj ){
			
			var boolean = false;
			
			if( dateObj == null ) return boolean;
			
			var today = this.getToday();
			var checkDay ="" + dateObj.year + this.twoCheck( dateObj.month) + this.twoCheck( dateObj.day); 
			if( today == checkDay ){
				boolean = true;
			}
			
			return boolean;
		};
		
		this.getToday = function(div){
			if( div == null ) div = "";
			var today = "" + _this.date.getFullYear() + div +  this.twoCheck( _this.date.getMonth() + 1 ) + div + this.twoCheck( _this.date.getDate());
			
			return today;
		};
		
		this.getTodayKey = function(){
			var today = "" + _this.date.getFullYear() +  this.twoCheck( _this.date.getMonth() + 1 ) + this.twoCheck( _this.date.getDate() );
			return today;
		};
		
		this.twoCheck = function(n){
			var str = String(n);
			if( str.length < 2 ){
				str = "0" + str;
			}
			
			return str;
		};
		
		this.getDaysInMonth = function (year,mon)
		{
			var daysInMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
			if (this.isLeapYear(year) == true)
			{
				daysInMonth[1] = 29;
			}
			return daysInMonth[mon - 1];
		};
		
		this.isLeapYear = function (year)
		{
			if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		};
		
		this.getStartDay = function(strsDate){
			var sDate = _this.currentYear + "/" + _this.currentMonth + "/" + 1;
			var tmpDate = new Date(sDate);
			var nWeek = tmpDate.getDay();
			return nWeek;
		};
		
		this.getYearData = function( maxDate ){
			
			var currentYear = _this.date.getFullYear();
			var length = 20;
			if( maxDate != null ){
				length = maxDate - _this.date.getFullYear() + 20;
				currentYear = maxDate;
			}
			var arr = [];
			var index = 0;
			for( var i=_this.maxYear; i>=_this.minYear; i-- ){
				arr[index++] = {value: i, txt: i};
			}
			return arr;
		};
		
		this.getMonthData = function(){
			
			var arr = [];
			for( var i = 0; i< 12; i++ ){
				arr[i] = {value : this.twoCheck(i+1), txt : this.twoCheck(i+1) };
			}
			return arr;
		};
		
		
		this.init();
		
		
	};
	
})(jQuery);



//달력 브라우져 클릭시 닫히게
$(document).mousedown(function(e){
	$('.ik_calendar').each(function(){
        if( $(this).css('display') == 'block' )
        {
            var l_position = $(this).offset();
            l_position.right = parseInt(l_position.left) + ($(this).width());
            l_position.bottom = parseInt(l_position.top) + parseInt($(this).height());


            if( ( l_position.left <= e.pageX && e.pageX <= l_position.right )
                && ( l_position.top <= e.pageY && e.pageY <= l_position.bottom ) )
            {
                //alert( 'popup in click' );
            }
            else
            {
                //alert( 'popup out click' );
                $(this).hide("fast");
            }
        }
    });
}); 

