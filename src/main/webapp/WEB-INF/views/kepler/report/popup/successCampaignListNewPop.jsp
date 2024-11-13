<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="pop_main_div_mbr">
   <div>
       <div class="page_btn_area" >
           <div class="col-xs-7">
               <span><spring:message code="M00277" /></span>
           </div>
           <div class="col-xs-5 searchbtn_r">
           </div>
       </div>
       <div id="exeCampaignChnlGrid" class="white_bg grid_bd0"></div>
   </div>
   <div id="emptyDialog" class="popup_container"></div>
   <div class="pop_btn_area">
      <ifvm:inputNew type="button" btnType="save"   text="C00038"  id="choiceMbrBtn" btnFunc="choiceMbrFn"/>
      <ifvm:inputNew type="button"   text="M00441"  id="cancelmbrTransFerBtn" btnFunc="searchCampPopClose"/>
   </div>
</div>
<div id="transferPointConfirmPopup" class="popup_container"></div><!-- 팝업 -->

<script type="text/javascript">
var exeCampaignChnlGrid;
var camStartDd;
var camEndDd;
function getStoreList(){
    var ejGridOption = {
        serializeGridData : function(data) {
           if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getCampaignExeInfoList"/>',
        columns:[
            {
                 field : 'camNm', headerText : '캠페인 명', headerTextAlign : 'center', textAlign : 'left', width : '200px',
                 customAttributes : {
                    index : 'camNm' }
              }, {
                 field : 'camTerm', headerText : '캠페인 기간', headerTextAlign : 'center', textAlign : 'center', width : '120px',
                 customAttributes : {
                    index : 'camTerm' }
              }, {
                  field : 'pushYn', headerText : 'PUSH 발송여부', headerTextAlign : 'center', textAlign : 'center',width : '60px',
                  customAttributes : {
                     index : 'pushYn' }
              }, {
                  field : 'emailYn', headerText : 'EMAIL 발송여부', headerTextAlign : 'center', textAlign : 'center',width : '60px',
                  customAttributes : {
                     index : 'emailYn' }
              }, {
                  field : 'lmsYn', headerText : 'LMS 발송여부', headerTextAlign : 'center', textAlign : 'center',width : '60px',
                  customAttributes : {
                     index : 'lmsYn' }
              }, {
                  field : 'smsYn', headerText : 'SMS 발송여부', headerTextAlign : 'center', textAlign : 'center',width : '60px',
                  customAttributes : {
                     index : 'smsYn' }
              }, {
                  field : 'tgtAmt', headerText : '추출 대상자 수', headerTextAlign : 'center', textAlign : 'right',width : '100px',
                  customAttributes : {
                     index : 'tgtAmt' }
              }, {
                  field : 'camId', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
                  customAttributes : {
                	  searchable : false,
                     index : 'camId' }
              }, {
                  field : 'startDd', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
                  customAttributes : {
                	  searchable : false,
                     index : 'startDd' }
              }, {
                  field : 'endDd', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
                  customAttributes : {
                	  searchable : false,
                     index : 'endDd' }
              }
        ],
        requestGridData : {
              nd   : new Date().getTime(),
              rows : 10,
              _search : false
           },
           rowList : [10,25,50,100],
           radio: true
     };
    exeCampaignChnlGrid = $("#exeCampaignChnlGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}   
//공통 조회 목록 설정 
function searchInit() {
    $.fn.ifvmSetCommonCondList("searchList","CAM_REPORT_02");
}

//공통 조회 호출
function storeSerch() {
	$.fn.ifvmSubmitSearchCondition("exeCampaignChnlGrid",getStoreList);
}

function choiceMbrFn(){
    if ($.fn.ifvmIsNotEmpty(exeCampaignChnlGrid.opt.gridControl.getSelectedRecords()[0])) {
       var chnlNm = exeCampaignChnlGrid.opt.gridControl.getSelectedRecords()[0].camNm;
       $("#chnlNm").val(chnlNm);
       camStartDd = exeCampaignChnlGrid.opt.gridControl.getSelectedRecords()[0].startDd;
       camEndDd = exeCampaignChnlGrid.opt.gridControl.getSelectedRecords()[0].endDd;
       camId = exeCampaignChnlGrid.opt.gridControl.getSelectedRecords()[0].camId;
       searchCampPopClose();
    }
    else {
        alert('목록을 선택해 주세요.');
    }
}

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    searchInit();


    getStoreList();

    //조회
    $('#mbrTransFerSearchBtn').on('click', function(){
        storeSerch();
    });
    //초기화
    $("#mbrTransFerSearchInitBtn").on('click', function(){
        searchInit('exeCampaignChnlGrid');
    });
});
</script>