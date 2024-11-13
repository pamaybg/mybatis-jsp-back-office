<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02895" /></span>
	</div>
    <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" text="L02536" id="btnDownload" objCode="gameTicketListDown_OBJ"/>
    </div>
</div>
<div id="gameTicketGrid"></div>

<script type="text/javascript">
	var GameTicketList = function () {
	    var _rid = null;
	    var _ridGame = ifvGlobal["gameRid"];
	    this.dataUrl = '<ifvm:action name="getGameTicketList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["gameTicketRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getRidGame = function () {
            return _ridGame;
        },
        this.setGridAndDataLoad = function (url) {

            var _serializeGridData = function (data) {
                data.ridGame = this.getRidGame();
                return data;
            };

            var ejGridOption = {
                serializeGridData: _serializeGridData.bind(this),
                dataUrl: url || this.dataUrl,
                columns: [{
                    field: 'rid',
                    visible: false
                }, {
                    field: 'mbrNo',
                    headerText: '<spring:message code="L00433"/>',
                    textAlign : 'center'
                }, {
                    field: 'earnDt',
                    headerText: '<spring:message code="L02897"/>',
                    textAlign : 'center'
                }, {
                    field: 'ofrQty',
                    headerText: '<spring:message code="L02900"/>',
                    textAlign : 'center',
                }, {
                    field: 'useDt',
                    headerText: '<spring:message code="L02901"/>',
                    textAlign : 'left',
                }, {
                    field: 'cancelEarnDt',
                    headerText: '<spring:message code="L02898"/>',
                    textAlign : 'center'
                }, {
                    field: 'cancelEarnRsn',
                    headerText: '<spring:message code="L02899"/>',
                    textAlign : 'center'
                }],
                requestGridData: {
                    sidx: '1'
                },
                radio: true,
            };
            $("#gameTicketGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $('#btnDownload').on('click', function () {
                $.ifvExcelDn('<ifvm:action name="exportExcelGameTicketList"/>','gameTicketGrid');
            }.bind(this));
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
		gameTicketGrid = new GameTicketList();
		gameTicketGrid.init();
	});
</script>