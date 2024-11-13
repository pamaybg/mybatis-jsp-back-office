<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/x-jsrender" id="ynTemplate">
	{{if promYn == 1 }}
		Y
	{{else}}
		N
	{{/if}}
</script>

<script>
	/*
	 * 마케팅 플랜 리스트 스크립트 
	 * 
	 * @date 2020. 06. 11.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	var strType = '';

	var planListGrid = null;
	var selectChk = false;

	var plan = {
		id : "",
		selRow : ""
	};


	//공통 조회 조건 목록 설정
	function planListSearchInit(gridId) {
		$.fn.ifvmSetCommonCondList("planSearchList", "PGM_M_012", gridId);
	}

	// 공통 조회 호출
	function planListSearch() {
		$.fn.ifvmSubmitSearchCondition("planSearchList", function() {
			planListGrid.searchGrid({
				item : requestitem
			});
		});
	}

	//캠페인 워크플로우 화면 이동
	function goPlanWorkflow(id) {
		var url = '<ifvm:url name="planDetail"/>?type=MKT&id=' + id;

		qtjs.href(url);
	};

	//캠페인 목록
	function getPlanList() {

		var ejGridOption = {
			rowSelected : function(args) {
				//selectChk = true;

			},
			recordDoubleClick : function(args) {
				var data = args.data;
				goPlanWorkflow(data.id);

			},
			serializeGridData : function(data) {
				if ($.fn.ifvmIsNotEmpty(requestitem)) {
					data.item = requestitem;
				}
				if ($.fn.ifvmIsNotEmpty(strType)) {
					data.type = strType;
				}
				return data;
			},
			dataUrl : '<ifvm:action name="getPlanList"/>',
			columns : [ {
				field : 'id',
				headerText : 'id',
				visible : false,
				customAttributes : {
					searchable : false,
					index : 'ID'
				}
			/*id*/
			}, {
				field : 'planNo',
				headerText : '<spring:message code="M02291"/>',
				headerTextAlign : 'center',
				width : '90px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'PLAN_NO'
				}
			/*번호 */
			}, {
				field : 'planNm',
				headerText : '<spring:message code="M02292"/>',
				headerTextAlign : 'center',
				width : '220px',
				customAttributes : {
					index : 'PLAN_NM'
				}
			/*플랜명 */
			}, {
				field : 'planPrps',
				headerText : '<spring:message code="M00756"/>',
				headerTextAlign : 'center',
				width : '80px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'PLAN_PRPS_CD'
				}
			/*목적 */
			}, {
				field : 'planStart',
				headerText : '<spring:message code="M01330"/>',
				headerTextAlign : 'center',
				width : '80px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'PLAN_START_DT'
				}
			/* 시작일*/
			}, {
				field : 'planEnd',
				headerText : '<spring:message code="M01331"/>',
				headerTextAlign : 'center',
				width : '60px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'PLAN_END_DT'
				}
			/*종료일*/
			}, {
				field : 'planDesc',
				headerText : '<spring:message code="M02777"/>',
				headerTextAlign : 'center',
				width : '90px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'PLAN_DESC'
				}
			/*비고 */
			}, {
				field : 'name',
				headerText : '<spring:message code="Q02848"/>',
				headerTextAlign : 'center',
				width : '90px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'NAME'
				}
			/*생성자 */
			}, {
				field : 'createDate',
				headerText : '<spring:message code="L00041"/>',
				headerTextAlign : 'center',
				width : '100px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'T1.CREATE_DATE'
				}
			/*생성일 */
			},

			],
			requestGridData : {

				sidx : 'createDate',
				sord : 'desc',
			},
			rowList : [ 10, 25, 50, 100 ],
			radio : true,
			tempId : 'ifvGridSimplePageTemplete'
		};
		planListGrid = $("#planListGrid").ifvsfGrid({
			ejGridOption : ejGridOption
		});

		if (plan.selRow != "") {
			$("#gridIdplanListGrid").setSelection(plan.selRow, true);
			plan.selRow = "";
		}
	}

	//삭제버튼
	function setPlanRemove() {

		var dataList = planListGrid.opt.gridControl.getSelectedRecords();
		if (dataList.length == 0) {
			alert('<spring:message code="M01051"/>');
		} else {
			var data = dataList[0];
			var id = data.id;
			if (confirm('<spring:message code="M02305" />')) {

				var sendId = null;
				$(planListGrid.opt.gridControl.getSelectedRecords()).each(
						function(index, item) {
							sendId = item.id;
						});
				//마케팅 플랜 삭제
				$.ifvSyncPostJSON('<ifvm:action name="removePlan"/>', {
					id : sendId,
				}, function(result) {
					alert('<spring:message code="M01049"/>');
				});
				getPlanList();

			}
		}
	}
	//그리드 -> 엑셀 다운로드
	function setPlanExcelExport() {
		$.ifvExcelDn('<ifvm:action name="getPlanListExport"/>','planListGrid');
	}

	function InitPlan(getType) {

		strType = getType;

		getPlanList();

		// 공통 조회 조건 목록 설정
		planListSearchInit();

		// 조회
		$('#planListSearchBtn').on('click', function() {
			planListSearch();
		});

		// 초기화
		$("#planListSearchInitBtn").on('click', function() {
			planListSearchInit('planListGrid');
		});

		// 신규 클릭시
		$('#planNewBtn').on('click', function() {
			qtjs.href('<ifvm:url name="planDetail"/>');
		});

		// 삭제
		$('#planRemoveBtn').on('click', function() {
			setPlanRemove();
		});

		//그리드 -> 엑셀 다운로드
		$('#planExcelExportBtn').on('click', function() {
			setPlanExcelExport();
		});

	}
</script>