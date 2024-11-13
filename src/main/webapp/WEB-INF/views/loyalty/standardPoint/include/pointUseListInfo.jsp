<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var pointUseList;
var baseRid="null";
//적립 항목 리스트
function getPointUseList(){
    var jqGridOption = {
    	ondblClickRow : function(data){
  			var obj = pointUseList.getRowData()[data-1];
  			rid = obj.rid;
  	        pointUseDtl();    // 상세 보기 이벤트         	
    	},
        onSelectRow : function (data) {
        	baseRid=data.rid;
        },
       serializeGridData : function( data ){
    	   
    	   data.rid=testViewList_rid;
    	   data.listType="USE";
    	   return data;
        },  
        loadComplete : function(obj){
        }, 
        url : '<ifvm:action name="getPointItemBaseList"/>',
        colNames:[ 
                   '<spring:message code="L00915" />',  /*최소사양포인트 */
                   '<spring:message code="L00906" />',  /*사용여부 */
                   '<spring:message code="L00907" />',  /*적용시작일자 */
                   '<spring:message code="L00908" />',  /*적용종료일자 */
                
                   'rid',  /*rid */
                 ],
        colModel:[
             { name:'grntMinAmt',   index:'lpbi.GRNT_MIN_AMT',  resizable : true, align:'right',    width:'80',formatter :'integer' },
             { name:'activeYn',   index:'lpbi.ACTIVE_YN',  resizable : true, align:'center',    width:'100px' },
             { name:'aplyStartDd',   index:'lpbi.APLY_START_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
             { name:'aplyEndDd',   index:'lpbi.APLY_END_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },

             
             { name:'rid',   index:'lpbi.rid',  hidden:true },
        ],
        sortname: 'aplyStartDd',
        autowidth : true , sortorder: "desc",
        radio: true

    };
    
    pointUseList = $("#pointUseListGrid").ifvGrid({ jqGridOption : jqGridOption });
}
function pointUseDtl(){
	pointUseInfoPop ={
	        id : "pontUseInfoPopDiv"
	    };
 pointUseInfoPop.popup = function (){
	 pointUseInfoPop.pop = $('#'+pointUseInfoPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="pointUseInfoPop"/>'+"?pntUseRid="+baseRid,
	            contentType: "ajax",
	            title:'<spring:message code="L00898" />',
	            width: "800px"
	        });
	};
	pointUseInfoPop.beforeClose = function (obj) {
	}; 
	pointUseInfoPop.close = function (obj) {
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 pointUseInfoPop.popup();
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플 
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}


function newUsePointFn(){
	pointUseInfoPop ={
		        id : "pontUseInfoPopDiv"
		    };
	 pointUseInfoPop.popup = function (){
		 pointUseInfoPop.pop = $('#'+pointUseInfoPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointUseInfoPop"/>',
		            contentType: "ajax",
		            title:'<spring:message code="L00898" />',
		            width: "800px"
		        });
		};
		pointUseInfoPop.beforeClose = function (obj) {
		}; 
		pointUseInfoPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 pointUseInfoPop.popup();
}

function delUsePointFn(){
	if(baseRid=="null"){
		alert('<spring:message code="L00914"/>');
		return;
	}
/* 	if($("#statusCd").val()=="10"){
		alert('<spring:message code="L01674"/>');
		return;
	} */
	$.ifvSyncPostJSON('<ifvm:action name="deletePointItem"/>',{  
		rid:baseRid
		},function(result) {
			alert('<spring:message code="L00034"/>');
			pointUseList.requestData();		
		},function(result){
			alert(result.message);
		});

}

function buttonStatus(){
	if(testViewList_rid =="null"){
		$("#useBtnDiv button" ).attr("disabled",true);
	}
}

$(document).ready(function() {
	getPointUseList();
	buttonStatus();

});

</script>

<div>   
<%--     <div class="page_btn_area" id=''>
       <div class="col-xs-7">
           <span> <spring:message code="L00898"/></span>
       </div>   
        <div class="col-xs-5 searchbtn_r" id="useBtnDiv">
 			<ifvm:inputNew type="button" btnType="plus"  text="L00078"  id="newUsePointBtn" btnFunc="newUsePointFn"/>
 			<ifvm:inputNew type="button" btnType="minus"  text="L00029"  id="delUsePointBtn" btnFunc="delUsePointFn"/>
        </div>     
    </div> --%>
    <div id="pointUseListGrid" class="white_bg grid_bd0"></div>     
</div>
 <div id="pontUseInfoPopDiv" class="popup_container content_container"></div>
