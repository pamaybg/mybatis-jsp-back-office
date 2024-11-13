<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
function PgmGrid(){
    this.pgmRid = null;
    this.pgmNo = null;
    this.getSearchCond = function() {
        if (typeof ifvGlobal.searchHelp !== 'undefined' && typeof ifvGlobal.searchHelp.searchCond !== 'undefined' ) {
            $.extend(ejGridOption.requestGridData, ifvGlobal.searchHelp.searchCond);
            delete ifvGlobal.searchHelp.searchCond;
        }
    },
    this.init = function() {
        this.getSearchCond();
        $("#grid").ifvsfGrid({
            ejGridOption: ejGridOption
        });
    }
    var _rowSelected = function (args) {
        var data = args.data;
        this.pgmRid = data.rid;
        this.pgmNm = data.pgmNm;
    };

    var ejGridOption = {
        rowSelected: _rowSelected.bind(this),
        serializeGridData: function (data) {
            return data;
        },
        dataUrl: '<ifvm:action name="getPgmPopup"/>',
        columns: [ // '프로그램 번호', '프로그램명', '상태', '최종수정일','수정자', 'rid'
        	{
                field: 'repYn',
                headerText: '<spring:message code="대표여부"/>',
                width: '70px', textAlign : 'center',
                customAttributes: {
                    searchable: true
                }
            },
        	{
                field: 'pgmNo',
                headerText: '<spring:message code="L00087"/>',
                width: '100px', textAlign : 'center',
                customAttributes: {
                    searchable: true
                }
            }, {
                field: 'pgmNm',
                headerText: '<spring:message code="L00088"/>',
                customAttributes: {
                    searchable: true
                }
            }, {
                field: 'pgmStatNm',
                headerText: '<spring:message code="C00125"/>', width: '100px', textAlign : 'center',
            },{
                field: 'modifyBy',
                headerText: '<spring:message code="L00095"/>',
                width: '100px', textAlign : 'center',
            }, {
                field: 'modifyDate',
                headerText: '<spring:message code="L00094"/>',
                width: '100px', textAlign : 'center',
            }, {
                field: 'rid',
                headerText: 'rid',
                visible: false,
            }],
        requestGridData: {
            sidx: 'pgmNo',
        },
        radio: true
    };
}

$(document).ready(function(){
	var pgmGrid = new PgmGrid();
	pgmGrid.init();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
        pgmRid = pgmGrid.pgmRid;
        $("#pgmNm").val(pgmGrid.pgmNm);
        $.fn.ifvmPopupClose();
    });
	
  	//취소 클릭시
    $('#cancelBtn').on('click', function(){
    	$.fn.ifvmPopupClose();
    });
});
</script>

<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="grid" class=""></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn" objCode="pgmPopselectBtn_OBJ">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00123"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="pgmPopcancelBtn_OBJ">
	    <spring:message code="L00124"/>         
	    </button> 
	</div>
</div>

