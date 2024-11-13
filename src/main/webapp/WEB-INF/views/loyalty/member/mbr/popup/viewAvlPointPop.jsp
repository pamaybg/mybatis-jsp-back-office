<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="checkAvlPointWrap">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="text" id="avlPoint"   dto="avlPoint"	disabled="true"	className="text-right"
					label="L00468" labelClass="5" conClass="6" /><!-- 가용 포인트-->
			</div>
		</div>
	</div>
</div>
<script>
	gViewMbrAvlPoint= {
		init : function (){
			this.loadData();
		},
		loadData : function(){
			var action = '<ifvm:action name="getAvlPoint"/>';
			$.ifvPostJSON(action, {
				mbrNo: gMbrDetail.data.mbrNo
			}, function(result) {

				if ($.fn.ifvmIsNotEmpty(result)) {
					var avlp = result.avlPoint;
					avlp = (avlp.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					$("#checkAvlPointWrap #avlPoint").val(avlp);
				}
			});
		}
	}
	gViewMbrAvlPoint.init()

</script>