<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
	var OfferCpnPoolCond = function () {

		var _formId = 'cpnPoolCond';
		this.fields = $.ifvGetFields(_formId);

		/* 페이지 초기화 */
		this.init = function () {
			this.formDataLoad();
		}
		
		/* Form 데이터 로드 */
	    this.formDataLoad = function () {
	        var _callback = function (result) {
	            if ($.fn.ifvmIsNotEmpty(result)) {
	                // 필드의 데이터 로드
	                $.ifvLoadFormData(result, this.fields);
	            }
	        }
	        $.ifvSyncPostJSON('<ifvm:action name="getOfferCpnPoolListCond"/>', null, _callback.bind(this));
	    }
	}
	
	$(document).ready(function() {

		$("#btnPopupClose").on('click', function(){
			fnOfferCpnPoolCondPopClose()
		}); 
		
		var offerCpnPoolCond = new OfferCpnPoolCond();
		offerCpnPoolCond.init();
		
	});

</script>

<div style="margin-top: 25px;">
	<div id="cpnPoolCond">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="O00100" /></span>
			</div>
		</div>
		<div>
			<div class="form-horizontal underline top_well">
				<div class="row">
					<!-- 전체건수 -->
					<div class="col-xs-6">
						<ifvm:inputNew type="text" id="mTypeTotCnt" label="O00102" labelClass="4" conClass="7" disabled="true" />
					</div>
					<!-- 발급건수 -->
					<div class="col-xs-6">
						<ifvm:inputNew type="text" id="mTypeIssueCnt" label="O00103" labelClass="4" conClass="7" disabled="true"/>
					</div>
				</div>
				<div class="row ">
					<!-- 잔여건수 -->
					<div class="col-xs-6">
						<ifvm:inputNew type="text" id="mTypeRemainCnt" label="O00104" labelClass="4" conClass="7" disabled="true" />
					</div>
				</div>
			</div>
		</div>
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="O00101" /></span>
			</div>
		</div>
		<div>
			<div class="form-horizontal underline top_well">
				<div class="row">
					<!-- 전체건수 -->
					<div class="col-xs-6">
						<ifvm:inputNew type="text" id="sTypeTotCnt" label="O00102" labelClass="4" conClass="7" disabled="true" />
					</div>
					<!-- 발급건수 -->
					<div class="col-xs-6">
						<ifvm:inputNew type="text" id="sTypeIssueCnt" label="O00103" labelClass="4" conClass="7" disabled="true"/>
					</div>
				</div>
				<div class="row ">
					<!-- 잔여건수 -->
					<div class="col-xs-6">
						<ifvm:inputNew type="text" id="sTypeRemainCnt" label="O00104" labelClass="4" conClass="7" disabled="true" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area" style="margin-top: 20px;">
	<button class="btn btn-sm btn_lightGray2" id="btnPopupClose" objCode="">
		<spring:message code="O00115" />
	</button>
</div>

