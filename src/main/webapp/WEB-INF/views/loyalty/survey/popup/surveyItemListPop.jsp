<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-04-05
  Time: 오전 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="surveyItemListGrid"></div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="selectSurvItem" objCode="selectSurvItem_OBJ">
        <spring:message code="L00072"/>
    </button>
    <button class="btn btn-sm btn_lightGray2" id="closeSurvItemListPop" objCode="closeSurvItemListPop_OBJ">
        <spring:message code="M00441"/>
    </button>
</div>

<script>
var survItemListPop;

var surveyItemListPop = function () {
    var _rid = null;
    var _itemNo = null;
    var _itemTitle = null;

    this.setRid = function (rid) {
        _rid = rid;
    },
    this.getRid = function () {
        return _rid;
    },
    this.setItemNo = function(itemNo){
        _itemNo= itemNo;
    },
    this.getItemNo = function(){
        return _itemNo;
    },
    this.setItemTitle = function(itemTitle){
        _itemTitle = itemTitle;
    },
    this.getItemTitle = function(){
        return _itemTitle;
    },
    this.surveyItemListGrid = null,
    this.init = function () {
        this.action();
        this.getSurveyItemListGrid();
    },
    this.getSurveyItemListGrid = function () {
        var ejGridOption = {
            serializeGridData: function (data) {
                data.ridSurveySection = ridSurveySection;
                return data;
            },
            rowSelected: function (args) {
                var data = args.data;
                this.setRid(data.ridSurveyItem);
                this.setItemNo(data.itemNo);
                this.setItemTitle(data.itemTitle);
            }.bind(this),
            recordDoubleClick: function (args) {
                var data = args.data;
                ridSurveyItem = data.ridSurveyItem;
                itemNo = data.itemNo;
                itemTitle = data.itemTitle;

                pageObjectSurveyItemAttrDetailPop.setupRidSurveyItem(ridSurveyItem);
                $("#surveyItemRid").val(ridSurveyItem)
                $("#itemNo").val(itemNo)
                $("#itemTitle").val(itemTitle)
                pageObjectSurveyItemAttrDetailPop.setTitleTemp();

                //pageObjectSurveySectionDetail.surveyItemGrid.opt.gridControl.selectRows(itemNo-1);
                var index = 0;
                pageObjectSurveySectionDetail.surveyItemGrid.opt.gridControl.model.currentViewData.forEach(function (vf) {
                    if(ridSurveyItem == vf.ridSurveyItem ){
                        pageObjectSurveySectionDetail.surveyItemGrid.opt.gridControl.selectRows(index);
                    }
                    index = index+1;
                });

                this.close();
            }.bind(this),
            dataUrl: '<ifvm:action name="getSurveyItemListPop"/>',
            columns: [
                {
                    field: 'ridSurveyItem', headerText: 'ridSurveyItem', visible: false
                }, {
                    field: 'fieldTypeCode', headerText: 'fieldTypeCode', visible: false
                }, {
                    field: 'itemNo', headerText: '<spring:message code="S00090"/>', textAlign: 'center',
                }, {
                    field: 'itemTitle', headerText: '<spring:message code="S00091"/>', textAlign: 'left',
                }, {
                    field: 'fieldTypeCodeName', headerText: '<spring:message code="L02702"/>', textAlign: 'center',
                    customAttributes: {index: 'fieldTypeCode'}
                }, {
                    field: 'optionalFlag', headerText: '선택 문항 여부', textAlign: 'center',
                    customAttributes: {index: 'optionalFlag'}
                }, {
                    field: 'modifyBy', headerText: '<spring:message code="L00044"/>', textAlign: 'center',
                    customAttributes: {index: 'name'}
                }, {
                    field: 'modifyDate', headerText: '<spring:message code="L02703"/>', textAlign: 'center'
                }
            ],
            requestGridData: {
                sidx: 'itemNo',
                sord: 'asc',
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            tempId: "ifvGridTemplete"
        };

        this.surveyItemListGrid = $('#surveyItemListGrid').ifvsfGrid({
            ejGridOption: ejGridOption
        });
    },
    this.close = function () {
        $.fn.ifvmPopupClose();
    },
    this.action = function () {

        $('#selectSurvItem').on('click', function () {
            if($.fn.ifvmIsNotEmpty(this.surveyItemListGrid.opt.gridControl.getSelectedRecords()[0])){
                pageObjectSurveyItemAttrDetailPop.setupRidSurveyItem(ridSurveyItem);
                ridSurveyItem = this.getRid();
                itemNo = this.getItemNo();
                itemTitle = this.getItemTitle();

                $("#surveyItemRid").val(ridSurveyItem)
                $("#itemNo").val(itemNo)
                $("#itemTitle").val(itemTitle)
                pageObjectSurveyItemAttrDetailPop.setTitleTemp();

                //pageObjectSurveySectionDetail.surveyItemGrid.opt.gridControl.selectRows(itemNo-1);
                var index = 0;
                pageObjectSurveySectionDetail.surveyItemGrid.opt.gridControl.model.currentViewData.forEach(function (vf) {
                    if(ridSurveyItem == vf.ridSurveyItem ){
                        pageObjectSurveySectionDetail.surveyItemGrid.opt.gridControl.selectRows(index);
                    }
                    index = index+1;
                });

                this.close();
            }else{
                alert('<spring:message code="M00499"/>')
            }
        }.bind(this));

        $("#closeSurvItemListPop").click(function () {
            this.close();
        }.bind(this));
    }
}

$(document).ready(function () {
    survItemListPop = new surveyItemListPop();
    survItemListPop.init();
});
</script>
