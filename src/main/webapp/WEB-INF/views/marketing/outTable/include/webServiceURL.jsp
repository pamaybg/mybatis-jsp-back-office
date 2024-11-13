<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var webServiceId = null;

function getWebServiceListInit(){
    var ejGridOption = {
            rowSelected : function (args) {
                webServiceId = args.data.id;
            },
        dataUrl: '<ifvm:action name="getwebService"/>',
        columns  :[
            {
                field : 'title', headerText : '<spring:message code="M02509"/>',textAlign : 'left' , headerTextAlign : 'center',
                customAttributes : {
                    index : 'cw.TITLE' }
            }
            ,{
                field : 'siteName', headerText : '<spring:message code="M03019"/>',textAlign : 'left' , headerTextAlign : 'center',
                customAttributes : {
                    index : 'cw.SITENAME' } 
            }
            ,{
                field : 'host', headerText : '<spring:message code="M03012"/>', headerTextAlign : 'center',
                customAttributes : {
                    index : 'cw.HOST' } 
            
              }
            ,{
                field : 'port', headerText : '<spring:message code="M03013"/>', headerTextAlign : 'center',
                customAttributes : {
                    index : 'cw.PORT'} 
            
              }
            ,{
              field : 'accessToken', headerText : '<spring:message code="M03014"/>', headerTextAlign : 'center',
              customAttributes : {
                  index : 'cw.ACCESS_TOKEN' } 
          
            }
            ,{
              field : 'refreshToken', headerText : '<spring:message code="M03015"/>',textAlign : 'center' , headerTextAlign : 'center',
              customAttributes : {
                  index : 'cw.REFRESH_TOKEN'} 
            }
          ,{
              field : 'mallId', headerText : '<spring:message code="M03016"/>',textAlign : 'left' , headerTextAlign : 'center',
              customAttributes : {
                  index : 'cw.MALL_ID' } 
          }
          ,{
              field : 'clientId', headerText : '<spring:message code="M03017"/>',textAlign : 'left' , headerTextAlign : 'center',
              customAttributes : {
                  index : 'cw.CLIENT_ID' } 
          }
          ,{
              field : 'clientSecretId', headerText : '<spring:message code="M03018"/>',textAlign : 'left' , headerTextAlign : 'center',
              customAttributes : {
                  index : 'cw.CLIENT_SECRET_ID' } 
          }
          ,{
              field : 'id', headerText : 'id', visible : false ,
              customAttributes : {
                  searchable : false,
                  index : 'cw.ID' } //
          },
      ],  
      requestGridData : {
          sidx : '1',
          sord : 'desc',
      },
      
      rowList : [10,25,50,100],
      radio: true,
      tempId : 'ifvGridSimplePageTemplete'
    };
    webServiceList = $("#webServiceList").ifvsfGrid({ ejGridOption : ejGridOption });
}
 
function targetLevelPopInit(title){
    $("#webServicePop").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="webServicePop"/>',
        contentType: "ajax",
        title: title,
        width: 650,
        close : 'webServicePopClose',
    });
}

function webServicePopClose() {
    webServicePop._destroy();
}


$(document).ready(function(){
    getWebServiceListInit();
    
    $('#addWebServiceList').on('click', function() {
        webServiceId = "";
        targetLevelPopInit("<spring:message code='M00167'/>");
    });
    
    $('#removeWebServiceList').on('click', function() {
        var rowData = webServiceList.opt.gridControl.getSelectedRecords()[0].id;
        
        if( rowData != null ){
            if(confirm('<spring:message code="M00208"/>')){
                //이벤트 조회
                $.ifvSyncPostJSON('<ifvm:action name="deleteWebService"/>', {
                    webServiceId : rowData
                }, function(result) {
                    alert('<spring:message code="M00590"/>');
                    webServiceList._doAjax();
                });
            }
        } else {
            alert('<spring:message code="C00113"/>');
        }
    });
    
    $("#modifyWebServiceList").on('click', function(){
        var data = webServiceList.opt.gridControl.getSelectedRecords()[0].id;
        
        if(typeof(data) == 'undefined'){
            alert('<spring:message code="M00004" />');
        }
        else{
            webServiceId = webServiceList.opt.gridControl.getSelectedRecords()[0].id;
            targetLevelPopInit("<spring:message code='M00167'/>");
        }
        
    });
});

</script>
    

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="M03011"/></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="addWebServiceList" objCode="webServiceNewAdd_OBJ">
            <i class="fa fa-plus"></i>
            <spring:message code="M01120"/>
        </button> 
        
        <button class="btn btn-sm" id="modifyWebServiceList" objCode="webServiceNewModify_OBJ">         
            <spring:message code="M00259"/>
        </button> 
        
        <button class="btn btn-sm" id="removeWebServiceList" objCode="webServiceNewDel_OBJ">
            <i class="fa fa-minus"></i>
            <spring:message code="M00275"/>
        </button> 
    </div>
</div>
<div id="webServiceList" class="grid_bd0"></div>
<div id="webServicePop" class="popup_container"></div>
