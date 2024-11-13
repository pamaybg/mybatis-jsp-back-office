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