<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">


var changeTaxiList;
gChangeTaxiList = {
	checkedData : null,
	init : function(){
		this.searchInit();
		this.search();

	},
	searchInit : function(){
		$.fn.ifvmSetCommonCondList("changeTaxiListSearchList","PGM_L_049");
		//승인상태 - 작성중 디폴트 조회
		$("#changeTaxiListSearchList #searchType option:selected[joinsrcclm='APV_STATUS']").parents('.SearchCondition').children('.changeTypeAreaCode').find('select').val('10');
	},
	search : function(){
		$.fn.ifvmSubmitSearchCondition("changeTaxiListSearchList", function(){
			changeTaxiList = $("#changeSeatchListGrid").ifvGrid({ jqGridOption : gChangeTaxiList.jqGridOption })
		});
	},
	jqGridOption : {
        ondblClickRow : function(data){
	      var data = changeTaxiList.getRowData()[data-1];
	      gChangeTaxiList.checkedData = data;
	      gChangeTaxiList.addChangeTaxi.pop(data);
        },
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getChangeTaxiList"/>',
        colNames:[
                   '<spring:message code="L01766" />',
                   '<spring:message code="L01767" />',
                   '<spring:message code="L01768" />',
                   '<spring:message code="L01769" />',
                   '<spring:message code="L01770" />',
                   '<spring:message code="L01771" />',
                   '<spring:message code="L01772" />',
                   '<spring:message code="L01773" />',
                   'memDiv',
                   'ridApv',
                   'apvStatusCd',
                   'rid',
                   'ridMbr'
                 ],
        colModel:[
             { name:'createDate',   index:'ltc.create_date',  	resizable : true, align:'center',    width:'100px' ,  formatter:'date', formatoptions:{newformat:"Y-m-d"}},
             { name:'mbrNo',   		index:'ltc.mbr_no',  		resizable : true, align:'center',    width:'100px', formatter: goGridRowMbrLink },
             { name:'custNm',   	index:'lc.cust_nm',  		resizable : true, align:'center',    width:'100px' },
             { name:'memDivCd',   	index:'cc1.mark_name',  	resizable : true, align:'center',    width:'100px' },
             { name:'apvStatus',   	index:'cc2.mark_name',  	resizable : true, align:'center',    width:'100px' },
             { name:'createBy',   	index:'em2.name',  			resizable : true, align:'center',    width:'100px' },
             { name:'apvNm',   		index:'em1.name ',  		resizable : true, align:'center',    width:'100px' },
             { name:'rmark',   		index:'ltc.rmark',  		resizable : true, align:'center',    width:'100px' },
             { name:'memDiv',    	index:'ltc.mem_div',    	hidden : true},
             { name:'ridApv',    	index:'ltc.rid_apv',    	hidden : true},
             { name:'apvStatusCd',  index:'ltc.apvStatusCd',   	hidden : true},
             { name:'rid',    		index:'ltc.rid',    		hidden : true},
             { name:'ridMbr',    	index:'lm.rid',    			hidden : true},

        ],
        sortname: 'ltc.create_date',
        autowidth : true ,
        sortorder: "desc",
        multiselect : true,


    },
    addChangeTaxi : {
    	id:"changeTaxiPop",
    	pop : function(obj){
    		var contentUrl = '<ifvm:url name="addchangeTaxiPop"/>'
    		if(obj == null){
    			gChangeTaxiList.checkedData = null;
			}else{
				contentUrl += '?rid='+obj.rid;
			}
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : contentUrl,
	            contentType : "ajax",
	            title : '<spring:message code="L00821"/>', // 개인택시 전환
	            width : '1000px'
	        });
		},
		beforeClose : function(obj){
			changeTaxiList.requestData();
		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}

    },
     requestApprov : function (){
		var checkedList =changeTaxiList.getCheckedList();
		if(checkedList.length != 1){
			alert('<spring:message code="L01393"/>');
			return;
		}else if(checkedList[0].apvStatusCd != 10){
			alert('<spring:message code="L01789"/>');
			return;
		}else{
			var dataObj = {
					empId : $.ifvmGetUserInfo().empId
					, taxiList : checkedList
			}

			var action = '<ifvm:action name="requestApprovTaxi"/>';
			$.ifvSyncPostJSON(action, dataObj, function(result) {

				if(result.success){
					alert('<spring:message code="L01818"/>');
					changeTaxiList.requestData();
				}
			}, function(result){
				alert(result.message)
			})
		}
	},
	unReqApprov : function(){
		var checkedList =changeTaxiList.getCheckedList();
		if(checkedList.length < 1){
			alert('<spring:message code="L01393"/>');
			return;
		}else{
			for(var i = 0 ; i < checkedList.length ; i++){
				if(checkedList[i].apvStatusCd != 10){
					alert('<spring:message code="L01790"/>');
					return;
				}
			}	
			var dataObj = {
					empId : $.ifvmGetUserInfo().empId
					, taxiList : checkedList
			}
			var action = '<ifvm:action name="unReqApprovTaxi"/>';
			$.ifvSyncPostJSON(action, dataObj, function(result) {

				if(result.success){
					alert('<spring:message code="L01260"/>');
					changeTaxiList.requestData();
				}
			})
		}
	},
	approvTaxi : function(){
		var checkedList =changeTaxiList.getCheckedList();
		if(checkedList.length == 0){
			alert('<spring:message code="L01393"/>');
			return;
		}else{
			for(var i = 0 ; i < checkedList.length ; i++){
				if(checkedList[i].apvStatusCd != 10){
					alert('<spring:message code="L01789"/>');
					return;
				}
			}
			var dataObj = {
					empId  : $.ifvmGetUserInfo().empId
					, taxiList : checkedList
			}

			var action = '<ifvm:action name="approvTaxi"/>';
			$.ifvSyncPostJSON(action, dataObj, function(result) {

				if(result.success){
					alert('<spring:message code="L01818"/>');
					changeTaxiList.requestData();
				}
			}, function(result){
				alert(result.message)
			})
		 }
	}
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}

$(document).ready(function(){
    gChangeTaxiList.init();
});
</script>


<div class="page-title">
    <h1>
	    <spring:message code="L01763" />
	 	&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnFunc="gChangeTaxiList.search" btnType="search" text="L00081" />
            <ifvm:inputNew type="button" btnFunc="gChangeTaxiList.searchInit" text="L00082" />
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="changeTaxiListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L00033" /><spring:message code="L01258" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnFunc="gChangeTaxiList.addChangeTaxi.pop" btnType="plus" text="L01531" />
            <ifvm:inputNew type="button" btnFunc="gChangeTaxiList.approvTaxi" text="L01764" objCode="LOY_APV_001"/>
            <%-- <ifvm:inputNew type="button" btnFunc="gChangeTaxiList.approvTaxi" text="L01764" /> --%>
            <ifvm:inputNew type="button" btnFunc="gChangeTaxiList.unReqApprov" text="L01765" />
        </div>
    </div>
    <div id="changeSeatchListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="changeTaxiPop" class="popup_container"></div>
