

$.extend({
	ifvGetFields: function (id) {
		var fields = {};
		var valueFields = ['input[type=text]', 'input[type=number]', 'textarea', 'input[type=hidden]'];
		var notCheckboxInputLists = '#' + id + ' ' + valueFields.join(', #' + id + ' ');

		fields["valueFields"] = $(notCheckboxInputLists).toArray().map(function(e) { return e.id });
		fields["checkboxFields"] = $('#' + id + ' input[type=checkbox]').toArray().map(function(e) { return e.id });
		return fields;
	},
    ifvSetSelectOptions: function (optionFields,optionValues) {
		optionFields.forEach(function (of) {
			var fieldName = of.fieldName;
			var commCode = of.commCode;
            var parField = of.parField;
            var isFirstLowBlank = of.isFirstLowBlank !== true;
			var option = (optionValues && optionValues[fieldName]) ? optionValues[fieldName] : null;

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