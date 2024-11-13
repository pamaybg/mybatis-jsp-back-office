<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var settlePntUseGrid;

	function getSettlePntUseList() {
		var ejGridOption = {
			//        	ondblClickRow : function(data){
			//        	},
			//         onSelectRow : function (data) {
			//        	},
			serializeGridData : function(data) {
				if ($.fn.ifvmIsNotEmpty(requestitem)) {
					data.item = requestitem;
				}
				return data;
			},
			loadComplete : function(obj) {
			},
			dataUrl : '<ifvm:action name="getSettlePntUseList"/>',
			columns : [ {
				field : 'useDat',
				headerText : '포인트 생성일자',
				headerTextAlign : 'center',
				textAlign : 'center',
				customAttributes : {
					index : 'epua.USE_DAT'
				}
			/* */
			}, {
				field : 'shopNm',
				headerText : '매장명',
				headerTextAlign : 'center',
				textAlign : 'left',
				customAttributes : {
					index : 'epua.SHOP_NAM'
				}
			/* */
// 			}, {
// 				field : 'useGbn',
// 				headerText : '구분',
// 				headerTextAlign : 'center',
// 				customAttributes : {
// 					index : 'epua.USE_GBN'
// 				}
			/* */
			}, {
				field : 'usePnt',
				headerText : '사용포인트',
				headerTextAlign : 'center',
				format : '{0:n0}',
				textAlign : 'right',
				customAttributes : {
					index : 'epua.USE_PNT'
				}
			/* */
			}, {
				field : 'distDivNm',
				headerText : '사용타입',
				headerTextAlign : 'center',
				customAttributes : {
					index : 'c1.mark_name'
				}
			/* */
			}, {
				field : 'execDate',
				headerText : '실행일 ',
				headerTextAlign : 'center',
				textAlign : 'center',
				customAttributes : {
					index : 'epua.EXEC_YYYYMMDD'
				}
			/* */
			} ],
			requestGridData : {
				nd : new Date().getTime(),
				rows : 10,
				sidx : 'epua.USE_DAT',
				sord : 'desc',
				_search : false
			},
			rowList : [ 10, 25, 50, 100 ],
			//         autowidth : true ,
			gridDataInit : false,
			tempId : 'ifvGridOriginTemplete'
		};

		settlePntUseGrid = $("#settlePntUseGrid").ifvsfGrid({
			ejGridOption : ejGridOption
		});
	}

	//공통 조회 조건 목록 설정
	function SearchInit() {
		$.fn.ifvmSetCommonCondList("SearchList", "SETTLE_PNT_02");
	}

	// 공통 조회 호출
	function ListSearch() {
		var rstdDate;
		var rendDate;
		$.fn.ifvmSubmitSearchCondition_NoAllSearch("SearchList", function() {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				for (var i = 0; i < requestitem.length; i++) {
					var getTrNo = requestitem[i].comTgCol
					if (getTrNo == 'CREATE_DATE') {
						rstdDate = new Date(requestitem[i].startDate);
						rendDate = new Date(requestitem[i].endDate);
						break;
					}
				}
				var a = (rendDate.getTime() - rstdDate.getTime())
						/ (1000 * 60 * 60 * 24);
				if (a >= 1) {
					alert('시작날짜와 종료날짜가 같아야 합니다.');
					return;
				}
				settlePntUseGrid.searchGrid({
					item : requestitem
				});
			} else {
				alert('최소 1개의 조회조건을 입력해주세요.');
			}
		});
	}

	$(document).ready(
			function() {
				getSettlePntUseList();

				//공통 조회 조건 목록 설정
				SearchInit();

				//조회
				$('#SearchBtn').on('click', function() {
					ListSearch();
				});

				//초기화
				$("#ListSearchInitBtn").on('click', function() {
					SearchInit();
				});
				$("#excelListBtn").on(
						'click',
						function() {

							$.ifvExcelDn('/loyalty/settle/pntUseExeDown.do',
									'settlePntUseGrid');
						});

			});
</script>

<div class="page-title">
	<h1>
		<spring:message code="M02038" />
		&gt; 일별 포인트 정산(사용)
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="SearchBtn">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="ListSearchInitBtn">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	    <div class="well form-horizontal well_bt5" id="SearchList" >
</div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="excelListBtn">
				<spring:message code="M01218" />
			</button>
		</div>
	</div>
	<div id="settlePntUseGrid" class="white_bg grid_bd0"></div>
</div>
