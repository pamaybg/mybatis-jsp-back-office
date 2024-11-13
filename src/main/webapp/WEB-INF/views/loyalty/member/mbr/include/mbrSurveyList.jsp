<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-01-10
  Time: 오후 4:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="설문 이력" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" id="surveyRsltPopBtn" text="설문결과상세"  objCode="surveyRsltPopBtn_OBJ"/>
    </div>
</div>
<div id="mbrSurveyListGrid" class="white_bg grid_bd0"></div>
<div id="popupContainer" class="popup_container"></div>
<script TYPE="text/javascript">
var mbrSurveyGrid;

var mbrSurveyList = function(){
    var _rid = null;
    this.dataUrl = '<ifvm:action name="getMbrSurveyList"/>',
    this.mbrSurveyListGrid = null,
    this.getRid = function () {
        return _rid;
    },
    this.setRid = function (rid) {
        _rid = rid;
    },
    this.init = function(){
        this.getMbrSurveyList()
        this.action()
    },
    this.getMbrSurveyList = function () {

        var _recordDoubleClick = function (args) {
            var data = args.data;
            this.setRid(data.rid);
            this.openPopup(this.getRid())
        };

        var _serializeGridData = function (data) {
            data.ridMbr = mbr_rid;
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
            dataUrl: this.dataUrl,
            columns: [
                {
                    field: 'survNo', headerText: '설문번호', textAlign: 'center', customAttributes: {index : 'lsm.SURV_NO', searchable: true}
                }, {
                    field: 'survNm', headerText: '<spring:message code="S00074"/>', textAlign: 'center', customAttributes: {index : 'lsm.SURV_NM', searchable: true}
                }, {
                    field: 'validDate', headerText: '<spring:message code="설문기간"/>', textAlign: 'center', width: '30%'
                }, {
                    field: 'createDate', headerText: '<spring:message code="L02292"/>', textAlign: 'center',
                }, {
                    field: 'rid', headerText: 'rid', visible: false
                }
            ],
            requestGridData: {
                sidx: 'validStartDate',
                sord: 'desc',
            },
            gridDataInit: true,
            radio: true,
        };

        this.mbrSurveyListGrid = $('#mbrSurveyListGrid').ifvsfGrid({
            ejGridOption: ejGridOption
        });
    },
    this.openPopup = function (_rid) {
        if($.fn.ifvmIsNotEmpty(_rid)){
            $.fn.ifvmPopupOpen('popupContainer', _rid,
                '<ifvm:url name="mbrSurveyDetatilPop"/>',
                '<spring:message code="L02929"/>', 860);
        }else{
            alert('<spring:message code="M00285"/>')
        }

    },
    this.action = function(){

        $("#surveyRsltPopBtn").click(function(){
            this.openPopup(this.getRid())
        }.bind(this))
    }
}
$(document).ready(function(){
    mbrSurveyGrid = new mbrSurveyList();
    mbrSurveyGrid.init();
})
</script>
