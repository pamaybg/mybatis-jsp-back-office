<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//이미지, 파일 제한 그리드
function imageFileLimitGrid() {
	var ejGridOption = {
		serializeGridData: function (data) {
			data.mktChlId = selectRow;
			return data;
		},
		rowSelected : function (args) {
				selectChilRow = args.data.id;
		},
	    dataUrl:'<ifvm:action name="getImgOption"/>',
	    columns:[
	    	{
        		  field : 'seq', headerText : '<spring:message code="M00478"/>', 
        	  },{
        		  field : 'upldType', headerText : '<spring:message code="M00490"/>', 
        	  },{
        		  field : 'upldEtsionCd', headerText : '<spring:message code="M00491"/>', 
        	  },{
        		  field : 'maxVol', headerText : '<spring:message code="M00492"/>', 
        	  },{
        		  field : 'imgResolW', headerText : '<spring:message code="M00493"/>', 
        	  },{
        		  field : 'imgResolH', headerText : '<spring:message code="M00494"/>', 
        	  },{
        		  field : 'modifyBy', headerText : '<spring:message code="M00473"/>', 
        	  },{
        		  field : 'mDate', headerText : '<spring:message code="M00495"/>', 
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
//	       gridDataInit: false,
	      radio: true,
	      tempId: 'ifvGridOriginTemplete',
// 	      emptyRows: true
	};
	imageFileLimitGrid = $("#imageFileLimitGridDiv").ifvsfGrid({ ejGridOption : ejGridOption });

}

/**
 * 파일 제한 삭제
 */
function deleteImgOptionList() {
	var active = 0;
	var checkedList = imageFileLimitGrid.opt.gridControl.getSelectedRecords();
	var listFlowIdList = [];
	if (checkedList.length != 0) {
		for ( var i = 0; i < checkedList.length; i++ ) {
			listFlowIdList.push( checkedList[i].id );
		}
		if (confirm('<spring:message code="M01020"/>') == true) {
			$.ifvSyncPostJSON('<ifvm:action name="removeImgOption"/>',{
				listChannelFlowId : listFlowIdList
			}, function(result) {
				alert('<spring:message code="M00622"/>');
				//임시처리, syncfusion 답변완료 후 변경 필요
				imageFileLimitGrid.searchGrid();
			});
		}
	}
	else {
		alert('<spring:message code="M00285"/>');
	}
}

$(document).ready(function() {

	imageFileLimitGrid();

	//채널, 이미지 제한 신규
	$('#imageFileNewBtn').on('click', function() {
		if (!selectRow) {
			alert('<spring:message code="M00498"/>');
		}
		else {
			$("#channelPopCon").ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="MKTImageFileLimitPop"/>?id=' + selectRow,
				contentType : "ajax",
				title : '<spring:message code="M00497"/>',
				width : 340,
				close : 'channelPopupClose'
			});
		}
	});

	// 채널, 이미지 제한 수정
	$('#imageFileEditBtn').on('click', function() {
		if (imageFileLimitGrid.opt.gridControl.getSelectedRecords()[0].id != "") {
			if (selectRow == null) {
				alert('<spring:message code="M00498"/>');
			}
			else if (selectChilRow == null) {
				alert('<spring:message code="M00499"/>')
			}
			else {
				$("#channelPopCon").ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : '<ifvm:url name="MKTImageFileLimitPop"/>?id=' + selectRow + '&chilId=' + selectChilRow,
					contentType : "ajax",
					title : '<spring:message code="M00497"/>',
					width : 340,
					close : 'channelPopupClose'
				});
			}
		}
	});

	//파일 제한 삭제
	$("#imageFileDelBtn").on('click', function() {
		if (selectRow == null) {
			alert('<spring:message code="M00498"/>');
		}
		else if (selectChilRow == null) {
			alert('<spring:message code="M00499"/>')
		}
		else {
			deleteImgOptionList();
		}
	});

});

</script>

<!-- 이미지, 파일 제한 -->
<div id="imageFileLimitArea" class="">
	<div class="page_btn_area" id="">
		<div class="col-xs-7">
			<span><spring:message code="M00496"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="imageFileNewBtn" objCode="imageFileNewBtn_OBJ">
				<i class="fa fa-plus"></i>
				<spring:message code="M00274"/>
			</button>
			<button class="btn btn-sm" id="imageFileEditBtn" objCode="imageFileEditBtn_OBJ">
				<spring:message code="M00283"/>
			</button>
			<button class="btn btn-sm" id="imageFileDelBtn" objCode="imageFileDelBtn_OBJ">
				<i class="fa fa-minus"></i>
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	<div id="imageFileLimitGridDiv" class="grid_bd0"></div>
</div>