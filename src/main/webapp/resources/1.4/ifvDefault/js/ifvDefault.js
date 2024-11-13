$.extend({
	ifvPostJSON: function (url, jsonData, callback, errorCallback, btn, progressClass) {

		var jsonDataType = "json";
		var progress = null;
		if (btn != null) {

			var index = $.ifvRequestBtnSearch(btn);
			if (index > -1) return;

			progress = $.ifvLoading(btn, progressClass);
		}

		$.setProgressZindex();

		var jsonData = jsonData ? jsonData : {};
		$.extend(jsonData, {
			appServiceId: window.appServiceId,
			country: window.country,
			lang: window.lang
		});

		var config = {
			url: url,
			type: "POST",
			data: $.toJSON(jsonData),
			dataType: jsonDataType,
			contentType: "application/json; charset=utf-8",
			success: function (result) {
				if ($.errorChecker(result, errorCallback) == false) {
					return;
				}
				callback(result);
			},
			async: true,
			complete: function (xhr, status) {
				if (progress != null) $(progress).remove();
				$.ifvRemoveRequestBtn(btn);
			}
		};

		$.ajaxSetup(config);
		$.ajax();

		config = {
			url: null,
			type: "GET",
			data: null,
			dataType: null,
			contentType: "application/x-www-form-urlencoded",
			success: null,
			async: true
		};
		$.ajaxSetup(config);
	},
	ifvLoading: function (btn, progressClass, txt) {

		$.ifvAddRequestBtn(btn);
		var _btn;
		if (typeof btn == 'string') {
			_btn = $(btn);
		} else {
			_btn = btn;
		}

		_btn.attr('disabled', true);

		_btn.css('position', 'relative');
		var progress = document.createElement('div');
		if (btn != 'body')
			progress.style.position = 'absolute';

		if (progressClass != null) {
			$(progress).addClass(progressClass);
		} else {
			$(progress).addClass('progressRoll');
		}

		txt ? $(progress).text(txt) : $(progress).text(MESSAGE.common.progressTxt || '처리중');
		/*$(progress).css('z-index', '2147483647');*/
		$.setProgressZindex();
		if (_btn.children(".loading").hasClass("loading") === false) {
			_btn.append(progress);
		}

		return progress;
	},
	ifvAddRequestBtn: function (btn) {
		if ($.requestbtnArr == null) {
			$.requestbtnArr = [];
		}
		$.requestbtnArr.push(btn);
	},
	ifvRemoveRequestBtn: function (btn) {
		if (btn == null) btn = 'body';
		var index = $.ifvRequestBtnSearch(btn);

		if (index > -1) {
			$.requestbtnArr.splice(index, 1);
			$(btn).find('.progressRoll').remove();
			$(btn).attr('disabled', false);
		}
	},
	ifvRequestBtnSearch: function (btn) {
		var index = -1;

		if ($.requestbtnArr != null) {
			for (var i = 0; i < $.requestbtnArr.length; i++) {
				if (btn == $.requestbtnArr[i]) {
					index = i;
				}
			}
		}

		return index;
	},
	ifvPostHeaderJSON: function (url, jsonData, jsonHeaderData, callback, errorCallback, btn, progressClass) {
		var progress;
		if (btn != null) {
			var index = $.ifvRequestBtnSearch(btn);
			if (index > -1) return;
			progress = $.ifvLoading(btn, progressClass);
		}

		$.setProgressZindex();

		var jsonData = jsonData ? jsonData : {};
		$.extend(jsonData, {
			appServiceId: window.appServiceId,
			country: window.country,
			lang: window.lang
		});
		$.extend(jsonHeaderData, {
			appServiceId: window.appServiceId,
			country: window.country,
			lang: window.lang
		});

		var config = {
			url: url,
			type: "POST",
			data: $.toJSON(jsonData),
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function (result) {
				if ($.errorChecker(result, errorCallback) == false) {
					return;
				}
				callback(result);
			},
			async: true,
			headers: jsonHeaderData,
			complete: function (xhr, status) {
				if (progress != null) $(progress).remove();
				$.ifvRemoveRequestBtn(btn);
			},
		};

		$.ajaxSetup(config);
		$.ajax();

		config = {
			url: null,
			type: "GET",
			data: null,
			dataType: null,
			contentType: "application/x-www-form-urlencoded",
			success: null
		};
		$.ajaxSetup(config);
	},
	//이름은 동기지만 로직은 비동기 async: true...
	ifvSyncPostJSON: function (url, jsonData, callback, errorCallback, btn, progressClass, fallback) {
		var progress;
		if (btn != null) {
			var index = $.ifvRequestBtnSearch(btn);
			if (index > -1) return;

			progress = $.ifvLoading(btn, progressClass);
		}

		$.setProgressZindex();

		var jsonData = jsonData ? jsonData : {};
		$.extend(jsonData, {
			appServiceId: window.appServiceId,
			country: window.country,
			lang: window.lang
		});
		
		var config = {
			url: url,
			async: false,
			type: "POST",
			data: JSON.stringify(jsonData),
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function (result) {
				if ($.errorChecker(result, errorCallback) == false) {
					return;
				}
				callback(result);
			},
			complete: function (xhr, status) {
				if (progress != null) $(progress).remove();
				$.ifvRemoveRequestBtn(btn);
			},
			error: fallback
		};

		$.ajaxSetup(config);
		$.ajax();
		config = {
			url: null,
			type: "GET",
			data: null,
			async: true,
			dataType: null,
			contentType: "application/x-www-form-urlencoded",
			success: null
		};
		$.ajaxSetup(config);
	},
	ifvReplaceStr: function (str, replaceSize) {
		if (str == null && str == undefined) {
			str = '';
		} else if (str.length > replaceSize) {
			if (str.length > replaceSize) {
				str = str.substring(0, replaceSize) + '...';
			}
		}
		return str;
	},
	ifvGetTodayDate: function (formmat, value) {
		var _date = new Date();
		var _year = _date.getFullYear();
		var _month = "" + (_date.getMonth() + 1);
		var _day = "" + _date.getDate();
		if (_month.length == 1)
			_month = "0" + _month;
		if ((_day.length) == 1)
			_day = "0" + _day;
		var hour = _date.getHours();
		var minutes = _date.getMinutes();
		var seconds = _date.getSeconds();
		var tmp = "" + _year + _month + _day;
		var tmp2 = "";
		if (value == 'seconds') {
			tmp2 = "" + minutes + seconds;
		} else if (value == 'his') {
			tmp2 = " " + hour + ':' + minutes + ':' + seconds;
		}

		tmp = $.ifvDateForm(tmp, formmat);
		tmp += tmp2;
		return tmp;
	},
	ifvDateForm: function (date, str) {
		if (date == null) return;
		var div = '-';
		if (str != null)
			div = str;
		date = date.toString();
		var year = date.substring(0, 4);
		var month = date.substring(4, 6);
		var day = date.substring(6, 8);
		if (day == '' || day == null) {
			return year + div + month;
		}
		return year + div + month + div + day;
	},
	ifvNumberFormat: function (num) {

		if (num == null) return '';

		var result = '';
		var rest = '';
		var mark = '';
		var num_str = '';
		var isRest = false;

		num = num.toString();
		if (num.length > 0 && num[0] == '-') {
			mark = '-';
			num = num.replaceAll('-', '');
			num_str = num;
		}
		if (num.indexOf('.') > -1) {
			isRest = true;
			num_str = num;
			var arr = num_str.split('.');
			num_str = arr[0];
			num = num_str;
			if (arr.length > 1) {
				rest = arr[1];
				for (var i = 2; i < arr.length; i++) {
					rest += arr[i];
				}
			}
		} else {
			num_str = num;
		}

		if (isNaN(num)) {
			result = num;
		} else {
			result = "";
			if (num_str.length > 1) {
				for (var i = 0; i < num_str.length; i++) {
					var tmp = num_str.length - (i + 1);

					if (((i % 3) == 0) && (i != 0)) {
						result = ',' + result;
					}

					result = num_str.charAt(tmp) + result;
				}
			} else {
				result = num_str;
			}


			if ((isRest == true && rest == '') || rest != '') {
				rest = rest.replaceAll('-', '');
				if (result == '') result = 0;
				result = result + '.' + rest;
			}
		}

		return mark + result;
	},
	ifvStringFormat: function (cha) {
		var str = cha.replace(/\,/gi, '');

		if (isNaN(str)) {
			result = cha;
		} else {
			result = Number(str);
		}

		return result;
	},
	ifvLoadPop: function (obj) {

		var _data = obj;
		$.ifvCachedHtml(obj.url).done(function (script, textStatus) {

			obj.content = script;

			ifv.cPop = new ifvPopupFullscreen(obj);
			var fileName = _data.url.split('/').pop();
			if (window[fileName + '_init'] != null) window[fileName + '_init'](_data.params);


		});
	},
	ifvLoadEndPop: function (func) {
		func($.modalPopData);
	},
	ifvCachedHtml: function (url, options) {
		options = $.extend(options || {}, {
			dataType: "html",
			cache: true,
			async: false,
			url: url
		});

		return jQuery.ajax(options);
	},
	ifvtwoCheck: function (n) {
		var str = String(n);
		if (str.length < 2) {
			str = "0" + str;
		}

		return str;
	},
	ifvConfirm: function (str, func) {
		if (confirm(str)) {
			func();
		}
	},
	ifvGetParams: function () {
		var vars = [], hash;
		var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
		for (var i = 0; i < hashes.length; i++) {
			hash = hashes[i].split('=');
			vars.push(hash[0]);
			vars[hash[0]] = hash[1];
		}
		return vars;
	},
	ifvGetParam: function (name) {
		return $.ifvGetParams()[name];
	},
	ifvReload: function () {
		window.location.reload();
	},
	ifvEnterSetting: function (inputArr, func) {
		for (var i = 0; i < inputArr.length; i++) {
			$(inputArr[i]).keypress(function (e) {
				if (e.keyCode == 13) {
					func();
				}
			});
		}
	},
	modalClose: function (obj) {
		ifv.popup.closeFullScreenPopup(obj);
	},
	ifvGetNewDate: function (type, num, cDate) {
		var now = new Date();
		if (cDate != null) now = cDate;

		var newDate = new Date();
		switch (type) {
			case 'd':
				newDate.setDate(newDate.getDate() + num);
				break;
			case 'w':
				var now_t = now.getTime();
				term = 6 * 24 * 60 * 60 * 1000 * num;
				newDate.setTime(now_t - term);
				break;
			case 'm':
				newDate.setMonth(newDate.getMonth() + num);
				break;
			case 'y':
				newDate.setFullYear(newDate.getFullYear() + num);
				break;
			case 'y01':
				newDate.setFullYear(newDate.getFullYear() + num);
				newDate.setDate(01);
				break;
			case 'm01': 
				newDate.setMonth(newDate.getMonth() + num);
				newDate.setDate(01);
				break;	
		    case 'mEnd': // 한달전 말일 구함
				newDate.setDate(0);
		}

		var now_y = now.getFullYear();
		var now_m = now.getMonth() + 1;
		var now_d = now.getDate();

		var old_y = newDate.getFullYear();
		var old_m = newDate.getMonth() + 1;
		var old_d = newDate.getDate();

		old_y = String(old_y);
		old_m = (old_m < 10) ? '0' + String(old_m) : String(old_m);
		old_d = (old_d < 10) ? '0' + String(old_d) : String(old_d);

		now_y = String(now_y);
		now_m = (now_m < 10) ? '0' + String(now_m) : String(now_m);
		now_d = (now_d < 10) ? '0' + String(now_d) : String(now_d);

		var fromS = old_y + "-" + old_m + "-" + old_d;
		var toS = now_y + "-" + now_m + "-" + now_d;

		return {
			newDate: old_y + old_m + old_d,
			to: now_y + now_m + now_d,
			newDateS: fromS,
			toS: toS,
			monthType: old_y + "-" + old_m
		};
	},
	ifvGetDateTerm: function (d_term) {
		var now = new Date();
		var old = new Date();
		var term = 0;

		var now_t = now.getTime();

		if (d_term == 'w') {
			term = 6 * 24 * 60 * 60 * 1000;
			old.setTime(now_t - term);
		} else if (d_term == 'm') {
			old.setMonth(old.getMonth() - 1);
		} else if (d_term == '3m') {
			old.setMonth(old.getMonth() - 3);
		} else if (d_term == '6m') {
			old.setMonth(old.getMonth() - 6);
		} else if (d_term == 'y') {
			old.setFullYear(old.getFullYear() - 1);
		}

		var now_y = now.getFullYear();
		var now_m = now.getMonth() + 1;
		var now_d = now.getDate();

		var old_y = old.getFullYear();
		var old_m = old.getMonth() + 1;
		var old_d = old.getDate();

		old_y = String(old_y);
		old_m = (old_m < 10) ? '0' + String(old_m) : String(old_m);
		old_d = (old_d < 10) ? '0' + String(old_d) : String(old_d);

		now_y = String(now_y);
		now_m = (now_m < 10) ? '0' + String(now_m) : String(now_m);
		now_d = (now_d < 10) ? '0' + String(now_d) : String(now_d);

		var fromS = old_y + "-" + old_m + "-" + old_d;
		var toS = now_y + "-" + now_m + "-" + now_d;

		return {
			from: old_y + old_m + old_d,
			to: now_y + now_m + now_d,
			fromS: fromS,
			toS: toS
		};

	},
	ifvAlert: function (txt, func) {

		new ifvConfirm({
			btnTxt1: ifv.commonMessage.yes,
			btnTxt2: ifv.commonMessage.no,
			text: txt,
			closeFunc: function (index) {
				if (index == 1) {
					func();
				}
			}
		});
	},
	ifvErrorPop: function (txt) {
		new ifvConfirm({
			btnTxt1: ifv.commonMessage.ok,
			btnTxt2: false,
			text: txt
		});
	},
	ifvSupplant: function (temp, data) {
		return temp.replace(/{([^{}]*)}/g,
			function (a, b) {
				var r = data[b];
				return typeof r === 'string' ? r : a;
			}
		);

	},
	ifvFormatBytes: function (bytes) {
		if (bytes < 1024) return bytes + " Bytes";
		else if (bytes < 1048576) return (bytes / 1024).toFixed(3) + " KB";
		else if (bytes < 1073741824) return (bytes / 1048576).toFixed(3) + " MB";
		else return (bytes / 1073741824).toFixed(3) + " GB";
	},
	ifvFormatDate: function (format, time) {
		var dt;
		var uua = navigator.userAgent;
		var napn = navigator.appName;
		var nua = uua.toLowerCase();
		if ((napn == 'Netscape' && uua.search('Trident') != -1) || (nua.indexOf("msie") != -1) || (nua.indexOf('firefox') > -1)) {
			if (!isNaN(time - 0)) {
				dt = new Date(time);
			} else {
				time = time.replaceAll('-', '/').split('.')[0];
				dt = new Date(time);
			}
		} else {
			dt = new Date(time);
		}

		return result = format.replace(/(yyyy|yy|mm|dd|hh|HH|mi|ss|am|pm)/gi,
			function ($1) {
				switch ($1) {
					case 'yyyy': return dt.getFullYear();
					case 'yy': return dt.getFullYear().toString().substr(2);
					case 'mm': return dt.getMonth() + 1 < 10 ? '0' + (dt.getMonth() + 1) : dt.getMonth() + 1;
					case 'dd': return dt.getDate() < 10 ? '0' + dt.getDate() : dt.getDate();
					case 'hh': return (h = dt.getHours() % 12) ? (h < 10 ? '0' + h : h) : 12;
					case 'HH': return dt.getHours() < 10 ? '0' + dt.getHours() : dt.getHours();
					case 'mi': return dt.getMinutes() < 10 ? '0' + dt.getMinutes() : dt.getMinutes();
					case 'ss': return dt.getSeconds() < 10 ? '0' + dt.getSeconds() : dt.getSeconds();
					case 'am': return dt.getHours() < 12 ? 'am' : 'pm';
					case 'pm': return dt.getHours() < 12 ? 'am' : 'pm';
				}
			}
		);
	},
	errorChecker: function (data, errorCallback) {
		if (data == null) return true;
		var boolean = true;
		if (data.success == false || (data.errorType != null && data.errorType != 0)) {
			boolean = false;

			var str = '';
			switch (data.errorType) {
				case 100400:

					str = ifv.errorMessage.e_100400;

					break;
				case 100500:

					str = ifv.errorMessage.e_100500;

					break;
				case 100410:
					str = ifv.errorMessage.e_100410;

					break;
				case 200300:

					str = ifv.errorMessage.e_200300;

					break;

				case 200310:

					str = ifv.errorMessage.e_200310;

					break;

				case 200400:
					str = ifv.errorMessage.e_200400;

					break;
				case 200410:

					str = ifv.errorMessage.e_200410;

					if (typeof sessionEndFunc != "undefined" && sessionEndFunc != null) {
						sessionEndFunc();
					}

					break;
				case 200420:

					str = ifv.errorMessage.e_200420;


					break;
				case 200430:

					str = ifv.errorMessage.e_200430;

					break;
				case 200440:

					str = ifv.errorMessage.e_200440;

					break;
				case 200450:

					str = ifv.errorMessage.e_200450;

					break;
				case 200460:

					str = ifv.errorMessage.e_200460;

					if (typeof permissionCheckRedirectFunc != "undefined" && permissionCheckRedirectFunc != null) {
						permissionCheckRedirectFunc();
					}

					break;

				case 200500:

					if (errorCallback == null) {
						$.messageCheckr(data.message);
					}
					break;

				case 200700:

					$.ifvErrorPop(data.message);
					break;

			}
			if (errorCallback != null) {
				errorCallback(data);
				return boolean;
			} else if (boolean == false && str != '') {
				$.ifvErrorPop(str);
			}

		}

		return boolean;
	},
	messageCheckr: function (str) {
		var isMessage = true;
		switch (str) {
			case 'MSG_1000':
				$.ifvErrorPop(ifv.errorMessage.m_1000);
				break;
			case 'MSG_1001':
				$.ifvErrorPop(ifv.errorMessage.m_1001);
				break;
			case 'MSG_1002':
				$.ifvErrorPop(ifv.errorMessage.m_1002);
				break;
			case 'MSG_1003':
				$.ifvErrorPop(ifv.errorMessage.m_1003);
				break;
			case 'MSG_1004':
				$.ifvErrorPop(ifv.errorMessage.m_1004);
				break;
			case 'MSG_1005':
				$.ifvErrorPop(ifv.errorMessage.m_1005);
				break;
			case 'MSG_1006':
				$.ifvErrorPop(ifv.errorMessage.m_1006);
				break;
			case 'MSG_1007':
				$.ifvErrorPop(ifv.errorMessage.m_1007);
				break;
			case 'MSG_1008':
				$.ifvErrorPop(ifv.errorMessage.m_1008);
				break;
			case 'MSG_1009':
				$.ifvErrorPop(ifv.errorMessage.m_1009);
				break;
			case 'MSG_1010':
				$.ifvErrorPop(ifv.errorMessage.m_1010);
				break;
			case 'MSG_1012':
				$.ifvErrorPop(ifv.errorMessage.m_1012);
				break;
			case 'MSG_1013':
				$.ifvErrorPop(ifv.errorMessage.m_1013);
				break;
			case 'MSG_1014':
				$.ifvErrorPop(ifv.errorMessage.m_1014);
				break;
			case 'MSG_1015':
				$.ifvErrorPop(ifv.errorMessage.m_1015);
				break;
			case 'MSG_1016':
				$.ifvErrorPop(ifv.errorMessage.m_1016);
				break;
			case 'MSG_1017':
				$.ifvErrorPop(ifv.errorMessage.m_1017);
				break;
			case 'MSG_1018':
				$.ifvErrorPop(ifv.errorMessage.m_1018);
				break;
			case 'MSG_1019':
				$.ifvErrorPop(ifv.errorMessage.m_1019);
				break;
			case 'MSG_1020':
				$.ifvErrorPop(ifv.errorMessage.m_1020);
				break;
			case 'MSG_1021':
				$.ifvErrorPop(ifv.errorMessage.m_1021);
				break;
			case 'MSG_1022':
				$.ifvErrorPop(ifv.errorMessage.m_1022);
				break;
			case 'MSG_1023':
				$.ifvErrorPop(ifv.errorMessage.m_1023);
				break;
			case 'MSG_1024':
				$.ifvErrorPop(ifv.errorMessage.m_1024);
				break;
			case 'MSG_1025':
				$.ifvErrorPop(ifv.errorMessage.m_1025);
				break;
			case 'MSG_1026':
				$.ifvErrorPop(ifv.errorMessage.m_1026);
				break;
			case 'MSG_1027':
				$.ifvErrorPop(ifv.errorMessage.m_1027);
				break;
			case 'MSG_1028':
				$.ifvErrorPop(ifv.errorMessage.m_1028);
				break;
			case 'MSG_1029':
				$.ifvErrorPop(ifv.errorMessage.m_1029);
				break;
			case 'MSG_1030':
				$.ifvErrorPop(ifv.errorMessage.m_1030);
				break;
			case 'MSG_1031':
				$.ifvErrorPop(ifv.errorMessage.m_1031);
				break;
			case 'MSG_1032':
				$.ifvErrorPop(ifv.errorMessage.m_1032);
				break;
			case 'MSG_1033':
				$.ifvErrorPop(ifv.errorMessage.m_1033);
				break;
			case 'MSG_1034':
				$.ifvErrorPop(ifv.errorMessage.m_1034);
				break;
			case 'MSG_1035':
				$.ifvErrorPop(ifv.errorMessage.m_1035);
				break;
			case 'MSG_1036':
				$.ifvErrorPop(ifv.errorMessage.m_1036);
				break;
			case 'MSG_1037':
				$.ifvErrorPop(ifv.errorMessage.m_1037);
				break;
			case 'MSG_1038':
				$.ifvErrorPop(ifv.errorMessage.m_1038);
				break;
			case 'MSG_1039':
				$.ifvErrorPop(ifv.errorMessage.m_1039);
				break;
			case 'MSG_1040':
				$.ifvErrorPop(ifv.errorMessage.m_1040);
				break;
			case 'MSG_1041':
				$.ifvErrorPop(ifv.errorMessage.m_1041);
				break;
			case 'MSG_1042':
				$.ifvErrorPop(ifv.errorMessage.m_1042);
				break;
			case 'MSG_1043':
				$.ifvErrorPop(ifv.errorMessage.m_1043);
				break;
			case 'MSG_1044':
				$.ifvErrorPop(ifv.errorMessage.m_1044);
				break;
			case 'MSG_1045':
				$.ifvErrorPop(ifv.errorMessage.m_1045);
				break;
			case 'MSG_1046':
				$.ifvErrorPop(ifv.errorMessage.m_1046);
				break;
			case 'MSG_1047':
				$.ifvErrorPop(ifv.errorMessage.m_1047);
				break;
			case 'MSG_1048':
				$.ifvErrorPop(ifv.errorMessage.m_1048);
				break;
			case 'MSG_1049':
				$.ifvErrorPop(ifv.errorMessage.m_1049);
				break;
			case 'MSG_1050':
				$.ifvErrorPop(ifv.errorMessage.m_1050);
				break;
			default:
				$.ifvErrorPop(ifv.errorMessage.m_1001);
				break;
		}

		return isMessage;
	},
	ifvJSONP: function (url, jsonData, callback, errorCallback, btn, progressClass, fallback) {
		var progress;
		if (btn != null) {
			var index = $.ifvRequestBtnSearch(btn);
			if (index > -1) return;

			progress = $.ifvLoading(btn, progressClass);
		}

		$.setProgressZindex();

		var jsonData = jsonData ? jsonData : {};
		$.extend(jsonData, {
			appServiceId: window.appServiceId,
			country: window.country,
			lang: window.lang
		});

		var config = {
			url: url + '?callback=?',
			crossDomain: true,
			type: "GET",
			data: { jsonData: JSON.stringify(jsonData) },
			dataType: "jsonp",
			success: function (result, textStatus, jqXHR) {
				if ($.errorChecker(result, errorCallback) == false) {
					return;
				}
				callback(result);
			},
			complete: function (xhr, status) {
				if (progress != null) $(progress).remove();
				$.ifvRemoveRequestBtn(btn);
			},
			error: fallback
		};

		$.ajaxSetup(config);
		$.ajax();

		config = {
			url: null,
			type: "GET",
			data: null,
			async: true,
			dataType: null,
			contentType: "application/x-www-form-urlencoded",
			success: null
		};
		$.ajaxSetup(config);
	},
	ifvGetSelectBoxNum: function () {
		var arr = [10, 25, 50, 100];
		return arr;
	},
	ifvChangeMPString: function (msg, strArr) {
		var str = msg.cFormat(strArr);
		return str;
	},
	ifvIntChecker: function (n) {
		return Number(n) === n && n % 1 === 0;
	},
	ifvProgressControl: function (bl, tar, txt) {
		var tarDom;
		if (tar == null) tarDom = 'body';
		else tarDom = tar;

		if (bl == true) {
			$.ifvLoading(tarDom, 'loading', txt);
		} else {
			if ($('div.loading').length > 0) {
				$('div.loading').remove();
				$.ifvRemoveRequestBtn();
			}
		}
	},
	setProgressZindex: function () {
		var dg = $('body').find('.e-dialog.e-widget');
		if (dg.length > 0) {
			var zindex = 0;
			for (var i = 0; i < dg.length; i++) {
				var thiszindex = Number($(dg[i]).css('z-index'));
				if (zindex < thiszindex) zindex = thiszindex;
			}
		}
		$('div.loading').css({ 'z-index': zindex });
	},
	ifvGetCommCodeList: function (type, tarId, url, gc, sc, na, nainit) {
		var commJson = {};
		commJson['groupCode'] = gc;
		if (typeof sc !== 'undefined') commJson['schemas'] = sc;
		if (na === true) commJson['enableNA'] = true;
		$.ifvSyncPostJSON(url, commJson, function (result) {
			if (result.rows.length < 1) return false;
			if (type == "select") {
				var aptemp = $("#commCodeSelectTemplate").tmpl(result.rows);
				$("#" + tarId).append(aptemp);
				if (nainit === true) $('#' + tarId).val('NA');
			}
			else if (type == "checkbox") {
				for (var i = 0; i < result.rows.length; i++) {
					result.rows[i].codeId = result.rows[i].codeName + 'Checkbox' + i;
					result.rows[i].domName = tarId + 'Checkbox';
				}

				var aptemp = $("#commCodeCheckboxTemplate").tmpl(result.rows);
				$("#" + tarId).append(aptemp);
			}
			else if (type == "radio") {
				for (var i = 0; i < result.rows.length; i++) {
					result.rows[i].codeId = result.rows[i].codeName + 'Radio' + i;
					result.rows[i].domName = tarId + 'Radio';
				}

				var aptemp = $("#commCodeRadioTemplate").tmpl(result.rows);
				$("#" + tarId).append(aptemp);
			}
		});
	},
	ifvChangeTabContent: function (url, type, parentId, targetId) {
		var fileName = url.split('/').pop();
		$.ifvCachedHtml(url).done(function (script, textStatus) {
			$("#" + parentId).find('a').removeClass('active');
			$("#" + type).addClass('active');
			$("#" + targetId).empty();
			$("#" + targetId).html('');
			$("#" + targetId).append(script);

			if (window[fileName + '_init'] != null) window[fileName + '_init']();
		});
	},
	ifvCallValidationBox: function (dom, msg) {
		dom.focus();
		$('body').find('.ifv_vali_wrong').removeClass('ifv_vali_wrong');

		dom.addClass('ifv_vali_wrong');

		dom.parent().css('position', 'relative');
		var valiItem = $("<div class='vali_tooltip'>");

		var valiContent = $("<div class='vali_content'>");
		var valiArrow = $("<div class='vali_arrow'>");

		valiContent.text(msg);

		valiItem.append(valiContent);
		valiItem.append(valiArrow);

		var offset = dom.offset();

		valiItem.css({ left: offset.left, top: offset.top, opacity: 0 });
		$('body').append(valiItem);

		var vwidth = valiItem.outerWidth();
		var vheight = valiItem.outerHeight();

		valiItem.css({ left: offset.left, top: offset.top - vheight - 10, });

		valiItem.stop().animate({ opacity: 1 }, 200, function () {
			valiItem.delay(1000).animate({ opacity: 0 }, 50, function () {
				valiItem.remove();
			});
		});
	},
	ifvFilePostJSON: function (url, formData, callback, errorCallback, btn, progressClass, fallback) {
		var progress;
		if (btn != null) {
			var index = $.ifvRequestBtnSearch(btn);
			if (index > -1) return;

			progress = $.ifvLoading(btn, progressClass);
		}

		$.setProgressZindex();

		var config = {
			url: url,
			type: "POST",
			data: formData,
			processData: false,
			contentType: false,
			success: function (result) {
				if ($.errorChecker(result, errorCallback) == false) {
					return;
				}
				callback(result);
			},
			complete: function (xhr, status) {
				if (progress != null) $(progress).remove();
				$.ifvRemoveRequestBtn(btn);
			},
			error: fallback
		};

		$.ajaxSetup(config);
		$.ajax();

		config = {
			url: null,
			type: "GET",
			data: null,
			async: true,
			dataType: null,
			contentType: "application/x-www-form-urlencoded",
			success: null
		};
		$.ajaxSetup(config);
	},
	ifvGetByte: function (slt) {
		var str = slt.text() || slt.val();
		var strByte = (function (s, b, i, c) {
			for (b = i = 0; c = s.charCodeAt(i++); b += c >> 11 ? 3 : c >> 7 ? 2 : 1);
			return b;
		})(str);
		return strByte;
	},
	ifvSearchClear: function (args) {
		args.split(',').forEach(function(id) { $('#' + id.trim()).val('') })
	},
	//미사용
	ifvNumberPoint: function (num) {
		var isRest = false;
		var num_str;
		var rest = '';
		num = num.toString();
		var result = '';
		if (num.indexOf('.') > -1) {
			isRest = true;
			num_str = num;
			var arr = num_str.split('.');
			result = arr[0];
			if (arr.length > 1) {
				rest = arr[1];
				for (var i = 2; i < arr.length; i++) {
					rest += arr[i];
				}
			}
		} else {
			result = num;
		}

		if (result == '') result = '0';

		if ((isRest == true && rest == '') || rest != '') {
			result = result + '.' + rest;
		}

		return result;
	},
	//미사용
	ifvProgressSetting: function (area) {

		if (area == null) area = 'body';

		if ($.ifvRequestBtnSearch(area) > -1) return;

		$.ifvAddRequestBtn(area);
		var _btn = $(area);

		_btn.css('position', 'relative');
		var progress = $(document.createElement('div'));
		progress.addClass('progressRoll');
		progress.height(_btn[0].clientHeight);
		progress.width(_btn[0].clientWidth);

		var table_cell = document.createElement('div');
		$(table_cell).addClass('table_cell');

		var img = document.createElement('img');
		img.src = "/resources/images/icon/loading.gif";

		progress.append(table_cell);
		$(table_cell).append(img);

		_btn.append(progress[0]);
	},
	//미사용
	ifvMainException: function (area, str) {
		if (area == null || $.ifvRequestBtnSearch(area) > -1)
			return;

		$.ifvAddRequestBtn(area);
		var _btn = $(area);

		_btn.css('position', 'relative');
		var progress = $(document.createElement('div'));
		progress.addClass('progressRoll');
		progress.addClass('main_p_bg');
		if (_btn[0] != null) {
			if (_btn[0].clientHeight != 0) progress.height(_btn[0].clientHeight);
			if (_btn[0].clientWidth != 0) progress.width(_btn[0].clientWidth);
		}

		var table_cell = document.createElement('div');
		$(table_cell).addClass('table_cell');

		var txt = document.createElement('div');
		txt.innerHTML = str;

		progress.append(table_cell);
		$(table_cell).append(txt);

		_btn.append(progress[0]);
	},
	//미사용
	ifvPostJSONLoading: function (url, jsonData, btn, callback, str) {


		if (str) {
			if (confirm(str)) {

				$.ifvPostJSONLoading2(url, jsonData, btn, callback);
			} else {
				return;
			}
		} else {
			$.ifvPostJSONLoading2(url, jsonData, btn, callback);
		}

	},
	//미사용
	ifvPostJSONLoading2: function (url, jsonData, btn, callback, str) {
		if (btn != null) {

			$.ifvAddRequestBtn(btn);
			var _btn;
			if (btn == '') {
				_btn = $('body');
			} else if (typeof btn == 'string') {
				_btn = $("#" + btn);
			} else {
				_btn = btn;
			}

			_btn.css('position', 'relative');
			var progress = document.createElement('div');
			$(progress).addClass('progressRoll');
			if (_btn[0] == $('body')[0]) {
				$(progress).height($(window).height());
			} else {
				$(progress).height(_btn.height());
			}
			if (_btn.length > 0) $(progress).width(_btn[0].clientWidth);

			var table_cell = document.createElement('div');
			$(table_cell).addClass('table_cell');

			var img = document.createElement('img');
			img.src = "/resources/images/icon/loading.gif";

			$(progress).append(table_cell);
			$(table_cell).append(img);

			_btn.append(progress);
		}

		$.ifvPostJSON(url, jsonData, function (result) {
			if (btn != null) {
				$(progress).remove();
				$.ifvRemoveRequestBtn(btn);
			}

			if (result == null)
				return;
			if (result.okFl == "E") {
				alert(result.message);
			} else {
				callback(result);
			}
		});
	},
	//미사용
	ifvLoadingPostJSON: function (url, jsonData, callback, rootElement, errorCallback) {

		var jsonData = jsonData ? jsonData : {};
		$.extend(jsonData, {
			appServiceId: window.appServiceId,
			country: window.country,
			lang: window.lang
		});

		var config = {
			url: url,
			type: "POST",
			data: JSON.stringify(jsonData),
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function (result) {
				if ($.errorChecker(result, errorCallback) == false) {
					return;
				}
				callback(result);
			},
			async: true,
			beforeSend: function (xhr) {
				$(rootElement).block({
					message: null,
					css: {
						background: 'white',
						background: '#fff'
					}
				});
			},
			complete: function (xhr, status) {
				$(rootElement).unblock();
			}
		};

		$.ajaxSetup(config);
		$.ajax();

		config = {
			url: null,
			type: "GET",
			data: null,
			dataType: null,
			contentType: "application/x-www-form-urlencoded",
			success: null
		};
		$.ajaxSetup(config);
	},
	//미사용
	ifvIncludePage: function (obj) {

		var _data = obj;
		$.ifvCachedHtml(obj.url).done(function (script, textStatus) {

			obj.content = script;
			var fileName = _data.url.split('/').pop();
			var prms = _data.params || '';
			if (window[fileName + '_init'] != null) window[fileName + '_init'](prms);


		});
	},
	//미사용
	ifvLoadPopScriptSetting: function (html) {

		var regexp1 = /\r\n/g;
		var html2 = html.replace(regexp1, '');

		var regexp2 = /<script.*?>(.+)<\/script>/g;
		var html3 = html2.replace(regexp2, function ($0, $1, $2, $3) {
			var newScript = '<script type="text/javascript">';
			newScript += 'ModalClass' + ifv.popNum + ' = function(){';
			newScript += $1;
			newScript += '};';
			newScript += 'var modalClass' + ifv.popNum + ' = new ModalClass' + ifv.popNum + '();';
			newScript += '</script>';
			return newScript;
		});

		return html3;
	},
	//미사용
	ifvAddZero: function (num, tarLength) {

		var newNum = "";
		var length = String(num).length;
		if (tarLength == null) tarLength = 2;
		if (length < tarLength) {
			for (var i = 0; i < tarLength - length; i++) {
				newNum += "0";
			}
			newNum += num;
		} else {
			newNum = num;
		}

		return newNum;
	},
	//미사용
	ifvGetYearList: function (startYear, sN, lastYear) {
		var arr = [];

		var currentYear = lastYear;
		if (currentYear == null)
			currentYear = new Date().getFullYear();

		var selectNum = 0;
		if (sN != null) {
			selectNum = sN;
		}

		for (var i = currentYear; i > startYear - 1; i--) {
			var obj = {
				value: i,
				txt: i
			};
			if (selectNum == arr.length)
				obj.selected = true;
			arr.push(obj);
		}

		return arr;
	},
	//미사용
	ifvGetMonthList: function (sN) {

		var arr = [];

		var selectNum = 1;
		if (sN != null) {
			selectNum = sN;
		}

		for (var i = 1; i <= 12; i++) {
			var obj = {
				value: $.ifvtwoCheck(i),
				txt: $.ifvtwoCheck(i)
			};
			if (selectNum == i)
				obj.selected = true;
			arr.push(obj);
		}

		return arr;
	},
	//미사용
	ifvGetHour: function (sN) {
		var arr = [];
		var selectNum = 0;
		if (sN != null) {
			selectNum = sN;
		}

		for (var i = 0; i < 24; i++) {
			var obj = {
				value: $.ifvtwoCheck(i),
				txt: $.ifvtwoCheck(i)
			};
			if (selectNum == $.ifvtwoCheck(i))
				obj.selected = true;
			arr.push(obj);
		}

		return arr;
	},
	//미사용
	ifvGetMinute: function (sN) {
		var arr = [];
		var selectNum = 0;
		if (sN != null) {
			selectNum = sN;
		}
		for (var i = 0; i < 60; i++) {
			var obj = {
				value: $.ifvtwoCheck(i),
				txt: $.ifvtwoCheck(i)
			};
			if (selectNum == $.ifvtwoCheck(i))
				obj.selected = true;
			arr.push(obj);
		}

		return arr;
	},
	//미사용
	ifvGetPageNum: function (num) {
		var arr = [];
		for (var i = 0; i < num; i++) {
			arr[i] = {
				value: i + 1,
				txt: i + 1
			};
		}
		arr[0].selected = true;
		return arr;
	},
	//미사용
	ifvPostSubmit: function (url, listArr) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		document.body.appendChild(form);

		var input_id = null;
		for (var i = 0; i < listArr.length; i++) {
			input_id = document.createElement("input");
			input_id.setAttribute("type", "hidden");
			input_id.setAttribute("name", "id");
			input_id.setAttribute("value", listArr[i]);
			form.appendChild(input_id);
		}

		form.submit();
	},
	//미사용
	ifvPostSubmitJson: function (url, json) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		document.body.appendChild(form);
		var input_id = null;
		for (var key in json) {
			input_id = document.createElement("input");
			input_id.setAttribute("type", "hidden");
			input_id.setAttribute("name", key);
			input_id.setAttribute("value", json[key]);
			form.appendChild(input_id);
		}
		$(form).submit().remove();
	},
	//미사용
	ifvPostSubmitJsonPopup: function (url, json) {
		var form = document.createElement("form");
		window.open(url, "viewer", 'width=1000, height=700');
		form.target = "viewer";
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var input_id = null;
		for (var key in json) {
			input_id = document.createElement("input");
			input_id.setAttribute("type", "hidden");
			input_id.setAttribute("name", key);
			input_id.setAttribute("value", json[key]);
			form.appendChild(input_id);
		}
		$(form).submit().remove();
	},
	//미사용
	ifvGetSubmitJsonPopup: function (url, json) {

		var params = '';
		for (var key in json) {
			params += key + "=" + encodeURI(encodeURIComponent(json[key])) + "&";
		}
		window.open(url + '?' + params, "viewer", 'resizable=yes, scrollbars=yes, width=700, height=800');

	},
	//미사용
	ifvPostSubmitObj: function (url, key) {

		if (typeof (key) != 'object') {
			var newUrl = url + '?key=' + key;
		} else {
			var newUrl = url + '?' + $.param(key);
		}
		location.href = newUrl;
	},
	//미사용
	ifvObserverMap: {},
	//미사용
	ifvObserver: function (selector, params) {

		if ($.ifvObserverMap[selector] == null)
			return;

		var callback = $.ifvObserverMap[selector].callback;
		var scope = $.ifvObserverMap[selector].scope;

		callback.call(scope, params);
	},
	//미사용
	ifvRegObserver: function (scope, selector, callback) {
		$.ifvObserverMap[selector] = {
			callback: callback,
			scope: scope
		};
	},
	//미사용
	ifvRemoveParam: function (arr, paramName) {
		var arr2 = [];
		for (var i = 0; i < arr.length; i++) {
			arr2[i] = arr[i];
			delete arr2[i][paramName];
		}
		return arr2;
	},
	//미사용
	ifvSetHashChecker: function (hashSet, addClassName, callBack) {
		var _this = function () {
			if (!!hashSet && !!hashSet._default && !!hashSet._group) {
				var hash = window.location.hash;

				if (hash == '') {
					window.location.hash = '#' + hashSet._default;

					return false;
				} else {
					hash = (hash)
						.match(/(^#|[^&]#)([a-z0-9]+)\b(?!;)/gi)[0];
					hash = hash.replace('#', '');
				}

				if (typeof (addClassName) != 'undefined') {
					$(hashSet._group).removeClass(addClassName);
					$(hashSet[hash]).addClass(addClassName);
				}

				if (typeof (callBack) == 'function') {
					callBack(hash);
				}
			}
		}

		$(window).bind('hashchange', _this);

		_this();
	},
	//미사용
	ifvGetHash: function () {
		var hash = window.location.hash;

		if (hash != '') {
			hash = (hash).match(/(^#|[^&]#)([a-z0-9]+)\b(?!;)/gi)[0];
			hash = hash.replace('#', '');
		}

		return hash;
	},
	//미사용
	ifvGetParamValue: function (name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex
			.exec(location.search);

		return results == null ? "" : decodeURIComponent(results[1]
			.replace(/\+/g, " "));
	},
	//미사용
	ifvParentListener: {
		user_info: function (data) {
			alert(data);
		}
	},
	//미사용
	ifvRegParentListener: function (lid_arr, callback) {
		$.each(lid_arr, function (i, val) {
			$.ifvParentListener[val] = callback;
		});
	},
	//미사용
	ifvHref: function (url, type) {
		if (type == '_blank') {
			var openNewWindow = window.open("about:blank");
			openNewWindow.location.href = url;
		} else {
			location.href = url;
		}
	},
	//미사용
	ifvGetDateArr: function () {

		var arr = [];

		var date = new Date();
		var old = new Date();

		var year = date.getFullYear();
		var month = date.getMonth() + 1;

		var now = date.getTime();

		for (var i = 0; i < 7; i++) {
			old.setTime(now - 1 * 1000 * 60 * 60 * 24 * (7 - i));
			arr[i] = year + $.ifvtwoCheck(month) + $.ifvtwoCheck(old.getDate());
		}

		return arr;
	},
	//미사용
	ifvFromToCheck: function (fromId, toId) {
		var from = $(fromId).attr('key');
		var to = $(toId).attr('key');

		if (from > to) {
			alert('시작일은 종료일을 넘을 수 없습니다.');
			return false;
		}

		return true;
	},
	//미사용
	ifvFromToGapCheck: function (fromId, toId, gapDay) {

		var from = $(fromId).attr('key');
		var to = $(toId).attr('key');

		if (from == null || to == null)
			return true;

		var newDateFrom = new Date(from.substring(0, 4), from.substring(4, 6), from.substring(6, 8));
		var newDateTo = new Date(to.substring(0, 4), to.substring(4, 6), to.substring(6, 8));

		var interval = (newDateTo - newDateFrom) / (1000 * 60 * 60 * 24);

		if (interval > gapDay) {
			alert('조회기간이 ' + gapDay + '일이 이내로 입력해주세요.');
			return false;
		}

		return true;
	},
	//미사용
	ifvChangeByDay: function (date) {
		var info = new $.calendarInfo();

		var year = Number(date.substring(0, 4));
		var month = Number(date.substring(4, 6));
		var day = Number(date.substring(6, 8));

		return days = year * 360
			+ info.getDaysInMonth(year, Number(month)) * month
			+ day;

	},
	//미사용
	ifvUserAgent: function () {
		var b = navigator.userAgent.toLowerCase(), c = window.opera, a = {
			ie: eval("/*@cc_on!@*/false"),
			opera: !!c && c.version,
			webkit: b.indexOf(" applewebkit/") > -1,
			air: b.indexOf(" adobeair/") > -1,
			mac: b.indexOf("macintosh") > -1,
			quirks: document.compatMode == "BackCompat",
			mobile: b.indexOf("mobile") > -1,
			iOS: /(ipad|iphone|ipod)/.test(b),
			isCustomDomain: function () {
				if (!this.ie)
					return false;
				var a = document.domain, b = window.location.hostname;
				return a != b && a != "[" + b + "]"
			},
			secure: location.protocol == "https:"
		};
		a.gecko = navigator.product == "Gecko" && !a.webkit && !a.opera;
		if (a.webkit)
			b.indexOf("chrome") > -1 ? a.chrome = true
				: a.safari = true;
		var f = 0;
		if (a.ie) {
			f = a.quirks || !document.documentMode ? parseFloat(b
				.match(/msie (\d+)/)[1]) : document.documentMode;
			a.ie10Compat = f == 10;
			a.ie9Compat = f == 9;
			a.ie8Compat = f == 8;
			a.ie7Compat = f == 7;
			a.ie6Compat = f < 7 || a.quirks
		}
		if (a.gecko) {
			var e = b.match(/rv:([\d\.]+)/);
			if (e) {
				e = e[1].split(".");
				f = e[0] * 1E4 + (e[1] || 0) * 100 + (e[2] || 0) * 1
			}
		}
		a.opera && (f = parseFloat(c.version()));
		a.air && (f = parseFloat(b.match(/ adobeair\/(\d+)/)[1]));
		a.webkit && (f = parseFloat(b.match(/ applewebkit\/(\d+)/)[1]));
		a.version = f;
		a.isCompatible = a.iOS
			&& f >= 534
			|| !a.mobile
			&& (a.ie && f > 6 || a.gecko && f >= 10801 || a.opera
				&& f >= 9.5 || a.air && f >= 1 || a.webkit
				&& f >= 522 || false);
		a.cssClass = "cke_browser_"
			+ (a.ie ? "ie" : a.gecko ? "gecko" : a.opera ? "opera"
				: a.webkit ? "webkit" : "unknown");
		if (a.quirks)
			a.cssClass = a.cssClass + " cke_browser_quirks";
		if (a.ie) {
			a.cssClass = a.cssClass
				+ (" cke_browser_ie" + (a.quirks || a.version < 7 ? "6"
					: a.version));
			if (a.quirks)
				a.cssClass = a.cssClass + " cke_browser_iequirks"
		}
		if (a.gecko && f < 10900)
			a.cssClass = a.cssClass + " cke_browser_gecko18";
		if (a.air)
			a.cssClass = a.cssClass + " cke_browser_air";
		return a;
	},
	//미사용
	previewImage: function (imgArea, fileData) {

		var ua = window.navigator.userAgent;

		if (ua.indexOf("MSIE") > -1) {
			fileData.select();

			try {
				var src = document.selection.createRange().text;
				imgArea.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
					+ src + "', sizingMethod='scale')";
			} catch (e) {
				if (!document.getElementById("ie_preview_error_"
					+ previewId)) {
					var info = document.createElement("<p>");
					info.id = "ie_preview_error_" + previewId;
					info.innerHTML = "a";
					$(imgArea).before(info, null);
				}
			}

		} else {

			var files = fileData.files;
			for (var i = 0; i < files.length; i++) {

				var file = files[i];
				if (window.FileReader) {
					var reader = new FileReader();
					reader.onloadend = (function (aImg) {
						return function (e) {
							aImg.src = e.target.result;
						};
					})(imgArea);
					reader.readAsDataURL(file);
				} else {
					if (!document.getElementById("sfr_preview_error_"
						+ previewId)) {
						var info = document.createElement("p");
						info.id = "sfr_preview_error_" + previewId;
						info.innerHTML = "not supported FileReader";
						preview.insertBefore(info, null);
					}
				}
			}
		}

	},
	//미사용
	ifvChangeDateString: function (str, divider) {
		if (typeof str != 'string') str.toString();
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		str = str.replace(regExp, '');
		divider = divider || '';
		var rtnStr = '';

		if (str.length == 8)
			rtnStr = str.substr(0, 4) + divider + str.substr(4, 2) + divider + str.substr(6, 2);
		else
			rtnStr = str.substr(0, 4) + divider + str.substr(4, 2);

		return rtnStr;
	},
	//미사용
	imageUrlChecker: function (imageUrl) {
		var iLength = imageUrl.length;
		var slicedUrl = imageUrl.substr(iLength - 4, 4);
		if (slicedUrl == 'null' || slicedUrl.indexOf('.') == -1)
			return false;
		else
			return true;
	},
	//미사용
	ifvNewUUID: function () {
		return UUID.generate().replace(/-/g, '').substring(0, 24);
	},
	//미사용 - ifvmLnbSetting사용
	ifvLnbSetting: function (lnbId) {
		if (!$(".leftMenu li").hasClass("active")) {
			$(".leftMenu li").removeClass("active");
			$("#" + lnbId).addClass("active");
			if ($("#" + lnbId).parent().hasClass('sub'))
				$("#" + lnbId).parent().parent().addClass('active');
		}
	},
	//미사용
	ifvGetTime: function (day) {
		return new Date(day).getTime();
	},
	//미사용
	deleteParam: function (arr, paramName) {
		var deleteParam = [];

		for (var i = 0; i < arr.length; i++) {

			if (arr[i].codeName != paramName) {
				deleteParam.push(arr[i]);
			}
		}
		return deleteParam;
	},
	//미사용
	ifvMonthChanger: function (month) {

		var rmt;
		switch (month) {
			case 1:
				rmt = MESSAGE.month.january;
				break;
			case 2:
				rmt = MESSAGE.month.febrary;
				break;
			case 3:
				rmt = MESSAGE.month.march;
				break;
			case 4:
				rmt = MESSAGE.month.april;
				break;
			case 5:
				rmt = MESSAGE.month.may;
				break;
			case 6:
				rmt = MESSAGE.month.june;
				break;
			case 7:
				rmt = MESSAGE.month.july;
				break;
			case 8:
				rmt = MESSAGE.month.august;
				break;
			case 9:
				rmt = MESSAGE.month.september;
				break;
			case 10:
				rmt = MESSAGE.month.october;
				break;
			case 11:
				rmt = MESSAGE.month.november;
				break;
			case 12:
				rmt = MESSAGE.month.december;
				break;
		}

		return rmt;
	},
	//미사용
	ifvMonthlyCalendar: function (tarId, terms) {
		var monthJson = [];

		if (terms < 1) return false;
		var todayY = Number($.ifvGetNewDate().newDate.substr(0, 4));
		var todayM = Number($.ifvGetNewDate().newDate.substr(4, 2));
		for (var i = 0; i < terms; i++) {
			todayM--;
			if (todayM == 0) {
				todayM = 12;
				todayY--;
			}

			if (todayM < 10) todayM = "0" + todayM;

			var monthObj = { yyyymm: todayY.toString() + todayM.toString() };
			monthJson.push(monthObj);
		}
		var aptemp = $("#monthlyCalendarTemplate").tmpl(monthJson);
		$("#" + tarId).append(aptemp);
	},
	//미사용
	ifvSetCookie: function (cName, cValue, cDay) {
		var d = new Date();
		d.setTime(d.getTime() + (cDay * 24 * 60 * 60 * 1000));
		var expires = "expires=" + d.toUTCString();
		document.cookie = cName + "=" + cValue + "; " + expires;
	},
	//미사용
	ifvGetCookie: function (cName) {
		var name = cName + "=";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ') {
				c = c.substring(1);
			}
			if (c.indexOf(name) == 0) {
				return c.substring(name.length, c.length);
			}
		}
		return "";
	},
	//미사용
	ifvGetCheckedValueInDiv: function (tarId, varArray) {
		var tarDom = $('#' + tarId);
		if (typeof varArray != 'undefined') {
			tarDom.find('input[type="checkbox"]').each(function () {
				for (var i = 0; i < varArray.length; i++) {
					if (varArray[i] == $(this).val())
						$(this).attr('checked', true);
				}
			});
			tarDom.find('input[type="radio"]').each(function () {
				for (var i = 0; i < varArray.length; i++) {
					if (varArray[i] == $(this).val())
						$(this).attr('checked', true);
				}
			});
		} else {
			var cvArr = [];
			tarDom.find('input[type="checkbox"]:checked').each(function () {
				cvArr.push($(this).val());
			});
			tarDom.find('input[type="radio"]:checked').each(function () {
				cvArr.push($(this).val());
			});
			return cvArr;
		}
	}
});

$.fn.getSubmitData = function () {
	var jsonObj = {};
	var pId = this.attr('id');

	var inputArr = this.find('[dtoParam]');

	for (var i = 0; i < inputArr.length; i++) {
		var input = $(inputArr[i]);
		dataMatch(input);
	};

	function dataMatch(item) {

		var paramArr = item.attr('dtoParam').split('.');
		var parentParam = null;
		if (paramArr.length > 1) {
			parentParam = paramArr[0];
		}
		var paramName = paramArr[paramArr.length - 1];
		var type = item.attr('paramType');
		var tagName = item[0].tagName.toUpperCase();
		if (tagName == 'INPUT' || tagName == 'TEXTAREA' || tagName == 'SELECT') {	//

			dataMatch2(parentParam, paramName, getValue(item), type);
		} else {
			if (type == 'array') {
				jsonObj[paramName] = [];
			} else {
				jsonObj[paramName] = {};
			}
		}

	};

	function dataMatch2(parentParam, paramName, val, type) {
		if (val == null) return;
		if (parentParam != null) {
			if (type == 'array') {
				if (jsonObj[parentParam][paramName] == null) {
					jsonObj[parentParam][paramName] = [];
				}
				jsonObj[parentParam][paramName].push(val);
			} else {
				jsonObj[parentParam][paramName] = val;
			}

		} else {
			if (type == 'array') {
				if (jsonObj[paramName] == null) {
					jsonObj[paramName] = [];
				}
				jsonObj[paramName].push(val);
			} else {
				if ($('[dtoParam=' + paramName + ']').hasClass('ifv_number_only'))
					jsonObj[paramName] = val.replaceAll(',', '');
				else
					jsonObj[paramName] = val;
			}

		}
	};

	function getValue(item) {
		var val;
		if (item.attr('key') != null) {
			val = item.attr('key');
		} else {
			if (item[0].type == "radio" || item[0].type == 'checkbox') {
				if (item[0].checked == true) {
					val = item.val();
				}
			} else {
				val = item.val();
			}
		}

		if (item[0].type == 'checkbox') {
			val = item[0].checked;
		}

		return val;

	}

	return jsonObj;
};
$.fn.dataSetting = function (obj, type, isDisabled, notDisabledArr) {
	for (var key in obj) {

		if (typeof obj[key] == 'object')
			continue;

		var input = this.find('[dtoParam="' + key + '"]');
		if (input.length > 0) {
			if (type != null) {
				input.text(obj[key]);
			} else if (input.attr('type') == 'checkbox' || input.attr('type') == 'radio') {
				for (var i = 0; i < input.length; i++) {
					if (input.eq(i).attr('value') == obj[key]) {
						input.eq(i).trigger("click");
						input.eq(i).attr('checked', 'checked');
						break;
					}
				}
			} else {
				if (input.hasClass('ifv_number_only'))
					input.val($.fn.ifvmNumberWithCommas(obj[key]));
				else
					input.val(obj[key]);
			}

			if (isDisabled == true) {
				var check = -1;
				if (notDisabledArr != null) {
					for (var i = 0; i < notDisabledArr.length; i++) {
						if (key == notDisabledArr[i]) {
							check = i;
							break;
						}
					}
				}

				if (check == -1) {
					input.attr('disabled', true);
				}
			}
		};
	}
};
$.fn.ifvFormClean = function (noIdArr) {
	var inputArr = this.find('input, textarea');
	var noArr = this.find('input[type=button]');

	for (var i = inputArr.length - 1; i > -1; i--) {
		for (var j = 0; j < noArr.length; j++) {
			if (inputArr[i] == noArr[j]) {
				inputArr.splice(i, 1);
			}
		}

		for (var k = 0; k < noIdArr.length; k++) {
			if (inputArr[k].attr('id') == noIdArr[k]) {
				inputArr.splice(i, 1);
			}
		}
	}

	inputArr.val('');
};
$.fn.ifvNumberOnly = function () {

	var _this = this;
	$(this).addClass('ifv_number_only');

	this.keyup(function () {
		_this.replce();
	});

	this.blur(function () {
		_this.check();
	});

	this.replce = function () {
		var v = _this.val();
		if (v === "-") _this.val(v);
		else {
			var ng = false;
			var ispg = false;
			var pg;
			if (v.indexOf('.') > -1) {
				ispg = true;
				pg = v.split('.')[1];
				v = v.split('.')[0];
			}
			if (v.charAt(0) === '-')
				ng = true;

			var numPattern1 = /[^\d]+/g;

			var str = v.replace(numPattern1, '');

			var numPattern2 = /\B(?=(\d{3})+(?!\d))/g;

			str = str.replace(numPattern2, ",");
			if (ng) str = '-' + str;
			if (ispg) str += '.' + pg;
			_this.val(str);
		}
	};

	this.check = function () {
		var _v = _this.val();
		var v = Number(_v.replaceAll(',', ''));

		var regex = /^(?:\d*\.\d{1,2}|\d+)$/;
		if (v < 0)
			v *= -1;
		if (isNaN(v) || !regex.test(v))
			_this.val(0);
		else if (_v.slice(-1) == '.')
			_this.val(_v.slice(0, -1));
	}

};
$.fn.ifvFloatOnly = function (round) {

	var _this = this;

	$(this).addClass('ifv_float_only');

	this.keyup(function () {
		_this.replce();
	});

	this.focus(function () {
		_this.replce();
	});

	this.blur(function () {
		_this.replce();
	});

	this.replce = function () {
		var reg = /[^(0-9)\|.]/gi;
		var num = _this.val().replace(reg, '');
		var parts = num.split(".");
		var str = parts[0] + (parts[1] ? "." + parts[1] : "");
		str = (str * 1).toFixed(round) + "";
		parts = str.split(".");
		str = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (parts[1] ? "." + parts[1] : "")

		_this.val(str);
	};

};
$.fn.onlyNumber = function (type, length, toFixLength) {
	return this.each(function () {
		$(this).onlyNumber2(type, length, toFixLength);
	});
};
$.fn.onlyNumber2 = function (type, length, toFixLength) {

	var _this = this;
	this.keyup(function () {
		_this.replce();
	});

	this.blur(function () {
		_this.replce();
	});

	this.replce = function () {

		var numPattern = /([^-0-9\.])/g;

		if (type == 'point') {
			numPattern = /([^0-9\.])/g;
		} else if (type == 'number') {
			numPattern = /([^0-9])/g;
		} else if (type == 'eng') {
			numPattern = /([^A-Za-z0-9])/g;
		}

		var str = String(_this.val()).replace(numPattern, '');

		if (type == 'money') {
			var arr = str.split('.');
			var tL = 2;
			if (toFixLength != null) tL = toFixLength;
			if (arr.length > 1 && arr[1].length > tL) {

				str = String(Number(str).toFixed(String(tL)));
			}
		}

		if (length != null) str = str.substring(0, length);

		if (type == "money" || type == "point" || type == "number") {
			str = $.ifvNumber_format(str);
		}

		_this.val(str);
	};

	return this;
};
$.fn.ifvDateChecker = function(options){

	this.opt = $.extend({
		minDate : null,
		maxDate : null,
		onSelect : null,
		changeYear: true,
		changeMonth: true,
		yearRange: null,
		minTxt : MESSAGE.common.minDateTxt,
		maxTxt : MESSAGE.common.maxDateTxt,
		minDataArr : [],
		maxDateArr : []
	}, options);

	this.init = function(){

		this.defaultSetting();
		this.eventSetting();
		this.optionSetting();
		
	};

	this.defaultSetting = function(){
		this.opt.minDataArr = this.arraySetting( this.opt.minDate );
		this.opt.maxDateArr = this.arraySetting( this.opt.maxDate );
	};

	this.arraySetting = function( data ){
		var arr = [];
		if( data != null ){
			if( typeof data == 'string' || !$.isArray(data) ){
				arr.push( data );
			}else{
				arr = data;
			}
		}
		return arr;
	};

	this.eventSetting = function(){
		var dataDateFormat = this.attr('data-dateformat') || 'dd-mm-yy';

		var _this = this;

		var beforeDate = null;
		beforeDate = this.val();

		var beforeOrignDate = beforeDate;
		var lenguageObj = $.datepicker.regional[lang];
		lenguageObj.dateFormat = dataDateFormat;
		lenguageObj.onSelect = function(date) {
			valiCheck(date);
		},
		lenguageObj.prevText = '';
		lenguageObj.nextText = '';
		this.datepicker( lenguageObj );

		this.blur(function(e) {
        	var _this = this;
        	if($(this).val()) {
        		setTimeout(function() {
	                var date = _this.value;
	                var dateObj = {
	                	year: date.substr(0,4),
	                	month: date.substr(4,2),
	                	day: date.substr(6,2)
	                }
	                
	                var num_regexp = /^[0-9]*$/
	                var num_check = /^\d{4}-\d{1,2}-\d{1,2}$/;
	                
	                if(num_regexp.test(date)) {
	                	date = dateObj.year + '-' + dateObj.month + '-' + dateObj.day;
	                }
	                
	                if (num_check.test(date) == false) {
	                    date = '';
	                }
	                valiCheck(date);
	        	}, 300)
        	}
        });

		this.keydown(function (e) {
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 187,109]) !== -1 ||
                (e.keyCode == 65 && e.ctrlKey === true) ||
                (e.keyCode >= 35 && e.keyCode <= 39)) {
                     return;
            }
            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                e.preventDefault();
            }
        });

		function valiCheck( date ){
			var dateRegEx = /^\d{4}-\d{2}-\d{2}$/;
			if(!dateRegEx.test(date)) {
        		_this.datepicker("setDate", "");
        		return;
        	} else if(date == beforeDate) {
            	return;
            } else {
        		_this.datepicker("setDate", date);
        	}
			
			if(date != "") {
                var selectedDate = new Date(date);
                if (isNaN(selectedDate) == true && date != "") {
                    _this.datepicker("setDate", beforeDate);
                    return;
                }
                
                for (var i = 0; i < _this.opt.minDataArr.length; i++) {
                    if (_this.getDate(_this.opt.minDataArr[i]) > selectedDate.getTime()) {
                        alert(_this.opt.minTxt);
                        _this.datepicker("setDate", beforeDate);
                        if (document.activeElement != document.body) document.activeElement.blur();
                        return;
                    }
                }
                
                for (var i = 0; i < _this.opt.maxDateArr.length; i++) {
                    if (_this.getDate(_this.opt.maxDateArr[i]) < selectedDate.getTime()) {
                        alert(_this.opt.maxTxt);
                        _this.datepicker("setDate", beforeDate);
                        if (document.activeElement != document.body) document.activeElement.blur();
                        return;
                    }
                }
                
                if(_this.opt.changeYear) {
                	var yearRangeArr = _this.opt.yearRange.split(':');
                	
                	if(date.substr(0,4) < yearRangeArr[0] || date.substr(0,4) > yearRangeArr[1]) {
                		_this.datepicker("setDate", beforeDate);
                        return;
                	}
                }
			}
			
			beforeDate = date;

			if( _this.opt.onSelect != null ) _this.opt.onSelect( beforeOrignDate );

			beforeOrignDate = date;
		}
	};

	this.optionSetting = function(){
		var thisYear = new Date().getFullYear() + 70;
		
		if(this.opt.changeYear) {
			if(!this.opt.yearRange) {
				this.opt.yearRange = '1940:' + thisYear;
			}
			
			$(this).datepicker('option', {
				'changeYear': true,
				'yearRange' : this.opt.yearRange
			});
		}
		
		if(this.opt.changeMonth) {
			$(this).datepicker('option', {
				'changeMonth': true
			});
		}
		
		// Remove jQuery UI datepicker KeyDown Event
		this.unbind('keydown');
		this.keydown(function(e) {
			
			if(e.keyCode === 13) {
				$(this).trigger('blur');
			}
			
		});
	};

	this.getDate = function( date ){
		if( date == null ) return;

		if(typeof date === "object") {
        	day = date.val();
        }  else {
        	if (date == 'today') {
                day = new Date().getFullYear() + '-' + (new Date().getMonth() + 1) + '-' + new Date().getDate();
            } else {
                day = date;
            }
        }
		
		return new Date( day ).getTime();
	};

	this.init();

	return this;
};
$.fn.ifvMonthChecker = function (options) {

	this.opt = $.extend({
		minMonth: null,
		maxMonth: null,
		minTxt: MESSAGE.common.minDateTxt,
		maxTxt: MESSAGE.common.maxDateTxt,
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		dateFormat: 'yy-mm',
		yearSuffix: '',
		onClose: function (dateText, inst) {
			if (typeof inst.settings.minMonth != 'undefined') {
				var mmo = inst.settings.minMonth.val();
				var year = mmo.substr(0, 4);
				var month = mmo.indexOf('-') != -1 ? Number(mmo.substr(5, 2)) - 1 : Number(mmo.substr(4, 2)) - 1;
				var mmval = new Date(Number(year), Number(month), 1).getTime();
				var nval = new Date(inst.selectedYear, inst.selectedMonth, 1).getTime();
				if (mmval > nval) {
					alert(MESSAGE.common.minDateTxt);
					var lv = inst.lastVal;
					var lyear = lv.substr(0, 4);
					var lmonth = lv.indexOf('-') != -1 ? Number(lv.substr(5, 2)) - 1 : Number(lv.substr(4, 2)) - 1;
					$(this).datepicker('setDate', new Date(Number(lyear), Number(lmonth), 1));
				} else {
					$(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1));
				}
			} else if (typeof inst.settings.maxMonth != 'undefined') {
				var mmo = inst.settings.maxMonth.val();
				var year = mmo.substr(0, 4);
				var month = mmo.indexOf('-') != -1 ? Number(mmo.substr(5, 2)) - 1 : Number(mmo.substr(4, 2)) - 1;
				var mmval = new Date(Number(year), Number(month), 1).getTime();
				var nval = new Date(inst.selectedYear, inst.selectedMonth, 1).getTime();
				if (mmval < nval) {
					alert(MESSAGE.common.maxDateTxt);
					var lv = inst.lastVal;
					var lyear = lv.substr(0, 4);
					var lmonth = lv.indexOf('-') != -1 ? Number(lv.substr(5, 2)) - 1 : Number(lv.substr(4, 2)) - 1;
					$(this).datepicker('setDate', new Date(Number(lyear), Number(lmonth), 1));
				} else {
					$(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1));
				}
			} else {
				$(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1));
			}
			$(".ui-datepicker-calendar").hide();
		},
		beforeShow: function (input, inst) {
			var datestr;
			if ((datestr = $(this).val()).length > 0) {
				var year = datestr.substr(0, 4);
				var month = datestr.indexOf('-') != -1 ? Number(datestr.substr(5, 2)) - 1 : Number(datestr.substr(4, 2)) - 1;
				$(this).datepicker('option', 'defaultDate', new Date(year, month, 1));
				$(this).datepicker('setDate', new Date(year, month, 1));
			}
		}
	}, options);

	this.init = function () {
		this.eventSetting();

	};

	this.focus(function () {
		setTimeout(function () {
			$(".ui-datepicker-calendar").hide();
		}, 50)

	})

	this.eventSetting = function () {
		var dataDateFormat = this.opt.dateFormat || 'yy-mm';

		var _this = this;

		var beforeDate = null;
		beforeDate = this.val();

		var beforeOrignDate = beforeDate;

		var lenguageObj = $.datepicker.regional[lang];
		lenguageObj.dateFormat = dataDateFormat;

		lenguageObj.prevText = '';
		lenguageObj.nextText = '';

		lenguageObj.changeMonth = _this.opt.changeMonth;
		lenguageObj.changeYear = _this.opt.changeYear;
		lenguageObj.showButtonPanel = _this.opt.showButtonPanel;
		lenguageObj.onClose = _this.opt.onClose;
		lenguageObj.beforeShow = _this.opt.beforeShow;

		if (_this.opt.minMonth != null)
			lenguageObj.minMonth = _this.opt.minMonth;

		if (_this.opt.maxMonth != null)
			lenguageObj.maxMonth = _this.opt.maxMonth;

		this.datepicker(lenguageObj);

		this.keydown(function (e) {
			if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 187, 109]) !== -1 ||
				(e.keyCode == 65 && e.ctrlKey === true) ||
				(e.keyCode >= 35 && e.keyCode <= 39)) {
				return;
			}
			if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
				e.preventDefault();
			}
		});
	};

	this.init();

	return this;
};
//미사용
$.fn.onlyCharacter = function () {

	var _this = this;
	this.keyup(function () {
		_this.replce();
	});

	this.blur(function () {
		_this.replce();
	});

	this.replce = function () {
		var numPattern = /([^가-힣ㄱ-ㅎㅏ-ㅣA-za-z^\s])/g;

		var str = _this.val().replace(numPattern, '');

		var numPattern2 = /([\^\_\\])/g;

		str = str.replace(numPattern2, '');

		_this.val(str);
	};
};
//미사용
$.fn.onlyPercent = function () {

	var _this = this;

	this.onlyNumber(null, 5);

	this.blur(function () {
		_this.replace();
	});

	this.replace = function () {

		var val = _this.val();

		if (!isNaN(val)) {

			val = val.replace(/(^0+)/, "");

			if (val > 100) {
				_this.val("100");
			} else if (val < 0) {
				_this.val("0");
			} else {
				val = Math.round(val * 100) / 100;
				_this.val(val);
			}
		} else {
			_this.val("0");
		}
	}
};
//미사용
$.fn.ifvCheckSubmitDataChange = function (submitCheckArr) {

	this.submitCheckArr1 = submitCheckArr;
	this.submitCheckArr2 = [];

	this.init = function () {
		submitCheckArr2 = this.getSubmitData();

		if (JSON.stringify(this.submitCheckArr1) == JSON.stringify(submitCheckArr2))
			return true;
		else
			return false;
	}

	return this.init();
};
//미사용
$.fn.ifvMinusArray = function (arg) {
	var what, L = arg.length, ax;
	while (L && this.length) {
		what = arg[--L];
		while ((ax = this.lastIndex(what)) != -1) {
			this.splice(ax, 1);
		}
	}
	return this;
};
//미사용
$.getURLParam = function (strParamName) {

	var strReturn = "";
	var strHref = window.location.href;
	var bFound = false;

	var cmpstring = strParamName + "=";
	var cmplen = cmpstring.length;

	if (strHref.indexOf("?") > -1) {

		var strQueryString = strHref.substr(strHref.indexOf("?") + 1);
		var aQueryString = strQueryString.split("&");

		for (var iParam = 0; iParam < aQueryString.length; iParam++) {
			if (aQueryString[iParam].substr(0, cmplen) == cmpstring) {
				var aParam = aQueryString[iParam].split("=");
				strReturn = aParam[1];
				bFound = true;
				break;
			}
		}
	}

	if (bFound == false)
		return null;

	return strReturn;
};
//미사용
$.fn.onBtn = function () {
	this.attr('src', this.attr('src').replace('off', 'on'));
};
//미사용
$.fn.offBtn = function () {
	this.attr('src', this.attr('src').replace('on', 'off'));
};
//미사용
$.fn.allDisabled = function (exclusionArr) {
	var inputArr = this.find('input, textarea, a');

	for (var i = 0; i < inputArr.length; i++) {
		if (exclusionArr == null || exclusionArr.indexOf(inputArr[i].id) < 0) {
			if (inputArr[i].tagName == "A") {
				$(inputArr[i]).hide();
			} else {
				if (inputArr[i].type == "radio" || inputArr[i].type == "checkbox") {
					inputArr[i].setAttribute('disabled', true);
				} else {
					inputArr[i].setAttribute('readonly', true);
				}
			}

		}
	}
};
if( typeof ifv == "undefined" ) var ifv = new Object();

//글로벌 변수 담는 객체
var ifvGlobal = {};	

ifv.Lib = function(){
    this.VS=1.0;
};

ifv.Lib.prototype =
{
    overrideObject : function (defaultObj,updateObj)
    {
        
        if (updateObj == null)
        {
            return defaultObj;
        }
        
        for (var key in updateObj)
        {
            defaultObj[key] = updateObj[key];
        }
        return defaultObj;
    },
    
    updateObject : function (defaultObj,updateObj)
    {
            if (updateObj == null)
            {
                return defaultObj;
            }
            for (var key in defaultObj)
            {
                if (updateObj[key] == undefined)
                {
                    updateObj[key] = defaultObj[key];
                }
            }
            return updateObj;
    },
    
    indexSetting : function(result){
        if( result == null ) return;
        for( var i = 0; i<result.length; i++ ){
            result[i].index = i;
        }
    },
    
    closeFullScreenPopup : function(){
        ifvGlobal.popupComponetNum--;
        $( '#popupFullScreen' + ifvGlobal.popupComponetNum ).remove();
        if( ifvGlobal.popupComponetNum == 0 ){
            $('body')[0].style.overflow = 'auto';
        }
    },
    
    closeFullScreenAllPopup : function(){
        for( var i= 0; i<ifvGlobal.popupComponetNum; i++ ){
            $.closeFullScreenPopup();
        }
    },
    
    fullScreenPopRelocation : function(){
        currentPopupComponent.rePosition();
    }
};

ifv.commonMessage = {
    search : '검색',
    noData : '데이타가 없습니다.',
    gun : '건',
    total : '전체',
    select : '선택',
    ok : '확인',
    cancel : '취소',
    minDateTxt : '기준일 이전입니다.',
    maxDateTxt : '기준일 이후입니다.',
    yes : '예',
    no : '아니오'
};

ifv.Console = function() {};
ifv.Console.prototype.setText = function(str){
    
    if( this.view == null ){
        this.view = document.createElement('div');
        this.view.style.position = 'fixed';
        this.view.style.zIndex = '30000000000000';
        this.view.style.left='0px';
        this.view.style.top='0px';
        this.view.style.width='300px';
        this.view.style.height='300px';
        this.view.style.overflow='auto';
        this.view.style.background='#ffffff';
        document.body.appendChild( this.view );
    }
    this.view.innerHTML = this.view.innerHTML + '<br/>' + str; 
};
ifv.Console.prototype.view = null;


ifv.lib = new ifv.Lib();
ifv.console = new ifv.Console();

String.prototype.trim = function() {
    return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
};

String.prototype.replaceAll = function(searchStr, replaceStr) {
    return this.split(searchStr).join(replaceStr);
};

Array.prototype.remove = function(idx) {
    return (idx<0 || idx>this.length) ? this : this.slice(0, idx).concat(this.slice(idx+1, this.length));
};

Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};


if (!Array.prototype.indexOf)
{
  Array.prototype.indexOf = function(elt /*, from*/)
  {
    var len = this.length >>> 0;

    var from = Number(arguments[1]) || 0;
    from = (from < 0)
         ? Math.ceil(from)
         : Math.floor(from);
    if (from < 0)
      from += len;

    for (; from < len; from++)
    {
      if (from in this &&
          this[from] === elt)
        return from;
    }
    return -1;
  };
}

if(!Array.sortOn){
    Array.prototype.sortOn = function($key){
    	var dup = this.slice();
		if(!arguments.length) return dup.sort();
		var args = Array.prototype.slice.call(arguments);
		return dup.sort(function(a,b){
			var props = args.slice();
			var prop = props.shift();
			while(a[prop] == b[prop] && props.length) prop = props.shift();
			return a[prop] == b[prop] ? 0 : a[prop] > b[prop] ? 1 : -1;
		});
    };
};

if (!Object.create) {
    Object.create = (function(){
        function F(){}

        return function(o){
            if (arguments.length != 1) {
                throw new Error('Object.create implementation only accepts one parameter.');
            }
            F.prototype = o;
            return new F();
        };
    })();
};





(function($){
	
	/*
	 * 
	 * ifvScrollPaging
	 * 
	 */
	$.fn.ifvScrollPaging = function(options){
		var _this = this;
		_this = $.extend({
			dataObj : {},
			container : null,
			isEnd : false,
			resultFunc : null,
			url : null,
			scope : null,
			active : true,
			isLoading : false,
			tempId : null
		}, options);
		
		
		this.init = function(url){

			_this.dataObj.lastCreateDate = null;
			_this.dataObj.filterKey = null;
			_this.dataObj.filterValue = null;

			_this.isEnd = false;
			if( url != null ) _this.url = url;
			
			this.requestData();
		};
		
		
		this.scrollSetting = function(){
			var that = this;
			
			
			this.scroll(function(){
				
				if( _this.isEnd == false && _this.active == true ){
					
					if( that[0] == window ){
						if( $(window).scrollTop() == $(document).height() - $(window).height()) {
							//that.requestData({pageIndex : _this.dataObj.pageIndex + 1});
							that.requestData();
					    }
						
						/*ifv.console.setText( "scrollTop : " + $(window).scrollTop() );
						ifv.console.setText( "height : " + $(document).height() );
						ifv.console.setText( "w height : " + $(window).height() );*/
						
					}else{
						if( that.scrollTop() + that[0].offsetHeight >= that[0].scrollHeight - 100 ){
							//that.requestData({pageIndex : _this.dataObj.pageIndex + 1});
							that.requestData();
						};
						
						/*ifv.console.setText( "scrollTop : " + that.scrollTop() );
						ifv.console.setText( "offsetHeight : " + that[0].offsetHeight );
						ifv.console.setText( "scrollHeight : " + that[0].scrollHeight );*/
					}
				}
			});
		};
		
		this.requestData = function( obj ){
			$.extend(_this.dataObj, obj);
			//ifv.lib.overrideObject( _this.dataObj, obj );
			this.request();
		};
		
		this.request = function(){

			var that = this;
			if( _this.isLoading == false ){
				_this.isLoading = true;

				this.btnProgressSetting();
				$.ifvPostJSON(_this.url, _this.dataObj, function(result){
					if(_this.progress != null)
						_this.progress.remove();
		            
					$.ifvRemoveRequestBtn(_this.btn);

					that.pageDataSetting(result);
					that.addData(result);
					if(result.remainCount < 1) _this.isEnd = true;
					_this.isLoading = false;
					if( _this.resultFunc != null ) _this.resultFunc.call(_this.scope, result);
				});
			};
		};
		
		this.addData = function(result){
			var arr = result.rows;
			
			for( var i=0; i<arr.length; i++ ){
				this.append( $.ifvSupplant( $("#" + _this.tempId).text(), arr[i] ));
			}
		};

		this.pageDataSetting = function(result){

			_this.dataObj.lastCreateDate = result.lastCreateDate;
			_this.dataObj.filterKey = result.filterKey;
			_this.dataObj.filterValue = result.filterValue;
			_this.dataObj.orderBy = result.orderBy;
			_this.dataObj.createDateColumn = result.createDateColumn;

			/*if( result.pageSize == result.pageIndex ){
				_this.isEnd = true;
			}
			_this.dataObj.pageIndex = result.pageIndex;*/
			
		};
		
		this.btnProgressSetting = function(){
			
		};
		
		this.active = function(){
			_this.active = true;
		};
		
		this.deactive = function(){
			_this.active = false;
		};
		
		this.remove = function(){
			this.empty();
		};
		
		this.init();
		this.scrollSetting();
		
		return this;
	};
	
	
	
	
	
	
	
	
	/*
	 * pageing
	 */
	$.fn.ifvPagingNavi = function(options){
		var _this = this;

		_this = $.extend({
			length : null,
			showNum : 5,
			lastNum : null,
			currentNum : 0,
			numItemArr : null,
			wrap : null,
			con : null,
			itemWidth : 31,
			firstBtn : null,
			prevBtn : null,
			nextBtn : null,
			endBtn : null,
			moveNum : null,
			callback : null,
			url : null,
			dataObj : {},
			isLoading : false,
			scope:null,
			btn:null,
			progress:null,
			resultFunc : null,
			isMake : false

		}, options);
		
		this.defaultSetting = function(){
			var obj = {
				page : 1,
				rows : 10,
				searchType : '',
				searchWord : '',
				sidx : '',
				sord : ''
			};
			$.extend(_this.dataObj, obj );
		};

		this.init = function(){
			_this.currentNum = 0;
			_this.dataObj.page = 1;
			_this.dataObj.rows = 10;
			this.changeOn(0);
		};

		this.makePage = function(){
			
			_this.isMake = true;

			this.addClass('page_navi');

			this.makePrevBtn();

			_this.wrap = document.createElement('div');
			_this.wrap.className = "page_wrap";
			
			var lN = _this.showNum;
			if( lN > _this.length ) lN = _this.length;
			var tww = lN * _this.itemWidth;
			if( tww < 0 ) tww = 0;
			_this.wrap.style.width = tww + "px";
			this.append(_this.wrap);

			_this.con = document.createElement('div');
			_this.con.className = "con";
			_this.con.style.width = ( _this.length * ( _this.itemWidth + 1) ) + "px";
			_this.wrap.appendChild(_this.con);

			_this.numItemArr = [];
			for( var i = 0; i < _this.length; i++ ){
				var num = i;
				var a = document.createElement('a');
				a.href='javascript:;';
				a.innerHTML = String(num + 1);
				if( _this.currentNum == num ){
					a.className = 'on';
				}
				this.eventSetting(a, num);
				_this.con.appendChild(a);
				_this.numItemArr.push(a);
			}

			
			this.makeNextBtn();

			
			_this.lastNum = _this.length - _this.showNum;
			if( _this.lastNum < 0 ) _this.lastNum = 0;
			_this.moveNum = 0;

			this.btnCheck();
		};

		this.moveCon = function(){
			this.changeOn(_this.currentNum);
			var tml = -(_this.moveNum * (_this.itemWidth ));
			_this.con.style.marginLeft = tml + "px";
			
			_this.dataObj.page = _this.currentNum+1;
			this.request();
				
			
		};
		
		this.btnCheck = function(){
			if( _this.currentNum == 0 ){
				
				$(_this.firstBtn).addClass('disabled');
				$(_this.prevBtn).addClass('disabled');
			}else{
				$(_this.firstBtn).removeClass('disabled');
				$(_this.prevBtn).removeClass('disabled');
			}
			
			if( _this.currentNum == _this.length - 1 ){
				
				$(_this.nextBtn).addClass('disabled');
				$(_this.endBtn).addClass('disabled');
			}else{
				$(_this.nextBtn).removeClass('disabled');
				$(_this.endBtn).removeClass('disabled');
			}
		};


		this.makePrevBtn = function(){
			_this.firstBtn = this.makeBtn("&lt;&lt;", '처음페이지로 이동', "처음");
			_this.prevBtn = this.makeBtn("&lt;", '이전페이지로 이동', "이전");


			var that = this;
			$(_this.firstBtn).click(function(){
				_this.moveNum = 0;
				_this.currentNum = 0;
				that.moveCon();
			});

			$(_this.prevBtn).click(function(){
								
				if( _this.currentNum > 0 ){
					_this.currentNum--;
					var cMinN = _this.moveNum;
					if( cMinN > _this.currentNum ) _this.moveNum--;
					that.moveCon();
				}
				
			});
		};

		this.makeNextBtn = function(){
			_this.nextBtn = this.makeBtn("&gt;", '다음페이지로 이동', "다음");
			_this.endBtn = this.makeBtn("&gt;&gt;", '마지막페이지로 이동', "마지막");
			
			$(_this.nextBtn).addClass('nll');
			$(_this.endBtn).addClass('rl');

			var that = this;
			$(_this.nextBtn).click(function(){
			
				if( _this.currentNum < _this.length - 1 ){
					_this.currentNum++;
					
					var cMaxN = _this.moveNum + _this.showNum - 1;
					if( cMaxN < _this.currentNum ) _this.moveNum++;
					that.moveCon();
				}
				
			});

			$(_this.endBtn).click(function(){
				_this.moveNum = _this.lastNum;
				_this.currentNum = _this.length - 1;
				that.moveCon();
			});
		};

		this.makeBtn = function(txt, alt, title){
			var a = document.createElement('a');
			a.href='javascript:;';
			a.innerHTML = txt;

			this.append(a);

			return a;
		};

		this.eventSetting = function( a, i ){
			var that = this;
			$(a).click(function(){

				_this.dataObj.page = i+1;
				_this.currentNum = i;
				that.changeOn(i);
				if( _this.url != null ){
					that.request();
				}else{
					_this.callback(i+1);
				}
			});
		};
		
		this.setData = function( obj ){
			$.extend(_this.dataObj, obj)
		};

		this.requestData = function( obj ){
			$.extend(_this.dataObj, obj);
			_this.isMake = false;
			this.html('');
			_this.dataObj.page = 1;
			_this.moveNum = 0;
			this.changeOn(0);
			if( _this.con != null ) _this.con.style.marginLeft = 0;
			this.request();
		};

		this.request = function(){
			var that = this;
			if( _this.isLoading == false ){
				_this.isLoading = true;
				this.btnProgressSetting();

				

				/*//test
				var result = {};
				result.total = 10;
				result.rows = 10;
				result.tableList = []
				result.tableList[0] = {no: 0};
				result.tableList[1] = {no: 1};
				result.tableList[2] = {no: 2};
				result.tableList[3] = {no: 1};

				that.pageDataSetting(result);
				_this.isLoading = false;
				if( _this.progress != null ) _this.progress.remove();
			    $.ifvRemoveRequestBtn(_this.btn);

				_this.resultFunc.call(_this.scope, result);
				return;*/
				
				$.ifvPostJSON(_this.url, _this.dataObj, function(result){
					
					if( _this.btn != null ){
						if( _this.progress != null ) _this.progress.remove();
			            $.ifvRemoveRequestBtn(_this.btn);
					}
					
					that.pageDataSetting(result);
					_this.isLoading = false;
					if( result.okFl == "E" ){
						alert( result.message );
					}else{
						_this.resultFunc.call(_this.scope, result);
					}
				});
			}
		};

		this.pageDataSetting = function( obj ){
			
			_this.length = obj.total;
			if( obj.rows == 0 ) obj.rows = 10;
			
			//_this.length = 100;
			
			if( _this.isMake == false ) this.makePage();
			
		};

		this.btnProgressSetting = function(){
			if( _this.btn == null || $.ifvRequestBtnSearch(_this.btn) > -1 ) return;

	        $.ifvAddRequestBtn(_this.btn);
	        var _btn = $(_this.btn);

	        _btn.css({'position': 'relative' });
	        _this.progress = $(document.createElement('div'));
	        _this.progress.addClass('progressRoll');
	        _this.progress.height(_btn[0].clientHeight);
	        _this.progress.width(_btn[0].clientWidth);

	        var table_cell = document.createElement('div');
	        $(table_cell).addClass('table_cell');

	        var img = document.createElement('img');
	        img.src = "./resources/images/loading.gif";

	        _this.progress.append(table_cell);
	        $(table_cell).append(img);

	        _btn.append(_this.progress[0]);
		};

		this.changeOn = function( n ){
			if( _this.numItemArr == null ) return;
			for( var i = 0; i<_this.numItemArr.length; i++ ){
				if( n == i ){
					_this.numItemArr[i].className = "on";
				}else{
					_this.numItemArr[i].className = "";
				}
			}
			
			this.btnCheck();
		};

		this.defaultSetting();

		return this;
	};
	
	
})(jQuery);
(function($){
	/*
	 * ifvSimplePager
	 */
	$.fn.ifvSimplePager = function(options){

		this.pageCon = null;
		this.currentNum = 1;
		this.totalNum = 1;
		
		this.opt = $.extend({
			url : null,
			dataObj : { page : 1, rows : 10, sidx: '', sord : 'DESC', searchType : '', searchWord : '', nd : '', searchText : '' },
			size : 5,
			maxSizeNum : 0,
			tempId : null,
			containerId : null,
			container : null,
			templete : null,
			complete : null,
			callback : null,
			func : {}
		}, options );
		
		this.init = function(){
			
			$.extend( this.opt.dataObj, {sidx : this.opt.sidx, sord : this.opt.sord } );
			
			this.opt.templete = $( "#" + this.opt.tempId );
			this.opt.container = $( "#" + this.opt.containerId );
			
			this.addClass('ifv_simple_pager');
			this.pageCon = $("<ul>");
			
			this.leftArea = $("<li>");
			this.numArea = $("<li>");
			this.rightArea = $("<li>");
			
			this.pageCon.append( this.leftArea );
			this.pageCon.append( this.numArea );
			this.pageCon.append( this.rightArea );
			
			this.makeLeft();
			this.makeRight();
			
			this.append( this.pageCon );
			if( this.opt.url != null ){
				this.requestData();
			}
		};
		
		
		this.makeLeft = function(data){
			this.firstBtn = $("<a href='javascript:;' class='first_btn'>");
			this.prevBtn = $("<a href='javascript:;' class='prev_btn'>");
			/*this.firstBtn.text('<<');
			this.prevBtn.text('<');*/
			
			this.leftArea.append( this.firstBtn );
			this.leftArea.append( this.prevBtn );
			
			
		};
		
		this.makeRight = function(data){
			this.lastBtn = $("<a href='javascript:;' class='last_btn'>");
			this.nextBtn = $("<a href='javascript:;' class='next_btn'>");
			/*this.nextBtn.text('>');
			this.lastBtn.text('>>');*/
			
			this.rightArea.append( this.nextBtn );
			this.rightArea.append( this.lastBtn );
		};
		

		this.change = function(data){
			if( data.records == null ) data.records = this.opt.records;
			this.opt.records = data.records;
			this.opt.maxSizeNum = Math.ceil( data.records / this.opt.dataObj.rows );
			this.currentNum = data.page;
			
			this.numArea.empty();
			
			var startNum = Math.floor( (data.page -1) / this.opt.size ) * this.opt.size + 1;
			var max = Math.ceil( data.records / this.opt.dataObj.rows ) + 1;
			var lenth = startNum + this.opt.size;
			if( lenth > max ) lenth = max;
			if( lenth == 1 ) lenth = 2;
			for( var i = startNum; i < lenth; i++ ){
				var num = $("<a href='javascript:;'>");
				num.text(i);
				if( data.page == i ){
					num.addClass('on');
				}
				this.numArea.append(num);
				
				var _this = this;
				(function(n){
					num.click(function(){
						_this.currentNum = n; 
						_this.moveClick(n);
					});
				})(i);
			}
			
			this.btnCheck(data);
		};
		
		this.moveClick = function( n ){
			if( this.opt.url != null ){
				this.requestData({ page:n });
			}else{
				this.change({ page:n, records : this.opt.records });
				this.opt.callback(n);
			};
		};
		
		this.requestData = function( data ){
			$.extend( this.opt.dataObj, data );

			var _this = this;
			$.ifvPostJSON(_this.opt.url, this.opt.dataObj, function(result){
				
				_this.dataSetting(result);
				_this.change({ page : result.page, records : result.records });
				if( _this.opt.complete != null ) _this.opt.complete( result );
			});
		};
		
		this.dataSetting = function( result ){
			this.opt.container.html('');
			var list = this.opt.templete.tmpl( result.rows, this.opt.func );
			this.opt.container.append( list );
		};
		
		this.btnCheck = function(data){
			
			var _this = this;
			
			this.firstBtn.unbind();
			this.prevBtn.unbind();
			this.nextBtn.unbind();
			this.lastBtn.unbind();
			if( data.page == 1 ){
				this.firstBtn.addClass('disabled');
				this.prevBtn.addClass('disabled');
				
			}else{
				this.firstBtn.removeClass('disabled');
				this.prevBtn.removeClass('disabled');
				
				this.firstBtn.click(function(){
					_this.moveClick(1);
				});
				this.prevBtn.click(function(){
					var n = _this.currentNum-1;
					if( n < 1 ) n = 1;
					_this.moveClick( n );
				});
			}
			if( data.page >= _this.opt.maxSizeNum ){
				this.nextBtn.addClass('disabled');
				this.lastBtn.addClass('disabled');
			}else{
				this.nextBtn.removeClass('disabled');
				this.lastBtn.removeClass('disabled');
				
				this.nextBtn.click(function(){
					var n = _this.currentNum+1;
					if( n > _this.opt.maxSizeNum ) n = data.size;
					_this.moveClick( n );
				});
				this.lastBtn.click(function(){
					_this.moveClick( _this.opt.maxSizeNum );
				});
			}
		};

		this.init();
		
		return this;
	};
	
	
})(jQuery);
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

				var trimCheck = txt;
				var requiredInputData = null;

				if(trimCheck != null && trimCheck != ''){
					checkDoneData = trimCheck.trim();
				} else {
					checkDoneData = trimCheck;
				}

				if( checkDoneData == '' ){
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


ifv.isConfirm = false; //얼럿창 중복안뜨게 하기 위한 플레그
ifv.popNum = 0;
ifv.cPop = null;
ifvPopup = function(){};
ifvPopup.prototype = {
	closeFullScreenPopup : function(obj){
		ifv.popNum--;
		if( ifv.popNum < 0 ) {
			ifv.popNum = 0;
			return;
		}
		var modal = ifv.popup.modalPopArr[ifv.popNum];
		if( modal == null ) return;
		modal.remove();
		if( modal.close != null ) modal.close.call( modal.scope, obj );
		
		ifv.popup.modalPopArr.splice( ifv.popNum, 1 );
		
	    //$( '#ifvPopupFullScreen' + ifv.popNum ).remove();
	    if( ifv.popNum == 0 ){
	        $('body')[0].style.overflow = 'auto';
	    }
	},

	closeFullScreenAllPopup : function(){
	    for( var i= 0; i<ifv.popNum; i++ ){
	        this.closeFullScreenPopup();
	    }
	},

	fullScreenPopRelocation : function(){
		ifv.cPop.rePosition();
	},
	
	modalPopArr : []
};
ifv.popup = new ifvPopup();

ifvPopupFullscreen = function(obj){
	//brower 분기(ie에서 activeElement.blur() 오류 수정)
	var uua = navigator.userAgent;
	var napn = navigator.appName; 
	var nua = uua.toLowerCase();
	//ie 11버전은 msie 텍스트를 갖고 있지 않으므로 Appname과 Trident로 구분
	if ( (napn == 'Netscape' && uua.search('Trident') != -1) || (nua.indexOf("msie") != -1)) {
		if ( document.activeElement && document.activeElement.nodeName.toLowerCase() !== "body" ) {
	        document.body.focus();
		}
	} else {
		if (document.activeElement != document.body) document.activeElement.blur();
	}
	this.bg = $("<div class='dark_alpha_pop'>");
	this.bg.attr('id', 'ifvPopupFullScreen' + ifv.popNum );
	
	this.bg.close = obj.close; 	//팝업닫을때 close func 호출하기 위해 객체에 저장
	this.bg.scope = obj.scope; 	//팝업닫을때 close func 호출하기 위해 객체에 저장
	ifv.popup.modalPopArr.push(this.bg);
	
	//변수 초기화
	if( obj.valign != null ) this.valign = obj.valign;
	if( obj.tGap != null ) this.tGap = obj.tGap;
	
	this.init( obj );
};

ifvPopupFullscreen.prototype = {
	bg : null,
	closeBtn : null,
	contentCon : null,
	valign : 'middle', 
	tGap : 30,
};

ifvPopupFullscreen.prototype.init = function( obj ){
	
	$('body').append(this.bg);
	$('body').css( 'overflow', 'hidden' );
	
	this.contentCon = $("<div class='ifv_content_con'>");
	this.contentCon.append( obj.content );
	this.bg.append( this.contentCon );
	
	this.closeBtn = $("<a href='javascript:;' class='btn_close'>");
	this.contentCon.children().append( this.closeBtn );

	this.eventSetting();
	this.rePosition();

	ifv.popNum++;
};

ifvPopupFullscreen.prototype.eventSetting = function(){

	var _this = this;
	$(window).resize( function(e){
		_this.rePosition();
	});

	this.closeBtn.click( function(e){
		ifv.popup.closeFullScreenPopup();
	});

	$(document).one('keydown', function(e){
		if(event.keyCode == 27) {
			ifv.popup.closeFullScreenPopup();
	    }
	});
};

ifvPopupFullscreen.prototype.rePosition = function(){
	var fullHeight = $(window).height();
	
	this.bg.height( fullHeight );
	
	var pos = this.getTarPos(fullHeight);
	
	this.contentCon.css('marginTop', ( pos.tarTop ) + 'px' );
	
	this.bg.css('paddingBottom', pos.bottomGap + 'px' );
};

ifvPopupFullscreen.prototype.getTarPos = function(fullHeight){
	
	var bottomGap = 0;
	if( this.contentCon.height() > fullHeight ){
		bottomGap = 50;
	};
	var tarTop = 0;
	switch( this.valign ){
		case 'top' :
			tarTop = this.tGap;
			break;
			
		case 'middle' :
			tarTop = fullHeight/2 - this.contentCon.height()/2;
			if( tarTop < this.tGap ) tarTop = this.tGap;
			break;
	};
	
	return {
		bottomGap : bottomGap,
		tarTop : tarTop
	};
};


/*
 * BasePopup
 */
BasePopup = function(){
	$.ifvLoadEndPop( this.init );
	
};

BasePopup.prototype.init = function(data){
	
};

BasePopup.prototype.close = function(){
    ifv.popup.closeFullScreenPopup();
};

BasePopup.prototype.reload = function(){
    window.location.reload();
};

BasePopup.prototype.reLocation = function(){
    ifv.popup.fullScreenPopRelocation();
};




/*
 * ifvConfirm 
 */
ifvConfirm = function( obj ){

	if( ifv.isConfirm == true ){
		return;
	}
	ifv.isConfirm = true;
	
	this.uiSetting();
	
	if( obj.btnTxt1 != null ) this.btnTxt1 = obj.btnTxt1;
	if( obj.btnTxt2 != null ) this.btnTxt2 = obj.btnTxt2;
	
	this.toastPop = this.item.find('#toastPop');
	if( this.toastPop == null || this.toastPop.length == 0 ) return;
	
	this.txtArea = this.item.find('.txt_area');
	this.txtArea.html(obj.text);
	
	this.toastPop.addClass('toast_pop_fail');
	this.closeFunc = obj.closeFunc;
	
	$('body').append( this.item );
	
	this.rePosition();
	var _this = this;
	
	this.btn1 = this.item.find('.btn1');
	this.btn1.text(this.btnTxt1);
	this.btn1.click(function(){
		_this.remove();
		$('body').css({'overflow':''});
		if( obj.closeFunc != null ) obj.closeFunc(1);
		return false;
	});
	
	this.btn2 = this.item.find('.btn2');
	this.btn2.text(this.btnTxt2);
	this.btn2.click(function(){
		_this.remove();
		return false;
	});
	
	if( this.btnTxt1 == false ){
		this.btn1 = this.item.find('.btn1');
		this.btn1.css("display","none");
	}
	if( this.btnTxt2 == false ){
		this.btn2 = this.item.find('.btn2');
		this.btn2.css("display","none");
	}
	
	if( this.btnTxt1 == false && this.btnTxt2 == false ){
		this.item.find('.btn_area').css("display","none");
	}
	
	if( obj.img == null ){
		this.item.find('.img_area').css("display","none");
	}else{
		this.imgArea = this.item.find('.img_area').find('img');
		this.imgArea.attr('src', obj.img );
	}
		
	/*ik.lib.addEventListener( window, 'resize', function(e){
		_this.rePosition();
	});*/
};

ifvConfirm.prototype = {
	item : null,
	closeFunc : null,
	btnTxt : null,
	btnTxt1 : ifv.commonMessage.ok,
	btnTxt2 : ifv.commonMessage.cancel
};

ifvConfirm.prototype.uiSetting = function(){
	var html = $("#ifvConfirmTemplete").text();
	//brower 분기(ie에서 activeElement.blur() 오류 수정)
	var uua = navigator.userAgent;
	var napn = navigator.appName; 
	var nua = uua.toLowerCase();
	//ie 11버전은 msie 텍스트를 갖고 있지 않으므로 Appname과 Trident로 구분
	if ( (napn == 'Netscape' && uua.search('Trident') != -1) || (nua.indexOf("msie") != -1)) {
		if ( document.activeElement && document.activeElement.nodeName.toLowerCase() !== "body" ) {
	        document.body.focus();
		}
	} else {
		if (document.activeElement != document.body) document.activeElement.blur();
	}
	
	html = html.replace('{txt_area}', "<div class='txt_area'></div>");
	html = html.replace('{img_area}', "<div class='img_area'><img src='' /></div>");
	html = html.replace('{btn1}', "<a href='javascript:;' class='btn1 btn_style'></a>");
	html = html.replace('{btn2}', "<a href='javascript:;' class='btn2 btn_style'></a>");
	
	this.item = $(html);
};

ifvConfirm.prototype.rePosition = function(){
	
	if( this.toastPop == null || this.toastPop.length == 0 ) return;
	
	//this.item.css( 'top', $('body').scrollTop() );
	
	var fullHeight = $(window).height();
	var fullWidth = document.body.clientWidth;
	var tarTop = fullHeight/2 - this.toastPop.height()/2;
	this.toastPop.css( 'left', (fullWidth/2 - this.toastPop[0].clientWidth/2) + 'px' ); 	
	this.toastPop.css( 'top', (tarTop - 20) + 'px'); 	
	
	var ty = $(this.txtArea).css('top');
	$(this.toastPop).css( { top : (parseInt(ty)+20) + "px" });
	$(this.toastPop).animate({ top : "-=20px" }, 200 );
	
	$("html").css({overflow:'hidden'});
	$("body").css({overflow:'hidden'}).bind('touchmove', function(e){e.preventDefault()});
};

ifvConfirm.prototype.remove = function(){
	ifv.isConfirm = false;
	$("html").css({overflow:'auto'});
	$("body").css({overflow:'auto'}).unbind('touchmove');
	this.item.remove();
};

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
(function($){

	
	/*
	 * ifvSelectBox
	 */
	$.fn.ifvSelectBox = function(options){

		var _this = $.extend({
			data : null,
			input : null,
			selectList : null,
			isShow : false,
			func:null,
			span : null,
			scope : null,
			outTimer : null,
			width : null,
			isUp : false,
			isDisable : false

		}, options);

		var that = this;

		this.init = function(){
			
			_this.input = this;
			_this.input.css('position', 'relative');
			_this.input.attr('readonly', true );
			if( _this.width != null ) _this.input.width( _this.width );
			_this.span = document.createElement('span');
			_this.span.className = 'selectbox_type1';
			this.before(_this.span);

			$(this).appendTo(_this.span);
			var a = document.createElement('a');
			a.href = "javascript:;";
			a.className = 'select_btn';
			_this.span.appendChild(a);

			var selectList = document.createElement('div');
			_this.selectList = $(selectList);
			_this.selectList.addClass("select_list");
			if( _this.isUp == true ) _this.selectList.addClass("up");
			_this.span.appendChild(selectList);

			_this.input.click(function(){
				that.selectListShow();
			});

			$(a).click(function(){
				that.selectListShow();
			});

			_this.selectList.mouseout(function(){
				if( _this.outTimer != null ) clearInterval(_this.outTimer);
				_this.outTimer = setInterval(function () {
					that.selectListHide();

			        clearInterval(_this.MoveTumTimer);
			    }, 150);
			});

			$(_this.span).mouseover(function(){
				if( _this.isShow ){
					that.selectListShow();
				}
			});
		};

		this.selectListHide = function(){
			_this.selectList.hide();
			_this.isShow = false;
		};

		this.selectListShow = function(){
			
			if( _this.isDisable == true || _this.input.attr('disabled') != null ) return;
			
			if( _this.data != null && _this.data.length > 0 ){
				if( _this.outTimer != null ) clearInterval(_this.outTimer);
				_this.selectList.show();
				_this.input.focusout();
				//_this.selectList.scrollTop(0);
				_this.isShow = true;
			}
		};
		
		this.disabled = function(){
			_this.isDisable = true;
			_this.input.attr('disabled', true );
		};
		
		this.enabled = function(){
			_this.isDisable = false; 
			_this.input.attr('disabled', false );
		};

		this.getSpan = function(){
			return _this.span;
		};

		this.setData = function(data, func){
			_this.func = func;
			_this.selectList.html('');
			_this.data = data;
			for( var i = 0; i<data.length; i++ ){
				if( data[i] != null ){
					var div = document.createElement('div');
					div.title = data[i].value;
					div.innerHTML = data[i].value;
					_this.selectList.append(div);
					
					if(_this.data[i].key2 != undefined){
						_this.input.attr('key2', _this.data[i].key2 );
					}
					this.eventsetting(div, i);
					if(!!data[i].selected && data[i].selected == true) {
						_this.input.val( _this.data[i].value );
						_this.input.attr('key', _this.data[i].key );
					}
				}
			}
		};

		this.eventsetting = function(item, i ){

			$(item).click(function(){
				_this.input.val( _this.data[i].value );
				_this.input.attr('key', _this.data[i].key );
				_this.input.attr('key2', _this.data[i].key2 );
				that.selectListHide();
				if( _this.func != null ){
					if( _this.scope != null ){
						_this.func.call(this.scope, _this.data[i]);
					}else{
						_this.func(_this.data[i]);
					}

				}
			});

			$(item).mouseover(function(){
				//if( _this.outTimer != null ) clearInterval(_this.outTimer);
				_this.selectList.show();
			});
		};

		this.setValue = function(value){

			_this.input.val( value );

			if( _this.data != null ){
				for( var i = 0; i<_this.data.length; i++ ){
					if( _this.data[i].value == value ){
						_this.input.attr('key', _this.data[i].key );
					}
				}
			}
		};

		this.setKey = function(key){
			_this.input.attr('key', key );

			if( _this.data != null ){
				for( var i = 0; i<_this.data.length; i++ ){
					if( _this.data[i].key == key ){
						_this.input.val( _this.data[i].value );
					}
				}
			}
		};

		this.setObj = function(obj){
			_this.input.val( obj.value );
			_this.input.attr('key', obj.key );
		};

		this.getObj = function(){
			var obj = {
				value :_this.input.val(),
				key : _this.input.attr('key'),
				key2: _this.input.attr('key2')
			};
			return obj;
		};

		this.show = function(){
			$(_this.span).show();
		};

		this.hide = function(){
			$(_this.span).hide();
		};

		this.init();

		return this;
	};



	/*
	 * ikSelectBoxPlus
	 */
	$.fn.ikSelectBoxPlus = function(options){
		var _this = $.extend({
			data : null,
			func : null,
			selectbox : null,
			selectArr : null,
			selectValue : null
		}, options);

		this.init = function(){

			_this.selectArr = [];

			this.makeSelectbox(true);
		};

		this.makeSelectbox = function(isPlus){

			var div = document.createElement("div");
			div.className = 'plusBox';
			var item = $(div).ikSelectBoxItem({
				scope : this,
				data : _this.data,
				isPlus : isPlus,
				plusFunc : this.plusItem,
				removeSelectbox : this.removeSelectbox,
				returnFunc : this.returnFunc
			});
			item.attr('key', _this.selectArr.length );
			if( !isPlus ) item.css('marginTop','2px');

			this.append(div);
			_this.selectArr.push($(div));
		};

		this.plusItem = function(){
			this.makeSelectbox(false);
		};

		this.removeSelectbox = function(index){
			_this.selectArr[index].remove();
			_this.data.callback.call( _this.data.scope );
			//if( _this.func != null ) _this.func(false, index);
		};

		this.returnFunc = function(obj){
			if( obj != null ){
				obj.id = this.parent().parent().attr('id');
			}
			_this.data.callback.call( _this.data.scope, obj );
		};

		this.init();
	};



	$.fn.ikSelectBoxItem = function(options){

		var _this = $.extend({
			scope : null,
			plusFunc : null,
			removeSelectbox : null,
			returnFunc : null,
			selectboxCon : null,
			selectbox : null,
			input : null,
			isPlus : null,
			btn : null,
			data : null,
			selectValue : null
		}, options);


		this.init = function(){

			this.makeItem();
		};


		this.makeItem = function(){
			_this.selectboxCon = this.makeSelectBox();
			_this.btn = this.makeBtn();
			_this.input = this.makeInput();
			this.append(_this.selectboxCon);
			this.append(_this.btn);
			this.append(_this.input);
		};

		this.makeSelectBox= function(){
			
			var that = this;
			
			var input = document.createElement("input");
			input.type="text";
			_this.selectbox =  $(input).ikSelectBox();
			_this.selectbox.setData(_this.data.selectDataArr, function(obj){
				
				_this.input.value = 0;
				
				_this.selectValue = obj.value;
				_this.returnFunc.call( _this.scope );
				//_this.selectbox.setKey( _this.data.selectDataArr[0].value );
				
			});

			if( _this.data.selectWidth != null ) $(input).css('width', _this.data.selectWidth + 'px');

			return _this.selectbox.getSpan();
		};
		

		this.makeBtn = function(){

			var btn = document.createElement("a");
			btn.style.display = 'inline';
			btn.href='javascript:;';
			var img = document.createElement("img");
			$(btn).append(img);
			if( _this.isPlus ){
				img.src = '../../resources/images/btn/btn_plus.gif';
			}else{
				img.src = '../../resources/images/btn/btn_minus.gif';
			}

			this.btnEventSetting(btn);
			if( _this.data.btnLeftGap != null ) $(btn).css('marginLeft' , _this.data.btnLeftGap + 'px');

			return btn;
		};

		this.btnEventSetting = function(btn){

			var that = this;
			if( _this.isPlus ){
				$(btn).click(function(){
					//that.makeSelectbox(false);
					_this.plusFunc.call(_this.scope, false);
					var index = $(this).parent().attr('key');
					if( _this.func != null ) _this.func(true, index);
				});
			}else{
				$(btn).click( function(){
					var index = $(this).parent().attr('key');
					that.removeSelectbox.call(_this.scope, index );
				});
			}
		};

		this.makeInput = function(){
			var input = document.createElement("input");
			input.type="text";
			if( _this.data.inputWidth != null ) $(input).css('width', _this.data.inputWidth + 'px');
			if( _this.data.inputLeftGap != null ) $(input).css('marginLeft' , _this.data.inputLeftGap + 'px');
			var that = this;
			$(input).focusout(function(){
				var obj = _this.selectbox.getObj();
				obj.input = this;
				obj.num = $(this).val();
				_this.returnFunc.call( _this.scope, obj );
			});
			
			$(input).onlyNumber();

			return input;
		};

		this.removeSelectbox = function(index){
			_this.removeSelectbox.call( _this.scope, index);
			/*_this.selectArr[index].remove();
			if( _this.func != null ) _this.func(false, index);*/
		};

		this.init();

		return this;
	};


})(jQuery);





(function($){
    
    $.fn.ifvValidation = function(options){
    	
        this.opt = $.extend({
            itemArr : [],	//validation check item array
            requiredInputArr : [], //필수값 array 
            valiId : null,
        	valiTxtArr : [],
        	type : 'absolute'
        }, options);

        this.init = function(){
            this.addClass('ifv_validation');
            this.inputSetting();
        };

        this.inputSetting = function(){
            
            var arrInput = this.getArray(); 
            var _this = this;
            arrInput.each( function(index, item){
                _this.opt.itemArr.push( $(item).ifvValiItem({parentCheck : _this.allCheck, scope : _this, type : _this.opt.type }) );
            });
            
            this.keydownValiCheck();
        };
        
        this.keydownValiCheck = function(){
        	var inputArr = this.find('input[vali-type=number]');
        	inputArr.keydown(function (e) {
        		
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    (e.keyCode == 65 && e.ctrlKey === true) || 
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                         return;
                }
                
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                	e.preventDefault ? e.preventDefault() : (e.returnValue = false);
                }
            });
        	
        	inputArr.blur(function(e){
        		var num_check=/^[0-9]*$/;
        		if( num_check.test(this.value) == false ){
        			this.value = '';
        		}
        	});
        	
        	var floatArr = this.find('input[vali-type=float]');
        	floatArr.keydown(function (e) {
        		
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    (e.keyCode == 65 && e.ctrlKey === true) || 
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                         return;
                }
                if ((e.shiftKey || ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 190)) && ((e.keyCode < 96 || e.keyCode > 105) && e.keycode != 110)) {
                	e.preventDefault ? e.preventDefault() : (e.returnValue = false);
                }
            });
        	
        	floatArr.blur(function(e){
        		if(isNaN(this.value) || this.value % 1 === 0)
        			this.value = '';
        	});
        	
        	var latArr = this.find('input[vali-type=lat]');
        	latArr.keydown(function (e) {
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    (e.keyCode == 65 && e.ctrlKey === true) || 
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                         return;
                }
                if ((e.shiftKey || ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 190 && e.keyCode != 189)) && ((e.keyCode < 96 || e.keyCode > 105) && e.keycode != 110)) {
                	e.preventDefault ? e.preventDefault() : (e.returnValue = false);
                }
            });
        	
        	latArr.blur(function(e){
            	var reg = /^(-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,15})?))$/;
            	
            	var check = !reg.test( this.value );
            	
                if( check ){
                	this.value = '';
                }
                	
        	});
        	
        	var lngArr = this.find('input[vali-type=lng]');
        	lngArr.keydown(function (e) {
        		
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    (e.keyCode == 65 && e.ctrlKey === true) || 
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                         return;
                }
                if ((e.shiftKey || ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 190 && e.keyCode != 189)) && ((e.keyCode < 96 || e.keyCode > 105) && e.keycode != 110)) {
                	e.preventDefault ? e.preventDefault() : (e.returnValue = false);
                }
            });
        	
        	lngArr.blur(function(e){
            	var reg = /^(-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,15})?))$/;
            	var check = !reg.test( this.value );
            	
                if( check ){
                	this.value = '';
                }
        	});
        };
          
        this.getArray = function(){
        	var inputArr = this.find('input[vali-type], textarea[vali-type], select[vali-type], input[required], textarea[required], select[required]');
        	var falseRequiredArr = this.find('input[required=false], textarea[required=false], select[required=false]');
        	
        	for( var i = inputArr.length-1; i > -1; i-- ){
        		for( var j = falseRequiredArr.length-1; j > -1; j-- ){
        			if( inputArr[i] == falseRequiredArr[j] ){
        				inputArr.splice( i, 1 );
        			}
        		}
        	}
        	return inputArr;
        };
        
        this.requiredCheck = function(){
        	
            for( var i = 0; i < this.opt.requiredInputArr.length; i++ ){

				var trimCheck = this.opt.requiredInputArr[i].value;
				var requiredInputData = null;

				if(trimCheck != null && trimCheck != ''){
					requiredInputData = trimCheck.trim();
				} else {
					requiredInputData = trimCheck;
				}

                if( this.opt.requiredInputArr[i].type == 'radio' || this.opt.requiredInputArr[i].type == 'checkbox' ){
                    
                    var arr = this.find('input[name=' + this.opt.requiredInputArr[i].name +']:checked');

                    if( arr.length == 0 ) return this.opt.requiredInputArr[i];

                }else if( requiredInputData == '' ){
                    return this.opt.requiredInputArr[i];
                }
            }
            
            return null;
        };
        
        this.allCheck = function(){
        	this.clear();
            var check = -1;
            for( var i = 0; i < this.opt.itemArr.length; i++ ){
                if( this.opt.itemArr[i].check() == false ){
                    check = i;
                    break;
                }
            }    

            return check;          
        };

        this.clear = function(){
        	
        	for( var i = 0; i < this.opt.requiredInputArr.length; i++ ){
        		$(this.opt.requiredInputArr[i]).removeClass('ifv_vali_wrong');
        	}
        	for( var i = 0; i < this.opt.itemArr.length; i++ ){
        		this.opt.itemArr[i].clear();
        		this.opt.itemArr[i].removeClass('ifv_vali_wrong');
        	}
        	for( var i = 0; i < this.opt.valiTxtArr.length; i++ ){
        		this.opt.valiTxtArr[i].remove();
        	}
        };

        this.confirm = function(){
        	
            var check = this.allCheck();

            if( check == -1 ){
                return true;
            }else{
                return false;
            }
        };
        
        this.valiShowAPI = function( _input, _valiItem ){
        	
        	var input = _input;
        	var valiItem = _valiItem;
        	
        	var offset = input.offset();
        	valiItem.show();
        	valiItem.css({ left : offset.left, top : offset.top + 15, opacity : 0 });
            $('body').append( valiItem );
            
    		valiItem.stop().animate({ top:offset.top, opacity : 1 }, 200, function(){
            	hidefailUI();
            });
            
            function hidefailUI(){
            	valiItem.delay( 500 ).animate({ opacity : 0 }, 50, function(){
            		valiItem.hide();
            	});
            };
        };

        this.init();
       
        return this;
    };


    /*
    *
    *   $.fn.ifvValiItem
    *
    */
    $.fn.ifvValiItem = function(options){

        this.opt = $.extend({
            valiItem : null,
            parentCheck : null,
            valiId : null,
            scope : null,
            type : null,
        }, options );

        this.init = function(){
            var _this = this;
            
            this.opt.valiId = this.attr('vali-id');
            
            this.keyup(function(){
            	if( _this.opt.type == 'absolute' ){
            		_this.clear();
            	}else{
            		_this.check();
            	}
            });
            this.change(function(){
            	if( _this.opt.type == 'absolute' ){
            		_this.clear();
            	}else{
            		_this.check();
            	}
            });
            
        };
        
        this.check = function(){
        	this.clear();
        	
        	var type = this.attr('required');
        	if( type != null && this.requiredCheck() == false ) return false;
        	
        	return this.validationCheck();
        };
        
        this.requiredCheck = function(){
        	
        	var str = ifv.validationMessage.required;

			var trimCheck = this.val();
			var requiredInputData = null;

			if(trimCheck != null && trimCheck != ''){
				requiredInputData = trimCheck.trim();
			} else {
				requiredInputData = trimCheck;
			}
        		
            if( this.attr('type') == 'radio' || this.attr('type') == 'checkbox' ){
                
                var arr = $("body").find('input[name=' + this.attr('name') +']:checked');
                if( arr.length == 0 ){
                	this.failUi(str);
                	return false;
                }
            }else if( this.attr('multiple') == 'multiple' ){
            	if( this.val() == '' ){
            		this.failUi(str);
                	return false;
            	}	
            }else if( requiredInputData == '' ){
            	this.failUi(str);
            	return false;
            	
            }
            
            return true;
        };

        this.validationCheck = function(){
        	if( this.val() == '' ) return true;
            var cheker = true;
            var str = '';
            var type = this.attr('vali-type');
            if( type == null ) return;
            switch( type ){
                case 'email' :
                    cheker = this.emailCheck();
                    str = ifv.validationMessage.email;
                    break;
                
                case 'password' :
                    cheker = this.passwordCheck();
                    str = ifv.validationMessage.password;
                    break;
                    
                case 'passwordConfirm' :
                    cheker = this.passwordConfirmCheck();
                    str = ifv.validationMessage.passwordConfirm;
                    break;
                    
                case 'phone' :
                    cheker = this.phoneCheck();
                    str = ifv.validationMessage.phone;
                    break;
                    
                case 'url' :
                    cheker = this.urlCheck();
                    str = ifv.validationMessage.url;
                    break;
                    
                case 'kor' :
                    cheker = this.hangleCheck();
                    str = ifv.validationMessage.kor;
                    break;
                    
                case 'eng' :
                    cheker = this.engCheck();
                    str = ifv.validationMessage.eng;
                    break;

                case 'number' :
                    cheker = this.numberCheck();
                    str = ifv.validationMessage.number;
                    break;
                    
                case 'exceptHangul' :
                    cheker = this.exceptHangulCheck();
                    str = ifv.validationMessage.exceptHangul;
                    break;
                    
                case 'float' :
                    cheker = this.floatCheck();
                    str = ifv.validationMessage.float;
                    break;

                case 'lat' :
                    cheker = this.latCheck();
                    str = ifv.validationMessage.lat;
                    break;

                case 'lng' :
                    cheker = this.lngCheck();
                    str = ifv.validationMessage.lng;
                    break;
                    
                case 'globalPhone' :
                    cheker = this.globalPhoneCheck();
                    str = ifv.validationMessage.globalPhone;
                    break;
                    
                case 'alphanumeric':
                    cheker = this.alphanumericCheck();
                    str = ifv.validationMessage.alphanumeric;
                    break;
                    
                default:
                	
                    break;
            }
            
            if( cheker == false ){
            	this.failUi(str);
            }

            return cheker;
        };
        
        this.failUi = function(str){
        	if( this.valiItem == null ){
        		
        		if( this.opt.valiId != null ){
        			this.valiItem = $("#" + this.opt.valiId);
        			this.valiItem.text(str);
        			this.makeFailUIShow();
        		}else{
        			this.addClass('ifv_vali_wrong');
        			if( this.opt.type == 'absolute' ){
        				this.makeFailUI2(str);
        			}else{
        				this.makeFailUI(str);
        			}
        		}
        	}
        };
        
        this.makeFailUI = function(str){
        	this.parent().css('position', 'relative');
            this.valiItem = $("<p class='valieTxt'>");
            this.valiItem.text(str);
            this.after( this.valiItem );
        };
        
        this.makeFailUI2 = function(str){
        	this.parent().css('position', 'relative');
            this.valiItem = $("<div class='vali_tooltip'>");
            
            var valiContent = $("<div class='vali_content'>");
            var valiArrow = $("<div class='vali_arrow'>");
            
            valiContent.text(str);
            
            this.valiItem.append(valiContent);
            this.valiItem.append(valiArrow);
            this.makeFailUIShow();
        };
        
        this.makeFailUIShow = function(){
        	if( this.opt.type == 'absolute' ){
        		this.focus();
        		var offset = this.offset();
        		
                this.valiItem.css({ left : offset.left, top : offset.top, opacity : 0 });
                $('body').append( this.valiItem );
                
                var vwidth = this.valiItem.outerWidth();
                var vheight = this.valiItem.outerHeight();
                
                this.valiItem.css({ left : offset.left, top:offset.top - vheight - 10, });
                
        		this.valiItem.stop().animate({ opacity : 1 }, 200, function(){
                	hidefailUI();
                });
                
                var _this = this;
                function hidefailUI(){
                	_this.valiItem.delay( 1000 ).animate({ opacity : 0 }, 50, function(){
                		_this.valiItem.remove();
                		//_this.removeClass('ifv_vali_wrong');
                	});
                };
			}else{
				this.valiItem.show();
			}
        };
        
        this.checkByte = function(value){
            var words_byte = 0; 
            for (var inx = 0; inx < value.length; inx++) { 
                var wd = escape(value.charAt(inx)); 
                if ( wd.length == 1 ) { 
                    words_byte ++; 
                } else if (wd.indexOf("%u") != -1) { 
                    words_byte += 2; 
                } else if (wd.indexOf("%") != -1) { 
                    words_byte += wd.length/3; 
                } 
            } 
            return words_byte;
         };
        
        this.hangleCheck = function(){
        	var reg = /^[가-힣]+$/i
        	return reg.test( this.val() );
        };
        
        this.engCheck = function(){
        	var reg = /^[A-Za-z]+$/i
        	return reg.test( this.val() );
        };
        
        this.numberCheck = function(){
        	var reg = /^[0-9]+$/i
        	return reg.test( this.val() );
        };
        
        this.exceptHangulCheck = function(){
        	var reg = /^[-A-Za-z0-9]+$/i
        	return reg.test( this.val() );
        };
        
        // http://docs.jquery.com/Plugins/Validation/Methods/number
        this.number = function(){
        	var reg = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/
			return reg.test( this.val() );
		};
	
		// http://docs.jquery.com/Plugins/Validation/Methods/numberDE
		this.numberDE = function(){
			var reg = /^-?(?:\d+|\d{1,3}(?:\.\d{3})+)(?:,\d+)?$/
			return reg.test( this.val() );
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/digits
		this.digits = function(value, element) {
			var reg = /^\d+$/
			return reg.test( this.val() );
		},
         
        this.passwordStringCheck = function() {
            return true;
        };
        
        this.passwordConfirmCheck = function() {
            return true;  
        };
        
        this.passwordCheck = function() {
        	var v = this.val();
        	if(v.length < 8)
        		return false
    		else
    			return true;
        };
        
        this.emailCheck = function() {
            var reg = /^([0-9a-zA-Z!#\$%&'\*\+\-\/=\?\^_`{\|}~\.]+)@([0-9a-zA-Z_-]+)(\.[a-zA-Z]+){1,2}$/i
            var check = reg.test( this.val() );
            
            if( check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.urlCheck = function() {
        	var reg = /^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/;
            var check = reg.test( this.val() );
            
            if( check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.phoneCheck = function() {
            var reg = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
            var check = !reg.test( this.val() );

            if( !check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.floatCheck = function() {
        	var v = this.val();
        	return !isNaN(v) && v % 1 !== 0 ? true : false;
        };

        this.latCheck = function() {
        	var reg = /^(-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,15})?))$/;
        	
        	var check = !reg.test( this.val() );
        	
            if( !check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.lngCheck = function() {
        	var reg = /^(-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,15})?))$/;
        	
        	var check = !reg.test( this.val() );
        	
            if( !check ){
                return true;
            }else{
                return false;
            }
        };

        this.globalPhoneCheck = function() {
        	var reg = /^[\+\-0-9][\-0-9]+$/gm;
        	
        	var check = !reg.test( this.val() );
        	
            if( !check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.alphanumericCheck = function() {
            var reg = /^[a-z0-9]+$/i;

            var check = !reg.test(this.val());

            if (!check) {
                return true;
            } else {
                return false;
            }
        };
        
        this.clear = function(){
        	if( this.valiItem != null ){
        		if( this.opt.valiId != null ){
        			this.valiItem.hide();
        		}else{
            		this.valiItem.remove();
        		}
        		this.removeClass('ifv_vali_wrong');
        		this.valiItem = null;
        	}
        };
        

        this.init();

        return this;
    };

})(jQuery);
(function($){
	/**
	 * 
	 * @class ifvGrid
	 * 
	 */
	$.fn.ifvGrid = function(options){

		this.opt = $.extend({
			searchBox : null,
			rowsBox : null,
			grid : null,
			gridPage : null,
			page : null,
			pager : null,
			data : null,
			gridId : null,
			postData : null,
			keyName : null,
			isRsizeTime : false,
			jqGridOptionCopy : null,
			isRowspan : false,
			trNum : 0
			
		}, options);
		
		this.init = function(){
			$.extend( options.jqGridOption.ajaxGridOptions, this.jqGridOption.ajaxGridOptions );	//ajaxGridOptions override
			$.extend( this.jqGridOption, options.jqGridOption );
			this.jqGridOption.caption = null;	

			if(this.opt.isRowspan) this.addClass('rowspan_grid');
			
			this.trNum = 0;
			
			this.optionSetting();
			
			this.uiSetting();
			this.keyCheck();
			this.makeGrid();
			this.titleInit();
			this.rowBoxInit();
			this.searchBoxInit();
			this.excelDownInit();
			this.btnInit();
			
			if( this.jqGridOption.url == null || this.jqGridOption.ajaxGridOptions.async == false ){
				if( this.jqGridOption.emptyRows == 0 ){
					var rowDatas = this.opt.grid.getRowData();
					if( rowDatas.length == 0 ){
						this.emptyMsgDiv.show();
					}
				}else{
					this.makeEmptyRows();
				}
			}
		};
		
		this.setEmptyRows = function(emptyRows){
			this.jqGridOption.emptyRows = emptyRows;
			this.makeEmptyRows();
		};
		
		this.makeEmptyRows = function(){
			if( this.opt.grid == null ) return;
			var dataRow = this.getRowData();
			var length = this.jqGridOption.emptyRows - dataRow.length;
			
			for( var i = 0; i < length; i++ ){
				this.addLocalTr();
			}
		};
		
		this.addRows = function(list){
			for( var i = 0; i < list.length; i++ ){
				this.addLocalTr(list[i]);
			}
			this.makeEmptyRows();
		};
		
		this.optionSetting = function(){
			
			var _this = this;
			
			this.jqGridOption.rowNum = this.jqGridOption.rowList[0];	//default rowNum

			var colModels = this.jqGridOption.colModel;
			for ( var i=0, l=colModels.length; i<l; i++ ) {
			    if ( colModels[i].formatter == 'date') {
			        colModels[i].formatoptions.srcformat = 'Y-m-d H:i:s';
			    }
			}

			if( this.jqGridOption.cellurl != null || this.jqGridOption.cellurl == "" ){
				this.jqGridOption.ajaxCellOptions = { contentType: 'application/json', type: 'POST' };
				this.jqGridOption.cellEdit = true;
				this.jqGridOption.cellsubmit = 'remote';
			}
			
			if( this.jqGridOption.onSelectCell != null ){
				this.jqGridOption.cellEdit = true;
			}
			
			if( this.jqGridOption.radio == true ){
				this.radioSetting();
			}
			
			if( this.jqGridOption.seq == true ){
				this.seqSetting();
			}
			
			for( var i = 0; i < this.jqGridOption.colModel.length; i++ ){
				if( this.jqGridOption.colModel[i] != null && this.jqGridOption.colModel[i].width == null ){
					this.jqGridOption.colModel[i].width = 'auto';
				}
			}
			
		};
		
		this.radioSetting = function(){
			if(this.jqGridOption.colModel[0].name == 'radio') return;
			var _this = this;
			var obj = { name : 'radio', align : 'center', width:45, editable : false, edittype : "radio", sortable : false, searchable :false 
				,formatter: function( cellValue, option ){
        			return '<input type="radio" name="radio_' + _this.gridId + '"  />';
    			}
			};
			this.jqGridOption.colNames.unshift( ifv.commonMessage.select );
			this.jqGridOption.colModel.unshift(obj);
			
			this.jqGridOption.beforeSelectRow = function( rowid, e ){
		        var $radio = $(e.target).closest('tr').find('input[type="radio"]');
		        $radio.attr('checked', 'checked');
		        $(this).setSelection(rowid, true);
		        return true; // allow row selection
		    };
		};
		
		this.titleInit = function(){
			if(title != undefined){ //사용중이지않은 화면이면 타지 않게 함
				var title = options.jqGridOption.caption;
				if( title != null && title != "" ){
					this.opt.title.html( title );
				}else{
					this.opt.title.remove();
				}
				}
		};
		
		this.btnInit = function(){
			var _this = this;
						
			if( this.opt.rowsBox != null ){
				this.opt.btnAdd.click(function() {
					if( _this.jqGridOption.cellEdit == true ){
						
						if( _this.opt.data != null && _this.opt.data.rows != null ){
							_this.opt.grid.jqGrid('addRowData', _this.opt.data.rows.length, {} );
						}else{		
							_this.addLocalTr();
						}
					}else if( _this.jqGridOption.addBtnClick != null ){
						_this.jqGridOption.addBtnClick();
					}
				});
			}
			
			if( this.jqGridOption.multiselect == true ){
				if( this.opt.btnDelete != null ){
					this.opt.btnDelete.click(function() {
					     _this.delRowData();
					});
				}
			}
		};
		
		this.keyCheck = function(){
			for( var i = 0; i<this.jqGridOption.colModel.length; i++ ){
				if( this.jqGridOption.colModel[i].key != null ){
					this.opt.keyName = this.jqGridOption.colModel[i].name;
					break;
				}
			}
		};

		this.uiSetting = function(){
			var con = $("#" + this.jqGridOption.tempId ).html();
			if(con != undefined){ //사용중이지않은 화면이면 타지 않게 함
				
		
				this.gridId = "gridId" + this.attr('id');
				
				con = con.replace('{searchBox}', '<div class="search_box" gridId="searchBox" ></div>' );
				con = con.replace('{rowsBox}', '<input class="combo_num_box" gridId="rowsBox" />' );
				con = con.replace('{grid}', '<table gridId="grid" id="' + this.gridId + '"></table>' );
				con = con.replace('{gridPage}', '<div gridId="gridPage" id="gridPage" ></div>' );
				con = con.replace('{page}', '<div gridId="page" ></div>' );
				con = con.replace('{total}', '<div gridId="total" ></div>' );
				con = con.replace('{btnAdd}', '<input type="button" class="btnAdd" gridId="btnAdd" value="?�록"/>' );
				con = con.replace('{btnDelete}', '<input type="button" class="btnDelete" gridId="btnDelete" value="??��"/>' );
				con = con.replace('{title}', '<div gridId="title" class="title"/>' );
				con = con.replace('{excelDown}', '<button gridId="excelDown" class="btn btn-sm btn-imgonly"><i class="fa fa-search"></i></button>' );
					
				this.html(con);
				
				this.opt.searchBox = this.find("[gridId=searchBox]");
				this.opt.rowsBox = this.find("[gridId=rowsBox]");
				this.opt.gridPage = this.find("[gridId=gridPage]");
				this.opt.page = this.find("[gridId=page]");
				this.opt.total = this.find("[gridId=total]");
				this.opt.btnAdd = this.find("[gridId=btnAdd]");
				this.opt.btnDelete = this.find("[gridId=btnDelete]");
				this.opt.title = this.find("[gridId=title]");
				this.opt.excelDown = this.find("[gridId=excelDown]");
		
			}
		};
		
		this.makeEmptyDiv = function(){
			this.emptyMsgDiv = $('<div class="empty_msg"></div>');
			this.emptyMsgDiv.text( this.jqGridOption.emptyMsg );
		};
		
		this.makeGrid = function(){
			
			this.makeEmptyDiv();
			this.resizeEvent();
			this.gridEventOverride();
			this.jqGridOption.gridId = this.attr('id');
			this.opt.grid = this.find("[gridId=grid]").jqGrid( this.jqGridOption );
			this.opt.grid.navGrid( "#gridPage", { closeOnEscape:false, del:false, add:false, edit:false, search:false, refresh:false });
			
			this.emptyMsgDiv.insertAfter( this.opt.grid.parent() );
			
			$('.ui-pg-selbox').hide();
			$('.ui-jqgrid-titlebar-close.HeaderButton').hide();
			
			/*if( this.jqGridOption.radio == true ){
				this.find('.ui-jqgrid-hbox').find('input[type=checkbox]')[0].style.display = "none";
			}*/
			this.setWidth( this.width() );
		};
		
		this.styleSetting = function(){
			if( this.jqGridOption.onSelectCell != null && this.opt.grid != null && this.jqGridOption.usePointer != false){
				this.opt.grid.find('td').css({ cursor: "pointer" });
			}
			
			this.cssSetting();
		};
		
        this.cssSetting = function() {
            if (this.jqGridOption.multiselect == true && this.opt.grid != null) {
                this.opt.grid.find(".cbox").parent().addClass('cbox_parent');
            }
            
            if(this.jqGridOption.gridHeight) {
            	this.find('.grid_con').css({
            		'maxHeight' : this.jqGridOption.gridHeight
            		, 'overflow-y' : 'auto'
            	});
            }
        };

        this.resizeEvent = function() {

            var _this = this;
            var timer = null;
            $(window).bind('resize', function() {
            	
                if (timer != null) {
                    clearTimeout(timer);
                }
                timer = setTimeout(function() {
                	console.log('innerWidth : ' + _this.find('.grid_con').prop('clientWidth'));
                    _this.setWidth(_this.find('.grid_con').prop('clientWidth'));
                }, 250);
            });
        };
		
		this.setWidth = function( width ){
			
			if( this.opt.grid != null ){
				this.find('.ui-jqgrid-view').width( width );
				this.find('.ui-state-default.ui-jqgrid-hdiv').width( width );
				this.find('.ui-jqgrid-bdiv').width( width );
				this.find('.ui-jqgrid-hbox table').width( width );
		    	this.find('.ui-jqgrid-bdiv table').width( width );
		    	this.find('.ui-jqgrid-sdiv').width( width );
		    	$("#gbox_" + this.gridId ).width( width );
				//this.opt.grid.setGridWidth( width, false);
			}
		};

        this.excelDownInit = function() {
            if (this.opt.excelDown == null) return;

            this.opt.excelDown.on('click', function() {
            	fnIfvExcelDownload(this.getAttribute('data-gid'));
            });
        };		

		this.rowBoxInit = function(){
            if( this.opt.rowsBox == null ) return;
            
            var arr = [];
            for( var i = 0; i < this.jqGridOption.rowList.length; i++ ){
            	var obj = { value : this.jqGridOption.rowList[i], key : this.jqGridOption.rowList[i] };
            	if( i == 0 ) obj.selected = true;
            	arr.push( obj );
            }
            
            var selectbox = this.opt.rowsBox.ifvSelectBox();
            
            var _this = this;
            selectbox.setData(arr, function(obj){
            	_this.pageInit();
				
            	_this.jqGridOption.rowNum = obj.key;
            	_this.opt.grid.setGridParam({ rowNum:obj.key });
            	_this.opt.grid.trigger("reloadGrid");
            	
            });
        };
        this.searchBoxInit = function(){
            if( this.opt.searchBox == null ) return;
            var headArr = [];
            var count = 0;
            for( var i = 0; i< this.jqGridOption.colNames.length; i++ ){
            	if( this.jqGridOption.colModel[i].hidden != true && ( this.jqGridOption.colModel[i].searchable == null || this.jqGridOption.colModel[i].searchable ) ){
            		headArr.push( {value: this.jqGridOption.colNames[count], key : this.jqGridOption.colModel[i].index });
            	}
            	
            	if( this.jqGridOption.colModel[i].hidden != true ){
            		count++;
            	}
            	
            	if (this.jqGridOption.colModel[i].hidden == true && (typeof this.jqGridOption.colModel[i].hiddensrch != "undefined" && this.jqGridOption.colModel[i].hiddensrch == true )) {
            		headArr.push( {value: this.jqGridOption.colNames[count], key : this.jqGridOption.colModel[i].index });
            		count++;
            	}
            }
            var _this = this;
            var searchBox = this.opt.searchBox.ifvSearchBox({ watermark : this.jqGridOption.searchInputWatermark });
            searchBox.setData( headArr, function( searchObj ){
            	_this.pageInit();
				
				$.extend( _this.opt.postData, searchObj);
            	_this.opt.grid.setGridParam({ postData : _this.opt.postData });
            	_this.opt.grid.trigger("reloadGrid");
            });
        };

        this.requestData = function(obj){
        	
        	this.pageInit();
        	
        	$.extend( this.opt.postData, obj);
        	
        	this.opt.grid.setGridParam({ postData : this.opt.postData });
        	this.opt.grid.trigger("reloadGrid");
        };
        
        this.pageInit = function(){
        	if( this.opt.pager != null ){
        		this.opt.pager.empty();
            	this.opt.pager = null;
            	this.opt.grid.setGridParam({ page : 1 });
            	this.opt.postData.page = 1;
        	}
        };

		this.pagerSetting = function( data ){
			
			if( this.opt.pager == null ){
				var _this = this;
				this.opt.pager = this.opt.page.ifvSimplePager({
					dataObj : { rows : _this.jqGridOption.rowNum },
					callback: function( page ){
						/**
						 * datatype 이 clientSide 인 경우 서버와 통신하는 postData 가 없으므로 null 체크 추가
						 * 없을 경우 clientSide 에서 페이징 시 에러발생.
						 */
						if(_this.opt.postData != null) {
							_this.opt.postData.page = page;
						}
						_this.opt.grid.setGridParam({ page : page });
                        if(_this.opt.jqGridOption.addGridDataWhenPaging) {
                        	_this.opt.postData = _this.opt.jqGridOption.addGridDataWhenPaging(_this.opt.postData);
                        }
		            	_this.opt.grid.trigger("reloadGrid");
					}
				});
				this.opt.pager.change( data );
			}
		};
		

		this.totalSetting = function( data ){
            if (!data.records) data.records = 0;
			var txt = this.jqGridOption.total.replace('{total}', data.records );
			this.opt.total.text( txt );
		};

		this.gridEventOverride = function(){
			this.jqGridOptionCopy = $.extend({}, this.jqGridOption );
			
			var _this = this;

			this.jqGridOption.serializeGridData = function( data ) {
				
				if( _this.opt.postData == null ){
					_this.opt.postData = {};
					var userData = {};
					if( _this.jqGridOptionCopy.serializeGridData != null ){
						userData = _this.jqGridOptionCopy.serializeGridData( data );
						$.extend( _this.opt.postData, userData );
					};
					
					if( _this.jqGridOptionCopy.addGridDataWhenPaging != null ){
						userData = _this.jqGridOptionCopy.addGridDataWhenPaging( userData );
						$.extend( _this.opt.postData, userData );
					};
				}

				var savePage = _this.opt.postData.page;
				
	        	$.extend( _this.opt.postData, data );
	        	
	        	_this.opt.postData.page = savePage; 
	            return JSON.stringify(_this.opt.postData);
			};
			
			//resposeData ?�팅
			this.jqGridOption.loadComplete = function( data ){
				
				/*if( _this.jqGridOption.radio == true ){
					_this.find('radio_' + this.gridId ).parent().width(40);
				}*/
				
				//if(  data.message != null && _this.opt.postData != null ) _this.opt.postData.lastItemId = data.message;
				if( data.rows != null ){
					if( data.rows.length == 0 ){
						_this.emptyMsgDiv.show();
					}else{
						_this.emptyMsgDiv.hide();
					}
				}
				
				if( $.errorChecker( data ) == false ){
					return;
				}
				
				_this.opt.data = data;
				
				if(_this.opt.jqGridOption.useGroupHeader) {
					_this.groupHeaderSetting();
					delete _this.opt.jqGridOption.useGroupHeader;
				}
				
				_this.pagerSetting( data );
				_this.totalSetting( data );
				_this.styleSetting();
				if(_this.jqGridOptionCopy.isRowspan) _this.rowspanSetting();
				
				//_this.setWidth( _this.width() );
				
				_this.makeEmptyRows();

				if( _this.jqGridOptionCopy.loadComplete != null ){
					_this.jqGridOptionCopy.loadComplete( data );
				};
				
			};
			
			this.rowspanSetting = function() {
				var rowGrid = this;
				$('td[name="cellRowspan"]', rowGrid).each(function() {
					var spans = $('td[rowspanid="' + this.id + '"]', rowGrid).length+1;
					if(spans>1){
						$(this).attr('rowspan', spans);
					}
				});
			};
			
			this.jqGridOption.onSelectCell = function( index, value, element, row, col ){
				if( _this.jqGridOptionCopy.onSelectCell != null ){
					if( _this.isRadioAreaClick(col) ) return;
					
					if( _this.opt.data == null ){
						_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, index );
					}else if( _this.opt.keyName != null ){
						for( var i = 0; i<_this.opt.data.rows.length; i++ ){
							if( _this.opt.data.rows[i][_this.opt.keyName] == index ){
								_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[i] );
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] ); 
					}
				};
			};
			
            var _index = 0;
            
            this.jqGridOption.onSelectRow = function(index, value) {
            	/* selectRow ?�벤?? 2�? 발생 방�? 체크. 2018.01.02 knlee */
            	if(_index == index) return;
            	 _index = index;

            	 if( _this.jqGridOptionCopy.onSelectRow != null ){
					
					if( _this.opt.data == null ){
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, index );
					}else if( _this.opt.keyName != null ){
						for( var i = 0; i<_this.opt.data.rows.length; i++ ){
							if( _this.opt.data.rows[i][_this.opt.keyName] == index ){
								_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[i] );
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] );
					}
				};
			};
			
			this.jqGridOption.onCellSelect = function( id, colIndex ){
				
				if( _this.jqGridOptionCopy.onCellSelect != null ){
					
					if( _this.isRadioAreaClick(colIndex) ) return;
					var obj = _this.opt.grid.getRowData( id );
					obj.rowId = id;
					obj.colIndex = colIndex;
					_this.jqGridOptionCopy.onCellSelect.call( _this.jqGridOption.scope, obj );
				}
			};
			
		};
		
		this.isRadioAreaClick = function(colIndex){
			return this.jqGridOption.radio == true && colIndex == 0;
		};
		
		/**
		 * 
		 * public method
		 * 
		 */
		
		this.resetChecked = function(){
			this.opt.grid.resetSelection();
		};
		
		this.setCheckRow = function( list ){
			
			var checkedArr = this.opt.grid.getGridParam('selarrrow');
			
			for( var i = 0; i < this.opt.data.rows.length; i++ ){
				var id = list[i];
				if( checkedArr.indexOf( list[i] ) < 0 ){
					this.opt.grid.setSelection( id, false);
				}
			};
		};
		
		this.getRowData = function(){
			if( this.opt.grid == null ) return [];
			if( this.jqGridOption.cellsubmit != null )
				this.opt.grid.editCell(0,0,false);
			return this.opt.grid.getRowData();
		};
		
		this.getRowDatas = function(rowId) {
			var selrowId;
			if(typeof rowId != "undefined")
				selrowId = rowId;
			else
				selrowId =  this.opt.grid.jqGrid('getGridParam','selrow');
			var selrowData = this.opt.grid.jqGrid('getRowData', selrowId);
			return selrowData;
		}


		this.setRowDatas = function(data) {
			var selrowId =  this.opt.grid.jqGrid('getGridParam','selrow');
			this.opt.grid.jqGrid('setRowData', selrowId, data);
		}
		
		this.getSum = function(cName, vName) {
			return this.opt.grid.jqGrid('getCol', cName, false, vName);
		}
		
		this.setFooter = function(data){
			this.opt.grid.jqGrid("footerData", "set", data);
			
			var rowDatas = this.opt.grid.getRowData();
			if( rowDatas.length == 0 )
				$("#" + this.attr('id') + " .ui-jqgrid-sdiv").hide();
			else
				$("#" + this.attr('id') + " .ui-jqgrid-sdiv").show();
		}
		
		this.setColspanTotal = function( arr ){
			
			var footRow = $("#" + this.attr('id') ).find(".footrow");
			var nameArr = [];
			var width2 = 0;
			
			for( var i=0; i<arr.length; i++){
				var item = footRow.find('>td[aria-describedby="gridId' + this.attr('id') + '_'+ arr[i] +'"]');
				nameArr.push(item);
				if( i == 0 ){
					width2 += item.width();
				}else {
					width2 += item.outerWidth();
				}
			}
			
			for( var i=0; i<arr.length; i++){
				if( i !== 0 ){
					nameArr[i].hide();
				}
			}
			
			nameArr[0].attr("colspan", nameArr.length).width(width2);
		}
		
		this.groupHeaderSetting = function() {
			this.opt.grid.jqGrid('setGroupHeaders', this.opt.jqGridOption.useGroupHeader);
		}
		
		this.getCheckedList = function(){
			var selectlist = this.getCheckedRowIds();
			var returnList = [];
			for( var i = 0; i<this.opt.data.rows.length; i++ ){
				if( selectlist.indexOf( String(i + 1) ) > -1 ){
					returnList.push( this.opt.data.rows[i] );
				}
			}
			return returnList;
		};
		
		this.getCheckedGridData = function(){
			
			var selectlist = this.getCheckedRowIds();
			
			var returnList = [];
			for( var i = 0; i<selectlist.length; i++ ){
				var obj = this.opt.grid.getRowData( selectlist[i] );
				obj.rowId = selectlist[i];
				returnList.push( obj );
			}
			return returnList;	
		};
		
		this.getRadioSelectedRowId = function(){
			var radioArr = this.opt.grid.find('[name=radio_' + this.gridId + ']:checked').parent().parent();
			var arr = [];
			for( var i = 0; i < radioArr.length; i++ ){
				arr.push( $(radioArr[i]).attr('id') );
			}
			return arr;
		};
		
		this.delCheckedRow = function(){
			if( this.jqGridOption.cellsubmit != null )
				this.opt.grid.editCell(0,0,false);
			
			var _this = this;
			var selectlist = this.getCheckedRowIds();
			var deleList = [];
			for( var i = 0; i < selectlist.length; i++ ){
				deleList.push( selectlist[i] );
			}
			$.each(deleList,function(i,v){
				_this.opt.grid.delRowData( v );
			});
		};
		
		this.delRowData = function(){
			if( this.jqGridOption.cellsubmit != null )
				this.opt.grid.editCell(0,0,false);
			
			var ids = this.getCheckedRowIds();
		     var length = ids.length;
		     for( var i = length-1; i>-1; i-- ){
		    	 this.opt.grid.delRowData( ids[i] );
		     }
		};

        this.getSelectedRowId = function() {
			return this.opt.grid.getGridParam('selrow');
		}
		
		this.getSelectedRowData = function() {
			var selrowid = this.getSelectedRowId();
			return this.getRowDatas(selrowid);
		}
		
		this.getCheckedRowIds = function(){
			var selectlist = [];
			if( this.jqGridOption.radio == true ){
				selectlist = this.getRadioSelectedRowId();
			}else{
				selectlist = this.opt.grid.getGridParam('selarrrow');
			}
			return selectlist;
		};
		
		this.getAllRowIds = function(){
			var selectlist = [];		
			selectlist = this.opt.grid.jqGrid('getDataIDs');
			return selectlist;
		};
		
		this.removeAll = function(){
			this.opt.grid.jqGrid('clearGridData');
		};
		
		this.addLocalTr = function( obj ){
			this.emptyMsgDiv.hide();
			
			this.trNum++;
			var id = this.attr('id') + this.trNum;
			this.opt.grid.jqGrid('addRowData', id, obj || {} );
			
			this.cssSetting();

		};
		
		this.editCell = function(rowId, colIndex, active ){
			if( this.opt.grid.find(".edit-cell").length > 0 ){
				this.opt.grid.editCell( rowId, colIndex, active);
			}
		};

		this.setLabel = function(obj){
			if(obj.length == 0) return;
			for(var i = 0; i < obj.length; i++) {
				this.opt.grid.jqGrid('setLabel', obj[i].colName, obj[i].newName, obj[i].styleType);				
			}
		};

        this.setSelection = function(rowId) {
        	this.opt.grid.jqGrid('setSelection', rowId);
        	if (this.jqGridOption.radio == true)
        		$('#gridId' + this.attr('id')).find('tr#' + rowId + ' input[type=radio]').prop('checked', true);
        }
		this.jqGridOption = {
				ajaxGridOptions: {
	                contentType: 'application/json',
	                type: 'POST',
	                beforeSend : function(){
	                	var progTxt = MESSAGE.common.gridProgressTxt || '조회';
	                	$.ifvProgressControl(true, null, progTxt);
	                	$.setProgressZindex();
	                },
	                complete : function() {
	                	$.ifvProgressControl(false);
	                }
	            },
	        jsonReader: {
				repeatitems : false,
	            page: 'page',
	            total: 'total',
	            root: 'rows',
	            records : 'records',
	            id: 'colId'
	        },
	        serializeCellData : function(obj){
				delete obj.oper;
				return JSON.stringify(obj);
			},
	        datatype: "json",
	        colNames:[],
	        postData : { 
	        	searchWord : '', 
	        	searchText : '', 
	        	page : 1 ,
	        	appServiceId : window.appServiceId, 
	        	country : window.country, 
	        	lang : window.lang
	        },
	        colModel:[],
	        rowNum:10,
	        height:'auto',
	        rowList:[10,20,30],
	        pager: '',
	        //autowidth : true,
	        total : ifv.commonMessage.total + ' : {total}' + ifv.commonMessage.gun,
	        caption:"",
	        tempId : "ifvGridNonFilterTemplete",
	        emptyMsg : ifv.commonMessage.noData,
	        emptyRows : 0,
	        scope : null
		};
		
		this.init();

		return this;
	};
})(jQuery);
//jsonpgrid
(function($){
	/**
	 *
	 * @class ifvJSONPGrid
	 *
	 */
	$.fn.ifvJSONPGrid = function(options){
		options.url += '?callback=?';
		this.opt = $.extend({
			searchBox : null,
			rowsBox : null,
			grid : null,
			gridPage : null,
			page : null,
			pager : null,
			data : null,
			gridId : null,
			postData : null,
			keyName : null,
			isRsizeTime : false,
			jqGridOptionCopy : null,
			isRowspan : false,
			trNum : 0

		}, options);

		this.init = function(){

			$.extend( options.jqGridOption.ajaxGridOptions, this.jqGridOption.ajaxGridOptions );	//ajaxGridOptions override
			$.extend( this.jqGridOption, options.jqGridOption );
			//$.extend( this.jqGridOption.url, options.jqGridOption.url + '?callback=?' );
			//this.jqGridOption.url += '?callback=?';
			this.jqGridOption.caption = null;	//jqgrid湲곕낯 ���댄� �덉벐�ㅺ퀬

			//20160728 sj.baek - rowspan 기능이 들어갈 경우 hover 및 highlight style 제거를 위해 class 추가
			if(this.opt.isRowspan) this.addClass('rowspan_grid');

			this.trNum = 0;

			this.optionSetting();

			this.uiSetting();
			this.keyCheck();
			this.makeGrid();
			this.titleInit();
			this.rowBoxInit();
			this.searchBoxInit();
			this.btnInit();

			if( this.jqGridOption.url == null || this.jqGridOption.ajaxGridOptions.async == false ){	//�쒕쾭�듭떊�놁쓣�쒖� 鍮꾨룞湲곗씪�� td�쒓컻 �앹꽦
				if( this.jqGridOption.emptyRows == 0 ){
					var rowDatas = this.opt.grid.getRowData();
					if( rowDatas.length == 0 ){
						this.emptyMsgDiv.show();
					}
				}else{
					this.makeEmptyRows();
				}
			}
		};

		this.setEmptyRows = function(emptyRows){
			this.jqGridOption.emptyRows = emptyRows;
			this.makeEmptyRows();
		};

		this.makeEmptyRows = function(){
			if( this.opt.grid == null ) return;	//sync�쇰븣�� jqgrid媛� �몄뒪�댁뒪�� �섍린 �꾩뿉 loadComplete媛� �⑥뼱�몄꽌 由ы꽩 init�먯꽌 �ㅼ떆 �몄텧��
			var dataRow = this.getRowData();
			var length = this.jqGridOption.emptyRows - dataRow.length;

			for( var i = 0; i < length; i++ ){
				this.addLocalTr();
			}
		};

		this.addRows = function(list){
			for( var i = 0; i < list.length; i++ ){
				this.addLocalTr(list[i]);
			}
			this.makeEmptyRows();
		};

		this.optionSetting = function(){

			var _this = this;

			this.jqGridOption.rowNum = this.jqGridOption.rowList[0];	//default rowNum

			// 理쒖씤��. 20150515 �좎옄 �낅젰�� �쒓컙or 遺꾩씠 �쒕�濡� �덈굹�ㅻ뒗 �ㅻ쪟 �섏젙.
			var colModels = this.jqGridOption.colModel;
			for ( var i=0, l=colModels.length; i<l; i++ ) {
			    if ( colModels[i].formatter == 'date') {
			        colModels[i].formatoptions.srcformat = 'Y-m-d H:i:s';
			    }
			}

			//cellurl�� �덉쑝硫� cell�섏젙紐⑤뱶 �듭뀡 異붽�
			if( this.jqGridOption.cellurl != null || this.jqGridOption.cellurl == "" ){
				this.jqGridOption.ajaxCellOptions = { contentType: 'application/json', type: 'POST' };
				this.jqGridOption.cellEdit = true;
				this.jqGridOption.cellsubmit = 'remote';
			}

			if( this.jqGridOption.onSelectCell != null ){
				this.jqGridOption.cellEdit = true;	//cellEdit媛� true �쇰븣留� onSelectCell �대깽�� 諛쒖깮
			}

			if( this.jqGridOption.radio == true ){
				this.radioSetting();
				/*this.jqGridOption.multiselect = true;
				this.jqGridOption.beforeSelectRow = function(){
					if( _this.jqGridOption.cellEdit == true ){
						_this.find( '[aria-describedby=' + _this.gridId + '_cb]' ).find('input[type=checkbox]').prop('checked', false );
					}else{
						_this.opt.grid.jqGrid('resetSelection');
					}
					return(true);
				};*/
			}

			if( this.jqGridOption.seq == true ){
				this.seqSetting();
			}

			for( var i = 0; i < this.jqGridOption.colModel.length; i++ ){
				if( this.jqGridOption.colModel[i] != null && this.jqGridOption.colModel[i].width == null ){
					this.jqGridOption.colModel[i].width = 'auto';
				}
			}

		};

		this.radioSetting = function(){
			var _this = this;
			var obj = { name : 'radio', align : 'center', width:45, editable : false, edittype : "radio", 
					customAttributes: { sortable : false, searchable :false }
				,formatter: function( cellValue, option ){
        			return '<input type="radio" name="radio_' + _this.gridId + '"  />';
    			}
			};
			this.jqGridOption.colNames.unshift( ifv.commonMessage.select );
			this.jqGridOption.colModel.unshift(obj);

			this.jqGridOption.beforeSelectRow = function( rowid, e ){
		        var $radio = $(e.target).closest('tr').find('input[type="radio"]');
		        $radio.attr('checked', 'checked');
		        $(this).setSelection(rowid, true);
		        return true; // allow row selection
		    };
		};

		this.titleInit = function(){
			var title = options.jqGridOption.caption;
			if( title != null && title != "" ){
				this.opt.title.html( title );
			}else{
				this.opt.title.remove();
			}
		};

		this.btnInit = function(){
			var _this = this;

			if( this.opt.rowsBox != null ){
				this.opt.btnAdd.click(function() {
					if( _this.jqGridOption.cellEdit == true ){

						if( _this.opt.data != null && _this.opt.data.rows != null ){
							_this.opt.grid.jqJSONPGrid('addRowData', _this.opt.data.rows.length, {} );
						}else{
							//�쒕쾭�듭떊�덊븳�곹깭�먯꽌 tr異붽� �좊븣
							_this.addLocalTr();
						}
					}else if( _this.jqGridOption.addBtnClick != null ){
						_this.jqGridOption.addBtnClick();
					}
				});
			}

			if( this.jqGridOption.multiselect == true ){
				if( this.opt.btnDelete != null ){
					this.opt.btnDelete.click(function() {
					     _this.delRowData();
					});
				}
			}
		};


		this.keyCheck = function(){
			for( var i = 0; i<this.jqGridOption.colModel.length; i++ ){
				if( this.jqGridOption.colModel[i].key != null ){
					this.opt.keyName = this.jqGridOption.colModel[i].name;
					break;
				}
			}
		};

		/*
		 * ui �ы뵆由� �쎌뼱�ㅼ뿬�� 而댄띁�뚰듃 �쒓렇濡� 蹂���
		 */
		this.uiSetting = function(){

			var con = $("#" + this.jqGridOption.tempId ).html();

			this.gridId = "gridId" + this.attr('id');

			con = con.replace('{searchBox}', '<div class="search_box" gridId="searchBox" ></div>' );
			con = con.replace('{rowsBox}', '<input class="combo_num_box" gridId="rowsBox" />' );
			con = con.replace('{grid}', '<table gridId="grid" id="' + this.gridId + '"></table>' );
			con = con.replace('{gridPage}', '<div gridId="gridPage" id="gridPage" ></div>' );
			con = con.replace('{page}', '<div gridId="page" ></div>' );
			con = con.replace('{total}', '<div gridId="total" ></div>' );
			con = con.replace('{btnAdd}', '<input type="button" class="btnAdd" gridId="btnAdd" value="�깅줉"/>' );
			con = con.replace('{btnDelete}', '<input type="button" class="btnDelete" gridId="btnDelete" value="��젣"/>' );
			con = con.replace('{title}', '<div gridId="title" class="title"/>' );

			this.html(con);

			this.opt.searchBox = this.find("[gridId=searchBox]");
			this.opt.rowsBox = this.find("[gridId=rowsBox]");
			this.opt.gridPage = this.find("[gridId=gridPage]");
			this.opt.page = this.find("[gridId=page]");
			this.opt.total = this.find("[gridId=total]");
			this.opt.btnAdd = this.find("[gridId=btnAdd]");
			this.opt.btnDelete = this.find("[gridId=btnDelete]");
			this.opt.title = this.find("[gridId=title]");

		};

		this.makeEmptyDiv = function(){
			//�곗씠���놁쓣�� �섏삤�� �곸뿭
			this.emptyMsgDiv = $('<div class="empty_msg"></div>');
			this.emptyMsgDiv.text( this.jqGridOption.emptyMsg );
		};


		/**
		 * jqGrid �앹꽦
		 */
		this.makeGrid = function(){
			this.makeEmptyDiv();
			this.resizeEvent();
			this.gridEventOverride();
			this.jqGridOption.gridId = this.attr('id');
			this.opt.grid = this.find("[gridId=grid]").jqJSONPGrid( this.jqGridOption );
			this.opt.grid.navGrid( "#gridPage", { closeOnEscape:false, del:false, add:false, edit:false, search:false, refresh:false });

			this.emptyMsgDiv.insertAfter( this.opt.grid.parent() );

			$('.ui-pg-selbox').hide();	//湲곕낯 �섏씠吏� ���됲듃 諛뺤뒪 �④린湲�
			$('.ui-jqgrid-titlebar-close.HeaderButton').hide(); //湲곕낯 �묎린 踰꾪듉 �④린湲�

			/*if( this.jqGridOption.radio == true ){
				this.find('.ui-jqgrid-hbox').find('input[type=checkbox]')[0].style.display = "none";
			}*/
			this.setWidth( this.width() );
		};

		this.styleSetting = function(){
			if( this.jqGridOption.onSelectCell != null && this.opt.grid != null && this.jqGridOption.usePointer != false){
				this.opt.grid.find('td').css({ cursor: "pointer" });
			}

			this.cssSetting();
		};

		this.cssSetting = function(){
			if( this.jqGridOption.multiselect == true && this.opt.grid != null ){
				this.opt.grid.find(".cbox").parent().addClass('cbox_parent');
			}
		};

		this.resizeEvent = function(){

			var _this = this;
			var timer = null;
		    $(window).bind('resize', function() {

		    	if( timer != null ){
		    		clearTimeout( timer );
		    	}
		    	timer = setTimeout(function(){
		    		_this.setWidth( _this.width() );
		    	}, 250);
		    });
		};

		this.setWidth = function( width ){

			if( this.opt.grid != null ){
				this.find('.ui-jqgrid-view').width( width );
				this.find('.ui-state-default.ui-jqgrid-hdiv').width( width );
				this.find('.ui-jqgrid-bdiv').width( width );
				this.find('.ui-jqgrid-hbox table').width( width );
		    	this.find('.ui-jqgrid-bdiv table').width( width );
		    	$("#gbox_" + this.gridId ).width( width ); //gbox ( grid�꾩껜 媛먯떥怨좎엳�� div ) width 蹂�寃�
				//this.opt.grid.setGridWidth( width, false);
			}
		};

		/**
		 *	row ���됲듃 諛뺤뒪 珥덇린��
		 */
		this.rowBoxInit = function(){
            if( this.opt.rowsBox == null ) return;

            var arr = [];
            for( var i = 0; i < this.jqGridOption.rowList.length; i++ ){
            	var obj = { value : this.jqGridOption.rowList[i], key : this.jqGridOption.rowList[i] };
            	if( i == 0 ) obj.selected = true;
            	arr.push( obj );
            }

            var selectbox = this.opt.rowsBox.ifvSelectBox();

            var _this = this;
            selectbox.setData(arr, function(obj){
            	//寃��됱떆�먮뒗 �좏깉 媛�닔 諛붾�뚮�濡� �섏씠吏��ㅼ떆 留뚮벉 page�� 1濡�
            	_this.pageInit();

            	_this.jqGridOption.rowNum = obj.key;
            	_this.opt.grid.setGridParam({ rowNum:obj.key });
            	_this.opt.grid.trigger("reloadGrid");

            });
        };
        
        /**
		 *	寃��� 諛뺤뒪 珥덇린��
		 */
        this.searchBoxInit = function(){

            if( this.opt.searchBox == null ) return;

            var headArr = [];
            var count = 0;
            for( var i = 0; i< this.jqGridOption.colNames.length; i++ ){
            	if( this.jqGridOption.colModel[i].hidden != true && ( this.jqGridOption.colModel[i].searchable == null || this.jqGridOption.colModel[i].searchable ) ){
            		headArr.push( {value: this.jqGridOption.colNames[count], key : this.jqGridOption.colModel[i].index }); //colModel�� hidden�� �덉쑝誘�濡� count濡� indexing
            	}
            	if( this.jqGridOption.colModel[i].hidden != true ){
            		count++;
            	}
            }

            var _this = this;
            var searchBox = this.opt.searchBox.ifvSearchBox({ watermark : this.jqGridOption.searchInputWatermark });
            searchBox.setData( headArr, function( searchObj ){

            	//寃��됱떆�먮뒗 �좏깉 媛�닔 諛붾�뚮�濡� �섏씠吏��ㅼ떆 留뚮벉 page�� 1濡�
            	_this.pageInit();

				$.extend( _this.opt.postData, searchObj);
            	_this.opt.grid.setGridParam({ postData : _this.opt.postData });
            	_this.opt.grid.trigger("reloadGrid");

            });
        };

        /**
		 * postData �ㅻ쾭�쇱씠�쒗썑 �쒕퉬�� �붿껌
		 */
        this.requestData = function(obj){

        	this.pageInit();

        	$.extend( this.opt.postData, obj);

        	this.opt.grid.setGridParam({ postData : this.opt.postData });
        	this.opt.grid.trigger("reloadGrid");
        };

        this.pageInit = function(){
        	if( this.opt.pager != null ){
        		this.opt.pager.empty();
            	this.opt.pager = null;
            	this.opt.grid.setGridParam({ page : 1 });
            	this.opt.postData.page = 1;
        	}
        };

        /*
		 * �섏씠吏� �뗮똿 諛� 蹂���
		 */
		this.pagerSetting = function( data ){

			if( this.opt.pager == null ){
				var _this = this;
				this.opt.pager = this.opt.page.ifvSimplePager({
					dataObj : { rows : _this.jqGridOption.rowNum },
					callback: function( page ){
						_this.opt.postData.page = page;
						_this.opt.grid.setGridParam({ page : page });
		            	_this.opt.grid.trigger("reloadGrid");
					}
				});
				this.opt.pager.change( data );
			}
		};

		/*
		 * �좏깉 �뗮똿
		 */
		this.totalSetting = function( data ){
			if (!data.records) data.records = 0;
			var txt = this.jqGridOption.total.replace('{total}', data.records );
			this.opt.total.text( txt );
		};

        /*
         * �ъ슜�� �ㅼ젙 option �댁뿉 �⑥닔 �ㅼ젙
         */
		this.gridEventOverride = function(){
			this.jqGridOptionCopy = $.extend({}, this.jqGridOption );	//�ъ슜�� �ㅼ젙 option����

			var _this = this;
			//jqGrid�먯꽌 �섏뼱�ㅻ뒗 �⑥닔

			//�쒕쾭�� �곗씠�� 蹂대궡湲� �� requestData �뗮똿
			this.jqGridOption.serializeGridData = function( data ) {

				if( _this.opt.postData == null ){	//理쒖큹�먮쭔 init �곗씠�� �ㅻ쾭�쇱씠��
					_this.opt.postData = {};
					if( _this.jqGridOptionCopy.serializeGridData != null ){
						var userData = _this.jqGridOptionCopy.serializeGridData( data );//�ъ슜�� �뺤쓽 �⑥닔 �몄텧
						$.extend( _this.opt.postData, userData );
					};
				}
				var savePage = _this.opt.postData.page;

	        	$.extend( _this.opt.postData, data );

	        	_this.opt.postData.page = savePage; //page�� grid�� page踰덊샇瑜� �덉벐怨� pager�� page踰덊샇瑜쇱벖��( sort�� gqrid�뷀럹�댁�1濡� 諛붽씀吏�留� ifv�� �덈컮袁몃뒗寃껋씠 洹쒖튃)

	            return JSON.stringify(_this.opt.postData);
			};

			//resposeData �뗮똿
			this.jqGridOption.loadComplete = function( data ){

				/*if( _this.jqGridOption.radio == true ){
					_this.find('radio_' + this.gridId ).parent().width(40);
				}*/

				//if(  data.message != null && _this.opt.postData != null ) _this.opt.postData.lastItemId = data.message;	//�쒕쾭�먯꽌 lastItemId�� 以꾧꼍�곕쭔 �ㅼ떆 二쇨린�꾪빐 ����
				if( data.rows != null ){
					if( data.rows.length == 0 ){
						_this.emptyMsgDiv.show();
					}else{
						_this.emptyMsgDiv.hide();
					}
				}

				if( $.errorChecker( data ) == false ){
					return;
				}

				_this.opt.data = data;

				_this.pagerSetting( data );
				_this.totalSetting( data );
				_this.styleSetting();
				if(_this.jqGridOptionCopy.isRowspan) _this.rowspanSetting();

				//_this.setWidth( _this.width() );

				_this.makeEmptyRows();

				//�꾩튂 蹂�寃� 15.10.14 hj.seo
				if( _this.jqGridOptionCopy.loadComplete != null ){
					_this.jqGridOptionCopy.loadComplete( data );//�ъ슜�� �뺤쓽 �⑥닔 �몄텧
				};

			};

			this.rowspanSetting = function() {
				var rowGrid = this;
				$('td[name="cellRowspan"]', rowGrid).each(function() {
					var spans = $('td[rowspanid="' + this.id + '"]', rowGrid).length+1;
					if(spans>1){
						$(this).attr('rowspan', spans);
					}
				});
			};

			this.jqGridOption.onSelectCell = function( index, value, element, row, col ){
				if( _this.jqGridOptionCopy.onSelectCell != null ){
					if( _this.isRadioAreaClick(col) ) return;

					if( _this.opt.data == null ){
						_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, index );
					}else if( _this.opt.keyName != null ){
						for( var i = 0; i<_this.opt.data.rows.length; i++ ){
							if( _this.opt.data.rows[i][_this.opt.keyName] == index ){
								_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[i] ); //�ъ슜�� �뺤쓽 �⑥닔 �몄텧
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] );   //�ъ슜�� �뺤쓽 �⑥닔 �몄텧
					}
				};
			};

			this.jqGridOption.onSelectRow = function( index, value ){
				if( _this.jqGridOptionCopy.onSelectRow != null ){

					if( _this.opt.data == null ){
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, index );
					}else if( _this.opt.keyName != null ){
						for( var i = 0; i<_this.opt.data.rows.length; i++ ){
							if( _this.opt.data.rows[i][_this.opt.keyName] == index ){
								_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[i] );//�ъ슜�� �뺤쓽 �⑥닔 �몄텧
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] );//�ъ슜�� �뺤쓽 �⑥닔 �몄텧
					}
				};
			};

			this.jqGridOption.onCellSelect = function( id, colIndex ){

				if( _this.jqGridOptionCopy.onCellSelect != null ){

					if( _this.isRadioAreaClick(colIndex) ) return;
					var obj = _this.opt.grid.getRowData( id );
					obj.rowId = id;
					obj.colIndex = colIndex;
					_this.jqGridOptionCopy.onCellSelect.call( _this.jqGridOption.scope, obj );
				}
			};

		};

		this.isRadioAreaClick = function(colIndex){
			return this.jqGridOption.radio == true && colIndex == 0;
		};

		/**
		 *
		 * public method
		 *
		 */

		this.resetChecked = function(){
			this.opt.grid.resetSelection();
		};

		this.setCheckRow = function( list ){

			var checkedArr = this.opt.grid.getGridParam('selarrrow');

			for( var i = 0; i < this.opt.data.rows.length; i++ ){
				var id = list[i];
				if( checkedArr.indexOf( list[i] ) < 0 ){
					this.opt.grid.setSelection( id, false);
				}
			};
		};

		this.getRowData = function(){
			if( this.opt.grid == null ) return [];
			if( this.jqGridOption.cellsubmit != null )	//editCell諛쒖깮�� selectCell�대깽�� 諛쒖깮�섎뒗 踰꾧렇 �뚮Ц�� 遺꾧린泥섎━
				this.opt.grid.editCell(0,0,false);	//edit以묒씤 cell�덉쑝硫� �リ린
			return this.opt.grid.getRowData();
		};

		this.getRowDatas = function(rowId) {
			var selrowId;
			if(typeof rowId != "undefined")
				selrowId = rowId;
			else
				selrowId =  this.opt.grid.jqJSONPGrid('getGridParam','selrow');
			var selrowData = this.opt.grid.jqJSONPGrid('getRowData', selrowId);
			return selrowData;
		}


		this.setRowDatas = function(data) {
			var selrowId =  this.opt.grid.jqJSONPGrid('getGridParam','selrow');
			this.opt.grid.jqJSONPGrid('setRowData', selrowId, data);
		}

		this.getCheckedList = function(){
			var selectlist = this.getCheckedRowIds();
			var returnList = [];
			for( var i = 0; i<this.opt.data.rows.length; i++ ){
				if( selectlist.indexOf( String(i + 1) ) > -1 ){
					returnList.push( this.opt.data.rows[i] );
				}
			}
			return returnList;
		};

		this.getCheckedGridData = function(){

			var selectlist = this.getCheckedRowIds();

			var returnList = [];
			for( var i = 0; i<selectlist.length; i++ ){
				var obj = this.opt.grid.getRowData( selectlist[i] );
				obj.rowId = selectlist[i];
				returnList.push( obj );
			}
			return returnList;
		};

		this.getRadioSelectedRowId = function(){
			var radioArr = this.opt.grid.find('[name=radio_' + this.gridId + ']:checked').parent().parent();
			var arr = [];
			for( var i = 0; i < radioArr.length; i++ ){
				arr.push( $(radioArr[i]).attr('id') );
			}
			return arr;
		};

		this.delCheckedRow = function(){
			if( this.jqGridOption.cellsubmit != null )	//editCell諛쒖깮�� selectCell�대깽�� 諛쒖깮�섎뒗 踰꾧렇 �뚮Ц�� 遺꾧린泥섎━
				this.opt.grid.editCell(0,0,false);	//edit以묒씤 cell�덉쑝硫� �リ린

			var _this = this;
			var selectlist = this.getCheckedRowIds();
			var deleList = [];
			for( var i = 0; i < selectlist.length; i++ ){
				deleList.push( selectlist[i] );
			}
			$.each(deleList,function(i,v){
				_this.opt.grid.delRowData( v );
			});
		};

		this.delRowData = function(){
			if( this.jqGridOption.cellsubmit != null )	//editCell諛쒖깮�� selectCell�대깽�� 諛쒖깮�섎뒗 踰꾧렇 �뚮Ц�� 遺꾧린泥섎━
				this.opt.grid.editCell(0,0,false);	//edit以묒씤 cell�덉쑝硫� �リ린

			var ids = this.getCheckedRowIds();
		     var length = ids.length;
		     for( var i = length-1; i>-1; i-- ){
		    	 this.opt.grid.delRowData( ids[i] );
		     }
		};

		this.getCheckedRowIds = function(){
			var selectlist = [];
			if( this.jqGridOption.radio == true ){
				selectlist = this.getRadioSelectedRowId();
			}else{
				selectlist = this.opt.grid.getGridParam('selarrrow');
			}
			return selectlist;
		};

		this.getAllRowIds = function(){
			var selectlist = [];
			selectlist = this.opt.grid.jqJSONPGrid('getDataIDs');
			return selectlist;
		};

		this.removeAll = function(){
			this.opt.grid.jqJSONPGrid('clearGridData');
		};

		this.addLocalTr = function( obj ){
			this.emptyMsgDiv.hide();

			this.trNum++;
			var id = this.attr('id') + this.trNum;
			this.opt.grid.jqJSONPGrid('addRowData', id, obj || {} );

			this.cssSetting();

			//this.opt.grid.find('#' + id).attr('dataObj', obj || {} );
		};

		this.editCell = function(rowId, colIndex, active ){
			if( this.opt.grid.find(".edit-cell").length > 0 ){
				this.opt.grid.editCell( rowId, colIndex, active);
			}
		};

		this.setLabel = function(obj){
			if(obj.length == 0) return;
			for(var i = 0; i < obj.length; i++) {
				this.opt.grid.jqJSONPGrid('setLabel', obj[i].colName, obj[i].newName, obj[i].styleType);
			}
		};

        /**
         * 湲곕낯 �듭뀡 �ㅼ젙, 由ы꽩func �ㅼ젙�� this.gridEventOverride�먯꽌
         */
		this.jqGridOption = {
			//ajaxGridOptions: { contentType: 'application/json', type: 'POST' },
			ajaxGridOptions: { contentType: 'application/json; charset=utf-8', type: 'GET' },
			mtype : 'GET',
	        crossDomain: true,
	       // ignoreCase: true,
			datatype: 'jsonp',
	        jsonReader: {
				repeatitems : false,
	            page: 'page',
	            total: 'total',
	            root: 'rows',
	            records : 'records',
	            id: 'colId'//瑗� �붾㈃ �꾩껜�먯꽌 寃뱀튂�� 媛믪씠 �낅뒗 column�� �ㅼ젙�� 寃� �덇렇�щ㈃ �먮윭 諛쒖깮
	        },
	        serializeCellData : function(obj){	//cell edit�� �곗씠�� json蹂���
				delete obj.oper;
				return JSON.stringify(obj);
			},
	        //datatype: "json",
	        colNames:[],
	        postData : {
	        	searchWord : '',
	        	searchText : '',
	        	page : 1 ,
	        	/* 20150511 理쒖씤�� language parameter 異붽�. */
	        	appServiceId : window.appServiceId,
	        	country : window.country,
	        	lang : window.lang
	        },
	        colModel:[],
	        rowNum:10,
	        height:'auto',
	        rowList:[10,20,30],
	        pager: '',
	        //autowidth : true,
	        total : ifv.commonMessage.total + ' : {total}' + ifv.commonMessage.gun,
	        /*sortname: 'invdate',
	        sortorder: "desc",*/
	        caption:"",
	        tempId : "ifvGridTemplete",
	        emptyMsg : ifv.commonMessage.noData,
	        emptyRows : 0,
	        scope : null
		};

		this.init();

		return this;
	};
})(jQuery);
(function($){
	$.fn.ifvAddRemove = function(options){
		
		this.opt = $.extend({
			templete : null,
			temp : null,
		}, options);
		
		
		this.init = function(){
			this.makeRow();
		};
		
		this.makeRow = function(){
			var row = $( "<div class='ifv_add_remove_row'>" );
			this.append( row );
			
			row.append($("#"+this.opt.temp).text());
			
			var addBtn = $( '<a href="javascript:;" class="btn_style search lg" pushId="btnAdd">추가</a>');
			var deleteBtn = $( '<a href="javascript:;" class="btn_style search " pushId="btnDelete">삭제</a>');
			
			row.append( addBtn );
			row.append( deleteBtn );
			
			var _this = this;
			addBtn.click(function(){
				_this.makeRow();
			});
			
			deleteBtn.click(function(){
				if( _this.children().length > 1 ){
					row.remove();
				}
			});
		};
		
		this.init();
		
		return this;
	};
})(jQuery);

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
	this.ridImage = null;
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
			
			
			if(_this.PathSetfunc) {
				$("#imgPathId").val(_this.uploadform.filelist[0].url);			
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
	    	if( _this.addFunc != null ) if(!_this.addFunc(data)) return true;
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
	                        	// alert(file.name.split('.')[1] + '<spring:message code="beacon.common.acceptFileTypes"/>');
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
if(typeof require !== 'undefined') XLSX = require('xlsx');

$.extend({
	ifvExcelReader : function(e, cond, sn, params, tc, popUrl, validUrl, uploadUrl, callback, errorCallback, btn, progressClass) {
		var progress = null;
		if( btn != null ){

			//이미 서비스 요청중일때( progress가 돌고있을때 )리턴
			var index = $.ifvRequestBtnSearch(btn);
			if (index > -1) return;

			progress = $.ifvLoading( btn, progressClass );
		}
		
		var ifid = e.delegateTarget.id;

		var files = e.target.files;
		var f = files[0];

		var result = [];
		var reader = new FileReader();
		var name = f.name;
		var fe = f.name.split('.');
		fe = fe[fe.length -1];
		var er = {};
		
		if(fe != 'xlsx' && fe != 'xls'){
			if( progress != null ) $(progress).remove();
			$.ifvRemoveRequestBtn(btn);
			errorCallback({success: false, errorType: 'extension'})
		}
		
		reader.onload = function(e) {
			var data = e.target.result;
			var sbinary = "";
			if(!FileReader.prototype.readAsBinaryString) {
				var sbytes = new Uint8Array(data);
				var slength = sbytes.byteLength;
				for (var i = 0; i < slength; i++) {
					sbinary += String.fromCharCode(sbytes[i]);
				}
		        data = sbinary;
			}
			
			var workbook = XLSX.read(data, {type: 'binary'});
			
			if(typeof sn != 'undefined' && sn.length > 0) {
				for(var i = 0; i < sn.length; i++) {
					var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sn[i]], cond);
					if(roa.errorList.length > 0 ){
						for(var j = 0; j < roa.errorList.length; j++){
							var rrow = {};
							rrow.sheet = sn[i];
							rrow.col = roa.errorList[j].col; 
							rrow.errorType = $.ifvChangeExcelValiString(roa.errorList[j].errorType);
							result.push(rrow);
						}
					}
				}
			} else {
				workbook.SheetNames.forEach(function(sheetName) {
					var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName], cond);
					if(roa.errorList.length > 0 ){
						for(var j = 0; j < roa.errorList.length; j++){
							var rrow = {};
							rrow.sheet = sheetName;
							rrow.col = roa.errorList[j].col; 
							rrow.errorType = $.ifvChangeExcelValiString(roa.errorList[j].errorType);
							result.push(rrow);
						}
					}
				});
			}
			
			if(result.length < 1){
				var formData = new FormData();
				formData.append("file", $('#' + ifid)[0].files[0]);
				formData.tc = tc;
				if(typeof params != 'undefined') {
					var ols = Object.keys(params).length;
					for(var i = 0; i < ols; i++) {
						formData.append(Object.keys(params)[i], params[Object.keys(params)[i]]);
					}
				}
				$.ifvFilePostJSON(
					validUrl
					, formData
					, function(data) {
						if( progress != null ) $(progress).remove();
						$.ifvRemoveRequestBtn(btn);
						//result에 때려박기
						result = data;
						if(result.length < 1) {
							var formData = new FormData();
							formData.append("file", $('#' + ifid)[0].files[0]);
							if(typeof params != 'undefined') {
								var ols = Object.keys(params).length;
								for(var i = 0; i < ols; i++) {
									formData.append(Object.keys(params)[i], params[Object.keys(params)[i]]);
								}
							}
							
							$.ifvFilePostJSON(
								uploadUrl
								, formData
								, function(data) {
									callback(data);
								}, function(data) {
									errorCallback(data);
								}
							)
						} else {
							for(var i = 0; i < result.length; i++) {
								result[i].errorType = ifv.validationMessage.overlap;
							}
							openEPop(popUrl, result, callback, errorCallback, progress, btn);							
						}
					}, function(data) {
						//팝업호출함수설정
						if( progress != null ) $(progress).remove();
						$.ifvRemoveRequestBtn(btn);
						return false;
					}
				);
				
			}
			else {
				openEPop(popUrl, result, callback, errorCallback, progress, btn);
			}
			
			function openEPop(popUrl, result, callback, errorCallback, progress, btn) {
				if( progress != null ) $(progress).remove();
				$.ifvRemoveRequestBtn(btn);
				$.ifvLoadPop({url :popUrl, params : {list : result}, close: function(){
					
				}});
			}
		}
		
		if (!FileReader.prototype.readAsBinaryString) {
	       reader.readAsArrayBuffer(f);
		} else {
			reader.readAsBinaryString(f);
		}
	},
	
	ifvChangeExcelValiString : function(s) {
		switch(s) {
			case 'maxLengthCheck' :
				return ifv.validationMessage.maxLength;
				break;
			case 'emptyCheck' :
				return ifv.validationMessage.empty;
				break;
			case 'overlapCheck' :
				return ifv.validationMessage.overlap;
				break;
			case 'floatCheck' :
				return ifv.validationMessage.float;
				break;
			case 'phoneCheck' :
				return ifv.validationMessage.globalPhone;
				break;
			case 'latCheck' :
				return ifv.validationMessage.lat;
				break;
			case 'lngCheck' :
				return ifv.validationMessage.lng;
				break;
			default :
				break;
		}
	}
});

(function($){
	/**
	 * 
	 * @class ifvsfPopup
	 * 
	 */
	$.fn.ifvsfPopup = function(options){
        var _this = this;

        var attrId = _this.attr('id');

		// 팝업 close 용 popup stack 생성
		window["popups"] = (typeof window["popups"] === "undefined") ? [] : window["popups"];
		window["popups"].push(attrId);

        window[this.attr('id')]; //전역변수 생성
        var pwid = options.width ? typeof options.width != "number" ? Number(options.width.replace('px', '')) : options.width : 600;
        var posx = Math.ceil((window.innerWidth - pwid)/2);
        var openCallback = function(args) {
        	if( window[attrId + '_init'] != null ) window[attrId + '_init'](_this.opt.params);
        	if(options.open) {
        		typeof options.open == "string" ? window[options.open](args) : options.open(args); 
        	}
        }
        this.opt = $.extend({
        	enableModal : true,
            enableResize: false,
            contentType: "ajax",
            width: 600,
            maxWidth: 1024,
			//데상트 요청으로 팝업 상위로 포커싱되는거 주석 처리 hr.noh 2022.03.31
            //position : {X: posx, Y:50},
            close: function() {
				window["popups"].pop();
				window[attrId].destroy();
				delete window[attrId];
            }
        }, options);
        this.opt.open = openCallback;
        
        this.init = function() {
            this.ejDialog(this.opt);
            window[attrId] = this.data("ejDialog");
        };

        this.init();

        return this;
	};
	$.fn.ifvsfPopupWidthUp = function(options){
		var _this = this;

		var attrId = _this.attr('id');

		// 팝업 close 용 popup stack 생성
		window["popups"] = (typeof window["popups"] === "undefined") ? [] : window["popups"];
		window["popups"].push(attrId);

		window[this.attr('id')]; //전역변수 생성
		var pwid = options.width ? typeof options.width != "number" ? Number(options.width.replace('px', '')) : options.width : 600;
		var posx = Math.ceil((window.innerWidth - pwid)/2);
		var openCallback = function(args) {
			if( window[attrId + '_init'] != null ) window[attrId + '_init'](_this.opt.params);
			if(options.open) {
				typeof options.open == "string" ? window[options.open](args) : options.open(args);
			}
		}
		this.opt = $.extend({
			enableModal : true,
			enableResize: false,
			contentType: "ajax",
			width: 600,
			maxWidth: 2048,
			//데상트 요청으로 팝업 상위로 포커싱되는거 주석 처리 hr.noh 2022.03.31
			//position : {X: posx, Y:50},
			close: function() {
				window["popups"].pop();
				window[attrId].destroy();
				delete window[attrId];
			}
		}, options);
		this.opt.open = openCallback;

		this.init = function() {
			this.ejDialog(this.opt);
			window[attrId] = this.data("ejDialog");
		};

		this.init();

		return this;
	};
})(jQuery);

(function($){
	/**
	 * 
	 * @class ifvsfDialog
	 * 
	 */
	$.fn.ifvsfDialog = function(options){
        var _this = this;
        window[this.attr('id')]; //전역변수 생성
        var pwid = options.width ? typeof options.width != "number" ? Number(options.width.replace('px', '')) : options.width : 600;
        var posx = Math.ceil((window.innerWidth - pwid)/2);

        this.opt = $.extend({
            enableModal: true,
            enableResize: false,
            contentType: "ajax",
            width: 600,
            maxWidth: 1024,
            maxHeight: 700,
            position : {X: posx, Y:50},
            close: function() {
                window[_this.attr('id')]._destroy();
            }
        }, options);

        this.init = function() {
            this.ejDialog(this.opt);
            window[_this.attr('id')] = this.data("ejDialog");
            window.currentPopupId = _this.attr('id') 
        };
		
		this.init();

		return this;
	};
})(jQuery);
(function($){
	/**
	 * 
	 * @class ifvsfTab
	 * 
	 */
	$.fn.ifvsfTab = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			
		}, options);
		
		this.init = function(){
			this.addTab();
			
			this.ejTab(this.opt);
			window[_this.attr('id')] = this.data("ejTab");
		};
		
		this.addTab = function(){
			if( this.opt.tabId != null && this.opt.msgCode != null ){
				this.append('<ul>');
				for(var i=0; i<this.opt.tabId.length; i++){
					this.children('ul').append('<li><a href="#'+ this.opt.tabId[i] +'">'+ this.opt.msgCode[i] +'</a></li>');
					this.append('<div id="'+ this.opt.tabId[i] +'">');
				}
			}
		}
		
		this.init();

		return this;
	};
})(jQuery);

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

(function($){
	/**
	 * 
	 * @class ifvsfAccordion
	 * 
	 */
	$.fn.ifvsfAccordion = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejAccordion(this.opt);
			window[_this.attr('id')] = this.data("ejAccordion");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);

(function($){
	/**
	 * 
	 * @class ifvsfChart
	 * 
	 */
	$.fn.ifvsfChart = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejChart(this.opt);
			window[_this.attr('id')] = this.data("ejChart");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);

(function($){
	/**
	 * 
	 * @class ifvsfDiagram
	 * 
	 */
	$.fn.ifvsfDiagram = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성

		this.opt = $.extend({
			constraints:DiagramConstraints.Default | DiagramConstraints.Bridging 
		}, options);
		
		this.init = function(){
			
			this.ejDiagram(this.opt);
			window[_this.attr('id')] = this.data("ejDiagram");
		};
		
		this.init();

		return this;
	};
})(jQuery);

(function($){
	/**
	 * 
	 * @class ifvsfPivotGrid
	 * 
	 */
	$.fn.ifvsfPivotGrid = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejPivotGrid(this.opt);
			window[_this.attr('id')] = this.data("ejPivotGrid");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);

(function($){
	/**
	 * 
	 * @class ifvsfPivotChart
	 * 
	 */
	$.fn.ifvsfPivotChart = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejPivotChart(this.opt);
			window[_this.attr('id')] = this.data("ejPivotChart");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);

(function($){
	/**
	 * 
	 * @class ifvsfSymbolPalette
	 * 
	 */
	$.fn.ifvsfSymbolPalette = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejSymbolPalette(this.opt);
			window[_this.attr('id')] = this.data("ejSymbolPalette");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);

(function($){
	/**
	 * 
	 * @class ifvsfRTE
	 * 
	 */
	$.fn.ifvsfRTE = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejRTE(this.opt);
			window[_this.attr('id')] = this.data("ejRTE");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);

(function($){
	/**
	 * 
	 * @class ifvsfToolbar
	 * 
	 */
	$.fn.ifvsfToolbar = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejToolbar(this.opt);
			window[_this.attr('id')] = this.data("ejToolbar");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);
(function($){
	/**
	 * 
	 * @class ifvsfColorPicker
	 * 
	 */
	$.fn.ifvsfColorPicker = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejColorPicker(this.opt);
			window[_this.attr('id')] = this.data("ejColorPicker");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);


(function($){
	/**
	 * 
	 * @class ifvsfCircularGauge
	 * 
	 */
	$.fn.ifvsfCircularGauge = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejCircularGauge(this.opt);
			window[_this.attr('id')] = this.data("ejCircularGauge");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);
(function($){
	/**
	 * 
	 * @class ifvsfDateTimePicker
	 * 
	 */
	$.fn.ifvsfDateTimePicker = function(options){
		var locale = (window.lang && window.country) ? (window.lang + "-" + window.country) : "ko-KR";
		var localeScript = document.createElement('script');
		localeScript.type = "text/javascript";
		localeScript.src = '/resources/1.4/syncfusion/scripts/i18n/ej.culture.' + locale + '.min.js';
		$('head').append(localeScript);
		
		var texts = {
			today: MESSAGE.datetimepicker.today
			, timeNow: ""
			, done: MESSAGE.datetimepicker.done
			, timeTitle: MESSAGE.datetimepicker.time
		};
		
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			dateTimeFormat :"yyyy-MM-dd HH:mm:ss" 
			, locale: locale
			, watermarkText : ifv.commonMessage.select || "선택"
		}, options);
		
		this.init = function(){
			this.ejDateTimePicker(this.opt);
			window[_this.attr('id')] = this.data("ejDateTimePicker");
			window[_this.attr('id')].setModel({ "locale": locale, buttonText: texts, watermarkText: MESSAGE.datetimepicker.placeholder });
			window[_this.attr('id')].setValue = function(date) {
				this.setModel({value : date});
			}
		};
		
		this.init();

		return this;
	};
})(jQuery);
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

(function ($) {
   /**
    *
    * @class ifvsfGrid
    *
    */
   $.fn.ifvsfGrid = function (options) {
      
       this.opt = {
           searchBox: null,
           rowsBox: null,
           grid: null,
           gridPage: null,
           page: null,
           pager: null,
           data: null,
           gridId: null,
           postData: null
       };

       /*
      * ejGrid 초기화
      */
       this._init = function () {
           /*
            * 기본 옵션 설정
            */
    	   
           var _this = this;
           this.opt.ejGridOption = {
              title: '',
              dataUrl: '',
              datatype: 'remote',
               tableType: 'normal',
               allowResizing: true,
               //commonWidth: 80,
               enableTouch: false,
               allowScrolling: false,
               allowTextWrap: true,
               isVerticalScroll: false,
               textWrapSettings: {wrapMode: "both"},
               isResponsive: true,
               allowSorting: false,
               columns: [],
               requestGridData : {
                nd   : new Date().getTime(),
                rows : 10,
                sidx : '',
                sord : 'desc',
                _search : false
               },
               tempId : "ifvGridOriginTemplete",
               rowNum: 10,
               rowList : [10, 25, 50, 100],
               emptyMsg : ifv.commonMessage.noData,
               total: ifv.commonMessage.total + ' : {total}' + ifv.commonMessage.gun,
               dataBound: function(args) {
                     if(_this.opt.ejGridOption.datatype == 'remote') {
                         var _thisId = this._id;
                       $('#' + _thisId + ' .e-gridheader').on('click', '.e-headercelldiv', function(args) {
                          var headerText = args.target.innerHTML,
                               gridObj = $('#' + _thisId).ejGrid('instance'),
                               length = gridObj.model.columns.length, columnData;
  
                          for (var i = 0; i < length; i++) {
                            if (gridObj.model.columns[i]['headerText'] == headerText) {
                               columnData = gridObj.getColumnByIndex(i);
                               _this._sortingData(columnData);
                            }
                          }
                      });
                     }
                     
                     if(_this.opt.ejGridOption.isHorizontalScroll) {
                        var hasFooter = false;
                        _this.find("[gridId=grid]").addClass('horizontal_scroll_grid');
                        _this.find("[gridId=grid]").removeClass('has_footer');
  
                        if(_this.opt.ejGridOption.showSummary && args.model.dataSource != null && args.model.dataSource.length != 0) {
                           _this.find("[gridId=grid]").addClass('has_footer');
                           hasFooter = true;
                        }
  
                        if(hasFooter) {
                           _this.find("[gridId=grid] .e-gridfooter").scrollLeft(0);
                           _this.find("[gridId=grid] .e-gridfooter").off().on('scroll', function(e) {
                               $(this).siblings('.e-gridheader').children('div').scrollLeft(e.srcElement.scrollLeft);
                               $(this).siblings('.e-gridcontent').children('div').scrollLeft(e.srcElement.scrollLeft);
                            });
                        } else {
                           _this.find("[gridId=grid] .e-gridcontent > div").scrollLeft(0);
                           _this.find("[gridId=grid] .e-gridcontent > div").off().on('scroll', function(e) {
                               $(this).parent().siblings('.e-gridheader').children('div').scrollLeft(e.srcElement.scrollLeft);
                            });
                        }
                     }
					if(_this.opt.ejGridOption.showStackedHeader == true){
					   var stackedCells = $(".e-stackedHeaderCell");
			           for (var len = 0; len < stackedCells.length; len++) {
			               if (stackedCells[len].textContent == "") {
			                //  checking whether the stacked header has empty content
			                   stackedCells[len].classList.add("stackedClass");
			                 //  adding custom class for differentiating
			               }
			           }
			           for (var len = 0; len < stackedCells.length; len++) {
			               if (stackedCells[len].colSpan > 1
			                   && stackedCells[len].classList.contains("stackedClass")) {
			                   var colSpanCount = stackedCells[len].colSpan; // colSpan of stackedheader cell that with empty content
			                   stackedCells[len].colSpan = 1; // changing colSpan of stacked header cell
			                   for (var i = 0; i < (colSpanCount - 1); i++) {
			                       $(stackedCells[len].cloneNode()).insertAfter($(stackedCells[len]));
			                       //inserting cloned node
			                   }
			               }
			           }	
					}
              },
               radio: false,
               gridDataInit: true
           };
                                   
           $.extend(true, this.opt.ejGridOption, options.ejGridOption);

           this.gridId = "gridId" + this.attr('id');

           if(this.opt.ejGridOption.datatype == 'clientSide' && this.opt.ejGridOption.tableType == 'offer') {
              var lst = [];
              var rmv = [];
              this.opt.ejGridOption.dataSource.forEach(function(item, index) {
                 if (typeof item.dataStatus != 'undefined' && item.dataStatus == 'D') {
                    rmv.push(item);
                 } else {
                    lst.push(item);
                 }
              });

              this.opt.ejGridOption.dataSource = lst;
              this.opt.ejGridOption.removeData = rmv;
           }

           if(this.opt.ejGridOption.datatype == 'clientSide') {
              var pageSettings = {};
              pageSettings.page = 1;
              pageSettings.pageSize = this.opt.ejGridOption.rowList[0];
              pageSettings.pageCount = 10;

              this.opt.ejGridOption.pageSettings = pageSettings;
              this.opt.ejGridOption.allowPaging = true;
           }

           this._setColumnDefault();
           this._setPostData();
           this._optionSetting();
           this._uiSetting();
           this._makeGrid();
           this._titleInit();
           this._rowBoxInit();
           this._authBoxInit();
           this._searchBoxInit();

		   this._pagerSetting({
    			page: 1,
    			records:0
			});
		   this._totalSetting({
    			total: 1
			});
           if(this.opt.ejGridOption.datatype == 'remote' && (this.opt.ejGridOption.gridDataInit || localStorage.getItem(this.attr('id') + "_PagerObj"))) this._doAjax();
           if(this.opt.ejGridOption.datatype == 'clientSide' && (this.opt.ejGridOption.gridDataInit || localStorage.getItem(this.attr('id') + "_PagerObj"))) this._setGridData();

       };
       /*
        * Column 디폴트 설정
        */
       this._setColumnDefault = function() {
          
          // 디폴트 Column 클래스
          var Column = function(c) {
             this.headerTextAlign = 'center',
             this.customAttributes = {
               sortable : true,
                   searchable : false,
             }
          }
          
          var columns = this.opt.ejGridOption.columns;
          
          this.opt.ejGridOption.columns = columns.map(function(c) {
             var column = new Column();
             // column과 머지함
             $.extend(true, column, c);
             column.customAttributes.index = (column.customAttributes && column.customAttributes.index)? column.customAttributes.index : column.field;
             return column;
          });

       };

         /*
          * ui 탬플릿 읽어들여서 컴퍼넌트 태그로 변환
          */
       this._uiSetting = function () {
           var con = $("#" + this.opt.ejGridOption.tempId).html();

           con = con.replace('{searchBox}', '<div class="search_box" gridId="searchBox" ></div>');
           con = con.replace('{rowsBox}', '<input class="combo_num_box" gridId="rowsBox" />');
           con = con.replace('{grid}', '<div class="responsive_grid" gridId="grid" id="' + this.gridId + '"></div>');
           con = con.replace('{gridPage}', '<div gridId="gridPage" id="gridPage" ></div>');
           con = con.replace('{page}', '<div gridId="page" ></div>');
           con = con.replace('{total}', '<div gridId="total" ></div>');
           con = con.replace('{btnAdd}', '<input type="button" class="btnAdd" gridId="btnAdd" value="등록"/>');
           con = con.replace('{btnDelete}', '<input type="button" class="btnDelete" gridId="btnDelete" value="삭제"/>');
           con = con.replace('{title}', '<div gridId="title" class="title"/>');
           con = con.replace('{excelDown}', '<button gridId="excelDown" class="btn btn-sm btn-imgonly"><i class="fa fa-search"></i></button>');
           con = con.replace('{authBox}', '<input class="combo_num_box" gridId="authBox" />');

           this.html(con);
           this.opt.searchBox = this.find("[gridId=searchBox]");
           this.opt.rowsBox = this.find("[gridId=rowsBox]");
           this.opt.gridPage = this.find("[gridId=gridPage]");
           this.opt.page = this.find("[gridId=page]");
           this.opt.total = this.find("[gridId=total]");
           this.opt.btnAdd = this.find("[gridId=btnAdd]");
           this.opt.btnDelete = this.find("[gridId=btnDelete]");
           this.opt.title = this.find("[gridId=title]");
           this.opt.excelDown = this.find("[gridId=excelDown]");
           this.opt.authBox = this.find("[gridId=authBox]");
       };

       /*
        * ajax통신 시 requestData 생성
        */
       this._setPostData = function () {
          var postData = {
               searchWord: '',
               searchText: '',
               page: 1,
               rows: this.opt.ejGridOption.rowList[0],
               appServiceId: window.appServiceId,
               country: window.country,
               lang: window.lang,
              nd : new Date().getTime(),
              _search: false
           };

           if (this.opt.ejGridOption.requestGridData)
               $.extend(postData, this.opt.ejGridOption.requestGridData);

           if (this.opt.ejGridOption.serializeGridData)
              postData = $.extend(postData, this.opt.ejGridOption.serializeGridData(postData));

           if (this.opt.ejGridOption.datatype == "clientSide")
              postData.records = postData.total = this.opt.ejGridOption.dataSource.length;

           if(localStorage.getItem(this.attr('id')+'_PagerObj')) {
              var pagerObj = JSON.parse(localStorage.getItem(this.attr('id')+'_PagerObj'));
              postData = $.extend(postData, pagerObj);
              this.opt.ejGridOption.rowNum = pagerObj.rows;
           }
           
           this.opt.postData = postData;
       };


       /*
        * 외부 검색함수
        */

       this.searchGrid = function(data) {
          $.extend(this.opt.postData, data);
         this.opt.ejGridOption.rowNum = this.opt.ejGridOption.rowList[0];
         this.rowSelectBox && this.rowSelectBox.setValue(this.opt.ejGridOption.rowList[0]);
         this.opt.postData.rows = this.opt.ejGridOption.rowList[0];
         this.opt.postData.page = 1;
         localStorage.setItem(this.attr('id')+'_PagerObj', JSON.stringify({page:1, rows:this.opt.ejGridOption.rowNum}));
          this._getData();
       }
       
       /*
        * 공통 조회조건 아닌 데이터들 조회
        */
       this.searchGrid2 = function(data) {
           $.extend(this.opt.postData, data);
           this._getData();
        }

       /*
        * Grid Data 가져오기
        */
       this._getData = function () {
          if(this.opt.ejGridOption.datatype == 'clientSide')
             this._setGridData();
          else
             this._doAjax();
       }

       /*
        * ClientSide Data Setting
        */
       this._setGridData = function() {
          this.opt.gridControl.dataSource(this.opt.ejGridOption.dataSource);
          this.opt.gridControl.gotoPage(this.opt.postData.page);

           this._pagerSetting(this.opt.postData);
           this._totalSetting(this.opt.postData);

          if(this.opt.ejGridOption.loadComplete) this.opt.ejGridOption.loadComplete(this.opt.gridControl);
       }

       /*
        * Ajax 통신
        */
       this._doAjax = function() {
           var _this = this;
           if(!this.opt.ejGridOption.gridDataInit && (!this.opt.postData.item || !this.opt.postData.item.length)) {
              return false;
           }
           $.ajax({
               url: this.opt.ejGridOption.dataUrl,
               datatype: 'json',
               type: 'POST',
               contentType: 'application/json; charset=utf-8',
               data: JSON.stringify(this.opt.postData),
               beforeSend: function () {
                   $('body').append($('<div>').addClass('loading').text(MESSAGE.common.progressTxt || '조회중'));
                   //$(".loading").attr("style", "z-index:99999999999;");
                   $.setProgressZindex();
               },
               success: function (resultData) {
                 if ($.errorChecker(resultData)) {
                       _this.opt.gridControl.dataSource(resultData.rows);

                       $.extend(_this.opt.gridControl.model.requestGridData, _this.opt.postData);
                       _this.opt.gridControl.model.requestGridData.records = resultData.records;

                       _this._pagerSetting(resultData);
                       _this._totalSetting(resultData);

                       _this.find('.emptyrecord').text(_this.opt.ejGridOption.emptyMsg); // 빈데이터 그리드일 때 텍스트 수정

                      if(_this.opt.ejGridOption.loadComplete) _this.opt.ejGridOption.loadComplete(_this.opt.gridControl, resultData);
                  } else {
                     _this.opt.gridControl.dataSource([]);
                  }
               },
               error: function (xhr, status, error) {
                  _this.opt.gridControl.dataSource([]);
               },
               complete: function () {
                   $('.loading').remove();
                   _this.opt.grid.find('.e-headercell .e-headercelldiv').addClass('sort_type');

                   var columns = _this.opt.ejGridOption.columns;
                   var column = {};

                   for(var i = 0; i < columns.length; i++) {   
                     column = columns[i];
                     customAttributes = column.customAttributes;

                     if(column.type != 'checkbox' && column.type != 'radio' && customAttributes.index === _this.opt.postData.sidx) {
                        _this.opt.grid.find('.e-headercell[title="' + column['headerText'] + '"] .e-headercelldiv').addClass(_this.opt.postData.sord);
                     }
                  }
               }
           });
       };

       /*
        * header sorting
        */
     this._sortingData = function (cItem) {
         if(!cItem.customAttributes.sortable) {
            this.opt.grid.find('.e-headercell[title="' + cItem.headerText + '"] .e-headercelldiv').css({cursor:'default'});
            return;
         }

        this.opt.postData.sidx = cItem.customAttributes.index;

        this.opt.postData.sord = this.opt.postData.sord === 'desc' ? 'asc' : 'desc';

        this._getData();
     }

       /*
        * ejGrid 생성
        */
       this._makeGrid = function () {
          this.opt.ejGridOption.gridId = this.attr('id');
          if(this.opt.ejGridOption.isFixedGrid) this.find("[gridId=grid]").removeClass('responsive_grid');
           this.opt.grid = this.find("[gridId=grid]").ejGrid(this.opt.ejGridOption);
           this.opt.gridControl = this.opt.grid.data('ejGrid');
           this.find('.emptyrecord').text(this.opt.ejGridOption.emptyMsg); // 빈데이터 그리드일 때 텍스트 수정
       };

       this._optionSetting = function () {
           if (this.opt.ejGridOption.radio) this._setRadio();
       };

       /*
        * radio 셋팅
        */
       this._setRadio = function () {
           var _this = this;

           var radioColumn = {
               headerText: '선택',
               type: "radio",
               template: '<input type="radio" name="radio_' + this.gridId + '" />',
               width: 40,
               headerTextAlign: 'center',
               textAlign: 'center',
               customAttributes: {
                  searchable: false,
                  sortable: false
               }
           };
           if(this.opt.ejGridOption.columns[0].type!="radio") {
              this.opt.ejGridOption.columns.unshift(radioColumn);
           }
           this.opt.ejGridOption.rowSelecting = function (args) {
               $('input[name=radio_' + _this.gridId).eq(args.rowIndex).prop('checked', true);
           };
       };

       /*
      *   title 초기화
      */
       this._titleInit = function() {
          this.opt.ejGridOption.title ? this.opt.title.html(this.opt.ejGridOption.title) : this.opt.title.remove();
       }

     /*
     *   row 셀렉트 박스 초기화
     */
       this._rowBoxInit = function(){
           if(!this.opt.rowsBox.length) return;

           var arr = [];
           for( var i = 0; i < this.opt.ejGridOption.rowList.length; i++ ){
              var obj = { key : this.opt.ejGridOption.rowList[i], value : this.opt.ejGridOption.rowList[i], };
              if( i == 0 ) obj.selected = true;
              arr.push( obj );
           }

           this.rowSelectBox = this.opt.rowsBox.ifvSelectBox();
           var _this = this;
           this.rowSelectBox.setData(arr, function(obj){
              _this._pageInit();
              _this.opt.ejGridOption.rowNum = obj.key;
              _this.opt.postData.rows = _this.opt.ejGridOption.rowNum;
          	  _this._pagerSetting({	page: 1, records:0});
          	  _this._totalSetting({total: 1});
              if(_this.opt.ejGridOption.datatype == "clientSide") {
                 _this.opt.gridControl._setModel({"pageSettings" : {"pageSize" : _this.opt.postData.rows}});
              }


           var pagerObj = {
              page: _this.opt.page.currentNum
              , rows: _this.opt.ejGridOption.rowNum
           }


           localStorage.setItem(_this.attr('id')+'_PagerObj', JSON.stringify(pagerObj));

               _this._getData();
           });

           if(localStorage.getItem(this.attr('id')+'_PagerObj')) {
              var pagerObj = JSON.parse(localStorage.getItem(this.attr('id')+'_PagerObj'));
              this.rowSelectBox.setValue(pagerObj.rows);
           }
       };
       
		this._authBoxInit = function(){
            if( this.opt.authBox == null ) return;
            
            var authobj = $.ifvmGetAuthInfo();
            var authDataType = authobj.dataTypeCd;
            
            var arr = [];
            
            if (authDataType == "ALL") {
                arr = [
                	{value: "All", key: "ALL", selected: true}
                	, {value: "Team", key: "TEAM"}
                	, {value: "My Team", key: "MY_TEAM"}
                	, {value: "My", key: "MY"}
                ];
            } else if (authDataType == "TEAM") {
                arr = [
                	{value: "Team", key: "TEAM", selected: true}
                	, {value: "My Team", key: "MY_TEAM"}
                	, {value: "My", key: "MY"}
                ];
            } else if (authDataType == "MY_TEAM") {
                arr = [
                	{value: "My Team", key: "MY_TEAM", selected: true}
                	, {value: "My", key: "MY"}
                ];
            } else if (authDataType == "MY") {
                arr = [
                	{value: "My", key: "MY", selected: true}
                ];
            }

            this.opt.postData.authDataTypeCd = authDataType;
            var authBox = this.opt.authBox.ifvSelectBox();

            var _this = this;
            authBox.setData(arr, function(obj){
                _this.opt.postData.authDataTypeCd = obj.key;
                _this._getData();

            });
        };


       /*
      *   검색 박스 초기화
      */
       this._searchBoxInit = function(){
           if(!this.opt.searchBox.length) return;

           var headArr = [];
           for( var i = 0; i< this.opt.ejGridOption.columns.length; i++ ){
              var column = this.opt.ejGridOption.columns[i];
              if( column.visible != false && column.type != 'checkbox' && column.type != 'radio' && column.customAttributes.searchable){
                 headArr.push( {value: this.opt.ejGridOption.columns[i].headerText, key : this.opt.ejGridOption.columns[i].customAttributes.index, key2 : this.opt.ejGridOption.columns[i].customAttributes.encColFlag}); //colModel은 hidden이 있으므로 count로 indexing
              }
           }

           var _this = this;
           var searchBox = this.opt.searchBox.ifvSearchBox();
           searchBox.setData( headArr, function( searchObj ){
              //검색시에는 토탈 갯수 바뀌므로 페이지다시 만듬 page도 1로
              _this._pageInit();
           $.extend( _this.opt.postData, searchObj);
           _this._getData();
           });
       };

       /*
        * 페이지 초기화
        */
       this._pageInit = function () {
           if (this.opt.pager != null) {
               this.opt.pager.empty();
               this.opt.pager = null;
               this.opt.postData.page = 1;
           }
       };

       /*
      * 페이지 셋팅 및 변환
      */
       this._pagerSetting = function (data) {
           if (this.opt.pager == null) {
               var _this = this;
               this.opt.pager = this.opt.page.ifvSimplePager({
                   dataObj: {rows: _this.opt.ejGridOption.rowNum},
                   callback: function (page) {
                       var pagerObj = {
                          page : page
                          , rows: _this.opt.ejGridOption.rowNum
                       }
                       localStorage.setItem(_this.attr('id')+'_PagerObj', JSON.stringify(pagerObj));
                       _this.opt.postData.page = page;
                       _this._getData();
                   }
               });
           }

           var pagerObj = {
              page : this.opt.page.currentNum
              , rows: this.opt.ejGridOption.rowNum
           }
           localStorage.setItem(this.attr('id')+'_PagerObj', JSON.stringify(pagerObj));
           this.opt.pager.change(data);
       };

       /*
        * 토탈 셋팅
        */
       this._totalSetting = function (data) {
          if(!data.records) data.records = 0;
           this.opt.total.text(this.opt.ejGridOption.total.replace('{total}', $.fn.ifvmNumberWithCommas(data.records) ));
           this.opt.data = data;
       };

       this._init();
       return this;
   }
})(jQuery);


$.extend({
	ifvGetFields: function (id) {
		var fields = {};
		var valueFields = ['input[type=text]', 'input[type=number]', 'textarea', 'input[type=hidden]'];
		var notCheckboxInputLists = '#' + id + ' ' + valueFields.join(', #' + id + ' ');

		fields["valueFields"] = $(notCheckboxInputLists).toArray().map(function(e) { return e.id });
		fields["checkboxFields"] = $('#' + id + ' input[type=checkbox]').toArray().map(function(e) { return e.id });
		return fields;
	},
    ifvSetSelectOptions: function (optionFields, optionValues) {
		optionFields.forEach(function (of) {
			var fieldName = of.fieldName;
			var commCode = of.commCode;
            var parField = of.parField;
            var isFirstLowBlank = of.isFirstLowBlank !== true;
			var option = (optionValues && optionValues[fieldName]) ? optionValues[fieldName] : null;
			if(option == null) option = of.option;

			if ($.fn.ifvmIsNotEmpty(parField)) {
				$.fn.ifvmSetSelectOptionCommCodeSync(fieldName, commCode, option, parField, isFirstLowBlank);
			} else {
				$.fn.ifvmSetSelectOptionCommCode(fieldName, commCode, option, null, isFirstLowBlank);
			}
		});
	},
	ifvGetFieldData: function (fields, optionFields, id) {
		
		var _id = (id) ? "#" + id + " #" : "#"; 
		var vObj = {};
		if (fields.valueFields) fields.valueFields.forEach(function (vf) { vObj[vf] = $(_id + vf).val(); });
		if (fields.checkboxFields) fields.checkboxFields.forEach(function (cf) { vObj[cf] = ($('input[id=' + cf + ']').is(":checked")) ? "Y" : "N" });

		if (optionFields) optionFields.forEach(function (of) { vObj[of.fieldName] = $(_id + of.fieldName).val() });
		return vObj;
	},
	ifvLoadFormData: function (result, fields, optionFields, id) {
		var _id = (id) ? "#" + id + " #" : "#"; 

		if (fields.valueFields) fields.valueFields.forEach(function (vf) { $(_id + vf).val(result[vf]) });
		if (fields.checkboxFields) fields.checkboxFields.forEach(function (cf) { $(_id + cf).prop("checked", result[cf] === 'Y') });

		if (optionFields) {
			var optionValues = {};
			optionFields.forEach(function (of) { optionValues[of.fieldName] = result[of.fieldName] });
			$.ifvSetSelectOptions(optionFields, optionValues);
		}
	},
	ifvInitFields: function(fields, optionFields) {
		if (fields.valueFields) fields.valueFields.forEach(function (vf) { $("#" + vf).val(''); });
		if (fields.checkboxFields) fields.checkboxFields.forEach(function (cf) { $("#" + cf).prop("checked", false) });
		if (optionFields) $.ifvSetSelectOptions(optionFields);
	}
});
(function () {

    var syncfution  = {
        getHeads : function ( strGridId ) {
            var gridOption = $( "#gridId"+strGridId ).data("ejGrid").option();
            // MultiHeader
            var getStackedHeader = function (stackedHeaderRows) {
                var headers = [];
                if ( stackedHeaderRows && stackedHeaderRows.length > 0 ) {

                    $("#"+strGridId).find("thead .e-stackedHeaderRow").each(function (idx,item ) {
                        var stackedRow = [];
                        $(item).children().each(function (i, row) {
                            if ( gridOption.radio && i == 0 ){
                               return true;
                            }
                            var $row = $(row);
                            var obj = {
                                field: "",
                                text: $row.hasClass("over vision") ? "" :$row.text(),
                                width: $row[0].width ? $row[0].width : 200,
                                align: "center",
                                colspan: $row[0].colSpan,
                                rowspan: 1
                            };
                            stackedRow.push(obj);
                        });
                        if ( stackedRow.length  > 0 ) {
                            headers.push(stackedRow);
                        }
                    });

                }
                return headers;
            };

            var getRowsHeader = function (columns) {
                var row = [];
                // 첫번째 컬럼 제외 ( Radio )
                for ( var i=0 ;  i < columns.length ; i++ ) {
                    if ( gridOption.radio && i == 0) continue;
                    if ( columns[i].visible == true ) {
                        var obj = {
                            field : columns[i].field,
                            text : columns[i].headerText,
                            width : columns[i].width ? columns.width : 200,
                            align : columns[i].headerTextAlign,
                            colspan : 1,
                            rowspan : 1
                        };
                        row.push(obj);
                    }
                }
                return row;
            };

            var header = getStackedHeader(gridOption.stackedHeaderRows);
            header.push( getRowsHeader(gridOption.columns));
            return header;
        },
        getFooters : function( strGridId ) {
           //header key값 가져오기
           var headMapArr = []; 
           
           $('#' + strGridId).find('.e-gridheader .e-columnheader:not(.e-stackedHeaderRow)').children('th.e-headercell').each(function(idx, item) {
             headMapArr.push($(this).children('div').attr('ej-mappingname'));
           });
           
           var fArr = [];
           $('#' + strGridId).find('.e-gridSummaryRows').each(function() {
              var obj = {};
              $(this).children('td').each(function(idx, item) {
            	  obj[headMapArr[idx]] = $(this).text();
              });
              fArr.push(obj);
           });
           return fArr;
        }
    };

    $.ifvExcelDn = function(targetUrl, strGridId , data) {
        var header =  syncfution.getHeads(strGridId);
        var footer =  syncfution.getFooters(strGridId);
        var gridOption = $( "#gridId"+strGridId ).data("ejGrid").option();

        var reqData = gridOption.requestGridData;
        reqData.skipCount = 0;
        reqData.initSize = 0;
        reqData.rows = 9999999;
        reqData.excelHeader = JSON.stringify(header);
        reqData.excelFooter = JSON.stringify(footer);
        reqData.gridType = "EXCEL";
        reqData.item = requestitem;
        reqData.uri = targetUrl;
        
        //
        // var reqData = {
        //     item: requestitem,
        //     excelHeader : JSON.stringify(header),
        //     sidx : gridOption.requestGridData.sidx ? gridOption.requestGridData.sidx : "",
        //     sord : gridOption.requestGridData.sord ? gridOption.requestGridData.sord : "",
        //     rows : 9999999
        // };

        $.extend(reqData,data);

        $.ifvProgressControl(true)

        var xhr = new XMLHttpRequest();
        xhr.open( "POST", targetUrl );
        xhr.responseType = "arraybuffer";

        xhr.onload = function() {
            $.ifvProgressControl(false)
            if( this.status === 200 ) {

                var fileName = "";
                var disposition = xhr.getResponseHeader( "Content-Disposition" );

                if ( disposition && disposition.indexOf( "attachment" ) !== -1 ) {
                    var fileNameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    var matches = fileNameRegex.exec( disposition );

                    if( matches != null && matches[1] ) {
                        fileName = matches[1].replace( /['"]/g, "" );
                    }
                }
                var type = xhr.getResponseHeader( "Content-Type" );
                var blob = new Blob( [this.response], { type: type } );

                if ( typeof window.navigator.msSaveBlob !== "undefined" ) {
                    window.navigator.msSaveBlob( blob, fileName );
                } else {
                    var URL = window.URL || window.webkitURL;
                    var downloadUrl = URL.createObjectURL( blob );

                    fileName = decodeURIComponent( fileName );
                    if ( fileName ){
                        var a = document.createElement( "a" );
                        if ( typeof a.download === "undefined" ) {
                            window.location = downloadUrl;
                        } else {
                            a.href = downloadUrl;
                            a.download = fileName;
                            document.body.appendChild( a );
                            a.click();
                        }
                    } else {
                        //window.location = "/login";
                        window.location = downloadUrl;
                    }

                    setTimeout(function() {
                        URL.revokeObjectURL( downloadUrl );
                    }, 100);
                }
            }
        };

        //xhr.setRequestHeader( "Content-Type", "application/x-www-form-urlencoded" );
        xhr.setRequestHeader( "Content-Type", "application/json" );
        xhr.send( JSON.stringify(reqData) );
    }

    //XMLHttpRequest 그리드를 사용하지 안고 output으로 화면에 파일을 보기 위한 로직
    $.ifvDBExcelDn = function(targetUrl, objCode, Data) {

    	var reqData = new Object();
        reqData.uri = targetUrl;
        reqData.objCode = objCode;

        $.extend(reqData, Data);

        $.ifvProgressControl(true)

        var xhr = new XMLHttpRequest();
        xhr.open( "POST", targetUrl );
        xhr.responseType = "arraybuffer";

        //파일을 화면에 뿌려준다
        xhr.onload = function() {
            $.ifvProgressControl(false)
            if( this.status === 200 ) {

                var fileName = "";
                var disposition = xhr.getResponseHeader( "Content-Disposition" );

                if ( disposition && disposition.indexOf( "attachment" ) !== -1 ) {
                    var fileNameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    var matches = fileNameRegex.exec( disposition );

                    if( matches != null && matches[1] ) {
                        fileName = matches[1].replace( /['"]/g, "" );
                    }
                }
                var type = xhr.getResponseHeader( "Content-Type" );
                var blob = new Blob( [this.response], { type: type } );

                if ( typeof window.navigator.msSaveBlob !== "undefined" ) {
                    window.navigator.msSaveBlob( blob, fileName );
                } else {
                    var URL = window.URL || window.webkitURL;
                    var downloadUrl = URL.createObjectURL( blob );

                    fileName = decodeURIComponent( fileName );
                    if ( fileName ){
                        var a = document.createElement( "a" );
                        if ( typeof a.download === "undefined" ) {
                            window.location = downloadUrl;
                        } else {
                            a.href = downloadUrl;
                            a.download = fileName;
                            document.body.appendChild( a );
                            a.click();
                        }
                    } else {
                        window.location = downloadUrl;
                    }

                    setTimeout(function() {
                        URL.revokeObjectURL( downloadUrl );
                    }, 100);
                }
            }
        };
        xhr.setRequestHeader( "Content-Type", "application/json" );
        xhr.send( JSON.stringify(reqData) );
    }
    
    //XMLHttpRequest 그리드를 사용하지 안고 output으로 화면에 파일을 보기 위한 로직
    $.ifvDBExcelDnSeo = function(targetUrl,strGridId, objCode) {
	    var header =  syncfution.getHeads(strGridId);
        var footer =  syncfution.getFooters(strGridId);
		var gridOption = $( "#gridId"+strGridId ).data("ejGrid").option();

        var reqData = gridOption.requestGridData;
		reqData.uri = targetUrl;
        reqData.objCode = objCode;
        reqData.skipCount = 0;
        reqData.initSize = 0;
        reqData.rows = 9999999;
        reqData.excelHeader = JSON.stringify(header);
        reqData.excelFooter = JSON.stringify(footer);
        reqData.gridType = "EXCEL";
        reqData.item = requestitem;
        reqData.uri = targetUrl;

        $.extend(reqData, objCode);

        $.ifvProgressControl(true)

        var xhr = new XMLHttpRequest();
        xhr.open( "POST", targetUrl );
        xhr.responseType = "arraybuffer";

        //파일을 화면에 뿌려준다
        xhr.onload = function() {
            $.ifvProgressControl(false)
            if( this.status === 200 ) {

                var fileName = "";
                var disposition = xhr.getResponseHeader( "Content-Disposition" );

                if ( disposition && disposition.indexOf( "attachment" ) !== -1 ) {
                    var fileNameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    var matches = fileNameRegex.exec( disposition );

                    if( matches != null && matches[1] ) {
                        fileName = matches[1].replace( /['"]/g, "" );
                    }
                }
                var type = xhr.getResponseHeader( "Content-Type" );
                var blob = new Blob( [this.response], { type: type } );

                if ( typeof window.navigator.msSaveBlob !== "undefined" ) {
                    window.navigator.msSaveBlob( blob, fileName );
                } else {
                    var URL = window.URL || window.webkitURL;
                    var downloadUrl = URL.createObjectURL( blob );

                    fileName = decodeURIComponent( fileName );
                    if ( fileName ){
                        var a = document.createElement( "a" );
                        if ( typeof a.download === "undefined" ) {
                            window.location = downloadUrl;
                        } else {
                            a.href = downloadUrl;
                            a.download = fileName;
                            document.body.appendChild( a );
                            a.click();
                        }
                    } else {
                        window.location = downloadUrl;
                    }

                    setTimeout(function() {
                        URL.revokeObjectURL( downloadUrl );
                    }, 100);
                }
            }
        };
        xhr.setRequestHeader( "Content-Type", "application/json" );
        xhr.send( JSON.stringify(reqData) );
    }

  /* 체크박스 그리드 선택 (id:gridId) */
  $.ifvCheckBoxGrid = function(id) {
		var checkboxGridId = '#' + id
		$(checkboxGridId).on('click', '.e-row, .e-alt_row', function(e){
			e.stopPropagation(); /* event 버블링 방지*/
  			isRowcheck = $(this).find(".e-checkcelldiv")[0].childNodes[1].checked;
			if($(e.target)[0].nodeName=="INPUT"){
    			/* 체크박스를 눌렀을때  */
  				if(isRowcheck){ 
    				this.setAttribute("aria-selected",true);
  	  		  		$(this).attr("aria-selected", true).find(".e-rowcell, .e-detailrowcollapse, .e-detailrowexpand").addClass("e-selectionbackground e-active");
 	  			}else{
 	  			  	this.removeAttribute("aria-selected");
					$(this).find(".e-rowcell, .e-detailrowcollapse, .e-detailrowexpand").removeClass("e-selectionbackground e-active");				
 	  			}
  	  		}else{
  	  			/* 그리드 클릭시  */
  	  			 if(isRowcheck){ 
  	  			   $(this).find(".e-checkcelldiv")[0].childNodes[1].checked=false;
  	  				this.removeAttribute("aria-selected");
  	  				$(this).find(".e-rowcell, .e-detailrowcollapse, .e-detailrowexpand").removeClass("e-selectionbackground e-active");				
   	  			}else{
  	  			  $(this).find(".e-checkcelldiv")[0].childNodes[1].checked=true;
  	  		      this.setAttribute("aria-selected",true);
  	  		  	  $(this).attr("aria-selected", true).find(".e-rowcell, .e-detailrowcollapse, .e-detailrowexpand").addClass("e-selectionbackground e-active");
	  			}
  	  		}
    	});
	},
	$.ifvMultiplePostJSON =  function (url, jsonData, callback, errorCallback, fallback, startFlag) {
		/*
		ifvMultiplePostJSON : 비동기 여러개 사용 시
		ifvComplete : Process Bar 종료
		fallback : exception 발생 시 callback function
		startFlag : 첫번째 비동기 통신 여부
		 */
		if(startFlag){
			$('body').append($('<div>').addClass('loading').text('조회중'));
			//$(".loading").attr("style", "z-index:99999999999;");
			$.setProgressZindex();
		}

		var jsonDataType = "json";

		$.setProgressZindex();

		var jsonData = jsonData ? jsonData : {};
		$.extend(jsonData, {
			appServiceId: window.appServiceId,
			country: window.country,
			lang: window.lang
		});

		var config = {
			url: url,
			type: "POST",
			data: $.toJSON(jsonData),
			dataType: jsonDataType,
			contentType: "application/json; charset=utf-8",
			success: function (result) {
				if ($.errorChecker(result, errorCallback) == false) {
					$.processBarComplete(url, false);
					return;
				}
				callback(result);
			},
			async: true,
			complete: function (xhr, status) {
			},
			error: function(){
				if(fallback != null) fallback();
				$.processBarComplete(url, true);
			}
		};

		$.ajaxSetup(config);
		$.ajax();

		config = {
			url: null,
			type: "GET",
			data: null,
			dataType: null,
			contentType: "application/x-www-form-urlencoded",
			success: null,
			async: true
		};
		$.ajaxSetup(config);
	},
	 $.processBarComplete = function (url, errorFlag) {
	 	 $('.loading').remove();
		  if(errorFlag) alert('Error: '+ url);
	  }
})();