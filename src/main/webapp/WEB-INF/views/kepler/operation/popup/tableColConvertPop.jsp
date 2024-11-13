<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var tableColConvertTargetList;

/**
 * 변경 대상 목록 출력
 * 
 * @author jh.kim
 * @date 2017. 7. 25.
 * @returns
 */
function tableColConvertPop_initList() {
    
    $.ifvSyncPostJSON('<ifvm:action name="getTableColListByType"/>', {
        colTypeCd : convert_beforeType,
        tableId : tableId
    }, function(result) {
        
        var jqGridOption = {
            loadComplete : function(obj) {
                // popup 높이 맞추기
                new ifvm.PopupHeight({
                    popupDivId : 'dialog',
                    contentsId : 'dialogPopupWrap'
                });
            },
            ondblClickRow : function(id) {
            },
            data : result,
            datatype : 'clientSide',
            colNames: [
                  '<spring:message code="M01164"/>'
                , '<spring:message code="M01573"/>'
                , '<spring:message code="M01571" />'
                , '<spring:message code="M01572"/>'
                , 'colId'
            ],
            colModel: [
                  {name : 'colNm',      index : '', resizable : false}
                , {name : 'dpNm',       index : '', resizable : false}
                , {name : 'dataTypeCd', index : '', resizable : false}
                , {name : 'colTypeCd',  index : '', resizable : false}
                , {name : 'colId',      index : '', hidden : true}
            ],
            rowList : [100000],
            multiselect : true,
            tempId : 'ifvGridSimpleTemplete'
        };

        tableColConvertTargetList = $("#tableColConvertTargetList").ifvGrid2({
            jqGridOption : jqGridOption
        });
    });
}

/**
 * col type cd 값을 일괄 변경 한다. 
 * 
 * @author jh.kim
 * @date 2017. 7. 26
 * @returns
 */
function tableColConvertPop_convert() {

    var arryColIds = [];
    var selectRows = tableColConvertTargetList.getCheckedGridData();

    // 선택 목록이 없음. 
    if (selectRows.length == 0) {
        alert('<spring:message code="M00108"/>');
        return false;
    }
    
    // colId 추가 
    for (var i = 0; i < selectRows.length; i++) {
        arryColIds.push(selectRows[i].colId);
    }

    // 수정 
    $.ifvSyncPostJSON('<ifvm:action name="editTableColsType"/>', {
          colTypeCd : convert_afterType
        , tblId : tableId
        , colIds : arryColIds
    }, function(result) {

        // 성공 메세지 출력 
        if ($.fn.ifvmIsNotEmpty(result) == true) {
            if (result.success == true) {
                alert('<spring:message code="M00429"/>');
            }
        }
        
        // 팝업 그리드 재조회
        tableColConvertPop_initList();
        
        // 상세화면 그리드 재조회
        getTableColList();
    });
}

$(document).ready(function() {

    // 변경대상 목록 출력
    tableColConvertPop_initList();

    // 닫기버튼
    $("#tableColConvertPopCloseBtn").on('click', function() {
        tableMstPopClose();
    });
    
    // 변환버튼
    $("#convertBtn").on('click', function() {
        tableColConvertPop_convert();
    });

});

</script>

<div id="dialogPopupWrap">
    <div class="page_btn_area">
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button id="convertBtn" class="btn btn-sm">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M02246"/></button>
        </div>
    </div>
    
    <div class="pop_inner_wrap" style="height: 500px">
        <div id="tableColConvertTargetList"></div>
    </div>
    
    <div class="pop_btn_area" style="height:60px;">
        <!-- 닫기 버튼 -->
        <button class="btn btn-sm btn_lightGray2" id="tableColConvertPopCloseBtn">         
            <spring:message code="M00441"/>
        </button>
    </div>
</div>