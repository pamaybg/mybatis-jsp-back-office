<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var targetMbrNoListGrid;

function getTargetMbrNoListGrid() {
    var ejGridOption = {
        serializeGridData: function(data) {
            return data;
        },
        loadComplete : function(obj) {
        },
        dataUrl: '<ifvm:action name="getTargetMbrNoList"/>',
        columns:[
            {
                field : 'custNm', headerText : '<spring:message code="L00435"/>', headerTextAlign : 'center', textAlign: 'center',
                customAttributes : {
                    index : 'tgmn.CUST_NM' }
            },
            {
                field : 'hhpNo', headerText : '<spring:message code="L01803"/>', headerTextAlign : 'center', textAlign: 'center',
                customAttributes : {
                    index : 'tgmn.HHP_NO' }
            },
            {
                field : 'mbrNo', headerText : '<spring:message code="L01798"/>', headerTextAlign : 'center', textAlign: 'center',
                customAttributes : {
                    index : 'tgmn.MBR_NO' }
            }
            ],
            requestGridData : {
                  nd   : new Date().getTime(),
                  rows : 10,
                  sidx : 'tgmn.CUST_NM',
                  sord : 'desc',
                  _search : false
              },
              rowList : [10,25,50,100],
              tempId : 'ifvGridNotSearchTemplete'
        };
    targetMbrNoListGrid = $("#targetMbrNoListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
	  


function fileUploadFn(){
	fileUploadPop ={
		        id : "targetMbrexcelUploadPop"
		    };
	fileUploadPop.popup = function (){
			 fileUploadPop.pop = $('#'+fileUploadPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="mbrExcelUploadPop"/>',
		            contentType: "ajax",
		            title: '<spring:message code="L01690" />',
		            width: "500px",
		            close: 'prodEntryUploadPopClose'
		        });
		};
	 	fileUploadPop.beforeClose = function (obj) {
		}; 
		fileUploadPop.close = function (obj) {
			getTargetMbrNoListGrid();
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		        
		        
		 };
		 fileUploadPop.popup();
}




$(document).ready(function() {
	
	getTargetMbrNoListGrid();
	
	$("#excelListBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/targetGroup/excelDownTargetMbrNoList.do','targetMbrNoListGrid' );
    });
	
});


function prodEntryUploadPopClose() {
	targetMbrexcelUploadPop._destroy();
}

function targetMbrExcelSampleDownFn(){
	var data = {
			fileName : "target_mbr_upload_sample.xlsx"
	};
	$.fn.ifvmExcelSampleDown(data);
}
</script>

<div>
	<div class="page_btn_area" >
	    <div class="col-xs-5">
	        <span><spring:message code="M00277" /></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button"   btnType="upload"  text="L01642"  id="fileUploadBtn" btnFunc="fileUploadFn"/>
 			<ifvm:inputNew type="button"   btnType="download"  text="I02131"  id="targetMbrExcelSampleDownFn" btnFunc="targetMbrExcelSampleDownFn"/>
 			<button class="btn btn-sm" id="excelListBtn" objCode="COM_EXC_001" >
             	<spring:message code="M01218" />
         	</button>
	    </div>
	</div>
	<div id="targetMbrNoListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="targetMbrexcelUploadPop" class="popup_container"></div>