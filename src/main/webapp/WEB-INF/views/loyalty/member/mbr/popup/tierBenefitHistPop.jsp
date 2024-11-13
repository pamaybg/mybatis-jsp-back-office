<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%-- <div class="page_btn_area" >
    <div class="col-xs-7"></div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" id="tierHistDetailPopBtn" text="사유"  objCode=""/> <!-- 필요한가? -->
	</div>
</div> --%>

<div id="tierBenefitHistList" class="white_bg grid_bd0"></div>

<div class="pop_btn_area">
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="closeBtn" objCode="tierBenefitHistClose_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>
<%-- <div id="tierHistDetailPop" class="popup_container"></div> --%>
    
    
<script type="text/javascript">
	var memberRid = mbrRid; // 이전페이지(mbrTierListNew.jsp)에 존재하는 mbrRid값을 가져와 초기화
	var tierBenefitHistList = null; // 등급혜택이력 그리드 내용을 담을 변수
	var recordRid = null;	// 선택한 레코드의 rid
	
	// 등급혜택이력 그리드 함수
	function getTierBenefitHistList() {
		
		var ejGridOption = {
				serializeGridData : function(data){
					data.ridMbr = memberRid;
					return data;
				},
				rowSelected : function(args){
					recordRid = args.data.id;
				},
				recordDoubleClick : function(args){
					recordRid = args.data.id;
				},
				dataUrl : '<ifvm:action name="getTierBenefitHistList"/>',
				columns : [
					 { field : 'payDay', headerText : '제공일자', width: '80', headerTextAlign : 'center', textAlign : 'center' } // , customAttributes : { searchable: true, index : 'payDay' }
					,{ field : 'tierBnftTypeCdNm', headerText : '유형', width: '40', headerTextAlign : 'center', textAlign : 'center', customAttributes : { searchable: true, index : 'cc3.MARK_NAME' } }
					/* ,{ field : 'ofrNo', headerText : '오퍼번호', width: '80', headerTextAlign : 'center', textAlign : 'center', customAttributes : { searchable : true, index: 'lo.OFR_NO' } } */
					,{ field : 'ofrNm', headerText : '오퍼명', width: '230', headerTextAlign : 'center', textAlign : 'left', customAttributes : { searchable : true, index: 'lo.OFR_NM' } }
					,{ field : 'ofrSubTypeNm', headerText : '오퍼 유형', width: '110', headerTextAlign : 'center', textAlign : 'center', customAttributes : { searchable : true, index: 'cc2.MARK_NAME' } }
					,{ field : 'cpnYn', headerText : '쿠폰여부', width: '50', headerTextAlign : 'center', textAlign : 'center', customAttributes : { searchable : true, index: 'lo.CPN_YN'} }
					,{ field : 'amt', headerText : '금액', width: '60', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}' } // , customAttributes :{ searchable : true, index: 'amt' }
					,{ field : 'qty', headerText : '수량', width: '40', headerTextAlign : 'center', textAlign : 'center', format : '{0:n0}' } // , customAttributes :{ searchable : true, index: 'ltb.QTY' }
					/* ,{ field : 'bnftActCycleCdNm', headerText : '주기', width: '40', headerTextAlign : 'center', textAlign : 'center', customAttributes :{ index : 'bnftActCycleCd' } }
					,{ field : 'bnftActRotCycleCdNm', headerText : '반복주기', width: '60', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'bnftActRotCycleCd' } } */
					,{ field : 'combinedBnftActCycleNm', headerText : '주기', width: '80', headerTextAlign : 'center', textAlign : 'center' } // , customAttributes : { index : 'combinedBnftActCycleNm' }
					,{ field : 'tierRid', headerText : 'tierRid', visible : false }
					,{ field : 'rid', headerText : 'rid', visible : false }
				],
				requestGridData : {
					sidx: 'createDate',
					sord: 'desc',
					tempId: 'ifvGridSimplePageTemplete2',
					rows: '10',
					//_search: true/false
				},
				gridDataInit: true ,
				rowList : [10,25,50,100] ,
				radio : false
		};//end ejGridOption
		
		tierBenefitHistList = $('#tierBenefitHistList').ifvsfGrid({ ejGridOption : ejGridOption });
	}//end getTierBenefitHistList

	
	// 팝업 닫기 함수
	function tierBenefitHistPopClose() {
		tierBenefitHistPop._destroy();
	}
	
	
	// 시행
	$(document).ready(function(){
		
		getTierBenefitHistList();
		
		// 닫기 버튼 클릭 시
		$('#closeBtn').on('click', function(){
			tierBenefitHistPopClose();
		});
	});
	
</script>
    