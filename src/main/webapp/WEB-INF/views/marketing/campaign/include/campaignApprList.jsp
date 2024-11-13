<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
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

    var campaignListGrid = null;
    var selectChk = false;

    var doubleSubmitFlag = false;

    var campaign = {
        id: "",
        selRow: ""
    };

    //캠페인 목록
    function getCampaignList() {

        var ejGridOption = {
            rowSelected : function (args) {
                selectChk = true;
            },
            recordDoubleClick : function (args) {
                var data =args.data;
                if (data.campaignTypeCode == 'QUICK') {
                    $(".campaign_order").empty();
                    qtjs.href('<ifvm:url name="quickCampaign"/>' + '?id=' + data.id);
                }
                else if (data.type == 'STN') {
                    $(".campaign_order").empty();
                    qtjs.href('<ifvm:url name="stnCampaignDetail"/>' + '?id=' + data.id);
                }
                else{
                    goCampaignWorkflow(data.id);
                }

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
            dataUrl : '<ifvm:action name="getCampaignApprList"/>',
            columns:[
                {
                    //field : 'dispNo', headerText : '<spring:message code="L00417"/>', headerTextAlign : 'center', width : '90px' , textAlign : ej.TextAlign.Center ,
                    field : 'dispNo', headerText : '번호', headerTextAlign : 'center', width : '90px' , textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'c.DISP_NO' , searchable : true}/*캠폐인번호 */
                },{
                    field : 'campaignTypeCodeName', headerText : '<spring:message code="M00598"/>', headerTextAlign : 'center',width : '90px', textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'c8.MARK_NAME' }/*유형 */
                },{
                    field : 'campaignName', headerText : '<spring:message code="M00592"/>', headerTextAlign : 'center', width : '220px' ,
                    //field : 'campaignName', headerText : 'Rule', headerTextAlign : 'center', width : '220px' ,
                    customAttributes : {
                        index : 'c.CAM_NM' , searchable : true}/*캠폐인명 */
                },{
                    field : 'campaignStartDate', headerText : '<spring:message code="M00593"/>', headerTextAlign : 'center',width : '80px' , textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'c.CAM_START_DD' }/*시작일 */
                },{
                    field : 'campaignEndDate', headerText : '<spring:message code="M00594"/>', headerTextAlign : 'center',width : '80px' , textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'c.CAM_END_DD' }/* 종료일*/
                },{
                    field : 'chnlTypeCd', headerText : '<spring:message code="M00402"/>', headerTextAlign : 'center',width : '60px' , textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'mcc.chnl_type_cd' }/*발송채널*/
                },{
                    field : 'campaignTargetCount', headerText : '<spring:message code="M00746"/>', headerTextAlign : 'center',width : '60px' , textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'com.nvl(th.CAM_TGT_CNT, 0)' }/*대상자*/
                },{
                    field : 'campaignStatusCodeName', headerText : '<spring:message code="M00595"/>', headerTextAlign : 'center',width : '60px' , textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'c2.MARK_NAME' }/*상태*/
                },{
                    field : 'campaignApprovalStatusCodeName', headerText : '<spring:message code="M03042"/>', headerTextAlign : 'center',width : '60px' , textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'c9.MARK_NAME' }/*결재상태*/
                },{
                    field : 'planOrgCodeName', headerText : '<spring:message code="M00558"/>', headerTextAlign : 'center',width : '80px' , textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'd1.div_nm' }/*소속*/
                },
// 	      	  {
// 	      		  field : 'campaignApprovalStatusCodeName', headerText : '<spring:message code="M00974"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c9.MARK_NAME' }/*승인진행상태 */
// 	      	  },
// 	      	  {
// 	      		  field : 'camScopeTypeNm', headerText : '<spring:message code="M02304"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c10.MARK_NAME' }/*캠페인 범위 */
// 	      	  },
                {
                    field : 'campaignPlannerName', headerText : '<spring:message code="M00596"/>', headerTextAlign : 'center',width : '100px', textAlign : ej.TextAlign.Center ,
                    customAttributes : {
                        index : 'mo.NAME' }/*기획자 */
                },
// 	      	  {
// 	      		  field : 'planOrgCodeName', headerText : '<spring:message code="M00597"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'd1.div_nm' }/*부서 */
// 	      	  },
//	      	  {
//	      		  field : 'offerName', headerText : '<spring:message code="M01870"/>', headerTextAlign : 'center',width : '150px' ,
//	      		  customAttributes : {
//	      			  index : 'o.OFFER_NM' }/*오퍼 */
//	      	  },
// 	      	  {
// 	      		  field : 'description', headerText : '<spring:message code="M00600"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c.CAM_DESC' }/*비고 */
// 	      	  },
                {
                    field : 'campaignTypeCode', headerText : 'typeCode', visible : false ,
                    customAttributes : {
                        searchable : false,
                        index : 'c8.CODE_NAME' }/* */
                }
                ,{
                    field : 'id', headerText : 'id', visible : false ,
                    customAttributes : {
                        searchable : false,
                        index : 'c.id' }/* */
                },{
                    field : 'type', headerText : 'type', visible : false ,
                    customAttributes : {
                        searchable : false,
                        index : 'c.type' }/* */
                },{
                    field : 'campaignApprovalStatusCode', headerText : 'campaignApprovalStatusCode', visible : false ,
                    customAttributes : {
                        searchable : false,
                        index : 'c9.CODE_NAME' }/* */
                },
                {
                    field : 'seq', headerText : 'seq', visible : false , hidden : true ,
                    customAttributes : {
                        searchable : false,
                        index : 'h.elec_aprv_seq' }/* */
                },
                {
                    field : 'itemId', headerText : 'itemId', visible : false , hidden : true ,
                    customAttributes : {
                        searchable : false,
                        index : 'h.id' }/* */
                },
                {
                    field : 'aprvType', headerText : 'aprvType', visible : false , hidden : true ,
                    customAttributes : {
                        searchable : false,
                        index : 'ea.elec_aprv_type_cd' }/* */
                },
                {
                    field : 'recordRid', headerText : 'recordRid', visible : false , hidden : true ,
                    customAttributes : {
                        searchable : false,
                        index : 'ea.cam_id' }/* */
                },
                {
                    field : 'aprvId', headerText : 'aprvId', visible : false , hidden : true ,
                    customAttributes : {
                        searchable : false,
                        index : 'ea.id' }/* */
                },
                {
                    field : 'apvrTypeCd', headerText : 'apvrTypeCd', visible : false , hidden : true ,
                    customAttributes : {
                        searchable : false,
                        index : 'h.apvr_type_cd' }/* */
                },
            ],
            requestGridData : {
                nd   : new Date().getTime(),
                rows : 10,
                sidx : 'c.create_date',
                sord : 'desc',
                _search : false
            },
            rowList : [10,25,50,100],
            radio: true,
            tempId : 'ifvGridNotSearchTemplete'
        };
        campaignListGrid = $("#campaignListGrid").ifvsfGrid({ ejGridOption : ejGridOption });

        if (campaign.selRow != "") {
            $("#gridIdcampaignListGrid").setSelection(campaign.selRow, true);
            campaign.selRow = "";
        }
    }

    //캠페인 진행현황 목록
    function getCampaignStatusList(id) {
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

    //캠페인 워크플로우 화면 이동
    function goCampaignWorkflow(id) {
        var url = '<ifvm:url name="campaignWorkFlow"/>?type=' + strType;
        if (id != null) {
            url = url + '&id=' + id;
        }
        qtjs.href(url);
    };

    // 팝업 닫기
    function campaignTempPopClose() {
        dialog._destroy();
    }

    // 공통 조회 조건 목록 설정
    function campaignListSearchInit(gridId) {
        $.fn.ifvmSetCommonCondList("campaignSearchList", "MKTMNG001",gridId);
    }

    // 공통 조회 호출
    function campaignListSearch() {
        $.fn.ifvmSubmitSearchCondition("campaignSearchList", function(){
            campaignListGrid.searchGrid({item: requestitem});
        });
    }

    function gridDataSetFlag() {
        var cellValue
        if (cellValue == '1') return 'Y';
        else return 'N';
    }

    //타겟그룹 상세 조회
    function getTargetGroup() {
        var targetGroupId = targetGroup.targetGroupId;

        $.ifvProgressControl(true);

        $.ifvPostJSON('<ifvm:action name="getTargetGroup"/>', {
                targetGroupId: targetGroupId
            },
            function(result) {
                //타겟그룹 설정
                setTargetGroup(result);
                targetGroup.data = result;
            },
            function(result) {
                $.errorChecker(result);
                $.ifvProgressControl(false);
            });
    }

    function setTargetGroup(data) {
        $("#targetGroupName").val(data.targetGroupName);
        $("#targetGroupDesc").val(data.targetGroupDesc);
        $("#filterText").val(data.dpCond);

        //대상수 조회 오류 발생시 메시지
        if (data.targetCount == "MSG_T0001") {
            $.ifvErrorPop('<spring:message code="M01694"/>');
        } else {
            $("#targetCount").val(numberWithCommas(data.targetCount));
        }
    }

    //1000단위 정규식
    function numberWithCommas(x) {
        if ($.fn.ifvmIsNotEmpty(x)) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        else return 0;
    }

    function doubleSubmitCheck(){
        if(doubleSubmitFlag){
            return doubleSubmitFlag;
        }else{
            doubleSubmitFlag = true;
            return false;
        }
    }

    function Aprvcount(){

        $.ifvSyncPostJSON('<ifvm:action name="getMyAgreeCount"/>', {
        }, function(result) {
            $("#aprvReq2").text(result.aprvReq);
        });
    }


    // 승인
    function fnApprove() {

        if(doubleSubmitCheck()) return;

        var active = 0;
        var checkedList = campaignListGrid.opt.gridControl.getSelectedRecords();
        var listFlowIdList = [];
        var err = 0 ;
        var suc = 0;
        var msg = "";


        if (checkedList.length != 0) {

            for( var i = 0; i < checkedList.length; i++ ){

                if(checkedList[i].campaignApprovalStatusCodeName != '결재진행중'){
                    alert('결재 진행중이 아닙니다.');
                    break;
                } else{
                    // 상태값 코드 변경
                    $.ifvSyncPostJSON('<ifvm:action name="editReject"/>', {
                        apvDd : '1',
                        id : checkedList[i].aprvId,
                        statusCode : '090',
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
                        msg += " " + '<spring:message code="L02923"/>';
                        alert( msg );
                        campaignListGrid._doAjax();
                    },function(result) {
                        setTimeout(function(){
                            Aprvcount();
                        }, 100);
                    });


                    //최종 승인자일 때
/*                    if (checkedList[i].apvrTypeCd == '9') {

                        //결재 완료
                        $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>',{
                            elecAprvStatusCd : '090'
                            ,id : checkedList[i].aprvId
                            ,aprvType: checkedList[i].aprvType
                            ,recordRid : checkedList[i].recordRid
                        },function(result) {
                            setTimeout(function(){
                                Aprvcount();
                            }, 100);
                            msg += " " + '<spring:message code="승인에 실패했습니다."/>';
                            alert( msg );
                        });
                    }*/
                }

            }
            campaignListGrid.searchGrid({});
        }
        else{
            alert('<spring:message code="M00285"/>');
        }
        doubleSubmitFlag = false;
    };

    function fnReject(){

        var checkedList = campaignListGrid.opt.gridControl.getSelectedRecords();
        if(checkedList.length === 1) {
            rejectId = checkedList[0].aprvId;
        } else {
            rejectId = null;
        }

        if(rejectId == null){
            alert('<spring:message code="M00499"/>');
        }else{
            $("#approvalPopup").ifvsfPopup({
                enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="rejectPop"/>?id='+rejectId,
                contentType: "ajax",
                title: '<spring:message code="M00978"/>',
                width: '340px',
                close : 'approvalPopupClose'
            });
        }
    }

    function initCampaign(getType) {

        strType = getType;

        getCampaignList();

        // 공통 조회 조건 목록 설정
        campaignListSearchInit();

        // 조회
        $('#campaignSubmitListSearchBtn').on('click', function() {
            campaignListSearch();
        });

        // 초기화
        $("#campaignSubmitListSearchInitBtn").on('click', function() {
            campaignListSearchInit('campaignListGrid');
        });

        // 승인
        $('#campaignSubmitBtn').on('click', function(){
            fnApprove();
        });

        // 반려
        $("#campaignRejectBtn").on('click', function() {
            fnReject();
        });
    }

</script>