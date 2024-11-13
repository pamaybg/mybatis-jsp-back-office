<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="pgmListGrid"></div></div> <!-- loyaltyListGrid -->

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnPgmSelect" objCode="loyaltyListPopSelect_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="closePgmListPop" objCode="loyaltyListPopClose_OBJ">
		<spring:message code="M00441" />
	</button>
</div>


<script type="text/javascript"> // loyaltyPgmRid loyaltyPgmNm
	var pgmList = null;
	var pgmRid = null;  // 프로그램 rid(rid)
	var pgmNo = null;	// 프로그램 번호(rid_opr)
	var pgmNm = null;   // 프로그램명()
		
	// 로열티 프로그램 리스트 보기팝업 화면 생성 함수
	function getPgmListSearch() {
		
		var ejGridOption = {
				serializeGridData : function(data) {	
					if ($.fn.ifvmIsNotEmpty(requestitem)) {
						data.item = requestitem;
					}
					//alert('data 얻음');
					return data;
				},
				rowSelected : function (args) {
					pgmRid = args.data.rid;
					pgmNo = args.data.pgmNo;
					pgmNm = args.data.pgmNm;
			    },
			    recordDoubleClick: function(args){
			    	pgmRid = args.data.rid;
					pgmNo = args.data.pgmNo;
					pgmNm = args.data.pgmNm;
					
			    	$('#loyaltyPgmRid').val(pgmRid); // 상위 창에 있는 로열티프로그램 필드(#loyaltyPgmRid) 초기화
			        $('#loyaltyPgmNm').val(pgmNm);   // 상위 창에 있는 로열티프로그램 필드(#loyaltyPgm) 초기화
			        $('#loyaltyPgmNo').val(pgmNo);   // 상위 창에 있는 로열티프로그램 필드(#loyaltyPgmNo) 초기화
			        // 상위 창에 있는 팝업창 컨테이너 닫기
			        loyaltyPopContainer._destroy();
			    },
			    dataUrl: '<ifvm:action name="getPgmPopup"/>',
		        columns: [ // 프로그램번호, 프로그램명, 주관사, 상태, 수정자, 수정일, rid 
		             { field: 'pgmNo',headerText: '<spring:message code="L00087"/>', textAlign : 'center',customAttributes: {searchable: true} }
		            ,{ field: 'pgmNm',headerText: '<spring:message code="L00088"/>',textAlign : 'center',customAttributes: {searchable: true} }
		            ,{ field: 'chnlNm', headerText: '<spring:message code="L00089"/>',textAlign : 'center' }
		            ,{ field: 'pgmStatNm',headerText: '<spring:message code="L00090"/>', textAlign : 'center', customAttributes: { index: 'pgmStat'} }
		            ,{ field: 'modifyBy', headerText: '<spring:message code="L00095"/>', textAlign : 'center', visible: false, }
		            ,{ field: 'modifyDate', headerText: '<spring:message code="L00094"/>', textAlign : 'center', visible: false}
		            ,{ field: 'rid', headerText: 'rid', visible: false}
		        ],
		        requestGridData: {
		            sidx: 'pgmNo'
		        },
		        radio: true
		        
	      };//end ejGridOption
	      
	      pgmList = $("#pgmListGrid").ifvsfGrid({ejGridOption: ejGridOption});
	};// end getPgmListSearch
	
	
	$(document).ready(function() {
		getPgmListSearch();

		// 선택 버튼 누를 때
		$("#btnPgmSelect").click(function() {
			if(pgmRid == null) {
				alert("목록을 선택하세요.");
			} else {
				$('#loyaltyPgmRid').val(pgmRid); // 상위 창에 있는 로열티프로그램 필드(#loyaltyPgmRid) 초기화
		        $('#loyaltyPgmNm').val(pgmNm);   // 상위 창에 있는 로열티프로그램 필드(#loyaltyPgm) 초기화
		        $('#loyaltyPgmNo').val(pgmNo);   // 상위 창에 있는 로열티프로그램 필드(#loyaltyPgmNo) 초기화
		        // 상위 창에 있는 팝업창 컨테이너 닫기
		        loyaltyPopContainer._destroy();
			}
		});
		
		// 닫기 버튼 누를 때
		$("#closePgmListPop").click(function() {
			if(pgmRid != null) {
				// 프로그램 rid, 번호, 이름을 다시 비우기
				pgmRid = null;  
				pgmNo = null;
				pgmNm = null;
			}
			// 팝업창 닫기
			loyaltyPopContainer._destroy();
		});
		
	});
</script>