<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var pointAdjustList;
var baseRid="null";
var adjustArr = [];
//적립 항목 리스트
function getPointAdjustList(){
    var jqGridOption = {
     	ondblClickRow : function(data){
     		var obj = pointAdjustList.getRowData()[data-1];
     		rid = obj.rid;
            pointAdjustDtl();    // 상세 보기 이벤트         	
      	},
        onSelectRow : function (data) {
        	baseRid= data.rid;
        	baseObj = data;
        },
       serializeGridData : function( data ){
    	   
    	   data.rid=testViewList_rid;
    	   data.listType="ADJUST";
    	   return data;
        },
        loadComplete : function(obj){
        	adjustArr =obj.rows
        }, 
        url : '<ifvm:action name="getPointItemBaseList"/>',
        colNames:[ 
                   '<spring:message code="L00837" />',  /*회원구분 */
                   '<spring:message code="L00745" />',  /*정산구분 */
                   '<spring:message code="L00916" />',  /*정산방법 */
                   '<spring:message code="L00747" />',  /*E1본사비율(%) */
                   '<spring:message code="L00748" />',  /*가맹점비율(%) */
                   '<spring:message code="L00749" />',  /*최소보장금액 */
                   '<spring:message code="L00906" />',  /*사용여부 */
                   '<spring:message code="L00907" />',  /*적용시작일자 */
                   '<spring:message code="L00908" />',  /*적용종료일자 */
                   'rid',  /*rid */
                 ],
        colModel:[
             { name:'mbrDivCd',   index:'cc1.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'adjustDivCd',   index:'cc2.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'adjustMethCd',   index:'cc3.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'e1ShrexpnsRate',   index:'lpbi.SHREXPNS_RATE',  resizable : true, align:'right',    width:'100px', formatter:'integer'  },
             { name:'partnerShrexpnsRate',   index:'lpbi.PARTNER_SHREXPNS_RATE',  resizable : true, align:'right',    width:'100px', formatter:'integer'  },
             { name:'grntMinAmt',   index:'lpbi.GRNT_MIN_AMT',  resizable : true, align:'right',    width:'100px',  formatter:'integer'  },
             { name:'activeYn',   index:'lpbi.ACTIVE_YN',  resizable : true, align:'center',    width:'80px',   },
             { name:'aplyStartDd',   index:'lpbi.APLY_START_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
             { name:'aplyEndDd',   index:'lpbi.APLY_END_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
             
             { name:'rid',   index:'lpbi.rid',  hidden:true },
        ],
        sortname: 'aplyStartDd',
        autowidth : true , sortorder: "desc",
        radio: true

    };
    pointAdjustList = $("#pointAdjustListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function pointAdjustDtl(){
	 pointAdjustInfoPop ={
		        id : "pontAdjustInfoPopDiv"
		    };
		 pointAdjustInfoPop.popup = function (){
	
		 pointAdjustInfoPop.pop = $('#'+pointAdjustInfoPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointAdjustInfoPop"/>'+"?adjustRid="+baseRid,
		            contentType: "ajax",
		            title: '<spring:message code="L00899" />',
		            width: "1000px"
		        });
		};
		pointAdjustInfoPop.beforeClose = function (obj) {
		};
		pointAdjustInfoPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 pointAdjustInfoPop.popup();
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

function newPointStandardFn(){
/* 	if(testViewList_rid =="null"){
		alert('<spring:message code="L01586"/>');
		return;
	}
	if($("#statusCd").val() !="10"){
		  alert('<spring:message code="L01589" />');
		  return;
	} */
	if($("#typeCd").val()!="B"){
		alert('<spring:message code="L01592" />');
		return;
	}
	 pointAdjustInfoPop ={
		        id : "pontAdjustInfoPopDiv"
		    };
	 pointAdjustInfoPop.popup = function (){
		 pointAdjustInfoPop.pop = $('#'+pointAdjustInfoPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointAdjustInfoPop"/>',
		            contentType: "ajax",
		            title: '<spring:message code="L00899" />',
		            width: "1000px"
		        });
		};
		pointAdjustInfoPop.beforeClose = function (obj) {
		};
		pointAdjustInfoPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		};
		pointAdjustInfoPop.popup();
}

function delTabAdjustPointFn(){
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
			pointAdjustList.requestData();		
		},function(result){
			alert(result.message);
		});
}

function buttonStatus(){
	if(testViewList_rid =="null"){
		$("#adjustmentBtnDiv button" ).attr("disabled",true);
	}
}
$(document).ready(function() {
	getPointAdjustList();
	buttonStatus();
});

</script>

<div>   
<%--     <div class="page_btn_area" id=''>
       <div class="col-xs-7">
           <span> <spring:message code="L00899"/></span>
       </div>   
        <div class="col-xs-5 searchbtn_r" id="adjustmentBtnDiv">
 			<ifvm:inputNew type="button" btnType="plus"  text="L00078"  id="newTabBtn" btnFunc="newPointStandardFn"/>
 			<ifvm:inputNew type="button" btnType="minus"  text="L00029"  id="delTabAdjustPointBtn" btnFunc="delTabAdjustPointFn"/>
        </div>     
    </div> --%>
    <div id="pointAdjustListGrid" class="white_bg grid_bd0"></div>     
</div>
 <div id="pontAdjustInfoPopDiv" class="popup_container content_container"></div>
