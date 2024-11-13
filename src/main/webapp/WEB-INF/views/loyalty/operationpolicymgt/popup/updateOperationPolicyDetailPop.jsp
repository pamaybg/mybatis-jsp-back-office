<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 서브그리드 화면 내용 수정 페이지  -->

<style>
	#loyaltyPgm { width: 130px; }
</style>

<div class="form-horizontal underline top_well" id="oprPlcyDetailUpdateForm">	
<br>
	<div class="row">
		<div class="col-xs-11">
			<!-- 속성명  --> <!-- attrCd값이 여기에 담겨서 markName으로 표시되어지게 된다 => 그래서 attrNm처럼 보이게 됨 -->
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="속성명"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="attrCd" names="attrCd" dto="attrCd" required="true"/>
			</div>
			<!-- 단일값여부 -->	
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="단일값여부"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="singleValYn" names="singleValYn" dto="singleValYn" required="true"/>
			</div>
			<!-- 사용여부 -->
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="사용여부"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="useYn" names="useYn" dto="useYn" required="true"/>
			</div>
			<!-- 히든 필드 -->
			<ifvm:inputNew type="hidden" id="ridOpr" names="ridOpr" dto="ridOpr"/> <!-- 운영정책값(업데이트 저장이 이뤄질 때 덩달아 시행될 history 저장에 쓰이도록 하기 위해, 여기에 만들어둔 것 -->
			<ifvm:inputNew type="hidden" id="parRid" names="parRid" dto="parRid"/> <!-- 상위속성값 -->
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-11">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="데이터유형"/></label>
            <!-- 데이터유형 -->
            <div class="col-xs-2 control_content">
                <ifvm:inputNew type="select" id="dataType" names="dataType" dto="dataType" required="true"/>
            </div>
            <!-- 값 ( markNm 필드 | dataVal 필드 ) -->
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="값"/></label>
			<div class="col-xs-3 control_content" style="padding-left:10px;">
				<!-- 공통코드의 MarkName 필드(조회팝업버튼) -->
				<div class="input-group">
				<ifvm:input type="text" id="markNm" readonly="true" />
				<span class="input-group-addon" id="oprPlcyCommCodeSearchBtn">
					<a id="searchLink"><i class="fa fa-search"></i></a>
				</span>
				</div>
			</div>
			<div class="col-xs-3 control_content">
                        <ifvm:input type="text" id="dataVal" names="dataVal" readonly="true"/>
                        <ifvm:inputNew type="hidden" id="groupCd"/> <!-- 공통코드 선택 시 해당하는 그룹코드를 담는 hidden 필드 -->
                        <ifvm:input type="text" id="dataValT" names="dataVal" readonly="true"/>
                        <div id="effLabel" style="width: 170px;"><ifvm:inputNew type="date" dto="dataValD" id="dataValD"  /></div>
			</div>
		</div>
	</div>
	
	<div class="row qt_border"></div>
	
	<!-- 설명 필드 -->
	<div class="row">
		<div class="col-xs-11">
	        <label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="설명"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:inputNew type="textarea" id="contents" names="contents" rows="5" dto="contents" required="true" maxLength="100"/>
			</div>
			<%-- <ifvm:inputNew type="hidden" id=""/> --%>
		</div>
	</div>
		
	<div class="row qt_border"></div>
</div><!-- end oprPlcyDetailUpdateForm -->

<div class="pop_btn_area">
	<!-- 저장 버튼 -->
	<button class="btn btn-sm btn_gray" id="saveOprPlcyDetailBtn" objCode="updateOperationPolicyDetailSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<!-- 닫기 버튼 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="closeThisPopBtn" objCode="updateOperationPolicyDetailClose_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<div id="attrSearchPopContainer" class="popup_container"></div>



<script type="text/javascript">
	//준비
	
	var rid = null; // 수정팝업과 동시에 로드된 내용의 rid
	
	var singleValYn = null;  //단일값여부
	var dataType = null;
	var sgRid = null;		 //sgFlag가 sg1이냐 sg2냐 에 따라 각각 다르게 rid가 담길 sgRid 변수
	// 단일값여부 점검한 결과의 true/false에 대한 변수
	var flag = null;
	
	
	// 로드내용 초기화
	function fillLoadDataIntoField(data){ // 디비에서 조회해 가져온 결과값 data
		rid = data.rid; // 받아온 rid값을 전역변수 rid에 초기화 
		$('#attrCd').val(data.attrCd);
		$('#useYn').val(data.useYn);
		$('#dataType').val(data.dataType);
		$('#dataVal').val(data.dataVal);
		$('#markNm').val(data.dataValMarkNm);
		$('#contents').val(data.contents);
		$('#groupCd').val(data.groupCd);
		$('#singleValYn').val(data.singleValYn);
		$('#ridOpr').val(data.ridOpr);
		$('#parRid').val(data.parRid);
	}
	
	// 데이터유형이 텍스트 일때의 필드처리 
	function refreshWhenDataTypeText(){
        $("#dataVal").show();
        $("#dataValT").hide();
        $('.input').hide();
        $("#dataValD").hide();
        $('#dataVal').val(null);
        $('#dataVal').attr('readonly',false);
        $("#dataValT").val(null);
        $("#dataValD").val(null);
		$('#markNm').attr('readonly',false);
		$('#markNm').attr('disabled',true);
		$('#groupCd').val(null);
	}
	   // 데이터유형이 텍스트 이면서 시간일때 필드처리 
    function refreshWhenDataTypeTime(){
        $("#dataVal").hide();
        $("#dataValT").show();
        $('.input').hide();
        $("#dataValD").hide();
        $('#dataVal').val(null);
        $('#dataVal').attr('readonly',false);
        $("#dataValD").val(null);
        $('#markNm').attr('readonly',false);
        $('#markNm').attr('disabled',true);
        $('#groupCd').val(null);
    }
    // 데이터유형이 캘린더 일때의 필드처리 
    function refreshWhenDataTypeCalendar(){
        $("#dataVal").hide();
        $("#dataValT").hide();
        $('.input').show();
        $("#dataValD").show();
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
        $("#dataVal").show();
        $("#dataValT").hide();
        $('.input').hide();
        $("#dataValD").hide();
        $('#dataVal').val(null);                    
        $('#dataVal').attr('readonly',true);
        $("#dataValT").val(null);
        $("#dataValD").val(null);
		$('#markNm').val(null);
		$('#markNm').attr('disabled',false);
		$('#markNm').attr('readonly',true);
		$('#groupCd').val(null);
	}
	
	function runThisPage(){
		// sg1인 경우면 sg1Rid가 / sg2인 경우면 sg2Rid가 온다
		sgRid = ifvGlobal.searchHelp.field;
		// sgFlag가 sg1이면 sg1Rid값이, sg2이면 sg2Rid값이 rid프로퍼티 안에 담기게 된다
		var varData = {
				rid : sgRid
		};
						
		$.ajax({
			url: '<ifvm:action name="getOprPlcyDetailBeforeUpdate"/>',
			contentType: 'application/json',
			type: 'POST',
			cache: false,
			dataType: 'json',
			data: JSON.stringify(varData),
			success: function(data){
				if(sgFlag == 'sg1') { // 서브그리드1 상황일 경우 => 로드한 데이터를 설명란에도 표시
					// 로드내용 한번 초기화 
					fillLoadDataIntoField(data);
					// 속성명이 '사용여부' 였을 때,					
					if($('#attrCd').val() == '12') {
                        createCalenDar();
						$("#dataType option[value='CODE']").show();
		            	$("#dataType option[value='TEXT']").hide();
                        $("#dataType option[value='CALEN']").hide();
		                $("#dataType option:eq(0)").prop("selected",true);
		                $("#dataVal").show();
		                $("#dataValT").hide();
		                $('.input').hide();
		                $("#dataValD").hide();
		                $('#dataVal').attr('readonly',true);
					}
					// 데이터유형 필드 관련 상호작용
			        if($('#dataType').val() == 'CODE' || $('#dataType').val() == 'CONTS') {
                        createCalenDar();
			            $('#dataVal').attr('readonly',true);
	                    $('#dataValT').attr('readonly',true);
	                    $('#dataValD').attr('readonly',true);
                        $("#dataValT").hide();
                        $('.input').hide();
                        $("#dataValD").hide();
			            $('#markNm').attr('disabled',false);
			            $('#markNm').attr('readonly',true);
			        } else if(data.dataType == 'TEXT') {
                         createCalenDar();
                         $("#dataVal").show();
                         $("#dataValD").hide();
                         $('.input').hide();
                         $("#dataValT").hide();
                         $('#dataVal').attr('readonly',false);
                         $('#dataValT').attr('readonly',true);
                         $('#dataValD').attr('readonly',true);                         
                         $('#markNm').attr('readonly',false);
                         $('#markNm').attr('disabled',true);
                         $('#dataVal').val(data.dataVal);
			        }else if(data.dataType == 'CALEN') {
	                     createCalenDar();
                         $('#dataVal').attr('readonly',true);
                         $('#dataValT').attr('readonly',true);
                         $('#dataValD').attr('readonly',false);
		                $("#dataVal").hide();
		                $("#dataValT").hide();
		                $('.input').show();
		                $("#dataValD").show();
	                    $('#markNm').attr('readonly',false);
	                    $('#markNm').attr('disabled',true);
	                    $('#dataValD').val(data.dataVal);
		            }
			     	// 로드내용 한번 더 초기화
					fillLoadDataIntoField(data);
	                    
				} else if(sgFlag == 'sg2') { // 서브그리드2 상황일 경우 => 로드한 데이터를 설명란에는 표시하지 않음
					// 로드내용 한번 초기화
					fillLoadDataIntoField(data);
					
					// 속성명 필드 관련 상호작용
		            if($("#attrCd").val() == "11"){ // 처음 로드되었을 때 속성명 값이 '시간(Time)'일 경우, 관련 필드들을 처리해준다
		                //타임피커 생성
                        $('#dataValT').timepicker({
                            showMeridian: false,
                            defaultTime: '00:00',
                            showSeconds: false,
                            minuteStep: 5,
                            secondStep: 1,
                        });
                        createCalenDar();
		                $("#dataType option:eq(1)").prop("selected", true); // '텍스트'가 선택된다
	                    $("#dataType option[value='TEXT']").show();
	                    $("#dataType option[value='CONTS']").hide();
	                    $("#dataType option[value='CODE']").hide();
	                    $("#dataType option[value='CALEN']").hide();
	                    $("#dataVal").hide();
// 	                    $("#dataValT").show();
	                    $("#dataValD").hide();
	                    $('.input').hide();
                        $('#dataValT').val(data.dataVal);

		            } else if($("#attrCd").val() == "10"){ // 처음 로드되었을 때 속성명 값이 '컨텐츠'일 경우
                        //타임피커 생성
                        $('#dataValT').timepicker({
                            showMeridian: false,
                            defaultTime: '00:00',
                            showSeconds: false,
                            minuteStep: 5,
                            secondStep: 1,
                        });
                        createCalenDar();
		              	  $("#dataType option:eq(2)").prop("selected", true);
		                  $("#dataType option[value='TEXT']").hide();
		                  $("#dataType option[value='CODE']").hide();
                          $("#dataType option[value='CALEN']").hide();
		                  
		            } else if($('#attrCd').val() == '12') { // 속성명: '사용여부'
                        //타임피커 생성
                        $('#dataValT').timepicker({
                            showMeridian: false,
                            defaultTime: '00:00',
                            showSeconds: false,
                            minuteStep: 5,
                            secondStep: 1,
                        });
                        createCalenDar();
	                        $("#dataType option[value='CODE']").show();
	                        $("#dataType option[value='TEXT']").hide();
	                        $("#dataType option[value='CALEN']").hide();
	                        $("#dataType option:eq(0)").prop("selected",true);
	                        $("#dataVal").show();
	                        $("#dataValT").hide();
	                        $('.input').hide();
	                        $("#dataValD").hide();
	                        $('#dataVal').val(null);                    
	                        $('#dataVal').attr('readonly',true);
		                
		            }
						
		         	// 데이터유형 필드 관련 상호작용
			        if($('#dataType').val() == 'CODE' || $('#dataType').val() == 'CONTS') {
                        //타임피커 생성
                        $('#dataValT').timepicker({
                            showMeridian: false,
                            defaultTime: '00:00',
                            showSeconds: false,
                            minuteStep: 5,
                            secondStep: 1,
                        });
                        createCalenDar();
                        $('#dataVal').attr('readonly',true);
                        $('#dataValT').attr('readonly',true);
                        $('#dataValD').attr('readonly',true);
                        $("#dataValT").hide();
                        $('.input').hide();
                        $("#dataValD").hide();
                        $('#markNm').attr('disabled',false);
                        $('#markNm').attr('readonly',true);
			        } else if(data.dataType == 'TEXT') {
			            if($("#attrCd").val() != "11"){ 
		                     //타임피커 생성
	                        $('#dataValT').timepicker({
	                            showMeridian: false,
	                            defaultTime: '00:00',
	                            showSeconds: false,
	                            minuteStep: 5,
	                            secondStep: 1,
	                        });
	                        createCalenDar();
		                        $("#dataVal").show();
		                        $("#dataValD").hide();
		                        $('.input').hide();
		                        $("#dataValT").hide();
		                        $('#dataVal').attr('readonly',false);
		                        $('#markNm').attr('readonly',false);
		                        $('#markNm').attr('disabled',true);
		                        $('#dataVal').val(data.dataVal);
			            } else {
	                          //타임피커 생성
                            $('#dataValT').timepicker({
                                showMeridian: false,
                                defaultTime: '00:00',
                                showSeconds: false,
                                minuteStep: 5,
                                secondStep: 1,
                            });
                            createCalenDar();
                                $("#dataVal").hide();
                                $("#dataValD").hide();
                                $('.input').hide();
                                $("#dataValT").show();
                                $('#dataValT').attr('readonly',false);
                                $('#markNm').attr('readonly',false);
                                $('#markNm').attr('disabled',true);
                                $('#dataValT').val(data.dataVal);
			            }
			        } else if(data.dataType == 'CALEN') {
                        createCalenDar();
                        $('#dataVal').attr('readonly',true);
                        $('#dataValT').attr('readonly',true);
                        $('#dataValD').attr('readonly',false);
                       $("#dataVal").hide();
                       $("#dataValT").hide();
                       $('.input').show();
                       $("#dataValD").show();
                       $('#markNm').attr('readonly',false);
                       $('#markNm').attr('disabled',true);
                       $('#dataValD').val(data.dataVal);
                    }
			        
				}// end else if
				
				// 로드내용 한번 더 초기화
				fillLoadDataIntoField(data);				
			},
			error: function(err) {
				alert('error: '+err);
			}
		});
		
	}// end runThisPage
	
	
	// 입력 폼 유효성 검사 
	function validateForm() {
		// form 의 필드들이 모두 적절한 상태인지 확인
		if(    ( $('#attrCd').val()      != null   &&   $('#attrCd').val()      != '' ) 
			&& ( $('#dataType').val()    != null   &&   $('#dataType').val()    != '' )
			&& ( $('#dataVal').val()     != null   &&   $('#dataVal').val()     != '' )
			&& ( $('#useYn').val()       != null   &&   $('#useYn').val()       != '' )
			//&& ( $('#contents').val()    != null   &&   $('#contents').val()    != '' )
			&& ( $('#singleValYn').val() != null   &&   $('#singleValYn').val() != '' )
			// groupCd는 Null 이 가능하기 때문에, 체크하지 않는다.
																							) {
			return true;
		} else {
			return false;
		}
	}//end validateForm
	
	// 단일값 규칙 위배 체크 함수(수정 시)
	function checkAttrCdSingleValYnForUpdate() {
		var url = '<ifvm:action name="checkAttrCdSingleValYnForUpdate"/>';  // url
		// 원래 필드객체의값을 서버로 보내줄 곳에 담는 작업은 실제 저장 시행단계에서 해줬는데, 본 작업은 그보다 이전에 수행되고 있으므로 attrCd가 비어있고, 그래서 손수 담아준다
		attrCd      = $('#attrCd').val();
		singleValYn = $('#singleValYn').val();
		ridOpr = ( $('#ridOpr').val() == null || $('#ridOpr').val() == '' ) ? null : $('#ridOpr').val();
		parRid = ( $('#parRid').val() == null || $('#parRid').val() == '' ) ? null : $('#parRid').val();
		
		var varData = {
				rid: rid,
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
		
	}//end checkAttrCdSingleValYnForUpdate
	
	     	 	       
	// 수정사항 저장 시행(dataType,dataVal,attrCd,useYn,contents 만 수정 되어짐)
	function executeUpdateOprPlcyDetail() {
				// 전역에 있는 newFlag변수 보고 신규/수정 상황인지 판별
				var url = '<ifvm:action name="updateOperationPolicyDetail"/>';
					 
			    dataType = $('#dataType').val();   
			    dataVal  = $('#dataVal').val();    
			    attrCd   = $('#attrCd').val();     
			    useYn 	 = $('#useYn').val();
			    contents = $('#contents').val();
			    ridOpr 	 = $('#ridOpr').val();
			    parRid 	 = $('#parRid').val();
			    groupCd	 = $('#groupCd').val();
			    singleValYn	 = $('#singleValYn').val();
			 	    
				// 서버로 보내줄 데이터를 담는 객체 varData 선언 (맨처음 로드처리 때 이미 초기화됐던 전역변수 sgRid값을 rid로 여기에 실어 보낸다)
				var varData = {
						rid      : sgRid,
						ridOpr   : ridOpr,
						parRid   : parRid,
						dataType : dataType,
						dataVal  : dataVal,
						attrCd   : attrCd,
						useYn    : useYn,
						contents : contents,
						groupCd  : groupCd,
						singleValYn : singleValYn
				};
				
				// ifv방식으로 서버와 통신(POST방식으로 전송, JSON형태 이용)
				$.ifvSyncPostJSON(url, varData, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) { 
						alert('<spring:message code="수정되었습니다."/>'); // 저장되었습니다
						updatePopClose();
					}
				}, function(result) { // 실패했을 경우
					if (result.message != null) // 메세지 있으면 메세지 표시
						alert('error: '+result.message);
					else						// 메세지도 없으면 그냥 실패 메세지 표시
						alert('<spring:message code="M02248"/>');
				});
				
				// 새로고침
				if(sgFlag == 'sg1') {
					subGrid1List._doAjax();
					// 한 그리드 리스트를 새로고침해주면, 그 그리드리스트의 하위 그리드리스트 역시 (새로고침격으로)초기화 해주어야 하므로 초기상태 그리드로 만들어준다.
					callSubGrid2List(null, null);
					//기존선택되어있었던레코드.click();
				} else if(sgFlag == 'sg2') {
					// 서브그리드2는 현재 하위 그리드리스트가 없다, 본인이 막내리스트임.
					subGrid2List._doAjax();
				}
				
	} //end executeUpdateOprPlcyDetail
	
	
	// 저장 요청 수행
	function updateOprPlcyDetail() {
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
	       
		var validation = validateForm();  // 입력 폼에 대한 유효성 검사 : 결과로 true/false
		
		if(!validation) {
			alert('항목들을 전부 입력해주세요');	
		} else {
			checkAttrCdSingleValYnForUpdate(); // 테이블안에서 '단일값여부'칼럼에 대한 유효성 검사 : 결과로 true/false
			
			if(flag) { // true 일 경우
				executeUpdateOprPlcyDetail();
			} else { // false 일 경우
				return;
			} 
		}
	} //end updateOprPlcyDetail
	
	
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
	// document.ready
	$(document).ready(function() {
		runThisPage();
		
		// 공통코드 연동		
		// '정책속성값'그리드 인 경우 / '세부사항'그리드 인 경우 에 따라 select박스에서 '컨텐츠'부분 표시 여부를 가른다.
		if(sgFlag == 'sg1') {
			$.fn.ifvmSetSelectOptionCommCode("attrCd", "LOY_OPR_PLCY_ATTR_CD", null, null, true); 		 // 속성명 필드에 공통코드 연결
			$("#attrCd option[value='10']").hide();
       		$("#attrCd option[value='11']").hide();
	        $("#attrCd option[value='AVR']").hide();       		
			$.fn.ifvmSetSelectOptionCommCode("dataType", "LOY_OPR_PLCY_DATA_TYPE_CD", null, null, true); // 데이터유형 필드에 공통코드 연결 (공통코드 단의 markname이 나오도록 되어진다/하지만 보이기만 그럴뿐 실제로는 code값이 배정되어 있는 것이다 : CODE/TEXT)
			$("#dataType option[value='CONTS']").hide();
		} else if(sgFlag == 'sg2') {
			$.fn.ifvmSetSelectOptionCommCode("attrCd", "LOY_OPR_PLCY_ATTR_CD", null, null, true); 		 // 속성명 필드에 공통코드 연결
			$("#attrCd option[value='10']").show();
	        $("#attrCd option[value='11']").show();
	        $("#attrCd option[value='AVR']").show();	        
			$.fn.ifvmSetSelectOptionCommCode("dataType", "LOY_OPR_PLCY_DATA_TYPE_CD", null, null, true); // 데이터유형 필드에 공통코드 연결 (공통코드 단의 markname이 나오도록 되어진다/하지만 보이기만 그럴뿐 실제로는 code값이 배정되어 있는 것이다 : CODE/TEXT)
			$("#dataType option[value='CONTS']").show();
		}
		$.fn.ifvmSetSelectOptionCommCode("useYn", "COM_STAT_TYPE_3_CD", null, null, true); 			 // 사용여부 코드 연결
		$.fn.ifvmSetSelectOptionCommCode("singleValYn", "REQUIRED_YN", null, null, true); 			 // 단일값여부 공통코드 연결
		
		
		// 값 필드의 검색팝업 클릭 시
		$("#oprPlcyCommCodeSearchBtn").click(function() {
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
 			updateOprPlcyDetail();
		});
		// 닫기 버튼 클릭 시
		$("#closeThisPopBtn").click(function() {
			updatePopClose();
		});
		
		
        // 데이터유형 선택시 필드제약 설정
        $("#dataType").change(function() { 
        	
        	dataType = $('#dataType').val();
            if(dataType == 'CODE' || dataType == 'CONTS') {     // 데이터타입으로 코드를 선택했을 때
            	refreshWhenCodeOrContent();
			} else if(dataType == 'TEXT') { 	 // 데이터유형이 text 일 경우 => 써치필드,상위속성필드 비활성화, 값 필드는 직접 입력가능
				refreshWhenDataTypeText();
			}else if(dataType == 'CALEN') { 
                refreshWhenDataTypeCalendar();
            }
            
        });
        
     	// 속성명 필드 변경시 필드 제약 변화 설정
        $("#attrCd").change(function() {
        	
        	if(sgFlag == 'sg1') { // '컨텐츠'항목 표시가 없는 '정책속성값'일 경우
        		$('#dataVal').val(null);		      		
                $('#dataValT').val(null);                    
                $('#dataValD').val(null);                  
//                 $('.input').hide();

				$('#markNm').val(null);
				$('#groupCd').val(null);

				// '속성명: 사용여부' 에 대한 설정: 정책속성값, 세부속성 그리드 모두 동일하게 적용
				 if($('#attrCd').val() == '12') { // '속성명: 사용여부'를 선택했을 시 => 데이터유형으로 '공통코드'만 뜨도록 한다
				 	 $('#dataType option[value="TEXT"]').hide();
                     $('#dataType option[value="CALEN"]').hide();
					 $("#dataType option:eq(0)").prop("selected",true); // 데이터유형 에서 '공통코드'선택
                     createCalenDar();
                     $("#dataVal").val(null);
                     $("#dataValD").val(null);
			        $("#dataVal").show();
			        $("#dataValT").hide();
			        $('.input').hide();
			        $("#dataValD").hide();
			        $('#dataVal').val(null);                    
			        $('#dataVal').attr('readonly',true);				 
				 } else {
                     createCalenDar();
					 $("#dataType option[value='TEXT']").show();
                     $('#dataType option[value="CALEN"]').show();
				 }
				
			} else if(sgFlag == 'sg2') { // '컨텐츠'항목 표시가 있는 '세부사항'에서의 사건일 경우
				// 속성명필드항목으로 '시(Time)'을 선택했을 경우 => 데이터유형으로 '텍스트'만 뜨도록 한다
			    if($("#attrCd").val() == "11"){  // '시(Time)였을 경우'
	                 //타임피커 생성
                    $('#dataValT').timepicker({
                        showMeridian: false,
                        defaultTime: '00:00',
                        showSeconds: false,
                        minuteStep: 5,
                        secondStep: 1,
                    });
                    createCalenDar();
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
			        refreshWhenDataTypeTime();
			        
			    } else if($("#attrCd").val() == "10"){ // '컨텐츠'를 눌렀을 경우 => 데이터유형에 컨텐츠 유형만 표시되어진다.
                    //타임피커 생성
                    $('#dataValT').timepicker({
                        showMeridian: false,
                        defaultTime: '00:00',
                        showSeconds: false,
                        minuteStep: 5,
                        secondStep: 1,
                    });
                    createCalenDar();			    	
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
                    //타임피커 생성
                    $('#dataValT').timepicker({
                        showMeridian: false,
                        defaultTime: '00:00',
                        showSeconds: false,
                        minuteStep: 5,
                        secondStep: 1,
                    });
                    createCalenDar();			        
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
                    //타임피커 생성
                    $('#dataValT').timepicker({
                        showMeridian: false,
                        defaultTime: '00:00',
                        showSeconds: false,
                        minuteStep: 5,
                        secondStep: 1,
                    });
                    createCalenDar();			        
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

		
	
	});// end document.ready
			
	
</script>