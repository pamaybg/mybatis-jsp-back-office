/*!
 * Diagram Utility
 * Copyright dg.ryu
 * v1.0.0
 */


//Not Empty 여부
function isNotEmpty(val) {
	if (!isEmpty(val)) {
		return true;
	}
	
	return false;
};

//Empty 여부
function isEmpty(mixed_var) {
	try {
		var undefined, i, len;
		var emptyValues = [undefined, null, ''];
		for (i = 0, len = emptyValues.length; i < len; i++) {
			if (mixed_var === emptyValues[i]) {
				return true;
			}
		}
	
		if (typeof mixed_var === 'object') {
			if ($.isEmptyObject(mixed_var)) {
				return true;
			}
			if (mixed_var.length == 0) {
				return true;
			}
		}
	} catch(e) {
		console.log(e);
		return false;
	}
	
	return false;
};

//string > number 형변환
function stringToNumber(val) {
	if (isNotEmpty(val)) {
		val = Math.ceil(val);
		if (/^(\-|\+)?([0-9]+|Infinity)$/.test(val)) {
			return Number(val);
		}
	}
	
	return "";
};

//string > jsonObject 형변환
function stringToJSONObject(val) {
	try {
		return JSON.parse(val);
	}
	catch(err) {
		return "";
	}
};
