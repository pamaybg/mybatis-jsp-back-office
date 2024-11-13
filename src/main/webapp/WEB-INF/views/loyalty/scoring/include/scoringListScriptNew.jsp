<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="ynTemplate">
	{{if promYn == 1 }}
		Y
	{{else}}
		N
	{{/if}}
</script>

<script>

var strType = '';

var scoringListGrid = null;
var cDialog;
var selectChk = false;

var campaign = {
    id: "",
    selRow: ""
};

//노드 체크 변수
var fbChk = false;
var instaChk = false;
var offerChk = false;
var targetChk = false;
var scheduleChk = false;
var delChk = false;
//페이스북 포스팅을 위한 appId
var appId = "";

/**
 * 이벤트트리거 scorign 목록 조회
 */
function getScoringList() {
    
    var ejGridOption = {
        rowSelected : function (args) {
            selectChk = true;
            /*
            if (args.data.campaignTypeCode == 'QUICK') {
                //진행현황 비활성
                $(".campaign_order").html("");
                //실행버튼 비활성
                $("#scoringRunBtn").hide();
            }
            else if (args.data.type == 'STN') {
                //진행현황 비활성
                $(".campaign_order").html("");
            }
            else {
                //실행버튼 활성
                $("#scoringRunBtn").show();
                
                //버튼 활성 설정
                setBtnActive(args.data.campaignStatusCode);
                
                //진행현황 활성
                getCampaignStatusList(args.data.id);
            }
            */
            
            //버튼 활성 설정
            setBtnActive(args.data.scrStatusCd);
            
            //진행현황 활성
//             getScoringStatusList(args.data.id);
            
            getAppIdAndInitSDK(args.data.id);
        },
        recordDoubleClick : function (args) {
            var data = args.data;
            scoringWorkflow(data.id);
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            if ($.fn.ifvmIsNotEmpty(strType)) {
                data.type = strType;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getScoringList"/>',
        columns:[ 
        	{
	      		  field : 'dispNo', headerText : '<spring:message code="L02201"/>', headerTextAlign : 'center', width : '90px' ,
	      		  customAttributes : {
	      			  index : 'esm.DISP_NO' }/*관리번호 */
	      	  },{
	      		  field : 'scrNm', headerText : '<spring:message code="L02202"/>', headerTextAlign : 'center', width : '220px' ,
	      		  customAttributes : {
	      			  index : 'esm.SCR_NM' }/*지수명 */
	      	  },{
	      		  field : 'scrTypeCdMarkName', headerText : '<spring:message code="L02203"/>', headerTextAlign : 'center', width : '80px' ,
	      		  customAttributes : {
	      			  index : 'c2.mark_name' }/*유형 */
	      	  },{
	      		  field : 'scrStatusCdMarkName', headerText : '<spring:message code="L02204"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'c1.mark_name' }/* 상태*/
	      	  },{
	      		  field : 'scrStartDd', headerText : '<spring:message code="L02205"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'esm.SCR_START_DD' }/*시작일 */
	      	  },{
	      		  field : 'scrEndDd', headerText : '<spring:message code="L02206"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'esm.SCR_END_DD' }/* 종료일*/
	      	  },{
	      		  field : 'execTypeMarkName', headerText : '<spring:message code="L02207"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'c3.mark_name' }/* 실행주기*/
	      	  },{
	      		  field : 'createDate', headerText : '<spring:message code="L02208"/>', headerTextAlign : 'center',width : '80px' ,
	      		  customAttributes : {
	      			  index : 'esm.CREATE_DATE' }/*등록일*/
	      	  },{
	      		  field : 'id', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			searchable : false,
	      			  index : 'esm.ID' }/* */
	      	  },{
	      		  field : 'scrStatusCd', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			searchable : false,
	      			  index : 'esm.SCR_STATUS_CD' }/* */
	      	  },{
	      		  field : 'scrApprovalStatusCd', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			searchable : false,
	      			  index : 'c7.CODE_NAME' }/* */
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'esm.CREATE_DATE',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
        //tempId : 'ifvGridOriginTemplete'
    };
    scoringListGrid = $("#scoringListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    
    if (campaign.selRow != "") {
        $("#gridIdscoringListGrid").setSelection(campaign.selRow, true);
        campaign.selRow = "";
    }
}

/**
 * 버튼 활성 설정
 * 삭제 / 중지 / 실행
 */
function setBtnActive(type) {
	
	//작업중
	if (type == "W") {
		$("#scoringCompletedBtn").removeAttr('disabled');
		$("#scoringRemoveBtn").removeAttr('disabled');
		$("#scoringStopBtn").attr('disabled',true);
	}
	
	//활성
	else if (type == "A") {
		$("#scoringCompletedBtn").attr('disabled', true);
		$("#scoringRemoveBtn").attr('disabled', true);
		$("#scoringStopBtn").removeAttr('disabled');
	}
	
	//그외
	else {
		$("#scoringCompletedBtn").attr('disabled',true);
		$("#scoringRemoveBtn").attr('disabled',true);
		$("#scoringStopBtn").attr('disabled',true);
	}
}

/**
 * 이벤트트리거 scoring 진행현황 목록
 */
function getScoringStatusList(id) {
    $.ifvPostJSON('<ifvm:action name="getCampaignWorkflowStatusList"/>', {
        campaignId : id
    }, function(result) {
        // 캠페인 진행상태 표시
        $.each(result, function(index, data) {
            if ($.fn.ifvmIsNotEmpty(data.enterTime)) {
                data.dataInTypeClass = "btn_complete";
            }
            else {
                data.dataInTypeClass = "btn_incomplete";
            }
            if ($.fn.ifvmIsNotEmpty(data.enterTime)) {
                data.enterTime = $.fn.ifvmGetCalculateTime(data.enterTime);
            }
        });
        var temp = '';

        // 초기화
        $(".campaign_order").empty();
        // start temp
        temp = $("#campaignStatusStartTemp").tmpl();
        $(".campaign_order").append(temp);
        // status temp
        var temp = $("#campaignStatusTemp").tmpl(result);
        $(".campaign_order").append(temp);
        // end temp
        temp = $("#campaignStatusEndTemp").tmpl();
        $(".campaign_order").append(temp);

    });
}

/**
 * 이벤트트리거 scoring 워크플로우 화면 이동
 */
function scoringWorkflow(id) {
    var url = '<ifvm:url name="scoringWorkFlow"/>?type=' + strType;
    if (id != null) {
        url = url + '&id=' + id;
    }
    qtjs.href(url);
};

/**
 * 이벤트트리거 scoring 중지
 */
function setScoringStop() {
    var dataList = scoringListGrid.opt.gridControl.getSelectedRecords();
    if (dataList.length != 0) {
        var data = dataList[0];
        var id = data.id;
        var camStatusCd = data.scrStatusCd;

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
                $.ifvSyncPostJSON('<ifvm:action name="editScoringStatus"/>', {
                	scrId : id
                    , scrStatusCd : 'S' //중지 요청
                }, function(result) {
            	
                	switch(result.message) {
	                case '3':
	            		//선택한 지수 관리에 연결된 노드가 있으나, 등록된 정보가 없어 지수 관리 활성을 진행 할 수 없습니다. 해당 노드를 삭제하거나, 노드의 정보를 저장 후 진행 바랍니다.
	                    alert("<spring:message code='L02243' />");
	                    $.ifvProgressControl(false);
	            		break;
	            	case '6':
	            		//지수 관리는 실행유형을 선택해야 활성 할 수 있습니다.
	                    alert("<spring:message code='L02244' />");
	                    $.ifvProgressControl(false);
	            		break;
	            	case '7':
	            		//지수 관리는 실행유형을 선택해야 결재 상신 할 수 있습니다.
	                    alert("<spring:message code='L02245' />");
	                    $.ifvProgressControl(false);
	            		break;
	            	case '12':
	            		//전자결재 승인이 완료되지 않아 활성을 진행할 수 없습니다. 전자결재 완료 후 진행 바랍니다.
	                    alert("<spring:message code='L02246' />");
	                    $.ifvProgressControl(false);
	            		break;
	            	case '13':
	            		//선택한 지수 관리에 연결된 노드가 있으나, 등록된 정보가 없어 결재 상신을 진행 할 수 없습니다. 해당 노드를 삭제하거나, 노드의 정보를 저장 후 진행 바랍니다.
	                    alert("<spring:message code='L02247' />");
	                    $.ifvProgressControl(false);
	            		break;
	            	case '80':
	            		//지수관리 상태가 작성중인 경우에만 활성이 가능합니다.
	                    alert("<spring:message code='L02248' />");
	                    $.ifvProgressControl(false);
	            		break;
	            	case '81':
	            		//지수관리 상태가 활성인 경우에만 중단이 가능합니다.
	                    alert("<spring:message code='L02249' />");
	                    $.ifvProgressControl(false);
	            		break;
	            	default : 
	            		//저장되었습니다.
	            		alert("<spring:message code='L00151' />");
	                    getScoringList();
                    	$(".campaign_order").empty();
	            		break;
                	}
                }, function(result) {
                    alert("<spring:message code='I00742' />");
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
                    getScoringList();
                    $(".campaign_order").empty();
                }, function(result) {
                    alert("<spring:message code='I00742' />");
                });
            }
        }
        else {
            alert("<spring:message code='L02249' />");
        }
    }
    else {
        alert("<spring:message code='M01018' />");
    }

    $.ifvProgressControl(false);
}

//페이스북 노드 체크, 있을 시 : 포스팅 -> 캠페인 활성화 / 없을 시 : 캠페인 활성화
function nodeCheck() {
    $.ifvProgressControl(true);
    var dataList = scoringListGrid.opt.gridControl.getSelectedRecords();
    var camChk = true;
    fbChk = false;
    instaChk = false;
    // 정보 노드가 존재하는가?
    var infoChk = false;

    if (dataList.length != 0) {
        var data = dataList[0];
        var id = data.id;
        var camStatusCd = data.campaignStatusCode;

        // 페이스북/인스타그램 채널이 포함된 캠페인 기획완료 시, 노드 체크
        $.ifvSyncPostJSON('<ifvm:action name="getCampaignWorkflowStatusList"/>', {
            campaignId : id
        }, function(result) {
            for (var x = 0; x < result.length; x++) {
                if (result[x].nodeTypeCode == "INFO") {
                    infoChk = true;
                }
                else if (result[x].nodeTypeCode == "FACEBOOK") {
                    fbChk = true;
                }
                else if (result[x].nodeTypeCode == "OFFER") {
                    offerChk = true;
                }
                else if (result[x].nodeTypeCode == "TARGET") {
                    targetChk = true;
                }
                else if (result[x].nodeTypeCode == "SCHEDULE") {
                    scheduleChk = true;
                }
                else if (result[x].nodeTypeCode == "INSTAGRAM") {
                    instaChk = true;
                }
            }
        });

        if (infoChk == false) {
            camStatusCd = "N/A";
        }
        else if (fbChk == true && offerChk == true) {
            camStatusCd = "N/A";
        }
        else if (fbChk == true && targetChk == true) {
            camStatusCd = "N/A";
        }
        else if (fbChk == true && scheduleChk == true) {
            camStatusCd = "N/A";
        }

        if (infoChk == false && data.type != "STN") { // 캠페인 노드 정보가 존재하지 않음. = 잘못 저장된 캠페인
            //캠페인 정보가 존재하지 않습니다
            alert("<spring:message code='M02242'/>");
            $.ifvProgressControl(false);
        }
        // 페이스북 포스팅
        else if (fbChk == true && camStatusCd == "W") {
            FBPosting(camStatusCd, id);
        }
        //이벤트트리거 scoring 실행
        else if ((fbChk == false && instaChk == false && camStatusCd == "W") || data.type == "STN") {
            setScoringCompleted(offerChk);
        }
        // 인스타그램 포스팅
        else if (instaChk = true && camStatusCd == "W") {
            instagramPosting(camStatusCd, id);
        }
        else if (fbChk == true && offerChk == true) {
            alert("<spring:message code='M02186'/>");
            $.ifvProgressControl(false);
        }
        else if (fbChk == true && targetChk == true) {
            alert("<spring:message code='M02187'/>");
            $.ifvProgressControl(false);
        }
        else if (fbChk == true && scheduleChk == true) {
            alert("<spring:message code='M02188'/>");
            $.ifvProgressControl(false);
        }
        else {
            //캠페인 상태가 작성중인 경우에만 활성이 가능합니다.
            alert('<spring:message code="M02157"/>');
            $.ifvProgressControl(false);
        }
    }
    else {
        //항목을 선택해주세요.
        alert("<spring:message code='M00499' />");
        $.ifvProgressControl(false);
    }
}

function getAppIdAndInitSDK(id) {
    appId = "";
    
    $.ifvSyncPostJSON('<ifvm:action name="getConidByCamid"/>', {
        camid : id
    }, function(getResult) {

        var len = getResult == null ? 0 : getResult.length;
        for (var z = 0 ; z < len ; z++) {
            var result = getResult[z];
            if (result.chnlTypeCd == 'FACEBOOK') {
                
                conid = result.conid;
                $.ifvSyncPostJSON('<ifvm:action name="getFacebookDtlList"/>', {
                    id : conid
                }, function(result2) {
                    if (result2 != null) {
                        $.ifvSyncPostJSON('<ifvm:action name="getFacebookPageInfoById"/>', {
                            fbId : result2.snsInfo
                        }, function(result3) {
                            if (result3 != null) {
                                appId = result3.appId;
                                initSDK(appId);
                            }
                        });
                    }
                });
            }
        }
    });
}

/**
 * 이벤트트리거 scoring 실행
 */
function setScoringCompleted(_offerChk) {
    var dataList = scoringListGrid.opt.gridControl.getSelectedRecords();
    var camChk = true;
    
    if (dataList.length != 0) {
        var data = dataList[0];
        var id = data.id;
        var camStatusCd = data.scrStatusCd;
    
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
                    $.ifvSyncPostJSON('<ifvm:action name="editScoringStatus"/>', {
                        scrId : id
                        , scrStatusCd : 'A' //활성 요청
                        , useApproval : true //지수관리 전자결재승인여부 체크 제외
                    }, function(result) {
                    	switch(result.message) {
    	                case '3':
    	            		//선택한 지수 관리에 연결된 노드가 있으나, 등록된 정보가 없어 지수 관리 활성을 진행 할 수 없습니다. 해당 노드를 삭제하거나, 노드의 정보를 저장 후 진행 바랍니다.
    	                    alert("<spring:message code='L02243' />");
    	                    $.ifvProgressControl(false);
    	            		break;
    	            	case '6':
    	            		//지수 관리는 실행유형을 선택해야 활성 할 수 있습니다.
    	                    alert("<spring:message code='L02244' />");
    	                    $.ifvProgressControl(false);
    	            		break;
    	            	case '7':
    	            		//지수 관리는 실행유형을 선택해야 결재 상신 할 수 있습니다.
    	                    alert("<spring:message code='L02245' />");
    	                    $.ifvProgressControl(false);
    	            		break;
    	            	case '12':
    	            		//전자결재 승인이 완료되지 않아 활성을 진행할 수 없습니다. 전자결재 완료 후 진행 바랍니다.
    	                    alert("<spring:message code='L02246' />");
    	                    $.ifvProgressControl(false);
    	            		break;
    	            	case '13':
    	            		//선택한 지수 관리에 연결된 노드가 있으나, 등록된 정보가 없어 결재 상신을 진행 할 수 없습니다. 해당 노드를 삭제하거나, 노드의 정보를 저장 후 진행 바랍니다.
    	                    alert("<spring:message code='L02247' />");
    	                    $.ifvProgressControl(false);
    	            		break;
    	            	case '80':
    	            		//지수관리 상태가 작성중인 경우에만 활성이 가능합니다.
    	                    alert("<spring:message code='L02248' />");
    	                    $.ifvProgressControl(false);
    	            		break;
    	            	case '81':
    	            		//지수관리 상태가 활성인 경우에만 중단이 가능합니다.
    	                    alert("<spring:message code='L02249' />");
    	                    $.ifvProgressControl(false);
    	            		break;
    	            	default : 
    	            		//저장되었습니다.
    	            		alert("<spring:message code='L00151' />");
                            getScoringList();
                            $(".campaign_order").empty();
                            $.ifvProgressControl(false);
                            break;
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

//페이스북 포스팅 삭제
function FBDeleting(id) {
    var acesToken = "";
    var postId = "";

    /*
     * $.ifvSyncPostJSON('<ifvm:action name="getFacebookDefaultInfo"/>', { camid : id }, function(result){
     * acesToken = result.acesToken; postId = result.postId;
     * //해당 포스팅을 삭제 처리 FB.api("/"+postId,"DELETE", { "access_token" : acesToken },function(response){ if(response && !response.error){
     * alert('<spring:message code="M02189"/>'); delChk == true; if(confirm('<spring:message code="M02155"/>')){
     * $.ifvSyncPostJSON('<ifvm:action name="setCampaignStop"/>', { id: id }, function(result) { alert('<spring:message code="M00152"/>'); getScoringList(); $(".campaign_order").empty(); }, function(result) { alert( "<spring:message code='I00742'/>" ); }); } }else{ alert('<spring:message code="M02190"/>'); } $.ifvProgressControl(false); }); });
     */

    // camid로 conid 조회 -> 변수 세팅
    $.ifvSyncPostJSON('<ifvm:action name="getConidByCamid"/>', {
        camid : id
    }, function(getResult) {
        var len = getResult == null ? 0 : getResult.length;
        for (var z = 0 ; z < len ; z++) {
            var result = getResult[z];
            if (result.chnlTypeCd == 'FACEBOOK') {
                conid = result.conid;
                $.ifvSyncPostJSON('<ifvm:action name="getFacebookDtlList"/>', {
                    id : conid
                }, function(result2) {

                    $.ifvSyncPostJSON('<ifvm:action name="getFacebookPageInfoById"/>', {
                        fbId : result2.snsInfo
                    }, function(result3) {
                        acesToken = result3.acesToken;
                    });
                    postId = result2.postId;

                    // 해당 포스팅을 삭제 처리
                    FB.api("/" + postId, "DELETE", {
                        "access_token" : acesToken
                    }, function(response) {
                        if (response && !response.error) {

                            alert('<spring:message code="M02189"/>');
                            delChk == true;
                            if (confirm('<spring:message code="M02155"/>')) {

                                $.ifvSyncPostJSON('<ifvm:action name="setCampaignStop"/>', {
                                    id : id
                                }, function(result) {
                                    alert('<spring:message code="M00152"/>');
                                    getScoringList();
                                    $(".campaign_order").empty();
                                }, function(result) {
                                    alert("<spring:message code='I00742'/>");
                                });
                            }

                        }
                        else {
                            alert('<spring:message code="M02190"/>');
                        }
                        $.ifvProgressControl(false);
                    });
                });
            }
        }
    });
}

//기획완료 버튼 클릭 시, 페이스북 포스팅
function FBPosting(camStatusCd, id) {
    var snsPageId = "";
    var appId = "";
    var appSecurCode = "";
    var acesToken = "";
    var acesExpDt = "";
    var contents = "";
    var openRange = "";
    var reservePost = "";
    var attType = "";
    var fileUrl = "";

    var numOfImages = "";
    var imageInfo = new Array();
    var imageInfoId = new Array();
    var postId = "";
    var conid = "";

    // camid로 conid 조회 -> 변수 세팅
    $.ifvSyncPostJSON('<ifvm:action name="getConidByCamid"/>', {
        camid : id
    }, function(getResult) {

        var len = getResult == null ? 0 : getResult.length;
        for (var z = 0 ; z < len ; z++) {
            var result = getResult[z];
            if (result.chnlTypeCd == 'FACEBOOK') {

                conid = result.conid;
                $.ifvSyncPostJSON('<ifvm:action name="getFacebookDtlList"/>', {
                    id : conid
                }, function(result2) {
                    $.ifvSyncPostJSON('<ifvm:action name="getFacebookPageInfoById"/>', {
                        fbId : result2.snsInfo
                    }, function(result3) {
                        snsPageId = result3.snsPageId;
                        appId = result3.appId;
                        appSecurCode = result3.appSecurCode;
                        acesToken = result3.acesToken;
                        acesExpDt = result3.acesExpDt;
                    });

                    contents = result2.contents;
                    openRange = result2.openRange;
                    reservePost = result2.reservePost;
                    attType = result2.attType;
                    fileUrl = '<%=com.icignal.common.util.CommonUtil.getInstance().getImageServerUrl()%>/' + result2.filePath + result2.fileName;

                    if (result2.imageUrl != '') {
                        numOfImages = result2.images.length;
                        for (var i = 0; i < numOfImages; i++) {
                            imageInfo[i] = result2.images[i].imgOrgUrl;
                        }
                    }
                    facebookPosting(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
                });
            }
        }
    });
}

// 팝업 닫기
function campaignTempPopClose() {
    $('#dialog').data('ejDialog')._destroy();
}

/**
 * 공통 조회 조건 목록 설정
 */
function scoringListSearchInit() {
    $.fn.ifvmSetCommonCondList("scoringSearchList", "PLOY_501");
}

/**
 * 공통 조회 호출
 */
function scoringListSearch() {
    $.fn.ifvmSubmitSearchCondition("scoringSearchList", getScoringList);
}

//기획완료 시, 인스타그램 포스팅
function instagramPosting(camStatusCd, id) {
    var snsPageId = "";
    var appId = "";
    var appSecurCode = "";
    var contents = "";
    var attType = "";
    var fileUrl = "";
    var numOfImages = "";
    var imageInfo = new Array();
    var postId = "";
    var conid = "";
    var imgFileName = new Array();
    var videoFileName = "";

    // camid로 conid 조회 -> 변수 세팅
    $.ifvSyncPostJSON('<ifvm:action name="getConidByCamid"/>', {
        camid : id
    }, function(getResult) {

        var len = getResult == null ? 0 : getResult.length;
        for (var z = 0 ; z < len ; z++) {
            var result = getResult[z];
            if (result.chnlTypeCd == 'INSTAGRAM') {

                conid = result.conid;
                $.ifvSyncPostJSON('<ifvm:action name="getInstagramDtlList"/>', {
                    id : conid
                }, function(result2) {
                    $.ifvSyncPostJSON('<ifvm:action name="getInstagramInfoById"/>', {
                        id : result2.snsInfo
                    }, function(result3) {
                        snsPageId = result3.snsPageId;
                        appId = result3.appId;
                        appSecurCode = result3.appSecurCode;
                    });

                    contents = result2.contents;
                    attType = result2.attType;
                    fileUrl = '<%=com.icignal.common.util.CommonUtil.getInstance().getImageServerUrl()%>/' + result2.filePath + result2.fileName;
                    videoFileName = result2.fileName;

                    if (result2.imageUrl != '') {
                        numOfImages = result2.images.length;
                        for (var i = 0; i < numOfImages; i++) {
                            imageInfo[i] = result2.images[i].imgOrgUrl;
                            imgFileName[i] = result2.images[i].imgFileName;
                        }
                    }

                    // 인스타그램 포스팅
                    if (attType == "IMAGE") {
                        $.ifvSyncPostJSON('<ifvm:action name="uploadImageToInsta"/>', {
                            username : appId,
                            password : appSecurCode,
                            imageInfo : imageInfo,
                            file : imgFileName,
                            contents : contents
                        }, function(result4) {
                            
                            if (result4.message == "0") {
                                alert('<spring:message code="M02223"/>');
                                $.ifvProgressControl(false);
                            }
                            else if (result4.message == "1") {
                                alert('<spring:message code="M02224"/>');
                                $.ifvProgressControl(false);
                            }
                            else if (result4.message == "2") {
                                alert('<spring:message code="M02225"/>');
                                $.ifvProgressControl(false);
                            }
                            else {
                                alert('<spring:message code="M02226"/>');

                                // 포스팅 이후, uploadId(result.message)를 데이터베이스에 저장
                                $.ifvSyncPostJSON('<ifvm:action name="setPostId"/>', {
                                    id : conid,
                                    postId : result4.message
                                }, function(result5) {
                                });

                                //이벤트트리거 scoring 실행
                                setScoringCompleted();
                            }
                        });
                    }
                    else if (attType == "VIDEO") {
                        $.ifvSyncPostJSON('<ifvm:action name="uploadVideoToInsta"/>', {
                            username : appId,
                            password : appSecurCode,
                            fileUrl : fileUrl,
                            file : videoFileName,
                            contents : contents
                        }, function(result4) {
                            
                            if (result4.message == "0") {
                                alert('<spring:message code="M02223"/>');
                                $.ifvProgressControl(false);
                            }
                            else if (result4.message == "1") {
                                alert('<spring:message code="M02224"/>');
                                $.ifvProgressControl(false);
                            }
                            else if (result4.message == "2") {
                                alert('<spring:message code="M02225"/>');
                                $.ifvProgressControl(false);
                            }
                            else {
                                alert('<spring:message code="M02226"/>');
                                //이벤트트리거 scoring 실행
                                setScoringCompleted();
                            }
                        });
                    }
                });
            }
        }
    });
}

/**
 * 캠페인 삭제
 * 
 * @date 2017. 11. 29.
 * @author jh.kim
 */
function setScoringRemove() {
    var dataList = scoringListGrid.opt.gridControl.getSelectedRecords();
    if (dataList.length != 0) {
        
        var data = dataList[0];
        var id = data.id;
        var scrStatusCd = data.scrStatusCd;
        var scrApprovalStatusCd = data.scrApprovalStatusCd;
        
        if (scrStatusCd == 'W' 
                && scrApprovalStatusCd != '010'
                && scrApprovalStatusCd != '090') {
            
            //선택한 지수 관리를 삭제하시겠습니까?
            if (confirm('<spring:message code="L02240" />')) {
                $.ifvSyncPostJSON('<ifvm:action name="removeScoring"/>', {
                    id: id,
                    scrStatusCd: scrStatusCd,
                    scrApprovalStatusCd: data.scrApprovalStatusCd
                }, function(result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        if (result.success == true) {
                            //삭제되었습니다.
                            alert('<spring:message code="L00034" />');
                            getScoringList();
                        }
                        else {
                            //해당 지수 관리는 삭제 가능한 상태가 아닙니다
                            alert('<spring:message code="L02241" />');
                        }
                        $(".campaign_order").empty();
                    }
                });
            }
        }
        else {
            //해당 지수 관리는 삭제 가능한 상태가 아닙니다
            alert('<spring:message code="L02241" />');
        }
    }
    else {
        //목록을 선택해주세요.
        alert("<spring:message code='M01018' />");
    }
}

function initCampaign(getType) {

    strType = getType;
    
    //이벤트트리거 scoring 목록 조회
    getScoringList();

    //공통 조회 조건 목록 설정
    scoringListSearchInit();

    //조회
    $('#scoringListSearchBtn').on('click', function() {
        scoringListSearch();
    });

    //초기화
    $("#scoringListSearchInitBtn").on('click', function() {
        scoringListSearchInit();
    });

    //신규 클릭시
    $('#scoringNewBtn').on('click', function() {
    	/*
        $("#dialog").ifvsfPopup({
            enableModal : true,
            enableResize : false,
            contentUrl : '<ifvm:url name="campaignTempPop"/>',
            contentType : "ajax",
            title : '<spring:message code="M00754" />',
            width : 825,
            close : 'campaignTempPopClose',
            open : function() {
                new ifvm.PopupCenter({
                    popupDivId : 'dialog'
                });
            }
        });
    	*/
    	//신규 캠페인 워크플로우
   	    var url = '<ifvm:url name="scoringWorkFlow"/>?type=SCR';
   	    qtjs.href(url);
    });

    //이벤트트리거 scoring 삭제
    $('#scoringRemoveBtn').on('click', function() {
        setScoringRemove();
    });

    //이벤트트리거 scoring 중지
    $('#scoringStopBtn').on('click', function() {
        $.ifvProgressControl(true);

        setTimeout(function() {
            setScoringStop();
        }, 1000);
    });

    //이벤트트리거 scoring 실행
    $('#scoringCompletedBtn').on('click', function() {
        $.ifvProgressControl(true);

        setTimeout(function() {
//             nodeCheck();
        	setScoringCompleted("");
        }, 1000);
    });

    //캠페인 진행사항 클릭시
    /*
    $('.circle_area').on('click', function(){
        var type = $(this).attr("tasktypecode");
        if (type == "INFO") {
            $("#dialog").ifvsfPopup({ 
                contentType: "ajax", 
                contentUrl: '<ifvm:url name="campaignInfoPop"/>',
                enableResize: false,
                enableModal: true,
                open : function(){
                    new ifvm.PopupHeight({
                        popupDivId : 'dialog',
                        contentsId : 'dialogPopupWrap'
                    });
                    new ifvm.PopupCenter({
                        popupDivId : 'dialog'
                    });
                }
            });
            
            cDialog = $("#dialog").data("ejDialog");
        }
    });
     */
}

</script>