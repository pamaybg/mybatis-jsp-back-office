<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap" id="vocDetailWrap">
	<div class="page_btn_area" id="headForm">
		<div class="col-xs-2">
			<span><spring:message code="L01370"/></span><!-- 상담상세 -->
		</div>
		<div class="col-xs-10 searchbtn_r">
			<ifvm:inputNew type="button" id="listenRecordBtn"	btnFunc="listenRecord" text="L00984" />
			<ifvm:inputNew type="button" id="completeBtn"  text="V00014" btnFunc="clickCompleteBtn"	disabled="true" />
    		<ifvm:inputNew type="button" btnType="save"	text="L01780" btnFunc="gVocDetail.save" />

		</div>
		<script>
	        function listenRecord(){
				var url = '<ifvm:url name="playRecordFilePop"/>';
				//url += '?callId='+selectedObj.callId+'&callDate='+selectedObj.chnlSendDt;
				//url += '?callId=181&callDate=2018-01-06 14:01:10';
				url += '?callId='+$("#detail_callId").val()+'&callDate='+$("#detail_receptionDate").val();
				  $("#playRecordFilePop").ifvsfPopup({
				     enableModal : true,
				     enableResize: false,
				     contentUrl: url,
				     contentType: "ajax",
				     title: "<spring:message code='V00158'/>",
				     width: 600,
				     close : 'playRecordFilePopClose'
				  });

	        }
	        function clickCompleteBtn(){

	        	if(gVocDetail.data.srTrtStatus == "Closed"){
	        		alert('<spring:message code="V00214"/>'); //이미 완료된 목록은 다시 완료 처리할 수 없습니다.
	        	}else{
	        		if(confirm('<spring:message code="V00221"/>') == true){
	        			var objectRidList =[gVocDetail.data.rid]
		        		$.ifvSyncPostJSON('<ifvm:action name="modifyRequestConsultation"/>',{
		        			srTrtStatus : "Closed"
		        			, ridList : objectRidList
		        		},function(result) {
		        			if(result.success){
		        				alert('<spring:message code="V00202"/>');
		        				gVocDetail.loadData();
		        			}else{
		        				alert('<spring:message code="M02248"/>');
		        			}
		        		});
	        		}
	        	}
	        }

        </script>
	</div>
	<div class="form-horizontal well">
		<div class="row">
			<!-- SR정보 -->
			<div class="col-xs-6 dataWrap">
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span><spring:message code="V00030"/></span>
					</div>
				</div>
				<div class="form-horizontal">
					<div id='srInfoWrap'>
						<div class="row">
							<ifvm:inputNew type="text" id="detail_srNo"	dto="srNo"
								label="V00016" labelClass="2" conClass="3" disabled="true"/><!--SR번호 -->
							<ifvm:inputNew type="text" id="detail_contactInfo"	dto="cntcDesk"	maxLength="13"
								label="V00009" labelClass="2" conClass="3" /><!--연락처 -->

							<div class="col-xs-2 middle">
								<ifvm:inputNew type="button" id="callConNo" nuc="" btnType="phone" btnFunc="makeCallForContactInfo" className="btn-imgonly"	disabled="true"/>
								<%-- <ifvm:inputNew type="button" id="msgConNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForConNo" className="btn-imgonly"/> --%>
							</div>
						</div>
						<div class="row">
							<ifvm:inputNew type="hidden" id="ridMbr"	dto="ridMbr" />
							<ifvm:inputNew type="hidden" id="detail_ridCust"	dto="ridCust" />
							<ifvm:inputNew type="search" id="memNo|mbrNoSearch"	dto="memNo"
								btnFunc="mbrSearchHelpBtn" searchBlurEvent="mbrSearchHelpBlur" searchEnterEvent="mbrSearchHelpEnter" label="L00797"  labelClass="2" conClass="3" />
							<%-- <ifvm:inputNew type="search" id="detail_memNo" names="detail_memNo" objCode="SRCH" dto="detail_memNo" btnFunc="showMemPop" label="V00004" labelClass="2" conClass="3" /> --%>
							<ifvm:inputNew type="text" id="detail_phoneNo"	dto="memPtblNo"		maxLength="13"
								label="V00006" labelClass="2" conClass="3" />
							<div class="col-xs-2 middle">
								<ifvm:inputNew type="button" id="callHpNo" nuc="" btnType="phone" btnFunc="makeCallForHhpNo" className="btn-imgonly"	disabled="true"/>
								<ifvm:inputNew type="button" id="msgHpNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForHpNo" className="btn-imgonly"	disabled="true"/>
							</div>
						</div>
						<div class="row">
							<%-- <ifvm:inputNew type="search" id="detail_memName" names="detail_memName" objCode="SRCH" dto="detail_memName" btnFunc="showMemPop" label="V00005" labelClass="2" conClass="3" /> --%>
							<ifvm:inputNew type="search" id="memNm|mbrNoSearch"	dto="memNm"
								btnFunc="mbrSearchHelpBtn" searchBlurEvent="mbrNmSearchHelpBlur" searchEnterEvent="mbrNmSearchHelpEnter" label="V00005"  labelClass="2" conClass="3" />
							<ifvm:inputNew type="text" id="detail_email"	dto="emailAddr"
								label="V00008" labelClass="2" conClass="3" />
							<div class="col-xs-2 middle">
								<ifvm:inputNew type="button" id="sendEmail" nuc="" btnType="envelope-o" btnFunc="showTransChnlPopForEmail" className="btn-imgonly"	disabled="true"/>
							</div>
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="detail_consultTitle"	dto="cnslgTitle"
								label="V00018" labelClass="2" conClass="10" required="true"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="textarea" id="detail_consultContent"	dto="cnslgSbst"
								label="V00019" labelClass="2" conClass="10"  rows="5" required="true"/>
						</div>
					</div>
				</div>
			</div>

			<!-- SR유형 -->
			<div class="col-xs-3 pl10 dataWrap">
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span><spring:message code="V00031"/></span>
					</div>
				</div>
				<div class="well form-horizontal">
					<div id='srTypeWrap'>
						<div class="row">
							<ifvm:inputNew type="select" id="detail_consultType1st"	dto="cnslgTypeCdL"	names="detail_consultType1st"
								label="V00010" labelClass="4" conClass="8" required="true"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="select" id="detail_consultType2nd" dto="cnslgTypeCdM"	names="detail_consultType2nd"
								label="V00011" labelClass="4" conClass="8" required="true"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="select" id="detail_consultType3rd" dto="cnslgTypeCdS" names="detail_consultType3rd"
								label="V00012" labelClass="4" conClass="8" required="true"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="select" id="detail_receptionMethod"	dto="rcpMeth"
								label="V00020" labelClass="4" conClass="8" required="true"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="hidden" id="detail_franchiseRid" dto="ridChnl"/>
							<ifvm:inputNew type="search" id="detail_franchiseCode" names="detail_franchiseCode"
								objCode="SRCH" dto="chnlNo" btnFunc="showFranchisePop" label="V00021" labelClass="4" conClass="8" />
						</div>
						<div class="row">
							<ifvm:inputNew type="search" id="detail_franchiseName" names="detail_franchiseName"
								objCode="SRCH" dto="chnlNm" btnFunc="showFranchisePop" label="V00022" labelClass="4" conClass="8" />
						</div>
						<div class="row">
							<ifvm:inputNew type="select" id="detail_affiliatedCom" dto="cprtVndrCd"
								label="V00023" labelClass="4" conClass="8" />
						</div>
						<div class="row">
					        <ifvm:inputNew type="singleCheckbox" id="detail_affiliatedComFail"	dto="detail_affiliatedComFail"
					        	label="V00024" values="1" labelClass="6" conClass="6" checked="false"/>
						</div>
					</div>
				</div>
			</div>

			<!-- 처리현황 -->
			<div class="col-xs-3 pl10 dataWrap">
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span><spring:message code="V00032"/></span>
					</div>
				</div>
				<div class="well form-horizontal">
					<div id='srProcWrap'>
						<div class="row">
							<ifvm:inputNew type="text" id="detail_processSituation"	dto="srTrtStatusNm"
								label="V00007" labelClass="3" conClass="8" disabled="true" />
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="detail_receptionist"	dto="createBy"
								label="V00025" labelClass="3" conClass="8" disabled="true" />
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="detail_receptionDate"	dto="rcpDt"
								label="V00017" labelClass="3" conClass="8" disabled="true" />
						</div>
						<div class="row">
							<ifvm:inputNew type="hidden" id="detail_personInChargeRid" dto="ridCrmuser"	required="true"/>
							<ifvm:inputNew type="hidden" id="detail_personInChargeUserId" dto="crmuserId"	/>
							<ifvm:inputNew type="search" id="detail_personInChargeName" names="detail_personInChargeName" objCode="SRCH" dto="crmuserName"
								btnFunc="showPersonInChargePop" label="V00026" labelClass="3" conClass="8" required="true"/>
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="detail_transferDate"	dto="trcDt"
								label="V00027" labelClass="3" conClass="8" disabled="true" />
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="detail_endDate"	dto="endDt"
								label="V00028" labelClass="3" conClass="8" disabled="true" />
						</div>
						<div class="row">
							<ifvm:inputNew type="text" id="detail_callId"	dto="callId"
								label="V00029" labelClass="3" conClass="8" disabled="true" />
						</div>
					</div>
				</div>
			</div>


		</div>

	</div>



	<!-- 탭 컨텐츠 -->
	<div id="tabVocArea">
		<div class="btn-group btn-group-justified" id="tabVocType">
		       <div id="tabVocContent" ></div>
		</div>
	</div>
</div>


<!-- 담당자 팝업 -->
<div id="setPICPop" class="popup_container"></div>
<!-- 회원번호 및 회원명 선택 팝업 - 이성원 과장님 -->
<div id="mbrSearchPopDiv" class="popup_container"></div>
<!-- 가맹점드 및 가맹점명 선택 팝업 - 이성원 과장님 -->
<div id="channelSearchPopDiv" class="popup_container"></div>

<div id="playRecordFilePop" class="popup_container"></div>

<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<script>
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var ridMbr = '<%= cleanXss(request.getParameter("ridMbr")) %>';
var closedFlag = false;
var mbrNoTemp ="" ;
gVocDetail = {
		tabVocContent : function(){
			$('#tabVocContent').DrawTab({
				item: [
					{label: '<spring:message code="V00033"/>', href: '<ifvm:url name="actyHistoryList"/>'},
					/* {label: '<spring:message code="V00041"/>', href: '<ifvm:url name="transactionListByRidMbr"/>'},
					{label: '<spring:message code="V00068"/>', href: '<ifvm:url name="cardListByRidMbr"/>'}, */
				]
			});
		},
		phoneFieldId : ['cntcDesk', 'memPtblNo'],
		setPhoneField : function(){
			for(var pi = 0 ; pi < this.phoneFieldId.length ; pi++){
				var _pval = $("#vocDetailWrap [dtoparam='"+this.phoneFieldId[pi]+"']").val();
				var _aval="";
				if(_pval){
					_aval = _pval.replaceAll("-","");
					if(_aval.length==11){
						_aval = _pval.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3')
					}
					if(_aval.length==10){
						_aval = _pval.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3')
					}
					if(_aval.length==9){
						_aval = _pval.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3')
					}
					if(_aval.length==8){
						  _aval = _pval.replace(/(\d{4})(\d{4})/, '$1-$2')
					}

				}
				$("#vocDetailWrap [dtoparam='"+this.phoneFieldId[pi]+"']").val(_aval);
			}
		},

		init : function(){
			
			$.fn.ifvmSetSelectOptionCommCode("detail_consultType1st", "SR_AREA_L", null, null, true);
			$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", $("#detail_consultType1st").val(), "detail_consultType1st", true);
			$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", $("#detail_consultType2nd").val(), "detail_consultType2nd", true);

			$.ifvGetCommCodeList('select', 'detail_receptionMethod', '<ifvm:action name="getCommCodeList"/>', 'CALL_TYPE', 'voc', false, false, false, false);
			$.ifvGetCommCodeList('select', 'detail_affiliatedCom', '<ifvm:action name="getCommCodeList"/>', 'ALLIANCE_COMPANY_TYPE', 'voc', false , true, false, false);

			$("#vocDetailWrap #detail_contactInfo,#vocDetailWrap #detail_phoneNo").keyup(function(){
				$(this).val(gVocDetail.autoHypenPhone($(this).val()));
			})
			
	       
	        /* v.1001s  history.pushStatus로 변경으로 rid 파라미터 추출  로직 추가. knlee. 2018.04.18 */        
	        // location.href 파라미터에 rid가 있을 경우 수정작업으로 인식.
			if(rid ==  "undefined"  || rid == "null") {
				var param = getParameters("rid");
				if(param != null) {
					rid = param;
				}
			}
	
			
			if(rid != "undefined" && rid != "null"){
				//상세
				detailFlag = true;
				//탭 컨텐츠 생성
				gVocDetail.tabVocContent();
				gVocDetail.loadData();


				$("#listenRecordBtn").show();
			}else{
				$("#listenRecordBtn").hide();
				//신규
				detailFlag = false;

				var userInfo=$.ifvmGetUserInfo()

				$("#detail_personInChargeRid").val(userInfo.id);
				$("#detail_personInChargeUserId").val(userInfo.userId);
				$("#detail_personInChargeName").val(userInfo.empName);

				if(typeof(ridMbr)!= "undefined" && ridMbr != "null"){
					var data = {
						rid : ridMbr
					}
					$.ifvSyncPostJSON('<ifvm:action name="getMbrDetail"/>', data , function(result) {
			        	//
			        	if ($.fn.ifvmIsNotEmpty(result)) {
			        		$("#ridMbr").val(result.rid);
			        		$("#detail_ridCust").val(result.ridCust);
			            	$("#memNo").val(result.mbrNo);
			            	$("#memNm").val(result.custNm);
			            	//$("#detail_contactInfo").val(result.homeTelNo);
			            	$("#detail_phoneNo").val(result.hhpNo);
			            	$("#detail_email").val(result.emailAddr);
			            	mbrNoTemp = result.mbrNo;
			            	gVocDetail.clearMasking(result);
			            	$("#detail_contactInfo").val("");
			        	}
			        },function(result){
						alert(result.message);
			        })
				}


				/* if(!gVocDetail.data.homeTelNo){
					$("#callConNo").prop('disabled',true);
				}
				if(!gVocDetail.data.hhpNo){
					$("#callHpNo, #msgHpNo").prop('disabled',true);
				}else{
					$("#callHpNo, #msgHpNo").prop('disabled',false);
				}
				if(!gVocDetail.data.emailAddr){
					$("#sendEmail").prop('disabled',true);
				}else{
					$("#sendEmail").prop('disabled',false);
				} */
				if(opener.window.parent.document.getElementById('TSPhone')){
					$("#callConNo, #callHpNo").prop('disabled',false);
				}else{
					$("#callConNo, #callHpNo").prop('disabled',true);
				}

				$("#detail_callId").val(opener.window.parent.CTI.callId);




			}
		},
		data : {},
		close : function(){
			window.close();
		},
		clearMasking : function(result){
			var targetField = [
			/* {
				type : 'mbr',
				field : 'tel',
				rid : $("#ridMbr").val(),
				target : 'detail_contactInfo',
				dTarget : 'homeTelNo'
			}, */
			{
				type : 'mbr',
				field : 'phone',
				rid : $("#ridMbr").val(),
				target : 'detail_phoneNo',
				dTarget : 'hhpNo'
			}, {
				type : 'mbr',
				field : 'email',
				rid : $("#ridMbr").val(),
				target : 'detail_email',
				dTarget : 'emailAddr'
			}]

			for (var i=0  ; i < targetField.length ; i++){
				$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
						targetField[i],
		        function(result) {
					$("#"+targetField[i].target).val(result.message);
					if(result.message){
						gVocDetail.data[targetField[i].dTarget] = result.message.replaceAll('-','');
					}
			     })
			}
		},
		loadData : function(){
			$.ifvSyncPostJSON('<ifvm:action name="getConsultDetail"/>',{
				rid : rid
			},function(result){
				//
				gVocDetail.data = result;
				//result.callId = opener.window.parent.CTI.callId;
				$("#vocDetailWrap").dataSetting(result);
				gVocDetail.clickUnmaskBtn();
				gVocDetail.setPhoneField();

				if(result.cprtVndrHhoConvFail == "Y"){
					$("#detail_affiliatedComFail").prop("checked",true);
				}else{
					$("#detail_affiliatedComFail").prop("checked",false);
				}
				$("#detail_consultType1st").val(result.cnslgTypeCdL);
				$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", true);
				$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
				$("#detail_consultType2nd").val(result.cnslgTypeCdM);
				$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
				$("#detail_consultType3rd").val(result.cnslgTypeCdS);

				if(result.rcpDt){
					$("#detail_receptionDate").val(result.rcpDt.split('.')[0]);
				}
				if(result.endDt){
					$("#detail_endDate").val(result.endDt.split('.')[0]);
				}
				//접수일시와 callId가 존재해야 녹취청취 버튼 활성화
				if(!result.callId || !result.rcpDt){
					$("#listenRecordBtn").prop('disabled',true);
				}
				if(gVocDetail.data.srTrtStatus != "Closed"){
					$("#completeBtn").prop('disabled',false);
				}
				if(gVocDetail.data.srTrtStatus == "Closed"){
					$("#vocDetailWrap input, #vocDetailWrap select, #vocDetailWrap textarea, #headForm button, #msgHpNo, #sendEmail, #newBtn, #smsBtn, #emailBtn").not("#listenRecordBtn").prop('disabled',true);
					$("#vocDetailWrap .input-group-addon").remove();
				}

				if(result.srTrtStatus == "Closed"){
					closedFlag = true;
				}
			}, function(result){
				alert(result.message);
			})

		},
		clickUnmaskBtn : function(){
			if($("#detail_srNo").val() != ""){
				if($("#detail_contactInfo").val() != ""){
					//연락처 마스킹 해제
					$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
				           rid: rid ,
				           type: 'voc' ,
				           field: 'cntcDesk'
				       },
				       function(result) {
				       	$("#detail_contactInfo").val(result.message);
				       	if(opener.window.parent.document.getElementById("TSPhone")){
					       	$("#callConNo").attr("disabled",null);
				       	}
						$("#msgConNo").attr("disabled",null);
				       });
				}

				if($("#detail_phoneNo").val() != ""){
					//휴대폰번호 마스킹 해제
					$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
				           rid: rid ,
				           type: 'voc' ,
				           field: 'memPtblNo'
				       },
				       function(result) {
				       	$("#detail_phoneNo").val(result.message);
				       	if(opener.window.parent.document.getElementById("TSPhone")){
					       	$("#callHpNo").attr("disabled",null);
				       	}
						$("#msgHpNo").attr("disabled",null);
				       });
				}

				if($("#detail_email").val() != ""){
					//이메일 마스킹 해제
					$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
				           rid: rid ,
				           type: 'voc' ,
				           field: 'emailAddr'
				       },
				       function(result) {
				       	$("#detail_email").val(result.message);
						$("#sendEmail").attr("disabled",null);
				       });
				}

				$("#unmaskBtn").attr("disabled","true");
			}else{
				alert('<spring:message code="V00200"/>');
			}
		},
		save : function(){
			if($.ifvmGetUserInfo().userId != $("#detail_personInChargeUserId").val()){
				alert('<spring:message code="V00296"/>'); //다른 담당자의 상담은 수정할 수 없습니다.
			}else{
				validation1 = $("#srInfoWrap").ifvValidation();
				validation2 = $("#srTypeWrap").ifvValidation();
				validation3 = $("#srProcWrap").ifvValidation();

				//제휴업체 호전환 실패 체크 여부 확인
				var chkFlag = "N";

				if($("#detail_affiliatedComFail").attr("checked") == "checked"){
					chkFlag = "Y";
				}

				var data = $(".dataWrap").getSubmitData();
				data.cprtVndrHhoConvFail = chkFlag;
				if(data.cntcDesk)data.cntcDesk = data.cntcDesk.replaceAll("-","");
				if(data.memPtblNo)data.memPtblNo = data.memPtblNo.replaceAll("-","");

				if(validation1.confirm() && validation2.confirm() && validation3.confirm()){
					if(detailFlag){
						data.rid = $.ifvGetParam('rid');
						data.srTrtStatus = "detailUpdate"
					//	console.log(data);
						//상담요청 상세 수정
						$.ifvSyncPostJSON('<ifvm:action name="modifyRequestConsultation"/>',data,function(result) {
							if(result.success){
								alert('<spring:message code="L01822"/>');
								gVocDetail.loadData();
								if(opener.gMbrDetail){
									opener.mbrDetailTab.reloadCurrentTab(opener.mbrDetailTab.getActiveIndex())
								}
							}else{
								alert('<spring:message code="M02248"/>');
							}
						});
					}else{
						//상담요청 상세 신규
						data.callId = opener.window.parent.CTI.callId;
						$.ifvSyncPostJSON('<ifvm:action name="setRequestConsultation"/>',data,function(result) {
							if(result.success){
								var url = '<ifvm:url name="vocDetailPop"/>';
								url += '?rid=' + result.message;
								/* v.1001s location.herf 제거후  리로딩 않고 자신의 페이지 호출 방식 history.pushStatus로 변경. knlee. 2018.04.18 */ 
								history.pushState(null, null, location.href +  '&rid=' + result.message);
								gVocDetail.init();
								changeConsultType();
								
								/* v.1001e */
								
								// qtjs.href(url; // (구)소스 );
								if(opener.gMbrDetail){
									opener.mbrDetailTab.reloadCurrentTab(opener.mbrDetailTab.getActiveIndex());
								}
							}else{
								alert('<spring:message code="M02248"/>');
							}
						});
					}
				}else{
					alert('<spring:message code="M01055"/>');
				}
			}
		},
		autoHypenPhone : function(str){
			str = str.replace(/[^0-9]/g, '');
			var tmp = '';
			  if( str.length < 4){
			    return str;
			  }else if(str.length < 7){
			    tmp += str.substr(0, 3);
			    tmp += '-';
			    tmp += str.substr(3);
			    return tmp;
			  }else if(str.length < 11){
				  if(str.substr(0, 2)=="02"){
					  tmp += str.substr(0, 2);
					  tmp += '-';
					  tmp += str.substr(2, 3);
					  tmp += '-';
					  tmp += str.substr(5);
					  return tmp;
				  }else{
					  tmp += str.substr(0, 3);
					  tmp += '-';
					  tmp += str.substr(3, 3);
					  tmp += '-';
					  tmp += str.substr(6);
					  return tmp;
				  }
			  }else{
				  if(str.substr(0, 2)=="02"){
					  tmp += str.substr(0, 2);
					  tmp += '-';
					  tmp += str.substr(2, 4);
					  tmp += '-';
					  tmp += str.substr(6);
					  return tmp;
				  }else{
					  tmp += str.substr(0, 3);
					  tmp += '-';
					  tmp += str.substr(3, 4);
					  tmp += '-';
					  tmp += str.substr(7);
					  return tmp;
				  }
			  }
			  return str;

		}


}
$(document).ready(function(){
	gVocDetail.init();

	changeConsultType();
})
//소프트폰 전화걸기 함수
function makeCallForContactInfo(){
	var contactInfo = $("#detail_contactInfo").val();

	opener.window.parent.localSoftMakeCall(contactInfo,null);
}
function makeCallForHhpNo(){
	var phoneNo = $("#detail_phoneNo").val();

	opener.window.parent.localSoftMakeCall(phoneNo,null);
}
//문자메시지&이메일 전송 팝업
function showTransChnlPopForConNo() {
	var url = '<ifvm:url name="transChnlPop"/>';
	url += "?sendType=sms&hpNo=" + $("#detail_contactInfo").val() + "&ridMbr=" + $("#ridMbr").val()+"&ridVocReq="+gVocDetail.data.rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForHpNo() {
	var url = '<ifvm:url name="transChnlPop"/>';
	url += "?sendType=sms&hpNo=" + $("#detail_phoneNo").val() + "&ridMbr=" + $("#ridMbr").val() +"&ridVocReq="+gVocDetail.data.rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForEmail() {
	var url = '<ifvm:url name="transChnlPop"/>';
	url += "?sendType=email&email=" + $("#detail_email").val() + "&ridMbr=" + $("#ridMbr").val()+"&ridVocReq="+gVocDetail.data.rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function mbrSearchHelpBlur(){
	if(mbrNoTemp!=$('#memNo').val()){
		if($('#memNo').val()==""){
			$('#ridMbr').val("");
			mbrNoTemp = "";
		}else{
			openMbrSearchHelp('<ifvm:url name="mbrSearchHelp"/>?mbrNo='+encodeURI(encodeURIComponent($('#memNo').val())));
		}
	}
}
function mbrSearchHelpBtn(){

	openMbrSearchHelp('<ifvm:url name="mbrSearchHelp"/>');

}
function mbrSearchHelpEnter(){

	if($('#memNo').val()==""){
		$('#ridMbr').val("");
		mbrNoTemp = "";
	}else{
		openMbrSearchHelp('<ifvm:url name="mbrSearchHelp"/>?mbrNo='+encodeURI(encodeURIComponent($('#memNo').val())));
	}

}
function mbrNmSearchHelpEnter() {
	if ($('#memNm').val() == "") {
		$('#ridMbr').val("");
	} else {
		openMbrSearchHelp('<ifvm:url name="mbrSearchHelp"/>?mbrNm='
				+ encodeURI(encodeURIComponent($('#memNm').val())));
	}
}

function mbrNmSearchHelpBlur() {
	if ($('#memNm').val() == "") {
		$('#ridMbr').val("");
	} else {
		openMbrSearchHelp('<ifvm:url name="mbrSearchHelp"/>?mbrNm='
				+ encodeURI(encodeURIComponent($('#memNm').val())));
	}
}
function openMbrSearchHelp(url){

	mbrSearchHelpPop ={
		        id : "mbrSearchPopDiv"
		    };
	mbrSearchHelpPop.popup = function (){
		mbrSearchHelpPop.pop = $('#'+mbrSearchHelpPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: url,
		            contentType: "ajax",
		            title: '<spring:message code="L00988"/>',
		            width: '700px',
		            close: mbrSearchHelpPop.close
		        });
		};
		mbrSearchHelpPop.beforeClose = function (obj) {
			//console.log(obj);
			$("#ridMbr").val(obj.rid);
        	$("#memNo").val(obj.mbrNo);
        	$("#memNm").val(obj.custNm);
        	$("#detail_ridCust").val(obj.ridCust);
        	$("#detail_phoneNo").val(obj.hhpNo);
        	$("#detail_email").val(obj.emailAddr);
        	gVocDetail.clearMasking();

        	mbrNoTemp = obj.mbrNo;
		};
		mbrSearchHelpPop.close = function (obj) {
			 if(obj!=null&&obj.type!="close"){
				 mbrSearchHelpPop.beforeClose(obj);
			 }else{
				 $("#mbrNo").val(mbrNoTemp);
			 }
			 mbrSearchPopDiv._destroy();
		 };
		 mbrSearchHelpPop.popup();
}


/* picPop = {
		id : "setPICPop",
		pop : function(){
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="setPICPop"/>',
	            contentType : "ajax",
	            title : '<spring:message code="I02080"/>', // 회원 찾기
	            width : '700px',

	        });
		},
		beforeClose : function(obj){
			console.log(obj);
			$("#detail_personInChargeRid").val(pic.ridUser);
			$("#detail_personInChargeUserId").val(pic.userId);
			$("#detail_personInChargeName").val(pic.empName);

		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}
} */
//담당자 팝업
function showPersonInChargePop(){
	$("#setPICPop").ifvsfPopup({
       enableModal : true,
	   enableResize: false,
	   contentUrl: '<ifvm:url name="setPICPop"/>',
	   contentType: "ajax",
	   title: "<spring:message code='I02080'/>",
	   width: 600,
	   close : 'setPICPopClose'
	});
}

//담당자 팝업 닫기
function setPICPopClose() {
	setPICPop._destroy();
}

//담당자 선택
function clickAddBtn(data){
	$("#detail_personInChargeRid").val(pic.ridUser);
	$("#detail_personInChargeUserId").val(pic.userId);
	$("#detail_personInChargeName").val(pic.empName);
	setPICPopClose();
}

//회원번호 및 회원명 선택 팝업 - 이성원 과장님
/* function showMemPop(){
	mbrSearchHelpPop ={
	        id : "mbrSearchPopDiv"
	    };
	mbrSearchHelpPop.popup = function (){
	mbrSearchHelpPop.pop = $('#'+mbrSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="mbrSearchHelp"/>'    ,
	            contentType: "ajax",
	            title: '회원명 찾기',
	            width: 700
	        });f
	};
	mbrSearchHelpPop.beforeClose = function (obj) {
	};
	mbrSearchHelpPop.close = function (obj) {
		 if(obj!=null){
	        	$("#ridMbr").val(obj.rid);
	        	$("#detail_memNo").val(obj.mbrNo);
	        	$("#detail_memName").val(obj.custNm);
	        }
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 mbrSearchHelpPop.popup();
} */

//가맹점드 및 가맹점명 선택 팝업 - 이성원 과장님
function showFranchisePop(){
	channelSearchHelpPop ={
	        id : "channelSearchPopDiv"
	    };
	channelSearchHelpPop.popup = function (){
		channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="channelSearchHelp"/>' + '?ouTypeCd=' + 'A',
		            contentType: "ajax",
		            title: '<spring:message code="L00987"/>',
		            width: 700
		        });
		};
		channelSearchHelpPop.beforeClose = function (obj) {

		};

		channelSearchHelpPop.close = function (obj) {
			 if(obj!=null){
				 	$("#detail_franchiseRid").val(obj.rid);
		        	$("#detail_franchiseName").val(obj.chnlNm);
		        	$("#detail_franchiseCode").val(obj.chnlNo);
		        	this.beforeClose(obj);
		        }

			 var _popObj = eval(this.id)
			_popObj._destroy();
		 };
		channelSearchHelpPop.popup();
}

//상담유형 변경 이벤트
function changeConsultType(){
	$("#detail_consultType1st").change(function(){
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", true);
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
	});
	$("#detail_consultType2nd").change(function(){
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
	});
}



var getParameters = function (paramName) {
    // 리턴값을 위한 변수 선언
    var returnValue = null;

    // 현재 URL 가져오기
    var url = location.href;

    // get 파라미터 값을 가져올 수 있는 ? 를 기점으로 slice 한 후 split 으로 나눔
    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');

    // 나누어진 값의 비교를 통해 paramName 으로 요청된 데이터의 값만 return
    for (var i = 0; i < parameters.length; i++) {
        var varName = parameters[i].split('=')[0];
        if (varName.toUpperCase() == paramName.toUpperCase()) {
            returnValue = parameters[i].split('=')[1];
            return decodeURIComponent(returnValue);
        }
    }
};

</script>
