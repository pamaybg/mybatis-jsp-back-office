<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<article class="popup_wrap">
	<div class="content">
		<article class="grid_content">
			<header>
				<h4>실행인수 목록</h4>
			</header>
			<div class="content grid_container" id="pExecParamGridCon"></div>
		</article>
	</div>
</article>
<div class="pop_btn_area">
	<ifvm:inputNew
	type="button"
	btnType="cancel"
	text="닫기"
	nuc="true"
	btnFunc="execParamListPopClose" />
</div>

<script>
//지역변수
var pExecParamGrid = null;

//실행인수 팝업 그리드 생성
function makePExecParamGrid() {
    var pExecParamGridOption = {
   	    colNames: [
   			"인수 명",
   			"인수 값",
   	        "rid"
           ],
   	    colModel: [
   			{
   				name: "paramNm",
   				index: "ljp.param_nm",
   				width: "292",
   				align: "left",
				sortable: false,
				resizable: false
   			},
   			{
   				name: "paramVal",
   				index: "ljp.param_val",
   				width: "292",
   				align: "left",
				sortable: false,
				resizable: false
   			},
   			{
   				name: "rid",
   				index: "ljp.rid",
   				hidden: true
   			}
   	    ],
   	    sortorder: "asc",
   	    rowList: [10],
   	    tempId: "ifvGridTemplete"
   	};
    if(gExecParam !== "") {
    	pExecParamGridOption.datatype = "clientSide";
    	pExecParamGridOption.data = JSON.parse(gExecParam);
    	pExecParamGridOption.sortname = "paranNm";
    } else {
    	pExecParamGridOption.url = "<ifvm:action name='getExecParamList'/>";
    	pExecParamGridOption.serializeGridData = function(data) {
   			data.ridJobMst = gJobRid;
   			return data;
        };
        pExecParamGridOption.sortname = "ljp.param_nm";
    }
    pExecParamGrid = $("#pExecParamGridCon").ifvGrid({jqGridOption: pExecParamGridOption});

    pExecParamGrid.opt.postData= { "page": 1 };
}
</script>