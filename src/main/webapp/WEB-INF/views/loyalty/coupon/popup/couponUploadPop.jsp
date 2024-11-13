<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
    function fileSearchFn() {
        fnExcelUpload({
                url: '<ifvm:action name="paymentCpnMultiUpload"/>',
                fileName: $("#fileName").val(),
                data: {
                    offerNo : "O000023",
                },
            }
            , function (result) {
            	alert(result.message);
                $.ifvProgressControl(false);
                couponUploadPop._destroy();
                couponUploadListSearch();

            }
            , function (){
                $('#fileName').val(fnExcelUpload.fileName);
            });
    }

    function fnUpload(){
                var _obj = {
                    url: '<ifvm:action name="paymentCpnMultiUpload"/>',
                    fileName: $("#fileName").val(),
                    data: {
                        offerNo : "O000023",
                    },
                };

                fnExcelUpload.data.formData ={
                    param : JSON.stringify(_obj)
                }

                fnExcelUpload.upload();
                $.ifvProgressControl(false);
    }

    $(document).ready(function(){
   	  $('#closeCouponUploadPopBtn').on('click', function(){
   		couponUploadPop._destroy();
	    });

   	$('#couponUploadBtn').on('click', function(){
   		fnUpload();
   	});



    });

</script>
<div class="form-horizontal underline top_well underline" id="newCustDetailForm">
<br>
	<div  class="form-horizontal underline top_well underline"  id="baseValidForm">
		<div class="page_btn_area"> <spring:message code="쿠폰 정보"/> </div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="fileName" dto="fileName" label="L01700" labelClass="2" conClass="8" disabled="true"  required="true"/>
    		<ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn"/>
		</div>

	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="couponUploadBtn" objCode="">
		<spring:message code="L01672" />
	</button>
	<button class="btn btn-sm btn_gray"  id="closeCouponUploadPopBtn" objCode="">
		<spring:message code="L00941" />
	</button>
</div>
