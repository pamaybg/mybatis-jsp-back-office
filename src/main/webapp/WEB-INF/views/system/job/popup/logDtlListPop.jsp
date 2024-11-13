<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<article class="popup_wrap">
	<div class="content">
		<article class="grid_content">
			<header>
				<h4>로그 상세 목록</h4>
				<ul class="btn_container">
					<li>
						<ifvm:inputNew
						type="button"
						btnType="download"
						text="엑셀 다운로드"
						nuc="true"
						btnFunc="downloadLogDtlExcel" />
					</li>
					<li>
						<ifvm:inputNew
						type="button"
						btnType="search"
						text="재조회"
						nuc="true"
						btnFunc="searchLogDtlList" />
					</li>
				</ul>
			</header>
			<div class="content grid_container" id="logDtlGridCon"></div>
		</article>
	</div>
</article>
<div class="pop_btn_area">
	<ifvm:inputNew
	type="button"
	btnType="cancel"
	text="닫기"
	nuc="true"
	btnFunc="logDtlListPopClose" />
</div>

<script>
//지역변수
var logDtlGrid = null;

makeLogDtlGrid();

//로그 상세 팝업 그리드 생성
function makeLogDtlGrid() {
    var logDtlGridOption = {
       	url: "<ifvm:action name='getLogDtlList'/>",
   		serializeGridData: function(_data) {
   			_data.ridJobLog = gLogRid;
			_data.ridJobMst = gJobRid;
   			return _data;
        },
   	    colNames: [
   			"로그일시",
   			"로그유형",
   			"Step 명",
   			"로그내용",
           ],
   	    colModel: [
   			{
   				name: "logDttm",
   				index: "jld.log_dttm",
   				width: "146",
   				align: "center",
   				formatter: dateFormatter,
				sortable: false,
				resizable: false
   			},
   			{
   				name: "logTypeCd",
   				index: "cc1.mark_name",
   				width: "146",
   				align: "center",
				sortable: false,
				resizable: false
   			},
   			{
   				name: "sbsqntJobNm",
   				index: "jld.sbsqnt_job_nm",
   				width: "146",
   				align: "left",
				sortable: false,
				resizable: false
   			},
   			{
   				name: "logContent",
   				index: "jld.log_content",
   				width: "146",
   				align: "left",
				sortable: false,
				resizable: false
   			}
   	    ],
   	    sortname: "jld.log_dttm",
   	    sortorder: "desc",
   	    rowList: [10],
   	    tempId: "ifvGridTemplete"
   	};
    logDtlGrid = setIfvGrid("logDtlGridCon", logDtlGridOption);
}

//로그 상세 목록 조회
function searchLogDtlList() {
	logDtlGrid.requestData();
}

//엑셀 다운로드
function downloadLogDtlExcel() {
	var url = "<ifvm:action name='downloadLogDtlExcel'/>";
	var colArr = logDtlGrid.jqGridOption.colNames;
	var href = url
		+ "?"
		+ "ridJobLog=" + gLogRid
		+ "&headerList=" + colArr.join();
	qtjs.href(href);
}
</script>