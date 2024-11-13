<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
    var FormVali = $("#contentTypeArea").ifvValidation();

    function addSaveAs() {

        if(!confirm("<spring:message code='M03034' />")){
            return;
        }
        if (FormVali.confirm()) {

            Differentdata.segmentName = $("#inputSaveAsName").val();
            //Differentdata.segmentDesc = $("#inputSaveAsDesc").val();
            Differentdata.oriSegmentId = segment.segmentId;
            Differentdata.logicalCompId = segment.logicalCompId;

            saveAsDifferentSegment();
        }
    }

    $(document).ready(function(){
        $("#btnSaveAsPopAdd").on("click", function(){
            addSaveAs();
        });

        $("#btnSaveAsPopCancel").on("click", function(){
            segmentDifferentSavePopClose();
        });
    });
</script>

<div id="contentTypeArea">
    <div class="pop_inner_wrap">
        <div class="form-horizontal">
            <div class="row qt_border store_content_top">
                <!-- 새그먼트 명 -->
                <div class="col-xs-12">
                    <div class="col-xs-12 control_content">
                        <div class="input-group">
                            <ifv:inputNew type="text" id="inputSaveAsName" label="세그먼트 명" maxLength="25" labelClass="3" conClass="7" required="true"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--<div class="form-horizontal">
            <div class="row qt_border store_content_top">
                <!-- 설명 -->
                <div class="col-xs-12">
                    <div class="col-xs-12 control_content">
                        <div class="input-group">
                            <ifv:inputNew type="text" id="inputSaveAsDesc" label="M00324" labelClass="3" conClass="7" maxLength="100" />
                        </div>
                    </div>
                </div>
            </div>--%>
        </div>
    </div>
    <div class="pop_btn_area">
        <!-- 저장 -->
        <button id="btnSaveAsPopAdd" class="btn btn-sm btn_gray" objCode="lcsbtnSaveAsPopAdd_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00137"/>
        </button>
        <!-- 취소 -->
        <button id="btnSaveAsPopCancel" class="btn btn-sm btn_lightGray2 cancel" objCode="lcsbtnSaveAsPopCancel_OBJ">
            <spring:message code="M00171"/>
        </button>
    </div>
</div>