<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/marketing/facebook/facebookPosting.js'></script>

<script>
var strType = '';
var campaignListGrid; //캠페인목록그리드

//노드 체크 변수
var fbChk = false;
var instaChk = false;
var offerChk = false;
var targetChk = false;
var scheduleChk = false;
var delChk = false;

//캠페인 목록
function getCampaignList() {
    
    var jqGridOption = {
        onSelectRow : function (data) {
        	//버튼 활성 설정
            setBtnActive(data.campaignStatusCode);
        },
        ondblClickRow : function (rowNo) {
            var data = campaignListGrid.getRowData()[rowNo-1];
            qtjs.href('<ifvm:url name="stnCampaignDetail"/>' + '?id=' + data.id);
        },
        serializeGridData : function( data ){
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            if ($.fn.ifvmIsNotEmpty(strType)) {
                data.type = strType;
            }
            return data;
        },
        url : '<ifvm:action name="getChargingStationCampaignList"/>',
        colNames:[ '<spring:message code="L00268"/>',
                   '<spring:message code="M00592"/>', 
                   '<spring:message code="L00155"/>', //유형
                   '<spring:message code="M00607" />', //기간
                   '<spring:message code="L00938" />', //충전소명
                   '<spring:message code="M00375" />', //채널유형
                   '<spring:message code="S00002" />', //혜택 유형
                   '<spring:message code="S00003" />', //고객수
                   '<spring:message code="S00006" />', //진행상태
                   
                   'campaignTypeCode',
                   'id',
                   'campaignStartDate',
                   'campaignEndDate'
                 ],
        colModel:[
            { name:'dispNo',					index:'c.disp_no', width:'150px', resizable : false },
            { name:'campaignName',				index:'c.CAM_NM', width:'250px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';} },
            { name:'camTypeCdMarkName',				index:'c4.mark_name', width:'100px', resizable : false },
            { name:'campaignPeriod',			index:'c.CAM_START_DD', width:'150px', resizable : false, align: 'center', formatter : setPeriod },
            { name:'chargingStationName',		index:'chnl.chnl_nm', width:'150px', resizable : false, align: 'center' }, //충전소명
            { name:'chnlTypeCodeName',			index:'c7.mark_name', width:'150px', resizable : false }, //채널유형
            { name:'offerTypeName',				index:'c1.MARK_NAME', width:'150px', resizable : false }, //혜택 유형
            { name:'campaignTargetCount',		index:'tgt.CAM_TGT_CNT', width:'150px', resizable : false }, //고객수
            { name:'campaignStatusCodeName',	index:'c2.MARK_NAME', width:'150px', resizable : false }, //진행상태 
            
            { name:'campaignTypeCode',			hidden : true, index:'c8.CODE_NAME' },
            { name:'id',						hidden : true, index:'c.id' },
            { name:'campaignStartDate',			hidden : true, index:'c.CAM_START_DD' },
            { name:'campaignEndDate',			hidden : true, index:'c.CAM_END_DD' }
        ],
        sortname: 'c.create_date',
        sortorder: "desc",
        radio: true,
        //tempId : 'ifvGridOriginTemplete'
    };
    campaignListGrid = $("#campaignListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function setPeriod(cellvalue, options, rowObject) {
	return rowObject.campaignStartDate + ' ~ ' + rowObject.campaignEndDate;
}

//버튼 활성 설정
function setBtnActive(type) {
	
	//작업중
	if (type == "W") {
		$("#campaignCompletedBtn").removeAttr('disabled');
		$("#campaignRemoveBtn").removeAttr('disabled');
		$("#campaignStopBtn").attr('disabled',true);
	}
	
	//활성
	else if (type == "A") {
		$("#campaignCompletedBtn").attr('disabled', true);
		$("#campaignRemoveBtn").attr('disabled', true);
		$("#campaignStopBtn").removeAttr('disabled');
	}
	
	//그외
	else {
		$("#campaignCompletedBtn").attr('disabled',true);
		$("#campaignRemoveBtn").attr('disabled',true);
		$("#campaignStopBtn").attr('disabled',true);
	}
}

//캠페인 중지
function setCampaignStop() {
	
    var dataList = campaignListGrid.getCheckedList();
    if (dataList.length == 1) {
        var data = dataList[0];
        var id = data.id;
        var camStatusCd = data.campaignStatusCode;

        // 페이스북 및 인스타그램 채널 노드 확인 및 포스팅 삭제 확인
        fbChk = false;
        instaChk = false;
        delChk = false;

        // 페이스북 노드 체크
        $.ifvSyncPostJSON('<ifvm:action name="getCampaignWorkflowStatusList"/>', {
            campaignId : id
        }, function(result) {
            for (var x = 0; x < result.length; x++) {
                if (result[x].nodeTypeCode == "FACEBOOK") {
                    fbChk = true;
                }
                else if (result[x].nodeTypeCode == "INSTAGRAM") {
                    instaChk = true;
                }
            }
        });

        // 캠페인 활성여부 확인
        if (fbChk == false && instaChk == false && camStatusCd == "A") {
            if (confirm('<spring:message code="M02155" />')) {
            	$.ifvProgressControl(true);
                $.ifvPostJSON('<ifvm:action name="setCampaignStop"/>', {
                    id : id
                }, function(result) {
                    alert('<spring:message code="M00152" />');
                    getCampaignList();
                    $.ifvProgressControl(false);
                }, function(result) {
                    alert("<spring:message code='I00742' />");
                    $.ifvProgressControl(false);
                });
            }
        }
        else if (fbChk == true && camStatusCd == "A") {
            if (confirm('<spring:message code="M02191"/>')) {
                // 페이스북 포스팅 삭제
                FBDeleting(id);
            }
        }
        else if (instaChk == true && camStatusCd == "A") {
            if (confirm('<spring:message code="M02232"/>')) {
                $.ifvSyncPostJSON('<ifvm:action name="setCampaignStop"/>', {
                    id : id
                }, function(result) {
                    alert('<spring:message code="M00152" />');
                    getCampaignList();
                }, function(result) {
                    alert("<spring:message code='I00742' />");
                });
            }
        }
        else {
            alert("<spring:message code='M02156' />");
        }
    }
    else {
        alert("<spring:message code='M01018' />");
    }
}

// 공통 조회 조건 목록 설정
function campaignListSearchInit() {
    $.fn.ifvmSetCommonCondList("campaignSearchList", "STNCAM001");
}

// 공통 조회 호출
function campaignListSearch() {
    $.fn.ifvmSubmitSearchCondition("campaignSearchList", getCampaignList);
}

/**
 * 캠페인 삭제
 * 
 * @date 2017. 11. 29.
 * @author jh.kim
 */
function setCampaignRemove() {
    var dataList = campaignListGrid.getCheckedList();
    if (dataList.length != 0) {
        
        var data = dataList[0];
        var id = data.id;
        var campaignStatusCode = data.campaignStatusCode;
        
        if (campaignStatusCode == 'W') {
            
            //캠페인 삭제 하시겠습니까?
            if (confirm('<spring:message code="M02305" />')) {
            	$.ifvProgressControl(true);
                $.ifvPostJSON('<ifvm:action name="deleteChargingStationCampaign"/>', {
                    id : id,
                    campaignStatusCode : campaignStatusCode
                }, function(result) {
                	if(result.success) {
	                    alert('<spring:message code="L00034" />');
	                    $.ifvProgressControl(false);
                	} else {
                		alert(result.message);
                		$.ifvProgressControl(false);
                	}
                	
	                getCampaignList();
                });
            }
        }
        else {
            //해당 캠페인은 삭제 가능한 상태가 아닙니다.
            alert('<spring:message code="M02306" />');
        }
    }
    else {
        //목록을 선택해주세요.
        alert("<spring:message code='M01018' />");
    }
}

//충전소캠페인 활성
function executeChargingStationCampaign(){
    var dataList = campaignListGrid.getCheckedList();
    var camChk = true;
	
    if (dataList.length != 0) {
        var data = dataList[0];
        var id = data.id;
        var camStatusCd = data.campaignStatusCode;
    
        // 캠페인 작성중 여부 확인
        if (camStatusCd == "W") {
            if (confirm('<spring:message code="M00753" />')) {
                
                // 외부고객 / PUSH 인경우 기획완료 처리 안됨
                $.ifvSyncPostJSON('<ifvm:action name="getTgtChnlChk"/>', {
                    id : id
                }, function(result) {
                    for (var i = 0 ; i < result.chnlTypeCdList.length ; i++) {
                        if (result.exeChnlTypeCd == "external" && result.chnlTypeCdList[i] == "PUSH") {
                            alert('<spring:message code="M01851" />');
                            camChk = false;
                            break;
                        }
                        else {
                            camChk = true;
                        }
                    }
                });
    
                if (camChk == true) {
                    // 장용 - 캠페인 상태 체크
                    $.ifvSyncPostJSON('<ifvm:action name="setCampaignComplete"/>', {
                        id : id
                    }, function(result) {


                        
                        if (result.message == '1') {
                            //오퍼유형이 [모바일 쿠폰]인 경우에는 전송 채널 중에 MMS만 연결이 가능합니다. [기획완료 및 실행]를 진행 할 수 없습니다.
                            alert("<spring:message code='M01386' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '2' || result.message == '13') {
                            //캠페인 승인이 완료되지 않았습니다. [기획완료 및 실행]를 진행 할 수 없습니다.
                            alert("<spring:message code='M01387' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '3') {
                            //선택한 캠페인에 연결된 노드가 있으나, 등록된 정보가 없어 캠페인 기획완료를 진행 할 수 없습니다. 해당 노드를 삭제하거나, 노드의 정보를 저장 후 진행 바랍니다.
                            alert("<spring:message code='M01392' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '4' || result.message == '5') {
                            //해당 캠페인은 일정을 등록해야 실행 할 수 있습니다.
                            alert("<spring:message code='M01786' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '6') {
                            //해당 캠페인은 일정을 등록할 수 없습니다. 
                            alert("<spring:message code='M02479' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '7') {
                            //해당 캠페인은 선행 캠페인을 등록해야 실행 할 수 있습니다. 
                            alert("<spring:message code='M02480' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '8' || result.message == '10') {
                            //해당 캠페인은 오퍼를 등록해야 실행할 수 있습니다.
                            alert("<spring:message code='M02478' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '9') {
                            //해당 캠페인은 프로모션 상세 정보를 등록해야 실행할 수 있습니다.
                            alert("<spring:message code='M02481' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '11') {
                            //해당 캠페인은 대상자를 등록해야 실행할 수 있습니다.
                            alert("<spring:message code='M02482' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '12') {
                            //해당 캠페인은 대상자를 등록할 수 없습니다.
                            alert("<spring:message code='M02483' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '98') {
                            //실행권환이 없습니다.
                            alert("<spring:message code='M02497' />");
                            $.ifvProgressControl(false);
                        }
                        else if (result.message == '99') {
                            //캠페인 상태가 작성중인 경우에만 활성이 가능합니다.
                            alert("<spring:message code='M02157' />");
                            $.ifvProgressControl(false);
                        }
                        else {
                            //저장되었습니다.
                            alert('<spring:message code="M00152" />');
                            getCampaignList();
                            $(".campaign_order").empty();
                            $.ifvProgressControl(false);
                        }
                    }
                    , function(result) {
                    	if (result.message == '97') {
                    		alert('<spring:message code="M02768" />');
                            $.ifvProgressControl(false);
                        }
                    });
                }
                else {
                    $.ifvProgressControl(false);
                }
            }
            else {
                $.ifvProgressControl(false);
            }
        }
    }
}

function initCampaign(getType) {
    strType = getType;
    
    getCampaignList();

    // 공통 조회 조건 목록 설정
    campaignListSearchInit();

    // 조회
    $('#campaignListSearchBtn').on('click', function() {
        campaignListSearch();
    });

    // 초기화
    $("#campaignListSearchInitBtn").on('click', function() {
        campaignListSearchInit();
    });

    // 신규 클릭시
    $('#campaignNewBtn').on('click', function() {
			qtjs.href('<ifvm:url name="stnCampaignDetail"/>');
    });

    // 캠페인 삭제
    $('#campaignRemoveBtn').on('click', function() {
        setCampaignRemove();
    });

    // 캠페인 중지
    $('#campaignStopBtn').on('click', function() {
        setCampaignStop();
    });

    // 캠페인 활성
    $('#campaignCompletedBtn').on('click', function() {
    	executeChargingStationCampaign();
    });
    
    //조회조건 enter 이벤트 시 자동조회
	$('input[type="text"]').keyup(function(e) {
		if (e.keyCode == 13) {
			$("#campaignListSearchBtn").trigger('click');
		}
	});
}



$(document).ready(function() {
	initCampaign("STN");
});

</script>

<script id="campaignStatusTemp" type="text/x-jquery-tmpl">
<li class="campaign_circle ${'${'}dataInTypeClass}" >
    <div class="circle_area" taskTypeCode="${'${'}taskTypeCode}">
        <span>${'${'}nodeTypeCodeName}</span>
    </div>
    <p class="campaign_title">${'${'}text}</p>
    <p class="complete_date">${'${'}enterTime}</p>
</li>
</script>

<script id="campaignStatusStartTemp" type="text/x-jquery-templ">
<li class="btn_edge first">
    <i class="start"></i>
    <span><spring:message code="M00742" /></span>
</li>
</script>

<script id="campaignStatusEndTemp" type="text/x-jquery-templ">
<li class="btn_edge">
    <i class="end"></i>
    <span><spring:message code="M00750" /></span>
</li>
</script>


<div class="page-title">
    <h1>
        <spring:message code="S00001" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00276" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignListSearchBtn">
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="campaignListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="campaignSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignNewBtn"><%-- 신규 --%>
                <spring:message code="M00274" />
            </button>
            <button class="btn btn-sm" id='campaignRemoveBtn'><%-- 삭제 --%>
                <spring:message code="M00165" />
            </button>
            <button class="btn btn-sm" id='campaignStopBtn'><%-- 중지 --%>
                <spring:message code="M02154" />
            </button> 
            <button class="btn btn-sm" id='campaignCompletedBtn'><%-- 활성 --%>
                <spring:message code="L00430" />
            </button>
        </div>
    </div>
    <div id="campaignListGrid" class="white_bg grid_bd0"></div>     
</div>

<div id="dialog" class="popup_container"></div>
<div id="dialogTempPop"></div>