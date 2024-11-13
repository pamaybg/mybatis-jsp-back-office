<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-03-02
  Time: 오전 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="surveyTextItemListGrid"></div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="selectTextItemBtn" objCode="selectTextItemBtn_OBJ">
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="L00123"/>
    </button>
    <button class="btn btn-sm btn_lightGray2" id="closeSearchTextItemPopBtn" objCode="closeSearchTextItemPopBtn_OBJ">
        <spring:message code="L00124"/>
    </button>
</div>
<script type="text/javascript">
    var surveyTextItemListGrid;
    var ridTextItem;
    var TextItemTitle;
    var surveyTextItemList = function(){
        this.init = function(){
            this.getTextItemList()
            this.action()
        },
        this.getTextItemList = function(){
            var _dataUrl = '<ifvm:action name="getTextItemList"/>';
            var _recordDoubleClick = function (args) {
                var data = args.data;
                ridTextItem = data.rid;
                TextItemTitle = data.itemTitle;
                $("#ridTextItem").val(ridTextItem);
                $("#textItemNm").val(TextItemTitle);
                $.fn.ifvmPopupClose();
            };

            var _serializeGridData = function (data) {

                //if($.fn.ifvmIsNotEmpty(ifvGlobal.searchHelp.searchCond)){
                //    data.ridSurveyItemAttr = ifvGlobal.searchHelp.searchCond;
                //}
                data.ridSurveySection = ridSurveySection;
                data.ridSurveyItem = ridSurveyItem;
                return data;
            };

            var _rowSelected = function (args) {
                var data = args.data;
                ridTextItem = data.rid;
                TextItemTitle = data.itemTitle;
            };

            var ejGridOption = {
                recordDoubleClick: _recordDoubleClick.bind(this),
                serializeGridData: _serializeGridData.bind(this),
                rowSelected: _rowSelected.bind(this),
                dataUrl: _dataUrl,
                columns:[{
                    field:'rid', visible: false
                },{
                    field: 'sectNo',
                    headerText: '페이지 번호',
                    textAlign : 'center',
                    width: '10%'
                },{
                    field: 'itemNo',
                    headerText: '항목 번호',
                    textAlign : 'center',
                    width: '10%'
                },{
                    field: 'itemTitle',
                    headerText: '항목 이름',
                    textAlign : 'center',
                    width: '50%'
                },{
                    field: 'fieldTypeCd',
                    headerText: '타입',
                    textAlign : 'center',
                    width: '15%'
                }],
                requestGridData: {
                    sidx: 'sectNo DESC, itemNo'
                },
                radio: true,
                tempId: "ifvGridTemplete"
            };

            $("#surveyTextItemListGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        this.action = function(){
            $('#selectTextItemBtn').on('click', function () {
                $("#ridTextItem").val(ridTextItem);
                $("#textItemNm").val(TextItemTitle);
                $.fn.ifvmPopupClose();
            }.bind(this));

            $('#closeSearchTextItemPopBtn').on('click', function () {
                $.fn.ifvmPopupClose();
            }.bind(this));
        }
    }

    $(document).ready(function () {
        surveyTextItemListGrid = new surveyTextItemList();
        surveyTextItemListGrid.init();
    });
</script>