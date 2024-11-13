<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02837" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAddChnl" objCode="stampBingoChnlListAdd_OBJ"/>
        <ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveChnl" objCode="stampBingoChnlListRemove_OBJ" />
        <ifvm:inputNew type="button" text="L02838" id="btnGetChnlHist" objCode="stampBingoChnlListGetHist_OBJ" />
    </div>
</div>
<div id="stampBingoChnlGrid"></div>

<script type="text/javascript">
	var StampBingoChnlList = function () {
	    var _rid = null;
	    var _ridStbg = ifvGlobal["stampBingoRid"];
	    this.dataUrl = '<ifvm:action name="getStampBingoChnlList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["stampBingoChnlRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getRidStbg = function () {
            return _ridStbg;
        },
        this.setGridAndDataLoad = function (url) {
            var _serializeGridData = function (data) {
                data.ridStbg = this.getRidStbg();
                return data;
            };
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
            };

            var ejGridOption = {
                serializeGridData: _serializeGridData.bind(this),
                rowSelected: _rowSelected.bind(this),
                dataUrl: url || this.dataUrl,
                columns: [{
                    field: 'rid',
                    visible: false
                }, {
                    field: 'chnlNo',
                    headerText: '<spring:message code="L00128"/>',
                    textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'chnlNm',
                    headerText: '<spring:message code="L00129"/>',
                    textAlign : 'left',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'createDate',
                    headerText: '<spring:message code="L00041"/>',
                    textAlign : 'center'
                }, {
                    field: 'createBy',
                    headerText: '<spring:message code="L00042"/>',
                    textAlign : 'center'
                }],
                requestGridData: {
                    sidx: 'createDate'
                },
                radio: true,
            };
            $("#stampBingoChnlGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 팝업 오픈 */
        this.openChnlPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', null, '<ifvm:url name="stampBingoChnlListPop"/>', '<spring:message code="L02837"/>');
        },
        this.openHistPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', null, '<ifvm:url name="stampBingoChnlHistListPop"/>', '<spring:message code="L02838"/>');
        },
        this.removeAction = function () {
            var _success = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
                this.setGridAndDataLoad();
            };

            var _fail = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert(result.message)`, 0);
            };

            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm('<spring:message code="L00086"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removeStampBingoChnl"/>', { rid: this.getRid() }, _success.bind(this), _fail.bind(this));
                }
            }
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddChnl").click(function () {
                this.openChnlPopup();
            }.bind(this));

            $("#btnRemoveChnl").click(function () {
                this.removeAction();
            }.bind(this));

            $("#btnGetChnlHist").click(function () {
                this.openHistPopup();
            }.bind(this));
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
		stampBingoChnlGrid = new StampBingoChnlList();
		ifvGlobal['stampBingoChnlGrid'] = stampBingoChnlGrid;
		stampBingoChnlGrid.init();
	});
</script>