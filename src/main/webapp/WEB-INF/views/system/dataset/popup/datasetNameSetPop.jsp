<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var commentsData = null;
var ownerData = null;
var objectNameData = null;

function dataSetGridFun(){
    var ejGridOption = {
        recordDoubleClick : function(args){
            commentsData = args.data.comments;
            ownerData = args.data.owner;
            objectNameData = args.data.objectName;
            
          },
          rowSelected : function (args) {
              commentsData = args.data.comments;
              ownerData = args.data.owner;
              objectNameData = args.data.objectName;          
          },
        dataUrl : '<ifvm:action name="getSysDataSetList"/>',
        columns : [
            {
                field : 'owner', headerText : '<spring:message code="스키마"/>',  textAlign : 'center', width:70 , customAttributes : {index : 'F.NAME', searchable : true}
            }           
            ,{
                field : 'objectName', headerText : '<spring:message code="오브젝트명"/>',  textAlign : 'center', width:250 , customAttributes : {index : 'A.NAME' , searchable : true}
            }      
            ,{
                field : 'objectType', headerText : '<spring:message code="오브젝트 유형"/>',  textAlign : 'center', width:90 , customAttributes : {index : 'A.TYPE', searchable : true}
            }
            ,{
                field : 'comments', headerText : '<spring:message code="코멘트"/>',  textAlign : 'center', width:320 ,customAttributes : {index : 'C.value', searchable : true}
            }      
        ],

        requestGridData : {
          sidx : '2',
          sord : 'desc'
        },
        gridDataInit: true,
        radio: true
    };

    dataSetGrid = $("#dataSetGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
    dataSetGridFun();
    $("#selectBtn").click(function(){
        if(commentsData != null && commentsData != ''){
            $('#dsNm').val(commentsData);
        } else {
            $('#dsNm').val('');
        } 
        if(ownerData != null && ownerData != ''){
            if(objectNameData != null && objectNameData != ''){
                $('#objNm').val(ownerData+"."+objectNameData);
            } else {
                $('#objNm').val('');
            }
        } else {
            $('#objNm').val('');
        }
        
        $.fn.ifvmPopupClose();
    });
    $("#cancelBtn").click(function(){
        $.fn.ifvmPopupClose();
    });
});

</script>
<div id="dataSetGrid"></div>

<!-- End -->
<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <!-- 선택 -->
        <button class="btn btn-sm btn_gray" id="selectBtn" objCode="datasetNameSelectBtn_OBJ">
            <spring:message code="M00282"/>
        </button>
        <!-- 닫기 --> 
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="datasetNameCancelBtn_OBJ">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>

