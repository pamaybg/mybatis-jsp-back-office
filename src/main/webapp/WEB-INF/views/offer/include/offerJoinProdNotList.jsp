<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    .tab-contents .page_btn_area .btn.disabled, .tab-contents .page_btn_area .btn[disabled] {
        display: inline;
    }
</style>
<div class="page_btn_area">
    <div class="col-xs-6">
        <span><spring:message code="사용 불가능 상품"/></span>
    </div>

    <div class="col-sm-6 searchbtn_r">
        <ifvm:inputNew type="button" text="전체불가상품" id="btnAllNotUsedProd" objCode="btnAllNotUsedProd_OBJ"/>
        <ifvm:inputNew type="button" btnType="plus" text="O00046" id="btnAddOfferJoinProd"
                       objCode="offerJoinProdListNew_OBJ"/>
        <ifvm:inputNew type="button" btnType="minus" text="O00047" id="btnRemoveOfferJoinProd"
                       objCode="offerJoinProdListRemove_OBJ"/>
        <ifvm:inputNew type="button" btnType="minus" text="O00082" id="btnRemoveOfferJoinAllProd"
                       objCode="offerJoinProdListRemoveAll_OBJ"/>
        <%--         <ifvm:inputNew type="button" text="O00083" id="btnUpload" btnFunc="fileSearchFn" objCode="offerJoinProdListUpload_OBJ"/> --%>
        <ifvm:inputNew type="button" text="O00084" id="excelDownloadBtn" btnFunc="targetListDownload"
                       objCode="offerJoinProdListDownload_OBJ"/>
        <%-- <ifvm:inputNew type="button" text="O00085" id="btnSampleDown" btnFunc="btnSampleDown" /> --%>
        <ifvm:inputNew type="button" text="O00083" id="btnUpload" objCode="offerJoinProdListUpload_OBJ"/>
        <ifvm:inputNew type="button" text="O00166" id="btnUploadSample" btnFunc="btnSampleDown"
                       objCode="offerJoinProdListUploadSample_OBJ"/>
    </div>
</div>
<div id="joinProdGrid"></div>
<div id="chnlExcelUploadPop" class="popup_container"></div>
<script type="text/javascript">

    var joinProdGrid = null;
    var OfferJoinProdList = function () {
        var _rid = null;
        this.setRid = function (rid) {
            ifvGlobal["joinProdRid"] = rid;
            _rid = rid;
        },
            this.getRid = function () {
                return _rid;
            },
            this.getProdRid = function () {
                return _prodRid;
            },
            this.joinProdGridOptions = null,
            this.setGridAndDataLoad = function (url) {
                var _serializeGridData = function (data) {
                    data.ridOfr = ifvGlobal["offerRid"];
                    return data;
                };
                var _rowSelected = function (args) {
                    var _data = args.data;
                    this.setRid(_data.rid);
                };
                /* var _recordDoubleClick = function (args) {
                    var _data = args.data;
                    this.setRid(_data.rid);
                    this.openPopup();
                }; */
                var ejGridOption = {
                    serializeGridData: _serializeGridData,
                    rowSelected: _rowSelected.bind(this),
                    //recordDoubleClick: _recordDoubleClick.bind(this),
                    dataUrl: '<ifvm:action name="getOfferJoinProdNotList"/>',
                    columns: [  // '상품번호', '상품명', '등록자', '등록일자'
                        {
                            field: 'prodId',
                            headerText: '<spring:message code="E00091"/>',
                            textAlign: 'center',
                            width: 100
                            ,
                            headerTextAlign: ej.TextAlign.Center,
                            customAttributes: {index: 'prodId'}//자재코드
                        }
                        , {
                            field: 'mmzzItemCd',
                            headerText: '<spring:message code="E00101"/>',
                            textAlign: 'center',
                            width: 120
                            ,
                            headerTextAlign: ej.TextAlign.Center,
                            customAttributes: {index: 'mmzzItemCd'}//아이템코드
                        }
                        , {
                            field: 'prodNm',
                            headerText: '<spring:message code="E00105"/>',
                            textAlign: ej.TextAlign.Left,
                            width: 400
                            ,
                            headerTextAlign: ej.TextAlign.Center,
                            customAttributes: {index: 'prodNm'}//자재이름
                        }
                        , {
                            field: 'lCtg',
                            headerText: '<spring:message code="E00110"/>',
                            textAlign: 'center',
                            width: 140
                            ,
                            headerTextAlign: ej.TextAlign.Center,
                            customAttributes: {index: 'lCtg'}//카테고리(대)
                        }
                        , {
                            field: 'mCtg',
                            headerText: '<spring:message code="E00111"/>',
                            textAlign: 'center',
                            width: 140
                            ,
                            headerTextAlign: ej.TextAlign.Center,
                            customAttributes: {index: 'mCtg'}//카테고리(중)
                        }
                        , {
                            field: 'sCtg',
                            headerText: '<spring:message code="E00112"/>',
                            textAlign: 'center',
                            width: 140
                            ,
                            headerTextAlign: ej.TextAlign.Center,
                            customAttributes: {index: 'sCtg'}//카테고리(소)
                        }
                        , {
                            field: 'rid', headerText: 'rid', visible: false
                        }
                    ],
                    requestGridData: {
                        sidx: '1'
                    },
                    radio: true,
                    tempId: 'ifvGridSimplePageTemplete',
                    isHorizontalScroll: true
                };
                joinProdGrid = $("#joinProdGrid").ifvsfGrid({ejGridOption: ejGridOption});
            },
            /* 팝업 오픈 */
            this.openPopup = function () {
                $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                    '<ifvm:url name="offerLoyProdNotListPopup"/>',
                    '<spring:message code="O00090"/>', 860);
            },
            /* 버튼 클릭 시 액션 세팅 */
            this.setButtons = function () {

                //전체 사용 불가능 상품 조회
                $("#btnAllNotUsedProd").click(function () {
                    $.fn.ifvmPopupOpen('popupContainer', '',
                        '<ifvm:url name="allNotUsedProdPopup"/>',
                        '<spring:message code="O00213"/>', 860);
                }).bind(this);

                //신규
                $("#btnAddOfferJoinProd").click(function () {
                    this.setRid(null);
                    this.openPopup();
                }.bind(this));

                //삭제
                $("#btnRemoveOfferJoinProd").click(function (obj) {
                    if (joinProdGrid.opt.gridControl.getSelectedRecords().length == 0) {
                        alert('<spring:message code="O00066"/>');
                    } else {

                        if (joinProdGrid.opt.gridControl.getSelectedRecords()[0].dataFlag == '전체') {
                            alert('구분자가 전체인 상품은 삭제 할 수 없습니다.');
                        } else {
                            this.removeAction(obj);
                        }
                    }
                }.bind(this));

                //전체삭제
                $("#btnRemoveOfferJoinAllProd").click(function (obj) {
                    if (joinProdGrid.opt.gridControl.model.currentViewData.length == 0) {
                        alert('<spring:message code="O00087"/>');
                    } else {
                        joinProdGrid.opt.gridControl.selectRows(0);

                        this.removeAction(obj);
                    }
                }.bind(this));

            },
            /* 삭제 액션 */
            this.removeAction = function (obj) {

                var _success = function () {
                    $.ifvProgressControl(false);
                    alert('<spring:message code="O00055"/>');
                    this.setGridAndDataLoad();
                };

                var _fail = function (result) {
                    alert(result.message);
                    $.ifvProgressControl(false);
                };

                var _rid = this.getRid();
                var _ridOfr = ifvGlobal["offerRid"];

                //선택된 삭제 버튼에 따른 actionTag 설정
                var selectId = obj.target.id;
                var _msg = '<spring:message code="O00056"/>';
                var _url = '<ifvm:action name="removeOfferJoinProd"/>';

                if (selectId == "btnRemoveOfferJoinProd") {
                    _msg = '<spring:message code="O00056"/>';   /* 삭제 하시겠습니까? */
                    _url = '<ifvm:action name="removeOfferJoinProd"/>';
                } else if (selectId == "btnRemoveOfferJoinAllProd") {
                    _msg = '<spring:message code="O00086"/>'; /* 등록된 전체 항목을 삭제 하시겠습니까? */
                    _url = '<ifvm:action name="removeOfferJoinNotAllProd"/>';
                }

                if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                    if (confirm(_msg)) {
                        $.ifvProgressControl(true);
                        $.ifvPostJSON(_url, {rid: _rid, ridOfr: _ridOfr}, _success.bind(this), _fail);
                    }
                }
            },
            this.init = function () {
                this.setGridAndDataLoad();
                this.setButtons();
            }
    }


    // 엑셀 다운로드
    function targetListDownload() {
        if (joinChnlGrid.opt.gridControl.model.dataSource.length != 0) {
            $.ifvExcelDn('<ifvm:action name="exportExcelOfferJoinNotProdTargetList"/>', 'joinProdGrid');
        } else {
            alert("다운로드할 데이터가 없습니다.");
        }
    }

    //업로드 양식 다운로드
    function btnSampleDown() {

        // if (joinChnlGrid.opt.gridControl.model.dataSource.length != 0) {
            var data = {
                fileName: "offerProd_sample_data.xls"
            };
            $.fn.ifvmExcelSampleDown(data);
        // } else {
        //     alert("다운로드할 데이터가 없습니다.");
        // }
    }


    //파일 업로드
    function fileSearchFn() {
        alert("준비중입니다.");
    }

    //파일 업로드
    function excelDownChnlItem() {
        $("#chnlExcelUploadPop").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="offerJoinProdNotExcelPop"/>',
            contentType: "ajax",
            title: '상품 업로드',
            width: 600,
            close: 'chnlExcelUploadClosePop'
        });
    }

    function chnlExcelUploadClosePop() {
        chnlExcelUploadPop._destroy();
    }

    $(document).ready(function () {
        var offerJoinProdGrid = new OfferJoinProdList();
        offerJoinProdGrid.init();

        $("#btnUpload").click(function () {
            excelDownChnlItem();
        });

        ofrStatSaveValid();
    });
</script>


