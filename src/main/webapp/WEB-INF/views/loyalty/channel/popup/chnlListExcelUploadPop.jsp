<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-05-10
  Time: 오전 9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 업로드 폼 -->
<div id ="uploadForm">
    <div class="form-horizontal underline top_well"  >
        <div class="row qt_border" >

            <div class="col-xs-12">
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="파일경로"/></label>
                <!-- 파일네임 -->
                <ifvm:inputNew type="text" id="fileName" dto="fileName" labelClass="2" conClass="8" disabled="true"  required="true"/>
                <!-- 찾아보기 버튼 -->
                <ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn" objCode="chnlListUploadfileSearchBtn_OBJ"/>
            </div>
        </div>


    </div>
</div>
<div class="pop_btn_area">
    <!-- 저장 버튼 -->
    <ifvm:inputNew type="button" btnType="upload" text="M00137" id="uploadBtn" btnFunc="fnUploadsave" objCode="chnlListUplodaSave_OBJ"/>
    <!-- 닫기 버튼 -->
    <ifvm:inputNew type="button"  text="I00404" btnFunc="fnClose" objCode="chnlListUploadPopClose_OBJ"/>
</div>

<script>
    $(document).ready(function(){
        $("#uploadForm").ifvValidation();

    });

    function fileSearchFn() {
        fnExcelUpload({
                // 서버로 요청을 보냄( fileName이 실제론 없는 상태로 )
                url: '<ifvm:action name="setChnlMultiUpload"/>',
                fileName: $("#fileName").val(),
                data: {
                },
            }
            , function (result) { // 결과에 대한 피드백
                if(result.success){
                    if(result.messages) alert(result.message);
                    else alert('업로드 완료');
                    fnClose();
                }

                $.ifvProgressControl(false);
            }
            , function (){ // 파일네임 인풋객체에 받아가지고온 파일네임을 넣어준다
                // File 선택 후 동작 할 액션을 정의 한다.
                $('#fileName').val(fnExcelUpload.fileName);
            });
    }

    function fnUploadsave(){

        uploadValid = $("#uploadForm").ifvValidation();
        if (uploadValid.confirm() == true) {
            if( fnExcelUpload['upload'] ) {
                var _obj = {
                    url: '<ifvm:action name="setChnlMultiUpload"/>',
                    fileName: $("#fileName").val()
                };

                fnExcelUpload.data.formData = {
                    param : JSON.stringify(_obj)
                }

                fnExcelUpload.upload();
            } else {

            }
        }

        $.ifvProgressControl(false);
        // 업로드 완료한 후 페이지 새로고침
        location.reload();
    }

    // 엑셀업로드 팝업창 닫기
    function fnClose() {
        $.fn.ifvmPopupClose();
    }

</script>
