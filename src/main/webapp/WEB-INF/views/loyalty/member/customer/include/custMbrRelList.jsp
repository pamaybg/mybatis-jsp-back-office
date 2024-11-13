<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02841" /></span>
	</div>
</div>
<div id="custMbrRelGrid"></div>

<script type="text/javascript">

	var CustMbrRelList = function() {
		var _ridCust = $.ifvGetParams().rid;
	    this.getRidCust = function() {
	    	return _ridCust;
	    },
		this.setGridAndDataLoad = function () {
	        var _serializeGridData = function(data) {
	            data.ridMbrC = this.getRidCust();
	            return data;
	        };
			var ejGridOption = {
				serializeGridData : _serializeGridData.bind(this),
				dataUrl : '<ifvm:action name="getCustMbrRelList"/>',
				columns : [ {
					field : 'rid',
					visible : false
				}, {
					field : 'custNo',
					headerText : '<spring:message code="L01651"/>', // 회원번호
                    textAlign : 'center',
                    customAttributes : {
                        searchable : true
                    }
                }, {
					field : 'custNm',
					headerText : '<spring:message code="M00850"/>', // 회원명
                    textAlign : 'left'
				}, {
					field : 'cardNo',
					headerText : '<spring:message code="L00414"/>', // 카드번호
                    textAlign : 'center',
				}, {
					field : 'statCdNm',
					headerText : '<spring:message code="L00627"/>', // 상태
                    textAlign : 'center',
				}, {
					field : 'brNm',
					headerText : '<spring:message code="L02843"/>', // 브랜치
                    textAlign : 'left',
				}, {
					field : 'createDate',
					headerText : '<spring:message code="L01125"/>', // 등록일
                    textAlign : 'center',
				}, {
					field : 'modifyDate',
					headerText : '<spring:message code="L02703"/>', // 변경일
                    textAlign : 'center',
				} ],
				requestGridData : {
					sidx : 'modifyDate'
				},
				radio : false,
			};
			
			$("#custMbrRelGrid").ifvsfGrid({
				ejGridOption : ejGridOption
			});
		},
	    this.init = function() {
			this.setGridAndDataLoad();
	    }
	};

	$(document).ready(function() {
		var custMbrRelGrid = new CustMbrRelList();
		custMbrRelGrid.init();
	});
</script>