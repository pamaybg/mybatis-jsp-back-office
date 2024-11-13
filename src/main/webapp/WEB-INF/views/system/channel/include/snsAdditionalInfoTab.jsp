<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//소셜부가정보 그리드
function snsAdditionalInfoGrid() {

	var ejGridOption = {
		serializeGridData: function (data) {
			data.mktChlId = selectRow;
			return data;
		},
		rowSelected : function (args) {
			selectChilRow = args.data.id;
		},
		dataUrl:'<ifvm:action name="getSnsAdtnInfoList"/>',
	    columns:[
	    	  {
	      		  field : 'snsPageId', headerText : '<spring:message code="M02135"/>', headerTextAlign : 'center',
	      	  },{
	      		  field : 'appId', headerText : '<spring:message code="M02136"/>', headerTextAlign : 'center',
	      	  },{
	      		  field : 'snsPageDesc', headerText : '<spring:message code="M02138"/>', headerTextAlign : 'center',
	      	  },{
	      		  field : 'acesExpDt', headerText : '<spring:message code="M02185"/>', headerTextAlign : 'center',
	      	  },{
	      		  field : 'cardNo', headerText : 'id', visible : false ,
	      	  }
	    ],
	    requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'snsPageId',
	      	  sord : 'asc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true,
	    	tempId : 'ifvGridOriginTemplete'
	};
	snsAdditionalInfoGrid = $("#snsAdditionalInfoGrid").ifvsfGrid({ ejGridOption : ejGridOption });

}

/**
 * 소셜부가정보 삭제
 */
function deleteAdditionalInfoDelBtnList( ) {
	var active = 0;
	var checkedList = snsAdditionalInfoGrid.opt.gridControl.getSelectedRecords();
	var listFlowIdList = [];
	if (checkedList.length != 0) {
		for (var i = 0; i < checkedList.length; i++) {
			listFlowIdList.push( checkedList[i].id );
		}
		if (confirm('<spring:message code="M01020"/>') == true) {
			$.ifvSyncPostJSON('<ifvm:action name="deleteSnsAdtnInfo"/>',{
				listChannelFlowId : listFlowIdList
			},function(result) {
				alert('<spring:message code="M00622"/>');
				snsAdditionalInfoGrid.searchGrid();
			});
		}
	}
	else {
		alert('<spring:message code="M00285"/>');
	}
}

$(document).ready(function() {

	snsAdditionalInfoGrid();

	$('#additionalInfoNewBtn').on('click', function() {
		if (pageCheck) {
			$("#snsAdtnInfoPopCon").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="snsAdtnInfoPop"/>?id='+ selectRow,
		        contentType: "ajax",
		        title: '<spring:message code="M02139"/>',
		        width: 400,
		        open : 'dialogHeightSetting',
		        close : 'snsAdtnInfoPopupClose'
		    });
		}
		else{
			alert('<spring:message code="M00498"/>');
		}
	});

	$('#additionalInfoModifyBtn').on('click', function(){
			if(selectRow == null){
				alert('<spring:message code="M00498"/>');
			}
			else if(!selectChilRow){
				alert('<spring:message code="M00499"/>')
			}
			else{
				$("#snsAdtnInfoPopCon").ifvsfPopup({
					enableModal : true,
			        enableResize: false,
			        contentUrl: '<ifvm:url name="snsAdtnInfoPop"/>?id='+ selectRow + '&chilId=' +  selectChilRow,
			        contentType: "ajax",
			        title: '<spring:message code="M00487"/>',
			        width: 400,
			        open : 'dialogHeightSetting',
			        close : 'snsAdtnInfoPopupClose'
			    });
			}
	});

	$("#additionalInfoDelBtn").on('click', function() {
		if (selectRow == null) {
			alert('<spring:message code="M00498"/>');
		}
		else if (selectChilRow == null) {
			alert('<spring:message code="M00499"/>')
		}
		else {
			deleteAdditionalInfoDelBtnList();
		}
	});
});

</script>

<!-- 소셜부가정보 -->
<div id="snsAdditionalInfoArea" >
	<div class="page_btn_area" id="snsAdditionalInfo">
		<div class="col-xs-7">
			<span><spring:message code="M02134"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="additionalInfoNewBtn" objCode="additionalInfoNewBtn_OBJ">
				<i class="fa fa-plus"></i>
				<spring:message code="M00274"/>
			</button>
			<button class="btn btn-sm" id="additionalInfoModifyBtn" objCode="additionalInfoModifyBtn_OBJ">
				<spring:message code="M00283"/>
			</button>
			<button class="btn btn-sm" id="additionalInfoDelBtn" objCode="additionalInfoDelBtn_OBJ">
				<i class="fa fa-minus"></i>
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	<div id="snsAdditionalInfoGrid" class="grid_bd0"></div>
</div>