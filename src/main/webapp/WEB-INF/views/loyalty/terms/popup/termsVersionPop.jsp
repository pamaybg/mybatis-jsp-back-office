<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script>
    var verRid = verRid;
    var isNew;
    var startDateVal = null;
    var contsSumryrteeObj;
    var ContentsrteeObj;
    var contsSumryfocusCHeck;
    var ContentsfocusCHeck;
    var contsSumryhtmlStore;
    var ContentshtmlStore;
    var editmodestr;
    var previewChk = false;
    var cContsSumry;
    var cContent;
    var ctitle;
    var modifyChk = false;
    var contsSumryData = null;
    var contentsData = null;
    var flagdata = false;
    var divReplace =/(<|<\/)div([\s.'"=a-zA-Z]*)>/gi;

	//초기 화면 셋
	function rteInit() {
        $("#contsSumry").ejRTE({
            height : "240px",
            width : "100%",
            minWidth : "10px",
            showFooter : true,
            showHtmlSource : true,
            maxLength:90000000,
            tools : {
                formatStyle : [ "format" ],
                font : [ "fontSize", "fontColor", "backgroundColor" ],
                style : [ "bold", "italic", "underline" ],
                indenting : [],
                images : [],
                tables : [],
                doAction : [],
                links : [],
                media : [],
                view : [ "fullScreen" ]
            }, 
            pasteCleanupSettings:{
                listConversion:true,
                cleanCSS:false,
                removeStyles:false,
                cleanElements:false
            },
            select : function () {
                contsSumryfocusCHeck = 'contsSumry_Iframe'
            }
        });

        contsSumryrteeObj = $("#contsSumry").data("ejRTE");
        $("#Contents").ejRTE({
            height : "380px",
            width : "100%",
            minWidth : "10px",
            showFooter : true,
            showHtmlSource : true,
            maxLength:90000000,
            tools : {
                formatStyle : [ "format" ],
                font : [ "fontSize", "fontColor", "backgroundColor" ],
                style : [ "bold", "italic", "underline" ],
                indenting : [],
                images : [],
                tables : [],
                doAction : [],
                links : [],
                media : [],
                view : [ "fullScreen" ]
            }, 
            select : function () {
                ContentsfocusCHeck = 'Contents_Iframe'
            }
        });

        ContentsrteeObj = $("#Contents").data("ejRTE");

        $("input[name=textTypeCode]:radio[value='HTML']").prop( 'checked', true);
        setTimeout(function () {
            if ($("#contsSumry").length) {
                contsSumryrteeObj.setHtml(contsSumryhtmlStore);
            }
            if ($("#Contents").length) {
                ContentsrteeObj.setHtml(ContentshtmlStore);
            }
        }, 200);
    }

    //기존 데이터 가져와서 화면에 뿌림
    function getVersionDetail() {
        if(modifyChk == false){
	        if (!isNew) {
	            $.ifvSyncPostJSON('<ifvm:action name="getTermsVerDetail"/>', {
	                rid : verRid
	            }, function (result) {
	                $("#termsVersion").val((result.ver).toFixed(1));
	                $("#startDate").val(result.startDate);
	                $("#parRid").val(result.ridTermsM);
	                console.log(result.requiredYn);
	                $.fn.ifvmSetSelectOptionCommCode("requiredYn","REQUIRED_YN", result.requiredYn, null,true);
	                startDateVal = result.startDate;
	                contsSumryhtmlStore = result.termsSumry;
	                ContentshtmlStore = result.termsConts;
	                editmodestr = result.editMode;
	            });
	
	            if (realStatCd != 'W') { //약관이 적용되고 난후(현시간 전에 실행된 약관)에는 아무것도 수정할수 없고 적용전의 약관은 수정가능
	                if (startDateVal <= $.ifvGetTodayDate()) {
	                    $("#termsVersion").attr('disabled', true);
	                    $("#startDate").attr('disabled', true);
	                    $("#versionBtnSave").attr('disabled', true);
	                    $("#requiredYn").attr('disabled', true);
	                }
	            }
	            modifyChk = true;
	        }
	        


	      }
            if (editmodestr == "TEXT") {
                setTimeout(function () {
	                $("input[name=textTypeCode]:radio[value='TEXT']").prop( 'checked', true);
	                if ($("#contsSumry").length) {
	                    $("#contsSumry").val(contsSumryhtmlStore);
	                }
	                if ($("#Contents").length) {
	                       $("#Contents").val(ContentshtmlStore);
	                }
                }, 200);
            }
            if (editmodestr == "HTML") {
                setTimeout(function () {
                         rteInit();
                }, 200);
            }
    }
    //캘린더 초기 날짜 설정(오늘)
    function setValidCalendar() {
        var startDate = $("#startDate");

        startDate.val($.ifvGetTodayDate());

        startDate.ifvDateChecker({
            minDate : "today",
        });
    }
    //저장
    function saveTermsVersion() {

        if ($("#termsVersion").val() == "") {
            alert('<spring:message code="L02689"/>');
            return false;
        }
        //ver 체크
        var verNum = $("#termsVersion").val();
        if (verNum > 99.9) {
            alert("0~99.0~9 형식에 맞추어 주세요 ");
            $("#termsVersion").focus();
            return false;
        }
        if (!isNew) {
            textTypeCode($("input[name=textTypeCode]:checked").val());
            if ($("input[name=textTypeCode]:checked").val() == 'TEXT') {
                $("input[name=textTypeCode]:radio[value='TEXT']").prop( 'checked', true);
                getVersionDetail();
                $.ifvSyncPostJSON('<ifvm:action name="modifyTermsVersion"/>', {
                    rid : verRid,
                    parRid : parRid,
                    ver : $("#termsVersion").val(),
                    termsSumry : $("#contsSumry").val(),
                    termsConts : $("#Contents").val(),
                    startDate : $("#startDate").val(),
                    requiredYn : $("#requiredYn").val(),
                    editMode : $("input[name=textTypeCode]:checked").val()
                }, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        alert("<spring:message code="C00094" />");
                        termsVerList._doAjax();
                        termsVersionPopupClose();
                    }
                }, function (result) {
                    if (result.message != null)
                        alert(result.message);
                });
            } else {
                $("input[name=textTypeCode]:radio[value='HTML']").prop( 'checked', true);
                $.ifvSyncPostJSON('<ifvm:action name="modifyTermsVersion"/>', {
                    rid : verRid,
                    parRid : parRid,
                    ver : $("#termsVersion").val(),
                    termsSumry : $("#contsSumry").val(),
                    termsConts : $("#Contents").val(),
                    startDate : $("#startDate").val(),
                    requiredYn : $("#requiredYn").val(),
                    editMode : $("input[name=textTypeCode]:checked").val()
                }, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        alert("<spring:message code="C00094" />");
                        termsVerList._doAjax();
                        termsVersionPopupClose();
                    }
                }, function (result) {
                    if (result.message != null)
                        alert(result.message);
                });
            }
        } else {
        	
            textTypeCode($("input[name=textTypeCode]:checked").val());
            if ($("input[name=textTypeCode]:checked").val() == 'TEXT') {
                $("input[name=textTypeCode]:radio[value='TEXT']").prop( 'checked', true);
                getVersionDetail();
	                $.ifvSyncPostJSON('<ifvm:action name="saveTermsVersion"/>', {
	                    parRid : parRid,
	                    ver : $("#termsVersion").val(),
	                    termsSumry :  $("#contsSumry").val(),
	                    termsConts : $("#Contents").val(),
	                    startDate : $("#startDate").val(),
	                    requiredYn : $("#requiredYn").val(),
	                    editMode : $("input[name=textTypeCode]:checked").val()
	                }, function (result) {
	                    if ($.fn.ifvmIsNotEmpty(result)) {
	                        alert("<spring:message code="C00094" />");
	                        termsVerList._doAjax();
	                        termsVersionPopupClose();
	                    }
	                }, function (result) {
	                    if (result.message != null)
	                        alert(result.message);
	                });  
            }else{
                $("input[name=textTypeCode]:radio[value='HTML']").prop( 'checked', true);
	                $.ifvSyncPostJSON('<ifvm:action name="saveTermsVersion"/>', {
	                    parRid : parRid,
	                    ver : $("#termsVersion").val(),
	                    termsSumry :  $("#contsSumry").val(),
	                    termsConts : $("#Contents").val(),
	                    startDate : $("#startDate").val(),
	                    requiredYn : $("#requiredYn").val(),
	                    editMode : $("input[name=textTypeCode]:checked").val()
	                }, function (result) {
	                    if ($.fn.ifvmIsNotEmpty(result)) {
	                        alert("<spring:message code="C00094" />");
	                        termsVerList._doAjax();
	                        termsVersionPopupClose();
	                    }
	                }, function (result) {
	                    if (result.message != null)
	                        alert(result.message);
	                });   
            }
		 }
        contsSumryData = "";
        contentsData = "";
        contsSumryhtmlStore = "";
        ContentshtmlStore = "";
    }
    
    function textTypeCode(type) { 
        //TEXT 변환
        if (type == "TEXT") {
            editmodestr = "TEXT"
            var contsDestroyChk = $("#contsSumry_Iframe").contents().children().children().next().html();
            var contentDestroyChk = $("#Contents_Iframe").contents().children().children().next().html();
            
            if (contsDestroyChk != null && contentDestroyChk != null ) {
                contsSumryrteeObj.destroy();
                ContentsrteeObj.destroy();
                
            }
            contsSumryData =  $("#contsSumry").val();
            contentsData =  $("#Contents").val();

            flagdata = true;

           var contsSumryStringHtmlData = $("#contsSumry").val().replace(/(<br>|<br\/>|<br \/>)/g, '\r\n').replace(divReplace, "").replace(/(<([^>]+)>)/ig, "");
           contsSumryStringHtmlData = contsSumryStringHtmlData.replace(/\&nbsp;/g, "\r\n");
           $("#contsSumry").html(contsSumryStringHtmlData);

            var ContentsStringHtmlData = $("#Contents").val().replace(/(<br>|<br\/>|<br \/>)/g, '\r\n').replace(divReplace, "").replace(/(<([^>]+)>)/ig, "");
            ContentsStringHtmlData = ContentsStringHtmlData.replace(/\&nbsp;/g, "\r\n");
            $("#Contents").html(ContentsStringHtmlData);
            
           contsSumryhtmlStore = $("#contsSumry").text();
           ContentshtmlStore =  $("#Contents").text();            
           
            getVersionDetail();
            //HTML 변환
        }
        if (type == "HTML") {
            editmodestr = "HTML";
            if (contsSumryhtmlStore != null) {
	                if(flagdata == true){
	                    if (contsSumryData != null || contsSumryData != '') {
	                        var contsSumryDataCheck = $("#contsSumry").html().replace(/(<br>|<br\/>|<br \/>)/g, '\r\n').replace(divReplace, "").replace(/(<([^>]+)>)/ig, "").replace(/\&nbsp;/g, "\r\n")   .replace(/&amp;/g, '&')
	                        .replace(/&lt;/g, '<')
	                        .replace(/&gt;/g, '>')
	                        .replace(/&quot;/g, '"')
	                        .replace(/&#039;/g, "'")
	                        .replace(/&#39;/g, "'");;
	                        if($("#contsSumry").val() != contsSumryDataCheck){
	                            contsSumryData =  $("#contsSumry").val();
	                            contsSumryhtmlStore = contsSumryData.replace(/(?:\r\n|\r|\n)/g, '<br/>');	                            
	                        } else {
	                            contsSumryhtmlStore = contsSumryData.replace(/(?:\r\n|\r|\n)/g, '<br/>');
	                        }
	                    }
	                } else {
	                            contsSumryData =  $("#contsSumry").val();
	                            contsSumryhtmlStore = contsSumryData.replace(/(?:\r\n|\r|\n)/g, '<br/>');
	                }
            }
            
            if (ContentshtmlStore != null) {
                if(flagdata == true){
                    if (contentsData != null || contentsData != '') {
                        var contentsDataCheck = $("#Contents").html().replace(/(<br>|<br\/>|<br \/>)/g, '\r\n').replace(divReplace, "").replace(/(<([^>]+)>)/ig, "").replace(/\&nbsp;/g, "\r\n")   .replace(/&amp;/g, '&')
                        .replace(/&lt;/g, '<')
                        .replace(/&gt;/g, '>')
                        .replace(/&quot;/g, '"')
                        .replace(/&#039;/g, "'")
                        .replace(/&#39;/g, "'");;
                        if($("#Contents").val() != contentsDataCheck){
                            contentsData =  $("#Contents").val();
                            ContentshtmlStore = contentsData.replace(/(?:\r\n|\r|\n)/g, '<br/>');                               
                        } else {
                            ContentshtmlStore = contentsData.replace(/(?:\r\n|\r|\n)/g, '<br/>');
                        }
                    }
                } else {
                            contentsData =  $("#Contents").val();
                            ContentshtmlStore = contentsData.replace(/(?:\r\n|\r|\n)/g, '<br/>');
                }
        }
            getVersionDetail();
        }
    }
    function previewBtnPop() {
        $("#previewPopDialog").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="termsPreviewPop"/>',
            contentType: "ajax",
            title: '<spring:message code="M00392"/>',
            width: 870,
            close : 'previewBtnPopClose'
        });
    }
    function previewBtnPopClose() {
        previewPopDialog._destroy();
    }

    $(document).ready(function () {
        //신규,기존 분기
       $.fn.ifvmSetSelectOptionCommCode("requiredYn","REQUIRED_YN", null, null,true);

        if (typeof verRid === 'undefined' || verRid == null) {
            isNew = true;
            modifyChk = true;
        } else {
            isNew = false;
            //기존에 있지만 값을 수정한 경우 
            if (modifyChk == false ) {
                contsSumryhtmlStore = "";
                ContentshtmlStore = "";
                getVersionDetail();
            }
        }
        //캘린더 초기 날짜 설정(오늘)
        setValidCalendar();
        //라디오 버튼
        $("input[name=textTypeCode]").change(function () {
            textTypeCode($(this).val());
        });
        //저장
        $("#versionBtnSave").click(function () {
            saveTermsVersion();
        });
        //취소
        $("#btnCancel").click(function () {
            termsVersionPopupClose();
        });
        //content_fullscreen 정의	
        $("#contsSumry_fullScreen").on("click", function () {
            $("#contsSumry_wrapper").css("top", "0");
        });
        $("#Contents_fullScreen").on("click", function () {
            $("#Contents_wrapper").css("top", "0");
        });
		//미리보기
		$('#previewBtn').on('click', function(){
	        //previewChk = true;
	        //var resultFlag = actionContent();
	        //if (resultFlag == false) return;
	                    if ($("#termsVersion").val() == "") {
				            alert('<spring:message code="L02689"/>');
				            return false;
				        }
				        //ver 체크
				        var verNum = $("#termsVersion").val();
				        if (verNum > 99.9) {
				            alert("0~99.0~9 형식에 맞추어 주세요 ");
				            $("#termsVersion").focus();
				            return false;
				        }
			            ctitle = termsVersion.value;
			            if ($("input[name=textTypeCode]:checked").val() == 'TEXT') {
			                cContsSumry =  $("#contsSumry").val();
			                cContent = $("#Contents").val();
			            } else {
			                cContsSumry = $("#contsSumry_Iframe").contents().children().children().next().html();
                            cContent = $("#Contents_Iframe").contents().children().children().next().html();
                            
                            cContsSumry = cContsSumry.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n').replace(divReplace, "").replace(/(<([^>]+)>)/ig, "").replace(/\&nbsp;/g, "\r\n");
                            cContent = cContent.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n').replace(divReplace, "").replace(/(<([^>]+)>)/ig, "").replace(/\&nbsp;/g, "\r\n");
			            }
			            previewBtnPop();
	         });

    });
</script>


<div class="form-horizontal underline top_well" id="termsVersionDetail">
	<div class="row qt_border">
		<ifvm:inputNew type="number" id="termsVersion" label="L02685"
			labelClass="1" conClass="3" required="true" />
		<ifvm:inputNew type="date" id="startDate" names="startDate"
			label="M00329" labelClass="1" conClass="3" required="true" />
		<ifvm:inputNew type="select" id="requiredYn" names="requiredYn"
			dto="requiredYn" labelClass="1" label="Q00029" conClass="2" />
	</div>
	<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message
				code="L02909" /></label>
		<div class="col-xs-7 control_content">
			<label class="radio-inline"> <ifvm:input type="radio"
					names="textTypeCode" values="TEXT" checked="true" id="textTypeCode" />
				<spring:message code="L02910" />
			</label> <label class="radio-inline"> <ifvm:input type="radio"
					names="textTypeCode" values="HTML" id="textTypeCode" /> <spring:message
					code="L02911" />
			</label>
		</div>
	</div>
	<%-- 미리보기 --%>
	<div class="row qt_border" style="padding-left: 846px;">
		<button class="btn btn-sm btn_gray" id="previewBtn" objCode="termsVersionPreview_OBJ">
			<spring:message code="M00392" />
		</button>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="contsSumry" names="contsSumry"
			dto="contsSumry" required="false" label="L02688" labelClass="1"
			conClass="11" rows="5"  />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="Contents" names="Contents"
			dto="Contents" required="false" label="L02332" labelClass="1"
			conClass="11" rows="20" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="hidden" id="parRid" labelClass="1" conClass="1" />
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="versionBtnSave" objCode="termsVersionSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="termsVersionCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>
<div id="previewPopDialog" class="popup_container"></div>
