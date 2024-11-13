<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02724" /></span>
	</div>
</div>
<div id="histGrid"></div>

<script type="text/javascript">

	var PgmHistList = function() {
		var _pgmRid = ifvGlobal["pgmRid"];
	    this.getRidPgm = function() {
	    	return _pgmRid;
	    },
		this.setGridAndDataLoad = function () {
	        var _serializeGridData = function(data) {
	            data.pgmRid = this.getRidPgm();
	            return data;
	        };
			var ejGridOption = {
				serializeGridData : _serializeGridData.bind(this),
				dataUrl : '<ifvm:action name="getPgmHistList"/>',
				columns : [ {
					field : 'rid',
					visible : false
				}, {
					field : 'histTypeNm',
					headerText : '<spring:message code="L00155"/>',
                    textAlign : 'center',
					customAttributes : {
						index : 'histType'
					}
                }, {
					field : 'chgCate',
					headerText : '<spring:message code="L02461"/>',
                    textAlign : 'center',
					customAttributes : {
						searchable : true
					}
				}, {
					field : 'chgCol',
					headerText : '<spring:message code="L01158"/>',
                    textAlign : 'center',
					customAttributes : {
						searchable : true
					}
				}, {
					field : 'chgBfVal',
					headerText : '<spring:message code="L01159"/>',
                    textAlign : 'center',
					customAttributes : {
						searchable : true
					}
				}, {
					field : 'chgAfVal',
					headerText : '<spring:message code="L01160"/>',
                    textAlign : 'center',
					customAttributes : {
						searchable : true
					}
				}, {
					field : 'modifyBy',
					headerText : '<spring:message code="L01042"/>',
                    textAlign : 'center',
				}, {
					field : 'modifyDate',
					headerText : '<spring:message code="L02703"/>',
                    textAlign : 'center',
				} ],
				requestGridData : {
					sidx : 'modifyDate'
				},
				radio : false,
			};
			
			$("#histGrid").ifvsfGrid({
				ejGridOption : ejGridOption
			});
		},
	    this.init = function() {
			this.setGridAndDataLoad();
	    }
	};

	$(document).ready(function() {
		var pgmHistGrid = new PgmHistList();
		pgmHistGrid.init();
	});
</script>