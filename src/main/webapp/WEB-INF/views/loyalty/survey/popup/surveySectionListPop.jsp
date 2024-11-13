<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-04-04
  Time: 오후 2:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="surveySectionListGrid"></div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="selectSurvSection" objCode="selectSurvSection_OBJ">
        <spring:message code="L00072" />
    </button>
    <button class="btn btn-sm btn_lightGray2" id="closeSurvSerctionListPop" objCode="closeSurvSerctionListPop_OBJ">
        <spring:message code="M00441" />
    </button>
</div>

<script>
var survSectionListPop;

var surveySectionListPop = function(){
    var _rid = null;
    var _sectionNo = null;
    var _sectionContents = null;

    this.setRid = function (rid) {
        _rid = rid;
    },
    this.getRid = function () {
        return _rid;
    },
    this.setSectionNo = function(sctionNo){
        _sectionNo = sctionNo;
    }  ,
    this.getSectionNo = function(){
        return _sectionNo;
    },
    this.setSectionContents = function(sctionContents){
        _sectionContents = sctionContents;
    },
    this.getSectionContents = function(){
        return _sectionContents;
    },
    this.surveySectionListGrid = null,
    this.init = function(){
        this.action();
        this.getSurveySectionListGrid();
    },
    this.getSurveySectionListGrid = function() {
        var ejGridOption = {
            serializeGridData: function (data) {
                data.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                return data;
            },
            rowSelected: function (args) {
                var data = args.data;
                this.setRid(data.ridSurveySection);
                this.setSectionNo(data.sectionNo);
                this.setSectionContents(data.sectionContents);
            }.bind(this),
            recordDoubleClick : function (args) {
                var data = args.data;
                ridSurveySection = data.ridSurveySection;
                sectionNo = data.sectionNo;
                sectionContents = data.sectionContents;

                pageObjectSurveySectionDetailPop.setupRidSurveySection(ridSurveySection);
                $("#surveySectionRid").val(ridSurveySection)
                $("#sectionNo").val(sectionNo)
                $("#sectionContents").val(sectionContents)
                pageObjectSurveySectionDetailPop.setTitleTemp();

                //pageObjectSurveySectionDetail.surveySectionGrid.opt.gridControl.selectRows(sectionNo-1);
                var index = 0;
                pageObjectSurveySectionDetail.surveySectionGrid.opt.gridControl.model.currentViewData.forEach(function (vf) {
                    if(ridSurveySection == vf.ridSurveySection ){
                        pageObjectSurveySectionDetail.surveySectionGrid.opt.gridControl.selectRows(index);
                    }
                    index = index+1;
                });

                this.close();
            }.bind(this),
            dataUrl: '<ifvm:action name="getSurveySectionList"/>',
            columns: [
                {
                    field: 'ridSurveySection', headerText: 'ridSurveySection', visible: false
                }, {
                    field: 'sectionNo', headerText: '<spring:message code="S00084"/>', textAlign: 'center', customAttributes: {searchable: true}, width: '12%'
                }, {
                    field: 'sectionContents', headerText: '페이지 설명', textAlign: 'left', customAttributes: {
                        searchable: true,
                        style: "text-overflow: ellipsis;white-space: nowrap;overflow: hidden;"
                    }
                }, {
                    field: 'lastFlag', headerText: '마지막 페이지 여부', textAlign: 'center'
                }, {
                    field: 'modifyBy', headerText: '<spring:message code="L00044"/>', textAlign: 'center', customAttributes: {index: 'name'}
                }, {
                    field: 'modifyDate', headerText: '<spring:message code="L02703"/>', textAlign: 'center'
                }
            ],
            requestGridData: {
                sidx: 'sectionNo',
                sord: 'asc'
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            tempId: "ifvGridTemplete"
        };

        this.surveySectionListGrid = $('#surveySectionListGrid').ifvsfGrid({
            ejGridOption: ejGridOption
        });
    },
    this.close = function(){
        $.fn.ifvmPopupClose();
    },
    this.action = function(){

        $('#selectSurvSection').on('click', function(){
            if($.fn.ifvmIsNotEmpty(this.surveySectionListGrid.opt.gridControl.getSelectedRecords()[0])) {
                pageObjectSurveySectionDetailPop.setupRidSurveySection(ridSurveySection);
                ridSurveySection = this.getRid();
                sectionNo = this.getSectionNo();
                sectionContents = this.getSectionContents();

                $("#surveySectionRid").val(ridSurveySection)
                $("#sectionNo").val(sectionNo)
                $("#sectionContents").val(sectionContents)
                pageObjectSurveySectionDetailPop.setTitleTemp();

                var index = 0;
                pageObjectSurveySectionDetail.surveySectionGrid.opt.gridControl.model.currentViewData.forEach(function (vf) {
                    if(ridSurveySection == vf.ridSurveySection ){
                        pageObjectSurveySectionDetail.surveySectionGrid.opt.gridControl.selectRows(index);
                    }
                    index = index+1;
                });

                this.close();
            }else{
                alert('<spring:message code="M00499"/>')
            }
        }.bind(this));

        $("#closeSurvSerctionListPop").click(function(){
            this.close();
        }.bind(this));
    }
}

$(document).ready(function(){
    survSectionListPop = new surveySectionListPop();
    survSectionListPop.init();
})
</script>
