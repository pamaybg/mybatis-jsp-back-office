<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02651" /></span>
	</div>
    <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" text="L02536" id="btnDownload" objCode="stampBingoMbrListPreview_OBJ" />
    </div>
</div>
<div id="stampBingoMbrGrid"></div>

<script type="text/javascript">
	var StampBingoMbrList = function () {
	    var _rid = null;
	    var _ridStbg = ifvGlobal["stampBingoRid"];
	    this.dataUrl = '<ifvm:action name="getStampBingoMbrList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["stampBingoMbrRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getRidStbg = function () {
            return _ridStbg;
        },
        this.setGridAndDataLoad = function (url) {

            var _recordDoubleClick = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.openPopup();
            };

            var _serializeGridData = function (data) {
                data.ridStbg = this.getRidStbg();
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
                    field: 'custNo',
                    width: '120px',
                    headerText: '<spring:message code="L00690"/>',
                    textAlign : 'center'
                }, {
                    field: 'custNm',
                    width: '100px',
                    headerText: '<spring:message code="L00798"/>',
                    textAlign : 'center'
                }, {
                    field: 'currStep',
                    width: '60px',
                    headerText: '<spring:message code="L02826"/>',
                    textAlign : 'center',
                }, {
                    field: 'currStepTitle',
                    headerText: '<spring:message code="L02827"/>',
                    textAlign : 'left',
                }, {
                    field: 'recentDate',
                    headerText: '<spring:message code="L02828"/>',
                    textAlign : 'center'
                }, {
                    field: 'joinDate',
                    headerText: '<spring:message code="L00377"/>',
                    textAlign : 'center'
                }, {
                    field: 'invitMrbYn',
                    width: '50px',
                    headerText: '<spring:message code="L02829"/>',
                    textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'ofrNm',
                    headerText: '<spring:message code="L02830"/>',
                    textAlign : 'left'
                }, {
                    field: 'compDate',
                    headerText: '<spring:message code="L02831"/>',
                    textAlign : 'center'
                }, {
                    field: 'chnlNm',
                    headerText: '<spring:message code="L02832"/>',
                    textAlign : 'left'
                }],
                requestGridData: {
                    sidx: 'recentDate'
                },
                radio: true,
            };
            $("#stampBingoMbrGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 팝업 오픈 */
        this.openPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                '<ifvm:url name="stampBingoMbrHistListPop"/>',
                '<spring:message code="L02833"/>', 1028);
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $('#btnDownload').on('click', function () {
                $.ifvExcelDn('<ifvm:action name="exportExcelStampBingoMbrList"/>','stampBingoMbrGrid');
            }.bind(this));
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
		stampBingoMbrGrid = new StampBingoMbrList();
		stampBingoMbrGrid.init();
	});
</script>