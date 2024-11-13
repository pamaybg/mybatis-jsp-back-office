<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
/* 일시적으로 숨김 처리 함 */
.temporarilyHide { display: none; }
</style>

<script>

//model
var campaignDefaultInfo;
//dialog
var planPop;
//validation
var campaignInfoPopValidation;

var campaignId;

var ridIntactType;
//탭 설정

var campaignStoreGrid;//intactTypePopGrid
//var gridIdintactTypePopGrid;
var deleteRid;

function storeList() {
	$("#intactTypePopCon").attr("hidden",false);
	getStoreMappingList();
}

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
	      		  field : 'sndStoreNm', headerText : '제공 및 안내점', headerTextAlign : 'center', textAlign : 'center' , width : '100px', resizable : false,
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


//model 정의
function initModels(data) {
    var infoModel = function(data) {

        //data set
        
        this.camDefaultInfo = data;
        //캠페인아이디
        this.camDefaultInfo.id = campaign.id;
        //기획자명
        this.camDefaultInfo.campaignPlannerName = data.campaignPlannerName != null ? data.campaignPlannerName : $.ifvmGetUserInfo().empName ;
        //요청자명
        this.camDefaultInfo.campaignRequestName = data.campaignRequestName;
        //기획자아이디
        this.camDefaultInfo.campaignPlanner = $.ifvmGetUserInfo().empId;
        //기획조직
        this.camDefaultInfo.planOrgCode = $.ifvmGetUserInfo().orgId;
        //조직
        this.camDefaultInfo.camScopeTypeCd = data.camScopeTypeCd  != null ? data.camScopeTypeCd : $.ifvmGetUserInfo().orgName ;
        //기획자 Account Id
        this.camDefaultInfo.accountId = $.ifvmGetUserInfo().accountId;

        this.camDefaultInfo.gaTagVal = data.gaTagVal;

        this.camDefaultInfo.ridIntactType = ridIntactType;

        if (this.camDefaultInfo.fatigueExceptYn == null || this.camDefaultInfo.fatigueExceptYn == "false" || this.camDefaultInfo.fatigueExceptYn == "N" ) {
            this.camDefaultInfo.fatigueExceptYn = false;
        }
        else this.camDefaultInfo.fatigueExceptYn = true;

        if (this.camDefaultInfo.promYn == null || this.camDefaultInfo.promYn == "false" || this.camDefaultInfo.promYn == "N") {
            this.camDefaultInfo.promYn = false;
        }
        else this.camDefaultInfo.promYn = true;

        if (this.camDefaultInfo.prmsExceptYn == null || this.camDefaultInfo.prmsExceptYn == "false" || this.camDefaultInfo.prmsExceptYn == "N") {
            this.camDefaultInfo.prmsExceptYn = false;
        }
        else this.camDefaultInfo.prmsExceptYn = true;

        if (this.camDefaultInfo.eventYn == null || this.camDefaultInfo.eventYn == "false" || this.camDefaultInfo.eventYn == "N") {
            this.camDefaultInfo.eventYn = false;
        }
        else this.camDefaultInfo.eventYn = true;
		
        //대분류
    
        $('#pntAccntBigTypeCd').val(this.camDefaultInfo.pntAccntBigTypeCd);
     	$('#pntAccntBigTypeCd').change();
   
     	//중분류
     	$('#pntAccntMidTypeCd').val(this.camDefaultInfo.pntAccntMidTypeCd);
     	$('#pntAccntMidTypeCd').change();

     	//소분류
     	$('#pntAccntSmlTypeCd').val(this.camDefaultInfo.pntAccntSmlTypeCd);
     	$('#pntAccntSmlTypeCd').change();

     	//세분류
     	$('#pntAccntDetailTypeCd').val(this.camDefaultInfo.pntAccntDetailTypeCd);
        
        $('#ridIntactTypeNm').val(this.camDefaultInfo.intactType2CodeName);

        $('#gaTagVal').val(this.camDefaultInfo.gaTagVal);

        campaignDefaultInfo = this;
        
        campaignTypeCodeChangeFn();
    };

    //konckout bindings
    ko.applyBindings(new infoModel(data), document.getElementById("campaignDefaultInfoPop") );

    //피로도 미적용 체크
    /* if ($.fn.ifvmIsEmpty(data.id)) {
        campaignDefaultInfo.camDefaultInfo.fatigueExceptYn = true;
		$('#fatigueExceptYn').prop('checked', true);
    } */
    
	 if ($.fn.ifvmIsNotEmpty(campaignId) && $("#campaignTypeCode").val()=="TRIGGER") {
		storeList();
    }else{
    	$("#intactTypePopCon").attr("hidden",true);
    }
}

//캠페인기본정보 저장
function saveCampaignDefaultInfo() {
	ridIntactType = $('#ridIntactType').val();
	
    //달력 binding 안되는 현상 발생 값을 찾아 넣어준다.
    campaignDefaultInfo.camDefaultInfo.campaignStartDate = $("#campaignStartDate").val();
    campaignDefaultInfo.camDefaultInfo.campaignEndDate = $("#campaignEndDate").val();
    campaignDefaultInfo.camDefaultInfo.campaignStatusCode = $("#campaignStatusCode").val();

    campaignDefaultInfo.camDefaultInfo.parCampaignId = $("#parCampaignId").val();
    campaignDefaultInfo.camDefaultInfo.b2cRefKey = $("#b2cRefKey").val();
    campaignDefaultInfo.camDefaultInfo.pntAccntCustDispTxt = $('#pntAccntCustDispTxt').val();
    campaignDefaultInfo.camDefaultInfo.type = strType;

    campaignDefaultInfo.camDefaultInfo.ridIntactType = $('#ridIntactType').val();
    campaignDefaultInfo.camDefaultInfo.intactType2CodeName = $('#ridIntactTypeNm').val();
    campaignDefaultInfo.camDefaultInfo.id = campaignId;
    
    campaignDefaultInfo.camDefaultInfo.campaignPurposeCode= $('#campaignPurposeCode').val();
    
    campaignDefaultInfo.camDefaultInfo.camScopeTypeCd= $('#camScopeTypeCd').val();

    campaignDefaultInfo.camDefaultInfo.campaignRequestName= $('#campaignRequestName').text();

    campaignDefaultInfo.camDefaultInfo.gaTagVal= $('#gaTagVal').val();

    campaignInfoPopValidation = $("#campaignDefaultInfoPop").ifvValidation();
    //check validation
    if (chkCalendarValidation() == true
            && campaignInfoPopValidation.confirm()) {


        $.ifvSyncPostJSON('<ifvm:action name="saveCampaignDefaultInfo"/>', campaignDefaultInfo.camDefaultInfo, function(result) {

        	
            campaignDefaultInfo = {};

            //set campaign ID
            campaign.id = result.message;
            
            campaignId = campaign.id;

            //set actual task ID
            diagram._selectedObject.actualTaskId = result.message;

            //set campaign ID
            diagram._selectedObject.campaignId = result.message;

            //set old campaign ID
            diagram._selectedObject.oldCampaignId = result.message;

            //save workflow
            saveWorkflow();

            //alert('<spring:message code="M00152" />');

            
            if($("#campaignTypeCode").val()=="TRIGGER"){
            	campaignDefaultInfoInitData();
            	storeList();
            }else{            
            //close popup
            closeCampaignInfoPop();
            }
            
            if(campaign.id != null){
            	$.ifvProgressControl(false);
            	qtjs.href('<ifvm:url name="campaignWorkFlow"/>?type=MKT&id='+campaign.id);
            } else {
            	$.ifvProgressControl(false);
           		location.reload();
            }
            
        });
    }
}

//캠페인기본정보 팝업 설정
function campaignDefaultInfoInit() {
    pageSetUp();

    //채널
    $.fn.ifvmSetSelectOptionCommCode("channelTypeCode", "MKT_CAM_CHNL_TYPE_CD");

    //캠페인 유형
    $.fn.ifvmSetSelectOptionCommCode("campaignTypeCode", "MKT_CAM_TYPE_CD", "TARGET",strType, true);
    
    
    //캠페인 목적
    $.fn.ifvmSetSelectOptionCommCode("campaignPurposeCode", "MKT_CAM_PRPS_CD", null, null , true);
    //임시로 캠페인 유형 값 'Target' , 'Mass' , '정기/반복'만 보이게 수정
    //$("select[name='campaignTypeCode'] option[value='TRIGGER']").remove();

    //캠페인상태
    $.fn.ifvmSetSelectOptionCommCode("campaignStatusCode", "MKT_CAM_STAT", "W");

    //조직
//     $.fn.ifvmSetSelectOptionCommCode("camScopeTypeCd", "CAM_SCOPE_TYPE_CD", null, null, true);
    
    
    //임시로 본사 값만 보이게 고정
//     $("select[name='camScopeTypeCd'] option[value='SPOT']").remove();
    $("#camScopeTypeCd").attr('disabled', true);

    //기획그룹
    $.fn.ifvmSetSelectOptionCommCode("planGroupCd", "PLAN_GROUP_CD", null, null, true);
	   
    //팝업설정
    //cDialog.model.title = '<spring:message code="M00770"/>';
    cDialog.model.title = '기본 정보';
    //$("#dialog_title").append('<spring:message code="M00770"/>');
    $("#dialog_title").append('기본 정보');
    cDialog.model.width = "660";
    cDialog.model.close = "closeCampaignInfoPop";

    //validation
    campaignInfoPopValidation = $("#campaignDefaultInfoPop").ifvValidation();
}

//달력
function setChannelCalendar() {
    var startDate = $("#campaignStartDate");
    var endDate = $("#campaignEndDate");

    startDate.val($.ifvGetTodayDate());
    endDate.val($.ifvGetNewDate('m', +1).newDateS);

    startDate.ifvDateChecker({});
    endDate.ifvDateChecker({});
}

/**
 * 시작일 종료일 체크
 */
function chkCalendarValidation() {
    var rtnFlag = true;
    var startDate = $("#campaignStartDate");
    var endDate = $("#campaignEndDate");
    startDate.removeClass('ifv_vali_wrong');
    if (startDate.val() > endDate.val()) {
        validFailMessage(startDate, '<spring:message code="C00043"/>');
        rtnFlag = false;
    }
    return rtnFlag;
}

//캠페인기본정보 팝업 데이터 설정
function campaignDefaultInfoInitData() {
    campaignDefaultInfo = {camDefaultInfo: {}};

    //set task type
    diagram._selectedObject.taskType = "INFO";

    //캠페인 ID
    var id = diagram._selectedObject.actualTaskId;
    campaignId = id;

    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignDefaultInfo"/>', {
        id: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)){
            campaignDefaultInfo.camDefaultInfo = result;
            $("#campaignStartDate").val(result.campaignStartDate);
            $("#campaignEndDate").val(result.campaignEndDate);
            $("#campaignRequestName").text(result.campaignRequest);
        }
    });

    initModels(campaignDefaultInfo.camDefaultInfo);
}

// dialog close
function closeCampaignInfoPop(args) {
    campaignDefaultInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

//트리거 데이터 유형 팝업 열기
function intactTypePopupOpen() {
    $("#intactTypePopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="intactTypePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02313"/>',
        width: 700,
        close : 'intactTypePopupClose'
    });
}

//이벤트 데이터 유형 선택
function selectIntactType() {
	var rowId = gridIdintactTypePopGrid.getGridParam("selrow");
	var rowData = gridIdintactTypePopGrid.getRowData(rowId);

	if ($.fn.ifvmIsNotEmpty(rowId)) {
		//캠페인기본정보에 해당 유형 값 설정
		 $("#ridIntactType").val(rowData.rid);
         $("#ridIntactTypeNm").val(rowData.intactType_2CdNm); 
		/*  campaignDefaultInfo.camDefaultInfo.ridIntactType = rowData.rid;
		$("#intactType2CodeName").val(rowData.intactType_2CdNm); */

		//팝업 닫기
        intactTypePopupClose();
	}
}

//트리거 데이터 유형 팝업 닫기
function intactTypePopupClose() {
    intactTypePopup._destroy();
}


/**
 * 마케팅 플랜 팝업열기
 */
function planListPopOpen() {
    planPop = $("#planPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="planListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02290"/>',
        width: 700,
        close : 'planPopupClose'
    });
}
/**
 * 마케팅 플랜 팝업 닫기
 */
function planPopupClose() {
    planPop.ejDialog('destroy');
}

/**
 * 상위 캠페인 코드 팝업 열기
 */
function parCamPopupOpen() {
    $("#parCamPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="parCamListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02290"/>',
        width: 700,
        close : 'parCamPopupClose'
    });
}
function parCamPopupClose() {
    parCamPopup._destroy();
} 

function campaignTypeCodeChangeFn(){

	if($("#campaignTypeCode").val()=="TRIGGER"){
		$("#ridIntactTypeNm").attr('required',true);
		$("#exceptArea").hide();
	}else{
		$("#ridIntactTypeNm").attr('required',false);
		$("#exceptArea").show();
	}
	
}
//지점매핑
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
    	 
         	node.storeId = node.id;  
    		obj.push({
    			storeNm: node.original.name,
    			rid:node.original.id
    		});
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

$(function () {

    //달력 설정
    setChannelCalendar();

    //캠페인기본정보 폼 설정
    campaignDefaultInfoInit();

    //캠페인기본정보 데이터
    campaignDefaultInfoInitData();

    if(empType != 'H'){
        $('#campaignControlCheckBox').hide();
    }

    if(campaignId == '' || campaignId == null){
        $("#intactTypePopCon").attr("hidden",true);
        $('#campaignRequestName').val($.ifvmGetUserInfo().empName);
        $('#campaignRequestName').text($.ifvmGetUserInfo().empId);
    }


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


    //저장 클릭시
    $('#campaignInfoPopSaveBtn').on('click', function(){
        saveCampaignDefaultInfo();
    });

    //draft 완료 클릭시
    $('#campaignInfoPopDramftSaveBtn').on('click', function(){
        saveCampaignDefaultInfo();
    });

    //취소 클릭시
    $('#campaignInfoPopCancelBtn').on('click', function(){
        closeCampaignInfoPop();
    });

    //이벤트유형 팝업 버튼
    $('#intactTypePopupBtn').on('click', function(){
        intactTypePopupOpen();
    });

    //마케팅 플랜 팝업 버튼
    $('#planListPopupBtn').on('click', function(){
        planListPopOpen();
    });

    //상위 캠페인 코드 팝업 버튼
    $('#parCamPopupBtn').on('click', function() {
        parCamPopupOpen();
    });

    setTimeout(function() {
        //popup 높이 맞추기
        new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });

        cDialog.refresh();
    }, 500);

    //퍼미션 체크 시 알림
    $('#prmsExceptYn').on('click', function(){
        if($('#prmsExceptYn').prop("checked")){
            if(confirm("수신동의를 미적용 하시겠습니까?")){
                $("input:checkbox[id='prmsExceptYn']").prop("checked", true);
            } else {
                $("input:checkbox[id='prmsExceptYn']").prop("checked", false);
            }
        }
    });
    //피로도 체크 시 알림
    $('#fatigueExceptYn').on('click', function(){
        if($('#fatigueExceptYn').prop("checked")){
            if(confirm("피로도를 미적용 하시겠습니까?")){
                $("input:checkbox[id='fatigueExceptYn']").prop("checked", true);
            } else {
                $("input:checkbox[id='fatigueExceptYn']").prop("checked", false);
            }
        }
    });

});

$('#campaignTypeCode').on('change', function(){
	campaignTypeCodeChangeFn();
});

//요청자 검색 팝업 버튼
function showRequestName(){
    $("#showRequestNamePopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="campaignRequestSearchPop"/>',
        contentType: "ajax",
        title: '<spring:message code="요청자 검색" />',
        width: '900px',
        height: '620px',
        close : 'showRequestNamePopClose'
    });
}

//상세 팝업 닫기
function showRequestNamePopClose(){
    showRequestNamePopup._destroy();
}

</script>

<style>
#hideFile {
	display: none
}
</style>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div class="form-horizontal" id="campaignDefaultInfoPop">
            <div class="row qt_border">

                <%-- 캠페인명 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><%-- <spring:message code="M00592"/> --%>캠페인명</label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="text" id="campaignName" names="campaignName" maxLength="50" required="true" dataBind="value: camDefaultInfo.campaignName" />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 시작일 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00593"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="date" id="campaignStartDate" names="campaignStartDate" required="true"  />
                </div>

                <%-- 종료일 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00594"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="date" id="campaignEndDate" names="campaignEndDate" required="true"  />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 유형 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00755"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="campaignTypeCode" names="campaignTypeCode" required="true" dataBind="value: camDefaultInfo.campaignTypeCode" />
                </div>
                <label class="col-xs-2 control-label">목적</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="campaignPurposeCode" names="campaignPurposeCode"  dataBind="value: camDefaultInfo.campaignPurposeCode" />
                </div>
           <%-- 이벤트 데이터 유형 --%>
<%--         		<form id = "evtDataType">
        		<label class="col-xs-3 control-label"><spring:message code="M02938"/></label>
        		<div class="col-xs-3 control_content">
            		<div class="input-group">
                		<ifvm:input type="text" id="ridIntactTypeNm"  readonly="true" dataBind="value: camDefaultInfo.intactType2CodeName"/>
                		<ifvm:input type="hidden" id="ridIntactType" dataBind="value: camDefaultInfo.ridIntactType"/>
                		<span class="input-group-addon" id="intactTypePopupBtn">
                    		<a><i class="fa fa-search"></i></a>
                		</span>
            		</div>
        		</div>
        		</form> --%>
            </div>
            <div class="row qt_border">

                <%-- 비고 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00600"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="textarea" id="description" names="description" maxLength="250" dataBind="value: camDefaultInfo.description" rows="3" />
                </div>
            </div>

            <%-- GA TAG --%>
            <div class="row qt_border">
                <label class="col-xs-2 control-label"><spring:message code="GA TAG"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="text" id="gaTagVal" names="gaTagVal"/>
                </div>
            </div>


            <div class="row qt_border">

                <%-- 상태 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00595"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="campaignStatusCode" names="campaignStatusCode" disabled="true" dataBind="value: camDefaultInfo.campaignStatusCode" />
                </div>

                <%-- 승인 상태 --%>
                <label class="col-xs-2 control-label"><spring:message code="M01333"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="hidden" id="campaignApprovalStatusCode" names="campaignApprovalStatusCode" />
                    <ifvm:input type="text" id="campaignApprovalStatusCodeName" names="campaignApprovalStatusCodeName"
                        disabled="true" dataBind="value: camDefaultInfo.campaignApprovalStatusCodeName" />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 마케팅 플랜 --%>
                <ifvm:input type="hidden" id="planNm" names="planNm" readonly="true" dataBind="value: camDefaultInfo.planNm"/>
                <ifvm:input type="hidden" id="planId" names="planId" dataBind="value: camDefaultInfo.planId" />
                <%--
                <label class="col-xs-2 control-label"><spring:message code="M02290"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="text" id="planNm" names="planNm" readonly="true" dataBind="value: camDefaultInfo.planNm" />
                        <ifvm:input type="hidden" id="planId" names="planId" dataBind="value: camDefaultInfo.planId" />
                        <span class="input-group-addon" id="planListPopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div>
                 --%>

                <%-- 조직 --%>
                <label class="col-xs-2 control-label"><spring:message code="M02455"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="camScopeTypeCd" names="camScopeTypeCd" dataBind="value: camDefaultInfo.camScopeTypeCd" />
                </div>

                <%-- 캠페인 코드 --%>
                <label class="col-xs-2 control-label"><%-- <spring:message code="M02311"/> --%>번호</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="dispNo" names="dispNo" maxLength="50" disabled="true" dataBind="value: camDefaultInfo.dispNo" />
                </div>
            </div>
            <div class="row qt_border temporarilyHide">

                <%-- 상위 캠페인 코드 PAR_CAM_ID --%>
                <label class="col-xs-2 control-label"><spring:message code="M02741"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="hidden" id="parCampaignId" names="parCampaignId" readonly="true" dataBind="value: camDefaultInfo.parCampaignId" />
                        <ifvm:input type="text" id="parDispNo" names="parDispNo" readonly="true" dataBind="value: camDefaultInfo.parDispNo" />
                        <span class="input-group-addon" id="parCamPopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div>

                <%-- 연관 이벤트 코드 B2C_REF_KEY --%>
                <label class="col-xs-2 control-label"><spring:message code="M02742"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="b2cRefKey" names="b2cRefKey" maxLength="50" dataBind="value: camDefaultInfo.b2cRefKey" />
                </div>
            </div>
            <ifvm:input type="select" id="planGroupCd" names="planGroupCd" dataBind="value: camDefaultInfo.planGroupCd" className="temporarilyHide"/>
			<!--
            <div class="row qt_border">
			 -->
                <%-- 기획 그룹 --%>
                <%--
                <label class="col-xs-2 control-label"><spring:message code="M02309"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="planGroupCd" names="planGroupCd" dataBind="value: camDefaultInfo.planGroupCd" />
                </div>
            </div>
             --%>
            <div class="row qt_border">

                <%-- 프로모션 --%>
                <label class="col-xs-2 control-label temporarilyHide"><spring:message code="M02486"/></label>
                <div class="col-xs-4 control-label text-left temporarilyHide">
                    <ifvm:input type="checkbox" id="promYn" names="promYn" dataBind="checked: camDefaultInfo.promYn" />
                </div>

                <%-- 기획자 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00596"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="campaignPlannerName" names="campaignPlannerName" disabled="true" dataBind="value: camDefaultInfo.campaignPlannerName" />
                </div>

                <%-- 요청자 --%>
                <label class="col-xs-2 control-label">요청자</label>
                <div class="col-xs-4 control_content">
                    <ifvm:inputNew type="search" id="campaignRequestName" names="campaignRequestName" dataBind="value: camDefaultInfo.campaignRequestName" btnFunc="showRequestName"/>
                </div>
            </div>
             <div id="campaignControlCheckBox" class="row qt_border">
<%--             <label class="col-xs-2 control-label"><spring:message code="M02310"/></label>--%>
                <label class="col-xs-2 control-label">수신동의 미적용</label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="prmsExceptYn" names="prmsExceptYn" dataBind="checked: camDefaultInfo.prmsExceptYn" />
                     <%--(※ 퍼미션 / 피로도 미적용시 체크)--%>
                </div>
                <label class="col-xs-2 control-label">피로도 미적용</label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="fatigueExceptYn" names="fatigueExceptYn" dataBind="checked: camDefaultInfo.fatigueExceptYn" />
                </div>
             </div>
<%--             <div id="exceptArea" style="display:none;">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span>퍼미션 / 피로도 적용 여부</span>
					 <span class="detail_txt" style="font-size:10px;">&nbsp;&nbsp;※ 퍼미션 / 피로도 미적용시 체크해 주세요.</span>
				</div>
			</div>
			
			<div class="row">
                피로도 미적용
                <label class="col-xs-2 control-label"><spring:message code="M02732"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="fatigueExceptYn" names="fatigueExceptYn" dataBind="checked: camDefaultInfo.fatigueExceptYn" />
                </div>
				
				퍼미션 미적용
                <label class="col-xs-2 control-label"><spring:message code="M02310"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="prmsExceptYn" names="prmsExceptYn" dataBind="checked: camDefaultInfo.prmsExceptYn" />
                </div>
            </div>
            </div> --%>
        </div>
    </div>
    
    
<div id="intactTypePopCon">
	<div class="page_btn_area" id=''>
		<div class="col-xs-4">
			<span>지점매핑</span>
		</div>
        <div class="col-xs-8 searchbtn_r">
            <button class="btn btn-sm" id="addStoreByFileBtn">파일업로드</button>
            <ifvm:input type="file" id="hideFile"/>
            <button class="btn btn-sm" id="addStoreBtn">신규</button>
            <button class="btn btn-sm" id="editStoreBtn">수정</button>
            <button class="btn btn-sm" id="removeStoreBtn">삭제</button>
        </div>
    </div>
	<div class="well">
		<div id="campaignStoreGrid" class=""></div>
	</div>
	
</div>     
    
    <div class="pop_btn_area">
        <%-- 저장 --%>
        <button class="btn btn-sm btn_gray" id="campaignInfoPopSaveBtn" objCode="campaignInfoPopSaveBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- 닫기 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="campaignInfoPopCancelBtn" objCode="campaignInfoPopCancelBtn_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

<div id="programPop" class="popup_container"></div>
<div id="intactTypePopup" class="popup_container"></div>
<div id="planPopup" class="popup_container"></div>
<div id="parCamPopup" class="popup_container"></div>
<div id="addStorePopup" class="popup_container"></div>
<div id="editStorePopup" class="popup_container"></div>
<div id="showRequestNamePopup" class="popup_container"></div>