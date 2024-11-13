<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#paymentAccordion .border_bottom_zero {border-bottom: 0px}
</style>

<script>

var approvedRequestListGrid;
var approvedRequestListGrid2;
var approvedReference;
var approvalDialog;
var rejectId;
var rowId;
var itemStatus;
var searchType = null;
var doubleSubmitFlag = false;
function accordionSetting(){
    $("#paymentAccordion").ejAccordion({collapsible: true});
    $("#paymentAccordion").width('inherit');
}

function AprvstatusUI(dataid){
    $("#approvalProgressArea").empty()
    $.ifvSyncPostJSON('<ifvm:action name="getApproverStatus"/>', {
           id : dataid
    }, function(result) {

        var temp = $("#approvalProgressStatus").tmpl(result);
        $("#approvalProgressArea").append(temp);
    });
    $("#approvalProgressWrap").show();

}


//내가 승인 요청한 캠페인 - 승인 요청 목록
function approvedRequestList(){
    var jqGridOption = {
        ondblClickRow : function(row) {
            var selData = approvedRequestListGrid.getRowData()[row-1];
            loadPop(selData.id, selData.recordRid, 'aprv');
        },
        onSelectRow : function (data) {
        },
        onSelectCell : function (data) {
            AprvstatusUI(data.id)
        },
        serializeGridData : function(data) {
            if(requestitem != null && requestitem.length > 0){
                data.item = requestitem;
            }
            data.searchType = searchType;
            return data;
        },
        url:'<ifvm:action name="getMyElapproval"/>',
        colNames:['<spring:message code="L01434"/>',
                  '<spring:message code="L01435"/>',
                  '<spring:message code="L01436"/>',
                  '<spring:message code="L01437"/>',
                  '<spring:message code="L01438"/>',
                  '<spring:message code="L01439"/>',
                  '<spring:message code="L01440"/>',
                  '<spring:message code="L01441"/>',
                  'id',
                  'aprvType',
                  'recordRid'
        ],
        colModel:[
            {name:'elecAprvTypeCd',		index:'b.mark_name', 		 resizable : false},
            {name:'elecAprvNo',			index:'a.elec_aprv_no', 	 resizable : false},
            {name:'elecAprvTitle',		index:'a.elec_aprv_title', 	 resizable : false},
            {name:'elecAprvRqtrId',		index:'e.name', 			 resizable : false},
            {name:'createDate',			index:'a.create_date',       resizable : false, formatter:'date', formatoptions:{newformat:"Y-m-d"}},
            {name:'elecAprvStatusCd',	index:'c.mark_name', 		 resizable : false},
            {name:'lastApvrId',			index:'g.name', 			 resizable : false},
            {name:'lastApvDd',			index:'f.apv_dd',  			 resizable : false, formatter:'date', formatoptions:{newformat:"Y-m-d"}},
            {name:'id', 				index:'a.id', 				 resizable : false, hidden : true, searchable : false},
            {name:'aprvType', 			index:'a.elec_aprv_type_cd', hidden : true, searchable : false},
            {name:'recordRid',        	index:'a.cam_id',            hidden : true, searchable : false},
        ],
        radio : true,
        sortname: 'a.modify_date',
        sortorder: 'desc',
		tempId : 'ifvGridOriginTemplete',
    };
    approvedRequestListGrid = $("#approvedRequestListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//등록화면 팝업
function popupUiSetting(){
    $(".page_hidden").remove();
    $("#approvalPopup .btn").remove();
    $(".page_border").css({"border-top":"0"});
    $("#approvalBasicInfo input").attr("disabled","disabled");
    $("#approvalBasicInfo select").attr("disabled","disabled");
    $("#approvalBasicInfo textarea").attr("disabled","disabled");
    $("#approvalContents").addClass("disabledDiv");
}

/* 팝업 닫기 */
function popupClose() {
    empRefPopupCon._destroy();
}

function previewCampaignPopupOpen(strId) {
    $("#empRefPopupCon").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="campaignReportPop"/>?id=' + strId,
        contentType: "ajax",
        title: '<spring:message code="M00392"/>',
        width: '1050px',
        maxHeight: null, 
        close : 'popupClose',
    });
}

/**
 * 결제라인화면 로드
 */
function loadPop(strId, campaignId, text) {
    $("#empRefPopupCon").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="approvalLineInfoPop"/>?id=' + strId + "&type=" + text + '&campaignId=' + campaignId,
        contentType: "ajax",
        title: '<spring:message code="M00392"/>',
        width: '1240px',
        height : '700px',
        close : 'popupClose'
    });
}

function fnAllSearch(){

    searchType = 'A';
    approvedRequestList();
}

function fnPreview() {
    var url;
    var checkedList = approvedRequestListGrid.getCheckedList();
    if(checkedList.length != 0){
        switch(checkedList[0].aprvType){
        case '01' :
            previewCampaignPopupOpen(checkedList[0].recordRid);
            break;
        case '02' :
            url = '<ifvm:url name="previewManualDetailPop"/>' + '?rid='+checkedList[0].recordRid;
            fnPreviewPopupOpen(url);
            break;
        case '03' :
        	url = '<ifvm:url name="previewBatchRgstDetailPop"/>' + '?rid='+checkedList[0].recordRid;
        	fnPreviewPopupOpen(url);
        	break;
        case '05' :
        	var recordRid = checkedList[0].recordRid.split('/');
        	url = '<ifvm:url name="previewSettleDetailPop"/>' + '?actYearMonth='+recordRid[0]+'&actnum='+recordRid[1];
        	fnPreviewPopupOpen(url);
        	break;
        case '06' :            	
        	url = '<ifvm:url name="previewUnRgstCardDetailPop"/>' + '?rid='+checkedList[0].recordRid;
        	fnPreviewPopupOpen(url);
        	break;	
        case '07' :            	
        	url = '<ifvm:url name="previewUnRgstCardUploadDetail"/>' + '?rid='+checkedList[0].recordRid;
        	fnPreviewPopupOpen(url);
        	break;		
        default :
            break;
        }
    }
}

function fnPreview2() {
    var url;
    var checkedList = approvedRequestListGrid2.getCheckedList();

    if (checkedList.length == 0) {
        alert('<spring:message code="L00066"/>');
    }
    else if (checkedList.length > 1) {
        alert('<spring:message code="V00204"/>');
    }
    else if (checkedList.length == 1) {

        switch (checkedList[0].aprvType) {
        case '01' :
            previewCampaignPopupOpen(checkedList[0].recordRid);
            break;
        case '02' :
            url = '<ifvm:url name="previewManualDetailPop"/>' + '?rid='+checkedList[0].recordRid;
            fnPreviewPopupOpen(url);
            break;
        case '03' :
        		url = '<ifvm:url name="previewBatchRgstDetailPop"/>' + '?rid='+checkedList[0].recordRid;
        		fnPreviewPopupOpen(url);
        	break;
        case '05' :
        		var recordRid = checkedList[0].recordRid.split('/');
        		url = '<ifvm:url name="previewSettleDetailPop"/>' + '?actYearMonth='+recordRid[0]+'&actnum='+recordRid[1];
        		fnPreviewPopupOpen(url);
			break;        		
        case '06' :            	
        	url = '<ifvm:url name="previewUnRgstCardDetailPop"/>' + '?rid='+checkedList[0].recordRid;
        	fnPreviewPopupOpen(url);
        	break;		
        	
        case '07' :            	
        	url = '<ifvm:url name="previewUnRgstCardUploadDetail"/>' + '?rid='+checkedList[0].recordRid;
        	fnPreviewPopupOpen(url);
        	break;		
        default :
            break;
        }
    }
}

function fnPreviewPopupOpen(url) {
   	previewPopup = {
           id : "previewPopup"
    };

   	previewPopup.popup = function() {
       	previewPopup.pop = $('#' + previewPopup.id).ifvsfPopup({
               enableModal : true,
               enableResize : false,
               contentUrl : url,
               contentType : "ajax", 
               title : '<spring:message code="L01442"/>',
               width : '1024px',
               close : previewPopup.close
           });
       };

       previewPopup.beforeClose = function(obj) {
       };

       previewPopup.close = function(obj) {
           previewPopup._destroy();
       };

       previewPopup.popup();
}

//승인대기목록
function approvedRequestList2(){
    var jqGridOption = {
        onSelectRow : function (data) {
            rejectId = data.id
        },
        ondblClickRow : function(row) {
            var selData = approvedRequestListGrid2.getRowData()[row-1];
            loadPop(selData.id, selData.recordRid, 'aprv');
        },
        serializeGridData : function(data) {
            if(requestitem != null && requestitem.length > 0){
                data.item = requestitem;
            }
            return data;
        },
        url:'<ifvm:action name="getMyElapproval2"/>',
         colNames:['<spring:message code="L01434"/>',
                      '<spring:message code="L01435"/>',
                      '<spring:message code="L01436"/>',
                      '<spring:message code="L01437"/>',
                      '<spring:message code="L01438"/>',
                      '<spring:message code="L01439"/>',
                      '<spring:message code="L01440"/>',
                      '<spring:message code="L01441"/>',
                      'id',
                      'aprvType',
                      'recordRid',
                      'itemId',
                      'seq',
                      'apvrTypeCd'
          ],
          colModel:[
                    {name:'elecAprvTypeCd',   index:'b.mark_name',         resizable : false},
                    {name:'elecAprvNo',       index:'a.elec_aprv_no',      resizable : false},
                    {name:'elecAprvTitle',    index:'a.elec_aprv_title',   resizable : false},
                    {name:'elecAprvRqtrId',   index:'e.name',              resizable : false},
                    {name:'createDate',       index:'a.create_date',       resizable : false, formatter:'date',  formatoptions:{newformat:"Y-m-d"}},
                    {name:'elecAprvStatusCd', index:'c.mark_name',         resizable : false},
                    {name:'lastApvrId',       index:'g.name',              resizable : false},
                    {name:'lastApvDd',        index:'f.apv_dd',            resizable : false, formatter:'date',  formatoptions:{newformat:"Y-m-d"}},
                    {name:'id',               index:'a.id',                hidden : true, searchable : false},
                    {name:'aprvType',         index:'a.elec_aprv_type_cd', hidden : true, searchable : false},
                    {name:'recordRid',        index:'a.cam_id',            hidden : true, searchable : false},
                    {name:'itemId',           index:'h.id',                hidden : true, searchable : false},
                    {name:'seq',              index:'h.elec_aprv_seq',     hidden : true, searchable : false},
                    {name:'apvrTypeCd',       index:'h.apvr_type_cd',      hidden : true, searchable : false}
        ],
        multiselect: true,
        sortname: 'a.modify_date',
        sortorder: "desc",
   		tempId : 'ifvGridOriginTemplete',
    };
    approvedRequestListGrid2 = $("#approvedRequestListGrid2").ifvGrid({ jqGridOption : jqGridOption });
}


//팝업 닫기
function approvalPopupClose(){
    approvalPopup._destroy();
}

function Aprvcount(){

    $.ifvSyncPostJSON('<ifvm:action name="getMyAgreeCount"/>', {
    }, function(result) {
        $("#aprvReq2").text(result.aprvReq);
    });

    /* $.ifvSyncPostJSON('<ifvm:action name="getMyAprvCount"/>', {
    }, function(result) {
        $("#aprvReq").text(result.aprvReq)
        $("#aprvLastReq").text(result.lastApvrReq)
    }); */

}


function fnReject(){
    if(rejectId == null){
        alert('<spring:message code="M00499"/>');
    }else{
        $("#approvalPopup").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="refusalPop"/>?id='+rejectId,
            contentType: "ajax",
            title: '<spring:message code="M00978"/>',
            width: '340px',
            close : 'approvalPopupClose'
        });
        }
    }


$(document).ready(function(){
	console.log('page document ready called');
    $.ifvmLnbSetting('electronicPaymentList');
    var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');

    accordionSetting();
    approvedRequestList();
    approvedRequestList2();

    Aprvcount();

    $("#divApproval").on('click', function(){
        approvedRequestList();
    });
    $("#divApproval2").on('click', function(){
        approvedRequestList2();
    });
    
    //필수 영역 공통 호출
/* 
    $("#authGroupSearchBtn").on('click', function(){
        $.fn.ifvmSubmitSearchCondition("channelRequiredList", approvedRequestList);
        $.fn.ifvmSubmitSearchCondition("channelRequiredList", approvedRequestList2);
        $.fn.ifvmSubmitSearchCondition("channelRequiredList", approvedReferenceList);
    });
    $.fn.ifvmSetCommonCondList("channelRequiredList",LeftMenuId);

    $("#authGroupinitBtn").on('click', function(){
        $.fn.ifvmSetCommonCondList("channelRequiredList",LeftMenuId);
    });

    $("#newApproval").on("click", function(){
        qtjs.href('<ifvm:url name="approvalDetail"/>');
    });

    $("#companionBtn").on("click", function(){

    }); */

    function deleteList(fromTbl, toTbl) {
        var active = 0;
        var checkedList = contentSearchResult.getCheckedList();
        var listFlowIdList = [];
        if(checkedList.length != 0){
            for( var i = 0; i < checkedList.length; i++ ){
                    listFlowIdList.push( checkedList[i].id );
            }
            $.ifvSyncPostJSON('<ifvm:action name="removeContent"/>',{
                lisContentFlowId : listFlowIdList
            },function(result) {
                alert('<spring:message code="M00012"/>');
                contentSearchResult.delCheckedRow();
            });
        }
        else {
            alert('<spring:message code="M00285"/>');
        }
    }

   
});


function doubleSubmitCheck(){
    if(doubleSubmitFlag){
        return doubleSubmitFlag;
    }else{
        doubleSubmitFlag = true;
        return false;
    }
}


// 승인
function fnApprove() {

	if(doubleSubmitCheck()) return;

    var active = 0;
    var checkedList = approvedRequestListGrid2.getCheckedList();
    var listFlowIdList = [];
	var err = 0 ;
	var suc = 0;


    if (checkedList.length != 0) {

    	for( var i = 0; i < checkedList.length; i++ ){

            // 상태값 코드 변경
            $.ifvSyncPostJSON('<ifvm:action name="editReject"/>', {
                apvDd : '1',
                id : checkedList[i].id,
                statusCode : '014',
                itemId : checkedList[i].itemId,
                aprvType : checkedList[i].aprvType,
                elecAprvStatusCd : '090',
                recordRid : checkedList[i].recordRid,
                seq : checkedList[i].seq,
                approvalTypeCd : checkedList[i].apvrTypeCd
            }, function(result) {
                setTimeout(function() {
                    Aprvcount();
                }, 100);
                suc = suc + 1;
            },function(result) {
                setTimeout(function(){
                    Aprvcount();
                }, 100);
            });


            //최종 승인자일 때
            if (checkedList[i].apvrTypeCd == '9') {

                //결재 완료
                $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>',{
                    elecAprvStatusCd : '090'
                    ,id : checkedList[i].id
                    ,aprvType: checkedList[i].aprvType
                    ,recordRid : checkedList[i].recordRid
                },function(result) {
                    setTimeout(function(){
                        Aprvcount();
                    }, 100);
                });
            }

       	}
        var msg = "";
        msg += '<spring:message code="L02028"/>' +suc + '<spring:message code="L02029"/>' ;
        msg += " " + '<spring:message code="L02045"/>';

    	alert( msg );
        approvedRequestListGrid.requestData({});
        approvedRequestListGrid2.requestData({});
    }
    else{
        alert('<spring:message code="M00285"/>');
    }
    doubleSubmitFlag = false;
};

</script>

<script id="channelListDateTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2 cal_frt start_date">
    <ifvm:input type="date" />
</div>
<div class="col-xs-1 swung_dash">~</div>
<div class="col-xs-2 cal_scd end_date">
    <ifvm:input type="date" />
</div>
</script>

<script id="channelListSelectTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="select" />
</div>
</script>

<script id="approvalProgressStatus" type="text/x-jquery-templ">
<div class="progress_item">
{{if statusCode == '021'}}
<div class="progress_item red">
{{/if}}
{{if statusCode != '021'}}
<div class="progress_item blue">
{{/if}}
    <div class="wrap_border">
        <div class="inner_bg">
            <span class="inner_text">${'${'}apprvType}</span>
        </div>
        {{if apprvCode == '1'}}
            <span class="icon_area write"></span>
        {{/if}}
        {{if apprvCode != '1'}}
            <span class="icon_area"></span>
        {{/if}}
    </div>
    <p class="txt_progress">${'${'}elApproveStatus}</p>
    <p class="txt_name">${'${'}apprvName}</p>
    <p class="txt_date">${'${'}apvDd}</p>
</div>
</div>


</script>

<style>
#approvalProgressWrap{display:none;}
</style>

<div id="paymentAccordion">
    <!-- 내가 승인 할 캠페인 -->
    <h3 id="divApproval2" >
        <a   href="#">
            <spring:message code="L01833"/>
            (
            <spring:message code="M00976"/> : <span id="aprvReq2"></span><spring:message code="M00964"/>
            )
        </a>
    </h3>
    <div   class="well form-horizontal well_sum">
        <div class="campaign_load_contents">
            <div class="page_btn_area border_bottom_zero">
                <div class="col-xs-7">
                    <span><spring:message code="L01833"/></span>
                </div>
                <div class="col-xs-5 searchbtn_r">
                    <ifvm:inputNew type="button" btnType="select" text="L01442" id="previewBtn2" btnFunc="fnPreview2" />
                    <ifvm:inputNew type="button" btnType="select" text="L01444" id="approveBtn" btnFunc="fnApprove" />
                    <ifvm:inputNew type="button" btnType="select" text="L01445" id="rejecthBtn"  btnFunc="fnReject" />
                </div>
            </div>
            <div id="approvedRequestListGrid2"></div>
        </div>
    </div>

    <!-- 내가 승인 요청한 캠페인 -->
    <h3 id="divApproval" >
        <a href="#">
            <spring:message code="L01834"/>
            <%-- (
            <spring:message code="M00962"/> : <span id="aprvReq"></span><spring:message code="M00964"/>,
            <spring:message code="M00963"/> : <span id="aprvLastReq"></span><spring:message code="M00964"/>
            ) --%>
        </a>
    </h3>
    <div  class="well form-horizontal well_sum">
        <div class="campaign_load_contents">
            <div class="page_btn_area border_bottom_zero">
                <div class="col-xs-7">
                    <span><spring:message code="L01834"/></span>
                </div>
                <div class="col-xs-5 searchbtn_r">
                    <ifvm:inputNew type="button" btnType="select" text="L01443"  id="allSearchBtn"  btnFunc="fnAllSearch" />
                    <ifvm:inputNew type="button" btnType="select" text="L01442"  id="previewBtn" btnFunc="fnPreview" />
                </div>
            </div>
            <div id="approvedRequestListGrid"></div>
        </div>
    </div>
</div>

<div id="empRefPopupCon" class="popup_container"></div>
<div id="approvalPopup" class="popup_container"></div>
<div id="previewPopup" class="popup_container"></div>
<div id="testPopup" class="popup_container"></div>