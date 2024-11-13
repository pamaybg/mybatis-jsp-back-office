<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L00135" /></span>
	</div>
</div>
<div id="chnlGrid"></div>

<script type="text/javascript">
	var pgmChnlListGrid;
	
	var PgmChnlList = function () {
	    var _rid = null;
	    var _ridPgm = ifvGlobal["pgmRid"];
	    this.setRid = function (rid) {
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getRidPgm = function () {
            return _ridPgm;
        },
        this.setGridAndDataLoad = function () {
            var _serializeGridData = function (data) {
                data.ridPgm = this.getRidPgm();
                return data;
            };
            var ejGridOption = {
                serializeGridData: _serializeGridData.bind(this),
                dataUrl: '<ifvm:action name="getPgmChnlList"/>',
                columns: [{
                    field: 'rid',
                    visible: false
                }, {
                    field: 'chnlNo',
                    headerText: '<spring:message code="L00128"/>',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'chnlNm',
                    headerText: '<spring:message code="L00129"/>',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'chnlTypeNm',
                    headerText: '<spring:message code="L00132"/>',
                    textAlign : 'center',
                    customAttributes: {
                        index: 'chnlTypeCd'
                    }
                }, {
                    field: 'pntAcrlYn',
                    headerText: '<spring:message code="L02747"/>',
                    textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'pntRdmYn',
                    headerText: '<spring:message code="L02748"/>',
                    textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'modifyBy',
                    headerText: '<spring:message code="L01042"/>',
                    textAlign : 'center',
                }, {
                    field: 'modifyDate',
                    headerText: '<spring:message code="L02703"/>',
                    textAlign : 'center',
                }],
                requestGridData: {
                    sidx: 'modifyDate'
                },
                radio: false,
            };

			pgmChnlListGrid = $("#chnlGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        this.init = function () {
            this.setGridAndDataLoad();
        }
	};
	
	$(document).ready(function () {
		var pgmChnlGrid = new PgmChnlList();
		pgmChnlGrid.init();
	});
</script>