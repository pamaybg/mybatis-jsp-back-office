<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/marketing/common/common/common.jsp" />

<style>
.well{padding-bottom:5px;}
</style>

<script>

var channelSearchResult;
var selectRow = null;     //선택 채널 ID
var selectChilRow; //선택 용량 ID
var chnlCodetype;  //sms,mms 코드 타입
var requestitem = [];
var chlid;
var pageCheck = false;

var chnlEtcInfoTab;

//조건 절 병견 후 셀렉트 박스가 나올 시 체인지되는 값.
//그룹 코드를 받아 그에 맞는 값을 넣는다.
function searchCommCode(_this,groupdata) {
    var changeTypeArea = $(_this).parent().next('.changeTypeArea');
    var SelectListTemp = $(_this).parent().next().children();
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
          groupCode: groupdata
        , enableNA: true
    }, function(result) {
        changeTypeArea.html('');
        changeTypeArea.append($("#ChannelListSelectTemp").tmpl());
        var temp = $("#CommonListTemp").tmpl(result.rows);
        $(changeTypeArea).children().children("#SelectList").append(temp)
    });
}

//검색 조건 초기 세팅 <,>,<= 등의 벼앨 적재
function initCondition(_this){

    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
          groupCode: 'MKT_TARGET_SERC_OPRT_TYPE'
        , enableNA: true
    }, function(result) {
        var temp = null;

        //초기 값 세팅
        if (_this == null) {
            for (var k=0; k<result.rows.length; k++) {
                result.rows[k].condType = $("#searchType").val();
            }
            temp = $("#ConditionOptionList").tmpl(result.rows);
            $(".searchCondition").append(temp);
        }
        //체인지 이벤트로 인한 조건 값 세팅
        else {

            $(_this).parent().parent().children().children("#searchCon").children().remove()
            for (var k = 0; k < result.rows.length; k++) {
                result.rows[k].condType = $(_this).val();
            }
            temp = $("#ConditionOptionList").tmpl(result.rows);

            $(_this).parent().parent().children().children("#searchCon").append(temp);
        }
    });
}

//조회결과 그리드
function channelSearchResultList() {
    var ejGridOption = {
        serializeGridData: function(data) {
            if(requestitem != null && requestitem.length > 0){
                data.item = requestitem;
            }
            return data;
        },
        /* recordDoubleClick: function(args){
            var strId = args.data.id;
            //location.href = '<ifvm:url name="MKTChannelDetail"/>?id=' + strId;
            qtjs.href('<ifvm:url name="MKTChannelDetail"/>?id=' + strId);
        }, */
        rowSelected: function (args) {
            pageCheck    = true;
            chnlCodetype = args.data.chnlTypeCd;
            selectRow    = args.data.id;
            chnlEtcInfoTab.reloadCurrentTab();
        },
		allowScrolling: true,
        dataUrl:'<ifvm:action name="getChannel"/>',
        columns:[
        	{
        		  field : 'chnlName', headerText : '<spring:message code="M00462"/>', headerTextAlign : 'center', width : '180px',
        		  customAttributes : {
        			  index : 'mc.chnl_nm' } //
        	  },{
          		  field : 'secretNm', headerText : '<spring:message code="M02893"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.aws_secret_nm' } //
          	  },{
          		  field : 'chnlTypeCd', headerText : '<spring:message code="M00463"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'c1.mark_name' } //
          	  },{
          		  field : 'commStatus', headerText : '<spring:message code="M00464"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'c2.mark_name' } //
          	  },{
          		  field : 'ptraccntId', headerText : '<spring:message code="M00465"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'c4.name' } //
          	  },{
          		  field : 'applyStrDate', headerText : '<spring:message code="M00466"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.APLY_START_DD' } //
          	  },{
          		  field : 'applyEndDate', headerText : '<spring:message code="M00467"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.APLY_END_DD' } //
          	  },{
          		  field : 'conId', headerText : '<spring:message code="M00468"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.con_id' } //
          	  },{
          		  field : 'conIp', headerText : '<spring:message code="M00469"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.con_ip' } //
          	  },{
          		  field : 'conPort', headerText : '<spring:message code="M00470"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.con_port' } //
          	  },{
          		  field : 'conUrl', headerText : '<spring:message code="M00471"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.con_url' } //
          	  },{
          		  field : 'description', headerText : '<spring:message code="M00472"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.CHNL_DESC' } //
          	  },{
          		  field : 'modifyBy', headerText : '<spring:message code="M00473"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'c3.name' } //
          	  },{
          		  field : 'modifyDate', headerText : '<spring:message code="M00474"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'mc.modify_date' } //
          	  },{
          		  field : 'id', headerText : 'id', visible : false ,
          		  customAttributes : {
          			  searchable: false,
          			  index : 'mc.id' } //
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'mc.chnl_nm',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio : true
    };
    channelSearchResult = $("#channelSearchResult").ifvsfGrid({ ejGridOption: ejGridOption });
}

/* 팝업 닫기 */
function channelPopupClose() {
	channelPopCon._destroy();
}

//소셜부가정보 관리 팝업 닫기
function snsAdtnInfoPopupClose() {
	snsAdtnInfoPopCon._destroy();
}

function dialogHeightSetting() {
    new ifvm.PopupHeight({
        popupDivId: 'channelPopCon',
        contentsId: 'capacityWrap'
    });
}

/**
 * 탭 설정
 */
function initTab() {

    chnlEtcInfoTab = $('#chnlEtcInfoTabDiv').DrawTab({
        item: [
            {label: '<spring:message code="M00488"/>', href: '/marketing/channel/include/imageFileLimitTabNew'},
            {label: '<spring:message code="M00489"/>', href: '/marketing/channel/include/channelCapacityTabNew'},
            {label: '<spring:message code="M02134"/>', href: '/marketing/channel/include/snsAdditionalInfoTab'},
        ]
    });
}

$(document).ready(function() {

    //채널 목록 조회
    channelSearchResultList();

    //탭 초기화
    initTab();

    //검색조건 초기 셋팅
    initCondition();

    var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
    
    //필수 영역 공통 호출
    $("#authGroupSearchBtn").on('click', function() {
        $.fn.ifvmSubmitSearchCondition("channelRequiredList", channelSearchResultList);
    });
    $.fn.ifvmSetCommonCondList("channelRequiredList",LeftMenuId);

    $("#authGroupinitBtn").on('click', function() {
        $.fn.ifvmSetCommonCondList("channelRequiredList",LeftMenuId);
    });

    //신규
    $('#channelNewBtn').on('click', function() {
        //location.href = '<ifvm:url name="MKTChannelDetail"/>';
        qtjs.href('<ifvm:url name="MKTChannelDetail"/>');
    });

  	//수정
    $('#channelModifyBtn').on('click', function() {
    	if (selectRow == null) {
			alert('<spring:message code="M00498"/>');
		}
    	else{
        	//location.href = '<ifvm:url name="MKTChannelDetail"/>?id=' + strId;
        	qtjs.href('<ifvm:url name="MKTChannelDetail"/>?id=' + selectRow);
        }
    });
});



</script>

<div class="page-title">
    <h1>
        <spring:message code="M00459"/> &gt;  <spring:message code="M00273"/>
    </h1>
</div>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="L01838"/></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id='authGroupSearchBtn' objCode="authGroupSearchBtn_OBJ"><i class="fa fa-search"></i>
            <spring:message code="M00273"/>
        </button>
        <button class="btn btn-sm" id='authGroupinitBtn' objCode="authGroupinitBtn_OBJ">
            <spring:message code="M00311"/>
        </button>
    </div>
</div>

<div class="well form-horizontal" id="channelRequiredList" ></div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="channelNewBtn" objCode="channelNewBtn_OBJ">
                <i class="fa fa-plus"></i>
                <spring:message code="M00274"/>
            </button>
            <button class="btn btn-sm" id="channelModifyBtn" objCode="channelModifyBtn_OBJ">
                <spring:message code="M00283"/>
            </button>
        </div>
    </div>
    <div id="channelSearchResult" class="grid_bd0"></div>
</div>

<div id="chnlEtcInfoTabDiv"></div>

<div id="channelPopCon" class="popup_container"></div>
<div id="snsAdtnInfoPopCon" class="popup_container"></div>