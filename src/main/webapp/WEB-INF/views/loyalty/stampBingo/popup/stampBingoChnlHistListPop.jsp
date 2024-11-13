<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="stampBingoChnlHistGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnDownload" objCode="stampBingoChnlHistDown_OBJ">
		<spring:message code="L02536" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="stampBingoChnlHistCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var StampBingoChnlHistList = function () {
	    var _ridStbg = ifvGlobal["stampBingoRid"];
	    var _ridChnl = ifvGlobal["stampBingoChnlRid"];
	    this.dataUrl = '<ifvm:action name="getStampBingoChnlHistList"/>';
        this.getRidStbg = function () {
            return _ridStbg;
        },
        this.getRidChnl = function () {
            return _ridChnl;
        },
        this.setGridAndDataLoad = function (url) {

            var _serializeGridData = function (data) {
                data.ridStbg = this.getRidStbg();
                data.ridChnl = this.getRidChnl();
                return data;
            };

            var ejGridOption = {
                serializeGridData: _serializeGridData.bind(this),
                dataUrl: url || this.dataUrl,
                columns: [{
                    field: 'rid',
                    visible: false
                }, {
                    field: 'custNo',
                    width: '60px',
                    headerText: '<spring:message code="L00690"/>',
                    textAlign : 'center'
                }, {
                    field: 'custNm',
                    width: '60px',
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
                radio: false,
            };
            $("#stampBingoChnlHistGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        this.setButtons = function () {
            $("#btnCancel").click(function () {
                $.fn.ifvmPopupClose();
            }.bind(this));
            // 다운로드
            $('#btnDownload').on('click', function () {
                $.ifvExcelDn('<ifvm:action name="exportExcelStampBingoChnlHistList"/>','stampBingoChnlHistGrid');
            }.bind(this));
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
		stampBingoChnlHistGrid = new StampBingoChnlHistList();
		stampBingoChnlHistGrid.init();
	});
</script>