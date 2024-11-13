<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
/* var PwChk = false; */
var pwChk = false;
$(document).ready(function(){
    
    $("#webServicePopCancel").on("click", function(){
        webServicePopClose();
    });
    $("#webServiceSaveBtn").on("click", function(){
        var obj = {};
        validation = $("#webServicePopFormArea").ifvValidation();
        
        if(validation.confirm()){
            if(webServiceId != ""){
                // 수정
                obj.webServiceId = webServiceId;
                obj.host = $("#host").val();
                obj.port = $("#port").val();
                obj.accessToken = $("#accessToken").val();
                obj.refreshToken = $("#refreshToken").val();
                obj.mallId = $("#mallId").val();
                obj.clientId = $("#clientId").val();
                obj.clientSecretId = $("#clientSecretId").val();
                obj.siteName = $("#siteName").val();
                obj.title = $('#title').val();
                
                $.ifvSyncPostJSON('<ifvm:action name="updateWebService"/>',obj
                ,function(result) {
                    alert('<spring:message code="M00267"/>');
                    webServicePopClose();
                    webServiceList._doAjax();
                });
            } else {
                // 입력
                obj.webServiceId = webServiceId;
                obj.host = $("#host").val();
                obj.port = $("#port").val();
                obj.accessToken = $("#accessToken").val();
                obj.refreshToken = $("#refreshToken").val();
                obj.mallId = $("#mallId").val();
                obj.clientId = $("#clientId").val();
                obj.clientSecretId = $("#clientSecretId").val();
                obj.siteName = $("#siteName").val();
                obj.title = $('#title').val();
                
                $.ifvSyncPostJSON('<ifvm:action name="insertWebService"/>',obj
                ,function(result) {
                    alert('<spring:message code="M00267"/>');
                    webServicePopClose();
                    webServiceList._doAjax();
                });
            }
        }
    });
});

/*로딩 시 세팅해주는 부분. 
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(function(){
    
    if(webServiceId != "") {
        //이벤트 조회
        $.ifvSyncPostJSON('<ifvm:action name="getwebServiceDetailPop"/>', {
            webServiceId : webServiceId
        }, function(result) {
            $("#host").val(result.host);
            $("#port").val(result.port);
            $("#accessToken").val(result.accessToken);
            $("#refreshToken").val(result.refreshToken);
            $("#mallId").val(result.mallId);
            $("#clientId").val(result.clientId);
            $("#clientSecretId").val(result.clientSecretId);
            $("#siteName").val(result.siteName);
            $("#title").val(result.title);
        });
    } else {
        $("#accessToken");
        $("#refreshToken");
        $("#host").val("");
        $("#port").val("");
        $("#accessToken").val("");
        $("#refreshToken").val("");
        $("#mallId").val("");
        $("#clientId").val("");
        $("#clientSecretId").val("");
        $("#siteName").val("");
        $("#title").val("");
    }
    
});
</script>

<div id='emailHostPopFormArea'>
    <div class="pop_inner_wrap form-horizontal">
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><spring:message code='M02509'/></label>
            <div class="col-xs-10 control_content">
                <ifvm:input type="text" id="title"/>
            </div>
        </div>

        <div class="row qt_border">
            <label class="col-xs-2 control-label"><spring:message code='M01376'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="host"/>
            </div>
            <label class="col-xs-2 control-label"><spring:message code='M01377'/></label>
             <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="port"/>
            </div>
        </div>
        
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><spring:message code='M03014'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="accessToken" />
            </div>
            <label class="col-xs-2 control-label"><spring:message code='M03015'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="refreshToken" />
            </div>
        </div>
        
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><spring:message code='M03017'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="clientId"/>
            </div>            
            <label class="col-xs-2 control-label"><spring:message code='M03018'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="clientSecretId"/>
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><spring:message code='M03019'/></label>
             <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="siteName"/>
            </div>
            <label class="col-xs-2 control-label"><spring:message code='M03016'/></label>
             <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="mallId"/>
            </div>
        </div>
    </div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="webServiceSaveBtn" objCode="webServicePopSave_OBJ">       
        <i class="glyphicon glyphicon-check"></i>  
        <spring:message code="M00280"/>
    </button>
    <button class="btn btn-sm btn_gray btn_lightGray2" id="webServicePopCancel" objCode="webServicePopCancel_OBJ">         
        <spring:message code="M00284"/>
    </button>  
</div>