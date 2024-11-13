<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
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
var consultGrid;

var isMask = true;
var maskYN = '<%= cleanXss(request.getParameter("maskYN")) %>'; // 마스킹 된 상태
if(maskYN != null && maskYN == "N") isMask = false;
var noneFlag = false;
var temp = null;
var initFlag = false;

//멤버십 회원 상세 정보 - 이성원 과장님
gMbrDetail = {
	data  : {},
	checkBoxIds : ['wbMemYn', 'e1MemYn', 'corpTaxiYn', 'eventTgtYn','mktAgrePrvInfoOpt'],
	pointFieldId : ['avlPoint', 'totChangePoint', 'giftPoint', 'giftAvlPoint', 'extncPamPoint'],
	phoneFieldId : ['homeTelNo', 'hhpNo'],
	dateTimeFieldId : ['ownhomeAdrChgDt'],
	setCheckBox : function(result){
		$("#mbrForm input[type='checkbox']").prop("checked",false);
		for(i in gMbrDetail.checkBoxIds){
			if(result[gMbrDetail.checkBoxIds[i]] != "" && result[gMbrDetail.checkBoxIds[i]] != null && (result[gMbrDetail.checkBoxIds[i]]).toUpperCase() == "Y"){
				
				$("#mbrForm input[type='checkbox'][value='"+gMbrDetail.checkBoxIds[i]+"']").prop('checked',true);
			}
		}
	},
	setPointField : function(){
		for(var pi = 0 ; pi < this.pointFieldId.length ; pi++){
			var _pval = $("#"+this.pointFieldId[pi]).val();
			var _aval="";
			if(_pval){
				_aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			$("#"+this.pointFieldId[pi]).val(_aval);
		}
	},
	setBirthField : function(value){
		if(value){
			return value.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');;
		}
		else{
			return "";
		}
	},
	setDateTimeField : function(){
		for(var pi = 0 ; pi < this.dateTimeFieldId.length ; pi++){
			var _pval = $("#"+this.dateTimeFieldId[pi]).val();
			var _aval="";
			if(_pval){
				_aval = _pval.split('.')[0];
			}
			$("#mbrForm #"+this.dateTimeFieldId[pi]).val(_aval);
		}
	},
	setPhoneField : function(){
		for(var pi = 0 ; pi < this.phoneFieldId.length ; pi++){
			var _pval = $("#"+this.phoneFieldId[pi]).val();
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
			$("#mbrForm #"+this.phoneFieldId[pi]).val(_aval);
		}
	},
	clearMasking : function(result){
		var targetField = [{
			type : 'mbr',
			field : 'tel',
			rid : $.ifvGetParam('rid'),
			target : 'homeTelNo'
		}, {
			type : 'mbr',
			field : 'phone',
			rid : $.ifvGetParam('rid'),
			target : 'hhpNo'
		}]

		for (var i=0  ; i < targetField.length ; i++){
			$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
					targetField[i],
	        function(result) {
				$("#"+targetField[i].target).val(result.message);
				if(result.message){
					gMbrDetail.data[targetField[i].target] = result.message.replaceAll('-','');
				}
		     })
		}
	},
	init : function(){
		$.ifvGetCommCodeList('select', 'memDiv', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_TYPE', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'tierCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_GRADE', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'sbscChnlCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CHANNEL', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'sbscChnlDtlCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CHANNEL_DTL', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'lunarGbnCd', '<ifvm:action name="getCommCodeList2"/>', 'BIRTHDAY_CD', 'loy', false, false, true);
		$.ifvmLnbSetting('mbrList');
		this.loadData();
	},
	loadData : function(){
		var action = '<ifvm:action name="getMbrDetail"/>';
		$.ifvSyncPostJSON(action, {
			rid: ridMbr
		}, function(result) {
			

			if ($.fn.ifvmIsNotEmpty(result)) {
				result.birthDt = gMbrDetail.setBirthField(result.birthDt);
				$("#mbrForm").dataSetting(result);
				gMbrDetail.setCheckBox(result);
				gMbrDetail.setPointField();
				gMbrDetail.setDateTimeField();
				gMbrDetail.setPhoneField();
				gMbrDetail.data = result;
				gMbrDetail.clearMasking(result);
				addr1ZipTemp = result.addr1Zip;
				//일반이 아니면 '개인택시 전환'버튼 비활성화
				if(result.memDiv != "P"){
					$("#changeTaxiBtn").prop("disabled",true);
				}
				//개인택시 회원 일 경우만 '일반회원 전환'버튼 활성화
				if(result.memDiv != "T"){
					$("#changeNmbrBtn").prop("disabled",true);
				}
				//회원의 상태코드값이 20(탈퇴) 일경우에는 '이벤트응모', '탈회' 버튼  비활성화
				//탈회회원 메뉴 active
				if(result.mbrStatCd == "20"){
					$("#tryEventBtn, #dropMbrBtn").prop("disabled",true);
					$("#infavorMenu #mbrList").removeClass('active');
					$.ifvmLnbSetting('dropMbrList');
				}

				//웹 회원이 아니면 '웹가입 에러처리'버튼 비활성화
				if(result.wbMemYn != "Y"){
					$("#webJoinErrorBtn").prop('disabled',true);
				}
			}else{
				alert('<spring:message code="L01609"/>');//잘못된 접근입니다.
// 				gMbrDetail.moveList();
			}
		})
	},
// 	moveList : function(){// 목록페이지 이동
// 		//탈회회원이면 탈회 회원 리스트로 이동
// 		if(gMbrDetail.data.mbrStatCd == "20"){
// 			qtjs.href('<ifvm:url name="dropMbrList"/>');
// 		}else{
// 			qtjs.href('<ifvm:url name="mbrList"/>');
// 		}

// 	},
	changeCorpTaxiYn : function (){ //법인택시 설정/해제

		if(confirm('<spring:message code="L00929"/>') == true){
			//기존 데이터에 CorpTaxiYn만 바꿔서 가져가기
			data = gMbrDetail.data;
			data.rid = $.ifvGetParam('rid');
			if(data.corpTaxiYn == "Y"){
				data.corpTaxiYn = "N"
			}else{
				data.corpTaxiYn = "Y"
			}
			console.log(data);
			var action = '<ifvm:action name="editMbrDetail"/>';
			$.ifvSyncPostJSON(action, data , function(result) {

				if (result.success) {
					alert('<spring:message code="L01260"/>');
					gMbrDetail.loadData();
				}
			})
		}
	},
	getChgHist : function(_data){//필요 없음
		var rtnList = [];
		rtnList = ifvCompareObj(gMbrDetail.data,_data);
		function convertToUnder(str){
			return str.replace(/([A-Z])/g, function(arg){
		        return "_"+arg.toLowerCase();
		    }).toUpperCase();
		}
		for(var i = 0 ; i < rtnList.diff.length ;i ++){
			console.log(rtnList.diff[i]);
			rtnList.diff[i].chgTbl = "LOY_MBR";
			rtnList.diff[i].chgCol = convertToUnder(rtnList.diff[i].chgCol);
		}
		return rtnList;
	},
	save : function(){
		var tgtData = $("#mbrForm").getSubmitData();
		data = gMbrDetail.data;
		data.homeTelNo = tgtData.homeTelNo.replaceAll("-","");
		data.hhpNo = tgtData.hhpNo.replaceAll("-","")
		data.addr1Zip = tgtData.addr1Zip;
		data.addr1Dflt = tgtData.addr1Dflt;
		data.addr1Dtl = tgtData.addr1Dtl;
		data.rid = $.ifvGetParam('rid');
		data.addr1JiDflt = tgtData.addr1JiDflt;
		data.addr1JiDtl = tgtData.addr1Dtl;
		data.addr1JiZip = tgtData.addr1JiZip;
		data.hCity = tgtData.hCity;
		data.hGu = tgtData.hGu;

		console.log(data);
		var action = '<ifvm:action name="editMbrDetail"/>';
		$.ifvSyncPostJSON(action, data , function(result) {

			if (result.success) {
				alert('<spring:message code="L01260"/>');
				gMbrDetail.loadData();
			}
		})


	},
	searchCharge : { //충전량 조회
		id : "searchChargePop",
		pop : function(){
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="searchCharge"/>',
	            contentType : "ajax",
	            title : '<spring:message code="L00818"/>', // 충전량 조회,
	            width : '1000px'
	        });
		},
		beforeClose : function(obj){

		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}

	},
	mbrDetailInfo : { //회원상세
		id : "mbrDetailInfoPop",
		pop : function(){
			
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="viewDetailInfoPop"/>',
	            contentType : "ajax",
	            title : '<spring:message code="L00833"/>', // 멤버십 회원 상세 정보,
	            width : '1200px',
	            close : this.close
	        });
		},
		beforeClose : function(obj){

		},
		close: function(obj){
		/* 	if(obj){
				this.beforeClose(obj)
			} */
			var _popObj = eval(this.id)
			gMbrDetail.loadData();
			mbrDetailInfoPop._destroy();

		}
	},
	changePw : function(){ //비밀번호 변경


	},
	checkPwCngDate : { //비밀번호 수정일시
		id : "checkPwCngDatePop",
		pop : function(){
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="viewPwCngDataPop"/>',
	            contentType : "ajax",
	            title : '<spring:message code="L00831"/>', // 비밀번호 수정일시
	            width : '400px'
	        });
		},
		beforeClose : function(obj){

		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}
	},
	changeTaxi : function(){ //개인택시전환
		if(confirm('<spring:message code="L01817"/>') == true){
			data = gMbrDetail.data;
			data.rid = $.ifvGetParam('rid');
			console.log(data);
			var action = '<ifvm:action name="addChangeTaxi"/>';
			$.ifvSyncPostJSON(action, data , function(result) {

				if (result.success) {
					alert('<spring:message code="L01818"/>');
					gMbrDetail.loadData();
				}
			}, function(result){
				alert(result.message);
			})
		}
	},
	changeNmbr : function(){ //일반회원 전환
		if(confirm('<spring:message code="L01858"/>') == true){
			data = gMbrDetail.data;
			data.rid = $.ifvGetParam('rid');
			data.memDiv = "P";
			console.log(data);
			var action = '<ifvm:action name="changeNmbr"/>';
			$.ifvSyncPostJSON(action, data , function(result) {

				if (result.success) {
					alert('<spring:message code="L01818"/>');
					gMbrDetail.loadData();
				}
			}, function(result){
				alert(result.message);
			})
		}
	},
	changePhoneNum : {
		pop : function(){
	        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
	    		groupCode : 'SYM_URL',
	    		codeName : 'E1CellPhoneModifyPopup'
	    } , function(result) {

	        	if (result.success) {
	        		var url = result.rows[0].attrib01;
	        		var popUrl = url+"?seq="+gMbrDetail.data.mbrNo;
	        		var popOption = "width=420, height=320, resizable=no, scrollbars=no, status=no;";
	        		window.open(popUrl,"",popOption);

	        	}
	        }, function(result){
	        	alert(result.message);
	        })
		}
	},
	sendCoupon : {
		pop : function(){
	        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
	    		groupCode : 'SYM_URL',
	    		codeName : 'E1CouponSendPopup'
	    	} , function(result) {

	        	if (result.success) {
	        		var url = result.rows[0].attrib01;
	        		var popUrl = url+"?seq="+gMbrDetail.data.mbrNo;
	        		var popOption = "width=420, height=320, resizable=no, scrollbars=no, status=no;";
	        		window.open(popUrl,"",popOption);

	        	}
	        }, function(result){
	        	alert(result.message);
	        })
		}
	},
	tryEvent : {
		pop : function(){
			$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
	    		groupCode : 'B2C_EVENT',
	    		codeName : '10'
	    	} , function(result) {

	        	if (result.success && result.rows.length >0) {
	        		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
	    	    		groupCode : 'SYM_URL',
	    	    		codeName : 'E1EventPopup'
	    	    	} , function(result) {

	    	        	if (result.success) {
	    	        		var url = result.rows[0].attrib01;
	    	        		var popUrl = url+"?seq="+gMbrDetail.data.mbrNo;
	    	        		var popOption = "width=420, height=320, resizable=no, scrollbars=no, status=no;";
	    	        		window.open(popUrl,"",popOption);

	    	        	}
	    	        }, function(result){
	    	        	alert(result.message);
	    	        })

	        	}
	        }, function(result){
	        	alert(result.message);
	        })
		}
	},
	dropMbr : function(){
		if(gMbrDetail.data.avlPoint>0){
			if(!confirm($("#avlPoint").val()+'<spring:message code="L01823"/>')){
				return;
			}
		}else{
			if(!confirm('<spring:message code="L01982"/>')){
				return;
			}
		}
		var data = {
				mbrNo : gMbrDetail.data.mbrNo
		}
		$.ifvSyncPostJSON('<ifvm:action name="dropMbrProc"/>', data , function(result) {

        	if (result.success) {
        		alert('<spring:message code="L01824"/>');
        		qtjs.href('<ifvm:url name="mbrList"/>');

        	}
        }, function(result){
        	alert(result.message);
        })
	},
	webJoinError : {
		pop : function(){
			$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
	    		groupCode : 'SYM_URL',
	    		codeName : 'WebJoinError'
	    	} , function(result) {

	        	if (result.success) {
	        		var url = result.rows[0].attrib01;
	        		var popUrl = url+"?seq="+gMbrDetail.data.mbrNo;
	        		var popOption = "width=420, height=320, resizable=no, scrollbars=no, status=no;";
	        		window.open(popUrl,"",popOption);

	        	}
	        }, function(result){
	        	alert(result.message);
	        })
		}
	},
	viewAvlPoint : {
		id : "checkAvlPointPop",
		pop : function(){
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="viewAvlPointPop"/>',
	            contentType : "ajax",
	            title : '<spring:message code="L00468"/>', // 가용 포인트
	            width : '400px'
	        });
		},
		beforeClose : function(obj){

		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}
	}
}

//상담요청 리스트
function consultList(){
	var jqGridOption = {
		ondblClickRow : function(data){
			var data = consultGrid.getRowData()[data-1];
			qtjs.href("${pageContext.request.contextPath}/voc/requestConsultation/consultDetail?rid=" +data.rid+"&ridCust="+data.ridCust+"&custNm=");
		},
	    onSelectRow : function (data) {
	    	rowData = [];
	    	rowData = data;
	    	getConsultDetail(data);

	    	$("#unmaskBtn").attr("disabled",null);
	    	$("#detail_callConNo, #msgConNo, #detail_callHpNo, #msgHpNo, #sendEmail").attr("disabled",true);
		},
		serializeGridData : function( data ){
			data.ridCust = ridCust;

			//초기 리스트 조회 시, 접수상태가 '접수'인 것만 조회되도록
			if(initFlag){
				data.initFlag = '1';
			}
		},
		loadComplete : function(data){
			if(data.rows.length == 1){
				consultGrid.setSelection("1");
				getConsultDetail(data.rows[0]);

				//마스킹해제 버튼 disabled 처리
		    	$("#unmaskBtn").attr("disabled",null);
		    	$("#callConNo, #msgConNo, #callHpNo, #msgHpNo, #sendEmail").attr("disabled",true);
			}

			parent.setParentIframeHeight();
		},
		url: '<ifvm:action name="getConsultList"/>',
	    colNames:[
	              '<spring:message code="V00017"/>', /* 접수일시 */
	              '<spring:message code="V00007"/>', /* 처리상태 */
	              '<spring:message code="V00004"/>', /* 회원번호 */
	              '<spring:message code="V00005"/>', /* 회원명 */
	              '<spring:message code="V00009"/>', /* 연락처 */
	              '<spring:message code="V00006"/>', /* 휴대폰번호 */
	              '<spring:message code="V00008"/>', /* e-mail */
	              '<spring:message code="V00010"/>', /* 상담유형(대) */
	              '<spring:message code="V00011"/>', /* 상담유형(중) */
	              '<spring:message code="V00012"/>', /* 상담유형(소) */
// 	              '<spring:message code="V00016"/>', /* SR번호 */  
	              'rid',
	              'ridCust',
	              'ridCrmuser',
	              'callId'
	              ],
	    colModel:[
	              {name:'rcpDt', 					index:'t1.rcp_dt', 				resizable : false, 		align:'center',    	width:'120px',  		formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
	              {name:'srTrtStatusNm', 			index:'c1.mark_name', 			resizable : false, 		align:'center',    	width:'60px'},
	              {name:'memNo',     				index:'t1.mem_no', 				resizable : false, 		align:'center',    	width:'100px',		formatter: goGridRowMbrLink},
	              {name:'memNm', 					index:'t1.mem_nm', 				resizable : false, 		align:'left',    	width:'100px'},
	              {name:'cntcDesk', 				index:'t1.cntc_desk', 			resizable : false, 		align:'center',    	width:'120px'},
	              {name:'memPtblNo', 				index:'t1.mem_ptbl_no', 		resizable : false, 		align:'center',    	width:'120px'},
	              {name:'emailAddr', 				index:'t1.email_addr', 			resizable : false, 		align:'left',    	width:'120px'},
	              {name:'cnslgTypeCdLNm', 			index:'c2.mark_name', 			resizable : false, 		align:'left',    	width:'100px'},
	              {name:'cnslgTypeCdMNm', 			index:'c3.mark_name', 			resizable : false, 		align:'left',    	width:'100px'},
	              {name:'cnslgTypeCdSNm', 			index:'c4.mark_name', 			resizable : false, 		align:'left',    	width:'100px'},
// 	              {name:'srNo',  					index:'t1.sr_no', 				resizable : false, 		align:'left',    	width:'150px'},
	              {name:'rid', 						index:'t1.rid', 				resizable : false, 		hidden : true},
	              {name:'ridCust', 					index:'t1.rid_Cust', 			resizable : false, 		hidden : true},
	              {name:'ridCrmuser', 				index:'t1.rid_crmuser', 		resizable : false, 		hidden : true},
	              {name:'callId', 					index:'t1.callId', 				resizable : false, 		hidden : true},
			      ],
// 		multiselect: true,
		radio: true,
		sortname: 't1.sr_no',
		sortorder: "desc",
// 		tempId : 'ifvGridExcelTemplete'
	};
	consultGrid = $("#consultGrid").ifvGrid({ jqGridOption : jqGridOption });

	$("#detail_callConNo, #msgConNo, #detail_callHpNo, #msgHpNo, #sendEmail").attr("disabled",true);
}

//상담요청 상세
function getConsultDetail(data){
	$.ifvSyncPostJSON('<ifvm:action name="getConsultDetail"/>',{
		rid : data.rid
	},function(result) {
		$("#detail_srNo").val(result.srNo);
		$("#detail_contactInfo").val(result.cntcDesk);
		$("#detail_memRid").val(result.ridMbr);
		$("#detail_ridCust").val(result.ridCust);
		$("#detail_memNo").val(result.memNo);
		$("#detail_phoneNo").val(result.memPtblNo);
		$("#detail_memName").val(result.memNm);
		$("#detail_email").val(result.emailAddr);
		$("#detail_consultTitle").val(result.cnslgTitle);
		$("#detail_consultContent").val(result.cnslgSbst);
		$("#detail_consultType1st").val(result.cnslgTypeCdL);
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", true);
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
		$("#detail_consultType2nd").val(result.cnslgTypeCdM);
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
		$("#detail_consultType3rd").val(result.cnslgTypeCdS);
		$("#detail_receptionMethod").val(result.rcpMeth);
		$("#detail_franchiseRid").val(result.ridChnl)
		$("#detail_franchiseCode").val(result.chnlNo);
		$("#detail_franchiseName").val(result.chnlNm);
		$("#detail_affiliatedCom").val(result.cprtVndrCd);
		if(result.cprtVndrHhoConvFail == "Y"){
			$("#detail_affiliatedComFail").prop("checked",true);
		}else{
			$("#detail_affiliatedComFail").prop("checked",false);
		}
		$("#detail_processSituation").val(result.srTrtStatusNm);
		$("#detail_receptionist").val(result.createBy);
		$("#detail_receptionDate").val(result.rcpDt);
// 		$("#detail_personInChargeRid").val(result.ridCrmuser);
// 		$("#detail_personInChargeUserId").val(result.crmuserId);
		$("#detail_personInChargeName").val(result.crmuserName);
		$("#detail_transferDate").val(result.trcDt);
		$("#detail_endDate").val(result.endDt);
		$("#detail_callId").val(result.callId);
	});
}

//상담요청 신규
function clickNewBtn(){
	var custNm = encodeURIComponent( encodeURIComponent( $("#custNm").val() ) );
// 	encodeURI($("#custNm").val());

	qtjs.href("${pageContext.request.contextPath}/voc/requestConsultation/consultDetail?ridCust="+ridCust+"&mbrNo="+$("#mbrNo").val()+"&custNm="+custNm+"&ridMbr="+ridMbr);
}

function init(){
// 	clearMbrDetail();
	
	gMbrDetail.init();

	$.fn.ifvmSetSelectOptionCommCode("detail_consultType1st", "SR_AREA_L", null, null, false);
	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", false);
	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", false);

	$.ifvGetCommCodeList('select', 'detail_receptionMethod', '<ifvm:action name="getCommCodeList"/>', 'CALL_TYPE', 'voc', false, true, true);
	$.ifvGetCommCodeList('select', 'detail_affiliatedCom', '<ifvm:action name="getCommCodeList"/>', 'ALLIANCE_COMPANY_TYPE', 'voc', false, true, true);

	getConsultListStatusOpen();

	$("#unmaskBtn").attr("disabled",true);
}

//SR정보 마스킹 해제
function clickUnmaskBtn(){
	if($("#detail_contactInfo").val() != ""){
		//연락처 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: rowData.rid ,
	           type: 'voc' ,
	           field: 'cntcDesk'
	       },
	       function(result) {
	       	$("#detail_contactInfo").val(result.message);
	       	if(window.parent.document.getElementById("TSPhone")){
		       	$("#detail_callConNo").attr("disabled",null);
	       	}
	    	$("#msgConNo").attr("disabled",null);
	       });
	}

	if($("#detail_phoneNo").val() != ""){
		//휴대폰번호 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: rowData.rid ,
	           type: 'voc' ,
	           field: 'memPtblNo'
	       },
	       function(result) {
	       	$("#detail_phoneNo").val(result.message);
	       	if(window.parent.document.getElementById("TSPhone")){
		       	$("#detail_callHpNo").attr("disabled",null);
	       	}
	    	$("#msgHpNo").attr("disabled",null);
	       });
	}

	if($("#detail_email").val() != ""){
		//이메일 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: rowData.rid ,
	           type: 'voc' ,
	           field: 'emailAddr'
	       },
	       function(result) {
	       	$("#detail_email").val(result.message);
	       	$("#sendEmail").attr("disabled",null);
	       });
	}

	$("#unmaskBtn").attr("disabled",true);

}

//녹취청취 버튼
function clickRecordBtn2(){
	var checkedList = consultGrid.getCheckedList();

	if(consultGrid.getCheckedGridData()[0] != undefined && checkedList.length == 1){
		$("#playRecordFilePop").ifvsfPopup({
		   enableModal : true,
		   enableResize: false,
		   contentUrl: '<ifvm:url name="playRecordFilePop"/>?callId='+rowData.callId+'&callDate='+rowData.rcpDt,
		   contentType: "ajax",
		   title: "<spring:message code='V00158'/>",
		   width: 600,
		   close : 'playRecordFilePopClose'
		});
	}else if(checkedList.length > 1){
		alert('<spring:message code="V00204"/>');
	}else if(consultGrid.getCheckedGridData()[0] == undefined){
		alert('<spring:message code="V00198"/>');
	}

}

//소프트폰 전화걸기 함수
function makeCallForContactInfo(){
	var contactInfo = $("#detail_contactInfo").val();

	parent.localSoftMakeCall(contactInfo,null);
}
function makeCallForHhpNo(){
	var phoneNo = $("#detail_phoneNo").val();

	parent.localSoftMakeCall(phoneNo,null);
}

function getConsultListStatusOpen(){
	initFlag = true;

	consultList();

	initFlag = false;
}

//문자메시지&이메일 전송 팝업
function showTransChnlPopForConNo() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#detail_contactInfo").val() + "&ridCust=" + $("#detail_ridCust").val();

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForHpNo() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#detail_phoneNo").val() + "&ridCust=" + $("#detail_ridCust").val();

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForEmail() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=email&email=" + $("#detail_email").val() + "&ridCust=" + $("#detail_ridCust").val();

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
// function checkButtnAuth(){
// 	var isAuth = false;
// 	var authArr = $.ifvmGetAuthInfo().authList;
// 	for(var i = 0 ; i < authArr.length ; i++){
// 		var authObj = authArr[i];
// 		var authName = authObj.authName;
// 		if(authName == 'E10010') isAuth = true;
// 	}
// 	if(!isAuth){
// 		$("#unmaskBtn").remove();
// 	}
// }

function clearMbrDetail(){
	$("#mbrForm input[type='text']").val("");
// 	$("#mbrForm select").val("");
	$("#mbrForm input[type='checkbox']").prop("checked",false);
}

function goGridRowMbrLink(cellvalue, options, rowObjec){
    var memNo = rowObjec.memNo;
    var url = '<ifvm:url name="mbrDetail"/>' + '?mbrNo=' + memNo;
   	var tag = null;
   	
   	if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
   	
   	return tag;
}

$(document).ready(function(){
	init();
	//마스킹해제 권한 체크
// 	checkButtnAuth();
});

</script>

<style>
	.heightForm{
		height:230px;
	}
	.middle {
	  	vertical-align: middle;
	  	text-align: left;
	}
</style>

<div>
	<div class="page_btn_area">
		<div class="col-xs-2">
			<span><spring:message code="V00114"/></span>
		</div>
		<div class="col-xs-10 searchbtn_r">
			<ifvm:inputNew type="button" id="newBtn"  text="M00274" btnType="plus" btnFunc="clickNewBtn" objCode="COM_NEW_001"/>
			<ifvm:inputNew type="button" id="recordBtn"  text="V00015" btnFunc="clickRecordBtn2" objCode="VOC_REC_001"/>
			<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('consultGrid')" objCode="COM_EXC_001"/>
		</div>
	</div>
	<div id=consultGrid class="grid_bd0"></div>
</div>

<!-- SR정보 -->
<div class="col-xs-6">
	<div class="page_btn_area">
		<div class="col-xs-3">
			<span><spring:message code="V00030"/></span>
		</div>
		<div class="col-xs-9 searchbtn_r">
			<ifvm:inputNew type="button" id="unmaskBtn"  text="L00326" btnType="" btnFunc="clickUnmaskBtn" objCode="COM_MSK_001"/>
		</div>
	</div>
	<div class="well form-horizontal heightForm underline">
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="detail_srNo" label="V00016" labelClass="2" conClass="3" disabled="true"/>
			<ifvm:inputNew type="text" id="detail_contactInfo" label="V00009" labelClass="2" conClass="3" disabled="true"/>
			<div class="col-xs-2 middle">
				<ifvm:inputNew type="button" id="detail_callConNo" nuc="" btnType="phone" btnFunc="makeCallForContactInfo" className="btn-imgonly"/>
				<ifvm:inputNew type="button" id="msgConNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForConNo" className="btn-imgonly"/>
			</div>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="hidden" id="detail_memRid" />
			<ifvm:inputNew type="hidden" id="detail_ridCust" />
<%-- 			<ifvm:inputNew type="search" id="detail_memNo" names="detail_memNo" objCode="SRCH" dto="detail_memNo" btnFunc="showMemNoPop" label="V00004" labelClass="2" conClass="3" /> --%>
			<ifvm:inputNew type="text" id="detail_memNo" label="V00004" labelClass="2" conClass="3" disabled="true"/>
			<ifvm:inputNew type="text" id="detail_phoneNo" label="V00006" labelClass="2" conClass="3" disabled="true"/>
			<div class="col-xs-2 middle">
				<ifvm:inputNew type="button" id="detail_callHpNo" nuc="" btnType="phone" btnFunc="makeCallForHhpNo" className="btn-imgonly"/>
				<ifvm:inputNew type="button" id="msgHpNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForHpNo" className="btn-imgonly"/>
			</div>
		</div>
		<div class="row qt_border">
<%-- 			<ifvm:inputNew type="search" id="detail_memName" names="detail_memName" objCode="SRCH" dto="detail_memName" btnFunc="showMemNamePop" label="V00005" labelClass="2" conClass="3" /> --%>
			<ifvm:inputNew type="text" id="detail_memName" label="V00005" labelClass="2" conClass="3" disabled="true"/>
			<ifvm:inputNew type="text" id="detail_email" label="V00008" labelClass="2" conClass="3" disabled="true"/>
			<div class="col-xs-2 middle">
				<ifvm:inputNew type="button" id="sendEmail" nuc="" btnType="envelope-o" btnFunc="showTransChnlPopForEmail" className="btn-imgonly"/>
			</div>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="detail_consultTitle" label="V00018" labelClass="2" conClass="8" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="detail_consultContent" label="V00019" labelClass="2" conClass="8" disabled="true" rows="5"/>
		</div>
	</div>
</div>
<!-- SR유형 -->
<div class="col-xs-3 pl10">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="V00031"/></span>
		</div>
	</div>
	<div class="well form-horizontal heightForm underline">
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="detail_consultType1st" names="detail_consultType1st" label="V00010" labelClass="4" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="detail_consultType2nd" names="detail_consultType2nd" label="V00011" labelClass="4" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="detail_consultType3rd" names="detail_consultType3rd" label="V00012" labelClass="4" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="detail_receptionMethod" label="V00020" labelClass="4" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
<%-- 			<ifvm:inputNew type="search" id="detail_franchiseCode" names="detail_franchiseCode" objCode="SRCH" dto="detail_franchiseCode" btnFunc="showFranchiseCodePop" label="V00021" labelClass="4" conClass="6" /> --%>
			<ifvm:inputNew type="text" id="detail_franchiseCode" label="V00021" labelClass="4" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
<%-- 			<ifvm:inputNew type="search" id="detail_franchiseName" names="detail_franchiseName" objCode="SRCH" dto="detail_franchiseName" btnFunc="showFranchiseNamePop" label="V00022" labelClass="4" conClass="6" /> --%>
			<ifvm:inputNew type="text" id="detail_franchiseName" label="V00022" labelClass="4" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="detail_affiliatedCom" label="V00023" labelClass="4" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
            <ifvm:inputNew type="singleCheckbox" id="detail_affiliatedComFail" label="V00024" values="1" labelClass="4" conClass="6" checked="false" disabled="true"/>
		</div>
	</div>
</div>
<!-- 처리현황 -->
<div class="col-xs-3 pl10">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="V00032"/></span>
		</div>
	</div>
	<div class="well form-horizontal heightForm">
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="detail_processSituation" label="V00007" labelClass="3" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="detail_receptionist" label="V00025" labelClass="3" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="detail_receptionDate" label="V00017" labelClass="3" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
<%-- 			<ifvm:inputNew type="hidden" id="detail_personInChargeRid" required="true"/> --%>
<%-- 			<ifvm:inputNew type="hidden" id="detail_personInChargeUserId" /> --%>
<%-- 			<ifvm:inputNew type="search" id="detail_personInChargeName" names="detail_personInChargeName" objCode="SRCH" dto="detail_personInChargeName" btnFunc="showPersonInChargePop" label="V00026" labelClass="3" conClass="6" required="true"/> --%>
			<ifvm:inputNew type="text" id="detail_personInChargeName" label="V00026" labelClass="3" conClass="6" disabled="true"/>
	</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="detail_transferDate" label="V00027" labelClass="3" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="detail_endDate" label="V00028" labelClass="3" conClass="6" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="detail_callId" label="V00029" labelClass="3" conClass="6" disabled="true"/>
		</div>
	</div>
</div>

<!-- 녹취파일 듣기 팝업 -->
<div id="playRecordFilePop"></div>