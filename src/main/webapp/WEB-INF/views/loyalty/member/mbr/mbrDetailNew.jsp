<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
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
var mbr_rid = '<%=cleanXss(request.getParameter("rid"))%>';
var mbrNo = '<%=cleanXss(request.getParameter("mbrNo"))%>';
var tabIndex  = '<%=cleanXss(request.getParameter("tabIndex"))%>';
var tabId = '<%=cleanXss(request.getParameter("tabid"))%>';
tabIndex = tabIndex === 'null' ? null : tabIndex;
var srcCustNm ;
var isNew = true;  //신규 여부. 신규: true, 수정 : false
var isMask = true;
var maskYN = '<%=cleanXss(request.getParameter("maskYN"))%>'; // 마스킹 된 상태
	if (maskYN != null && maskYN == "N")
		isMask = false;
	var addr1ZipTemp;

	gMbrDetail = {
		data : {},
		checkBoxIds : [ /* 'wbMemYn',  */'e1MemYn', 'corpTaxiYn', 'eventTgtYn', 'mktAgrePrvInfoOpt', 'simpleMbrSwitchYn' ],
		pointFieldId : [ 'avlPoint', 'totChangePoint', 'extncPamPoint' ],//'giftPoint', 'giftAvlPoint',
		phoneFieldId : [ 'hhpNoDec' ], // 'homeTelNo',
		dateTimeFieldId : [ /* 'ownhomeAdrChgDt' */ ],
		//dateFieldId : [ 'semiVipStartDt', 'semiVipEndDt' ],
		setCheckBox : function(result) {
			$("#mbrForm input[type='checkbox']").prop("checked", false);
			for (i in gMbrDetail.checkBoxIds) {
				if (result[gMbrDetail.checkBoxIds[i]] != ""
						&& result[gMbrDetail.checkBoxIds[i]] != null
						&& (result[gMbrDetail.checkBoxIds[i]]).toUpperCase() == "Y") {
					$("#mbrForm input[type='checkbox'][value='" + gMbrDetail.checkBoxIds[i] + "']").prop('checked', true);
				}
			}
		},
		setPointField : function() {
			for (var pi = 0; pi < this.pointFieldId.length; pi++) {
				var _pval = $("#" + this.pointFieldId[pi]).val();
				var _aval = "";
				if (_pval) {
					_aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				}
				$("#" + this.pointFieldId[pi]).val(_aval);
			}
		},
		setBirthField : function(value) {
			if (value) {
				return value.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			} else {
				return "";
			}
		},
		setDateTimeField : function() {
			for (var pi = 0; pi < this.dateTimeFieldId.length; pi++) {
				var _pval = $("#" + this.dateTimeFieldId[pi]).val();
				var _aval = "";
				if (_pval) {
					_aval = _pval.split('.')[0];
				}
				$("#mbrForm #" + this.dateTimeFieldId[pi]).val(_aval);
			}
		},
		/*
		setDateField : function() {
			for (var pi = 0; pi < this.dateFieldId.length; pi++) {
				var _pval = $("#" + this.dateFieldId[pi]).val();
				var _aval = "";
				if (_pval) {
					_aval = _pval.split(' ')[0];
				}
				$("#mbrForm #" + this.dateFieldId[pi]).val(_aval);
			}
		},
		 */
		setPhoneField : function() {
			for (var pi = 0; pi < this.phoneFieldId.length; pi++) {
				var _pval = $("#" + this.phoneFieldId[pi]).val();
				var _aval = "";
				if(_pval){
					_aval = _pval.replaceAll("-","");
					if (_aval.length == 11) {
						_aval = _pval.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
					}
					if (_aval.length == 10) {
						_aval = _pval.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
					}
					if (_aval.length == 9) {
						_aval = _pval.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
					}
					if (_aval.length == 8) {
						_aval = _pval.replace(/(\d{4})(\d{4})/, '$1-$2');
					}
				}
				$("#mbrForm #" + this.phoneFieldId[pi]).trigger('keyup');
				$("#mbrForm #"+this.phoneFieldId[pi]).val(_aval);
			}
		},
		checkDateVali : function(_date) {
			var date = _date + "";
			date = date.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');

			var dateType = new Date(date);
			dateType += "";

			if (dateType.indexOf('Invalid') > -1) {
				return false;
			} else {
				return true;
			}

		},
		clearMasking : function(result) {
			var targetField = [ {
				type : 'mbr',
				field : 'tel',
				rid : gMbrDetail.data.rid,
				target : 'homeTelNo'
			}, {
				type : 'mbr',
				field : 'phone',
				rid : gMbrDetail.data.rid,
				target : 'hhpNo'
			}, {
				type : 'mbr',
				field : 'email',
				rid : gMbrDetail.data.rid,
				target : 'emailAddr'
			} ]

			for (var i = 0; i < targetField.length; i++) {
				$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>'
				, targetField[i]
				, function(result) {
					$("#" + targetField[i].target).val(result.message);
					if (result.message) {
						gMbrDetail.data[targetField[i].target] = result.message.replaceAll('-', '');
					}
				});
			}
		},
		init : function() {
			$.ifvGetCommCodeList('select', 'genGbnCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_GEN_CD', 'loy', false, false, true);
		    //회원구분
			$.ifvGetCommCodeList('select', 'memDiv', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_TYPE', 'loy', false, false, true);
			//회원등급
// 			$.ifvGetCommCodeList('select', 'tierCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_GRADE', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'sbscChnlCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CHANNEL', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'sbscChnlDtlCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CHANNEL_DTL', 'loy', false, false, true);
			//$.ifvGetCommCodeList('select', 'lunarGbnCd', '<ifvm:action name="getCommCodeList2"/>', 'BIRTHDAY_CD', 'loy', false, false, true);
			//회원상태
			$.ifvGetCommCodeList('select', 'mbrStatCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_MEM_STAT_CD', 'loy', false, false, true);

			$.ifvGetCommCodeList('select', 'custTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_CUST_TYPE_CD', 'loy', false, false, true);
			$.ifvGetCommCodeList('select', 'identiTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_IDENTI_TYPE_CD', 'loy', false, false, true);
			


			$.ifvmLnbSetting('mbrListNew');
			/*
			$("#mbrForm #homeTelNo").keyup(function() {
				$(this).val(gMbrDetail.autoHypenPhone($(this).val()));
			});
			var birthDt  = $('#mbrForm #birthDt');
			birthDt.val();
			birthDt.ifvDateChecker({});
			this.buttonAuth();
			 */
			gMbrDetail.loadData();

			$("#mbrForm #mktAgrePrvInfoOpt").click(function() {
				if ($(this).is(':checked')) {
					$("#mbrForm .blockTarget").prop("disabled", false);
					$("#mbrForm #addr1ZipSearch").show();

				} else {
					$("#mbrForm .blockTarget").prop("disabled", true);
					$("#mbrForm #addr1ZipSearch").hide();
				}
			})
		},
		buttonAuth : function() {
			//탈회 버튼권한
			var isAuth = false;
			var authArr = $.ifvmGetAuthInfo().authList;
			for(var i = 0 ; i < authArr.length ; i++){
				var authObj = authArr[i];
				var authName = authObj.authName;
				if (authName == 'E10009') isAuth = true;
			}
			if(!isAuth){
				$("#dropMbrBtn").remove();
			}
		},
		loadData : function() {
			$.ifvSyncPostJSON('<ifvm:action name="getMbrDetail"/>', {
				rid : $.ifvGetParam('rid'),
				mbrNo : $.ifvGetParam('mbrNo')
			}, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					result.birthDt = gMbrDetail.setBirthField(result.birthDt);
					$("#mbrForm").dataSetting(result);
					gMbrDetail.setCheckBox(result);
					gMbrDetail.setPointField();
					gMbrDetail.setDateTimeField();
					//gMbrDetail.setDateField();
					gMbrDetail.data = result;
					//마스킹 주석처리
					//gMbrDetail.clearMasking(result);
					gMbrDetail.setPhoneField();
					addr1ZipTemp = result.addr1Zip;
					$("#realNmCertiDate").val(result.realnmCertiDate);
					//일반이 아니면 '개인택시 전환'버튼 비활성화
					if (result.memDiv != "P") {
						$("#changeTaxiBtn").prop("disabled", true);
						$("#changeNmbrBtn").prop("disabled", false);
					}
					//개인택시 회원 일 경우만 '일반회원 전환'버튼 활성화
					if (result.memDiv != "T") {
						$("#changeTaxiBtn").prop("disabled", false);
						$("#changeNmbrBtn").prop("disabled", true);
					}
					//회원의 상태코드값이 20(탈퇴) 일경우에는  버튼  비활성화
					//탈회회원 메뉴 active
					if (result.mbrStatCd == "20") {
						$("#tryEventBtn, #dropMbrBtn").prop("disabled",true);
						$(".dropHidBtn").prop("disabled", true);
						$("#infavorMenu #mbrList").removeClass('active');
						$.ifvmLnbSetting('dropMbrListNew');
					}

					//웹 회원이 아니면 '웹가입 에러처리'버튼 비활성화
					/* if (result.wbMemYn != "Y") {
						$("#webJoinErrorBtn").prop('disabled', true);
					} */

					if (result.mktAgrePrvInfoOpt == "N") {
						$("#mbrForm .blockTarget").prop("disabled", true);
						$("#mbrForm #addr1ZipSearch").hide();
					} else {
						$("#mbrForm .blockTarget").prop("disabled", false);
						$("#mbrForm #addr1ZipSearch").show();
					}

					if(result.newuserYn == 'N'){
						$("#newUserYn").attr('checked',true);
					}else{
						$("#newUserYn").attr('checked',false);
					}

					if (window.parent.document.getElementById('TSPhone')) {
						$("#callConNo, #callHpNo, #btnPwdIvr").prop('disabled',
								false);
					}/*
					if (!result.homeTelNo) {
						$("#callConNo").prop('disabled', true);
					} */
					if (!result.hhpNo) {
						$("#callHpNo").prop('disabled', true);
						$("#btnDelPhone").prop('disabled', true);
					}
					$("#addr1Dtl").prop('disabled',true);
				} else {
					alert('<spring:message code="L01609"/>');//잘못된 접근입니다.
					gMbrDetail.moveList();
				}
			});
		},
		moveList : function() {// 목록페이지 이동
			// alert(location.href );
			history.pushState(null, null, location.href );

			//탈회회원이면 탈회 회원 리스트로 이동
			if (gMbrDetail.data.mbrStatCd == "20") {
				qtjs.href('<ifvm:url name="dropMbrListNew"/>');
			} else {
				qtjs.href('<ifvm:url name="mbrListNew"/>');
			}

		},
		changeCorpTaxiYn : function() { //법인택시 설정/해제

			if (confirm('<spring:message code="L00929"/>') == true) {
				//기존 데이터에 CorpTaxiYn만 바꿔서 가져가기
				data = gMbrDetail.data;
				data.rid = gMbrDetail.data.rid;
				if (data.corpTaxiYn == "Y") {
					data.corpTaxiYn = "N"
				} else {
					data.corpTaxiYn = "Y"
				}
				var action = '<ifvm:action name="editMbrDetail"/>';
				$.ifvSyncPostJSON(action, data, function(result) {

					if (result.success) {
						alert('<spring:message code="L01260"/>');
						gMbrDetail.loadData();
					}
				})
			}
		},
		getChgHist : function(_data) {//필요 없음
			var rtnList = [];
			rtnList = ifvCompareObj(gMbrDetail.data, _data);
			function convertToUnder(str) {
				return str.replace(/([A-Z])/g, function(arg) {
					return "_" + arg.toLowerCase();
				}).toUpperCase();
			}
			for (var i = 0; i < rtnList.diff.length; i++) {
				rtnList.diff[i].chgTbl = "LOY_MBR";
				rtnList.diff[i].chgCol = convertToUnder(rtnList.diff[i].chgCol);
			}
			return rtnList;
		},
		save : function() {
			//휴대폰번호 정규식 체크
			var regexp = /^\d{3}-\d{3,4}-\d{4}|^\d{10,11}$/;
			v = $('#hhpNoDec').val();
			if( !regexp.test(v) ) {
				$.ifvCallValidationBox($('#hhpNoDec'), '유효한 전화번호 형식이 아닙니다.');
				$('#hhpNoDec').val(v.replace(regexp,''));
				return true;
			}

			// 다이소 요청으로 멤버십 회원 유무와 상관없이 고객명 수정 가능하게끔 주석처리.
			// 2019.02.18 jk.kim
			/*
			if($.fn.ifvmIsNotEmpty($('#wbMemId').val()) || $.fn.ifvmIsNotEmpty($('#wbMemYn').attr('checked'))) {
				alert('다이소멤버십 회원은 관리자 화면에서 수정할 수 없습니다.');
				return true;
			} */

			var tgtData = $("#mbrForm").getSubmitData();

			//수정못하는데 validation 기능 없애라고 하셔서 임시 주석
			//나중에 가입 기능 추가되면 그때 다시 풀어야함
			//2019.02.19 jk.kim
			/* if(tgtData.birthDt){
				if (!gMbrDetail.checkDateVali(tgtData.birthDt)) {
					alert('생년월일이 날짜형식에 맞지 않습니다.');
					return;
				}
			} */

			data = gMbrDetail.data;
			data.rid = gMbrDetail.data.rid;
			data.hhpNo = tgtData.hhpNoDec.replaceAll("-", "");
			data.emailAddr = gMbrDetail.data.emailAddrDec;
			data.addr1Zip = tgtData.addr1Zip;
			data.addr1Dflt = tgtData.addr1Dflt;
			data.addr1Dtl = tgtData.addr1Dtl;
			//data.addr1JiDflt = tgtData.addr1JiDflt;
			//data.addr1JiDtl = tgtData.addr1JiDtl;
			//data.addr1JiZip = tgtData.addr1JiZip;
			//data.hCity = tgtData.hCity;
			//data.hGu = tgtData.hGu;
			data.birthDt = tgtData.birthDt.replaceAll("-", "");
			//data.lunarGbnCd = tgtData.lunarGbnCd;
			data.mktAgrePrvInfoOpt = tgtData.mktAgrePrvInfoOpt;
			data.custNm = tgtData.custNm;

			for (var i = 0; i < gMbrDetail.checkBoxIds.length; i++) {
				var id = gMbrDetail.checkBoxIds[i];
				if (tgtData[id]) {
					data[id] = "Y"
				} else {
					data[id] = "N"
				}
			}
			//'개인정보 수집 및 이용 동의(mktAgrePrvInfoOpt)'가 선택되어 있지 않으면 이메일,주소 정보 수집 불가능
		/* 	if (!tgtData.mktAgrePrvInfoOpt
					&& (tgtData.addr1Zip != "" || tgtData.addr1Dflt != ""
							|| tgtData.addr1Dtl != ""
							|| tgtData.homeTelNo != "" || data.emailAddr != ""
							|| data.marryAniv != "" || data.marryYn != ""
							|| data.addr1JiDflt != "" || data.addr1JiDtl != "" || data.addr1JiZip != "")) {
				if (confirm('<spring:message code="L02188"/>')) {//개인정보 수집 및 이용동의를 하지 않아 주소 및 이메일, 결혼, 자택전화번호 정보를 제거합니다. \\n계속하시겠습니까?
					data.addr1Zip = "";
					data.addr1Dflt = "";
					data.addr1Dtl = ""
					data.homeTelNo = "";
					data.emailAddr = "";
					data.marryAniv = "";
					data.marryYn = "";
					data.addr1JiDflt = "";
					data.addr1JiDtl = "";
					data.addr1JiZip = "";

				} else {
					return;
				}
				/* if(tgtData.addr1Zip != ""||tgtData.addr1Dflt != ""||tgtData.addr1Dtl != "" ||tgtData.homeTelNo != ""){
					alert('<spring:message code="L02113"/>');//개인정보 수집 및 이용 동의를 받으셔야 주소 및 이메일,결혼,자택전화번호 정보 수집이 가능 합니다.
					return;
				} */
		/*	} */


			var action = '<ifvm:action name="editMbrDetail"/>';
			$.ifvSyncPostJSON(action
			, data
			, function(result) {
//
				if (result.success) {
					alert('<spring:message code="L01260"/>');
					gMbrDetail.loadData();
				}
			}, function(result) {
				if(result.message === '1') {
					alert('회원정보 변경 중 에러가 발생하였습니다. 관리자에게 문의해주세요. [에러 사유 : 식별값 중복]');
				} else if(result.message === '2') {
					alert('회원정보 변경 중 에러가 발생하였습니다. 관리자에게 문의해주세요. [에러 사유 : 암호화 실패]');
				} else {
					$.errorChecker(result);
				}
			})

		},
		searchCharge : { //충전량 조회
			id : "searchChargePop",
			pop : function() {
				$("#" + this.id).ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : '<ifvm:url name="searchCharge"/>',
					contentType : "ajax",
					title : '<spring:message code="L00818"/>', // 충전량 조회,
					width : '1000px'
				});
			},
			beforeClose : function(obj) {

			},
			close : function(obj) {
				if (obj) {
					this.beforeClose(obj)
				}
				var _popObj = eval(this.id)
				_popObj._destroy();
			}

		},

		changePw : function() { //비밀번호 변경

		},
		checkPwCngDate : { //비밀번호 수정일시
			id : "checkPwCngDatePop",
			pop : function() {
				$("#" + this.id).ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : '<ifvm:url name="viewPwCngDataPop"/>',
					contentType : "ajax",
					title : '<spring:message code="L00831"/>', // 비밀번호 수정일시
					width : '400px'
				});
			},
			beforeClose : function(obj) {

			},
			close : function(obj) {
				if (obj) {
					this.beforeClose(obj)
				}
				var _popObj = eval(this.id)
				_popObj._destroy();
			}
		},
		changeTaxi : function() { //개인택시전환
			if (confirm('<spring:message code="L01817"/>') == true) {
				data = gMbrDetail.data;
				data.rid = gMbrDetail.data.rid;
				var action = '<ifvm:action name="addChangeTaxi"/>';
				$.ifvSyncPostJSON(action, data, function(result) {

					if (result.success) {
						alert('<spring:message code="L01818"/>');
						gMbrDetail.loadData();
					}
				}, function(result) {
					alert(result.message);
				})
			}
		},
		//일반회원 전환
		changeNmbr : function() {
			if (confirm('<spring:message code="L01858"/>') == true) {	//일반회원으로 전환 하시겠습니까?
				data = gMbrDetail.data;
				data.rid = gMbrDetail.data.rid;
				data.memDiv = "P";
				var action = '<ifvm:action name="changeNmbr"/>';
				$.ifvSyncPostJSON(action, data, function(result) {

					if (result.success) {
						alert('<spring:message code="L01818"/>');	//정상적으로 요청되었습니다.
						gMbrDetail.loadData();
					}
				}, function(result) {
					alert(result.message);
				})
			}
		},
		changePhoneNum : {
			pop : function() {
				$.ifvSyncPostJSON(
								'<ifvm:action name="getCommCodeList"/>',
								{
									groupCode : 'SYM_URL',
									codeName : 'E1CellPhoneModifyPopup'
								},
								function(result) {

									if (result.success) {
										var url = result.rows[0].attrib01;
										var popUrl = url + "?seq="
												+ gMbrDetail.data.mbrNo
												+ "&cs=" + $.ifvmGetUserInfo().userId;
										var popOption = "width=1600, height=380, resizable=1, scrollbars=1, status=no;";
										window.open(popUrl, "", popOption);

									}
								}, function(result) {
									alert(result.message);
								})
			}
		},
		sendCoupon : {
			pop : function() {
				$
						.ifvSyncPostJSON(
								'<ifvm:action name="getCommCodeList"/>',
								{
									groupCode : 'SYM_URL',
									codeName : 'E1CouponSendPopup'
								},
								function(result) {

									if (result.success) {
										var url = result.rows[0].attrib01;
										var popUrl = url + "?seq="
												+ gMbrDetail.data.mbrNo
												+ "&cs=" + $.ifvmGetUserInfo().userId;
										var popOption = "width=1200, height=530, resizable=1, scrollbars=1, status=no;";
										window.open(popUrl, "", popOption);

									}
								}, function(result) {
									alert(result.message);
								})
			}
		},
		tryEvent : {
			pop : function() {
				$
						.ifvSyncPostJSON(
								'<ifvm:action name="getCommCodeList"/>',
								{
									groupCode : 'B2C_EVENT',
									codeName : '10'
								},
								function(result) {

									if (result.success
											&& result.rows.length > 0) {
										$
												.ifvSyncPostJSON(
														'<ifvm:action name="getCommCodeList"/>',
														{
															groupCode : 'SYM_URL',
															codeName : 'E1EventPopup'
														},
														function(result) {

															if (result.success) {
																var url = result.rows[0].attrib01;
																var popUrl = url
																		+ "?seq="
																		+ gMbrDetail.data.mbrNo
																		+ "&cs=" + $.ifvmGetUserInfo().userId;
																var popOption = "width=1200, height=500, resizable=1, scrollbars=1, status=no;";
																window
																		.open(
																				popUrl,
																				'',
																				popOption);
																//var evtWindow = window.open('',"E1EventWindow",popOption);
																//evtWindow.location.href = popUrl;
															}
														},
														function(result) {
															alert(result.message);
														})

									}
								}, function(result) {
									alert(result.message);
								})
			}
		},
		orangeCardLuck : {
			pop : function() {
				$
						.ifvSyncPostJSON(
								'<ifvm:action name="getCommCodeList"/>',
								{
									groupCode : 'SYM_URL',
									codeName : 'OcaWiner'
								},
								function(result) {

									if (result.success
											&& result.rows.length > 0) {
										var url = result.rows[0].attrib01;
										var popUrl = url + "?seq="
													+ gMbrDetail.data.mbrNo
													+ "&cs=" + $.ifvmGetUserInfo().userId;
										var popOption = "width=1200, height=500, resizable=1, scrollbars=1, status=no;";
										window.open(popUrl,'',popOption);
									}
								}, function(result) {
									alert(result.message);
								})
			}
		},
		// 회원탈회
		dropMbr : function() {
		    if (gMbrDetail.data.mbrStatCd == 'C') {
		        //이미 탈회한 회원입니다.
				alert('<spring:message code="L02348"/>');
				return ;
		    }
		    else if (gMbrDetail.data.avlPoint > 0) {
		        //**점의 가용포인트가 존재합니다.탈회 처리 하시겠습니까?
				if (!confirm($("#avlPoint").val() + '<spring:message code="L01823"/>')) {
					return;
				}
			}
		  	//탈회 처리 하시겠습니까?
		    else if (!confirm('<spring:message code="L01982"/>')) {
				return;
			}
			dropMbrReasonPop = {
					id : "dropReasonPop",
					pop : function() {
						$("#" + this.id).ifvsfPopup({
							enableModal : true,
							enableResize : false,
							contentUrl : '<ifvm:url name="dropReasonPop"/>',
							contentType : "ajax",
							title : '<spring:message code="D10224"/>', // 회원 찾기
							width : '800px'
						});
					},
					beforeClose: function(getObj) {
						qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + getObj.rid);
					},
					close : function(getObj) {
						if (getObj) {
							this.beforeClose(getObj);
						}
						var _popObj = eval(this.id);
						_popObj._destroy();
					}
				}

			dropMbrReasonPop.pop();
// 		    if (gMbrDetail.data.mbrStatCd == 'C') {
// 		        //이미 탈회한 회원입니다.
// 				alert('<spring:message code="L02348"/>');
// 				return ;
// 		    }
// 		    else if (gMbrDetail.data.avlPoint > 0) {
// 		        //**점의 가용포인트가 존재합니다.탈회 처리 하시겠습니까?
// 				if (!confirm($("#avlPoint").val() + '<spring:message code="L01823"/>')) {
// 					return;
// 				}
// 			}
// 		  	//탈회 처리 하시겠습니까?
// 		    else if (!confirm('<spring:message code="L01982"/>')) {
// 				return;
// 			}

		},
		webJoinError : {
			pop : function() {
				$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
					groupCode : 'SYM_URL',
					codeName : 'WebJoinError'
				}, function(result) {

					if (result.success) {
						var url = result.rows[0].attrib01;
						var popUrl = url + "?seq=" + gMbrDetail.data.mbrNo;
						var popOption = "width=420, height=320, resizable=no, scrollbars=no, status=no;";
						window.open(popUrl, "", popOption);
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},
		viewAvlPoint : {
			id : "checkAvlPointPop",
			pop : function() {
				$("#" + this.id).ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : '<ifvm:url name="viewAvlPointPop"/>',
					contentType : "ajax",
					title : '<spring:message code="L00468"/>', // 가용 포인트
					width : '400px'
				});
			},
			beforeClose : function(obj) {

			},
			close : function(obj) {
				if (obj) {
					this.beforeClose(obj)
				}
				var _popObj = eval(this.id)
				_popObj._destroy();
			}
		},
		mbrSearchHelpPopOpen : function() {
			mbrSearchHelpPop = {
				id : "searchMbrPop",
				pop : function() {
					$("#" + this.id).ifvsfPopup({
						enableModal : true,
						enableResize : false,
						contentUrl : '<ifvm:url name="mbrSearchHelp"/>',
						contentType : "ajax",
						title : '<spring:message code="L00988"/>', // 회원 찾기
						width : '800px'
					});
				},
				beforeClose: function(getObj) {
					qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + getObj.rid);
				},
				close : function(getObj) {
					if (getObj) {
						this.beforeClose(getObj);
					}
					var _popObj = eval(this.id);
					_popObj._destroy();
				}
			}
			mbrSearchHelpPop.pop();
		},
		autoHypenPhone : function(str) {
			str = str.replace(/[^0-9]/g, '');
			var tmp = '';
			if (str.length < 4) {
				return str;
			} else if (str.length < 7) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3);
				return tmp;
			} else if (str.length < 10) {
				if (str.substr(0, 2) == "02") {
					tmp += str.substr(0, 2);
					tmp += '-';
					tmp += str.substr(2, 3);
					tmp += '-';
					tmp += str.substr(5);
					return tmp;
				} else {
					tmp += str.substr(0, 3);
					tmp += '-';
					tmp += str.substr(3, 3);
					tmp += '-';
					tmp += str.substr(6);
					return tmp;
				}
			} else {
				if (str.substr(0, 2) == "02") {
					tmp += str.substr(0, 2);
					tmp += '-';
					tmp += str.substr(2, 4);
					tmp += '-';
					tmp += str.substr(6);
					return tmp;
				} else {
					tmp += str.substr(0, 3);
					tmp += '-';
					tmp += str.substr(3, 4);
					tmp += '-';
					tmp += str.substr(7);
					return tmp;
				}

			}
			return str;

		},
		editMbrPntUsePw: function() {
			editMbrPntUsePwPop = {
				id : "editMbrPntUsePwPop",
				pop : function() {
					$("#" + this.id).ifvsfPopup({
						enableModal : true,
						enableResize : false,
						contentUrl : '<ifvm:url name="editMbrPntUsePwPop"/>',
						contentType : "ajax",
						title : '포인트 사용비밀번호 변경',
						width : '500px'
					});
				},
				beforeClose: function(getObj) {
// 					qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + getObj.rid);
				},
				close : function(getObj) {
					if (getObj) {
						this.beforeClose(getObj);
					}
					var _popObj = eval(this.id);
					_popObj._destroy();
				}
			}
			editMbrPntUsePwPop.pop();
		},
		poinTransMbr: function() {
			srcCustNm = $("#custNm").val();
			poinTransMbrPop = {
				id : "poinTransMbrPop",
				pop : function() {
					$("#" + this.id).ifvsfPopup({
						enableModal : true,
						enableResize : false,
						contentUrl : '<ifvm:url name="poinTransMbrPop"/>',
						contentType : "ajax",
						title : '티켓 수동 지급',
						width : '1000px'
					});
				},
				beforeClose: function(getObj) {
// 					qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + getObj.rid);
				},
				close : function(getObj) {
					if (getObj) {
						this.beforeClose(getObj);
					}
					var _popObj = eval(this.id);
					_popObj._destroy();
				}
			}
			poinTransMbrPop.pop();
		},
		resetfailCnt: function(){
			if(confirm('기기등록 실패횟수를 초기화 하시겠습니까?') === false) return;
			$.ifvSyncPostJSON('<ifvm:action name="updateResetfailCnt"/>', {
				rid : mbr_rid,
			}, function(result) {

				if (result.success) {
					alert("초기화 되었습니다.");
					gMbrDetail.loadData();
				}
			}, function(result) {
				alert(result.message);
			});
		},
		editMbrUsePw: function() {
			editMbrUsePwPop = {
					id : "editMbrUsePwPop",
					pop : function() {
						$("#" + this.id).ifvsfPopup({
							enableModal : true,
							enableResize : false,
							contentUrl : '<ifvm:url name="mbrPwdEditPop"/>',
							contentType : "ajax",
							title : '회원 로그인 비밀번호 변경',
							width : '500px'
						});
					},
					beforeClose: function(getObj) {
//	 					qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + getObj.rid);
					},
					close : function(getObj) {
						if (getObj) {
							this.beforeClose(getObj);
						}
						var _popObj = eval(this.id);
						_popObj._destroy();
					}
				}
				editMbrUsePwPop.pop();
			},
			editMbrName: function() {
				editMbrNamePop = {
						id : "editMbrNamePop",
						pop : function() {
							$("#" + this.id).ifvsfPopup({
								enableModal : true,
								enableResize : false,
								contentUrl : '<ifvm:url name="mbrNameEditPop"/>',
								contentType : "ajax",
								title : '회원 이름 변경',
								width : '500px'
							});
						},
						beforeClose: function(getObj) {
//		 					qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + getObj.rid);
						},
						close : function(getObj) {
							if (getObj) {
								this.beforeClose(getObj);
							}
							var _popObj = eval(this.id);
							_popObj._destroy();
						}
					}
				editMbrNamePop.pop();
			},
			editMbrTier: function() {
				mbrTierListPop = {
						id : "mbrTierListPop",
						pop : function() {
							$("#" + this.id).ifvsfPopup({
								enableModal : true,
								enableResize : false,
								contentUrl : '<ifvm:url name="mbrTierListPop"/>',
								contentType : "ajax",
								title : '<spring:message code="M01996" />',
								width : '600px'
							});
						},
						beforeClose: function(getObj) {
//		 					qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + getObj.rid);
						},
						close : function(getObj) {
							if (getObj) {
								this.beforeClose(getObj);
							}
							var _popObj = eval(this.id);
							_popObj._destroy();
						}
					}
				mbrTierListPop.pop();
			},
			pageRefresh : function() {
				qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + mbr_rid);
			}
	}

	/*  주소 */

	function addrSearchHelpBlur() {

		$('#mbrForm #addr1Zip').val(addr1ZipTemp);

	}

	function addrSearchHelpBtn() {

		addrSearchHelp();

	}
	function addrSearchHelpEnter() {
		addrSearchHelp();

	}
	function addrSearchHelp() {
		execDaumPostcode();
// 		addrSearchHelpPop = {
// 			id : "addrPopupContainer"
// 		};
// 		addrSearchHelpPop.popup = function() {
// 			addrSearchHelpPop.pop = $('#' + addrSearchHelpPop.id).ifvsfPopup({
// 				enableModal : true,
// 				enableResize : false,
// 				contentUrl : '<ifvm:url name="zipCodeListPop"/>',
// 				contentType : "ajax",
// 				title : '<spring:message code="L00442"/>',
// 				width : '700px',
// 				close : addrSearchHelpPop.close
// 			});
// 		};
// 		addrSearchHelpPop.beforeClose = function(obj) {
// 		};
// 		addrSearchHelpPop.close = function(obj) {
// 			if (obj != null && obj.type != "close") {
// 				if (obj == "reset") {
// 					addr1ZipTempPop = null;
// 				} else {
// 					addr1ZipTempPop = obj.zipNo;
// 				}
// 				$("#mbrForm #addr1Zip").val(obj.zipNo);
// 				/*도로명  */
// 				$("#mbrForm #addr1Dflt").val(obj.roadAddr);
// 				$("#mbrForm #addr1Dtl").val(obj.dtlAddr);
// 				/*지번 */
// 				$("#mbrForm #addr1JiDflt").val(obj.jibunAddr);
// 				$("#mbrForm #addr1JiDtl").val(obj.dtlAddr);
// 				$("#mbrForm #addr1JiZip").val(obj.zipNo);

// 				$("#mbrForm #hCity").val(obj.siNm);
// 				$("#mbrForm #hGu").val(obj.sggNm);

// 			} else {
// 				$("#mbrForm #addr1Zip").val(addr1ZipTemp);
// 			}
// 			addrSearchHelpPop.beforeClose(obj);
// 			addrPopupContainer._destroy();
// 		};
// 		addrSearchHelpPop.popup();

	}

	function execDaumPostcode() {

	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = ''; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수

	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
// 	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                fullAddr = data.roadAddress;
// 	            }
// 	            else { // 사용자가 지번 주소를 선택했을 경우(J)
// 	                fullAddr = data.jibunAddress;
// 	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
// 	            if(data.userSelectedType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
// 	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	        //    document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
	        //    document.getElementById('sample6_address').value = fullAddr;
	            $("#addr1JiZip").val(data.zonecode);
	            $("#addr1JiDflt").val(data.jibunAddress);
	            $("#addr1JiDtl").focus();
	            $("#addr1Zip").val(data.zonecode);
	            $("#addr1Dflt").val(fullAddr);
	            $("#addr1Dtl").focus();

	            // 커서를 상세주소 필드로 이동한다.
	        //    document.getElementById('sample6_address2').focus();
	        }
	    }).open();
	}

	var mbrDetailTab = null;
	function drawTab() {
		mbrDetailTab = $('#mbrDetailTabArea').DrawTab({
			item : [
				{	label : '<spring:message code="L00423"/>', href : '<ifvm:url name="mbrPtnTxnHistListNew"/>', tabid: 'mbrPtnTxnHistListNew'}, //포인트거래
				{	label : '<spring:message code="L02193"/>', href : '<ifvm:url name="mbrCardListNew"/>', tabid: 'mbrCardListNew'},	//카드 리스트
				{	label :  '추천인' , href : '<ifvm:url name="mbrRecommenderHistListNew"/>', tabid: 'mbrRecommenderHistListNew'}, //추천인
				{   label : '등급이력', href : '<ifvm:url name="mbrTierHistList2"/>', tabid: 'mbrTierHistList2'}, //등급이력
				{	label : '약관동의', href : '<ifvm:url name="mbrTermsHistListNew"/>', tabid: 'mbrTermsHistListNew'}, //약관동의
				{	label : '<spring:message code="L00407"/>', href : '<ifvm:url name="mbrChnlRelListNew"/>', tabid: 'mbrChnlRelListNew'}, //채널관계
				{	label : '<spring:message code="L00657"/>', href : '<ifvm:url name="mbrChangeHistListNew"/>', tabid: 'mbrChangeHistListNew'}, //변경이력
				/* {	label :  '로그인' , href : '<ifvm:url name="mbrLoginHistListNew"/>', tabid: 'mbrLoginHistListNew'}, //로그인
				{	label :  '알림' , href : '<ifvm:url name="mbrNoticeList"/>', tabid: 'mbrNoticeList'} //알림 */

//			{	label : '<spring:message code="L00360"/>', href : '<ifvm:url name="mbrPurHistListNew"/>'}, //구매이력
//			{ 	label : '<spring:message code="L00653"/>', href : '<ifvm:url name="mbrVocListNew"/>' }, //상담요청
//			{ 	label : '<spring:message code="L00656"/>', href : '<ifvm:url name="mbrInOutHistListNew"/>' }, //접촉이력
//			{	label : '<spring:message code="L00654"/>', href : '<ifvm:url name="mbrPointLimit"/>'}, //회원별포인트 한도
//	 		{	label : '<spring:message code="L00655"/>', href : '<ifvm:url name="mbrEventHistList"/>' }, //이벤트 이력
//			{	label : '<spring:message code="L02114"/>', href : '<ifvm:url name="mbrCouponTrnsHistNew"/>' }, //쿠폰 거래이력
//			{	label : '<spring:message code="L00658"/>', href : '<ifvm:url name="mbrTierHistListNew"/>' }, //등급이력
//			{	label : '<spring:message code="L01322"/>', href : '<ifvm:url name="mbrSignInfo"/>' }, //가입정보
//	 		{	label : '<spring:message code="L00659"/>', href : '<ifvm:url name="mbrInsurHistList"/>'}, //보험이력
//	 		{	label : '<spring:message code="L01109"/>', href : '<ifvm:url name="mbrTaxiHistList"/>'}, //택시전환이력
//	 		{	label : '<spring:message code="L01110"/>', href : '<ifvm:url name="mbrTaxiPntHistList"/>'}, //택시전환포인트
//			{	label : '<spring:message code="L01995"/>', href : '<ifvm:url name="mbrSemiVipHistList"/>'}, //우수회원 맛보기 이력
//	 		{	label : '<spring:message code="L01008"/>', href : '<ifvm:url name="mbrStmpTxnHistList"/>'}, //스탬프 거래이력
//	 		{	label : '<spring:message code="L01035"/>', href : '<ifvm:url name="mbrStnPntTxnList"/>'}, //충전소 포인트 거래내역
//			{	label : '<spring:message code="L01806"/>', href : '<ifvm:url name="mbrTmAgrHistList"/>'}, //제휴 TM동의이력
//	 		{	label : '<spring:message code="L01112"/>', href : '<ifvm:url name="mbrClubList"/>'}, //동호회
//	 		{	label : '<spring:message code="L01113"/>', href : '<ifvm:url name="mbrBlackListNew"/>'}, //부정이력
//	 		{	label : '<spring:message code="L01114"/>', href : '<ifvm:url name="mbrSegmentList"/>'}, //세그먼트이력
//	 		{	label : '<spring:message code="L01115"/>', href : '<ifvm:url name="mbrCarHistList"/>'}, //차량 이력
//			{	label : '<spring:message code="L01116"/>', href : '<ifvm:url name="mbrCampaignResListNew"/>'}, //캠페인 응답 이력
// 			{	label : '소멸포인트내역', href : '<ifvm:url name="mbrDormancyPntListNew"/>'},
			/* {	label : '포인트 이관 이력', href : '<ifvm:url name="transPointHistNew"/>'}, */
//			{ 	label : '선물하기 이력', href : '<ifvm:url name="mbrPntGiftHistListNew"/>'},
//			{   label : '패밀리 이력', href : '<ifvm:url name="mbrFamliyHistListNew"/>'},
//			{   label : '스탬프', href : '<ifvm:url name="mbrStmpHistList"/>'},
//			{	label : '포인트쿠폰' , href : '<ifvm:url name="mbrPointCouponListNew"/>'},
			//{	label : '이벤트' , href : '<ifvm:url name="eventListNew"/>'}
			]
		});
		
	}

	$(document).ready(function() {
		drawTab();
		gMbrDetail.init();
		
		
		/**
		 * 2018.12.04 hy.jun
		 * 저장 버튼 주석처리 & 모든 영역 disabled 처리 (현업에 따라 관리자가 회원정보 수정할 수 없는곳도 있다.)
		 */
		$('#mbrForm input').each(function(i, e) {
			if(!($(e).attr('id') === 'custNm' || $(e).attr('id') === 'hhpNoDec')) {
				$(e).attr('disabled', true)
			}
		});

		if($.fn.ifvmIsNotEmpty(tabIndex)) {
			mbrDetailTab.moveTabIndex(tabIndex);
			tabIndex = null;
		}
		
		if($.fn.ifvmIsNotEmpty(tabId)) {
			mbrDetailTab.moveTabByTabId(tabId)
		}
		
	});
</script>



<div class="page-title">
	<h1>
		<spring:message code="L00890" />
		&gt; <spring:message code="L00079" />
	</h1>
</div>

<div>
<div class="page_btn_area" id="headForm">
	<div class="col-xs-3">
		<span><spring:message code="L00833" /></span>
	</div>
	<div class="col-xs-9 searchbtn_r">
		<!-- 회원상세 -->
		<ifvm:inputNew type="button" btnFunc="mbrDetailInfoOpen" text="L00820" objCode="mbrDetailInfoOpen_obj"/>
		<!-- 회원검색 -->
		<ifvm:inputNew type="button" btnFunc="gMbrDetail.mbrSearchHelpPopOpen" objCode="mbrSearchHelpPopOpen_obj" text="L01673" className="dropHidBtn"/>
		<!-- 회원 이름 변경 -->
		<%-- <ifvm:inputNew type="button" btnFunc="gMbrDetail.editMbrName" text="회원 이름변경" nuc="true" /> --%>
		<!-- 비밀번호 변경 -->
		<%-- <ifvm:inputNew type="button" btnFunc="gMbrDetail.editMbrUsePw" text="회원 비밀번호변경" nuc="true" /> --%>
		<!-- 포인트 이관 -->
		<%-- <ifvm:inputNew type="button" btnFunc="gMbrDetail.poinTransMbr" text="티켓수동지급" nuc="true" /> --%>
		<!-- 재조회 -->
		<ifvm:inputNew type="button" btnFunc="gMbrDetail.pageRefresh" objCode="pageRefresh_obj" text="재조회" nuc="true"/>
		<%-- <ifvm:inputNew type="button" id="addBtn" text="L00741"
			btnFunc="certiOwn.pop" className="dropHidBtn" /> --%>
		<script>
			certiOwn = {
				id : "certiPopup",
				pop : function() {
					var url = '<ifvm:url name="certiOwnPop"/>';
					url += '?certiCase=001'
					$("#" + this.id).ifvsfPopup({
						enableModal : true,
						enableResize : false,
						contentUrl : url,
						contentType : "ajax",
						title : '<spring:message code="L00741"/>', // 회원 찾기
						width : '500px'
					});
				},
				beforeClose : function(obj) {
				},
				close : function(obj) {
					if (obj) {
						this.beforeClose(obj)
					}
					var _popObj = eval(this.id)
					_popObj._destroy();
				}
			}
		</script>
		<script>
			function mbrSearchHelpPopOpen() {
				mbrSearchHelpPop = {
					id : "searchMbrPop",
					pop : function() {
						$("#" + this.id).ifvsfPopup({
							enableModal : true,
							enableResize : false,
							contentUrl : '<ifvm:url name="mbrSearchHelp"/>',
							contentType : "ajax",
							title : '<spring:message code="L00988"/>', // 회원 찾기
							width : '700px'
						});
					},
					beforeClose : function(obj) {
						qtjs.href('<ifvm:url name="mbrDetail"/>' + '?rid=' + obj.rid);

					},
					close : function(obj) {
						if (obj) {
							this.beforeClose(obj)
						}
						var _popObj = eval(this.id)
						_popObj._destroy();
					}
				}
			}
		</script>
<%-- 		<ifvm:inputNew type="button" btnFunc="gMbrDetail.changePhoneNum.pop" --%>
<%-- 			text="L00827" className="dropHidBtn" /> --%>
		<!-- 휴대폰수정 -->
		<%-- <ifvm:inputNew type="button" id="vocDetailPopBtn" text="L00819"
			className="dropHidBtn" /> --%>
		<!-- 상담생성 -->
<%-- 		<ifvm:inputNew type="button" btnFunc="gMbrDetail.sendCoupon.pop" --%>
<%-- 			text="L00828" className="dropHidBtn" /> --%>
 		<!-- 쿠폰전송 -->
<%-- 		<ifvm:inputNew type="button" id="tryEventBtn" objCode="tryEventBtn_obj"--%>
<%-- 			btnFunc="gMbrDetail.tryEvent.pop" text="L00829" --%>
<%-- 			className="dropHidBtn" /> --%>
		<!-- 오카행운 -->
<%-- 		<ifvm:inputNew type="button" btnFunc="gMbrDetail.orangeCardLuck.pop" --%>
<%-- 			text="M02814" className="dropHidBtn" /> --%>
		<!-- 이벤트 응모 -->
<%-- 		<ifvm:inputNew type="button" btnFunc="gMbrDetail.searchCharge.pop" --%>
<%-- 			text="L00818" className="dropHidBtn" /> --%>
		<!-- 충전량 조회 -->
		<%-- <ifvm:inputNew type="button" btnType="save" btnFunc="gMbrDetail.save" text="L00074" className="dropHidBtn" /> --%>
		<!-- 저장 -->
		<ifvm:inputNew type="button" btnFunc="gMbrDetail.moveList" objCode="moveList_obj" text="L00824"/>
		<!-- 목록 -->
		<%-- <ifvm:inputNew type="button" id="dropMbrBtn" btnFunc="gMbrDetail.dropMbr" text="L00832" className="dropHidBtn" /> --%>
	</div>
	<!--
	<script>
		$("#vocDetailPopBtn")
				.click(
						function() {
							var url = '<ifvm:url name="vocDetailPop"/>';
							url += '?ridMbr=' + gMbrDetail.data.rid
							window
									.open(url, 'vocDetailPop',
											'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=1200,height=740')
						})
	</script>
	 -->
</div>

<div class="form-horizontal underline top_well" id="mbrForm">
	<div class="row">
		<div class="half_wrap top_well">
			<div class="half_content half_left qt_border">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="L00834" /></span>
						<!-- 회원정보 -->
					</div>
					<div class="col-xs-10 searchbtn_r">
<%-- 						<ifvm:inputNew type="button" btnFunc="gMbrDetail.viewAvlPoint.pop" --%>
<%-- 							text="L00826" /> --%>
						<!-- 가용포인트 -->
						<%-- <ifvm:inputNew type="button" id="searchCondBtn" text="L00830" disabled="true" /> --%>
						<!-- 비밀번호 변경 -->
<%-- 						<ifvm:inputNew type="button" --%>
<%-- 							btnFunc="gMbrDetail.checkPwCngDate.pop" text="L00831" /> --%>
						<!-- 비밀번호 수정일시 -->
<%-- 						<ifvm:inputNew type="button" id="btnPwdIvr" btnFunc="fnPwdIvr" --%>
<%-- 							text="L00825" disabled="true" /> --%>
						<!-- 비밀번호 IVR -->
<%-- 						<ifvm:inputNew type="button" id="btnDelPhone" btnFunc="fnDelPhone" --%>
<%-- 							text="L02191" /> --%>
						<!-- 휴대폰 삭제 -->
					</div>
					<script>
						function fnDelPhone(){
							if(confirm('<spring:message code="L02192"/>')){ //휴대폰정보를 삭제하시겠습니까?
								$.ifvSyncPostJSON(
										'<ifvm:action name="delPhoneNum"/>',
										{
											rid : gMbrDetail.data.rid,
											hhpNo : gMbrDetail.data.hhpNo
										},
										function(result) {

											if(result.success){
												alert('<spring:message code="L01260"/>');//정상적으로 수정되었습니다.
											}
											gMbrDetail.loadData();
										})
							}
						}
						function fnPwdIvr() {
							parent.changeCardPwd(gMbrDetail.data.mbrNo);
						}
						function mbrDetailInfoOpen() {
							mbrDetailInfo = {
								id : "mbrDetailInfoPop",
								url : '<ifvm:url name="viewDetailInfoPop"/>',
								pop : function(obj) {
									this.url = '<ifvm:url name="viewDetailInfoPop"/>'
											+ '?ridMbr=' + gMbrDetail.data.rid
									$("#" + this.id)
											.ifvsfPopup(
													{
														enableModal : true,
														enableResize : false,
														contentUrl : this.url,
														contentType : "ajax",
														title : '<spring:message code="L00833"/>', // 멤버십 회원 상세 정보,
														width : '1200px',
														close : this.close
													});
								},
								beforeClose : function(obj) {

								},
								close : function(obj) {
									if (obj) {
										mbrDetailInfo.beforeClose(obj)
									}
									var _popObj = eval(this.id)
									gMbrDetail.loadData();
									$("#addr1Dtl").prop('disabled',true);
									mbrDetailInfoPop._destroy();

								}
							}
							mbrDetailInfo.pop();

						}
					</script>

				</div>
				<div class="form-horizontal top_well underline" id="reachInfo">
					<div class="row">
						<ifvm:inputNew type="text" id="custNm" dto="custNm"
							label="L00835" labelClass="2" conClass="4" disabled="true" />
						<!-- 회원명-->
						<ifvm:inputNew type="text" id="mbrNo" dto="mbrNo" disabled="true"
							label="L00836" labelClass="2" conClass="4" />
						<!-- 회원번호 -->
					</div>
					<div class="row">
							<%--
						<ifvm:inputNew type="select" id="memDiv" dto="memDiv"
							disabled="true" label="L00837" labelClass="2" conClass="4" />
							--%>
						<!-- 회원구분-->

						<ifvm:inputNew type="select" id="mbrStatCd" dto="mbrStatCd" disabled="true" label="L01244" labelClass="2" conClass="4" />
						<!-- 회원상태 -->
						<ifvm:inputNew type="text" id="tierNm" dto="tierNm"
							disabled="true" label="L00838" labelClass="2" conClass="2" />
						<!-- 등급변경 -->
						<div class="col-xs-2 control_content">
							<ifvm:inputNew type="button" btnFunc="gMbrDetail.editMbrTier" objCode="editMbrTier_obj" text="등급변경" nuc="true"/>
						</div>
						<!-- 회원등급 -->
					</div>
					<div class="row">
				<%-- 		<ifvm:inputNew type="text" id="homeTelNo" dto="homeTelNo"
							icon="phone" label="L00839" labelClass="2" conClass="3"
							className="blockTarget" />
						<!-- 자택전화번호-->
						<div class="col-xs-1 middle">
							<ifvm:inputNew type="button" id="callConNo" nuc=""
								btnType="phone" btnFunc="makeCallForContactInfo"
								className="btn-imgonly" disabled="true" />
						</div> --%>

						<!-- 본인생년월일 -->
						<ifvm:inputNew type="text" id="birthDt" dto="birthDt" label="L00842" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="hhpNoDec" dto="hhpNoDec" icon="phone" disabled="true" label="L00840" labelClass="2" conClass="4" />
						<!-- 핸드폰번호 -->
						<%--
						<div class="col-xs-1 middle">
							<ifvm:inputNew type="button" id="callHpNo" nuc="" btnType="phone"
								btnFunc="makeCallForHhpNo" className="btn-imgonly"
								disabled="true" />
						</div>
						<script>
							//소프트폰 전화걸기 함수
							//자택 전화걸기
							function makeCallForContactInfo() {
								var contactInfo = $("#homeTelNo").val();
								parent.localSoftMakeCall(contactInfo, null);
							}
							//휴대폰전화걸기
							function makeCallForHhpNo() {
								var phoneNo = $("#hhpNo").val();
								parent.localSoftMakeCall(phoneNo, null);
							}
						</script>
						 --%>
					</div>
<!-- 					<div class="row"> -->
						<!-- 본인생일구분-->
						<%-- <ifvm:inputNew type="select" id="lunarGbnCd" dto="lunarGbnCd" label="L00841" labelClass="2" conClass="4" /> --%>
						<!-- 본인생년월일 -->
						<%-- <ifvm:inputNew type="date" id="birthDt"   dto="birthDt"
							label="L00842" labelClass="2" conClass="4" /> --%>
<!-- 					</div> -->
					<div class="row">
						<!-- 고객정보 -->
						<ifvm:inputNew type="select" id="custTypeCd" dto="custTypeCd" disabled="true" label="L00318" labelClass="2" conClass="4" />
						<ifvm:inputNew type="select" id="genGbnCd"   dto="genGbnCd"    disabled="true"
					label="L01184" labelClass="2" conClass="2" /><!-- 성별 -->
					</div>

					<div class="row">
					<!-- 고객 식별값 -->
						<ifvm:inputNew type="select" id="identiTypeCd" dto="identiTypeCd" disabled="true" label="L00343" labelClass="2" conClass="4" />
						<ifvm:inputNew type="text" id="identiVal" dto="identiVal" disabled="true" label="L00342" labelClass="2" conClass="4" />

					</div>
					<div class="row">
						<!-- 자택우편번호-->
						<ifvm:inputNew type="search" id="addr1Zip|addr1ZipSearch"
							names="addr1Zip" hidId="addr1ZipTemp" hidDto="addr1ZipTemp"
							dto="addr1Zip" btnFunc="addrSearchHelpBtn" searchBlurEvent="addrSearchHelpBlur"
							searchEnterEvent="addrSearchHelpEnter" label="L00843"
							labelClass="2" conClass="3" />
						<!-- [도로명]주소 -->
							<ifvm:inputNew type="text" id="addr1Dflt" dto="addr1Dflt"  conClass="7" disabled="true" />
						<!-- 주소변경일시 -->
						<%-- <ifvm:inputNew type="text" id="ownhomeAdrChgDt" dto="ownhomeAdrChgDt" disabled="true" label="L00844" labelClass="2" conClass="4" /> --%>
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="addr1Dtl" dto="addr1Dtl"	className="blockTarget" disabled="true" label="L00846" labelClass="2" conClass="10" />
						<!-- [도로명]주소상세 -->
					</div>
				</div>
			</div>
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-2">
						<span><spring:message code="L00847" /></span>
						<!-- 추가정보 -->
					</div>
					<div class="col-xs-10 searchbtn_r">
<%-- 						<ifvm:inputNew type="button" id="changeTaxiBtn" --%>
<%-- 							btnFunc="gMbrDetail.changeTaxi" text="L00821" --%>
<%-- 							className="dropHidBtn" /> --%>
						<!-- 개인택시 전환 -->
<%-- 						<ifvm:inputNew type="button" id="changeNmbrBtn" --%>
<%-- 							btnFunc="gMbrDetail.changeNmbr" text="L01857" --%>
<%-- 							className="dropHidBtn" /> --%>
						<!-- 일반회원 전환 -->
<%-- 						<ifvm:inputNew type="button" btnFunc="gMbrDetail.changeCorpTaxiYn" --%>
<%-- 							text="L00822" className="dropHidBtn" /> --%>
						<!-- 법인택시 설정/해제 -->
						<%-- <ifvm:inputNew type="button" id="webJoinErrorBtn" btnFunc="gMbrDetail.webJoinError.pop" text="L00823"  className="dropHidBtn" /> --%>
						<!-- 웹가입 에러처리 -->

					</div>
				</div>
				<div class="form-horizontal top_well underline" id="mktAgree">
					<div class="row">
						<ifvm:inputNew type="text" id="avlPoint" dto="avlPoint"
							disabled="true" className="text-right" label="가용 포인트" nuc="true"
							labelClass="2" conClass="4" />
						<!-- 가용포인트-->
						<%--
						<ifvm:inputNew type="text" id="totChangePoint"
							dto="totChangePoint" disabled="true" className="text-right"
							label="L00849" labelClass="2" conClass="4" />
						 --%>
						<!-- 총충전포인트 -->
					</div>
					<%--
					<div class="row">
						<ifvm:inputNew type="text" id="giftAvlPoint" dto="giftAvlPoint"
							disabled="true" className="text-right" label="L00851"
							labelClass="2" conClass="4" />
						<!-- 선물가능포인트 -->
						<ifvm:inputNew type="text" id="giftPoint" dto="giftPoint"
							disabled="true" className="text-right" label="L00850"
							labelClass="2" conClass="4" />
						<!-- 선물받은포인트-->
					</div>
					 --%>
					<div class="row">
						<%--
						<ifvm:inputNew type="text" id="extncPamMonth" dto="extncPamMonth"
							disabled="true" label="L00852" labelClass="2" conClass="4" />
						<!-- 소멸예정월-->
						--%>
						<ifvm:inputNew type="text" id="preAcrlPoint" dto="preAcrlPoint"
							disabled="true" className="text-right" label="L02383"
							labelClass="2" conClass="4"/>
						<!-- 적립예정포인트 -->
						<ifvm:inputNew type="text" id="extncPamPoint" dto="extncPamPoint"
							disabled="true" className="text-right" label="소멸예정포인트"
							labelClass="2" conClass="4" desc="익월 1일 자동소멸" nuc="true"/>
						<!-- 소멸예정포인트 -->
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="wbMemId" dto="wbMemId" disabled="true" label="L00854" labelClass="2" conClass="4" />
						<!-- 웹회원ID-->
						<%-- <ifvm:inputNew type="singleCheckbox" id="wbMemYn" dto="wbMemYn" label="L00855" values="wbMemYn" disabled="true" labelClass="2" conClass="1" /> --%>
						<!-- 간편가입 전환회원-->
						<%-- <ifvm:inputNew type="singleCheckbox" id="simpleMbrSwitchYn" dto="simpleMbrSwitchYn" label="기존회원여부" nuc="true" values="simpleMbrSwitchYn" disabled="true" labelClass="2" conClass="1" /> --%>
						<ifvm:inputNew type="singleCheckbox" id="newUserYn" dto="newUserYn" label="기존회원여부" nuc="true" values="newUserYn" disabled="true" labelClass="2" conClass="1" />
					</div>
					<div class="row">
						<%--
						<ifvm:inputNew type="select" id="ridChnlJoin" dto="ridChnlJoin"
							disabled="true" label="L00859" labelClass="2" conClass="4" />
						--%>
						<ifvm:inputNew type="text" id="chnlJoinNm" dto="chnlJoinNm" disabled="true" label="L00859" labelClass="2" conClass="4" />
						<!-- 가입채널-->
						<ifvm:inputNew type="text" id="rcmmdCd" dto="rcmmdCd" disabled="true" label="추천인ID(본인)" nuc="true" labelClass="2" conClass="4" />
						<!-- 가입 추천 회원 (웹회원ID + 회원명) -->
						<%-- <ifvm:inputNew type="singleCheckbox" id="solPayYn" dto="solPayYn" label="다이소SOL페이가입" nuc="true" values="wbMemYn" disabled="true" labelClass="2" conClass="1" /> --%>
						<!-- 웹회원ID-->
						<%--
						<ifvm:inputNew type="select" id="sbscChnlDtlCd"
							dto="sbscChnlDtlCd" disabled="true" label="L00860" labelClass="2"
							conClass="4" />
						<!-- 가입채널상세-->
						 --%>
					</div>
					<div class="row">
					<ifvm:inputNew type="text" id="joinRcmmdNm" dto="joinRcmmdNm" disabled="true" label="추천인ID(회원명)" nuc="true" labelClass="2" conClass="4" />
					<%-- <ifvm:inputNew type="text" id="famNo" dto="famNo" disabled="true" label="패밀리 번호" nuc="true" labelClass="2" conClass="4" /> --%>
						<%--
						<ifvm:inputNew type="text" id="semiVipStartDt"
							dto="semiVipStartDt" disabled="true" label="L02006"
							labelClass="2" conClass="4" /> --%>
						<!-- 맛보기 시작일-->
				<%-- 		<ifvm:inputNew type="text" id="semiVipEndDt" dto="semiVipEndDt"
							disabled="true" label="L02007" labelClass="2" conClass="4" /> --%>
						<!-- 맛보기 종료일-->

<%--  						<ifvm:inputNew type="singleCheckbox" id="e1MemYn" dto="e1MemYn"  --%>
<%--  							label="L00856" values="e1MemYn" disabled="true" labelClass="2"  --%>
<%--  							conClass="1" /> --%>
					</div>
					<div class="row">
						<!-- 실명인증  일시-->
						<ifvm:inputNew type="text" id="realNmCertiDate" dto="realNmCertiDate" disabled="true" label="실명인증 일시" nuc="true"  labelClass="2" conClass="4" />

						<!--<ifvm:inputNew type="singleCheckbox" id="mktAgrePrvInfoOpt"
							label="L02099" values="mktAgrePrvInfoOpt" disabled="false"
							dto="mktAgrePrvInfoOpt" labelClass="3" conClass="1" />
						<!-- 개인정보 수집 및 이용 동의-->
<%-- 						<ifvm:inputNew type="singleCheckbox" id="corpTaxiYn" --%>
<%-- 							dto="corpTaxiYn" label="L00857" values="corpTaxiYn" --%>
<%-- 							disabled="true" labelClass="4" conClass="1" /> --%>
						<%--<ifvm:inputNew type="singleCheckbox" id="eventTgtYn"  label="L00858" values="eventTgtYn" disabled="true"
							labelClass="2" conClass="1" /> --%>
					</div>
					<div class="col-xs-12"></div>
					<ifvm:inputNew type="hidden" id="hCity" dto="hCity" />
					<ifvm:inputNew type="hidden" id="hGu" dto="hGu" />
					<ifvm:inputNew type="hidden" id="addr1JiDflt" dto="addr1JiDflt" />
					<ifvm:inputNew type="hidden" id="addr1JiDtl" dto="addr1JiDtl" />
					<ifvm:inputNew type="hidden" id="addr1JiZip" dto="addr1JiZip" />
				</div>
			</div>
		</div>
	</div>

</div>
</div>

<div id="mbrDetailTabArea">

	<!-- 탭 컨텐츠 -->
	<!--
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
	-->
</div>

<div id="searchChargePop" class="popup_container"></div>
<!--충전량 조회  -->
<div id="mbrDetailInfoPop" class="popup_container"></div>
<!--회원상세 -->
<div id="certiPopup" class="popup_container"></div>
<!--본인인증-->
<div id="checkPwCngDatePop" class="popup_container"></div>
<!--비밀번호 수정일시-->
<div id="searchMbrPop" class="popup_container"></div>
<!--검색-->
<div id="changePhonePop" class="popup_container"></div>
<!--검색-->
<div id="addrPopupContainer" class="popup_container"></div>
<!--주소 검색-->
<div id="checkAvlPointPop" class="popup_container"></div>
<!--가용포인트-->
<div id="createVocPop" class="popup_container"></div>
<!--상담생성-->
<div id="editMbrPntUsePwPop" class="popup_container"></div>
<!--포인트사용비밀번호변경-->
<div id="editMbrUsePwPop" class="popup_container"></div>
<!--비밀번호변경-->
<div id="editMbrNamePop" class="popup_container"></div>
<!--이름 변경-->
<div id="poinTransMbrPop" class="popup_container"></div>

<!-- 포인트이관 -->

<!-- 탈회 -->
<div id="dropReasonPop" class="popup_container"></div>

<!--오카행운-->
<div id="orangeCardLuckPop" class="popup_container"></div>

<!-- 등급 목록 -->
<div id="mbrTierListPop" class="popup_container"></div>
