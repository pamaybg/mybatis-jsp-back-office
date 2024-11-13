<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.BeansUtil" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<link rel="stylesheet" href="/resources/css/marketing/printPopup.css">

<style>

#barcodimg {margin-top: 10px}
#qrcodimg {width: 114px; height: 114px}

</style>

<script>

var camId = '<%= cleanXss(request.getParameter("id")) %>';

/**
 * 레포트 데이터 출력 
 */
function initReportData() {
    $('#reportOfferArea').hide();
    //$('#reportCoupnTable').hide();
    $('#reportTargetingArea').hide();
    $('#reportPromArea').hide();
	$('#reportSchedulingOnce').hide();
	$('#reportSchedulingRepeat').hide();
	$('#reportContsArea').hide();
	$('#reportRelCampaignArea').hide();
    
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignReportInfo"/>', {
        campaingId: camId
    },
    function(result) {
    	
        if ($.fn.ifvmIsNotEmpty(result) && $.fn.ifvmIsNotEmpty(result.campaignDefaultInfo)) {
            
            //캠페인 기본정보 
            $('#campaignTitle').text(result.campaignDefaultInfo.camNm);
            $('#campaignTerm').text(result.campaignDefaultInfo.camStartDd + ' ~ ' + result.campaignDefaultInfo.camEndDd);
            $('#camTypeNm').text(result.campaignDefaultInfo.camTypeNm);
            $('#camDesc').text(result.campaignDefaultInfo.camDesc);
            /* $('#camScopeTypeNm').text(result.campaignDefaultInfo.camScopeTypeNm); */
            $('#oldAprStatCd').text(result.campaignDefaultInfo.oldAprStatCd);
            $('#camPlner').text(result.campaignDefaultInfo.camPlner);
            
            //if (result.campaignDefaultInfo.promYn == '1') {
	        //    $('#promYn').attr('checked', 'checked');
	        //    $('#promYn').prop('checked', true);
            //}
            
            if (result.campaignDefaultInfo.fatiExceptYn == '1') {
	            $('#fatiExceptYn').attr('checked', 'checked');
	            $('#fatiExceptYn').prop('checked', true);
            }
            
            if (result.campaignDefaultInfo.prmsExceptYn == '1') {
	            $('#prmsExceptYn').attr('checked', 'checked');
	            $('#prmsExceptYn').prop('checked', true);
            }
            
            /* $('#intactType2Nm').text(result.campaignDefaultInfo.intactType2Nm); */
            //승인자
            if ($.fn.ifvmIsNotEmpty(result.approvalList)) {
                var aprvList = result.approvalList;
                var signData = [];
                var cnt = 0;
                aprvList.forEach(function(data) {
                    if (cnt == 0) {
                        $('#rqtrNm').text(data.aprvNm);
                    }
                    else {
	                    signData.push({name: data.aprvNm , cnt: cnt});
                    }
                    cnt++;
                });
                setSignArea(signData);
            }
            
            //오퍼 조회
            if ($.fn.ifvmIsNotEmpty(result.offerInfo)) {
            	var aplyStartDate = result.offerInfo.aplyStartDd
            	var aplyEndDate = result.offerInfo.aplyEndDd;
            	var aplyDate = aplyStartDate + ' ~ ' + aplyEndDate;
            	var couponExe  = result.offerInfo.offerAplyDay;
            	var startDt	   = result.offerInfo.startDtnum;
            	var vsDt	   = result.offerInfo.vsDtnum;
            	
                $('#reportOfferArea').show();
                
                $('#offerNm').text(result.offerInfo.offerNm);
                $('#offerTypeNm').text(result.offerInfo.offerTypeNm);
                $('#prodNm').text(result.offerInfo.prodNm);
                $('#offerSubTypeNm').text(result.offerInfo.offerSubTypeNm);
                $('#dividName').text(result.offerInfo.dividName);
                $('#divIdVal').text(result.offerInfo.divIdVal);
                //$('#offerUseDeskDivNm').text(result.offerInfo.offerUseDeskDivNm);
                $('#offerDesc').text(result.offerInfo.offerDesc);
                $('#vsBasCd').text(result.offerInfo.vsBasCd);
                
                if($.fn.ifvmIsNotEmpty(startDt)){
                	$('#startDtnum').text(result.offerInfo.startDtnum + '일');
                }
                if($.fn.ifvmIsNotEmpty(vsDt)){
                	$('#vsDtnum').text(result.offerInfo.vsDtnum + '월');
                }
                
                /* 쿠폰 기간 날짜 or 실행일 */
                if($.fn.ifvmIsNotEmpty(aplyStartDate) && $.fn.ifvmIsNotEmpty(aplyEndDate)){
                	
                	$('#couponTerm').text('날짜 : ' + aplyDate);
                	$('#selfTotAmt').text(result.offerInfo.selfTotAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g ,','));
                }else if($.fn.ifvmIsNotEmpty(couponExe)){
                	
                	$('#couponTerm').text('실행일 : 발급기준일 + ' + couponExe + '일');
                	$('#selfTotAmt').text(result.offerInfo.selfTotAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g ,','));
                }
                
                $('#offerNotiOne').text(result.offerInfo.offerNotiOne);
                $('#offerNotiTwo').text(result.offerInfo.offerNotiTwo);
                $('#offerNotiThree').text(result.offerInfo.offerNotiThree);
                
            }

            //쿠폰조회
            /* if ($.fn.ifvmIsNotEmpty(result.coupnInfo)) {
                $('#reportCoupnTable').show();

                $('#coupnNm').text(result.coupnInfo.coupnNm);
                $('#coupnTerm').text(result.coupnInfo.useStartDt + ' ~ ' + result.coupnInfo.useEndDt);
                $('#coupnDesc').text(result.coupnInfo.coupnDesc);
                $('#coupnUseGdnc').text(result.coupnInfo.coupnUseGdnc1);
            } */

            //타겟팅 정보 
            if ($.fn.ifvmIsNotEmpty(result.targetingInfo)) {
                $('#reportTargetingArea').show();
                
                $('#camTgtTypeNm').text(result.targetingInfo.camTgtTypeNm);
				$('#camTgtCnt').text(numberWithCommas(result.targetingInfo.camTgtCnt));
                $('#tgtGroupDesc').text(result.targetingInfo.tgtGroupDesc);
            }
            
            //프로모션 정보
            if ($.fn.ifvmIsNotEmpty(result.promInfo)) {
                $('#reportPromArea').show();
                
                $('#promStartDt').text(result.promInfo.promStartDt);
                $('#promEndDt').text(result.promInfo.promEndDt);
                $('#acrlTypeNm').text(result.promInfo.acrlTypeNm);
                $('#acrlAmt').text(result.promInfo.acrlAmt);
                $('#allianceTypeNm').text(result.promInfo.allianceTypeNm);
                $('#monthLmtPoint').text($.fn.ifvmNumberWithCommas(result.promInfo.monthLmtPoint));
                
                $('#rulesetDesc').text(result.promInfo.rulesetDesc);
                $('#promTypeNm').text(result.promInfo.promTypeNm);
                
                //상시
                if (result.promInfo.promCyclTypeCd == 'A') {
	                $('#promCycl').text('<spring:message code="M02485"/>');
                }
                //반복
                else if (result.promInfo.promCyclTypeCd == 'M') {
	                $('#promCycl').text('<spring:message code="M00902"/>('
	                        			+ Number(result.promInfo.promCyclStartDd)
	                        			+ '<spring:message code="M00905"/>~'
	                        			+ Number(result.promInfo.promCyclEndDd)
	                        			+ '<spring:message code="M00905"/>)' );
                }
            }
            
            //일정
            //schedulingInfo
            if ($.fn.ifvmIsNotEmpty(result.schedulingInfo)) {

                //정기/반복 캠페인 (반복실행)
                if (result.campaignDefaultInfo.camTypeCd == 'REGULAR') {
                    $('#reportSchedulingRepeat').show();

                    $('#exeStartDd').text(result.schedulingInfo.exeStartDd);
                    $('#exeEndDd').text(result.schedulingInfo.exeEndDd);
                    $('#exeHour').text(result.schedulingInfo.exeHour+':'+result.schedulingInfo.exeMnut);
                    
                    var exeRepeatInfoStr = '';
                    
                    //반복주기 유형코드 = 매일 
                    if (result.schedulingInfo.exeCyclTypeCd == 'D') {
                        var exeWeek = [];
                        if (result.schedulingInfo.exeSunYn == '1') exeWeek.push('<spring:message code="M00895"/>');
                        if (result.schedulingInfo.exeMonYn == '1') exeWeek.push('<spring:message code="M00896"/>');
                        if (result.schedulingInfo.exeTueYn == '1') exeWeek.push('<spring:message code="M00897"/>');
                        if (result.schedulingInfo.exeWedYn == '1') exeWeek.push('<spring:message code="M00898"/>');
                        if (result.schedulingInfo.exeThuYn == '1') exeWeek.push('<spring:message code="M00899"/>');
                        if (result.schedulingInfo.exeFriYn == '1') exeWeek.push('<spring:message code="M00900"/>');
                        if (result.schedulingInfo.exeSatYn == '1') exeWeek.push('<spring:message code="M00901"/>');
                        exeRepeatInfoStr += exeWeek.join('/');
                    }
                    //반복주기 유형코드 = 매월 
                    else if (result.schedulingInfo.exeCyclTypeCd == 'M') {
                        
                        //매월선택 = 일
                        if (result.schedulingInfo.exeMonthTypeCd == 'MD') {
                            exeRepeatInfoStr += '<spring:message code="M00902"/> ' + Number(result.schedulingInfo.exeDay) + '<spring:message code="M00905"/>';
                        }
                        //매월선택 = 월말
                        else if (result.schedulingInfo.exeMonthTypeCd == 'ML') {
                            exeRepeatInfoStr += '<spring:message code="M00906"/>';
                        }
                    }
                    $('#exeRepeatInfo').text(exeRepeatInfoStr);
                    
                    var exeDivInfoStr = '';
                    if ($.fn.ifvmIsNotEmpty(result.schedulingInfo.divSendTtime)) {
                        var time = result.schedulingInfo.divSendTtime.substr(0, 2) + ':' + result.schedulingInfo.divSendTtime.substr(2, 2);
                        exeDivInfoStr += time + ' <spring:message code="M02489"/> ';
                    }
                    if ($.fn.ifvmIsNotEmpty(result.schedulingInfo.divSendCnt)) {
                        exeDivInfoStr += '<spring:message code="M02490"/> ' + numberWithCommas(result.schedulingInfo.divSendCnt) + '건 ';
                    }
                    if ($.fn.ifvmIsNotEmpty(result.schedulingInfo.maxSendCnt)) {
                        exeDivInfoStr += '<spring:message code="M02491"/> ' + numberWithCommas(result.schedulingInfo.maxSendCnt) + '건';
                    }
                    $('#exeDivInfo').text(exeDivInfoStr);
                    
                }
                //타겟 캠페인 (한번실행)
                else if (result.campaignDefaultInfo.camTypeCd == 'TARGET') {
                    $('#reportSchedulingOnce').show();
                    
                    if ($.fn.ifvmIsNotEmpty(result.schedulingInfo.dtlList)
                            && result.schedulingInfo.dtlList.length > 0 ) {
                        var $schedulingOnceList = $('#schedulingOnceList');
                        result.schedulingInfo.dtlList.forEach(function(dtlData) {
                            var $tr = $('<tr>');
                            $tr.append($('<td>').addClass('center').append(dtlData.exeSeq)); 	//차수
                            $tr.append($('<td>').addClass('center').append(dtlData.exeDt));		//실행일시
                            $tr.append($('<td>').addClass('center').append($.fn.ifvmNumberWithCommas(dtlData.exeTgtAmt)));	//대상수
                            
                            
                            $schedulingOnceList.append($tr);
                        });
                    }
                    else {
                        //데이터가 없습니다 
                        $('#schedulingOnceList').append(
                        	$('<tr>').append(
                        	        $('<td>').attr('colspan', '3').addClass('center').append('<spring:message code="M01099"/>')
                        	)
                       	);
                    }
                }
            }
            
            if (result.campaignDefaultInfo.camTypeCd == 'TRIGGER') {
                if ($.fn.ifvmIsNotEmpty(result.eventNodeList)) {
                    var rulePackList = result.eventNodeList;
                    var cnt = 0;
                    rulePackList.forEach(function(eventItem) {
                        //룰 테이블 1개 생성 
                        cnt++;
                        var data = {
                                cnt : cnt,
                                itemList : eventItem
                        }
                    	var ruleHtml = $('#ruleTemplate').tmpl(data);
                    	$('#ruleArea').append(ruleHtml);
                    });
                }
            }
            else {
                // 컨텐츠
                if ($.fn.ifvmIsNotEmpty(result.contsList)) {
                    $('#reportContsArea').show();
                    
                    if ($.fn.ifvmIsNotEmpty(result.contsList)
                            && result.contsList.length > 0 ) {
                        
                        var $contsList = $('#contsList');
                        result.contsList.forEach(function(dtlData) {
                            var $tr = $('<tr>');
                            $tr.append($('<td>').addClass('bg_gray').addClass('center').append(dtlData.exeChnlTypeNm));
                            if ((dtlData.exeChnlTypeCd == 'PUSH' && dtlData.contsPushTypeCd == 'HTML')
                                    || dtlData.exeChnlTypeCd == 'EMAIL'
                                    || dtlData.exeChnlTypeCd == 'TM') {
                                $tr.append($('<td>').append($('<button>').on('click', function() {
                                    contsHtmlPop(dtlData.contsId);
                                }).text('미리보기')));
                            }
    	                    else {
    	                        var contents = '';
    	                        var imgPath = '<%=BeansUtil.getApplicationProperty("icignal.context.imageServerUrl")%>/';
   	                        	if ($.fn.ifvmIsNotEmpty(dtlData.contsTitle))  contents += '<p>' + dtlData.contsTitle + '</p>';
    	                        
    	                        //이미지가 있을 경우
    	                       if ($.fn.ifvmIsNotEmpty(dtlData.imgId))
    	                    	    contents += "<p><img src = \'" + imgPath + dtlData.imgSrc + "\' id = 'mmsImage' width='140px' height='110px'></p>"
       	                        if ($.fn.ifvmIsNotEmpty(dtlData.subImgId))
       	                        	contents += "<p><img src = \'" + imgPath + dtlData.subImgSrc + "\' id = 'mmsImage' width='140px' height='110px'></p>"
       	                        	
    	                        if ($.fn.ifvmIsNotEmpty(dtlData.contsSbst))   contents += '<p>' + dtlData.contsSbst + '</p>';
    	                        if ($.fn.ifvmIsNotEmpty(dtlData.contsBottom)) contents += '<p>' + dtlData.contsBottom + '</p>';
    	                        
        	                    //영수증일 경우 
        	                    if (dtlData.exeChnlTypeCd == 'RECEIPT' ) {
        	                        if (dtlData.attrib02 == 'Y' ) contents += "<p><img src=\"<ifvm:image name='barcode_sample2'/>\" id='barcodimg'/></p>"
        	                        if (dtlData.attrib03 == 'Y' ) contents += "<p><img src=\"<ifvm:image name='qr_code_e1'/>\" id='qrcodimg'/></p>"
        	                    }
        	                    $tr.append($('<td>').append(contents));
                            }
                            $contsList.append($tr);
                        });
                    }
                    else {
                        //데이터가 없습니다 
                        $('#contsList').append(
                        	$('<tr>').append(
                        	        $('<td>').attr('colspan', '2').addClass('center').append('<spring:message code="M01099"/>')
                        	)
                       	);
                    }
                }
            }
            
			if ($.fn.ifvmIsNotEmpty(result.relCampaignList)) {
				$('#reportRelCampaignArea').show();
				
                if ($.fn.ifvmIsNotEmpty(result.relCampaignList)
                        && result.relCampaignList.length > 0 ) {
                    var $relCampaignList = $('#relCampaignList');
                    result.relCampaignList.forEach(function(dtlData) {
                        var $tr = $('<tr>');
                        $tr.append($('<td>').append(dtlData.camNm)); 	//차수
                        $tr.append($('<td>').addClass('center').append(dtlData.camStartDd + '~'+dtlData.camEndDd));	//실행일시
                        $tr.append($('<td>').addClass('center').append(dtlData.targetChnl)); //타겟채널
                        
                        $relCampaignList.append($tr);
                    });
                }
                else {
                    //데이터가 없습니다 
                    $('#relCampaignList').append(
                    	$('<tr>').append(
                    	    $('<td>').attr('colspan', '3').addClass('center').append('<spring:message code="M01099"/>')
                    	)
                   	);
                }
            }
        }
    });
}

/**
 * 숫자에 컴마 적용 
 */
function numberWithCommas(amt) {
    if ($.fn.ifvmIsNotEmpty(amt)) {
		return amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");   
    }
    else {
        return 0;
    }
}

function setSignArea(signData) {
    var template = $('#signItemTemplate').tmpl(signData);
    $('#signArea').append(template);
}

/**
 * 컨텐츠 HTML 팝업 호출 
 */
function contsHtmlPop(contsId) {
    var url = '<ifvm:url name="campaignReportHtml"/>?id=' + contsId
    window.open(url, 'contsHtmlPop', '');
}

$(document).ready(function() {
    initReportData();

	$('#btnPrint').on('click', function() {
		$.ifvPrintPartOfPage('printArea');
	});
});
</script>

<!-- 서명란 템플릿 -->
<script id="signItemTemplate" type="text/x-jquery-tmpl">
<li>
<div class="sign">
    <p>승인자${'${'}cnt}</p>
</div>
<div class="sign">
    <p>${'${'}name}</p>
</div>
</li>
</script>

<script id="ruleTemplate" type="text/x-jquery-tmpl">
<div class="popup-table well form-horizontal">
    <div class="table_label_area">
        <div>
            <span>룰 - ${'${'}cnt}</span>
        </div>
    </div>
    <div class="table_wrap">
      <table>
         <caption></caption>
         <colgroup>
            <col style="width: 10%;"/>
            <col style="width: 10%;"/>
            <col style="width: 35%;"/>
            <col style="width: 10%;"/>
            <col style="width: 35%;"/>
         </colgroup>
         <tbody id="ruleTBody">
			{{each(key, item) itemList}}
                {{if item.nodeTypeCd == "ETCOND" && item.ruleInfo != null }}
                <tr>
                   <th rowspan="2">Rule</th>
                   <td class="bg_gray">Rule 유형</td>
                   <td>${'${'}item.ruleInfo.typeNm}</td>
                   <td class="bg_gray">Rule 명</td>
                   <td>${'${'}item.ruleInfo.title}</td>
                </tr>
                <tr>
                   <td class="bg_gray">내용</td>
                   <td colspan="3">
                      <p>${'${'}item.ruleInfo.desctxt}</p>
                   </td>
                </tr>
				{{/if}}
                {{if item.nodeTypeCd == "ETACT" && item.ruleInfo != null }}
                <tr>
                    <th rowspan="3">액션</th>
                    <td class="bg_gray">액션명</td>
                    <td colspan="3">${'${'}item.ruleInfo.title}</td>
				</tr>
				<tr>
                    <td class="bg_gray">액션유형</td>
                    <td>${'${'}item.ruleInfo.typeNm}</td>
					{{if item.type == "OFF" }}
                    <td class="bg_gray">오퍼명</td>
                    <td>${'${'}item.ruleInfo.offerNm}</td>
					{{else}}
                    <td class="bg_gray">Function 명</td>
                    <td>${'${'}item.ruleInfo.subInputScrn}</td>
					{{/if}}
                </tr>
                <tr>
                    <td class="bg_gray">설명</td>
                    <td colspan="3">
                        <p>${'${'}item.ruleInfo.desctxt}</p>
                    </td>
                </tr>
				{{/if}}
                {{if item.nodeTypeCd != "ETACT" && item.nodeTypeCd != "ETCOND" && item.chnlInfo != null }}
                <tr>
                    <th>채널<br/>(${'${'}item.chnlInfo.exeChnlTypeNm})</th>
                    <td colspan="4">
						{{if (item.chnlInfo.exeChnlTypeCd == "PUSH" && item.chnlInfo.exeChnlTypeCd == "HTML")
							|| item.chnlInfo.exeChnlTypeCd == 'EMAIL' || item.chnlInfo.exeChnlTypeCd == 'TM'}}
						<button onclick="contsHtmlPop('${'${'}item.chnlInfo.contsId}')">미리보기</button>
						{{else}}
                        <p>${'${'}item.chnlInfo.contsTitle}</p>
                        <p>${'${'}item.chnlInfo.contsSbst}</p>
                        <p>${'${'}item.chnlInfo.contsBottom}</p>
						{{/if}}
                    </td>
                </tr>
				{{/if}}
			{{/each}}
		 </tbody>
      </table>
   </div>
</div>
</script>

<div class="page_btn_area">
	<div class="col-xs-12 searchbtn_r">
		<ifvm:inputNew type="button" btnType="print" text="프린트" id="btnPrint" nuc="true" />
	</div>
</div>

<div id="printArea">
	<link href="/resources/css/marketing/printPopup.css" rel="stylesheet" media="print"/>
	<link href="/resources/css/marketing/printPopupDefault.css" rel="stylesheet" media="screen"/>
    <div class="title-campaign">
        <div class="title">
            <h1 id="campaignTitle"></h1>
        </div>
        <%-- <div class="sign-area">
            <ul id="signArea">
                <li>
                	<div class="sign">
                        <p><spring:message code="L00668"/></p>
                    </div>
                	<div class="sign">
                        <p><span id="rqtrNm"></span></p>
                    </div>
                </li>
            </ul>
		</div> --%>
    </div>
    
    <div class="popup-table well form-horizontal" >
        <div class="table_wrap">
            <table>
                <caption></caption>
                <colgroup>
                    <col style="width: 10%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
             	</colgroup>
             	<tbody>
                	<tr>
                   		<th rowspan="4" ><spring:message code="M00556"/></th>
                   		<td class="bg_gray"><spring:message code="M02747"/></td>
                   		<td class="center" ><span id="campaignTerm"></span></td>
                   		<td class="bg_gray"><spring:message code="L00155"/></td>
                   		<td><span id="camTypeNm"></span></td>
                	</tr>
                	<tr>
	                	<%-- 내용 --%>
	                   	<td class="bg_gray" ><spring:message code="M01892"/></td>
	                   	<td colspan="3" id="camDesc"></td>
	                </tr>
	                <tr>
	                	<%-- 조직 --%>
	                    <%-- td class="bg_gray"><spring:message code="M02455"/></td>
	                    <td><span id="camScopeTypeNm"></span></td> --%>
	                    
	                    <%-- 프로모션 여부 --%>
	                    <%-- <td class="bg_gray"><spring:message code="M02486"/></td>
	                    <td><input type="checkbox" disabled id="promYn"/></td> --%>
	                    
	                    <%-- 승인상태 --%>
	                    <td class="bg_gray"><spring:message code="M02639"/></td>
	                    <td><span id="oldAprStatCd"></span></td>
	                    
	                    <%-- 등록자 --%>
	                    <td class="bg_gray"><spring:message code="M00221"/></td>
	                    <td><span id="camPlner"></span></td>
	                </tr>
	                <tr>
	                	<%-- 이벤트 트리거 유형     --%>
	                    <%-- <td class="bg_gray"><spring:message code="M02456"/></td>
	                    <td><span id="intactType2Nm"></span></td> --%>
	                    
	                    <%-- 퍼미션 미적용 --%>
	                    <td class="bg_gray"><spring:message code="M02310"/></td>
	                    <td><input type="checkbox" disabled id="prmsExceptYn"/></td>
	                    
	                    <%-- 피로도 미적용 --%>
	                    <td class="bg_gray"><spring:message code="M02732"/></td>
	                    <td><input type="checkbox" disabled id="fatiExceptYn"/></td>
	                </tr>
             	</tbody>
          	</table>
       	</div>
    </div>
    
    <div class="popup-table well form-horizontal" id="reportOfferArea">
        <div class="table_label_area">
            <div>
                <span><spring:message code="L00159"/></span>
            </div>
        </div>
        <div class="table_wrap">
            <table>
                <caption></caption>
                <colgroup>
                    <col style="width: 10%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                 </colgroup>
                <tbody>
                    <tr>
                       	<th rowspan="2"><spring:message code="M00556"/></th>
                       	
                       	<%-- 오퍼명 --%>
                       	<td class="bg_gray"><spring:message code="M01870"/></td>
                       	<td><span id="offerNm"></span></td>
                       	
                       	<%-- 오퍼유형 --%>
                       	<td class="bg_gray"><spring:message code="M01872"/></td>
                       	<td><span id="offerTypeNm"></span></td>
                    </tr>
                    <%-- <tr>
                    	참조값
                       	<td class="bg_gray"><spring:message code="M02274"/></td>
                       	<td><span id="prodNm"></span></td>
                       	
                       	오퍼유형상세
                       	<td class="bg_gray"><spring:message code="M01896"/></td>
                       	<td><span id="offerSubTypeNm"></span></td>
                    </tr> --%>
                    <tr>
                    	<%-- 재원 --%>
                       	<td class="bg_gray"><spring:message code="M02276"/></td>
                       	<td><span id="dividName"></span></td>
                       	
                       	<%-- 분담율 --%>
                       	<td class="bg_gray"><spring:message code="M02289"/></td>
                       	<td><span id="divIdVal"></span></td>
                       	
                       	<%-- 사용처 --%>
                       	<%-- <td class="bg_gray"><spring:message code="M02275"/></td>
                       	<td><span id="offerUseDeskDivNm"></span></td> --%>
                    </tr>
					<tr>
						<%-- 포인트 정책 --%>
                       	<th rowspan="2"><spring:message code="M02894"/></th>
                       	
                       	<%-- 기준일자  유형--%>
                       	<td class="bg_gray"><spring:message code="M02895"/></td>
                       	<td><span id="vsBasCd"></span></td>
                       	
                       	<%-- 혜택시작일 --%>
                       	<td class="bg_gray"><spring:message code="L00265"/></td>
                       	<td><span id="startDtnum"></span></td>
                    </tr>
                    <tr>
                    	<%-- 소멸예정월 --%>
                        <td class="bg_gray"><spring:message code="L00260"/></td>
                        <td><span id="vsDtnum"></span></td>
                        
                        <td class="bg_gray"></td>
                    	<td></td>
                    </tr>
                    <tr>
						<%-- 포인트 쿠폰 --%>
                       	<th rowspan="4"><spring:message code="M02902"/></th>
                       	
                       	<%-- 쿠폰기간--%>
                       	<td class="bg_gray"><spring:message code="M02903"/></td>
                       	<td><span id="couponTerm"></span></td>
                       	
                       	<%-- 혜택 포인트 --%>
                       	<td class="bg_gray"><spring:message code="M02901"/></td>
                       	<td><span id="selfTotAmt"></span></td>
                    </tr>
                    <tr>
                    	<%-- 쿠폰유의사항1 --%>
                        <td class="bg_gray"><spring:message code="M02898"/></td>
                        <td colspan="3"><span id="offerNotiOne"></span></td>
                    </tr>
                    <tr>
                    	<%-- 쿠폰유의사항2 --%>
                        <td class="bg_gray"><spring:message code="M02899"/></td>
                        <td colspan="3"><span id="offerNotiTwo"></span></td>
                    </tr>
                    <tr>
                    	<%-- 쿠폰유의사항3 --%>
                        <td class="bg_gray"><spring:message code="M02900"/></td>
                        <td colspan="3"><span id="offerNotiThree"></span></td>
                    </tr>
				</tbody>
			</table>
			
            <%-- <table id="reportCoupnTable" style="margin-top: 2px;">
                <caption></caption>
                <colgroup>
                    <col style="width: 10%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                 </colgroup>
                <tbody>                    
                    <tr>
                       	<th rowspan="3"><spring:message code="M02749"/></th>
                       	
                       	쿠폰명
                       	<td class="bg_gray"><spring:message code="L02116"/></td>
                       	<td><span id="coupnNm"></span></td>
                       	
                       	사용기간
                       	<td class="bg_gray"><spring:message code="M02748"/></td>
                       	<td><span id="coupnTerm"></span></td>
                    </tr>
                    <tr>
                       	쿠폰설명
                    	<td class="bg_gray"><spring:message code="L02117"/></td>
                        <td colspan="3"><span id="coupnDesc"></span></td>
                    </tr>
                    <tr>
                       	사용안내
                        <td class="bg_gray"><spring:message code="S00067"/></td>
                        <td colspan="3"><span id="coupnUseGdnc"></span></td>
                    </tr>
                </tbody>
            </table> --%>
        </div>
    </div>
    
    <div class="popup-table well form-horizontal" id="reportTargetingArea">
        <div class="table_label_area">
            <div>
                <span><spring:message code="M02750"/></span>
            </div>
        </div>
        <div class="table_wrap">
            <table>
                <caption></caption>
                <colgroup>
                    <col style="width: 10%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                 </colgroup>
                <tbody>
                    <tr>
                       <th rowspan="2"><spring:message code="M00556"/></th>
                       
                       <%-- 타켓팅 유형 --%>
                       <td class="bg_gray"><spring:message code="M00746"/></td>
                       <td><span id="camTgtTypeNm"></span></td>
                       
                       <%-- 대상자 --%>
                       <td class="bg_gray"><spring:message code="M00746"/></td>
                       <td><span id="camTgtCnt"></span></td>
                    </tr>
                    <tr>
                       <%-- 설명 --%>
                       <td class="bg_gray"><spring:message code="L00340"/></td>
                       <td colspan="3"><span id="tgtGroupDesc"></span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="popup-table well form-horizontal" id="reportPromArea">
        <div class="table_label_area">
            <div>
                <span>프로모션 정보</span>
            </div>
        </div>
        <div class="table_wrap">
            <table>
                <caption></caption>
                <colgroup>
                    <col style="width: 10%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                    <col style="width: 10%;"/>
                    <col style="width: 35%;"/>
                 </colgroup>
                <tbody>
                    <tr>
                    	<%-- 기본정보 --%>
                        <th rowspan="2"><spring:message code="M00556"/></th>
                        
                        <%-- 시작일시 --%>
                        <td class="bg_gray"><spring:message code="L00340"/></td>
                        <td><span id="promStartDt"></span></td>
                        
                        <%-- 종료일시 --%>
                        <td class="bg_gray"><spring:message code="V00028"/></td>
                        <td><span id="promEndDt"></span></td>
                    </tr>
                    <tr>
                    	<%-- 반복주기 --%>
                        <td class="bg_gray"><spring:message code="M00893"/></td>
                        <td><span id="promCycl"></span></td>
                        
                    	<%-- 프로모션 유형 --%>
                        <td class="bg_gray"><spring:message code="L00589"/></td>
                        <td><span id="promTypeNm"></span></td>
                    </tr>
                    <tr>
                        <th rowspan="3">보상</th>
                        
                    	<%-- 보상유형 --%>
                        <td class="bg_gray"><spring:message code="M02656"/></td>
                        <td><span id="acrlTypeNm"></span></td>
                        
                    	<%-- 금액/율 --%>
                        <td class="bg_gray"><spring:message code="M02657"/></td>
                        <td><span id="acrlAmt"></span></td>
                    </tr>
                    <tr>
                    	<%-- 제휴사명 --%>
                        <td class="bg_gray"><spring:message code="M02658"/></td>
                        <td><span id="allianceTypeNm"></span></td>
                        
                    	<%-- 월한도포인트 --%>
                        <td class="bg_gray"><spring:message code="M02659"/></td>
                        <td><span id="monthLmtPoint"></span></td>
                    </tr>
                    <tr>
                    	<%-- 설명 --%>
                        <td class="bg_gray"><spring:message code="I00075"/></td>
                        <td colspan="3"><span id="rulesetDesc"></span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- 한 번 실행할 경우 -->
    <div class="popup-table well form-horizontal" id="reportSchedulingOnce">
        <div class="table_label_area">
            <div>
                <span><spring:message code="M02503"/> - <spring:message code="M00875"/></span>
            </div>
        </div>
       <div class="table_wrap">
          <table>
             <caption></caption>
             <colgroup>
                <col style="width: 15;"/>
                <col style="width: 42.5%;"/>
                <col style="width: 42.5%;"/>
             </colgroup>
             <thead>
             	<tr>
	                <th><spring:message code="M00889"/></th>
	                <th><spring:message code="M00890"/></th>
	                <th><spring:message code="M00881"/></th>
                </tr>
             </thead>
             <tbody id="schedulingOnceList"></tbody>
          </table>
       </div>
    </div>
    <!-- //한 번 실행할 경우 -->
    
    <!-- 반복 실행할 경우 -->
    <div class="popup-table well form-horizontal" id="reportSchedulingRepeat">
        <div class="table_label_area">
            <div>
                <span>실행일정 - 반복실행</span>
            </div>
        </div>
       <div class="table_wrap">
          <table>
             <caption></caption>
             <colgroup>
                <col style="width: 10%;"/>
                <col style="width: 35%;"/>
                <col style="width: 10%;"/>
                <col style="width: 35%;"/>
             </colgroup>
             <tbody>
                <tr>
                	<%-- 실행시작일자 --%>
                    <td class="bg_gray">실행시작일자</td>
                    <td class="center"><span id="exeStartDd"></span></td>
                    
                	<%-- 실행종료일자 --%>
                    <td class="bg_gray">실행종료일자</td>
                    <td class="center"><span id="exeEndDd"></span></td>
                </tr>
                <tr>
                	<%-- 반복주기 --%>
                    <td class="bg_gray">반복주기</td>
                    <td><span id="exeRepeatInfo"></span></td><!-- 월/수/금 , 매월 05일 , 매월말일 -->
                    
                	<%-- 실행시간 --%>
                    <td class="bg_gray">실행시간</td>
                    <td class="center"><span id="exeHour"></span></td>
                </tr>
                <tr>
                	<%-- 분할옵션 --%>
                    <td class="bg_gray">분할옵션</td>
                    <td colspan="3"><span id="exeDivInfo"></span></td><!-- 00:00 마다 1회 [ ]건, 최대 [ ] 건 -->
                </tr>
             
             </tbody>
          </table>
       </div>
    </div>
    <!-- //반복 실행할 경우 -->
    
	<%-- 컨텐츠 --%>
    <div class="popup-table well form-horizontal" id="reportContsArea">
        <div class="table_label_area">
            <div>
                <span>콘텐츠</span>
            </div>
        </div>
        <div class="table_wrap">
            <table>
                <caption></caption>
                <colgroup>
                    <col style="width: 10%;"/>
                    <col style="width: 90%;"/>
                 </colgroup>
                <tbody id="contsList"></tbody>
            </table>
        </div>
    </div>

	<!-- 이벤트 트리거 -->
    <div id="ruleArea"></div>

    <div class="popup-table well form-horizontal" id="reportRelCampaignArea">
        <div class="table_label_area">
            <div>
                <span>연관 캠페인 정보</span>
            </div>
        </div>
        <div class="table_wrap">
            <table>
                <caption></caption>
                <colgroup>
                    <col style="width: 40%;"/>
                    <col style="width: 20%;"/>
                    <col style="width: 40%;"/>
                </colgroup>
                <thead>
                	<tr>
	                    <th>캠페인</th>
	                    <th>기간</th>
	                    <th>대상 채널</th>
                    </tr>
                </thead>
                <tbody id="relCampaignList"></tbody>
            </table>
        </div>
    </div>

</div>
