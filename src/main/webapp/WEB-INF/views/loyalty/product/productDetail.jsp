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

var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var productValid;
var prodTempObj={};
var prodIdValid="";
var regNumber = /[^0-9]/;

var originalProdId ="";  //기존 상품아이디
//var regNumber2 = /^Q[0-9][0-9]/g;
var regNumber2 =  /^[0-9]*$/;

function productDataLoad(testViewList_rid) {
	if(testViewList_rid!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getProductDetail"/>', {
			  rid: testViewList_rid
			 }, function(result) {
			  if($.fn.ifvmIsNotEmpty(result)) {
				  	$("#prudctDtlForm").dataSetting(result);
				  	originalProdId=result.prodId;
					$.fn.ifvGetHierarchySelect("prodTypeLv2",'<ifvm:action name="getHierarchyCommCodeList"/>','PROD_LEVEL_2',$("#prodTypeLv1").val(), true );
					$("#prodTypeLv2").val(result.prodTypeLv2);
					$($('#prudctDtlForm').find('input')).each(function(index, item){
						if($(this).attr('type')=="checkbox"){
			 	 			if(result[$(item).attr('id')]=='1'){
			 	 				$(this).attr('checked', 'true');
			 	 			}
			 	 			if(result[$(item).attr('id')]=='Y'){
			 	 				$(this).attr('checked', 'true');
			 	 			}
			 	 		}
					})

					if (!( $("#coplexProdFlg").prop("checked"))){
						  $($('#coplexProdForm').find('input[type=text]')).each(function(index, item){
				    			$(this).attr("disabled",true);
				    	  })
					}
					if($("#coplexProdFlg").val()=='Y'){
	 	 				$(this).attr('checked', 'true');
	 	 				prodIdValid="F";
	 	 			}else if($("#coplexProdFlg").val()=='N'){
	 	 				prodIdValid="S";
	 	 			}
				/* 	$($('#prudctDtlForm').find('input')).each(function(index, item){
						$(item).val(result.rows[0][$(item).attr('id')]);
			 	 		if($(this).attr('type')=="checkbox"){
			 	 			if(result.rows[0][$(item).attr('id')]=='1'){
			 	 				$(this).attr('checked', 'true');
			 	 			}
			 	 		}
			 		});
			 		$($('#prudctDtlForm').find('select')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
		 				$.fn.ifvGetHierarchySelect("prodTypeLv2",'<ifvm:action name="getHierarchyCommCodeList"/>','PROD_LEVEL_2',$("#prodTypeLv1").val(), true );
			 		});
			 		$($('#prudctDtlForm').find('select')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 		}); */
			  }
			  prodTempObj = result;
		});
	}else{
		$("#statusCd").val("00");
	}

	if($("#coplexProdFlg").prop("checked")){
		  $($('#coplexProdForm').find('input[type=text]')).each(function(index, item){
  			$(this).attr("disabled",false);
  	  })
	}else{
		  $($('#coplexProdForm').find('input[type=text]')).each(function(index, item){
  			$(this).attr("disabled",true);
  	  })
	}

	numberFormatterSetting();
	buttonValid();
}

function coplexProdFlgDiv(){
	if($("#coplexProdFlg").prop("checked")){
	}else{
		  $("#prodId").val(  $(this).val().replace(regNumber,'') );
	}
}

function buttonValid(){
	if($("#statusCd").val()=="10"){
		productDtlDisabled();
		$("#productDetailSaveBtn").attr("disabled",true)
		$("#productConfirmBtn").attr("disabled",true);
		$("#channelSearchBtn").addClass("hidden");
		$("#taxtnProdNmSearch").addClass("hidden");
		$("#taxfrProdNmSearchBtn").addClass("hidden");
	}else{
		$("#channelSearchBtn").removeClass("hidden");
		$("#taxtnProdNmSearch").removeClass("hidden");
		$("#taxfrProdNmSearchBtn").removeClass("hidden");
	}
	if(!($("#taxtnYn").prop("checked"))){
		$("#taxtnProdNmSearch").addClass("hidden");
		$("#taxfrProdNmSearchBtn").addClass("hidden");
	//	if(prodTempObj.length)
	}
	if($("#compnUseYn").prop("checked")){
	 	$("#chnlNm").attr("disabled",true);
    	$("#channelSearchBtn").addClass("hidden");
	}
}

//1000단위 정규식
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function setAuthBtn(){
	//상담원권한(E10004, E10005)만 가지고 있을 경우 화면의 필드, 버튼 비활성화 (readOnly)
	var authList = $.ifvmGetAuthInfo().authList;
	var isAuth = false;

	for(var i = 0 ; i < authList.length ; i++){
		if(authList[i].authName == 'E10004' || authList[i].authName == 'E10005'){
			isAuth = true;
		}
	}
	if(isAuth){
		$("#prudctDtlForm input").prop('disabled',true);
		$("#prudctDtlForm .input-group-addon, #headForm button").hide();
	}
}
$(document).ready(function(){
	$.ifvmLnbSetting('productList');
	commCodeSetting();
	productDataLoad(testViewList_rid);
	checkBoxClickFn();
	tabContent();
	selectChangeEvent();
	fnKeyUp();
	setAuthBtn();
});

function selectChangeEvent(){
	$("#prodTypeLv1").change(function(){
		$.fn.ifvGetHierarchySelect("prodTypeLv2",'<ifvm:action name="getHierarchyCommCodeList"/>','PROD_LEVEL_2',$("#prodTypeLv1").val(), true );
	})
}
//1000단위 정규식
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function numberFormatterSetting(){
	var numFormatVal=$("#taxtnOccAmt").val();
	$("#taxtnOccAmt").ifvNumberOnly();
	$("#taxtnOccAmt").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#taxtnRate").val();
	$("#taxtnRate").ifvFloatOnly("2");
	$("#taxtnRate").css("text-align","right");
	$("#taxtnRate").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#price").val();
	$("#price").ifvNumberOnly("2");
	$("#price").css("text-align","right");
	$("#price").val(numberWithCommas(numFormatVal));
}

function tabContent(){
	var testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L01373"/>' , href: '<ifvm:url name="productPriceList"/>'+""},
			{label:'<spring:message code="L01374"/>' , href: '<ifvm:url name="productCodeList"/>'},
			/* {label:'<spring:message code="L01375"/>' , href: '<ifvm:url name="accountCodeList"/>'}, */
		]
	});
}
function productLitFn(){
		var url = '<ifvm:url name="productList"/>';
 		qtjs.href(url);
}
function commCodeSetting(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'PROD_LEVEL_1'
		, enableNA : true
	},function(result) {
		var temp = $("#prodTypeLv1Temp").tmpl(result.rows);
		$("#prodTypeLv1").append(temp);
	});
/*
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'PROD_LEVEL_2'
		, enableNA : true
	},function(result) {
		var temp = $("#prodTypeLv2Temp").tmpl(result.rows);
		$("#prodTypeLv2").append(temp);
	});
	 */
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'PRODUCT_STATUS'
		, enableNA : true
	},function(result) {
		var temp = $("#statusCdTemp").tmpl(result.rows);
		$("#statusCd").append(temp);
	});

	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'ENIS_TRANS_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#enisSetlMethTemp").tmpl(result.rows);
		$("#enisSetlMeth").append(temp);
	});
}

function checkBoxClickFn(){
	   $('#taxtnYn').click(function() { // 과세분기여부 클릭시 이벤트
	        if ($(this).is(':checked')) {
	        	$("#taxtnProdNm").attr("disabled",false);
	        	$("#taxfrProdNm").attr("disabled",false);

	    		$("#taxtnProdNmSearch").removeClass("hidden");
	    		$("#taxfrProdNmSearchBtn").removeClass("hidden");
	    		if(prodTempObj.taxtnProdNm!=null){
	    			$("#taxtnProdNm").val(prodTempObj.taxtnProdNm);
	    			$("#taxtnProdCd").val(prodTempObj.taxtnProdCd);
	    			$("#taxfrProdNm").val(prodTempObj.taxfrProdNm);
	    			$("#taxfrProdCd").val(prodTempObj.taxfrProdCd);
	    		}
	        }else{
	        	$("#taxtnProdNm").attr("disabled",true);
	        	$("#taxfrProdNm").attr("disabled",true);
	    		$("#taxtnProdNmSearch").addClass("hidden");
	    		$("#taxfrProdNmSearchBtn").addClass("hidden");
	    		if(prodTempObj.taxtnProdNm!=null){
	    			$("#taxtnProdNm").val(prodTempObj.taxtnProdNm);
	    		}
	    		taxtnYnValClear();
	        }
	    });



	   $('#compnUseYn').click(function() { // 다수가맹점여부 클릭시 이벤트
	        if ($(this).is(':checked')) {
	        	$("#chnlNm").attr("disabled",true);
	        	$("#channelSearchBtn").addClass("hidden");

	        	$("#chnlNm").val("");
	        	$("#chnlNo").val("");
	        	compnUseYnClear();
	        }else{
	    		if(prodTempObj.chnlNm!=null){
	    			$("#chnlNm").val(prodTempObj.chnlNm);
	    		}
	        	$("#chnlNm").attr("disabled",false);
	    		$("#channelSearchBtn").removeClass("hidden");
	        }
	    });

	   $("#coplexProdFlg").click(function(){
	      if ($(this).is(':checked')) {
	    	  $("#prodId").attr("maxlength",3);

	    	  $("#prodId").val( $("#prodId").val().substring(0,3)) ;
	    	  prodIdValid="F";
	    	  $("#prodNickNm").val(prodTempObj.prodNickNm);
	    	  $("#barcode").val(prodTempObj.barcode);
	    	  $("#price").val(prodTempObj.price);

	    	  $($('#coplexProdForm').find('input[type=text]')).each(function(index, item){
	    			$(this).attr("disabled",false);
	    	  })
	      }else{
	    	  $("#prodId").attr("maxlength",6);
	    	  $("#prodId").val( $("#prodId").val().replace(regNumber,'') );
	    	  prodIdValid="S";

	    	  $($('#coplexProdForm').find('input[type=text]')).each(function(index, item){
	    			$(this).val("");
	    			$(this).attr("disabled",true);
	    	  })
	      }
	   })
}

function fnKeyUp(){
	$( "#prodId" ).keyup( function () {
		if(prodIdValid=="S"){
			$(this).val(  $(this).val().replace(regNumber,'') );
		}else if(prodIdValid=="F"){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
			   }
		}
	});
}

function taxtnYnValClear(){
	$("#taxtnProdNm").val("");
	$("#taxtnProdCd").val("");
	$("#taxfrProdNm").val("");
	$("#taxfrProdCd").val("");
}

function compnUseYnClear(){
	$("#chnlNm").val("");
	$("#chnlNo").val("");
}

function productDetailSaveFn(){
	productValid = $("#prudctDtlForm").ifvValidation();
	if(productValid.confirm()==true){
		var submitData=$("#prudctDtlForm").getSubmitData();
		if($("#compnUseYn").prop("checked")){
			submitData.compnUseYn = "Y"
			submitData.ridChnl ="";
		}else{
			submitData.compnUseYn = "N"
		}
		if($("#taxtnYn").prop("checked")){
			submitData.taxtnYn = "Y"
		}else{
			submitData.taxtnYn = "N"
			submitData.ridTaxtn = "";
			submitData.ridTaxfr = "";
		}
		if($("#priceFlg").prop("checked")){
			submitData.priceFlg = "1";
		}else{
			submitData.priceFlg = "0";
		}

		if($("#coplexProdFlg").prop("checked")){
			submitData.coplexProdFlg = "Y";
			if($("#prodId").val().substring(0,1)!="E"  ||   !regNumber2.test(  $("#prodId").val().substring(1,3)) ){
				alert('<spring:message code="L01874"/>');
				$("#prodId").focus();
				return;
			}

		}else{
			if($("#prodId").val().length<3){
				alert('<spring:message code="L02005"/>');
				return;

			}
			var numberValid = /^[0-9]*$/;
			if(!numberValid.test($("#prodId").val())){
				alert('<spring:message code="L01935"/>');
				$("#prodId").focus();
				return;
			}
			submitData.coplexProdFlg = "N";
		}
		submitData.rid =  testViewList_rid;
		//,제거
		
		submitData.taxtnOccAmt = $("#taxtnOccAmt").val().replace(/[^\d]+/g, '');
	//	submitData.taxtnRate = $("#taxtnRate").val().replace(/[^\d]+/g, '');
		if(testViewList_rid =="null"){
			 $.ifvSyncPostJSON('<ifvm:action name="insertProductDetail"/>', submitData, function(result) {
					alert('<spring:message code="I00741"/>');
					testViewList_rid=result.message;
					 qtjs.href('<ifvm:url name="productDetail"/>' + '?rid=' + testViewList_rid);
				 },function(result){
					 alert(result.message);
					 return;
				 });
		}else{
			if(originalProdId == $("#prodId").val()){
				submitData.idCheckFlg ="Y";
			}else{
				submitData.idCheckFlg ="N";
			}
			 $.ifvSyncPostJSON('<ifvm:action name="updateProductDetail"/>', submitData, function(result) {
					alert('<spring:message code="L00148"/>');
					productDataLoad(testViewList_rid);
				 },function(result){
					 alert(result.message);
				 });
		}
	}
}

function channelSearchFn(){
	channelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>' + '?ouTypeCd=' + 'A');
}

function channelSearchHelpBlur(){
	if($("#chnlNm").val()==""){
		$("#ridChnl").val("");
		$("#chnlNo").val("");
	}else{
		channelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>'+'?ouTypeCd=A&&chnlNm=' +encodeURI(encodeURIComponent($('#chnlNm').val())));
	}
}

function channelSearchHelpEnter(){
	if($("#chnlNm").val()==""){
		$("#ridChnl").val("");
		$("#chnlNo").val("");
	}else{
		channelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>'+'?ouTypeCd=A&&chnlNm=' +encodeURI(encodeURIComponent($('#chnlNm').val())));
	}
}

function channelSearchHelpPopOpen(url){
	channelSearchHelpPop ={
	        id : "channelSearchPopDiv"
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
	        	$("#chnlNm").val(obj.chnlNm);
	        	$("#chnlNo").val(obj.chnlNo);
	        	$("#ridChnl").val(obj.rid);
	        	prodTempObj.chnlNm = obj.chnlNm;
	        }else{
	        	$("#chnlNm").val(prodTempObj.chnlNm);
	        }
	        this.beforeClose(obj);
	        channelSearchPopDiv._destroy();
	 };
	channelSearchHelpPop.popup();
}

function taxtnProdNmSearchHelpBlur(){
	if($.trim($('#taxtnProdNm').val())==""){
		$('#ridTaxtn').val("");
		$('#taxtnProdCd').val("");
	}else{
		taxtnProdNmSearchPopOpen('<ifvm:url name="prodSearchHelp"/>'+"?prodNm="+encodeURI(encodeURIComponent($('#taxtnProdNm').val())));
	}
}

function taxtnProdNmSearchHelpEnter(){
	if($.trim($('#taxtnProdNm').val())==""){
		$('#ridTaxtn').val("");
		$('#taxtnProdCd').val("");
	}else{
		taxtnProdNmSearchPopOpen('<ifvm:url name="prodSearchHelp"/>'+"?prodNm="+encodeURI(encodeURIComponent($('#taxtnProdNm').val())));
	}
}

function taxtnProdNmSearchFn(){
	taxtnProdNmSearchPopOpen('<ifvm:url name="prodSearchHelp"/>');
}

function taxtnProdNmSearchPopOpen(url){
	prodSearchHelpPop ={
	        id : "prodSearchHelpPopDiv"
	    };
prodSearchHelpPop.popup = function (){
	prodSearchHelpPop.pop = $('#'+prodSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: url,
	            contentType: "ajax",
	            title: "<spring:message code='L01394'/>",
	            width: "700px"
	        });
	};
	prodSearchHelpPop.beforeClose = function (obj) {
	};
	prodSearchHelpPop.close = function (obj) {
		 if(obj!=null || typeof obj!="undefined"){
	        	$("#taxtnProdNm").val(obj.prodNm);
	        	$("#taxtnProdCd").val(obj.prodId);
	        	$("#ridTaxtn").val(obj.rid);
	        	prodTempObj.taxtnProdNm = obj.prodNm;
	        }else{
	        	$("#taxtnProdNm").val(prodTempObj.taxtnProdNm);
	        }

	        this.beforeClose(obj);
	        prodSearchHelpPopDiv._destroy();
	 };
	 prodSearchHelpPop.popup();
}

function taxfrProdNmSearchHelpBlur(){
	if($("taxfrProdNm").val()==""){
		$('#ridTaxtn').val("");
		$('#taxtnProdCd').val("");
	}else{
		taxfrProdNmSearchPopOpen('<ifvm:url name="prodSearchHelp"/>'+"?prodNm="+encodeURI(encodeURIComponent($('#taxfrProdNm').val())));
	}
}

function taxfrProdNmSearchHelpEnter(){
	if($("taxfrProdNm").val()==""){
		$('#ridTaxtn').val("");
		$('#taxtnProdCd').val("");
	}else{
		taxfrProdNmSearchPopOpen('<ifvm:url name="prodSearchHelp"/>'+"?prodNm="+encodeURI(encodeURIComponent($('#taxfrProdNm').val())));
	}
}

function taxfrProdNmSearchFn(){
	taxfrProdNmSearchPopOpen('<ifvm:url name="prodSearchHelp"/>');
}
function taxfrProdNmSearchPopOpen(url){
	prodSearchHelpPop ={
	        id : "prodSearchHelpPopDiv"
	    };
prodSearchHelpPop.popup = function (){
	prodSearchHelpPop.pop = $('#'+prodSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: url,
	            contentType: "ajax",
	            title: "<spring:message code='L01394'/>",
	            width: "700px"
	        });
	};
	prodSearchHelpPop.beforeClose = function (obj) {
	};
	prodSearchHelpPop.close = function (obj) {
		 if(obj!=null || typeof obj!="undefined"){
	        	$("#taxfrProdNm").val(obj.prodNm);
	        	$("#taxfrProdCd").val(obj.prodId);
	        	$("#ridTaxfr").val(obj.rid);
	        	prodTempObj.taxfrProdNm = obj.prodNm;
	        }else{
	        	$("#taxfrProdNm").val(prodTempObj.taxfrProdNm);
	        }
	        this.beforeClose(obj);
	        prodSearchHelpPopDiv._destroy();
	 };
	 prodSearchHelpPop.popup();
}

function productDtlDisabled(){
	$('#prudctDtlForm').find('input').each(function(index, item){
		$(item).attr("disabled",true);
	});

	$('#prudctDtlForm').find('select').each(function(index, item){
		$(item).attr("disabled",true);
	});
}

function prodDtlValidCheck(){
	productValid = $("#prudctDtlForm").ifvValidation();
	var validCheck =false;
	if(productValid.confirm()==true){
		validCheck =  true;

		if($("#prodId").val().length>=3 &&  $("#prodId").val().length <=6){
			validCheck = true;
		}else{
			validCheck = false
			$.ifvCallValidationBox($("#prodId"),
			'<spring:message code="L01832"/>');
		}
	}
	return validCheck;
}

function productConfirmFn(){
	//productValid = $("#prudctDtlForm").ifvValidation();
	if(prodDtlValidCheck()){
		var submitData=$("#prudctDtlForm").getSubmitData();
		if($("#compnUseYn").prop("checked")){
			submitData.compnUseYn = "Y"
		}else{
			submitData.compnUseYn = "N"
		}
		if($("#taxtnYn").prop("checked")){
			submitData.taxtnYn = "Y"
		}else{
			submitData.taxtnYn = "N"
		}

		submitData.rid =  testViewList_rid;
		//,제거
		submitData.taxtnOccAmt = $("#taxtnOccAmt").val().replace(/[^\d]+/g, '');
		submitData.taxtnRate = $("#taxtnRate").val().replace(/[^\d]+/g, '');

		if(confirm('<spring:message code="L02010"/>')) {
			if(testViewList_rid !="null" ){ // 수정
				$.ifvSyncPostJSON('<ifvm:action name="updateProdStatusCd"/>', submitData, function(result) {
					 $.ifvSyncPostJSON('<ifvm:action name="updateProdStatusCd"/>',{rid : testViewList_rid}, function(result) {
							alert('<spring:message code="L01588"/>');
							productDataLoad(testViewList_rid);
							productDtlDisabled();
						 });
				 },function(result){
					 alert(result.message);
					 return;
				 });
			}else{ //신규
				 $.ifvSyncPostJSON('<ifvm:action name="insertProductDetail"/>', submitData, function(result) {
						testViewList_rid=result.message;
						 $.ifvSyncPostJSON('<ifvm:action name="updateProdStatusCd"/>',{rid : testViewList_rid},
							function(result) {
								alert('<spring:message code="L01588"/>');
								location.replace('<ifvm:url name="productDetail"/>' + '?rid=' + testViewList_rid);
							 });
					 },function(result){
						 alert(result.message);
						 return;
					 });
			}
		}


	}
}

</script>

<script id="prodTypeLv1Temp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="prodTypeLv2Temp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="statusCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="enisSetlMethTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="page-title">
 <h1>
	<spring:message code="L01282"/>&gt;  <spring:message code="L00079"/>
 </h1>
</div>

<div class="page_btn_area" id="headForm">
 <div class="col-xs-7">
  <span> <spring:message code="L01372"/></span>
 </div>

 <div class="col-xs-5 searchbtn_r">
 	<ifvm:inputNew type="button" btnType="save"  text="L00074"  id="productDetailSaveBtn" btnFunc="productDetailSaveFn"/>
  	<ifvm:inputNew type="button" text="L00900"  id="productConfirmBtn" btnFunc="productConfirmFn"/>
  	<ifvm:inputNew type="button" text="M00002"  id="productLitBtn" btnFunc="productLitFn"/>
 </div>
</div>
<div id="prudctDtlForm">
	<div class="form-horizontal underline top_well">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01988" /></span>
			</div>
		</div>
		<div class="row  qt_border">
			<ifvm:inputNew type="text" id="prodNm" maxLength="50"  dto="prodNm"   label="L01266" labelClass="1" conClass="2" required="true"/>
			<ifvm:inputNew type="text" id="prodId" maxLength="6"  dto="prodId"   label="L01265" labelClass="1" conClass="2" required="true"/>
		    <ifvm:inputNew type="text" id="taxtnOccAmt" maxLength="50"  dto="taxtnOccAmt"   label="L01272" labelClass="1" conClass="2" />
		    <ifvm:inputNew type="text" id="taxtnRate" maxLength="50"  dto="taxtnRate"   label="L01273" labelClass="1" conClass="2" />
		</div>
		<div class="row  qt_border">
			<ifvm:inputNew type="select" id="prodTypeLv1" maxLength="50"  dto="prodTypeLv1"   label="L01263" labelClass="1" conClass="2"  required="true"/>

			<ifvm:inputNew type="select" id="prodTypeLv2" maxLength="50"  dto="prodTypeLv2"   label="L01264" labelClass="1" conClass="2"  required="true"/>

			<ifvm:inputNew type="search" id="taxtnProdNm|taxtnProdNmSearch"  dto="taxtnProdNm" names="taxtnProdNm" hidId="ridTaxtn" hidDto="ridTaxtn"
				   btnFunc="taxtnProdNmSearchFn" searchBlurEvent="taxtnProdNmSearchHelpBlur" searchEnterEvent="taxtnProdNmSearchHelpEnter" label="L01275"  labelClass="1" conClass="2" />
		    <ifvm:inputNew type="text" id="taxtnProdCd" maxLength="50"  dto="taxtnProdCd"   label="L01274" labelClass="1" conClass="2"  disabled="true"/>
		</div>

		<div class="row  qt_border">
			<ifvm:inputNew type="search" id="chnlNm|channelSearchBtn"  dto="chnlNm" names="chnlNm" hidId="ridChnl" hidDto="ridChnl"  disabled="false"
				   btnFunc="channelSearchFn" searchBlurEvent="channelSearchHelpBlur" searchEnterEvent="channelSearchHelpEnter" label="L01262"  labelClass="1" conClass="2" />
			<ifvm:inputNew type="text" id="chnlNo" maxLength="50"  dto="chnlNo"   label="L01261" labelClass="1" conClass="2"  disabled="true"/>

			<ifvm:inputNew type="search" id="taxfrProdNm|taxfrProdNmSearchBtn"  dto="taxfrProdNm" names="taxfrProdNm" hidId="ridTaxfr" hidDto="ridTaxfr"
				   btnFunc="taxfrProdNmSearchFn" searchBlurEvent="taxfrProdNmSearchHelpBlur" searchEnterEvent="taxfrProdNmSearchHelpEnter" label="L01277"  labelClass="1" conClass="2" />
		    <ifvm:inputNew type="text" id="taxfrProdCd" maxLength="50"  dto="taxfrProdCd"   label="L01276" labelClass="1" conClass="2"  disabled="true"/>
		</div>
	 	<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="L01267"/></label>
			<div class="col-xs-2 control_content">
				<input type="checkbox"  id="compnUseYn"/>
			</div>
			<ifvm:inputNew type="select" id="statusCd" maxLength="50"  dto="statusCd"   label="L01269" labelClass="1" conClass="2" disabled="true" />
			<ifvm:inputNew type="select" id="enisSetlMeth" maxLength="50"  dto="enisSetlMeth"   label="L01270" labelClass="1" conClass="2" required="true" />
			<label class="col-xs-1 control-label"><spring:message code="L01271"/></label>
			<div class="col-xs-2 control_content">
				<input type="checkbox"  id="taxtnYn" />
			</div>
		</div>

		<div class="row  qt_border">
			<ifvm:inputNew type="text" id="desc1" maxLength="300"  dto="desc1"   label="L01268" labelClass="1" conClass="8" 	/>

		<%-- 	<label class="col-xs-1 control-label"><spring:message code="L01866"/></label>
			<div class="col-xs-2 control_content">
				<input type="checkbox"  id="coplexProdFlg" />
			</div> --%>
		</div>
	 </div>

	 <div class="form-horizontal underline top_well" id="coplexProdForm" >
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01989" /></span>
			</div>
		</div>

		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="L01990"/></label>
			<div class="col-xs-2 control_content">
				<input type="checkbox"  id="coplexProdFlg" />
			</div>
			<ifvm:inputNew type="text" id="prodNickNm" maxLength="300"  dto="prodNickNm"   label="L01991" labelClass="1" conClass="2" 	/>
			<ifvm:inputNew type="text" id="barcode"    maxLength="300"  dto="barcode"   label="L01992" labelClass="1" conClass="2" 	/>
		</div>

		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="L01994"/></label>
			<div class="col-xs-2 control_content">
				<input type="checkbox"  id="priceFlg" />
			</div>
			<ifvm:inputNew type="text" id="price" maxLength="300"  dto="price"   label="L01993" labelClass="1" conClass="2" 	/>
		</div>
	</div>
</div>

 <!-- 탭 컨텐츠 -->
 <div id="tabArea">
	<div id="tabContent" ></div>
 </div>


<div id="channelSearchPopDiv" class="popup_container"></div>
<div id="prodSearchHelpPopDiv" class="popup_container"></div>
