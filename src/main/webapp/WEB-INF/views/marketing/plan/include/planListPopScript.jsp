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
	 * 마케팅 플랜 디테일 팝업 리스트 스크립트 
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

	//노드 체크 변수
	var fbChk = false;
	var instaChk = false;
	var offerChk = false;
	var targetChk = false;
	var scheduleChk = false;
	var delChk = false;
	var data = null;
	var temp = null;
	//공통 조회 조건 목록 설정
	function planListSearchInit(gridId) {
		$.fn.ifvmSetCommonCondList("planSearchList", "MKTMNG001", gridId);
	}

	// 공통 조회 호출
	function planListSearch() {
		$.fn.ifvmSubmitSearchCondition("planSearchList", function() {
			planListGrid.searchGrid({
				item : requestitem
			});
		});
	}

	//캠페인 목록
	function selectCampaignPlanList() {

		var ejGridOption = {
			rowSelected : function(args) {
				temp = args.data;
				//console.log(data);
				selectChk = true;

			},
			recordDoubleClick : function(args) {
				data = args.data;
				selectBtnf(data);
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
			dataUrl : '<ifvm:action name="selectCampaignPlanList"/>',
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
				field : 'dispNo',
				headerText : '<spring:message code="M02291"/>',
				headerTextAlign : 'center',
				width : '90px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'DISP_NO'
				}
			/*번호 */
			}, {
				field : 'camNm',
				headerText : '<spring:message code="L01093"/>',
				headerTextAlign : 'center',
				width : '220px',
				customAttributes : {
					index : 'CAM_NM'
				}
			/*캠페인명 */
			}, {
				field : 'camTypecd',
				headerText : '<spring:message code="L00155"/>',
				headerTextAlign : 'center',
				width : '80px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'CAM_TYPE_CD'
				}
			/*유형 */
			}, {
				field : 'camStatuscd',
				headerText : '<spring:message code="L00271"/>',
				headerTextAlign : 'center',
				width : '80px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'CAM_STATUS_CD'
				}
			/*상태*/
			}, {
				field : 'camStartdd',
				headerText : '<spring:message code="L00272"/>',
				headerTextAlign : 'center',
				width : '60px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'CAM_START_DD'
				}
			/*시작일*/
			}, {
				field : 'camEnddd',
				headerText : '<spring:message code="L00273"/>',
				headerTextAlign : 'center',
				width : '90px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'CAM_END_DD'
				}
			/*종료일 */
			}, {
				field : 'name',
				headerText : '<spring:message code="Q02848"/>',
				headerTextAlign : 'center',
				width : '90px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'T3.NAME'
				}
			/*생성자 */
			}, {
				field : 'createDate',
				headerText : '<spring:message code="L00041"/>',
				headerTextAlign : 'center',
				width : '100px',
				textAlign : ej.TextAlign.Center,
				customAttributes : {
					index : 'C.CREATE_DATE'
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

	function InitPlan(getType) {

		strType = getType;

		selectCampaignPlanList();

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

	}
	//노드 생성을 위한 그리드 데이터를 전송.
	function selectBtnf(data) {
		if (data == null) {
			if (selectChk == true) {
					data = temp;
					selectChk = false;
					if(data == null){
						alert('<spring:message code="L00066"/>');
					}else{
						planCamNodeData(data);
					}
			} else {
				
				alert('<spring:message code="L00066"/>');
			}
		} else {
			planCamNodeData(data);
		}
	}

	$(document).ready(function() {

		//선택 클릭시
		$('#selectBtn').on('click', function() {
			selectBtnf();
		});

		//취소 클릭시
		$('#cancelBtn').on('click', function() {
			dialog._destroy();
		});
	});
</script>