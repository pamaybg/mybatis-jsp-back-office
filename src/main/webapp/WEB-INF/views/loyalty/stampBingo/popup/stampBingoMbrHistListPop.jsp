<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="stampBingoMbrHistGrid"></div>

<script type="text/javascript">
	var StampBingoMbrHistList = function () {
	    var _rid = null;
	    var _ridStbgMbr = ifvGlobal["stampBingoMbrRid"];
	    this.dataUrl = '<ifvm:action name="getStampBingoMbrHistList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["stampBingoMbrHistRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getRidStbgMbr = function () {
            return _ridStbgMbr;
        },
        this.setGridAndDataLoad = function (url) {

            var _serializeGridData = function (data) {
                data.ridStbgMbr = this.getRidStbgMbr();
                return data;
            };

            var ejGridOption = {
                serializeGridData: _serializeGridData.bind(this),
                dataUrl: url || this.dataUrl,
                columns: [{
                    field: 'rid',
                    visible: false
                }, {
                    field: 'stepNo',
                    width: '50px',
                    headerText: '<spring:message code="L02811"/>',
                    textAlign : 'center'
                }, {
                    field: 'stepTitle',
                    headerText: '<spring:message code="L02834"/>',
                    textAlign : 'center',
                    customAttributes: {
                        searchable: true,
                        index : 'title'
                    }
                }, {
                    field: 'promNm',
                    headerText: '<spring:message code="L02835"/>',
                    textAlign : 'left',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'createDate',
                    headerText: '<spring:message code="L02292"/>',
                    textAlign : 'left',
                }, {
                    field: 'ofrNm',
                    headerText: '<spring:message code="L02818"/>',
                    textAlign : 'left'
                }, {
                    field: 'ofrCnt',
                    width: '70px',
                    headerText: '<spring:message code="L02819"/>',
                    textAlign : 'center'
                }, {
                    field: 'compDate',
                    headerText: '<spring:message code="L02836"/>',
                    textAlign : 'center'
                }, {
                    field: 'canlRsn',
                    headerText: '<spring:message code="L00572"/>',
                    textAlign : 'left'
                }],
                requestGridData: {
                    sidx: 'createDate'
                },
                radio: true,
            };
            $("#stampBingoMbrHistGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        this.init = function () {
            this.setGridAndDataLoad();
        }
	};

	$(document).ready(function () {
		stampBingoMbrHistGrid = new StampBingoMbrHistList();
		stampBingoMbrHistGrid.init();
	});
</script>