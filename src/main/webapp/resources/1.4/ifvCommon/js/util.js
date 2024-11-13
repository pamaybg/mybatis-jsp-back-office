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
		$(progress).css('z-index', '2147483647');
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
	ifvSearchClear: function (a, b) {
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
		var thisYear = new Date().getFullYear() + 10;
		
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