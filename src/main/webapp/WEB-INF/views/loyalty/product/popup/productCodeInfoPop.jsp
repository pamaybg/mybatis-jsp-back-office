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
var prodPopTempObj = {};
var codeRid = '<%= cleanXss(request.getParameter("codeRid")) %>';
function setValidCalendar() {
    var startDate = $("#startDd");
    var endDate = $("#endDd");
    
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

function codeValidation(){
	var prodValid = true;
	formValid = $("#productCodeInfoPopForm").ifvValidation();
	if(formValid.confirm()==true){
		if($("#statusCd").val()=="00"){
			alert('<spring:message code="L01422"/>');
			prodValid = false;
		}
	}else{
		prodValid = false
	}
	return prodValid;
}


function productInfoSaveFn(){
	if(codeValidation()){
		var submitData =$("#productCodeInfoPopForm").getSubmitData();
		submitData.ridProd=testViewList_rid;
		var startDd = submitData.startDd.split("-")[0]+ submitData.startDd.split("-")[1]+  submitData.startDd.split("-")[2];
		var endDd = submitData.endDd.split("-")[0]+ submitData.endDd.split("-")[1]+  submitData.endDd.split("-")[2];
		submitData.startDd = startDd
		submitData.endDd = endDd
		if(codeRid =="null"){
			$.ifvSyncPostJSON('<ifvm:action name="insertProductCodeDetail"/>',submitData 
					,function(result) {
						alert('<spring:message code="L00127"/>');
						productCodeList.requestData();
						productCodeInfoPop.close();
					},function(result){
						alert(result.message);
					}
				);
			
		}else{
			submitData.rid = codeRid;
			$.ifvSyncPostJSON('<ifvm:action name="updateProductCodeDetail"/>',submitData 
					,function(result) {
						alert('<spring:message code="L00127"/>');
						productCodeList.requestData();
						productCodeInfoPop.close();
					},function(result){
						alert(result.message);
					}
				);

		}
	}
}

function closeProductInfoPopFn(){
	productCodeInfoPop.close();
}

function productCodeInfoDtl(){
	if(codeRid!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getProductCodeDetail"/>',{rid : codeRid} 
				,function(result) {
					$($('#productCodeInfoPopForm').find('input')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);	
			 			numberFormatterSetting();
			 		});
			 		
			 		$($('#productCodeInfoPopForm').find('select')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);	
			 		});
				});
	}
}

function popChannelSearchHelpBlur(){
	if( $("#productCodeInfoPopForm #chnlNo").val()==""){
		$("#productCodeInfoPopForm #ridChnl").val("");
		$("#productCodeInfoPopForm #chnlNm").val("");
		
	}else{
		popChannelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>'+'?ouTypeCd=A&&chnlNm=' +encodeURI(encodeURIComponent($('#chnlNm').val())));
	}
}

function popChannelSearchHelpEnter(){
	if( $("#productCodeInfoPopForm #chnlNo").val()==""){
		$("#productCodeInfoPopForm #ridChnl").val("");
		$("#productCodeInfoPopForm #chnlNm").val("");
		
	}else{
		popChannelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>'+'?ouTypeCd=A&&chnlNm=' +encodeURI(encodeURIComponent($('#chnlNm').val())));
	}
}

function popChannelSearchFn(){
	popChannelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>' + '?ouTypeCd=' + 'A');
}

function popChannelSearchHelpPopOpen(url){
	channelSearchHelpPop ={
	        id : "popChannelSearchPopDiv"
	    };
	channelSearchHelpPop.popup = function (){
	channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: url,
	            contentType: "ajax",
	            title: "<spring:message code='L00987'/>",
	            width: "700px"
	        });
	};
	channelSearchHelpPop.beforeClose = function (obj) {
	};
	channelSearchHelpPop.close = function (obj) {
		 if(obj!=null || typeof obj!="undefined"){
				 $("#productCodeInfoPopForm #chnlNm").val(obj.chnlNm);
				 $("#productCodeInfoPopForm #chnlNo").val(obj.chnlNo);
				 $("#productCodeInfoPopForm #ridChnl").val(obj.rid);
				 prodPopTempObj.chnlNo = obj.chnlNo;
	        }else{
	        	 $("#productCodeInfoPopForm #chnlNo").val(prodPopTempObj.chnlNo);
	        }
	        this.beforeClose(obj);
	        popChannelSearchPopDiv._destroy();
	 };
	channelSearchHelpPop.popup();
}

$(document).ready(function() {
	setValidCalendar();
	
	productCodeInfoDtl();
});

</script>

<div id="productCodeInfoPopForm" >
	<div class="form-horizontal underline top_well" >
		 	
	 	 <div class="row  qt_border">
	  	 	<ifvm:inputNew type="date" id="startDd" dto="startDd" maxLength="50" label="L01096" labelClass="2" conClass="3" required="true"  />
    	    <ifvm:inputNew type="date" id="endDd" dto="endDd" maxLength="50" label="L01097" labelClass="2" conClass="3" required="true"/>
	 	 </div>
		 
		 <div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="prodNm"   dto="prodNm"   label="L01179" labelClass="2" conClass="3" required="true"  /> 
			<ifvm:inputNew type="search" id="chnlNo|channelSearchBtn"  dto="chnlNo" names="chnlNm" hidId="ridChnl" hidDto="ridChnl" required="true"  disabled="false"  
				   btnFunc="popChannelSearchFn" searchBlurEvent="popChannelSearchHelpBlur" searchEnterEvent="popChannelSearchHelpEnter" label="L00648"  labelClass="2" conClass="2" />		   
			<ifvm:inputNew type="text" id="chnlNm" maxLength="50"  dto="chnlNm"    labelClass="1" conClass="2"  disabled="true"/>
			    	
	 <%--    	<ifvm:inputNew type="text" id="chnlNo"   dto="chnlNo"   label="L00648" labelClass="2" conClass="2" required="true"  /> 
	    	<div class="col-xs-2 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="chnlNm"  dto="chnlNm" disabled="true" />				
				<span class="input-group-addon" id="chnlNmSearch">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
			</div> --%>
	 	</div>
	 	
	 	<div class="row  qt_border">
			<ifvm:inputNew type="text" id="desc1" maxLength="300"  dto="desc1"   label="L00885" labelClass="2" conClass="10"  /> 
		</div>
	 	
	 	<div hidden="true">
	 		 <ifvm:inputNew type="date" id="dateValid" dto="dateValid" maxLength="50" label="L00907" labelClass="2" conClass="3"   />
	 	</div>
	</div>
</div>

<div class="pop_btn_area">
 	<ifvm:inputNew type="button" btnType="save"  text="L00074"  id="productInfoSaveBtn" btnFunc="productInfoSaveFn"/>
 	<ifvm:inputNew type="button"   text="L00913"  id="closeProductInfoPopBtn" btnFunc="closeProductInfoPopFn"/>
</div>


<div id="popChannelSearchPopDiv" class="popup_container"></div>