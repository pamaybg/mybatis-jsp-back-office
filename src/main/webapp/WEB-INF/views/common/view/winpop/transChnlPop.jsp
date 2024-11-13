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
<div class="pop_inner_wrap">
	<div class="page_btn_area" id="headForm">
		<div class="col-xs-2">
			<span><spring:message code="L01791"/></span><!-- 채널 전송 -->
		</div>
		<div class="col-xs-10 searchbtn_r">
		    <ifvm:inputNew type="button" text="L01805" btnFunc="gTransChnl.transChnl" />
		</div>
	</div>
	<div class="form-horizontal underline half_wrap top_well" id="transChnlPopWrap">
		<div class="form-horizontal">
			<div class="page_btn_area">
				<div class="row col-xs-5">
					<span><spring:message code="L01793"/></span><!-- 수신자 정보 조회 -->
				</div>
				<div class="col-xs-7 searchbtn_r">
					<ifvm:inputNew type="button" btnFunc="mbrSearchHelpPop.pop" text="L01794" /><!-- 회원조회 -->
				</div>
				<script>
					mbrSearchHelpPop = {
							id : "searchMbrPopCon",
							pop : function(){
								$("#"+this.id).ifvsfPopup({
						            enableModal : true,
						            enableResize : false,
						            contentUrl : '<ifvm:url name="mbrSearchHelp"/>',
						            contentType : "ajax",
						            title : '<spring:message code="L00988"/>', // 회원 찾기
						            width : '700px'
						        });
							},
							beforeClose : function(obj){
								var url = '<ifvm:url name="transChnlPop"/>';
								url += '?ridMbr='+obj.rid;
								qtjs.href(url);
								//수신동의 정보 가져와야 해서 리로드...일단 지우지 마세요
								/* gTransChnl.mbrInfo = obj;
								$("#transChnlPopWrap #mbrNo").val(obj.mbrNo);
								$("#transChnlPopWrap #custNm").val(obj.custNm);
								$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
									{ type : 'mbr', field : 'phone', rid : obj.rid },
									function(result) {
										gTransChnl.mbrInfo.hhpNo = result.message
										$("#transChnlSmsWrap #hhpNo").val(gTransChnl.mbrInfo.hhpNo);
								});
								$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
									{ type : 'mbr', field : 'email', rid : obj.rid },
									function(result) {
										gTransChnl.mbrInfo.emailAddr = result.message
										$("#transChnlEmailWrap #email").val(gTransChnl.mbrInfo.emailAddr);
								}); */
							},
							close: function(obj){
								if(obj){
									this.beforeClose(obj)
								}
								var _popObj = eval(this.id)
								_popObj._destroy();
							}
					}
		         </script>
			</div>
			<div class="form-horizontal top_well clearfix" id="" >
				<div clasa="row clearfix">
					<ifvm:inputNew type="singleCheckbox" id="appNewsYn" label="L01201" values="appNewsYn"	disabled="true"
						dto="appNewsYn" 	labelClass="2" conClass="1" /><!-- App 기본수신동의 -->
					<ifvm:inputNew type="singleCheckbox" id="appBenefitYn" label="L01204" values="appBenefitYn"	disabled="true"
						dto="appBenefitYn" 	labelClass="2" conClass="1" /><!-- App 혜택수신동의 -->
					<ifvm:inputNew type="text" id="mbrNo"   dto="mbrNo"    disabled="true"
						label="L01798" labelClass="2" conClass="3" /><!-- 회원번호 -->

				</div>
				<div clasa="row clearfix">
					<ifvm:inputNew type="singleCheckbox" id="chnlAgreSms" label="L01195" values="chnlAgreSms"	disabled="true"
						dto="chnlAgreSms" 	labelClass="2" conClass="1" /><!-- SMS 수신동의 -->
					<ifvm:inputNew type="singleCheckbox" id="chnlAgreEmail" label="L01198" values="chnlAgreEmail"	disabled="true"
						dto="chnlAgreEmail" 	labelClass="2" conClass="1" /><!-- EMAIL 수신동의 -->
					<ifvm:inputNew type="text" id="custNm"   dto="custNm"    disabled="true"
						label="L01799" labelClass="2" conClass="3" /><!-- 회원명 -->
				</div>
			</div>
		</div>
		<div class="form-horizontal clearfix">
			<!--나의 전송 요약정보  -->
			<div class="page_btn_area">

				<div class="row col-xs-12">
					<span><spring:message code="L01795"/></span><!-- 전송 채널 선택 및 정보 입력 -->
				</div>
			</div>
			<div id="tabArea">
				<!-- 탭 컨텐츠 -->
				<div id="tabContent" class="white_bg grid_bd0"></div>
			</div>

		</div>
	</div>
</div>

<div id="searchMbrPopCon" class="popup_container"></div><!--검색-->


<script>
var ridMbr = '<%= cleanXss(request.getParameter("ridMbr")) %>';
var ridCust = '<%= cleanXss(request.getParameter("ridCust")) %>';
var vocRid = '<%= cleanXss(request.getParameter("vocRid")) %>';
var sendType = '<%= cleanXss(request.getParameter("sendType")) %>';
var hpNo = '<%= cleanXss(request.getParameter("hpNo")) %>';
var email = '<%= cleanXss(request.getParameter("email")) %>';
var ridVocReq = '<%= cleanXss(request.getParameter("ridVocReq")) %>';
var rejectHtml = '';

if(sendType =='email') {
	var transChnlTab = $('#transChnlPopWrap #tabArea').DrawTab({
		item: [
			{label: '<spring:message code="L01802"/>', href: '<ifvm:url name="transChnlEmail"/>'}, //email
			{label: '<spring:message code="L01801"/>', href: '<ifvm:url name="transChnlSms"/>'} //sms
		]
	});
}
else{
	var transChnlTab = $('#transChnlPopWrap #tabArea').DrawTab({
		item: [
			{label: '<spring:message code="L01801"/>', href: '<ifvm:url name="transChnlSms"/>'}, //sms
			{label: '<spring:message code="L01802"/>', href: '<ifvm:url name="transChnlEmail"/>'} //email
		]
	});
}


gTransChnl = {
		checkBoxIds : ['chnlAgreSms','chnlAgreEmail', 'appBenefitYn', 'appNewsYn'],
		setCheckBox : function(result){
			for(i in gTransChnl.checkBoxIds){
				if(result[gTransChnl.checkBoxIds[i]] != "" && result[gTransChnl.checkBoxIds[i]] != null && (result[gTransChnl.checkBoxIds[i]]).toUpperCase() == "Y"){
					$("#transChnlPopWrap input[type='checkbox'][value='"+gTransChnl.checkBoxIds[i]+"']").prop('checked',true);
				}
			}
		},
		sms : {

		},
		email : {

		},
		mbrInfo : {

		},
		init : function(){
			//로그인 한 유저의 전송 요약정보 가져오기

			//넘어온 mbrNo존재시 데이터 셋팅
			if(ridMbr != "null" || ridCust != "null"){
				if(ridMbr != "null") {
					var data = {
						rid : ridMbr
					}
				}
				if(ridCust != "null") {
					var data = {
							ridCust : ridCust
					}
				}
				$.ifvSyncPostJSON('<ifvm:action name="getMbrDetail"/>', data , function(result) {

		        	if ($.fn.ifvmIsNotEmpty(result)) {
		        		gTransChnl.mbrInfo = result;
		        		$("#transChnlPopWrap #mbrNo").val(result.mbrNo);
		        		$("#transChnlPopWrap #custNm").val(result.custNm);
		        		if(result.hhpNo){
		        			$("#transChnlPopWrap #hhpNo").val(result.hhpNo);
		            		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
		    						{ type : 'mbr', field : 'phone', rid : result.rid },
		    						function(result) {
		    							gTransChnl.mbrInfo.hhpNo = result.message
		    							$("#transChnlSmsWrap #hhpNo").val(gTransChnl.mbrInfo.hhpNo);
		    					});
		        		}
		        		if(result.emailAddr){
		        			$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
									{ type : 'mbr', field : 'email', rid : result.rid },
									function(result) {
										gTransChnl.mbrInfo.emailAddr = result.message
										$("#transChnlEmailWrap #email").val(gTransChnl.mbrInfo.emailAddr);
								});
		        		}

						gTransChnl.setCheckBox(result);

						//var emailDt = gTransChnl.mbrInfo.chnlAgreEmailDt.split(' ')[0];
						//var emailDate = new Date(emailDt);




						/* rejectHtml += '<tr><!-- footer -->'
						rejectHtml += '		<td width="100%">';
						rejectHtml += '			<table border="0" cellspacing="0" cellpadding="0" width="100%">';
						rejectHtml += '				<tr>';
						rejectHtml += '					<td width="30" rowspan="4" bgcolor="#ffffff"></td>';
						rejectHtml += '					<td height="1" bgcolor="#f8f8f8"></td>';
						rejectHtml += '					<td width="30"  rowspan="4" bgcolor="#ffffff"></td>';
						rejectHtml += '				</tr>';
						rejectHtml += '				<tr>';
						rejectHtml += ' 				<td height="29"  bgcolor="#ffffff"></td>';
						rejectHtml += '				</tr>';
						rejectHtml += '				<tr>';
						rejectHtml += '					<td align="left" valign="top"  bgcolor="#ffffff" style="font-family:"돋움",Dotum,sans-serif; font-weight:400; color:#777; font-size:14px; line-height:170%; letter-spacing:-1px">';
						rejectHtml += ' 					본 메일은 정보통신망 이용촉진 및 정보보호 등에 관한 법룰 시행규칙에 의거하여 고객님께서 <span style="font-weight:700; color:#666;vertical-align:middle">';
						rejectHtml += emailDate.getFullYear()+'년 '+(emailDate.getMonth()+1)+'월 '+emailDate.getDate()+'일';
						rejectHtml += '							</span> 에 메일 수신을 동의하셨기에 발송되었습니다. 메일을 원치 않을 경우 <a href="#"  target="_blank" title="새창"  style="vertical-align:middle" ><img src="../resources/img/link_dm_norecive.gif" alt="수신거부" width="64" height="20" border="0"  style="vertical-align:top" ></a>를 클릭해 주시기 바랍니다. <br> 변경된 정보가 있으시면 <a href="#" target="_blank" title="새창" style="vertical-align:middle"><img src="../resources/img/link_dm_change.gif" alt="회원정보수정" width="86" height="20" border="0"  style="vertical-align:top" ></a>을 클릭해 주십시오.';
						rejectHtml += '					</td>';
						rejectHtml += '				</tr>';
						rejectHtml += '				<tr>';
						rejectHtml += '					<td height="29"  bgcolor="#ffffff"></td>';
						rejectHtml += '				</tr>';
						rejectHtml += '				<tr>';
						rejectHtml += '					<td height="20"  bgcolor="#f8f8f8" colspan="3"></td>';
						rejectHtml += '				</tr>';
						rejectHtml += '				<tr>';
						rejectHtml += '					<td align="center" valign="top" colspan="3" bgcolor="#f8f8f8" ><img src="../resources/img/img_dm_footer.gif" alt="Copyright  E1 Corporation. All Rights Reserved." style="vertical-align:middle" border="0"></td>';
						rejectHtml += '				</tr>';
						rejectHtml += '				<tr>';
						rejectHtml += '					<td height="20"  bgcolor="#f8f8f8"  colspan="3"></td>';
						rejectHtml += '				</tr>';
						rejectHtml += '			</table>';
						rejectHtml += '		</td>';
						rejectHtml += '	</tr>'; */


		        	}
		        }, function(result){
		        	alert(result.message);
		        })
			}


			if(sendType == 'email'){
				if(email != 'null'){

					$("#email").val(email);

				}

			}else if(sendType == 'sms') {
				if(hpNo != 'null'){
				 	var hypenHpNo = gTransChnl_sms.autoHypenPhone(hpNo+'');
					$("#hhpNo").val(hypenHpNo);
				}
			}
			$("#transChnlPopWrap #hhpNo").trigger('keyup');



		},
		close : function(){
			window.close();
		},
		transChnl : function(){
			var vali = $("#transChnlPopWrap").ifvValidation();
			var userInfo = $.ifvmGetUserInfo();
			if(vali.confirm()){
				var data = {}
				var chnlType = $("#tabArea .tab-list li.on a").text().toLowerCase();
				switch(chnlType){
				case "email":
					data = {
						chnlType :chnlType,
						msgType : $("#transChnlEmailWrap #msgType").val(),
						mbrNo : (gTransChnl.mbrInfo.mbrNo)?gTransChnl.mbrInfo.mbrNo:"",
						ridMbr : (gTransChnl.mbrInfo.rid)?gTransChnl.mbrInfo.rid:"",
						ridCust : (gTransChnl.mbrInfo.ridCust)?gTransChnl.mbrInfo.ridCust:"",
						emailAddr : $("#transChnlEmailWrap #email").val(),
						comment : rteeObj.getHtml(),
						creatorLogin : userInfo.userId,
						ridVocReq : ridVocReq,
						senderEmail : "e1@e1.co.kr",
						emailTitle :$("#transChnlEmailWrap #title").val(),
						mailSuppressDt : (gTransChnl.mbrInfo.chnlAgreEmailDt)?gTransChnl.mbrInfo.chnlAgreEmailDt.split(' ')[0].replaceAll("-", ""):""
					}
					//data.comment += '<br>'+rejectHtml;

					if( $("#transChnlEmailWrap #msgType").val()== "E002" && !$("#chnlAgreEmail").prop('checked')){
						alert('<spring:message code="L02095"/>'); //EMAIL 수신동의를 하지 않은 고객입니다.
						return;
					}
					if($("#transChnlEmailWrap #msgType").val()== "E002"){
						data.emailTitle = '<spring:message code="L02111"/>' + data.emailTitle; // (광고)[E1오렌지카드]

					}else if($("#transChnlEmailWrap #msgType").val()== "E001"){
						data.emailTitle = '<spring:message code="L02185"/>' + data.emailTitle;//[E1오렌지카드]
					}
					break;
				case "sms":
					var callBackNo = "";
					var comment = $("#smsArea").val() + $("#mmsTextArea").val() + $("#blockInfo").val();
					if($("#textByteSize").text() >=80){
						chnlType = "lms"
					}
					$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
			    		groupCode : 'SMS_CALL_BACK',
			    		codeName : 'SR'
			    } , function(result) {

			        	if (result.success) {
			        		callBackNo = result.rows[0].markName;
			        	}
			        }, function(result){
			        	alert(result.message);
			        })
					data = {
						chnlType :chnlType,
						msgType : $("#transChnlSmsWrap #msgType").val(),
						mbrNo : (gTransChnl.mbrInfo.mbrNo)?gTransChnl.mbrInfo.mbrNo:"",
						ridMbr : (gTransChnl.mbrInfo.rid)?gTransChnl.mbrInfo.rid:"",
						ridCust : (gTransChnl.mbrInfo.ridCust)?gTransChnl.mbrInfo.ridCust:"",
						hhpNo : $("#transChnlSmsWrap #hhpNo").val().replaceAll('-',''),
						comment : comment,
						creatorLogin : userInfo.userId,
						ridVocReq : ridVocReq,
						callBackNo :callBackNo
					}
					if($("#transChnlSmsWrap #msgType").val()== "S002" && !$("#chnlAgreSms").prop('checked')){
						alert('<spring:message code="L02096"/>');
						return;
					}
					break;
				}

				if(data.comment == ""){
					alert('<spring:message code="L01915"/>');
					return;
				}

				if(!confirm('<spring:message code="L02004"/>')){
					return;
				}
				$.ifvSyncPostJSON('<ifvm:action name="transChnl"/>', data , function(result) {

		        	if (result.success) {
						alert('<spring:message code="L01914"/>');
						gTransChnl.close();

		        	}
		        }, function(result){
		        	alert(result.message);
		        })
			}

		}
}
$(document).ready(function(){
	gTransChnl.init();
})


</script>
