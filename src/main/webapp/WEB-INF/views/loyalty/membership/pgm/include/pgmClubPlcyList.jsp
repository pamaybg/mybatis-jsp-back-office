<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02721" /></span>
	</div>
</div>
<div id="clubPlcyGrid"></div>

<script type="text/javascript">

	var PgmClubPlcyList = function() {
	    var _ridPgm = ifvGlobal["pgmRid"] ;
	    this.getRidPgm = function() {
	    	return _ridPgm;
	    },
		this.setGridAndDataLoad = function () {
	        var _serializeGridData = function(data) {
	            data.ridPgm = this.getRidPgm();
	            return data;
	        };
			var ejGridOption = {
				serializeGridData : _serializeGridData.bind(this),
				dataUrl : '<ifvm:action name="getPgmClubPlcyList"/>',
				columns : [ {
					field : 'rid',
					visible : false
				}, {
					field : 'clubNo',
					textAlign : 'center',
					headerText : '<spring:message code="L02692"/>',
					customAttributes : {
						searchable : true
					}
                }, {
					field : 'clubNm',
					headerText : '<spring:message code="L02693"/>',
					customAttributes : {
						searchable : true
					}
				}, {
					field : 'ctgCdNm',
					headerText : '<spring:message code="L00155"/>',
                    textAlign : 'center',
					customAttributes : {
						index : 'ctgCd'
					}
				}, {
					field : 'clubStatCdNm',
					headerText : '<spring:message code="L00337"/>',
                    textAlign : 'center',
					customAttributes : {
						index : 'clubStatCd'
					}
				}, {
					field : 'atchYn',
					headerText : '<spring:message code="L02694"/>',
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
			
			$("#clubPlcyGrid").ifvsfGrid({
				ejGridOption : ejGridOption
			});
		},
	    this.init = function() {
			this.setGridAndDataLoad();
	    }
	};

	$(document).ready(function() {
		var pgmClubPlcyGrid = new PgmClubPlcyList();
		pgmClubPlcyGrid.init();
	});
</script>