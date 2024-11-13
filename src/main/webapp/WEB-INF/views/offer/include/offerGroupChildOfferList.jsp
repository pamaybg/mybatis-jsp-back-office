<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="O00068" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAddChildOffer" objCode="offerGroupChildNew_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveChildOffer" objCode="offerGroupChildRemove_OBJ"/>
	</div>
</div>
<div id="childOfferGrid"></div>

<script type="text/javascript">

	var ChildOfferList = function () {
	    var _rid = null;
	    var _offerGroupRid = ifvGlobal["offerGroupRid"];
	    this.dataUrl = '<ifvm:action name="getChildOfferList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["childOfferRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getOfferGroupRid = function () {
            return _offerGroupRid;
        },
        this.setGridAndDataLoad = function (url) {
            var _recordDoubleClick = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.openPopup();
            };
            var _serializeGridData = function (data) {
                data.ridOfrgrp = this.getOfferGroupRid();
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
                    field: 'ofrNo',
                    headerText: '<spring:message code="O00006"/>'
                }, {
                    field: 'ofrNm',
                    headerText: '<spring:message code="O00007"/>',
                    customAttributes: {
                    	searchable: true
                    }
                }, {
                    field: 'ofrValAmt',
                    textAlign : 'right',
                    format: "{0:n0}",
                    headerText: '<spring:message code="O00042"/>',
                }, {
                    field: 'reqYn',
                    headerText: '<spring:message code="O00072"/>',
                    textAlign : 'center',
                },{
                    field: 'minAmt',
                    headerText: '<spring:message code="O00073"/>',
                    format: "{0:n0}",
                    textAlign : 'right',
                },{
                    field: 'maxAmt',
                    headerText: '<spring:message code="O00074"/>',
                    format: "{0:n0}",
                    textAlign : 'right',
                }, {
                    field: 'clickAmt',
                    headerText: '<spring:message code="O00075"/>',
                    format: "{0:n0}",
                    textAlign : 'right',
                }],
                requestGridData: {
                    sidx: 'ofrNo'
                },
                radio: true,
            };

            $("#childOfferGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 팝업 오픈 */
        this.openPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                '<ifvm:url name="offerGroupChildOfferDetail"/>',
                '<spring:message code="O00068"/>', 1028);
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddChildOffer").click(function () {
                this.setRid(null);
                this.openPopup();
            }.bind(this));

            $("#btnRemoveChildOffer").click(function () {
                this.removeAction();
            }.bind(this));
        },
        /* 삭제 액션 */
        this.removeAction = function () {
            var _success = function () {
                $.ifvProgressControl(false);
                setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
                this.setGridAndDataLoad();
            };

            var _fail = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert(result.message)`, 0);
            };

            var _rid = this.getRid();

            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm('<spring:message code="L00086"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removeChildOffer"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};
	
	$(document).ready(function () {
		var ChildOfferGrid = new ChildOfferList();
		ifvGlobal['childOfferGrid'] = ChildOfferGrid;
		ChildOfferGrid.init();
	});
</script>