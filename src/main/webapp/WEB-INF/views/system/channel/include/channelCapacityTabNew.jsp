<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var channelCapacityGrid;

//채널별 용량 그리드
function initChannelCapacityGrid() {
	var ejGridOption = {
		serializeGridData: function (data) {
			data.mktChlId = selectRow;
			return data;
		},
		rowSelected: function (args) {
			selectChilRow = args.data.id;
		},
		dataUrl:'<ifvm:action name="getChannelStore"/>',
	    columns:[
	    	  {
        		  field : 'seq', headerText : '<spring:message code="M00478"/>', headerTextAlign : 'center',
        	  },{
        		  field : 'periodType', headerText : '<spring:message code="M00475"/>', headerTextAlign : 'center',
        	  },{
        		  field : 'maxVol', headerText : '<spring:message code="M00476"/>', headerTextAlign : 'center',
        	  },{
        		  field : 'reserveVol', headerText : '<spring:message code="M00477"/>', headerTextAlign : 'center',
        	  },{
        		  field : 'description', headerText : '<spring:message code="M00472"/>', headerTextAlign : 'center',
        	  },{
        		  field : 'modifyBy', headerText : '<spring:message code="M00473"/>', headerTextAlign : 'center',
        	  },{
        		  field : 'modifyDate', headerText : '<spring:message code="M00474"/>', headerTextAlign : 'center',
        	  },{
        		  field : 'id', headerText : 'id', visible : false , 
        	  } 
	    ],
	    requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'seq',
      	  sord : 'asc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
	    tempId : 'ifvGridOriginTemplete',
	};
	channelCapacityGrid = $("#channelCapacityGridDiv").ifvsfGrid({ ejGridOption : ejGridOption });

}

/**
 * 채널용량 삭제
 */
function deleteCapaList() {
	var active = 0;
	var checkedList = channelCapacityGrid.opt.gridControl.getSelectedRecords();
	var listFlowIdList = [];

	if(checkedList.length != 0){
		for( var i = 0; i < checkedList.length; i++ ){
			listFlowIdList.push( checkedList[i].id );
		}
		$.ifvSyncPostJSON('<ifvm:action name="removeCapa"/>',{
			listChannelFlowId : listFlowIdList
		},function(result) {
			alert('<spring:message code="M00012"/>');
			channelCapacityGrid.searchGrid();
		});
	}
	else {
		alert('<spring:message code="M00285"/>');
	}
}

$(document).ready(function() {

	initChannelCapacityGrid();

	//채널별 용량 신규
	$('#capacityPerChannelBtn').on('click', function() {
		if (pageCheck) {
			$("#channelPopCon").ifvsfPopup({
				enableModal: true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="MKTCapacityPerChannelPop"/>?id=' + selectRow,
		        contentType: "ajax",
		        title: '<spring:message code="M00487"/>',
		        width: 340,
		        open: 'dialogHeightSetting',
		        close: 'channelPopupClose'
		    });
		}
		else {
			alert('<spring:message code="M00498"/>');
		}
	});

	//채널별 용량 수정
	$('#capacityModifyBtn').on('click', function() {
		if (channelCapacityGrid.opt.gridControl.getSelectedRecords()[0].id != "") {
			if (!selectRow) {
				alert('<spring:message code="M00498"/>');
			}
			else if (selectChilRow == null) {
				alert('<spring:message code="M00499"/>')
			}
			else {
				$("#channelPopCon").ifvsfPopup({
					enableModal: true,
			        enableResize: false,
			        contentUrl: '<ifvm:url name="MKTCapacityPerChannelPop"/>?id=' + selectRow + '&chilId=' +  selectChilRow,
			        contentType: "ajax",
			        title: '<spring:message code="M00487"/>',
			        width: 400,
			        open: 'dialogHeightSetting',
			        close: 'channelPopupClose'
			    });
			}
		}
	});

	//용량 삭제
	$("#capacityDelBtn").on('click', function() {
		if (selectRow == null) {
			alert('<spring:message code="M00498"/>');
		}
		else if (selectChilRow == null) {
			alert('<spring:message code="M00499"/>')
		}
		else {
			deleteCapaList();
		}
	});

});

</script>

<!-- 채널별 용량 -->
<div id="channelCapacityArea" >
	<div class="page_btn_area" id="channelCapacity">
		<div class="col-xs-7">
			<span><spring:message code="M00461"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="capacityPerChannelBtn" objCode="capacityPerChannelBtn_OBJ">
				<i class="fa fa-plus"></i>
				<spring:message code="M00274"/>
			</button>
			<button class="btn btn-sm" id="capacityModifyBtn" objCode="capacityModifyBtn_OBJ">
				<spring:message code="M00283"/>
			</button>
			<button class="btn btn-sm" id="capacityDelBtn" objCode="capacityDelBtn_OBJ">
				<i class="fa fa-minus"></i>
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	<div id="channelCapacityGridDiv" class="grid_bd0"></div>
</div>