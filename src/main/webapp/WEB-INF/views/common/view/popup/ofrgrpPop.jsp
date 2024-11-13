<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="ofrgrpGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnOfrgrpSelect" objCode="">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnOfrgrpCancle" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var OfrgrpListPop = function () {
	    var _ofrgrpRid = null;
	    var _ofrgrpNm = null;
	
	    this.getOfrgrpRid = function () {
	        return _ofrgrpRid;
	    },
        this.setOfrgrpRid = function (ofrgrpRid) {
            _ofrgrpRid = ofrgrpRid;
        },
        this.getOfrgrpNm = function () {
            return _ofrgrpNm;
        },
        this.setOfrgrpNm = function (ofrgrpNm) {
            _ofrgrpNm = ofrgrpNm;
        },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {

            var _serializeGridData = function (data) {
                return data;
            };
            var _rowSelected = function (args) {
                var _data = args.data;
                this.setOfrgrpRid(_data.rid);
                this.setOfrgrpNm(_data.ofrgrpNm);
            };
            var ejGridOption = {
                serializeGridData: _serializeGridData,
                rowSelected: _rowSelected.bind(this),
                dataUrl: '<ifvm:action name="getOfferGroupList"/>',
                columns: [ 
                    {
                        field: 'ofrgrpNo',
                        headerText: '<spring:message code="O00060"/>',
                        width: '80px',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'ofrgrpNm',
                        headerText: '<spring:message code="O00061"/>',
                        width: '200px',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'ofrgrpTypeNm',
                        headerText: '<spring:message code="O00051"/>',
                        width: '100px',
                        customAttributes: {
                            index: 'ofrgrpType'
                        }
                    }, {
                        field: 'totAmt',
                        headerText: '<spring:message code="O00063"/>',
                        width: '70px',
                    }, {
                        field: 'createBy',
                        headerText: '<spring:message code="O00012"/>',
                        width: '100px',
                    }, {
                        field: 'createDate',
                        headerText: '<spring:message code="O00013"/>',
                        width: '80px',
                    }, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false,
                    }],
                requestGridData: {
                    sidx: 'ofrgrpNo',
                },
                radio: true
            }
            this.ofrgrpGridOptions = $("#ofrgrpGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnOfrgrpSelect").on('click', function () {
                
        		$("#ofrgrpNm").val(this.getOfrgrpNm());
        		$("#ridOfrgrp").val(this.getOfrgrpRid());
            	$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnOfrgrpCancle").on('click', function () {
            	$.fn.ifvmPopupClose();
            }.bind(this));
        },
        /* 페이지 초기화 */
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};
	
	$(document).ready(function () {
	    var ofrgrpListPop = new OfrgrpListPop();
	    ofrgrpListPop.init();
	});
</script>
