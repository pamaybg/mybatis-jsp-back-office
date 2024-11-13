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
                $.ifvProgressControl(false);
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
</script>
<div>
    <ifvm:inputNew type="text" id="fileName" dto="fileName " label="L01700" labelClass="2" conClass="8" disabled="true"  required="true"/>
    <ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn"/>
</div>
