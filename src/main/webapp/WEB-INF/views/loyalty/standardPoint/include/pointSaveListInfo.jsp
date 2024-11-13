<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var pointSaveList;
var baseRid="null";
var savePntArr = [];
//적립 항목 리스트
function getPointSaveList(){
    var jqGridOption = {
 		ondblClickRow : function(data){
		   var obj = pointSaveList.getRowData()[data-1];
		   rid = obj.rid;
           pointSaveDtl();    // 상세 보기 이벤트         	
 	    },
        onSelectRow : function (data) {
        	baseRid=data.rid;
        },
       serializeGridData : function( data ){
    	   
    	   data.rid=testViewList_rid;
    	   data.listType="SAVE";
    	   return data;
        },  
        loadComplete : function(obj){
        	savePntArr = obj.rows;
        }, 
        url : '<ifvm:action name="getPointItemBaseList"/>',
        colNames:[ 
                   '<spring:message code="L00901" />',  /*회원구분 */
                   '<spring:message code="L00902" />',  /*회원등급 */
                   '<spring:message code="L00903" />',  /*적립단위 */
                   '<spring:message code="L00904" />',  /*적립포인트 */
                   '<spring:message code="L00905" />',  /*적립한도 */
                   '<spring:message code="L00906" />',  /*사용여부 */
                   '<spring:message code="L00907" />',  /*적용시작일자 */
                   '<spring:message code="L00908" />',  /*적용종료일자 */
                
                   'rid',  /*rid */
                 ],
        colModel:[
             { name:'mbrDivCd',   index:'cc1.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'tierCd',   index:'cc2.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'acrlUnit',   index:'cc3.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'acrlPnt',   index:'lpbi.ACRL_PNT',  resizable : true, align:'right',    width:'120px', formatter:'integer'  },
             { name:'acrlPntLmt',   index:'lpbi.ACRL_PNT_LMT',  resizable : true, align:'right',    width:'120px', formatter:numberCommaForamtter },
             { name:'activeYn',   index:'lpbi.ACTIVE_YN',  resizable : true, align:'center',    width:'80px',   },
             { name:'aplyStartDd',   index:'lpbi.APLY_START_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
             { name:'aplyEndDd',   index:'lpbi.APLY_END_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },

             
             { name:'rid',   index:'lpbi.rid',  hidden:true },
        ],
        sortname: 'aplyStartDd',
        autowidth : true , sortorder: "desc",
        radio: true

    };
    pointSaveList = $("#pointSaveListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//null일때 숫자처리
function numberCommaForamtter(cellvalue, options, rowObjec){
    var pnt = rowObjec.acrlPntLmt;
	if(pnt!=null){
	    pnt = Math.round(pnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
	}else{
		pnt = '';
	}
	return pnt;
}

function newPointStandardFn(){
		if($("#typeCd").val()=="A" || $("#typeCd").val()=="G"){
			 pointSaveInfoPop ={
				        id : "pontSaveInfoPopDiv"
				    };
			 pointSaveInfoPop.popup = function (){
				 pointSaveInfoPop.pop = $('#'+pointSaveInfoPop.id).ifvsfPopup({
				            enableModal: true,
				            enableResize: false,
				            contentUrl: '<ifvm:url name="pointSaveInfoPop"/>',
				            contentType: "ajax",
				            title: '<spring:message code="L00897" />',
				            width: "800px"
				        });
				};
				pointSaveInfoPop.beforeClose = function (obj) {
				};
				pointSaveInfoPop.close = function (obj) {
				        this.beforeClose(obj);
				        this.pop.data('ejDialog')._destroy();
			};
				 pointSaveInfoPop.popup();
		}else{
			alert('<spring:message code="L01585"/>');
			return;
		}
}

function delTabSavePointFn(){
	if(baseRid=="null"){
		alert('<spring:message code="L00914"/>');
		return;
	}
/* 	if($("#statusCd").val()=="10"){
		alert('<spring:message code="L01674"/>');
		return;
	}
 */
	$.ifvSyncPostJSON('<ifvm:action name="deletePointItem"/>',{
		rid:baseRid
		},function(result) {
			alert('<spring:message code="L00034"/>');
			pointSaveList.requestData();
		},function(result){
			alert(result.message);
		});
}

function pointSaveDtl(){
	 pointSaveInfoPop ={
		        id : "pontSaveInfoPopDiv"
		    };
	 pointSaveInfoPop.popup = function (){
		 pointSaveInfoPop.pop = $('#'+pointSaveInfoPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointSaveInfoPop"/>'+"?baseRid="+baseRid,
		            contentType: "ajax",
		            title: '<spring:message code="L00897" />',
		            width: "800px"
		        });
		};
		pointSaveInfoPop.beforeClose = function (obj) {
		};
		pointSaveInfoPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 pointSaveInfoPop.popup();
}
function buttonStatus(){
	if(testViewList_rid =="null"){
		$("#saveBtnDiv button" ).attr("disabled",true);
	}
}


$(document).ready(function() {
	getPointSaveList();
	buttonStatus();

});

</script>
<div>   
<%--     <div class="page_btn_area" id=''>
       <div class="col-xs-7">
           <span> <spring:message code="L00897"/></span>
       </div>   
        <div class="col-xs-5 searchbtn_r" id="saveBtnDiv">
 			<ifvm:inputNew type="button" btnType="plus"  text="L00078"  id="newTabBtn" btnFunc="newPointStandardFn"/>
 			<ifvm:inputNew type="button" btnType="minus"  text="L00029"  id="delTabSavePointBtn" btnFunc="delTabSavePointFn"/>
        </div>     
    </div> --%>
    <div id="pointSaveListGrid" class="white_bg grid_bd0"></div>     
</div>
 <div id="pontSaveInfoPopDiv" class="popup_container"></div>
