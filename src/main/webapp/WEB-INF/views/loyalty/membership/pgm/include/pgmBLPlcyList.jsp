<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02725" /></span>
	</div>
</div>
<div id="blPlcyGrid"></div>

<script type="text/javascript">

	var PgmBLPlcyList = function() {
	    var _ridPgm = ifvGlobal["pgmRid"];
	    this.getRidPgm = function() {
	    	return _ridPgm;
	    },
		this.setGridAndDataLoad = function () {
	        var _serializeGridData = function(data) {
	            data.pgmRid = this.getRidPgm();
	            return data;
	        };
			var ejGridOption = {
				serializeGridData : _serializeGridData.bind(this),
				dataUrl : '<ifvm:action name="getPgmBLPlcyList"/>',
				columns : [ {
					field : 'rid',
					visible : false
				}, {
					field : 'fraudNo',
					headerText : '<spring:message code="이상거래번호"/>',
					customAttributes : {
						searchable : true
					}
                }, {
					field : 'fraudNm',
					headerText : '<spring:message code="이상거래명"/>',
					customAttributes : {
						searchable : true
					}
				}, {
					field : 'fraudTypeCdNm',
					headerText : '<spring:message code="유형"/>',
                    textAlign : 'center',
					customAttributes : {
						index : 'fraudTypeCd'
					}
				}, {
					field : 'fraudSubTypeCdNm',
					headerText : '<spring:message code="세부유형"/>',
                    textAlign : 'center',
					customAttributes : {
						index : 'fraudSubTypeCd'
					}
				}, {
					field : 'statCdNm',
					headerText : '<spring:message code="L02559"/>',
                    textAlign : 'center',
					customAttributes : {
						index : 'statCd'
					}
				}, {
					field : 'modifyBy',
                    textAlign : 'center',
					headerText : '<spring:message code="L01042"/>',
				}, {
					field : 'modifyDate',
                    textAlign : 'center',
					headerText : '<spring:message code="L02703"/>',
				} ],
				requestGridData : {
					sidx : 'modifyDate'
				},
				radio : false,
			};
			
			$("#blPlcyGrid").ifvsfGrid({
				ejGridOption : ejGridOption
			});
		},
	    this.init = function() {
			this.setGridAndDataLoad();
	    }
	};

	$(document).ready(function() {
		var pgmBLPlcyGrid = new PgmBLPlcyList();
		pgmBLPlcyGrid.init();
	});
</script>