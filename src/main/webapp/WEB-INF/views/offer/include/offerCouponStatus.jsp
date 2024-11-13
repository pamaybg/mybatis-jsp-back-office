<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="O00113"/></span>
    </div>
    <div class="col-sm-5 searchbtn_r">
        <%-- 	    	<ifvm:inputNew type="button" id="uploadSampleDownBtn" btnType="download"  btnFunc="uploadSampleDownFn" nuc="true" text="업로드샘플다운로드" objCode="offerCouponStatusUploadSD_OBJ"/> --%>
        <ifvm:inputNew type="button" id="excelDownBtn" btnFunc="excelDownFn" btnType="download" text="다운로드"
                       objCode="offerCouponStatusDown_OBJ"/>
        <!-- 추후개발 -->
        <%-- <ifvm:inputNew type="button" id="fileUploadBtn" btnFunc="fileUploadFn" btnType="upload" text="업로드(발급)" objCode=""/> --%>
    </div>
</div>
<div id="cpnStatusGrid"></div>

<div id="excelFileUploadPop" class="popup_container"></div>

<script>

    var cpnStatusList = function () {

        var _rid = null;
        this.dataUrl = '<ifvm:action name="getCpnStatusList"/>';
        this.setRid = function (rid) {
            // ifvGlobal["couponRid"] = rid;
            _rid = rid;
        },
            this.getRid = function () {
                return _rid;
            },
            this.optionFields = [
                {fieldName: "issType", commCode: "LOY_CPN_ISS_TYPE"}
            ],
            this.setGridAndDataLoad = function (url) {
                var _recordDoubleClick = function (args) {
                    var data = args.data;
                };
                var _serializeGridData = function (data) {

                    data.rid = ifvGlobal["offerRid"];
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
                        headerText: '<spring:message code="O00093"/>',
                        textAlign: 'center',
                        customAttributes: {
                            index: "A.CPN_NO",
                            searchable: true
                        },
                    }, {
                        field: 'issTypeNm',
                        headerText: '발급구분',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'issType'
                        }
                    },
                        {
                            field: 'cpnCreateDate',
                            headerText: '<spring:message code="O00147"/>',
                            textAlign: 'center',
                            customAttributes: {
                                index: 'cpnCreateDate'
                            }
                        }

                    ],
                    requestGridData: {
                        sidx: 'cpnCreateDate'
                        , _search: true
                    },
                    radio: true,
                };

                $("#cpnStatusGrid").ifvsfGrid({
                    ejGridOption: ejGridOption
                });
            },

            this.init = function () {
                $.ifvSetSelectOptions(this.optionFields);
                this.setGridAndDataLoad();
            }
    };

    //업로드 샘플 다운
    function uploadSampleDownFn() {
        var data = {};
        data.offerType = "OFR_CUPON_STATUS";
        $.fn.ifvmBatchRgstExcelSampleDown2(data);
    }

    $.fn.ifvmBatchRgstExcelSampleDown2 = function (data) {
        var inputs = "";
        var url = "/system/batchRgst/excelSampleDown2.do";
        var method = "post"
        if (data) {
            if ($.fn.ifvmIsNotEmpty(data.offerType)) {
                inputs += '<input type="hidden" name="offerType" value="' + data.offerType + '" />';

                jQuery('<form action="' + url + '" method="' + (method || 'post') + '">' + inputs + '</form>')
                    .appendTo('body').submit().remove();
            }
        }
        ;
    };

    //엑셀 다운로드
    function excelDownFn() {
        if (joinChnlGrid.opt.gridControl.model.dataSource.length != 0) {
            $.ifvExcelDn('<ifvm:action name="ofrCuponStatusExcelDownload"/>', 'cpnStatusGrid');
        } else {
            alert("다운로드할 데이터가 없습니다.");
        }
    }

    //파일업로드 (추후개발)
    function fileUploadFn() {
        fileUploadPop = {
            id: "excelFileUploadPop"
        };
        fileUploadPop.popup = function () {
            fileUploadPop.pop = $('#' + fileUploadPop.id).ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="offerCuponStatUploadPop"/>',
                contentType: "ajax",
                title: '오퍼쿠폰현황 업데이트',
                width: "700px"
            });
        };
        fileUploadPop.beforeClose = function (obj) {
        };
        fileUploadPop.close = function (obj) {
            this.beforeClose(obj);
            this.pop.data('ejDialog')._destroy();
        };
        fileUploadPop.popup();
    }

    $(document).ready(function () {

        var cpnStatusListGrid = new cpnStatusList();
        cpnStatusListGrid.init();
    });
</script>