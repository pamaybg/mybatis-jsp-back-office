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
<script type="text/javascript">


var coupnRid = '<%=cleanXss(request.getParameter("coupnRid"))%>';

var couponInfoObj = {
	initCouponInfo : function(data) {
		this.getCouponDetail();
	},
	//포인트상세조회
	getCouponDetail : function(data) {
		$.ifvPostJSON('<ifvm:action name="getMbrPointCouponDetail"/>', {
			coupnRid : coupnRid
		}, function(result) {
			$("#coupnUsegdnc1").val(result.coupnUsegdnc1);
			$("#coupnUsegdnc2").val(result.coupnUsegdnc2);
			$("#coupnUsegdnc3").val(result.coupnUsegdnc3);
		});
	},
}

$(document).ready(function(){
	couponInfoObj.initCouponInfo();
});
</script>

<div class="form-horizontal underline top_well" id="couponDetailForm">
	<div class="row qt_border">
		<div class="col-xs-12">
       		 <!-- 쿠폰유의사항 1 -->
        	<ifvm:inputNew type="text" id="coupnUsegdnc1" dto="coupnUsegdnc1" names="coupnUsegdnc1" labelClass="3" conClass="9" label="M02909" disabled="true"/>
    	</div>
    </div>
    <div class="row qt_border">
    	<div class="col-xs-12">
			<!-- 쿠폰유의사항 2 -->
			<ifvm:inputNew type="text" id="coupnUsegdnc2" dto="coupnUsegdnc2" names="coupnUsegdnc2" labelClass="3" conClass="9" label="M02910" disabled="true"/>
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-12">
			<!-- 쿠폰유의사항 3 -->
			<ifvm:inputNew type="text" id="coupnUsegdnc3" dto="coupnUsegdnc3" names="coupnUsegdnc3" labelClass="3" conClass="9" label="M02911" disabled="true"/>
		</div>
	</div>
</div>
<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="pointCouponPopClose" className="btn_lightGray2"/>
</div>