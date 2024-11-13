<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02651" /></span>
	</div>
    <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" text="L02536" id="btnDownload" objCode="gameJoinListDown_OBJ"/>
    </div>
</div>
<div id="gameJoinGrid"></div>

<script type="text/javascript">
	var GameJoinList = function () {
	    var _rid = null;
	    var _ridGame = ifvGlobal["gameRid"];
	    this.dataUrl = '<ifvm:action name="getGameJoinList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["gameJoinRid"] = rid;
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
                    field: 'joinDate',
                    headerText: '<spring:message code="L02902"/>',
                    textAlign : 'center'
                }, {
                    field: 'winYn',
                    headerText: '<spring:message code="M02425"/>',
                    textAlign : 'center',
                }, {
                    field: 'ofrNm',
                    headerText: '<spring:message code="L02896"/>',
                    textAlign : 'left',
                }, {
                    field: 'ofrWinQty',
                    headerText: '<spring:message code="L02819"/>',
                    textAlign : 'right',
                }, {
                    field: 'ofrWinEarnDate',
                    headerText: '<spring:message code="L02903"/>',
                    textAlign : 'center'
                }],
                requestGridData: {
                    sidx: '1'
                },
                radio: true,
            };
            $("#gameJoinGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $('#btnDownload').on('click', function () {
                $.ifvExcelDn('<ifvm:action name="exportExcelGameJoinList"/>','gameJoinGrid');
            }.bind(this));
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
		gameJoinGrid = new GameJoinList();
		gameJoinGrid.init();
	});
</script>