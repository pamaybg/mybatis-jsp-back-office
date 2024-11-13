<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%!
    public String cleanXss(String str) {

        if (str != null) {
            str = str.replaceAll("<", "&lt;");
            str = str.replaceAll(">", "&gt;");
        }
        return str;
    }
%>

<!-- 그리드 버튼이 두개 나타나는 현상 때문에 content.css의 after 부분을 재정의함. -->
<style type="text/css">
    .ifv_grid_templete .e-grid .e-headercell .sort_type.asc:after {
        content: '';
        height: '';
        width: '';
        background: '';
        display: none;
    }

    .ifv_grid_templete .e-grid .e-headercell .sort_type.desc:after {
        content: '';
        height: '';
        width: '';
        background: '';
        display: none;
    }
</style>

<script type="text/javascript">
    var atribColumnList;
    var targetGroupTargetListGrid;
    var targetGroup = {
        targetGroupId: "",
        targetGroupType: "CND",
        data: {}
    }
    var targetCount;
    var targetGroupId = '<%= cleanXss(request.getParameter("targetGroupId")) %>';
    targetGroup.targetGroupId = $.fn.ifvmIsEmpty(targetGroupId) || targetGroupId == "null" ? '' : targetGroupId;
    var targetColumnLen = 0;

    //1000단위 정규식
    function numberWithCommas(x) {
        if ($.fn.ifvmIsNotEmpty(x)) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        } else return 0;
    }

    //타겟그룹 대상자 목록
    function getTargetGroupTargetList() {
        if (targetGroupId != null && targetGroupId != '') {
            //타겟그룹 대상자 컬럼 목록 조회
            $.ifvSyncPostJSON('<ifvm:action name="getTargetGroupOfSimple"/>', {
                    targetGroupId: targetGroupId
                }, function (result) {
                    setTargetGroup(result);
                    targetGroup.data = result;
                },
                function (result) {
                    $.errorChecker(result);
                    return;
                });

            getTargetGroupTargetListFlag(false);
            aleadyTargetGroup();
            //저장 된 값을 불러옴.
            aleadyTargetGroupValue();
        } else {
            newTargetGroup();
        }
        $.ifvProgressControl(false);
    }

    //그리드 테이블들 값 넣어주는 곳
    function setTargetGroup(result) {
        $("#targetingName").val(result.targetGroupName);
        $("#explain").val(result.targetGroupDesc);

        //대상수 조회 오류 발생시 메시지
        if (result.cnt == "MSG_T0001") {
            $.ifvErrorPop('<spring:message code="M01694"/>');
        } else {
            $("#targetingCount").val(numberWithCommas(result.cnt));
            this.targetCount = result.cnt;
        }

    }

    //타겟그룹 대상자 목록
    function getTargetGroupTargetListFlag(getSelectFlag) {
            var targetGroupId = targetGroup.targetGroupId;
            var targetGroupColList = [];

            if (targetGroupId != null && targetGroupId != '') {
                //타겟그룹 대상자 컬럼 목록 조회
                $.ifvSyncPostJSON('<ifvm:action name="getSimpleTargetGroupColumnList"/>', {
                        targetGroupId: targetGroupId
                    },
                    function (result) {
                        if (result.length > 0) {
                            targetGroupColList = result;
                        }


                        //타겟그룹 대상자 그리드 설정
                        setTargetGroupTargetListGrid(targetGroupColList, getSelectFlag);

                    });
            } else {
                alert("저장이 되지 않았습니다. 저장 버튼을 눌러주세요.");
            }
    }

    //타겟그룹 대상자 그리드 설정
    function setTargetGroupTargetListGrid(targetGroupColList, getSelectFlag) {

        if (targetGroupColList.length < 1 && $.fn.ifvmIsNotEmpty(targetGroup.targetGroupId)) {
            //컬럼 설정 팝업 열기
            simpleTargetColumnSetPopUpOpen();
        } else {

            var targetGroupId = targetGroup.targetGroupId;
            var columns = [];

            //타겟그룹 대상자 그리드 모델 설정
            $.each(targetGroupColList, function (index, col) {
                if (col.displayName == "사용자ID") {
                    var model = {
                        field: col.columnName, headerText: col.displayName, headerTextAlign: 'center', textAlign: 'center', width: '80px',
                        template: "<span style=\"color : blue;cursor:pointer; text-decoration: underline; \">{{:" + col.columnName + "}}</span>",
                        customAttributes: {index: col.columnName}
                    };
                } else {
                    var model = {
                        field: col.columnName, headerText: col.displayName, headerTextAlign: 'center', textAlign: 'center', width: '80px',
                        customAttributes: {index: col.columnName}
                    };
                }

                columns.push(model);
            });

            var ejGridOption = {
                serializeGridData: function (data) {
                    data.targetGroupId = targetGroupId;

                    return data;
                },
                recordClick: function (args) {
                    <%--if (args.columnName == '사용자ID') {--%>
                    <%--    $.ifvPostJSON('<ifvm:action name="getMbrNoFromCust"/>', {--%>
                    <%--        userId: args.data.C0001--%>
                    <%--    }, function(result){--%>
                    <%--        MbrDetail(result.ridMbr, result.custTypeCd);--%>
                    <%--    });--%>
                    <%--}--%>
                },
                recordDoubleClick : function(args) {
                    $.ifvPostJSON('<ifvm:action name="getMbrNoFromCust"/>', {
                        userId: args.data.C0001
                    }, function(result){
                        MbrDetail(result.ridMbr, result.custTypeCd);
                    });
                },
                columns: columns,
                allowSorting: true,
                requestGridData: {
                    sidx: 1,
                    sord: 'desc',
                    _search: false
                },
                rowList: [10, 25, 50, 100],
                radio: false,
                isHorizontalScroll : true,
                tempId: 'ifvGridSimplePageTemplete'
            };

            // if (getSelectFlag == true) {
                ejGridOption.dataUrl = '<ifvm:action name="getSimpleTargetList"/>';
            // } else {
            //     ejGridOption.dataSource = [];
            //     ejGridOption.datatype = 'clientSide';
            // }

            targetGroupTargetListGrid = $("#targetGroupTargetListGrid").ifvsfGrid({ejGridOption: ejGridOption});

            targetColumnLen = targetGroupColList.length;
        }
    }

    //컬럼 설정 팝업 열기
    function simpleTargetColumnSetPopUpOpen() {
        $("#simpleTargetColumnSetPopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="simpleTargetColumnSetPop"/>',
            contentType: "ajax",
            title: '<spring:message code="M01496" />',
            width: 440,
            close: 'simpleTargetColumnSetPopupClose'
        });
    }

    //컬럼 설정 팝업 닫기
    function simpleTargetColumnSetPopupClose() {
        simpleTargetColumnSetPopup._destroy();
    }

    //엑셀 다운로드
    function excelDownload() {
        if ($.fn.ifvmIsNotEmpty(targetGroupTargetListGrid.opt.gridControl.model.dataSource)) {
            if (confirm('엑셀 다운로드를 진행하시겠습니까?') == true) {
                $.ifvExcelDn('<ifvm:action name="getSimpleGridListExport"/>',
                    'targetGroupTargetListGrid');
            }
        } else {
            alert("다운로드 할 대상을 조회 해주세요.")
        }
    }

    //대상수 구하는거
    function simpleTargeting() {
        var data = dataCheck();
        var countData;
        $.ifvSyncPostJSON("<ifvm:action name='setTargetingCountBtn'/>", {
            dataList: data[0]

        }, function (rst) {
            if ($.fn.ifvmIsNotEmpty(rst.cnt)) {
                countData = rst.cnt;
            } else {
                alert("입력하신 정보가 올바르지 않습니다. 다시 한번 확인해 주세요.")
            }
        }, function (rst) {
            alert("입력하신 정보가 올바르지 않습니다. 다시 한번 확인해 주세요.")
        });
        $("#targetingCount").val(countData);
        this.targetCount = countData;
    }

    //신규 저장
    function newDataSave(dataObjList, tgtGroupObjNm, tgtGroupObjDesc) {//,cntObj,filterObj_sql,filterObj_sql_count){
        $.ifvProgressControl(true);
        setTimeout(function () {
            if (confirm('저장 하시겠습니까?') == true) {
                simpleTargeting();
                $.ifvSyncPostJSON("<ifvm:action name='setTargetSimpleGroupNameTargetingGroupCondition'/>", {
                    dataList: dataObjList,
                    tgtGroupNm: tgtGroupObjNm,
                    tgtGroupDesc: tgtGroupObjDesc,
                }, function (rst) {
                    if ($.fn.ifvmIsNotEmpty(rst)) {
                        if (rst.success == true) {
                            var isAlert = true;
                            targetGroup.data.id = rst.message;
                            targetGroup.targetGroupId = rst.message;
                            targetGroup.data.targetCount = this.targetCount;
                            //캠페인 워크플로우일 경우
                            try {
                                if (workflowFlag) {
                                    isAlert = false;

                                    //캔버스 저장
                                    saveCampaignTarget();
                                }
                            } catch (e) {
                            }

                            // 성공시 기존 로직
                            if (isAlert == true) {
                                alert('<spring:message code="C00094"/>');
                                var url = '<ifvm:url name="simpleTargeting"/>?targetGroupId=' + rst.message;
                                qtjs.href(url);
                            }
                        }
                    }

                }, function (rst) {
                    alert("입력하신 정보가 올바르지 않습니다. 다시 한번 확인해 주세요.")
                });
            }
            $.ifvProgressControl(false);
        }, 1000);
    }

    //수정
    function aleadyDataSave(dataObjList, tgtGroupObjNm, tgtGroupObjDesc) {//,cntObj,filterObj_sql,filterObj_sql_count){
        $.ifvProgressControl(true);
        setTimeout(function () {
            if (confirm('수정 하시겠습니까?') == true) {
                simpleTargeting()
                $.ifvSyncPostJSON("<ifvm:action name='getTargetSimpleGroupUpdate'/>", {
                    dataList: dataObjList,
                    tgtGroupNm: tgtGroupObjNm,
                    tgtGroupDesc: tgtGroupObjDesc,
                    targetGroupId: targetGroupId,
                    targetCount: this.argetCount

                }, function (rst) {
                    if ($.fn.ifvmIsNotEmpty(rst)) {
                        if (rst.success == true) {
                            var isAlert = true;
                            targetGroup.data.id = rst.message;
                            targetGroup.targetGroupId = rst.message;
                            targetGroup.data.targetCount = this.targetCount;

                            //캠페인 워크플로우일 경우
                            try {
                                if (workflowFlag) {
                                    isAlert = false;

                                    //캔버스 저장
                                    saveCampaignTarget();
                                }
                            } catch (e) {
                            }

                            // 성공시 기존 로직
                            if (isAlert == true) {
                                alert('<spring:message code="C00094"/>');
                                var url = '<ifvm:url name="simpleTargeting"/>?targetGroupId=' + rst.message;
                                qtjs.href(url);
                            }
                        }
                    }
                }, function (rst) {
                    alert("입력하신 정보가 올바르지 않습니다. 다시 한번 확인해 주세요.")
                });
            }
            $.ifvProgressControl(false);
        }, 1000);
    }

    //값 전달
    function dataCheck() {
        var condList = [];
        var GroupList = [];
        var targetingName = $("#targetingName").val();
        var explain = $("#explain").val();

        $.each(atribColumnList, function (dataIdx, data) {
            var condData = {};
            var compValData = '';
            var compOperData = '';

            var filterData = ".searchPopOpen_" + data.id + " #filter";
            var filterColData = $(filterData).val();

            var filterStartDate = '#simpleStartDate_'+ data.id;
            var filterDateStartData = $(filterStartDate).val();
            var filterEndDate = '#simpleEndDate_'+ data.id;
            var filterDateEndData = $(filterEndDate).val();

            var selectedCol = ".colPopOpen_" + data.id + " option:selected";
            var selectedColData = $(selectedCol).val();

            if (data.inputType == 'DATE') {
                if (filterDateStartData != '' && filterDateEndData != '' && filterDateStartData != null && filterDateEndData != null) {
                    compValData = filterDateStartData + ' AND ' + filterDateEndData;
                }
                compOperData = 'FROMTO';
            } else {
                compValData = filterColData;
                compOperData = selectedColData;
            }

            var tblAliasColNm = atribColumnList[dataIdx].tblAliasColNm.toString();
            if (targetGroupId != '' && targetGroupId != null) {
                condData.targetGroupId = targetGroupId;
            }

            var sumYnFlag = ".sumYn_" + data.id + " #sumYn";
            var sumYnFlagCheck = $(sumYnFlag).is(':checked');
            var sumYnFlagData = "";

            if (sumYnFlagCheck == true && compValData != null && compValData != '') {
                sumYnFlagData = 'Y'
            } else {
                sumYnFlagData = 'N'
            }

            condData.lgcFldId = data.id;
            condData.compOper = compOperData;
            condData.compVal = compValData;
            condData.tblAliasColNm = tblAliasColNm;
            condData.dataTypeCd = data.dataTypeCd;
            condData.sumYn = sumYnFlagData;
            condData.mainShopCd = $.ifvmGetUserInfo().empNo;
            condList.push(condData);
        });
        return [condList, targetingName, explain];
    }

    //이미 저장된 값들을 찾아옴.
    function aleadyTargetGroupValue() {
        $.ifvProgressControl(true);
            //저장 된 값을 불러옴.
            $.ifvSyncPostJSON("<ifvm:action name='getTargetSimpleGroupValue'/>", {
                targetGroupId: targetGroupId
            }, function (rst) {
                $.each(rst, function (index, data) {
                    if (data.compOper == 'FROMTO') {
                        var filterStartDate = '#simpleStartDate_'+ data.lgcFldId;
                        var filterEndDate = '#simpleEndDate_'+ data.lgcFldId;

                        var spiltData = data.compVal.split("AND");

                        if (spiltData[0] != '' && spiltData[0] != null && spiltData[1] != '' && spiltData[1] != null) {
                            $(filterStartDate).val(spiltData[0].trim());
                            $(filterEndDate).val(spiltData[1].trim());
                        }

                        var startDate = $(filterStartDate);
                        var endDate = $(filterEndDate);

                        //설정
                        startDate.ifvDateChecker({
                            maxDate: endDate
                        });

                        endDate.ifvDateChecker({
                            minDate: startDate
                        });
                    } else {
                        var sumYnFlag = ".sumYn_" + data.lgcFldId + " #sumYn";
                        let checkedClass = 'colPopOpen_'+data.lgcFldId;

                        if (data.sumYn == 'Y') {
                            $(sumYnFlag).prop('checked', true);
                            sumYnCheckBoxControlFun(true, checkedClass);
                        } else {
                            $(sumYnFlag).prop('checked', false);
                            sumYnCheckBoxControlFun(false, checkedClass);
                        }

                        var searchDataQ = ".searchPopOpen_" + data.lgcFldId + " #filter";
                        var operatDataQ = ".colPopOpen_" + data.lgcFldId + " #simpleTypeCode";
                        $(operatDataQ).val(data.compOper);
                        $(searchDataQ).val(data.compVal);
                    }
                });
            });
            $.ifvProgressControl(false);
    }

    //저장 및 수정
    function simpleTargetingSave() {
        var targetingName = $("#targetingName").val();
        var explain = $("#explain").val();
        if (targetingName != null && targetingName != '') {
            if (explain != null && explain != '') {
                $("#targetingName").attr("required", false);
                $("#explain").attr("required", false);
                if (targetGroupId != null && targetGroupId != '') { //수정
                    var data = dataCheck();
                    aleadyDataSave(data[0], data[1], data[2]);

                } else { // 신규
                    var data = dataCheck();
                    newDataSave(data[0], data[1], data[2]);
                }
            } else {
                alert('<spring:message code="M02979"/>');
            }
        } else {
            alert('<spring:message code="M02978"/>');
        }
    }

    function selectCommCode() {
        var code;
        //select 옵션 내용 조회
        $.ifvSyncPostJSON("<ifvm:action name='getCommCodeList'/>", {
            groupCode: "MKT_TARGET_SERC_OPRT_TYPE",
            enableNA: true
        }, function (rst) {
            rst.rows.remove(0)
            rst.rows.remove(0)
            rst.rows.remove(0)
            rst.rows.remove(1)
            rst.rows.remove(1)
            rst.rows.remove(5)
            rst.rows.remove(5)
            // rst.rows.remove(5)
            // rst.rows.remove(12)
            code = rst.rows;
        });

        return code
    }

    //기존의 타겟
    function aleadyTargetGroup() {
        $.ifvProgressControl(true);
            var obj = [];
            var objTopName = [];
            var codeList;
            //그룹 이름 조회
            $.ifvSyncPostJSON("<ifvm:action name='getTargetSimpleGroupName'/>", {
                targetGroupId: targetGroupId
            }, function (rst) {
                $.each(rst, function (dataIdx, dataTopObject) {
                    var tmplTop = $("#simpleTargetingTemp").tmpl(dataTopObject);
                    $('#atribArea').append(tmplTop);
                });
            });

            codeList = selectCommCode();

            //컬럼 이름 조회
            $.ifvSyncPostJSON("<ifvm:action name='getTargetSimpleList'/>", {
                targetGroupId: targetGroupId
            }, function (rst) {
                atribColumnList = rst;

                $.each(rst, function (dataIdx, dataObject) {
                    //컬럼 생성
                    if (dataObject.inputType == 'DATE') {
                        var tmpl = $("#conditionDateTemplate").tmpl(dataObject);
                        $("#atribGroupArea_" + dataObject.parentId).append(tmpl);

                        var filterStartDate = '#simpleStartDate_'+ dataObject.id;
                        var filterEndDate = '#simpleEndDate_'+ dataObject.id;

                        var startDate = $(filterStartDate);
                        var endDate = $(filterEndDate);

                        //설정
                        startDate.ifvDateChecker({
                            maxDate: endDate
                        });

                        endDate.ifvDateChecker({
                            minDate: startDate
                        });
                    } else if (dataObject.inputType == 'SUM') {
                        var tmpl = $("#conditionSumTemplate").tmpl(dataObject);
                        $("#atribGroupArea_" + dataObject.parentId).append(tmpl);

                        //연산자 selectbox 생성
                        // $('.colPopOpen_'+dataObject.id);
                        var seltmpl = $("#analysisOptionTypeCodeTemplate").tmpl(codeList);
                        $("#grid_" + dataObject.id + " #simpleTypeCode").append(seltmpl);

                        //필터설정
                        // $('.searchPopOpen_'+dataObject.id);
                        // $('#searchbutton_'+dataObject.id);
                        $('#searchbutton_' + dataObject.id).on('click', function () {
                            openPopSearch(dataObject.id);
                        });

                    } else {
                        var tmpl = $("#conditionTemplate").tmpl(dataObject);
                        $("#atribGroupArea_" + dataObject.parentId).append(tmpl);

                        //연산자 selectbox 생성
                        // $('.colPopOpen_' + dataObject.id);
                        var seltmpl = $("#analysisOptionTypeCodeTemplate").tmpl(codeList);
                        $("#grid_" + dataObject.id + " #simpleTypeCode").append(seltmpl);

                        //필터설정
                        // $('.searchPopOpen_' + dataObject.id);
                        // $('#searchbutton_' + dataObject.id);
                        $('#searchbutton_' + dataObject.id).on('click', function () {
                            openPopSearch(dataObject.id);
                        });
                    }
                });
            });
            $.ifvProgressControl(false);
    }

    //신규 타겟
    function newTargetGroup() {
        var codeList;

        //그룹 이름 조회
        $.ifvSyncPostJSON("<ifvm:action name='getTargetSimpleGroupTopNameCondition'/>", {}, function (rst) {
            $.each(rst, function (dataIdx, dataTopObject) {
                var tmplTop = $("#simpleTargetingTemp").tmpl(dataTopObject);
                $('#atribArea').append(tmplTop);
            });
        });

        codeList = selectCommCode();
        //컬럼 이름 조회
        $.ifvSyncPostJSON("<ifvm:action name='getTargetSimpleListColNameCondition'/>", {}, function (rst) {
            atribColumnList = rst;
            $.each(rst, function (dataIdx, dataObject) {
                //컬럼 생성
                if (dataObject.inputType == 'DATE') {
                    var tmpl = $("#conditionDateTemplate").tmpl(dataObject);
                    $("#atribGroupArea_" + dataObject.parentId).append(tmpl);

                    var filterStartDate = '#simpleStartDate_'+ dataObject.id;
                    var filterEndDate = '#simpleEndDate_'+ dataObject.id;

                    var startDate = $(filterStartDate);
                    var endDate = $(filterEndDate);


                    //설정
                    startDate.ifvDateChecker({
                        maxDate: endDate
                    });

                    endDate.ifvDateChecker({
                        minDate: startDate
                    });


                } else if (dataObject.inputType == 'SUM') {
                    var tmpl = $("#conditionSumTemplate").tmpl(dataObject);
                    $("#atribGroupArea_" + dataObject.parentId).append(tmpl);

                    //연산자 selectbox 생성
                    // $('.colPopOpen_'+dataObject.id);
                    var seltmpl = $("#analysisOptionTypeCodeTemplate").tmpl(codeList);
                    $("#grid_" + dataObject.id + " #simpleTypeCode").append(seltmpl);

                    //필터설정
                    // $('.searchPopOpen_'+dataObject.id);
                    // $('#searchbutton_'+dataObject.id);
                    $('#searchbutton_' + dataObject.id).on('click', function () {
                        openPopSearch(dataObject.id);
                    });
                    let checkedClass = 'colPopOpen_'+dataObject.id;
                    var sumYnFlag = ".sumYn_" + dataObject.id + " #sumYn";
                    $(sumYnFlag).prop('checked', true);

                    sumYnCheckBoxControlFun(true, checkedClass);

                } else {
                    var tmpl = $("#conditionTemplate").tmpl(dataObject);
                    $("#atribGroupArea_" + dataObject.parentId).append(tmpl);

                    //연산자 selectbox 생성
                    // $('.colPopOpen_'+dataObject.id);
                    var seltmpl = $("#analysisOptionTypeCodeTemplate").tmpl(codeList);
                    $("#grid_" + dataObject.id + " #simpleTypeCode").append(seltmpl);

                    //필터설정
                    // $('.searchPopOpen_'+dataObject.id);
                    // $('#searchbutton_'+dataObject.id);
                    $('#searchbutton_' + dataObject.id).on('click', function () {
                        openPopSearch(dataObject.id);
                    });

                    $(".colPopOpen_" + dataObject.id + " option:eq(3)").prop("selected", true);

                }

            });
        });
    }

    //필터팝업
    function openPopSearch(id) {
        var selectedCol = ".colPopOpen_" + id + " option:selected";
        var filterData = ".searchPopOpen_" + id + " #filter";
        var sumYnFlagId = ".sumYn_" + id + " #sumYn";

        var filterColData = $(filterData).val();
        var selectedColData = $(selectedCol).val();
        var sumFieldData = $(sumYnFlagId).val();

        var sumYnFlagCheck = $(sumYnFlagId).is(':checked');
        var sumYnFlagData = "";
        var sumYnFieldFlag = false;

        if (sumYnFlagCheck == true) {
            sumYnFlagData = 'Y'
        } else {
            sumYnFlagData = 'N'
        }

        if(sumFieldData != null && sumFieldData != ''){
            sumYnFieldFlag = true
        }


        $("#simpleFilterSetPopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="simpleFilterSetPopup"/>',
            contentType: "ajax",
            title: '<spring:message code="M01187" />',
            width: 980,
            close: 'simpleFilterSetPopupClose',
            beforeOpen: function (args) {
                initFilterSetPop(id, selectedColData, filterColData, sumYnFlagData,sumYnFieldFlag);
            }
        });
    }

    //필터팝업클로즈
    function simpleFilterSetPopupClose() {
        simpleFilterSetPopup._destroy();
        sumYnCheckBoxControlFun(false, 'all');
    }

    //목록이동
    function segmentList() {
        var url = '<ifvm:url name="targetGroupList"/>';
        qtjs.href(url);
    }

    function goMbrDetail(id) {
        //개인정보 조회 이력남기기
        var url = null;

        $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true);
        //	qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + id);
        $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>', {
            rid: '',
            mbrNo: id
        }, function (result) {
            if (result.custTypeCd != null) {
                if (result.custTypeCd == 'C') {
                    //개인정보 조회 이력남기기(법인)
                    url = '<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid;
                } else if (result.custTypeCd == 'I' || result.custTypeCd == 'E' || result.custTypeCd == 'D' || result.custTypeCd == 'O' || result.custTypeCd == 'X') {
                    //개인정보 조회 이력남기기(개인/임직원)
                    url = '<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid;
                }
            }
        });
        window.open(url, "_blank");
    }

    //고객 상세 이동
    function MbrDetail(rid,custTypeCd) {
        if(custTypeCd != null){
            if(custTypeCd == 'C'){
                //개인정보 조회 이력남기기(법인)
                qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + rid);
            } else if(custTypeCd == 'I' || custTypeCd == 'E'|| custTypeCd == 'D'|| custTypeCd == 'O'|| custTypeCd == 'X') {
                //개인정보 조회 이력남기기(개인/임직원)
                qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + rid);
            }
        }
        $('#dialog_closebutton').trigger('click');
    }

    function sumYnCheckBoxControlFun(flag, clickValue) {
        var sumYnList = $('#sumYn #sumYn');
        $.each(sumYnList, function (dataIdx, dataObject) {
            if (dataObject.checked) {
                $("." + dataObject.value + " option[value='LIKE']").attr('disabled', 'disabled').hide();
                $("." + dataObject.value + " option[value='BETWEEN']").attr('disabled', 'disabled').hide();
                $("." + dataObject.value + " option[value='IN']").attr('disabled', 'disabled').hide();
                $("." + dataObject.value + " option[value='NOT IN']").attr('disabled', 'disabled').hide();
                $("." + dataObject.value + " option[value='IS NULL']").attr('disabled', 'disabled').hide();
                $("." + dataObject.value + " option[value='IS NOT NULL']").attr('disabled', 'disabled').hide();
                $("." + dataObject.value + " option[value='CUSTDTDEF']").attr('disabled', 'disabled').hide();
                if (flag && clickValue != 'all') {
                    if (dataObject.value == clickValue) {
                        $("." + dataObject.value + " option:eq(1)").prop("selected", true);
                    }
                }
            } else {
                $("." + dataObject.value + " option[value='LIKE']").removeAttr('disabled').show();
                $("." + dataObject.value + " option[value='BETWEEN']").removeAttr('disabled').show();
                $("." + dataObject.value + " option[value='IN']").removeAttr('disabled').show();
                $("." + dataObject.value + " option[value='NOT IN']").removeAttr('disabled').show();
                $("." + dataObject.value + " option[value='IS NULL']").removeAttr('disabled').show();
                $("." + dataObject.value + " option[value='IS NOT NULL']").removeAttr('disabled').show();
                $("." + dataObject.value + " option[value='CUSTDTDEF']").removeAttr('disabled').show();
                if (flag && clickValue != 'all') {
                    if (dataObject.value == clickValue) {
                        $("." + dataObject.value + " option:eq(3)").prop("selected", true);
                    }
                }
            }
        });
    }


    $(document).ready(function () {
        $.ifvProgressControl(true);
        setTimeout(function () {
            //대상자 조회
            getTargetGroupTargetList();

            $("#targetingName").attr("required", true);
            $("#explain").attr("required", true);

        },1000)

        //타켓팅
        $('#simpleTargeting').on('click', function () {
            $.ifvProgressControl(true);
            setTimeout(function () {
                simpleTargeting();
                alert('대상수 조회가 완료되었습니다. 대상수를 확인해 주세요. \n저장 시 조회된 대상으로 타겟그룹을 생성합니다.\n(대상수가 많을 경우 시간이 오래 걸릴 수 있습니다.) ')
                $.ifvProgressControl(false);
            },0)
        });
        //저장
        $('#simpleTargetingSave').on('click', function () {
            simpleTargetingSave();
        });
        //목록
        $('#segmentList').on('click', function () {
            segmentList();
        });

        // 대상자 조회
        $("#tgtSimpleDtlListBtn").on('click', function () {
            getTargetGroupTargetListFlag(true);
        });

        //컬럼 설정
        $('#columnSetBtn').on('click', function () {
            simpleTargetColumnSetPopUpOpen();
        });

        //엑셀 다운로드
        $('#excelDownloadBtn').on('click', function () {
            excelDownload();
        });

        //합계 체크박스
        $('#sumYn #sumYn').on('change', function () {
            let checkedClass = $(this).attr("value");
            sumYnCheckBoxControlFun(true, checkedClass);
        });

    });
</script>


<div class="page-title">
    <h1>
        <spring:message code="M02977"/>
        &gt; <spring:message code="M00582"/>
    </h1>
</div>

<div id="targetGroupDetail_area">

    <div class="page_btn_area">
        <div class="col-xs-2">
            <span><spring:message code="M00556"/></span>
        </div>
        <div class="col-xs-12 searchbtn_r" id="simpleTargetingDetailBtn_area">

            <%-- 목록 --%>
            <button class="btn btn-sm" id="segmentList" objCode="segmentList_OBJ">
                <spring:message code="L01698"/>
            </button>
        </div>
    </div>

    <div>
        <div class="well form-horizontal underline">
            <%-- 타겟팅명 --%>
            <div class="row qt_border">
                <label class="col-xs-1 control-label">
                    <span class="asterisk">*</span>
                    <spring:message code="M02438"/>
                </label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="text" required="true" id="targetingName"/>
                </div>
            </div>
            <%-- 설명 --%>
            <div class="row qt_border">
                <label class="col-xs-1 control-label">
                    <span class="asterisk">*</span>
                    <spring:message code="I00075"/>
                </label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="text" required="true" id="explain"/>
                </div>
            </div>
            <%-- 대상수 --%>
            <div class="row qt_border">
                <label class="col-xs-1 control-label">
                    <spring:message code="M01495"/>
                </label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="text" required="false" disabled="true" id="targetingCount"/>
                </div>
            </div>
        </div>
        <div id="atribArea" class="white_bg">
        </div>
    </div>
    <br/>
    <br/>
</div>
<br/>
<br/>
<div>
    <div style="padding-top : 30px;">
        <div class="page_btn_area">
            <div class="col-xs-5">
                <span><spring:message code="M01217"/></span>
            </div>
            <div class="col-xs-7 searchbtn_r">

                <%-- 타켓팅 --%>
                <button class="btn btn-sm" id="simpleTargeting" objCode="simpleTargeting_OBJ">
                    조회
                </button>

                <%-- 저장--%>
                <button class="btn btn-sm" id="simpleTargetingSave" objCode="simpleTargetingSave_OBJ">
                    <spring:message code="M00573"/>
                </button>

<%--                &lt;%&ndash; 조회 &ndash;%&gt;--%>
<%--                <button class="btn btn-sm" id="tgtSimpleDtlListBtn" objCode="tgtSimpleDtlListBtn_OBJ">--%>
<%--                    <spring:message code="L00030"/>--%>
<%--                </button>--%>

                <%-- 컬럼 설정 --%>
                <button class="btn btn-sm" id="columnSetBtn" objCode="columnSetBtn_OBJ">
                    <spring:message code="M01496"/>
                </button>

                <%-- 엑셀 다운로드 --%>
                <button class="btn btn-sm" id="excelDownloadBtn" objCode="excelDownloadBtn_OBJ">
                    <spring:message code="M01218"/>
                </button>
            </div>
        </div>
    </div>
    <!-- 대상자 목록 그리드  -->
    <div id="targetGroupTargetListGrid" class="white_bg grid_bd0"></div>
</div>
<!-- 필터설정을 위한 팝업 -->
<div id="simpleFilterSetPopup" class="popup_container"></div>
<!-- 그룹내의 컬럽 이름 옆에 seach 버튼의 팝업 -->
<div id="simpleTargetColumnSetPopup"></div>
<!-- 그룹의 이름을 내포할 템플릿 -->
<script id="simpleTargetingTemp" type="text/x-jquery-tmpl">
		
        	<div class="page_btn_area" id="atribGroupColName_${'${'}id}">
		   	 	<div class="col-xs-5">
			    	<span>${'${'}text}</span>
		    	</div>
	    	</div>
			<div class="row">
			<div class="form-horizontal top_well underline" id="atribGroupArea_${'${'}id}">
			</div>
			</div>

</script>
<!-- select comm_code 값을 내포할 템플릿 -->
<script id="analysisOptionTypeCodeTemplate" type="text/x-jquery-tmpl">
    <option value="${'${'}codeName}"> ${'${'}markName} </option>

</script>
<!-- 일반 템플릿 -->
<script id="conditionTemplate" type="text/x-jquery-tmpl">
	    		<div id = "grid_${'${'}id}" style="float: left; width: 33%;">
			    	<div id = "name" style="border: 1px solid white; float: left; width: 30%;">
						<label class="col-xs-10 control-label text-right"> ${'${'}text} </label>
					</div>
					<div id = "col" class="colPopOpen_${'${'}id}" style="border: 1px solid white;  float: left; width: 30%;">
						<ifvm:input type="select" id="simpleTypeCode" names="simpleTypeCode"/>
					</div>
					<div id="search" class="searchPopOpen_${'${'}id}" style="border: 1px solid white;  float: left; width: 33%;">
						<div class="input-group"> <input type="text" id="filter">
						<span style="cursor: pointer" id = "searchbutton_${'${'}id}"class="input-group-addon searchDateFuncBtn" ><i class="fa fa-search"></i></span></div>
					</div>
				</div>
</script>

<!-- 합계 템플릿 -->
<script id="conditionSumTemplate" type="text/x-jquery-tmpl">
    	    	<div id = "grid_${'${'}id}" style="float: left; width: 33%;">
			    	<div id = "name" style="border: 1px solid white; float: left; width: 30%;">
						<label class="col-xs-10 control-label text-right"> ${'${'}text} </label>
					</div>
					<div id = "sumYn" class="sumYn_${'${'}id}" style="border: 1px solid white;  float: left; position: relative; top: 5.5px;">
	                    <ifvm:input type="checkbox" id="sumYn" names="sumYn" title="합계(SUM)" values="colPopOpen_${'${'}id}" />
	                </div>
					<div id = "col" class="colPopOpen_${'${'}id}" style="border: 1px solid white;  float: left; width: 26%;">
						<ifvm:input type="select" id="simpleTypeCode" names="simpleTypeCode"/>
					</div>
					<div id="search" class="searchPopOpen_${'${'}id}" style="border: 1px solid white;  float: left; width: 33%;">
						<div class="input-group"> <input type="text" id="filter">
						<span style="cursor: pointer" id = "searchbutton_${'${'}id}"class="input-group-addon searchDateFuncBtn" ><i class="fa fa-search"></i></span></div>
					</div>
				</div>
</script>

<!-- 날짜 템플릿 -->
<script id="conditionDateTemplate" type="text/x-jquery-tmpl">
	    		<div id = "grid_${'${'}id}" style="float: left; width: 33%;">
			    	<div id = "name" style="border: 1px solid white; float: left; width: 30%;">
						<label class="col-xs-10 control-label text-right"> ${'${'}text} </label>
					</div>
					<div id = "searchDate_${'${'}id}" style="border: 1px solid white;  float: left; width: 64%;">
				        <ifvm:inputNew type="dateTerm" startDto="simpleStartDate_${'${'}id}" endDto="simpleEndDate_${'${'}id}" startId="simpleStartDate_${'${'}id}" endId="simpleEndDate_${'${'}id}" conClass="12"/>
					</div>
				</div>

</script>
	  	
