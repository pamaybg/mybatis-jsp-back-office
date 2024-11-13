<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class ="row white_bg">
    <div id="mbrMobileLoginPopGrid" class="white_bg grid_bd0"></div>
</div>  
<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <!-- 닫기 --> 
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>
<script>
    function mbrMobileLoginPopGridSelect(){
        var ejGridOption = {
            serializeGridData : function(data) {
                    data.rid = custRid;
                return data;
            },
            dataUrl : '<ifvm:action name="getMbrMobileLoginPopGrid"/>',
            columns : [
                {
                    field : 'mobileDeviceCdNm', headerText : '디바이스유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'mobileDeviceCd'}
                }
                ,{
                    field : 'verNo', headerText : '버전 ', headerTextAlign : 'center', textAlign : 'center'
                }
                ,{
                    field : 'tokenVal', headerText : '토근', headerTextAlign : 'center', textAlign : 'left'
                }
                ,{
                    field : 'deviceAgreYn', headerText : '동의여부', headerTextAlign : 'center', textAlign : 'center'
                }
                ,{
                    field : 'regDate', headerText : '등록일', headerTextAlign : 'center', textAlign : 'center'
                }
            ],
    
            requestGridData : {
              sidx : '1',
              sord : 'desc'
            },
            gridDataInit: true,
            radio: true,
            tempId : 'ifvGridNoneLeftTemplete'
        };
    
        mbrMobileLoginPopGrid = $("#mbrMobileLoginPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    }
    
    $(document).ready(function(){
        mbrMobileLoginPopGridSelect();
        $("#cancelBtn").click(function(){
            mbrMobileLoginPopClose();
        });
    });
</script>