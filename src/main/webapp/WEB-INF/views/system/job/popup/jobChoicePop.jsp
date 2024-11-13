<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<article class="popup_wrap">
	<div class="content">
		<article class="grid_content">
			<header>
				<h4>Job 목록</h4>
			</header>
			<div class="content grid_container" id="choiceJobGridCon"></div>
		</article>
	</div>
</article>
<div class="pop_btn_area">
	<ifvm:inputNew
	type="button"
	btnType="select"
	text="선택"
	nuc="true"
	btnFunc="selectJob" />
	<ifvm:inputNew
	type="button"
	btnType="cancel"
	text="취소"
	nuc="true"
	btnFunc="jobChoicePopClose" />
</div>

<script>
//지역변수
var choiceJobGrid = null;

makeChoiceJobGrid();

//선택할 Job 그리드 생성
function makeChoiceJobGrid() {
    var choiceJobGridOption = {
    	url: "<ifvm:action name='getChoiceJobList'/>",
    	serializeGridData: function(_data) {
    		_data.ridJobMst = gJobRid;
       	},
	    colNames: [
			"Job",
			"Group",
			"실행 프로그램",
	        "rid"
        ],
	    colModel: [
			{
				name: "jobNm",
				index: "ljm.job_nm",
				width: "181",
				align: "left",
				sortable: false,
				resizable: false
			},
			{
				name: "jobGrp",
				index: "cc1.mark_name",
				width: "181",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "pgmNm",
				index: "ljm.pgm_nm",
				width: "181",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "rid",
				index: "ljm.rid",
				hidden: true
			}
	    ],
	    sortname: "ljm.create_date",
	    sortorder: "desc",
	    rowList: [10],
	    tempId: "ifvSearchGridTemplete"
	};
    choiceJobGrid = setIfvGrid("choiceJobGridCon", choiceJobGridOption);
}

//Job 선택
function selectJob() {
	if($.fn.ifvmIsNotEmpty(choiceJobGrid.getRowDatas())) {
		gSelectedJobRid = choiceJobGrid.getRowDatas().rid;
		$("#targetJobNm").val(choiceJobGrid.getRowDatas().jobNm);
		jobChoicePopClose();
	}
}
</script>