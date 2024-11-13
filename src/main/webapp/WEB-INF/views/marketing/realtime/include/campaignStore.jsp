<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var campaignStoreGrid;//intactTypePopGrid
//var gridIdintactTypePopGrid;
var deleteRid;

//이벤트 유형 목록 그리드 설정
function getStoreMappingList(){
	var ejGridOption = {
			loadComplete : function(obj){
				//그리드 조회할 때 load되는 곳
				
	 		},
	 		rowSelected : function (data) {
				deleteRid=data.data.id;
			},
			serializeGridData : function( data ){
				data.camId =  campaign.id;
				return data;
			},
			dataUrl : '<ifvm:action name="getStoreMappingList"/>',
	      	columns: [
	      		{
	      		  field : 'storeNm', headerText : '이벤트 발생점', headerTextAlign : 'center', textAlign : 'center' , width : '100px', resizable : false,
	      		  customAttributes : {
	      			  index : 'evtchnl1.chnl_nm'
	      		  }
	      	  },{
	      		  field : 'sndStoreNm', headerText : '메시지 전송점', headerTextAlign : 'center', textAlign : 'center' , width : '100px', resizable : false,
	      		  customAttributes : {
	      			  index : 'lc3.chnl_nm'
	      		  }
	      	  },{
	      		  field : 'sndChnlId', headerText : 'sndChnlId', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'mcs.snd_chnl_id'
	      		  }
	      	  },{
	      		  field : 'id', headerText : 'id', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'mcs.id'
	      		  }
	      	  },{
	      		  field : 'evtStoreId', headerText : 'evtStoreId', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'evtchnl1.rid'
	      		  }
	      	  },{
	      		  field : 'evtBrandId', headerText : 'evtBrandId', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'evtchnl2.rid'
	      		  }
	      	  },{
	      		  field : 'evtSubsidryId', headerText : 'evtSubsidryId', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'evtchnl3.rid'
	      		  }
	      	  },{
	      		  field : 'sndStoreId', headerText : 'sndStoreId', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'sndchnl1.rid'
	      		  }
	      	  },{
	      		  field : 'sndBrandId', headerText : 'sndBrandId', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'sndchnl2.rid'
	      		  }
	      	  },{
	      		  field : 'sndSubsidryId', headerText : 'sndSubsidryId', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'sndchnl3.rid'
	      		  }
	      	  },{
	      		  field : 'camId', headerText : 'camId', resizable : false, visible: false,  searchable : false,
	      		  customAttributes : {
	      			  index : 'mcs.cam_id'
	      		  }
	      	  }
	      	  
	      	  
	      ],requestGridData : {
	    	  		nd   : new Date().getTime(),
	        	  	rows 	: 10,
	        	  	sidx	: 'mcs.id',
	        	  	sord 	: 'desc',
	        	  	_search : false,
	          	},
	          	rowList : [10,25,50,100],
	          	//gridDataInit: false,
	          	radio: true,
	          	tempId : 'ifvGridSimplePageTemplete2'
	     	};
	campaignStoreGrid = $("#campaignStoreGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	//gridIdintactTypePopGrid = $("#gridIdintactTypePopGrid");
}

//숫자 콤마표시
function numberFormat2(cellvalue, options, rowObjec) {
	var value = "";
	if (isNotEmpty(cellvalue)) {
		value = $.ifvNumberFormat(cellvalue);
	}

	return value;
}

 function addStorePopupOpen(){
	 var itCondition = [];
	    var obj = null;

	    gStoreTree ={
	        id : "addStorePopup",
	        fillter : obj
	    };
	    gStoreTree.pop = $('#'+gStoreTree.id).ifvsfPopup({
	        enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="campaignStoreAddPop"/>',
	        contentType: "ajax",
	        title: '지점 스토어 조회',
	        width: 700,
	        close : 'addStorePopupClose'
	    });
}
 
 function editStorePopupOpen(){
	 if($.fn.ifvmIsNotEmpty(deleteRid)) {
		 $("#editStorePopup").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="campaignStoreEditPop"/>',
		        contentType: "ajax",
		        title: '캠페인 지점 매핑',
		        width: '700px',
		        close : 'editStorePopupClose'
		    });
	 }else{
		 alert('<spring:message code="L01393" />')
	 }
	 
 }

 //선택버튼 누를 시 함수
 function commStoreTreeSelect(){
	 var array = $('#storeTree').jstree('get_selected')
     ,obj = [];
 
  	if(array.length==0){
  		alert("등록할 지점을 선택하여 주세요!");
  		return;
  	}
  	
	for ( var i=0 ; i < array.length ; i++){
     	 var node = $('#storeTree').jstree(true).get_node(array[i]);
     	 var storeTypeCd = node.original.storeTypeCd;
     	 
     	 if (storeTypeCd === 'S1') {
          	node.storeId = node.id;  
     		obj.push({
     			storeNm: node.original.name,
     			rid:node.original.id
     		});
     	 }
	}
	
	if (obj.length > 0) {
		$.ifvSyncPostJSON('<ifvm:action name="saveCampaignStore"/>', {
			camId: campaign.id,
			storeList: obj
		} ,function(result) {
					alert('<spring:message code="M00623"/>');
					getStoreMappingList();
					addStorePopupClose();
				});
	}
}

//수정팝업 저장버튼 클릭시
function editCampaignStore(){
 	 $.ifvSyncPostJSON('<ifvm:action name="editCampaignStore"/>', {
 		rid: deleteRid,
 		storeId : $("#storeCd").val(),
 		sndChnlId : $("#sndStoreCd").val(),
 		storeNm : $("#storeCd option:checked").text(),
 		sndStoreNm : $("#sndStoreCd option:checked").text()
 	},function(result) {
 		alert('<spring:message code="M00106"/>');
 		getStoreMappingList();
 		editStorePopupClose();
 	});   
 }
 
function removeStore(){
	if($.fn.ifvmIsNotEmpty(deleteRid)) {
        
   		if(!confirm('<spring:message code="C00079" />')) return;
         
   $.ifvSyncPostJSON('<ifvm:action name="removeCampaignStore"/>', {
	  
     	 rid: deleteRid
   }, function(result) {
     	 alert('<spring:message code="M01266" />');
     	getStoreMappingList();
   });
   } else {
      	alert('<spring:message code="L01393" />')
   }
}

function addStorePopupClose() {
	addStorePopup._destroy();
}

function editStorePopupClose(){
	editStorePopup._destroy();
}

/**
 * 엑셀업로드
 */
function chnlMappingFileUpload() {
	
	//업로드 전 초기세팅값만 존재 시 그리드 clear
/* 	if(ruleSetData.rulesetCondChnlList.length === 1 && ruleSetData.rulesetCondChnlList[0].chnlNo === 'ALL') {
		condChnlListGrid.removeAll();
		ruleSetData.rulesetCondChnlList = [];
	} */
	
	var validationCheck = false;

	// 파일 확장자 check
	if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'csv') {
		validationCheck = true;
	}
	if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xlsx'
			|| $("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xls') {
		validationCheck = true;
	}
	if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'txt') {
		validationCheck = true;
	}

	if (validationCheck) {
		$.ifvProgressControl(true);

//		if (($("#hideFile")[0].files[0].type.split('/')[1] == 'vnd.ms-excel')
//				|| $("#hideFile")[0].files[0].type.split('/')[1] == 'vnd.openxmlformats-officedocument.spreadsheetml.sheet') {

			var formData = new FormData();
			formData.append("file", $("#hideFile")[0].files[0]); //파일업로드
			formData.append("camId", campaign.id); //캠페인 아이디

			$.ajax({
				url : '<ifvm:action name="saveCampaignStoreByExcel"/>',
				data : formData,
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					//업로드 실패
					if (!data.success) {
						if ($.fn.ifvmIsEmpty(data.message)) {
							$.errorChecker(data);
							$.ifvProgressControl(false);
						} else {
							alert(data.message);
							$.ifvProgressControl(false);
						}
					} 
					//업로드 성공
					else {
						alert(data.message);
/* 						if(!$.fn.ifvmIsEmpty(data.channelList)) {
							$.merge(ruleSetData.rulesetCondChnlList, data.channelList)
							setCondChnlListGridGrid();
						} */
						$.ifvProgressControl(false);
						getStoreMappingList();
					}
				}
			});
//		} else {
//			alert("<spring:message code='M00703'/>");
//			$("#hideFile").removeAttr("value");
//		}
		//초기화
		$("#hideFile").val("");
	} else {
		alert("<spring:message code='M00703'/>");
		$("#hideFile").removeAttr("value");
	}
}

$(document).ready(function() {
	getStoreMappingList();
	
	//신규버튼
    $('#addStoreBtn').on('click', function(){
    	if(campaign.id == ""){
    		alert('<spring:message code="M00761" />')
    	}else{
    		addStorePopupOpen();    		
    	}
    });
	
	//수정버튼
    $('#editStoreBtn').on('click', function(){
    	if(campaign.id == ""){
    		alert('<spring:message code="M00761" />')
    	}else{
    		editStorePopupOpen();    		
    	}
    });
    
  	//삭제버튼
    $('#removeStoreBtn').on('click', function(){
    	if(campaign.id == ""){
    		alert('<spring:message code="M00761" />')
    	}else{
    		removeStore();    		
    	}
    });

    //엑셀업로드
    $("#addStoreByFileBtn").on('click', function() {
		alert('[파일 작성 안내]\n txt파일(탭으로 분리)만 가능.\n 순서 : 이벤트발생계열사 이벤트발생지점코드 메시지전송계열사 메시지전송지점코드).\n ex) EG02 AL253 EG01 7214');
		$("#hideFile").trigger("click");
	});

	//엑셀업로드 파일 선택 시
	$("#hideFile").on("change", function() {
		chnlMappingFileUpload();
	});
}); 
</script>

<style>
#hideFile {
	display: none
}
</style>

<div id="intactTypePopCon">
	<div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="addStoreByFileBtn">파일업로드</button>
            <ifvm:input type="file" id="hideFile" />
            <button class="btn btn-sm" id="addStoreBtn">신규</button>
            <button class="btn btn-sm" id="editStoreBtn">수정</button>
            <button class="btn btn-sm" id="removeStoreBtn">삭제</button>
        </div>
    </div>
	<div class="pop_inner_wrap">
		<div id="campaignStoreGrid" class=""></div>
	</div>
	
</div> 

<div id="addStorePopup" class="popup_container"></div>
<div id="editStorePopup" class="popup_container"></div>
