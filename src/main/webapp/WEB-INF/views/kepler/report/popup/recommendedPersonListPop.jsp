<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<%-- 그리드 영역 --%>
<div>
	<br>
    <div class="page_btn_area" >
		<!-- 추천한 사람들 목록 -->
        <div class="col-xs-7">
            <span><spring:message code="L00930"/></span>
        </div>
    </div>
</div>

<!-- 그리드 리스트 컨테이너 -->
<div id="recommPersonListContainer" class="white_bg grid_bd0"></div>

<div class="pop_btn_area">
	<button id="btnClose" class="btn btn-sm btn_gray">
		<spring:message code="L01781"/>
	</button>
</div>

<script type="text/x-jsrender" id="custNmTemplate">
	{{if custStatCdNm != null}}
		{{if custStatCdNm == '활성'}}
			{{:custNm}}		
		{{/if}}
		{{if custStatCdNm != '활성'}}
			{{:custStatCdNm}}
		{{/if}}	
	{{/if}}
</script>
<script type="text/x-jsrender" id="mbrNoTemplate">
	<span style="text-decoration:underline; color:#1266FF;">{{:mbrNo}}</span>
</script>


<script type="text/javascript">
	var rcmmdNo = '<%= cleanXss(request.getParameter("rcmmdNo")) %>';
	var startDt = '<%= cleanXss(request.getParameter("startDt")) %>';
	var endDt = '<%= cleanXss(request.getParameter("endDt")) %>';
	var recommPersonListObj = null;
	
	function getRecommendedPersonList(){
		var ejGridOption = {
		    	serializeGridData : function(data) {
		    		data.rcmmdNo = rcmmdNo;
		    		data.startDt = startDt;
		    		data.endDt = endDt;
		    		return data;
				},
				recordClick: function(args){
					if(args.columnName == '회원번호') {
						// 회원상세페이지로 이동
						var ridMbr = args.data.recommendedPersonRid;
						var custTypeCd = args.data.custTypeCd;
						goMbrDetail(ridMbr,custTypeCd);
						closePopup();
					}
				},
		       	dataUrl: '<ifvm:action name="getRecommendedPersonList"/>',
                columns: [
               	  	  { field: 'webId', headerText: '웹ID', width: '100px', textAlign : 'left', customAttributes: { index: 'webId' } } 
	  	        	, { field: 'mbrNo', headerText: '회원번호', width: '60px', textAlign : 'center', customAttributes: { searchable: true, index: 'mbrNo'}, template: '#mbrNoTemplate' }  
	  	        	, { field: 'custNm', headerText: '회원명', width: '60px', textAlign : 'center', customAttributes: { index: 'custNm' }, template: '#custNmTemplate' }
	  	        	, { field: 'hhp', headerText: '휴대폰번호', width: '60px', textAlign : 'left', customAttributes: { index: 'hhp' } }
	  		      	, { field: 'regDate', headerText: '등록일자', width: '60px', textAlign : 'center' }
	  		      	, { field: 'recommendedPersonRid', headerText: 'rid', visible: false }
	  		      	, { field: 'custStatCd', headerText: 'custStatCd', visible: false }
	  		      	, { field: 'custStatCdNm', headerText: 'custStatCdNm', visible: false }
	  		      	, { field: 'custTypeCd', headerText: 'custTypeCd', visible: false }
                ],
                requestGridData: {
                    sidx: '5',
                    sord: 'desc'
                },
                gridDataInit: true,
                radio: true,
                tempId: 'ifvGridSimplePageTemplete'
	    };
		recommPersonListObj = $("#recommPersonListContainer").ifvsfGrid({ ejGridOption : ejGridOption });
	}// getRecommendedPersonList
	
	function closePopup(){
		popupContainer._destroy();
	}
	
	//고객 상세 이동
	function goMbrDetail(rid,custTypeCd) {
	    if(custTypeCd == 'C'){
	        $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true); //개인정보 조회 이력남기기(법인)
	        qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + rid);
	    } else if(custTypeCd == 'I' || custTypeCd == 'E'|| custTypeCd == 'D'|| custTypeCd == 'O'|| custTypeCd == 'X') {
	        $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true); //개인정보 조회 이력남기기(개인/임직원)
	        qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + rid); 
	    }
	}
	

	$(document).ready(function() {
		getRecommendedPersonList();
		
		$('#btnClose').on("click", function(){
			closePopup();
		});
	});
	
</script>

