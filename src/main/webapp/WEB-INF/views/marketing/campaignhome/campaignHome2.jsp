<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>

var testTable = null;

function testTableSetting(){
	var jqGridOption = {
		onSelectCell: function(data) {
		},
		afterEditCell: function (rowid, cellname, value, iRow, iCol) {
		},
        datatype : 'clientSide',
        colNames:[ '시작일자',
                   '시작시',
                   '시작분',
                   '종료일자',
                   '종료시',
                   '종료분',
                   'TASK',
                   '업무유형',
        ],
        colModel:[
            { name:'startdate', index:'', resizable : false, sortable : false, editable:true },
            { name:'starthour', index:'', resizable : false, sortable : false, editable:true },
            { name:'startmin', index:'', resizable : false, sortable : false, editable:true },
            { name:'enddate', index:'', resizable : false, sortable : false, editable:true },
            { name:'endhour', index:'', resizable : false, sortable : false, editable:true },
            { name:'endmin', index:'', resizable : false, sortable : false, editable:true },
            { name:'task', index:'', resizable : false, sortable : false, editable:true, edittype:'select', editoptions:{value: "test1:test1; test2:test2; test3:test3"}},
            { name:'worktype', index:'', resizable : false, sortable : false, editable:true, edittype:'select', editoptions:{value: "test4:test4; test5:test5; test6:test6"}},
        ],
        rowList : [100000],
        tempId : 'ifvOnlyGridTemplate',
        cellsubmit:'clientArray',
        editurl:'clientArray'
    };
	testTable = $("#testTable").ifvGrid({ jqGridOption : jqGridOption });
	
	
};

function addRowTest() {
	testTable.addLocalTr();	
}

$(document).ready(function() {
	testTableSetting();
});

function testSave() {
	var submitObj = progList.getRowData;
	submitObj.forEach(function(item, index) {
		//validation 설정필요
	});
}

</script>

<div class="page-title">
	<h1>
		editable grid test
	</h1>
</div>

<div>
    <div class="page_btn_area">
    	<div class="col-sm-7">
    		<span><spring:message code="I02035"/></span>
    	</div>
    	<div class="col-sm-5 searchbtn_r">
    		<ifvm:inputNew type="button" className="authCretBtn" btnFunc="addRowTest()" text="I00887" btnType="plus"/>
    		<ifvm:inputNew type="button" className="authDelBtn" btnFunc="delRowTest()" text="I00888" btnType="minus"/>
    		<ifvm:inputNew type="button" btnFunc="testSave()" text="저장" btnType="save" nuc="true"/>
    	</div>
    </div>
    <div id="testTable" class="grid_bd0"></div>
</div>