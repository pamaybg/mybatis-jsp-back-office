<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<style>

#timeContent { padding: 0px }
#timeContent input { padding-right: 35px }

</style>
<script type="text/javascript">

var ruleSetTab;
var offerListGrid;
var gridIdofferListGrid;
var ruleSetRefMap;
var promBasicValidation;

var ruleSetData = {
        ridMktCamMst: "",
        rulesetDtl: {},
        rulesetPrvBnfList: [],
        ruleSetLimitPathList: [],
        rulesetTran: {},
        rulesetMbr: {},
        rulesetSday: {},
        rulesetCondChnlList : [],
        rulesetCondProdList : [],
        rulesetCondOtherList : [],
        rulesetCondAmtList : [],
        rulesetPymntPolicyList : [],
        ruleSetMstList :[],
        ruleSetProdList :[],
        ruleSetLimitCardList :[],
 }

/**
 * 탭 설정
 */
function initTab() {

    ruleSetTab = $('#ruleSetTabArea').DrawTab({
        item: [
        //    {label: '<spring:message code="M02314"/>', href: '/loyalty/ruleSet/include/prvBnfTab'},
        	{label: '<spring:message code="L00160"/>', href: '/loyalty/ruleSet/include/grantedStandard'},
//             {label: '<spring:message code="L00161"/>', href: '/loyalty/ruleSet/include/targetProduct'},
            {label: '<spring:message code="L00162"/>', href: '/loyalty/ruleSet/include/destinationPath'}
//             {label: '<spring:message code="L00163"/>', href: '/loyalty/ruleSet/include/paymentStandard'}
        ]
    });
}

/**
 * 달력 설정
 */
function setValidCalendar() {
    //프로모션 시작&종료시간
    $('#promStartDate').ifvDateChecker({});
    $('#promEndDate').ifvDateChecker({});

    $('#promStartTime').timepicker({
        showMeridian: false,
        defaultTime: '00:00:00',
        showSeconds: true,
        minuteStep: 5,
        secondStep: 1,
    });
    $('#promEndTime').timepicker({
        showMeridian: false,
        defaultTime: '23:59:59',
        showSeconds: true,
        minuteStep: 5,
        secondStep: 1,
    });
}

/**
 * 시작일 종료일 체크
 */
function chkCalendarValidation() {
    var rtnFlag = true;

    var startDate = $("#promStartDate");
    var endDate = $("#promEndDate");

    var startTime = $("#promStartTime");
    var endTime = $("#promEndTime");

    startDate.removeClass('ifv_vali_wrong');
    startTime.removeClass('ifv_vali_wrong');
    endDate.removeClass('ifv_vali_wrong');
    endTime.removeClass('ifv_vali_wrong');

    var startDateTime = startDate.val() + ' ' + startTime.val();
    var endDateTime = endDate.val() + ' ' + endTime.val();

    //캠페인 시작일시보다 프로모션 시작일시가 이전일때
    if (startDate.val() < $("#campaignStartDate").val()) {
        validFailMessage(startDate, '<spring:message code="C00042"/>');
        rtnFlag = false;
    }
    //캠페인 종료일시보다 프로모션 종료일시가 이후일때
    else if (endDate.val() > $("#campaignEndDate").val()) {
        validFailMessage(endDate, '<spring:message code="C00043"/>');
        rtnFlag = false;
    }
    //프로모션 시작일시보다 종료일시가 더 이전일때
    else if (startDateTime > endDateTime) {
        if (startDate.val() == endDate.val()) {
            validFailMessage(startTime, '<spring:message code="C00042"/>');
        }
        else {
            validFailMessage(startDate, '<spring:message code="C00042"/>');
        }
        rtnFlag = false;
    }
    return rtnFlag;
}

function initRuleSetMainData() {

    $.ifvProgressControl(true);

  	//캠페인 유형
    $.fn.ifvmSetSelectOptionCommCode("campaignTypeCode", "MKT_CAM_TYPE_CD");

    // 캠페인 정보 조회
    getCampaignInfo();

    setTimeout(function() {

        //오퍼 조회
        getRuleSetOffer();

        //RuleSet 조회
        getRulsetInfo();

        //탭설정
        initTab();
        tabValidSetting();
        $.ifvProgressControl(false);
    }, 100);
}

/**
 * Ruleset 상세정보 조회
 */
function getRulsetInfo() {

    $.ifvSyncPostJSON('<ifvm:action name="getRuleSet"/>', {
        ridMktCamMst : ruleSetData.ridMktCamMst
    }, function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {

            ruleSetData = result;

            // ruleset
            if (result.rulesetDtl == null) {
                ruleSetData.rulesetDtl = {};
            }
            else {
                $('#rulesetId').val(ruleSetData.rulesetDtl.rid);

                $('#promTypeCd').val(ruleSetData.rulesetDtl.promTypeCd);
                $('#allianceTypeCd').val(ruleSetData.rulesetDtl.allianceTypeCd);
                $('#monthLmtPoint').val(ruleSetData.rulesetDtl.monthLmtPoint);
                $('#promOccTmscntCd').val(ruleSetData.rulesetDtl.promOccTmscntCd);
                $('#fstPrizeCnt').val(ruleSetData.rulesetDtl.fstPrizeCnt);
                $('#prizePeriod').val(ruleSetData.rulesetDtl.prizePeriod);
                $('#stepAscAmt').val(ruleSetData.rulesetDtl.stepAscAmt);
                $('#chitOtputSbst').val(ruleSetData.rulesetDtl.chitOtputSbst);
                $('#rulesetDesc').val(ruleSetData.rulesetDtl.rulesetDesc);
                $('#prirtTypeCd').val(ruleSetData.rulesetDtl.prirtTypeCd);
                if ($.fn.ifvmIsNotEmpty(ruleSetData.rulesetDtl.promStartDt)) {
                    $('#promStartDate').val(ruleSetData.rulesetDtl.promStartDt.split(' ')[0]);
                    $('#promStartTime').val(ruleSetData.rulesetDtl.promStartDt.split(' ')[1]);
                }
                if ($.fn.ifvmIsNotEmpty(ruleSetData.rulesetDtl.promEndDt)) {
                    $('#promEndDate').val(ruleSetData.rulesetDtl.promEndDt.split(' ')[0]);
                    $('#promEndTime').val(ruleSetData.rulesetDtl.promEndDt.split(' ')[1]);
                }
                if ($.fn.ifvmIsNotEmpty(ruleSetData.rulesetDtl.cnclDt)) {
                    $('#cnclDate').val(ruleSetData.rulesetDtl.cnclDt.split(' ')[0]);
                    $('#cnclTime').val(ruleSetData.rulesetDtl.cnclDt.split(' ')[1]);
                }

                $('input:radio[name=promCyclTypeCd]:input[value=' + ruleSetData.rulesetDtl.promCyclTypeCd + ']').attr("checked", true);
                $('input:radio[name=promCyclTypeCd]:input[value=' + ruleSetData.rulesetDtl.promCyclTypeCd + ']').change();
                $('#promCyclStartDd').val(ruleSetData.rulesetDtl.promCyclStartDd);
                $('#promCyclEndDd').val(ruleSetData.rulesetDtl.promCyclEndDd);
                $('input:radio[name=promTgtSendTypeCd]:input[value=' + ruleSetData.rulesetDtl.promTgtSendTypeCd + ']').attr("checked", true);
            }

            // 혜택수량
            if (result.rulesetPrvBnfList == null) {
                ruleSetData.rulesetPrvBnfList = [];
            }
            else {
                if (ruleSetData.rulesetPrvBnfList.length > 0) {
                    $('#prvBnfRid').val(ruleSetData.rulesetPrvBnfList[0].rid);
                    $('#acrlType').val(ruleSetData.rulesetPrvBnfList[0].acrlType);
                    $('#acrlAmt').val(ruleSetData.rulesetPrvBnfList[0].acrlAmt);
                }
            }
            // 구매채널
            if (result.ruleSetLimitPathList == null) {
                ruleSetData.ruleSetLimitPathList = [];
            }

            // 고객정보
            if (result.rulesetMbr == null) {
                ruleSetData.rulesetMbr = {};
            }

            // 거래정보
            if (result.rulesetTran == null) {
                ruleSetData.rulesetTran = {};
            }

            // 기념일
            if (result.rulesetSday == null) {
                ruleSetData.rulesetSday = {};
            }

        	//지급 정책
            if (result.rulesetPymntPolicyList == null) {
                ruleSetData.rulesetPymntPolicyList = [];
            }

            //조건 상품
            if (result.rulesetCondProdList == null) {
                ruleSetData.rulesetCondProdList = [];
            }

            //조건 채널
            if (result.rulesetCondChnlList == null) {
                ruleSetData.rulesetCondChnlList = [];
            }
            //조건 금액
            if (result.rulesetCondAmtList == null) {
                ruleSetData.rulesetCondAmtList = [];
            }


            //조건 기타
            if (result.rulesetCondOtherList == null) {
                ruleSetData.rulesetCondOtherList = [];
            }

            if (result.ruleSetMstList == null) {
                ruleSetData.ruleSetMstList = [];
            }

            if (result.ruleSetProdList == null) {
                ruleSetData.ruleSetProdList = [];
            }

            if (result.ruleSetLimitCardList == null) {
                ruleSetData.ruleSetLimitCardList = [];
            }



        }
    });
}

/**
 * 캠페인 정보 조회
 */
function getCampaignInfo() {

    //캠페인 아이디
    var id = '<%= cleanXss(request.getParameter("id")) %>';
    id = $.fn.ifvmIsEmpty(id) || id == "null" ? '' : id;

    ruleSetData.ridMktCamMst = id;

    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignDefaultInfo"/>', {
        id: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            $("#campaignName").val(result.campaignName);
            $("#campaignTypeCode").val(result.campaignTypeCode);

            $("#campaignStartDate").val(result.campaignStartDate);
            $("#campaignEndDate").val(result.campaignEndDate);

            $("#promStartDate").val(result.campaignStartDate);
            $("#promEndDate").val(result.campaignEndDate);

            //대상자 전송주기 설정
            if (result.campaignTypeCode != "TARGET") {
            	$('input:radio[name=promTgtSendTypeCd]:input[value=O]').attr("checked", true);
            	$('input:radio[name=promTgtSendTypeCd]:input[value=D]').attr("checked", false);
            	$('input:radio[name=promTgtSendTypeCd]:input[value=D]').attr("disabled", true);
            }

            //반복주기 설정(정기 캠페인 일 경우에만 사용 가능)
            if (result.campaignTypeCode != "REGULAR") {
            	$('input:radio[name=promCyclTypeCd]:input[value=A]').attr("checked", true);
            	$('input:radio[name=promCyclTypeCd]:input[value=M]').attr("disabled", true);
            }

        }
    });
}

/**
 * 룰셋 오퍼 조회
 */
function getRuleSetOffer() {
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignOffer"/>', {
        campaignId: ruleSetData.ridMktCamMst
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            $.each(result.offerList, function(index, data) {
                data.discountAmt = Math.ceil(data.discountAmt);
            });
            setOfferListGrid(result);
        }
    });
}

/**
 * 오퍼 목록 조회
 */
function setOfferListGrid(data) {
    var jqGridOption = {
        loadComplete : function(obj) {
            //popup 높이 맞추기
            new ifvm.PopupHeight({
                popupDivId : 'dialog',
                contentsId : 'dialogPopupWrap'
            });
        },
        serializeGridData : function(data) {
        },
        ondblClickRow : function(id) {
        },
        data: data.offerList,
        datatype: 'clientSide',
        colNames:[
                   '#',
                   '<spring:message code="M00314"/>',
                   '<spring:message code="M00319"/>',
                   '<spring:message code="M01896"/>',
	               '<spring:message code="M02276"/>',
	               '<spring:message code="M02275"/>',
                   'offerId',
                   'id',
                 ],
        colModel:[
            {name:'offerNo',         index:'',       width:'100px', align:'center', resizable : false},
            {name:'offerName',       index:'',       width:'130px', align:'left',   resizable : false, cellattr: function() { return 'style="text-overflow:ellipsis;"';}},
            {name:'offerTypeCd',     index:'',       width:'80px',  align:'center', resizable : false},
            {name:'offerSubTypeNm',	 index:'', 		 width:'100px',align:'center', resizable : false},
            {name:'offerEcnrsDivNm', index:'', 		 width:'100px', resizable : false},
            {name:'offerUseDeskDivNm',index:'', 	 width:'100px', resizable : false},
            {name:'offerId',         index:'mof.id', resizable : false,  hidden : true,  searchable : false},
            {name:'id',              index:'mof.id', resizable : false,  hidden : true,  searchable : false}
        ],
        rowList : [100000],
        tempId : 'ifvGridSimpleTemplete',
    };
    offerListGrid = $("#offerListGridDiv").ifvGrid({ jqGridOption : jqGridOption });
    gridIdofferListGrid = $("#gridIdofferListGridDiv");
}

/**
 * 룰셋 저장
 */
function ruleSetSave() {

    if (promBasicValidation.confirm() && chkCalendarValidation()) {

        $.ifvProgressControl(true);
        // ruleset
        ruleSetData.rulesetDtl.rid = $('#rulesetId').val();
        ruleSetData.rulesetDtl.ridMktCamMst = ruleSetData.ridMktCamMst;
        ruleSetData.rulesetDtl.promStartDt = $('#promStartDate').val() + ' ' + $('#promStartTime').val();
        ruleSetData.rulesetDtl.promEndDt = $('#promEndDate').val() + ' ' + $('#promEndTime').val();
        ruleSetData.rulesetDtl.promTypeCd = $('#promTypeCd').val();
        ruleSetData.rulesetDtl.allianceTypeCd = $('#allianceTypeCd').val();
        ruleSetData.rulesetDtl.monthLmtPoint = $('#monthLmtPoint').val();
        ruleSetData.rulesetDtl.promOccTmscntCd = $('#promOccTmscntCd').val();
        ruleSetData.rulesetDtl.fstPrizeCnt = $('#fstPrizeCnt').val();
        ruleSetData.rulesetDtl.prizePeriod = $('#prizePeriod').val();
        ruleSetData.rulesetDtl.stepAscAmt = $('#stepAscAmt').val();
        ruleSetData.rulesetDtl.chitOtputSbst = $('#chitOtputSbst').val();
        ruleSetData.rulesetDtl.rulesetDesc = $('#rulesetDesc').val();
        ruleSetData.rulesetDtl.prirtTypeCd = $('#prirtTypeCd').val();

        ruleSetData.rulesetDtl.promCyclTypeCd = $(":input:radio[name=promCyclTypeCd]:checked").val();
        ruleSetData.rulesetDtl.promCyclStartDd = $('#promCyclStartDd').val();
        ruleSetData.rulesetDtl.promCyclEndDd = $('#promCyclEndDd').val();
        ruleSetData.rulesetDtl.promTgtSendTypeCd = $(":input:radio[name=promTgtSendTypeCd]:checked").val();
        ruleSetData.rulesetPrvBnfList = [{
            rid : $('#prvBnfRid').val(),
            acrlType : $('#acrlType').val(),
            acrlAmt : $('#acrlAmt').val(),
        }];
        
        ruleSetData.rulesetTran.dealStartDt = $('#dealStartDt').val();
        ruleSetData.rulesetTran.dealEndDt = $('#dealEndDt').val();

         $.ifvSyncPostJSON('<ifvm:action name="saveRuleSet"/>', ruleSetData,
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                //데이터 재구성
                initRuleSetMainData();
                alert("<spring:message code='M01857'/>");
            }
        });

        $.ifvProgressControl(false);

        diagram._selectedObject.taskType = diagram._selectedObject.nodeType;
        diagram._selectedObject.taskDataStatus = "U";

        //set actual task ID
        diagram._selectedObject.actualTaskId = campaign.id;

        //set campaign ID
        diagram._selectedObject.campaignId = campaign.id;

        //set old campaign ID
        diagram._selectedObject.oldCampaignId = campaign.id;

        //set alertFlag(현재 팝업에서 저장 alert창이 발생하여 중복 발생하지 않기 위해..)
        workflow.alertFlag = false;

        //save workflow
        saveWorkflow();

        //popup Close
        closeRuleSetPop();
    }
}

/**
 * 데이터 추가시 그리드에 여분의 자리가 있는지 확인한다.
 *
 * @param _gridArry 그리드 데이터
 * @param _promId 프로모션 코드
 * @param _tabIdx 탭 인덱스
 * @returns true = 그리드 full = 추가등록 불가
 */
function chkGridFullCheck(_gridArry, _promId, _tabIdx) {

    var refInfo = {};

    try {
        if ($.fn.ifvmIsNotEmpty(_promId)) {
            refInfo = eval("ruleSetRefMap." + String(_promId));
        }
    }
    catch(err) {
        console.log(err.stack);
    }

    var chkGridFullCheck_status = '';
    var chkGridFullCheck_returnFlag = false;  // true:추가등록불가 / false:추가등록 가능

    if (_tabIdx == 0) { chkGridFullCheck_status = refInfo.objRuleset; }
    if (_tabIdx == 1) { chkGridFullCheck_status = refInfo.objMdl;     }
    if (_tabIdx == 2) { chkGridFullCheck_status = refInfo.objPth;     }
    if (_tabIdx == 3) { chkGridFullCheck_status = refInfo.payMethd;   }

    switch (chkGridFullCheck_status) {
    case 'S': //단건
        if (_gridArry != null && _gridArry.length == 1) {
            alert("<spring:message code='M02211'/>");
            chkGridFullCheck_returnFlag = true;
        }
        break;
    default:
        chkGridFullCheck_returnFlag = false;
        break;
    }

    return chkGridFullCheck_returnFlag;
}

/**
 * validation 변경
 */
function changeValidation() {

    var selPromTypeCd = $('#promTypeCd').val();

    switch (selPromTypeCd) {
    case 'PO': //일반

        //월 한도 포인트 readonly
        $('#monthLmtPoint').prop('readonly', false);
        break
    default:

        ruleSetData.rulesetDtl.monthLmtPoint = '';
        $('#monthLmtPoint').val('');
        $('#monthLmtPoint').prop('readonly', true);
        break;
    }

    changeValidation_mbr();
    changeValidation_tran();
    changeValidation_sday();

    //initTab();
}

function changeTabValidation(){
	if(confirm('<spring:message code="L00149"/>')){
		ruleSetTab.abledTabAll();
	 	ruleSetTab.moveTabIndex(0);
		ruleSetTab.moveTabIndex(1);
		ruleSetTab.moveTabIndex(2);
		ruleSetTab.moveTabIndex(3);

		tabListValReset();
		tabValidSetting();
	}
}

function tabListValReset(){
	  var len=0;
	  if(typeof grantedStandardListGrid != "undefined"){
		  len = grantedStandardListGrid.getAllRowData().length;
		  if (len > 0) {
		        grantedStandardListGrid.delAllRowData();
		        // 전역변수에 값 매핑
		        ruleSetData.ruleSetMstList = grantedStandardListGrid.getAllRowData();
		  }
	  }

	  if(typeof targetProductListGrid != "undefined"){
	  	  len = targetProductListGrid.getAllRowData().length;
	      if (len > 0) {
		        targetProductListGrid.delAllRowData();

		        // 전역변수에 값 매핑
		        ruleSetData.ruleSetProdList = targetProductListGrid.getAllRowData();
		  }

	  }

	  if(typeof destinationPathListGrid != "undefined"){
		  len = destinationPathListGrid.getAllRowData().length;
	      if (len > 0) {
	          destinationPathListGrid.delAllRowData();

	          // 전역변수에 값 매핑
	          ruleSetData.ruleSetLimitPathList = destinationPathListGrid.getAllRowData();
	      }
	  }

	  if(typeof paymentStandardListGrid != "undefined"){
		  len = paymentStandardListGrid.getAllRowData().length;
	      if (len > 0) {
	          paymentStandardListGrid.delAllRowData();
	          // 전역변수에 값 매핑
	          ruleSetData.ruleSetLimitCardList = paymentStandardListGrid.getAllRowData();
	      }
	  }

}

function tabValidSetting(){
	var promTypeCdVal =  $("#promTypeCd").val();
	if(promTypeCdVal=="P001" || promTypeCdVal=="P002" || promTypeCdVal=="P003" || promTypeCdVal=="P004"){
		ruleSetTab.disabledTab([1]);
		ruleSetTab.disabledTab([2]);
		ruleSetTab.disabledTab([3]);
		ruleSetTab.moveTabIndex(0);
	}else if(promTypeCdVal=="P005"){
		ruleSetTab.disabledTab([1]);
		ruleSetTab.disabledTab([3]);
		ruleSetTab.moveTabIndex(0);
	}else if(promTypeCdVal=="P006"){
		ruleSetTab.disabledTab([1]);
		ruleSetTab.moveTabIndex(0)
	}else if(promTypeCdVal=="P007"){
		ruleSetTab.disabledTab([0]);
		ruleSetTab.disabledTab([3]);
		ruleSetTab.moveTabIndex(1);
	}else if(promTypeCdVal=="P009"){
		ruleSetTab.disabledTab([0]);
		ruleSetTab.disabledTab([1]);
		ruleSetTab.moveTabIndex(0);
	}
}

/**
 * 거래조건
 */
function changeValidation_tran() {
    var selPromTypeCd = $('#promTypeCd').val();

    // 현재 활성화된 탭이 기념일인 경우 화면에 데이터 출력
    if ($('#rulesetTabContent').val() == 'tran') {

        switch (selPromTypeCd) {
        case 'PO':  //일반

            $('#chargAmt').prop('readonly', false);
            $('#chargComprOptrCd').prop('disabled', false);
            $('#dealDowCd').prop('disabled', false);
            $('#dealCnt').prop('readonly', false);
            $('#dealComprOptrCd').prop('disabled', false);
            $('#dealStartDt').prop('disabled', false);
            $('#dealEndDt').prop('disabled', false);
            $('#baseDdCd').prop('disabled', false);
            $('#aplyDaycnt').prop('readonly', false);
            $('#aplyDaycntOptrCd').prop('disabled', false);

            break;
        default:

            ruleSetData.rulesetTran.chargAmt = '';
            ruleSetData.rulesetTran.chargComprOptrCd = '';
            ruleSetData.rulesetTran.dealDowCd = '';
            ruleSetData.rulesetTran.dealCnt = '';
            ruleSetData.rulesetTran.dealComprOptrCd = '';
            ruleSetData.rulesetTran.baseDdCd = '';
            ruleSetData.rulesetTran.aplyDaycnt = '';
            ruleSetData.rulesetTran.aplyDaycntOptrCd = '';
            ruleSetData.rulesetTran.dealStartDt = '';
            ruleSetData.rulesetTran.dealEndDt = '';

            $('#chargAmt').prop('readonly', true);
            $('#chargComprOptrCd').prop('disabled', true);
            $('#dealDowCd').prop('disabled', true);
            $('#dealCnt').prop('readonly', true);
            $('#dealComprOptrCd').prop('disabled', true);
            $('#dealStartDt').prop('disabled', true);
            $('#dealEndDt').prop('disabled', true);
            $('#baseDdCd').prop('disabled', true);
            $('#aplyDaycnt').prop('readonly', true);
            $('#aplyDaycntOptrCd').prop('disabled', true);

            break;
        }
        initTranData();
    }
}

/**
 * 고객정보
 */
function changeValidation_mbr() {
    var selPromTypeCd = $('#promTypeCd').val();

    // 현재 활성화된 탭이 기념일인 경우 화면에 데이터 출력
    if ($('#rulesetTabContent').val() == 'mbr') {

        switch (selPromTypeCd) {
        case 'PO':  //일반

            $('#custTypeCd').prop('disabled', false);
            $('#custGradeCd').prop('disabled', false);
            $('#sexCd').prop('disabled', false);
            $('#vipDivCd').prop('disabled', false);
            $('#totAvlPoint').prop('readonly', false);
            $('#avlpntComprOptrCd').prop('disabled', false);

            break;
        default:

            ruleSetData.rulesetMbr.custTypeCd = ''
            ruleSetData.rulesetMbr.custGradeCd = ''
            ruleSetData.rulesetMbr.sexCd = ''
            ruleSetData.rulesetMbr.vipDivCd = ''
            ruleSetData.rulesetMbr.totAvlPoint = ''
            ruleSetData.rulesetMbr.avlpntComprOptrCd = ''

            $('#custTypeCd').prop('disabled', true);
            $('#custGradeCd').prop('disabled', true);
            $('#sexCd').prop('disabled', true);
            $('#vipDivCd').prop('disabled', true);
            $('#totAvlPoint').prop('readonly', true);
            $('#avlpntComprOptrCd').prop('disabled', true);

            break;
        }
        initMbrData();
    }
}

/**
 * 기념일
 */
function changeValidation_sday() {
    var selPromTypeCd = $('#promTypeCd').val();

    switch (selPromTypeCd) {

    case 'PO':  //일반
        ruleSetData.rulesetSday.cmrtnTypeCd = '';
        ruleSetData.rulesetSday.sdayComprOptrCd = '';
        ruleSetData.rulesetSday.dealDd = '';
        $('#sdayComprOptrCd').prop('disabled', true);
        break;

    case 'PD': //회원생일
        ruleSetData.rulesetSday.cmrtnTypeCd = '10';
        ruleSetData.rulesetSday.dealDd = '';
        $('#sdayComprOptrCd').prop('disabled', false);
        break;

    case 'WD': //결혼기념일
        ruleSetData.rulesetSday.cmrtnTypeCd = '30';
        ruleSetData.rulesetSday.dealDd = '';
        $('#sdayComprOptrCd').prop('disabled', false);

        break;

    case 'ED': //E1 Day
        ruleSetData.rulesetSday.cmrtnTypeCd = '';
        ruleSetData.rulesetSday.sdayComprOptrCd = '05';
        ruleSetData.rulesetSday.dealDd = '21';
        $('#sdayComprOptrCd').prop('disabled', true);
        break;

    case 'FR': //카드 등록후 첫 충전
        ruleSetData.rulesetSday.cmrtnTypeCd = '20';
        ruleSetData.rulesetSday.sdayComprOptrCd = '05';
        ruleSetData.rulesetSday.dealDd = '';
        $('#sdayComprOptrCd').prop('disabled', true);
        break;

    case 'ED02': //E1Day(훼미리마트)
        ruleSetData.rulesetSday.cmrtnTypeCd = '';
        ruleSetData.rulesetSday.sdayComprOptrCd = '05';
        ruleSetData.rulesetSday.dealDd = '21';
        $('#sdayComprOptrCd').prop('disabled', true);
        break;
    }

    // 현재 활성화된 탭이 기념일인 경우 화면에 데이터 출력
    if ($('#rulesetTabContent').val() == 'sDay') {
        initSdayData();
    }
}

function getInitExtTime(kind) {
    if (kind == 'SD') {
        var exeDay = [];
        exeDay.push({code: "", name: ""})
        for (var i=1; i <= 31; i++ ) {
            exeDay.push({code: $.fn.ifvmStr_pad(i, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i, 2, '0', "LEFT")});
        }
        return exeDay;
    }
    else if (kind == 'ED') {
        var exeDay = [];
        exeDay.push({code: "", name: ""})
        exeDay.push({code: "E", name: "<spring:message code='L02128'/>"})
        for (var i=1; i <= 31; i++ ) {
            exeDay.push({code: $.fn.ifvmStr_pad(i, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i, 2, '0', "LEFT")});
        }
        return exeDay;
    }
}

/**
 * 프로모션 시간대 세팅 (0-24) 
 */
function setAplyTmSelectBoxSetting() {
	var _obj = [];
	var _i = ""
	for(var i=0; i<25; i++) {
		_i = i.toString().length < 2 ? "0"+i : i.toString();
		_obj.push({code : _i, name : '<spring:message code="L02272" arguments="' + _i + '"/>'})
	}
	
	$("#dealStartDt").append($("#CommonListTemp").tmpl(_obj));
	$("#dealEndDt").append($("#CommonListTemp").tmpl(_obj));
	
	$('#dealEndDt').val(24);
}

$(document).ready(function() {
    //	달력 설정
    setValidCalendar();

    //프로모션 시간대
    setAplyTmSelectBoxSetting();

    //실행 일
    var temp = $("#CommonListTemp").tmpl(getInitExtTime('SD'));
    $("#ruleSetMainWrap #promCyclStartDd").append(temp);

    temp = $("#CommonListTemp").tmpl(getInitExtTime('ED'));
    $("#ruleSetMainWrap #promCyclEndDd").append(temp);

    //화면 초기 설정
    initRuleSetMainData();

    //프로모션 유형
    $.fn.ifvmSetSelectOptionCommCode("promTypeCd", "LOY_PROM_SUB_TYPE", null, null, true);

    //제휴사명
    //$.fn.ifvmSetSelectOptionCommCode("allianceTypeCd", "CPRT_TYPE_CD", null, null, false);

    //프로모션 발생횟수
    $.fn.ifvmSetSelectOptionCommCode("promOccTmscntCd", "LOY_PROMO_STEP", null, null, true);

    //우선순위
    $.fn.ifvmSetSelectOptionCommCode("prirtTypeCd", "LOY_PRIORITY_CD", null, null, true);

    //보상유형
    //$.fn.ifvmSetSelectOptionCommCode("acrlType", "OBJECT_OPER_CODE", null, null, true);

    //저장
    $("#ruleSetSaveBtn").on('click', function() {
        ruleSetSave();
    })

    //프로모션 유형
    $('#promTypeCd').on('change', function() {
        changeValidation();
        changeTabValidation();
    });

    //반복주기 유형
    /*
    $('input[type=radio][name=promCyclTypeCd]').change(function() {
    	//상시
        if (this.value == 'A') {
        	$('#promCyclStartDd').removeAttr('required');
        	$('#promCyclEndDd').removeAttr('required');

        	$("#promCyclStartDd").val("");
        	$("#promCyclEndDd").val("");

        	$("#promCyclArea").hide();
        }
    	//매월
        else if (this.value == 'M') {
        	$("#promCyclStartDd").attr('required', true);
        	$("#promCyclEndDd").attr('required', true);

        	$("#promCyclArea").show();
        }

        promBasicValidation = $('#promBasicInfo').ifvValidation();
    });
    */

    changeValidation();

    promBasicValidation = $('#promBasicInfo').ifvValidation();
 //   changeTabValidation();
    //tabValidSetting();


});

</script>

<script id="CommonListTemp" type="text/x-jquery-tmpl">
    <option value=${'${'}code}>${'${'}name}</option>
</script>

<style>

#dialogPopupWrap .monitoring_grid .ui-th-ltr,
#dialogPopupWrap .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr {
    height: 31px;
}

</style>

<div id="ruleSetMainWrap">
    <ifvm:input type="hidden" id="rulesetId" names="rulesetId"/>

    <div class="page-title">
        <h1>
            <spring:message code="M00739" />
            &gt; <spring:message code="M00273" />
        </h1>
    </div>

    <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code='L00150'/></span>
            </div>
            <div class="col-xs-5 searchbtn_r">
                <button class="btn btn-sm" id="ruleSetSaveBtn"><i class="fa fa-plus"></i>
                    <spring:message code='M01855'/>
                </button>
            </div>
        </div>
    </div>

    <div class="well mg_bt0 underline form-horizontal" id="approvalBasicInfo">
        <div class="row qt_border">

            <%-- 캠페인 명 --%>
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='L00152'/></label>
            <div class="col-xs-8 control_content">
                <div class="input-group">
                    <ifvm:input type="text" disabled="true" id="campaignName"/>
                </div>
            </div>
        </div>
        <div class="row qt_border">

            <%-- 캠페인유형 --%>
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='M00755'/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="select" disabled="true" id="campaignTypeCode" names="campaignTypeCode"/>
            </div>
        </div>
        <div class="row qt_border">

            <%-- 시작일 --%>
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='L00153'/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="date" disabled="true" id="campaignStartDate"/>
            </div>

            <%-- 종료일 --%>
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='L00154'/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="date" disabled="true" id="campaignEndDate" />
            </div>
        </div>
    </div>
    <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code='L00159'/></span>
            </div>
        </div>
    </div>
    <div id="offerListGridDiv" class="white_bg grid_bd0"></div>

    <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code='M02319'/></span>
            </div>
        </div>
    </div>

    <div class="well mg_bt0 underline form-horizontal" id="promBasicInfo" style="width: 80%">
        <div class="row qt_border">

            <!-- 프로모션 시작일시 -->
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='M02469'/></label>
            <div class="col-xs-2 control_content">
                <ifvm:input type="date" required="true" id="promStartDate" />
            </div>
            <div class="col-xs-2 control_content time_content">
                <ifvm:inputNew type="time" required="true" id="promStartTime" />
            </div>

            <!-- 프로모션 종료일시 -->
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='M02470'/></label>
            <div class="col-xs-2 control_content">
                <ifvm:input type="date" required="true" id="promEndDate"/>
            </div>
            <div class="col-xs-2 control_content time_content" >
                <ifvm:inputNew type="time" required="true" id="promEndTime" />
            </div>
        </div>

        <div class="row qt_border">
	        <div class="row qt_border">

	        	<!-- 반복주기 -->
	            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00893"/></label>
	            <div class="col-xs-1 control_content">
					<label class="radio-inline">
		                <ifvm:input type="radio" names="promCyclTypeCd" id="promCyclTypeCd" values="A" checked="checked" />
		                <spring:message code="M02485"/>
		            </label>
	            </div>
	            <div class="col-xs-1 control_content">
		            <label class="radio-inline">
		                <ifvm:input type="radio" names="promCyclTypeCd" id="promCyclTypeCd" values="M" />
		                <spring:message code="M00902"/>
		            </label>
	            </div>

	            <!-- 대상자 전송주기 -->
	            <label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="L02125"/></label>
	            <div class="col-xs-1 control_content">
					<label class="radio-inline">
		                <ifvm:input type="radio" names="promTgtSendTypeCd" id="promTgtSendTypeCd" values="O" checked="checked" />
		                <spring:message code="L02126"/>
		            </label>
	            </div>
	            <div class="col-xs-1 control_content">
		            <label class="radio-inline">
		                <ifvm:input type="radio" names="promTgtSendTypeCd" id="promTgtSendTypeCd" values="D" />
						<spring:message code="L02127"/>
		            </label>
	            </div>
	        </div>

	        <div id="promCyclArea" Style="display:none;">
		        <div class="row">
		        	<!-- 시작일 -->
		            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00153"/></label>
	                <div class="col-xs-1">
	                    <ifvm:input type="select" id="promCyclStartDd" />
	                </div>

		            <!-- 종료일-->
	            	<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="L00154"/></label>
	                <div class="col-xs-1">
	                    <ifvm:input type="select" id="promCyclEndDd" />
	                </div>
		        </div>
	        </div>
        </div>

        <div class="row qt_border">

            <!-- 프로모션 유형 -->
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='L00589'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="promTypeCd" names="promTypeCd" required="true"/>
            </div>

            <%-- 프로모션 발생횟수 --%>
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='M02321'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="promOccTmscntCd" names="promOccTmscntCd" required="true"/>
            </div>
        </div>
        <div class="row qt_border">

            <!-- 취소일시 -->
            <label class="col-xs-2 span control-label"><spring:message code='M02323'/></label>
            <div class="col-xs-2 control_content" style="padding: 0px">
                <ifvm:inputNew type="date" id="cnclDate" disabled="true"/>
            </div>
            <div class="col-xs-2 control_content" style="padding: 0px">
                <ifvm:inputNew type="time" id="cnclTime" disabled="true"/>
            </div>

            <!-- 우선순위 -->
            <label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code='M02390'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="prirtTypeCd" names="prirtTypeCd" required="true"/>
            </div>
        </div>
        <div class="row qt_border">

            <!-- 전표출력내용 -->
            <div style="display:none;">
            <label class="col-xs-2 span control-label"><spring:message code='M02325'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="textarea" id="chitOtputSbst" names="chitOtputSbst" rows="3" maxLength="100"/>
            </div>
            </div>

            <!-- 비고 -->
            <label class="col-xs-2 span control-label"><spring:message code='L01024'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="textarea" id="rulesetDesc" names="rulesetDesc" rows="3" maxLength="100"/>
            </div>
            
			<!-- 프로모션 시간대 -->
			<label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code="L02271"/></label>
			<div class="col-xs-4 control_content">
				<div class="col-xs-6" style="padding-right:13px;">
					<ifvm:input type="select" id="dealStartDt" names="dealStartDt"/>
				</div>
				<div class="col-xs-2 swung_dash">~</div>
				<div class="col-xs-6" style="padding-left:13px;">
					<ifvm:input type="select" id="dealEndDt" names="dealEndDt"/>
				</div>
			</div>
        </div>
    </div>

    <%-- <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code='M02504'/></span>
            </div>
        </div>
    </div>

    <div class="well mg_bt0 underline form-horizontal" id="promBasicInfo" style="width: 80%">
        <div class="row qt_border">
            <ifvm:input type="hidden" id="prvBnfRid" names="prvBnfRid" />

            보상유형
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M02338'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" required="true" id="acrlType" names="acrlType" />
            </div>

            금액(률)
            <label class="col-xs-2 control-label"><spring:message code='M02339'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="number" className="text-right" id="acrlAmt" names="acrlAmt" />
            </div>
        </div>
        <div class="row qt_border">

            제휴사명
            <label class="col-xs-2 span control-label"><spring:message code='V00149'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="allianceTypeCd" names="allianceTypeCd"/>
            </div>

            월 한도 포인트
            <label class="col-xs-2 span control-label"><spring:message code='M02320'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="number" className="text-right" id="monthLmtPoint" names="monthLmtPoint" />
            </div>
        </div>
        <div class="row qt_border">

            첫당첨충전횟수
            <label class="col-xs-2 span control-label"><spring:message code='M02322'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="number" className="text-right" id="fstPrizeCnt" names="fstPrizeCnt" />
            </div>

            당첨주기(충전횟수)
            <label class="col-xs-2 span control-label"><spring:message code='M02876'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="number" className="text-right" id="prizePeriod" names="prizePeriod" />
            </div>
        </div>
        <div class="row qt_border">

            단계별 증가분
            <label class="col-xs-2 span control-label"><spring:message code='M02326'/>(<spring:message code='L00422'/>)</label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="number" className="text-right" id="stepAscAmt" names="stepAscAmt" />
            </div>
        </div>
    </div> --%>

    <div id="ruleSetTabArea" style="margin-top: 20px"></div>
</div>
