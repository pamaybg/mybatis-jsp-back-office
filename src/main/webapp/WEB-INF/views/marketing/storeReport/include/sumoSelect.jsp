<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sumoselect/sumoselect.min.css"/>
<script src="${pageContext.request.contextPath}/resources/js/sumoselect/jquery.sumoselect.min.js"></script>

<style>
	.SumoSelect .select-all{ height: 40px; }
	.SumoSelect>.optWrapper>.options li.opt label { text-align: left; }
    .divSumo {display:table; width: 9.8%;}
</style>
<script type="text/javascript">


	function setSumoSelect(name, groupCode, placeholder, parCodeId){
		var _name = name;
		var _parCodeId = $.fn.ifvmIsNotEmpty(parCodeId) ? parCodeId : null;
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
			groupCode: groupCode,
			enableNA: true,
			parCodeId: _parCodeId
		}, function (result) {
			$.each(result.rows, function (index, code) {
				var option =
						$("<option></option>")
								.text(code.markName)
								.attr("codeId", code.codeId)
								.attr("value", code.codeName)
								.attr("attrib01", code.attrib01)
				;
				option.appendTo("select[name='" + _name + "']");
			});
		});

        $('#'+ _name).SumoSelect({
            csvDispCount: 2,
            placeholder: placeholder,
            selectAll : true,
            clearAll : true
        })
        $(".SumoSelect .reset-all").hide();
	}

</script>