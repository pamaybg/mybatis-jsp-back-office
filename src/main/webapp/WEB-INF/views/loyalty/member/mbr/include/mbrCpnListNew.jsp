<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span>쿠폰발생현황</span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button"  text="다운로드" id="btnAddJoinPlcy" />
		<ifvm:inputNew type="button" text="업로드(발급)" id="btnRemoveJoinPlcy" />
	</div>
</div>
<div id="cpnStatusGrid"></div>
	
	
<script>

var cpnStatusList = function () {
    var _rid =null;
    this.dataUrl = '<ifvm:action name="getCpnStatusList"/>';
    this.setRid = function (rid) {
	    ifvGlobal["couponRid"] = rid;
        _rid = rid;
    },
    this.getRid = function () {
        return _rid;
    },
    this.setGridAndDataLoad = function (url) {
        var _recordDoubleClick = function (args) {
            var data = args.data;
            this.setRid(data.rid);
            this.openPopup();
        };
        var _serializeGridData = function (data) {
        	data.rid= ifvGlobal["couponRid"];
            //data.pgmRid = this.getPgmRid();
            return data;
        };
        var _rowSelected = function (args) {
            var data = args.data;
            this.setRid(data.rid);
        };
        var ejGridOption = {
            recordDoubleClick: _recordDoubleClick.bind(this),
            serializeGridData: _serializeGridData.bind(this),
            rowSelected: _rowSelected.bind(this),
            dataUrl: url || this.dataUrl,
            columns: [{
                field: 'rid',
                visible: false
            }, {
                field: 'cpnNo',
                headerText: '쿠폰번호',
                customAttributes: {
                    index: 'cpnNo'
                }
            }, {
                field: 'cpnOccurDt',
                headerText: '발행일시',
                customAttributes: {
                    index: 'cpnOccurDt'
                }
            }, {
                field: 'mbrNo',
                headerText: '<spring:message code="L02727"/>',
                customAttributes: {
                    index: 'mbrNo'
                }
            },{
                field: 'ridUsedChnl',
                headerText: '<spring:message code="L02728"/>',
                customAttributes: {
                    index: 'ridUsedChnl'
                }
            }],
            requestGridData: {
                sidx: 'cpnOccurDt'
            },
            radio: true,
        };

        $("#cpnStatusGrid").ifvsfGrid({
            ejGridOption: ejGridOption
        });
    },
    /* 팝업 오픈 */
    this.openPopup = function () {
        $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
            '<ifvm:url name="pgmJoinPlcyDetailPop"/>',
            '<spring:message code="L02729"/>', 860);
    },
    /* 버튼 클릭 시 액션 세팅 */
    this.setButtons = function () {
      
    },
    /* 삭제 액션 */
    this.removeAction = function () {
        var _success = function () {
            alert('<spring:message code="L00085"/>');
            this.setGridAndDataLoad();
            $.ifvProgressControl(false);
        };

        var _fail = function (result) {
            alert(result.message);
            $.ifvProgressControl(false);
        };

        var _rid = this.getRid();

        if ($.fn.ifvmIsNotEmpty(this.getRid())) {
            if (confirm('<spring:message code="L00086"/>')) {
                $.ifvProgressControl(true);
                $.ifvPostJSON('<ifvm:action name="removePgmJoinPlcy"/>', { rid: _rid }, _success.bind(this), _fail);
            }
        }
    },
    this.init = function () {
        this.setGridAndDataLoad();
        this.setButtons();
    }
};

$(document).ready(function () {
	var cpnStatusListGrid = new cpnStatusList();
	//ifvGlobal['pgmJoinPlcyGrid'] = pgmJoinPlcyGrid;
	cpnStatusListGrid.init();
});
</script>