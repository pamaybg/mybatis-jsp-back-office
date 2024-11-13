<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var ownerData = $('#objNm').val();
var ownerDataArray = ownerData.split('.');

var columnNameData = null
var commentsData = null

function dataItemSetGridFun(){
    var ejGridOption = {
        serializeGridData : function(data) {
            console.log(ownerDataArray[1])
                data.objectName = ownerDataArray[1] ;
                return data;
        },
        recordDoubleClick : function(args){
            columnNameData = args.data.columnName;
            commentsData = args.data.comments;
            
          },
          rowSelected : function (args) {
              columnNameData = args.data.columnName;
              commentsData = args.data.comments;
          },
        dataUrl : '<ifvm:action name="getDataItemSetList"/>',
        columns : [
            {
                field : 'columnName', headerText : '<spring:message code="컬럼명"/>',  textAlign : 'center', width:80 ,customAttributes : {index : 'A.COLUMN_NAME'}
            }      
            ,{
                field : 'comments', headerText : '<spring:message code="설명"/>',  textAlign : 'center', width:70 , customAttributes : {index : '(C.VALUE'}
            }           
        ],

        requestGridData : {
          sidx : '3',
          sord : 'desc'
        },
        radio: true,
        tempId : 'ifvGridSimplePageTemplete'
    };

    dataItemSetGrid = $("#dataItemSetGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
    dataItemSetGridFun();
    $("#selectBtn").click(function(){
        if(columnNameData != null && columnNameData != ''){
            $('#fieldNm').val(columnNameData);
        } else {
            $('#fieldNm').val('');
        } 
        if(commentsData != null && commentsData != ''){
                $('#fieldDesc').val(commentsData);
        } else {
            $('#fieldDesc').val('');
        }
        
        $.fn.ifvmPopupClose();
    });
    $("#cancelBtn").click(function(){
        $.fn.ifvmPopupClose();
    });
});

</script>

<div id="dataItemSetGrid"></div>
<!-- End -->
<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <!-- 선택 -->
        <button class="btn btn-sm btn_gray" id="selectBtn" objCode="dataSetItemSelectBtn_OBJ">
            <spring:message code="M00282"/>
        </button>
        <!-- 닫기 --> 
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="dataSetItemCancelBtn_OBJ">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>

