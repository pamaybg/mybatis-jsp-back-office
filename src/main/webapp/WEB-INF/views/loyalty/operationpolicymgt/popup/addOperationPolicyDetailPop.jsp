<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
	#loyaltyPgm { width: 130px; }
</style>

<!-- 정책속성값 신규 추가 페이지 인 경우: mgRid 를 필요로 함 -->
<!-- 세부속성 신규 추가 페이지인 경우 : mgRid, sg1Rid 를 필요로 함 -->

<div class="form-horizontal underline top_well" id="oprPlcyDetailAddForm">	
<br>
	<div class="row">
		<div class="col-xs-11">
			<!-- 속성명  --> <!-- attrCd값이 여기에 담겨서 markName으로 표시되어지게 된다 => 그래서 attrNm처럼 보이게 됨 -->
			<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="속성명"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="attrCd" names="attrCd" dto="attrCd" required="true"/>
			</div>
			<!-- 단일값여부 -->	
			<label class="col-xs-2 control-label"><spring:message code="단일값여부"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="singleValYn" names="singleValYn" dto="singleValYn" required="true"/>
			</div>
			<!-- 사용여부 -->
			<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="사용여부"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="useYn" names="useYn" dto="useYn" required="true"/>
				<!-- 히든 필드 -->
				<ifvm:inputNew type="hidden" id="parRid" names="parRid" dto="parRid"/> <!-- 상위속성값 -->
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-11">
			<!-- 데이터유형 -->
			<label class="col-xs-2 control-label"><span class="asterisk"></span><spring:message code="데이터유형"/></label>
			<div class="col-xs-2 control_content">
				    <ifvm:inputNew type="select" id="dataType" names="dataType" dto="dataType" required="true" conClass="12"/>
			</div>
			<!-- 값 ( markNm 필드 | dataVal 필드 ) -->
			<label class="col-xs-2 control-label"><span class="asterisk"></span><spring:message code="값"/></label>
			<div class="col-xs-3 control_content" style="padding-left:10px;">
					<!-- 공통코드의 MarkName 필드(조회팝업버튼) -->
					<div class="input-group">
					<ifvm:input type="text" id="markNm" readonly="true" />
					<span class="input-group-addon" id="oprPlcyCommCodeSearchBtn">
						<a id="searchLink"><i class="fa fa-search"></i></a>
					</span>
					</div>
			</div>
			<div class="col-xs-3 control_content" style="padding-right:10px;">
				        <ifvm:input type="text" id="dataVal" names="dataVal" readonly="true"/>
                        <ifvm:inputNew type="hidden" id="groupCd"/> <!-- 공통코드 선택 시 해당하는 그룹코드를 담는 hidden 필드 -->
                        <ifvm:input type="text" id="dataValT" names="dataVal" readonly="true"/>
                        <div id="effLabel" style="width: 170px;"><ifvm:inputNew type="date" dto="dataValD" id="dataValD"  /></div>
            </div>            			
		</div>
	</div>
	
	<div class="row qt_border"></div>
</div><!-- end oprPlcyDetailAddForm -->

<div class="pop_btn_area">
	<!-- 저장 버튼 -->
	<button class="btn btn-sm btn_gray" id="saveOprPlcyDetailBtn" objCode="addOperationPolicyDetailSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<!-- 닫기 버튼 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="closeThisPopBtn" objCode="addOperationPolicyDetailClose_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<div id="attrSearchPopContainer" class="popup_container"></div>



<script type="text/javascript">
	
	//준비
	var data = null;
	//var rid = null;
	var ridOpr = null;   // 운영정책코드
	var parRid = null;   // 상위코드
	
	var attrCd = null;   // 속성명 필드에 들어갈 속성값(attrCd)
	var attrCdNm = null; // 속성코드값에 대응하는 속성명
	var groupCd = null;  // 그룹코드
	var dataType = null; // 데이터타입
	var dataVal = null;  // 데이터값(값)
	var useYn = null;    // 사용여부
	var contents = null; // 설명 : 초기 자동 저장디폴트값으로는 "정책명+값+속성명" 으로 들어가게 할것
	var singleValYn = null; // 단일여부값 보내주기
	
	// 단일값여부 점검한 결과의 true/false에 대한 변수
	var flag = null; 
	
	// 입력 폼 유효성 검사 
	function validateForm() {
		// 1차 검사: form 의 필드들이 모두 적절한 상태인지 확인
		if(    ( $('#attrCd').val()       != null   &&   $('#attrCd').val()       != '' )
			&& ( $('#dataType').val()     != null   &&   $('#dataType').val()     != '' )
			&& ( $('#useYn').val()        != null   &&   $('#useYn').val()        != '' )
			&& ( $('#dataVal').val()      != null   &&   $('#dataVal').val()      != '' )){
			// groupCd는 Null 이 가능하기 때문에(데이터타입이 'TEXT'일 때), 유효성점검에 포함하지 않는다.
																							   
			return true;
		} else {
			return false;
		}
	}//end validateForm
	
	// 단일값 규칙 위배 체크 함수(신규 추가 시)
	function checkAttrCdSingleValYnForInsert() {
		var url = '<ifvm:action name="checkAttrCdSingleValYnForInsert"/>';  // url
		// 원래 필드객체의값을 서버로보내줄통에 담는작업은 실제저장시행단계에서 해줬는데, 본 작업은 그보다 이전에 수행되므로 attrCd가 비어있고, 그래서 손수 담아준다
		attrCd = $('#attrCd').val();
		singleValYn = $('#singleValYn').val();
		
		var varData = {
			ridOpr: ridOpr,
			parRid: parRid,
			attrCd: attrCd,
			singleValYn: singleValYn 
		};
		
		// ifv방식으로 서버와 통신(POST방식으로 전송, JSON형태 이용)
		$.ifvSyncPostJSON(url, varData
		,function(result) { // StatusResDto의 setSuccess가 true일 경우
			flag = true;
		},function(result) { // StatusResDto의 setSuccess가 false일 경우
			if(result.message != null) {
				alert(result.message);
			} else { // 메세지도 없으면 그냥 실패 메세지 표시
				alert('<spring:message code="처리 실패"/>'); 
			}
			flag = false;
		});
	}//end checkAttrCdSingleValYnForInsert
	
	
	// 실제 저장 수행
	function executeSaveOprPlcyDetail() {
		var url = '<ifvm:action name="addOperationPolicyDetail"/>';
	    //parRid = $('#parRid').val(); // 변수 parRid엔 이미 parRid가 담겨있긴 하지만, #parRid엘리먼트에 담겨있는 값으로 한번더 담아주었다 => null이 아니라 ''이 담겨 들어가게 되서, 인풋객체내용말고 그냥 변수에 있던 내용으로 넣어주었음.     
	    attrCd = $('#attrCd').val();
	    dataType = $('#dataType').val();
	    useYn = $('#useYn').val();
	
	    if($('#groupCd').val() == '' || $('#groupCd').val() == null) {
	    	groupCd = null;
	    } else {
	    	groupCd = $('#groupCd').val();	
	    }
	    singleValYn = $('#singleValYn').val();
	    
	    var attrCdObj = document.getElementById("attrCd");
	    var attrCdText = attrCdObj.options[attrCdObj.selectedIndex].text;
	    attrCdNm = attrCdText; // 속성명(한글로된)을 얻어 초기화했다
	    
	    // 신규저장 시
	    if(sgFlag == 'sg1') {
	    	if($('#dataType').val() == 'CODE') {
	    		contents = plcyCd + " " + attrCdNm + " " + $('#markNm').val();
	    	} else if($('#dataType').val() == 'TEXT' || $('#dataType').val() == 'CALEN') {
	    		contents = plcyCd + " " + dataVal + attrCdNm;	
	    	}
	    	
	    } else if(sgFlag == 'sg2') {
	    	// 전역에 있던 '운영정책명 변수: plcyCd'를 합쳐서 contents를 완성한다
		    if(    ( $('#dataType').val() == 'CONTS' && $('#attrCd').val() == '10' )
		    	|| ( $('#dataType').val() == 'CODE') 									) 
		    { // '공통코드/컨텐츠'경우일 때는 dataVal대신 markNm필드내용을 contents변수에 더한다.
		    	contents = plcyCd + " " + attrCdNm + " " + $('#markNm').val();
		    } else if($('#dataType').val() == 'TEXT' || $('#dataType').val() == 'CALEN' ) { // 텍스트/시간(Time)일 경우
		    	contents = plcyCd + " " + dataVal + attrCdNm;
		    }
	    }
	    
		// 서버로 보내줄 데이터를 담는 객체 varData 선언
		var varData = {
				ridOpr   : ridOpr,
				parRid   : parRid,
				attrCd   : attrCd,
				dataType : dataType,
				useYn    : useYn,
				dataVal  : dataVal,
				groupCd  : groupCd,
				contents : contents,
				singleValYn : singleValYn
		}; 
		
		// ifv방식으로 서버와 통신(POST방식으로 전송, JSON형태 이용)
		$.ifvSyncPostJSON(url, varData, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) { 
				alert('<spring:message code="C00094"/>'); // 저장되었습니다
				// 등록 팝업창 닫기
				addPopClose();
			}
		}, function(result) { // 실패했을 경우
			if (result.message != null) // 메세지 있으면 메세지 표사
				alert('error: '+result.message);
			else						// 메세지도 없으면 그냥 실패 메세지 표시
				alert('<spring:message code="M02248"/>');
		});
		
		// 새로고침
		if(sgFlag == 'sg1') {
			subGrid1List._doAjax();
			// 한 그리드 리스트를 새로고침해주면, 그 그리드리스트의 하위 그리드리스트 역시 (새로고침격으로)초기화 해주어야 하므로 초기상태 그리드로 만들어준다.
			callSubGrid2List(null, null);
			//sg1ClickedRecord.click();
		} else if(sgFlag == 'sg2') {
			subGrid2List._doAjax();
		}
	}//end executeSaveOprPlcyDetail
	
	
	// 저장 요청 수행
	function saveOprPlcyDetail() {
	   dataVal = $('#dataVal').val();
	   dataValT = $('#dataValT').val();
	   dataValD = $('#dataValD').val();

	   if(dataVal == '' ){
           $('#dataVal').attr('readonly',false);
	        if(dataValT != ''){
	            $('#dataVal').val(dataValT);
	            dataVal = $('#dataVal').val();
	         } else if (dataValD != ''){
	             $('#dataVal').val(dataValD)
	             dataVal = $('#dataVal').val();
	         }
	           $('#dataVal').attr('readonly',true);
	    }     
	        
		var validation = validateForm();     // 유효성 검사 : 결과로 true/false
		
		if(!validation) {					 // 유효성 검사 비통과
			alert('필수항목들을 입력해주세요');	
		} else {
			checkAttrCdSingleValYnForInsert(); // 단일값여부 체크 함수에 의해, 전역변수 flag가 초기화 되어짐.
			
			if(flag) {						 // 단일값여부 규칙에 위배되지 않을 경우
				executeSaveOprPlcyDetail();	
			} else {						 // 단일값여부 규칙에 위배될 경우
				return;
			} 
		}
	}//end saveOprPlcyDetail
		
	
	// 정책 속성코드 찾기 팝업 실행
 	function oprPlcyCommCodeSearchPop() {
 	    $.fn.ifvmSearchHelpOpen(null, null, 'attrSearchPopContainer', '<ifvm:url name="commCodeListNew"/>', '공통코드 찾기');	 
 	}
	
	// 컨텐츠 목록 팝업 함수
 	function openContentPop() {
		$('#commonPopContainer').ifvsfPopup({
			enableModal: true,
			enableResize: false,
			contentUrl: '<ifvm:url name="contentListNewPop"/>',
			contentType: 'ajax',
			title: '컨텐츠 목록',
			width: '1200px',
			close: 'closeContentPopup'
		});
	}//end openContentPop
	
	   // CALENDAR 생성
    function createCalenDar() {
        var dataValD = $("#dataValD");
        dataValD.ifvDateChecker({ 
            
        });
    }
	
	// 데이터유형이 텍스트 일때의 필드처리 
	function refreshWhenDataTypeText(){
		$('#dataVal').val(null);
		$('#dataVal').attr('readonly',false);
        $("#dataValT").val(null);
        $("#dataValD").val(null);
		$('#markNm').val(null);
		$('#markNm').attr('readonly',false);
		$('#markNm').attr('disabled',true);
		$('#groupCd').val(null);
	}
	   // 데이터유형이 캘린더 일때의 필드처리 
    function refreshWhenDataTypeCalendar(){
        $('#dataVal').val(null);
        $('#dataVal').attr('readonly',true);
        $("#dataValT").val(null);
        $('#markNm').val(null);
        $('#markNm').attr('readonly',false);
        $('#markNm').attr('disabled',true);
        $('#groupCd').val(null);
    }
	// 데이터유형이 공통코드/컨텐츠 일때의 필드처리
	function refreshWhenCodeOrContent(){
		$('#dataVal').val(null);		      		
		$('#dataVal').attr('readonly',true);
        $("#dataValT").val(null);
        $("#dataValD").val(null);
		$('#markNm').val(null);
		$('#markNm').attr('disabled',false);
		$('#markNm').attr('readonly',true);
		$('#groupCd').val(null);
	}
	
	
	// 시행
	$(document).ready(function() {
	    createCalenDar();
	    $('#dataValD').hide();
	    $('#dataValT').hide();
	    $('.input').hide();

        
		// 넘겨받아온  ridOpr을 담은 data를 가져와 여기에 담고 초기화한다.
		data = ifvGlobal.searchHelp.field; // 현페이지를호출한 이전함수가보내준 data객체를 부른다 // [질문] 왜 원래위치인 저장함수안에서 선언되어 있었을땐, 데이터타입을 code로 해서 인서트하면 ridOpr이 왜 상실되었었지?
		ridOpr = data.ridOpr;  
		parRid = data.parRid;
		$("#parRid").val(parRid);  // 본 화면의 hidden객체 #parRid에 이전 단에서 넘어온 parRid값을 초기화해주기
		
		// 공통코드 연동
		// '정책속성값'그리드 인 경우 / '세부사항'그리드 인 경우 에 따라 select박스에서 '컨텐츠'부분 표시 여부를 가른다.
		if(sgFlag == 'sg1') {
			$.fn.ifvmSetSelectOptionCommCode("attrCd", "LOY_OPR_PLCY_ATTR_CD", null, null, true); 		 // 속성명 필드에 공통코드 연결
			$("#attrCd option[value='10']").hide();
	        $("#attrCd option[value='11']").hide();
	        $("#attrCd option[value='AVR']").hide();
	        //$("#attrCd option[value='12']").show(); // '속성명: 사용여부' 보인다
			$.fn.ifvmSetSelectOptionCommCode("dataType", "LOY_OPR_PLCY_DATA_TYPE_CD", null, null, true); // 데이터유형 필드에 공통코드 연결 (공통코드 단의 markname이 나오도록 되어진다/하지만 보이기만 그럴뿐 실제로는 code값이 배정되어 있는 것이다 : CODE/TEXT)
			$("#dataType option[value='CONTS']").hide();
		} else if(sgFlag == 'sg2') {
			$.fn.ifvmSetSelectOptionCommCode("attrCd", "LOY_OPR_PLCY_ATTR_CD", null, null, true); 		 // 속성명 필드에 공통코드 연결
			$("#attrCd option[value='10']").show();
	        $("#attrCd option[value='11']").show();
	        $("#attrCd option[value='AVR']").show();
	        //$("#attrCd option[value='12']").hide(); // '속성명: 사용여부' 감춘다
			$.fn.ifvmSetSelectOptionCommCode("dataType", "LOY_OPR_PLCY_DATA_TYPE_CD", null, null, true); // 데이터유형 필드에 공통코드 연결 (공통코드 단의 markname이 나오도록 되어진다/하지만 보이기만 그럴뿐 실제로는 code값이 배정되어 있는 것이다 : CODE/TEXT)
			$("#dataType option[value='CONTS']").show();
		
		}
		$.fn.ifvmSetSelectOptionCommCode("useYn", "COM_STAT_TYPE_3_CD", null, null, true); 			 // 사용여부 코드 연결
		$.fn.ifvmSetSelectOptionCommCode("singleValYn", "REQUIRED_YN", null, null, true); 			 // 단일값여부 공통코드 연결
		// 단일값여부 필드를 처음에 Y부터 띄워주도록 하기 위해 Y로 초기화
		$('#singleValYn').val('Y');
		
		
		// 값 필드의 검색팝업 클릭 시
		$("#oprPlcyCommCodeSearchBtn").click(function(){
			if( $('#dataType').val() == 'TEXT' ) { // 데이터유형이 '텍스트'일 경우
				return;
			} else if( $('#dataType').val() == 'CODE' ) { // 데이터유형이 '공통코드'일 경우
				oprPlcyCommCodeSearchPop();
			} else if( $('#dataType').val() == 'CONTS' && $('#attrCd').val() == '10' ) { // 데이터유형이 '컨텐츠'이고 속성명도 '컨텐츠' 일 경우
				openContentPop();
			} else if($('#dataType').val() == 'CALEN'){
	             return;
			}
		});
		
		// 저장 버튼 클릭 시
		$("#saveOprPlcyDetailBtn").click(function() {
 			saveOprPlcyDetail();
		});
		// 닫기 버튼 클릭 시
		$("#closeThisPopBtn").click(function() {
			addPopClose();
		});
		
		
		// 데이터유형 변경시 필드 제약 변화 설정
		$("#dataType").change(function() {
			
			dataType = $('#dataType').val();
            if(dataType == 'CODE' || dataType == 'CONTS') {     // 데이터타입으로 코드를 선택했을 때
                $("#dataVal").show();
                $("#dataValT").hide();
                $('.input').hide();
                $("#dataValD").hide();
            	refreshWhenCodeOrContent();
			} else if(dataType == 'TEXT') { 	 // 데이터유형이 text 일 경우 => 써치필드,상위속성필드 비활성화, 값 필드는 직접 입력가능
                $("#dataVal").show();
                $("#dataValT").hide();
                $('.input').hide();
                $("#dataValD").hide();
				refreshWhenDataTypeText();
			} else if(dataType == 'CALEN') { 
                $("#dataVal").hide();
                $("#dataValT").hide();
                $('.input').show();
                $("#dataValD").show();
                refreshWhenDataTypeCalendar();
			}
            
		});
		
		// 속성명 필드 변경시 필드 제약 변화 설정
		$("#attrCd").change(function(){
		    
			if(sgFlag == 'sg1') { // '컨텐츠'항목 표시가 없는 '정책속성값'일 경우
	             $('#dataVal').val(null);                    
	                $('#markNm').val(null);
	                $('#groupCd').val(null);
				
				if($('#attrCd').val() == '12') { // '속성명: 사용여부'를 선택했을 시 => 데이터유형으로 '공통코드'만 뜨도록 한다
					$('#dataType option[value="TEXT"]').hide();
                    $("#dataType option[value='CALEN']").hide();
					$("#dataType option:eq(0)").prop("selected",true); // 데이터유형 에서 '공통코드'선택
					
                    $("#dataValT").val(null);
                    $("#dataValD").val(null);
                    $("#dataValT").hide();
                    $("#dataValD").hide();
                    $('.input').hide();
                    $("#dataVal").show();
                    
				} else {
					$("#dataType option[value='TEXT']").show();
                    $("#dataType option[value='CALEN']").show();
                    
                    $("#dataValT").val(null);
                    $("#dataValD").val(null);
                    $("#dataValT").hide();
                    $("#dataValD").hide();
                    $('.input').hide();
                    $("#dataVal").show();
				}
				
			} else if(sgFlag == 'sg2') { // '컨텐츠'항목 표시가 있는 '세부사항'에서의 사건일 경우
				// 속성명필드항목으로 '시(Time)'을 선택했을 경우 => 데이터유형으로 '텍스트'만 뜨도록 한다
			    if($("#attrCd").val() == "11"){  // '시(Time)였을 경우'
                    $("#dataType option:eq(1)").prop("selected", true); // '텍스트'가 선택된다
                    $("#dataType option[value='TEXT']").show();
                    $("#dataType option[value='CONTS']").hide();
                    $("#dataType option[value='CODE']").hide();
                    $("#dataType option[value='CALEN']").hide();
                    $("#dataVal").val(null);
                    $("#dataValD").val(null);
                    $("#dataValT").show();
                    $("#dataValD").hide();
                    $('.input').hide();
                    $("#dataVal").hide();  

			        //타임피커 생성
			         $('#dataValT').timepicker({
			             showMeridian: false,
			             defaultTime: '00:00',
			             showSeconds: false,
			             minuteStep: 5,
			             secondStep: 1,
			         });
			        // 텍스트일때의 필드 처리 : refreshWhenDataTypeText
			        refreshWhenDataTypeText();
			        
			    } else if($("#attrCd").val() == "10"){ // '컨텐츠'를 눌렀을 경우 => 데이터유형에 컨텐츠 유형만 표시되어진다.
			    	$("#dataType option:eq(2)").prop("selected",true); // 데이터유형 에서 '컨텐츠'항목이 자동으로 선택
				   	$("#dataType option[value='CONTS']").show();
			        $("#dataType option[value='CODE']").hide();
			        $("#dataType option[value='TEXT']").hide();
	                $("#dataType option[value='CALEN']").hide();

                    $("#dataValT").val(null);
                    $("#dataValD").val(null);
                    $("#dataValT").hide();
                    $("#dataValD").hide();
                    $('.input').hide();
                    $("#dataVal").show();

			        // 컨텐츠 일때의 필드처리 : refreshWhenDataTypeContent
			        refreshWhenCodeOrContent();
			        
			    } else if($('#attrCd').val() == '12') { // '속성명: 사용여부' 에 대한 설정
                    // '속성명: 사용여부'를 선택했을 시 => 데이터유형으로 '공통코드'만 뜨도록 한다
                    $('#dataType option[value="CODE"]').show();
                    $('#dataType option[value="TEXT"]').hide();
                    $('#dataType option[value="CONTS"]').hide();
                    $("#dataType option:eq(0)").prop("selected",true); // 데이터유형 에서 '공통코드'선택
                    $("#dataType option[value='CALEN']").hide();
                    $("#dataValT").val(null);
                    $("#dataValD").val(null);
                    $("#dataValT").hide();
                    $("#dataValD").hide();
                    $('.input').hide();
                    $("#dataVal").show();
					
			    } else { // 기타 나머지의 경우
                    $("#dataType option:eq(0)").prop("selected", true); // 데이터유형 에서 첫번째 항목('공통코드')항목이 자동으로 선택
                    $("#dataType option[value='CONTS']").show();
                    $("#dataType option[value='CODE']").show();
                    $("#dataType option[value='TEXT']").show();
                    $("#dataType option[value='CALEN']").show();
                    $("#dataValT").val(null);
                    $("#dataValD").val(null);
                    $("#dataValT").hide();
                    $("#dataValD").hide();
                    $('.input').hide();
                    $("#dataVal").show();
                    
			        // 공통코드류 일때의 필드처리 : refreshWhenDataTypeCode
			        refreshWhenCodeOrContent();
			    }
			 }//end if
		});

		
	});// end $(document).ready
	
</script>