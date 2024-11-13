<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="checkPwCngDateWrap">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="text" id="mbrPwCng"   dto="mbrPwCng"	disabled="true"
					label="L00831" labelClass="5" conClass="6" /><!-- 비밀번호 수정일시-->
			</div>
		</div>
	</div>
</div>
<script>
	gViewMbrPwDate= {
		init : function (){
			this.loadData();
		},
		loadData : function(){
			var action = '<ifvm:action name="getMbrPwChgDate"/>';
			$.ifvPostJSON(action, {
				rid: $.ifvGetParam('rid')
			}, function(result) {

				if ($.fn.ifvmIsNotEmpty(result)) {
					$("#mbrPwCng").val(result.message.split('.')[0]);
				}
			});
		}
	}
	gViewMbrPwDate.init()

</script>