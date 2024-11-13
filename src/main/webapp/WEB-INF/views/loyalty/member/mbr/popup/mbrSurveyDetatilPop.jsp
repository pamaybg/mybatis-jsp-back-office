<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="mbrSurveyDetailListGrid"></div></div>

<div class="pop_btn_area">
    <button class="btn btn-sm btn_lightGray2" id="closePopContainer" objCode="mbrSurveyDetailPopClose_OBJ">
        <spring:message code="M00441" />
    </button>
</div>

<script type="text/javascript">
    var mbrSurveyRsltDetail;

    var mbrSurveyDetailList = function(rid){
        var _rid = rid;

        this.mbrSurveyDetailListGrid = null,
        this.dataUrl = '<ifvm:action name="getMbrSurveyDetailPop"/>',
        this.init = function(){
            this.action();
            this.getMbrSurveyRsltList();
        },
        this.getMbrSurveyRsltList = function(){
            var _recordDoubleClick = function (args) {
                var data = args.data;
                return data;
            };

            var _serializeGridData = function (data) {
                data.ridMbr = mbr_rid;
                data.ridSurv = _rid || popSelectlId;
                return data;
            };

            var _rowSelected = function (args) {
                var data = args.data;
                return data;
            };

            var ejGridOption = {
                recordDoubleClick: _recordDoubleClick.bind(this),
                serializeGridData: _serializeGridData.bind(this),
                rowSelected: _rowSelected.bind(this),
                dataUrl: this.dataUrl,
                columns: [
                    {
                        field: 'itemTItle', headerText: '문항내용', textAlign: 'center', customAttributes: {searchable: true}
                    }, {
                        field: 'fieldTypeCd', headerText: '<spring:message code="유형"/>', textAlign: 'center', customAttributes: {searchable: true}
                    }, {
                        field: 'ansValue', headerText: '<spring:message code="응답내용"/>', textAlign: 'center'
                    }, {
                        field: 'rid', headerText: 'rid', visible: false
                    }
                ],
                requestGridData: {
                    sidx: 'sectNo',
                    sord: 'asc',
                },
                gridDataInit: true,
                radio: true,
            };

            this.mbrSurveyDetailListGrid = $('#mbrSurveyDetailListGrid').ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        this.action = function(){
            $("#closePopContainer").click(function(){
                $.fn.ifvmPopupClose();
            })
        }
    }

    $(document).ready(function(){
        mbrSurveyRsltDetail = new mbrSurveyDetailList(popSelectlId);
        mbrSurveyRsltDetail.init();
    })
</script>