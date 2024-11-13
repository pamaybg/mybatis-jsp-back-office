<%@page trimDirectiveWhitespaces="true" %>
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
<script>

    var authGroupGrid;
    var rid = '<%= cleanXss(request.getParameter("rid")) %>';
    var empId = '<%= cleanXss(request.getParameter("employeeId")) %>';


    //조직정보 리스트
    function authGroupGrid() {
        var ejGridOption = {
            serializeGridData: function (data) {
                data.rid = rid;
                return data;
            },
            dataUrl: '<ifvm:action name="getAuthGroupListByRidUser"/>',
            columns: [
                {
                    field: 'authGroupName',
                    headerText: '<spring:message code="M01243"/>',
                    resizable: false, textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                },
                /* { name:'authGroupType',			index:'ag.auth_data_group_type',	searchable : true, 		resizable : false }, */
                {
                    field: 'authGroupDesc',
                    headerText: '<spring:message code="권한 그룹 설명"/>',
                    resizable: false, textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                },
                {
                    field: 'modifyDate',
                    headerText: '<spring:message code="수정일자"/>',
                    resizable: false, textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                },
                {
                    field: 'id', headerText: '<spring:message code="ID"/>', visible: false,
                    customAttributes: {
                        searchable: true
                    }
                }
            ],
            requestGridData: {
                sidx: 'ag.modify_date',
                sord: 'desc'
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            tempId: 'ifvGridOriginTemplete'
        };
        authGroupGrid = $("#authGroupGrid").ifvsfGrid({ejGridOption: ejGridOption});
    }

    $(document).ready(function () {
        authGroupGrid();

        //선택 클릭시
        $('#selectBtn').on('click', function () {
            if (authGroupGrid.opt.gridControl.getSelectedRecords().length == 0) {
                alert('<spring:message code="L00117"/>');
            } else {
                var dataArr = authGroupGrid.opt.gridControl.getSelectedRecords();

                $.ifvPostJSON('<ifvm:action name="insertAuthGroupAndEmpId"/>',
                    {
                        empId: empId
                        , ridUser: rid
                        , autGroupId: dataArr[0].id
                    },
                    function (result) {
                        //success
                    }
                );
                authGroupPopupClose();
                //authGroupList(temp.rid, temp2.id);
                authGroupList(rid, empId);
            }

        });

        //취소 클릭시
        $('#cancelBtn').on('click', function () {
            authGroupPopupClose();
        });
    });
</script>

<div id="pop_main_div">
    <div class="pop_inner_wrap">
        <div id="authGroupGrid" class=""></div>
    </div>

    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="selectBtn" objCode="dptEmpNewAuthGroupPopSelect_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="L00123"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="dptEmpNewAuthGroupPopCancel_OBJ">
            <spring:message code="L00124"/>
        </button>
    </div>
</div>
