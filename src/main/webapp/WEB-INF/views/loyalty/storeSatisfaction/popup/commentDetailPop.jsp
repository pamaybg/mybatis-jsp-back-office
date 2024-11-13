<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<script>

commentDetail = {
	rid : '<%= cleanXss(request.getParameter("rid")) %>'
	, data : {}
	, init : function() {
		this.loadData();
	}
	, loadData: function() {
        $.ifvSyncPostJSON('<ifvm:action name="getStoreSatisfactionDetail"/>', {
            rid: this.rid
        },
        function(result) {
            commentDetail.data = result;
			$("#commentDetailWrap").dataSetting(result);
        });
	}
}

$(document).ready(function() {

    // 의견조회 조회
    commentDetail.init();
});

</script>
<div class="form-horizontal underline top_well clearfix" id="commentDetailWrap">
	<div class="form-horizontal top_well underline" >
		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="satisComment" names="satisComment" dto="satisComment" required="true" conClass="12" rows="5" maxLength="2000" readonly="true"/>
		</div>
	</div>
</div>

<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="commentDetailPop.close" className="btn_lightGray2" objCode="commentDetailSatis_OBJ"/>
</div>