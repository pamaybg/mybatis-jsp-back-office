<%@page import="com.icignal.auth.dto.response.LoginResDto"%>
<%@page import="java.util.UUID"%>
<%@page import="net.sf.json.JSONObject"%>

<%@ page import="com.icignal.common.util.BeansUtil" %>
<%@page import="com.icignal.auth.dto.response.AuthorityResDto"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<script type="text/javascript">
//<![CDATA[



window.appServiceId = '<%= BeansUtil.getApplicationProperty("icignal.context.server.appServiceId")%>';
window.country = '<%= BeansUtil.getApplicationProperty("icignal.context.server.country")%>';
window.lang = '<%= BeansUtil.getApplicationProperty("icignal.context.server.lang")%>';

$.extend({

    ifvmGetUserInfo : function(){
        var userObj = new Object();
        <% LoginResDto rtnValue = (LoginResDto)session.getAttribute(com.icignal.common.util.CommonUtil.USER_INFO_PROP);
            if(rtnValue != null){%>
                    userObj = $.parseJSON($.ifvmReplaceHtmlTag('<%= JSONObject.fromObject(rtnValue).toString().replace("'", "\\'")%>'));
                <%
            }
        %>

        /* language parameter 추가 20150513 최인한. */
        window.appServiceId = userObj.appServiceId;
        window.country      = userObj.country;      // US || KR
        window.lang         = userObj.lang;

        /* 20150519 추가. 최인한 */
        $("html").addClass('lang-'+window.lang);

        return userObj;
    },
	ifvmGetAuthInfo : function(){
		var userObj = new Object();
		<%AuthorityResDto auth = (AuthorityResDto)session.getAttribute(com.icignal.common.util.CommonUtil.SESSIONID_AUTH);

			if(auth != null){%>

					userObj = $.parseJSON($.ifvmReplaceHtmlTag('<%=JSONObject.fromObject(auth).toString().replace("'", "\\'").replace("\"", "\\\"")%>'));
				<%}%>

		return userObj;
	},
	ifvmAdminCheck : function (admCheck, btnCheck, dataCheck) {
	},
    ifvmLoginCheck : function(){
        if( $.ifvmIsLogin() == false ){
             window.top.qtjs.href('<ifvm:url name="MKTLogin"/>');
            return false;
        }else{

            return true;
        }
    },
    ifvmEncryptAES : function (str){

        var rtnValue =  '';
        $.ifvSyncPostJSON('<ifvm:action name="MKTEncryptAes"/>', {
            encryptStr : str
        },
        function(result) {
            rtnValue = result.message;
        });

        return rtnValue;
    },
    /**
    * 로그인 여부
    */
    ifvmIsLogin : function(){

        return <%=session.getAttribute(com.icignal.common.util.CommonUtil.CURR_STORE_PROP) == null ? false : true%>;

    },
    /**
    * 정회원 이상 권한 여부
    */
    ifvmIsAuthUser : function(){
        var rtnValue = $.ifvmIsLogin();
        if(rtnValue){

    
            renValue = false;

        }

        return rtnValue;
    },

    ifvmReplaceHtmlTag : function (value){
        return value.replace(/&/g, '&amp;')
         .replace(/>/g, '&gt;')
         .replace(/</g, '&lt;')
         .replace(/\n/g, ' <br>');
    },

    ifvmMarketingLogOut : function(){
       $.ifvSyncPostJSON('<ifvm:action name="MKTLogout"/>', {},
        function(result) {
   	   		location.href = '<ifvm:url name="MKTLogin"/>';
       });
    },
    
	//세션아이디
	ifvmGetSessionId : function() {
		return '<%=(String) session.getId()%>';
	}
});

if( typeof ifv != 'undefined' ){

    ifv.errorMessage = {
        e_100400 : '<spring:message code="C00001"/>',
        e_100500 : '<spring:message code="C00002"/>',
        e_100410 : '<spring:message code="C00003"/>',
        e_200300 : '<spring:message code="C00004"/>',
        e_200310 : '<spring:message code="C00005"/>',
        e_200400 : '<spring:message code="C00006"/>',
        e_200410 : '<spring:message code="C00007"/>',
        e_200420 : '<spring:message code="C00008"/>',
        e_200430 : '<spring:message code="C00009"/>',
        e_200440 : '<spring:message code="C00010"/>',
        e_200450 : '<spring:message code="C00011"/>',
        e_200460 : '<spring:message code="C00012"/>',
		e_200600 : '금지된 단어가 포함됐습니다.',
        m_1000 : '<spring:message code="C00013"/>',
        m_1001 : '<spring:message code="C00014"/>',
        m_1002 : '<spring:message code="C00015"/>',
        m_1003 : '<spring:message code="C00016"/>',
        m_1004 : '<spring:message code="C00017"/>',
        m_1005 : '<spring:message code="C00018"/>',
        m_1006 : '<spring:message code="C00019"/>',
        m_1007 : '<spring:message code="C00020"/>',
        m_1008 : '<spring:message code="C00021"/>',
        m_1009 : '<spring:message code="C00022"/>',
        m_1010 : '<spring:message code="C00023"/>',
        m_1050 : '<spring:message code="C00162"/>'
    };

    ifv.validationMessage = {
        required : '<spring:message code="C00024"/>',
        email : '<spring:message code="C00025"/>',
        password : '<spring:message code="C00026"/>',
        passwordConfirm : '<spring:message code="C00027"/>',
        phone : '<spring:message code="C00028"/>',
        url : '<spring:message code="C00029"/>',
        kor : '<spring:message code="C00030"/>',
        eng : '<spring:message code="C00031"/>',
        number : '<spring:message code="C00032"/>',
        exceptHangul : '<spring:message code="C00033"/>',
        alphanumeric : '<spring:message code="C00153"/>',
    };

    ifv.commonMessage = {
        search : '<spring:message code="C00034"/>',
        noData : '<spring:message code="C00035"/>',
        gun : '<spring:message code="C00036"/>',
        total : '<spring:message code="C00037"/>',
        select : '<spring:message code="C00038"/>',
        ok : '<spring:message code="C00039"/>',
        cancel : '<spring:message code="C00040"/>',
        add : '<spring:message code="M00166"/>',
        del : '<spring:message code="M00165"/>',
        mod : '<spring:message code="M00259"/>',
    };

}


//ifvMultiUpLoader 이미지 목록 추출
if( typeof ifvMultiUpLoader != 'undefined' ){
	ifvMultiUpLoader.prototype.getImageList = function() {
		var imgArr = [];
		var obj;
		
		for( var i = 0; i < this.uploadform.filelist.length; i++ ) {
			obj = {};
			obj.fileName = this.uploadform.filelist[i].name;
			obj.oriName = this.uploadform.filelist[i].oriName;
			obj.rotateAngle = $("#" + this.imgContainerId + i ).attr('RotateAngle');
			obj.parentId = this.imgParentId;
			obj.category = this.uploadform.category;
			obj.filePath = this.uploadform.filelist[i].url;

			imgArr.push( obj );
		}

		return imgArr;
	};

	ifvMultiUpLoader.prototype.setImgArrList = function(imageUrls){

		if(imageUrls.length > 0){
			var bindImages = imageUrls;

			for(var i = 0;i<bindImages.length; i++){
				var url = bindImages[i].imgOrgUrl;
				$("#" + this.imgId + i).attr('src', url);
				$("#" + this.imgContainerId + i).attr('isBind', 'true');
				$('#' + this.tempUpLoadFormId + i ).hide();
				var name = url.substring(url.lastIndexOf('/') + 1, url.length);

				var orgUrl = bindImages[i].imgOrgUrl;
				var orgName = orgUrl.substring(orgUrl.lastIndexOf('/') + 1, orgUrl.length);
				var oriName = bindImages[i].oriName;
				var file = {
						name : name,
						url : url,
						orgName : orgName,
						index : i,
						oriName : oriName
				};

				this.uploadform.filelist.push(file);
			}

			for( var i = 0; i<this.uploadform.maxNumber; i++ ){
				if( i < bindImages.length + 1 ){
					$("#" + this.imgContainerId + i).css('display','block');
				}else{
					$("#" + this.imgContainerId + i).css('display','none');
				}
			}

			if( this.successFunc != null ) this.successFunc();
		}

		this.deleteEventSetting();
	};
}

var MESSAGE = {};
MESSAGE.common = {};
MESSAGE.common.minDateTxt = '<spring:message code="C00042"/>';
MESSAGE.common.maxDateTxt = '<spring:message code="C00043"/>';
MESSAGE.common.progressTxt = '<spring:message code="C00151"/>';
MESSAGE.common.gridProgressTxt = '<spring:message code="C00150"/>';

MESSAGE.datetimepicker = {};
MESSAGE.datetimepicker.today = '<spring:message code="M01060"/>';
MESSAGE.datetimepicker.done = '<spring:message code="M00279"/>';
MESSAGE.datetimepicker.time = '<spring:message code="M00291"/>';
MESSAGE.datetimepicker.placeholder = '<spring:message code="C00038"/>';

MESSAGE.datatables = {};
MESSAGE.datatables.sEmptyTable = '<spring:message code="C00035"/>';
MESSAGE.datatables.sLoadingRecords = '<spring:message code="C00045"/>';
MESSAGE.datatables.sProcessing = '<spring:message code="C00046"/>';
MESSAGE.datatables.sSearch = '<spring:message code="C00047"/>';
MESSAGE.datatables.sZeroRecords = '<spring:message code="C00048"/>';
MESSAGE.datatables.sFirst = '<spring:message code="C00049"/>';
MESSAGE.datatables.sLast = '<spring:message code="C00050"/>';
MESSAGE.datatables.sNext = '<spring:message code="C00051"/>';
MESSAGE.datatables.sPrevious = '<spring:message code="C00052"/>';
MESSAGE.datatables.sSortAscending = '<spring:message code="C00053"/>';
MESSAGE.datatables.sSortDescending = '<spring:message code="C00054"/>';

MESSAGE.collectionList = {};
MESSAGE.collectionList.deleteAllConfirm = '<spring:message code="C00055"/>';
MESSAGE.collectionList.questionContent = '<spring:message code="C00056"/>';
MESSAGE.collectionList.type = '<spring:message code="C00057"/>';
MESSAGE.collectionList.question = '<spring:message code="C00058"/>';
MESSAGE.collectionList.rabel = '<spring:message code="C00059"/>';
MESSAGE.collectionList.rabelBefore = '<spring:message code="C00060"/>';
MESSAGE.collectionList.rabelAfter = '<spring:message code="C00061"/>';
MESSAGE.collectionList.example = '<spring:message code="C00062"/>';
MESSAGE.collectionList.sortAnswerEtc = '<spring:message code="C00063"/>';

MESSAGE.storeManage = {};
MESSAGE.storeManage.error_MSG_1004 = '<spring:message code="C00064"/>';
MESSAGE.storeManage.error_MSG_1005 = '<spring:message code="C00065"/>';
MESSAGE.storeManage.error_MSG_1006 = '<spring:message code="C00066"/>';
MESSAGE.storeManage.error_MSG_1008 = '<spring:message code="M00129"/>';
MESSAGE.storeManage.error_MSG_1001 = '<spring:message code="M00134"/>';
MESSAGE.storeManage.error_MSG_5001 = '<spring:message code="C00067"/>';
MESSAGE.storeManage.error_MSG_5009 = '<spring:message code="C00068"/>';
MESSAGE.storeManage.error_MSG_5008 = '<spring:message code="C00069"/>';
MESSAGE.storeManage.error_MSG_5007 = '<spring:message code="C00070"/>';
MESSAGE.storeManage.moveConfirm = '<spring:message code="C00071"/>';
MESSAGE.storeManage.moveChildren = '<spring:message code="C00072"/>';
MESSAGE.storeManage.newStore = '<spring:message code="C00073"/>';
MESSAGE.storeManage.newTeam = '<spring:message code="C00074"/>';
MESSAGE.storeManage.newPart = '<spring:message code="C00075"/>';
MESSAGE.storeManage.newHQ = '<spring:message code="C00076"/>';
MESSAGE.storeManage.newSEC = '<spring:message code="C00077"/>';
MESSAGE.storeManage.newCOR = '<spring:message code="C00078"/>';

MESSAGE.storeManage.deleteStore = '<spring:message code="C00079"/>';
MESSAGE.storeManage.deleteChildren = '<spring:message code="C00080"/>';
MESSAGE.storeManage.storeTypeChangeConfirm = '<spring:message code="C00081"/>';
MESSAGE.storeManage.group = '<spring:message code="C00082"/>';
MESSAGE.storeManage.store = '<spring:message code="C00083"/>';
MESSAGE.storeManage.newStoreText = '<spring:message code="C00084"/>';
MESSAGE.storeManage.add = '<spring:message code="C00085"/>';

MESSAGE.workflowChart = {};
MESSAGE.workflowChart.question = '<spring:message code="C00086"/>';
MESSAGE.workflowChart.selection = '<spring:message code="C00087"/>';
MESSAGE.workflowChart.noConnectTask = '<spring:message code="C00088"/>';
MESSAGE.workflowChart.typeChangeAlert = '<spring:message code="C00089"/>';
MESSAGE.workflowChart.start =  '<spring:message code="C00090"/>';
MESSAGE.workflowChart.noTaskAlert = '<spring:message code="C00091"/>';
MESSAGE.workflowChart.registWorkflowId = '<spring:message code="C00092"/>';
MESSAGE.workflowChart.loopAlert = '<spring:message code="C00093"/>';
MESSAGE.workflowChart.saveComplete = '<spring:message code="C00094"/>';
MESSAGE.workflowChart.alwaysNextTask = '<spring:message code="C00095"/>';
MESSAGE.workflowChart.targetLink = '<spring:message code="C00096"/>';
MESSAGE.workflowChart.postSelect = '<spring:message code="C00097"/>';
MESSAGE.workflowChart.couponSelect = '<spring:message code="C00098"/>';
MESSAGE.workflowChart.isConnectDecision = '<spring:message code="C00099"/>';
MESSAGE.workflowChart.nextTaskTrue = '<spring:message code="C00100"/>';
MESSAGE.workflowChart.nextTaskFalse = '<spring:message code="C00101"/>';
MESSAGE.workflowChart.nextTaskExit = '<spring:message code="C00102"/>';
MESSAGE.workflowChart.noAnswerAlert = '<spring:message code="C00103"/>';
MESSAGE.workflowChart.emptyConfirm = '<spring:message code="C00104"/>';
MESSAGE.workflowChart.workflowVali1 = '<spring:message code="C00105"/>';
MESSAGE.workflowChart.workflowVali2 = '<spring:message code="C00107"/>';
MESSAGE.workflowChart.onlyOneTaskId = '<spring:message code="C00106"/>';
MESSAGE.workflowChart.choiceDeleteRow = '<spring:message code="C00113"/>';
MESSAGE.workflowChart.workflowVali3 = '<spring:message code="C00108"/>';
MESSAGE.workflowChart.workflowVali4 = '<spring:message code="C00109"/>';
MESSAGE.workflowChart.workflowVali5 = '<spring:message code="C00110"/>';
MESSAGE.workflowChart.workflowVali6 = '<spring:message code="C00111"/>';
MESSAGE.workflowChart.workflowVali7 = '<spring:message code="C00112"/>';

MESSAGE.workflowChart.couponSelectAlert = '<spring:message code="C00114" />';
MESSAGE.workflowChart.selectPostAlert = '<spring:message code="C00115" />';
MESSAGE.workflowChart.ieNotsupport = '<spring:message code="C00116" />';
/* 2015-04-06 상품옵션 추가. */
MESSAGE.product = {};
MESSAGE.product.options = {};
MESSAGE.product.options.option = '<spring:message code="C00117"/>';
MESSAGE.product.options.opName = '<spring:message code="C00118"/>';
MESSAGE.product.options.opValue= '<spring:message code="C00119"/>';
MESSAGE.product.options.opExam = '<spring:message code="C00120"/>';
MESSAGE.product.options.opStatus = '<spring:message code="C00121"/>';
MESSAGE.product.options.opAddAmount = '<spring:message code="C00122"/>';
MESSAGE.product.options.monetaryUnit = '<spring:message code="C00123"/>';
MESSAGE.product.options.status = '<spring:message code="C00125"/>';
MESSAGE.product.options.optionDetail = '<spring:message code="C00124"/>';
MESSAGE.common.confirm = '<spring:message code="C00126"/>'; //확인

/* 2015.11.09 kj.kang 중복체크 */
MESSAGE.departments = {};
MESSAGE.departments.error_MSG_3001 = '<spring:message code="C00127"/>';
MESSAGE.departments.error_MSG_3002 = '<spring:message code="C00128"/>';
MESSAGE.departments.error_MSG_3003 = '<spring:message code="C00129"/>';

MESSAGE.common.justbefore = '<spring:message code="C00130"/>';
MESSAGE.common.ago = '<spring:message code="C00131"/>';
MESSAGE.common.years = '<spring:message code="C00132"/>';
MESSAGE.common.months = '<spring:message code="C00133"/>';
MESSAGE.common.days = '<spring:message code="C00134"/>';
MESSAGE.common.hours = '<spring:message code="C00135"/>';
MESSAGE.common.minutes = '<spring:message code="C00136"/>';
MESSAGE.common.optioncehck = '<spring:message code="C00137"/>';
MESSAGE.common.removeConfirm = '<spring:message code="C00079"/>';

/* 2015.12.01 백상주 캘린더 */
MESSAGE.calendar = {};
MESSAGE.calendar.monday = '<spring:message code="C00138"/>';
MESSAGE.calendar.tuesday = '<spring:message code="C00139"/>';
MESSAGE.calendar.wednesday = '<spring:message code="C00140"/>';
MESSAGE.calendar.thursday = '<spring:message code="C00141"/>';
MESSAGE.calendar.friday = '<spring:message code="C00142"/>';
MESSAGE.calendar.saturday = '<spring:message code="C00143"/>';
MESSAGE.calendar.sunday = '<spring:message code="C00144"/>';

/* 2015.12.14 dg.ryu 워크플로우 */
MESSAGE.campaign = {};
MESSAGE.campaign.canNotRemoveCampaignInfo = '<spring:message code="C00145"/>';
MESSAGE.campaign.onlyOneNodeCanBeAdded = '<spring:message code="C00146"/>';
MESSAGE.campaign.saveCampaign = '<spring:message code="C00147"/>';
MESSAGE.campaign.notConnectedCampaign = '<spring:message code="C00148"/>';
MESSAGE.campaign.notWorkingCampaign = '<spring:message code="C00149"/>';

MESSAGE.campaign.selectPromotionType = '<spring:message code="L00447"/>';
MESSAGE.campaign.selectTriggerType = '<spring:message code="L00448"/>';
MESSAGE.campaign.canNotPromotionInfo = '<spring:message code="M01027"/>';
MESSAGE.campaign.M02723 = '<spring:message code="M02723"/>';
MESSAGE.campaign.M02724 = '<spring:message code="M02724"/>';
MESSAGE.campaign.M02725 = '<spring:message code="M02725"/>';
MESSAGE.campaign.M02726 = '<spring:message code="M02726"/>';
MESSAGE.campaign.M02857 = '<spring:message code="M02857"/>';
MESSAGE.campaign.M03027 = '<spring:message code="M03027"/>';
MESSAGE.campaign.M03030 = '<spring:message code="M03030"/>';

/* 2018.07.30 hy.jun 워크플로우 */
MESSAGE.scoring = {};
MESSAGE.scoring.canNotRemoveScoringInfo = '<spring:message code="L02235"/>';
MESSAGE.scoring.onlyOneNodeCanBeAdded = '<spring:message code="L02236"/>';
MESSAGE.scoring.saveCampaign = '<spring:message code="L02237"/>';
MESSAGE.scoring.notConnectedCampaign = '<spring:message code="L02238"/>';
MESSAGE.scoring.notWorkingCampaign = '<spring:message code="L02239"/>';

LINK_URL = {};
LINK_URL.WORKFLOW = '<ifvm:url name="Workflow"/>';
LINK_URL.CAMPAIGN_INFO_POP = '<ifvm:url name="campaignInfoPop"/>';
LINK_URL.SCORING_INFO_POP = '<ifvm:url name="scoringInfoPop"/>';


var PAGE_CONTEXT_PATH = '${pageContext.request.contextPath}';

/* 2016.01.22 그리드  */
if( $.jgrid != null ){
	$.jgrid.defaults.loadtext = '<spring:message code="C00041"/>';
}

/* 2017.08.04 dg.ryu Kepler Segment */
MESSAGE.kepler = {};
MESSAGE.kepler.segment = {};
MESSAGE.kepler.segment.error_MSG_S0001 = '<spring:message code="M01497"/>';
MESSAGE.kepler.segment.error_MSG_S0002 = '<spring:message code="M01498"/>';
MESSAGE.kepler.segment.error_MSG_S0003 = '<spring:message code="M01499"/>';
MESSAGE.kepler.segment.error_MSG_S0004 = '<spring:message code="M01500"/>';
MESSAGE.kepler.segment.error_MSG_S0005 = '<spring:message code="M01501"/>';
MESSAGE.kepler.segment.error_MSG_S0006 = '<spring:message code="M01502"/>';

MESSAGE.kepler.analysis = {};
MESSAGE.kepler.analysis.error_MSG_S0001 = "<spring:message code='M01671' />";

MESSAGE.diagram = {};
MESSAGE.diagram.error_MSG_D0001 = '<spring:message code="M01025"/>';

/* 2017.06.27 jun.lee 페이스북 채널 */
CONTENTS = {};
CONTENTS.FB = {};
CONTENTS.FB.convertDateToUnixTimestamp = '<ifvm:action name="convertDateToUnixTimestamp"/>';
CONTENTS.FB.setPostId = '<ifvm:action name="setPostId"/>';
CONTENTS.FB.makeShortToLongLivedToken = '<ifvm:action name="makeShortToLongLivedToken"/>';
CONTENTS.FB.error_MSG_M02142 = '<spring:message code="M02142"/>';
CONTENTS.FB.error_MSG_M02151 = '<spring:message code="M02151"/>';
CONTENTS.FB.error_MSG_M02149 = '<spring:message code="M02149"/>';
CONTENTS.FB.error_MSG_M02148 = '<spring:message code="M02148"/>';
CONTENTS.FB.error_MSG_M02192 = '<spring:message code="M02192"/>';
CONTENTS.FB.error_MSG_M02193 = '<spring:message code="M02193"/>';
CONTENTS.FB.error_MSG_M02194 = '<spring:message code="M02194"/>';
CONTENTS.FB.error_MSG_M02195 = '<spring:message code="M02195"/>';

/* 2018.01.06*/
CTI = {};
CTI.callId = null;
CTI.ivrSvcCd = null;
</script>