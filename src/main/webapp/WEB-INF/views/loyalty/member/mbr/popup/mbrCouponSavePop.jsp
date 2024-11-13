<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal underline top_well underline"
	id="newCustDetailForm">
	<br>
	<div class="form-horizontal underline top_well underline"
		id="baseValidForm">
		<div class="page_btn_area">
			<spring:message code="쿠폰 정보" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="cpnMbrNo" label="회원번호" labelClass="2"
				conClass="3" required="true" disabled="true" nuc="true" />
			<%-- <ifvm:inputNew type="text" id="chnlPrNm" label="채널명" labelClass="2" conClass="3" required="true" disabled="true" nuc="true"/> --%>
			<ifvm:inputNew type="search" id="chnlPrNm" names="chnlPrNm"
				dto="chnlPrNm" btnFunc="getChnlList" label="채널명" labelClass="2"
				disabled="true" conClass="3" required="true" />
			<ifvm:inputNew type="hidden" id="chnlNo" labelClass="1" conClass="1"
				required="true" disabled="true" />
			<%--	<span class="input-group-addon" style="padding : 4px;"  id="chnlList">
				<a><i class="fa fa-search"></i></a>
			</span> --%>
		</div>
		<div class="row qt_border">
			<%-- <ifvm:inputNew type="text" id="rcptNo" label="영수증 번호" labelClass="2"
				conClass="3" required="true" nuc="true" /> --%>
			<ifvm:inputNew type="search" id="ofrNo" names="ofrNo" dto="ofrNo"
				btnFunc="getOfrList" label="오퍼번호" labelClass="2" disabled="true"
				conClass="3" required="true" />
			<ifvm:inputNew type="hidden" id="ridOfr" names="ridOfr" dto="ridOfr"
				conClass="2" />
				<ifvm:inputNew type="text" id="ofrNm" 
				conClass="5"  disabled="true"/>
			<div class="row qt_border">
				<ifvm:inputNew type="number" id="cpnAmt" label="쿠폰 발급 개수"
				labelClass="2" conClass="3" required="true" nuc="true" />
			</div>
			<!-- <span class="input-group-addon" style="padding : 4px;"  id="ofrList">
				<a><i class="fa fa-search"></i></a>
			</span> -->
		</div>
		<%-- <div class="row qt_border">
			<ifvm:inputNew type="number" id="cpnAmt" label="쿠폰 발급 개수"
				labelClass="2" conClass="3" required="true" nuc="true" />
			<ifvm:inputNew type="number" id="validStartDay" label="쿠폰 유효시작일"
				labelClass="2" conClass="3" nuc="true" />
		</div> --%>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="saveCpnBtn" objCode="mbrCouponIssueSave_OBJ">
		쿠폰 발급</button>
	<button class="btn btn-sm btn_gray" id="closePopBtn" objCode="mbrCouponIssueClose_OBJ">
		<spring:message code="L00941" />
	</button>
</div>
<div id="offerPopup" class="popup_container"></div>
<div id="chnlPopupContainer" class="popup_container"></div>
<style>
#chnlPrNm + span{
    cursor : no-drop !important;
 }
</style>
<script id="asterisk" type="text/x-jquery-tmpl">
<span class="asterisk">*</span>\${fieldDesc}
</script>
<script id="nonasterisk" type="text/x-jquery-tmpl">
\${fieldDesc}
</script>


<script type="text/javascript">
	var mbrCouponSave;
	var baseValidation;

	var mbrCouponSavePop = function() {
		var inputField = $("#newCustDetailForm input");
		var selectField = $("#newCustDetailForm select");
		this.textField = [], this.selectField = [], this.custItemVal = [],
				this.init = function() {
					this.action();
					this.getField();
					this.setSelectField();
					this.setDateField();
					$("#chnlPrNm").val("CS(고객서비스)");
					$("#chnlNo").val("CH0000519");
				}, this.save = function() {
					this.getField()
					if (baseValidation.confirm()) {
						var url = '<ifvm:action name="saveMbrCoupon"/>';
						$.ifvSyncPostJSON(url, this.getFieldVal(), function(
								result) {

							this.afterSave(result)
						}.bind(this), function(result) {
							this.afterSave(result)
						}.bind(this));
					}
				}, this.close = function() {
					mbrCouponSavePopCon._destroy();
				}, this.pgmclose = function() {
					ofrPopupContainer._destroy();
				}, this.chnlclose = function() {
					chnlPopupContainer._destroy();
				}, this.getField = function() {
					for (var i = 0; i < inputField.length; i++) {
						this.textField[i] = inputField[i].id;
					}
					for (var i = 0; i < selectField.length; i++) {
						this.selectField[i] = selectField[i].id;
					}

				}, this.setSelectField = function(values) {

				}, this.setDateField = function() {
					$("#cpnMbrNo").val(mbrNo);
					$("#cpnAmt").val(1);
				}
		this.getFieldVal = function() {
			var data = {}
			this.textField.forEach(function(a) {
				data[a] = $("#" + a).val()
			});
			this.selectField.forEach(function(b) {
				data[b] = $("#" + b).val()
			});
			var today = new Date();
			
			
			data.mbrNo = mbrNo;
			data.issueDt = getToday();
			data.saveNewCoupon = "Y";
			
			return data;
		}, this.afterSave = function(result) {
			if (result.success) {
				alert('쿠폰 발급 되었습니다.');
				mbrDetail();
				getCouponHistList();
				this.close();
			} else {
				if (result.message)
					alert(result.message);
				else
					alert('쿠폰 발급에 실패 하였습니다.');
			}
		}, this.action = function() {
			$("#saveCpnBtn").click(function() {
				this.save();
			}.bind(this));
			baseValidation = $("#baseValidForm").ifvValidation();

			$("#closePopBtn").click(function() {
				this.close();
			}.bind(this));

			$("#chnlList").click(
					function() {
						$.fn.ifvmPopupOpen('chnlPopupContainer', null,
								'<ifvm:url name="chnlListPop"/>',
								'<spring:message code="L00172"/>', 700, true,
								false);
					});

			/* $("#ofrList").click(function(){
				$.fn.ifvmPopupOpen('ofrPopupContainer', null,
						'<ifvm:url name="offerPop"/>',
						'<spring:message code="L00515"/>', 700, true, false);
			}); */

		}
	}

	function getOfrList() {
		var targetFields = {
			name : "ofrNm",
			rid : "ridOfr",
			no : "ofrNo"
		};
		$.fn.ifvmSearchHelpOpen(targetFields, 	null, 'offerPopup',
				'<ifvm:url name="offerPopMbrCoupon"/>',
				'<spring:message code="쿠폰 조회"/>','1200'); //O00014
	}

	function getChnlList() {
/*		$.fn.ifvmSearchHelpOpen(null, null, 'chnlPopupContainer',
						'<ifvm:url name="chnlPop"/>',
						'<spring:message code="L00172"/>');*/
	}

	function offerPopupClose() {
		offerPopup._destroy();
	}

	function chnlPopupClose() {
		chnlPopupContainer._destroy();
	}

	function getToday(){
	 
		var date = new Date();
	    var year = date.getFullYear();
	    var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);
        var hour=date.getHours();
        var min=date.getMinutes();
        var sec=date.getSeconds();
        
        return year + "-" + month + "-" + day+" "+hour+":"+min+":"+sec;
        }
	
	$(document).ready(function() {
		mbrCouponSave = new mbrCouponSavePop();
		mbrCouponSave.init();
		
	

	})
</script>