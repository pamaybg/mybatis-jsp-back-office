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

var formValid;
var priceRid = '<%= cleanXss(request.getParameter("priceRid")) %>';

function setValidCalendar() {
    var startDate = $("#aplyStartDd");
    var endDate = $("#aplyEndDd");
    
    var todayDt = $("#dateValid");
   	todayDt.val($.ifvGetNewDate('d', +1).newDateS);
    //startDate.val($.ifvGetTodayDate());
    startDate.val($.ifvGetNewDate('d', +1).newDateS);
    startDate.ifvDateChecker({});

	endDate.val($.ifvGetNewDate('m', +1).newDateS);
	endDate.ifvDateChecker({});
	
	 //설정
/* 	 startDate.ifvDateChecker({
	  maxDate : endDate
	 // minDate : $.ifvGetNewDate('d', +1).newDateS
	 });
 */
	 endDate.ifvDateChecker({
	  minDate : startDate
	 });
	 
	  startDate.ifvDateChecker({
		  minDate : todayDt,
		  maxDate : endDate
	});
 
}

function productValidation(){
	var prodValid =true;
	formValid = $("#productPriceInfoPopForm").ifvValidation();
	if(formValid.confirm()==true){
		if($("#statusCd").val()=="00"){
			alert('<spring:message code="L01422"/>');
			prodValid = false;
		}
	}
	return prodValid;
}

function productInfoSaveFn(){
	
	formValid = $("#productPriceInfoPopForm").ifvValidation();
	
	if(productValidation()){
		var submitData =$("#productPriceInfoPopForm").getSubmitData();
		submitData.ridProd=testViewList_rid;
	
		var startDd = submitData.aplyStartDd.split("-")[0]+ submitData.aplyStartDd.split("-")[1]+  submitData.aplyStartDd.split("-")[2];
		var endDd = submitData.aplyEndDd.split("-")[0]+ submitData.aplyEndDd.split("-")[1]+  submitData.aplyEndDd.split("-")[2];
		submitData.aplyStartDd = startDd
		submitData.aplyEndDd = endDd
	
		if(priceRid=="null"){
			
		
		$.ifvSyncPostJSON('<ifvm:action name="insertProductPrice"/>',submitData 
			,function(result) {
				alert('<spring:message code="L00127"/>');
				productPriceList.requestData();
				productPriceInfoPop.close();
			},function(result){
				alert(result.message);
			});
		}else{
			submitData.rid=priceRid;
	
			$.ifvSyncPostJSON('<ifvm:action name="updateProductPrice"/>',submitData 
					,function(result) {
						alert('<spring:message code="L00127"/>');
						productPriceList.requestData();
						productPriceInfoPop.close();
					},function(result){
						alert(result.message);
					}
				);
			
		}
	}
}
//1000단위 정규식
function numberWithCommas(x) {
    return Math.round(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function numberForamtter(){
	var numFormatVal=$("#pointApplyPrice").val();
	
	$("#pointApplyPrice").ifvNumberOnly();
	$("#pointApplyPrice").val(numberWithCommas(numFormatVal));
	
	numFormatVal=$("#mbrbsSplPrice").val();
	$("#mbrbsSplPrice").ifvNumberOnly();
	$("#mbrbsSplPrice").val(numberWithCommas(numFormatVal));
	
}

function closeProductInfoPopFn(){
	productPriceInfoPop.close();
}

function productPriceDtlSetting(){
	if(priceRid !="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getProductPriceDtl"/>',{rid : priceRid} 
				,function(result) {
					$($('#productPriceInfoPopForm').find('input')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);	
			 			numberFormatterSetting();
			 		});
			 		
			 		$($('#productPriceInfoPopForm').find('select')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);	
			 		});
				});
	}
}
$(document).ready(function() {
	setValidCalendar();
	productPriceDtlSetting();
	numberForamtter();
});

</script>





<div id="productPriceInfoPopForm" >
	<div class="form-horizontal underline top_well" >
		 <div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="pointApplyPrice"   dto="pointApplyPrice"   label="L01382" labelClass="2" conClass="2" required="true"  /> 
		    <ifvm:inputNew type="text" id="mbrbsSplPrice"   dto="mbrbsSplPrice"   label="L01383" labelClass="2" conClass="2"  />
	 	</div>
	 	
	 	<div class="row  qt_border">
	  	 	<ifvm:inputNew type="date" id="aplyStartDd" dto="aplyStartDd" maxLength="50" label="L01384" labelClass="2" conClass="3" required="true"  />
    	    <ifvm:inputNew type="date" id="aplyEndDd" dto="aplyEndDd" maxLength="50" label="L01385" labelClass="1" conClass="3" required="true"/>
	 	</div>
	 	
	 	<div hidden="true">
	 		 <ifvm:inputNew type="date" id="dateValid" dto="dateValid" maxLength="50" label="L00907" labelClass="2" conClass="3" required="true"  />
	 	</div>
	</div>
</div>

<div class="pop_btn_area">
 	<ifvm:inputNew type="button" btnType="save"  text="L00074"  id="productInfoSaveBtn" btnFunc="productInfoSaveFn"/>
 	<ifvm:inputNew type="button"   text="L00913"  id="closeProductInfoPopBtn" btnFunc="closeProductInfoPopFn"/>
</div>
