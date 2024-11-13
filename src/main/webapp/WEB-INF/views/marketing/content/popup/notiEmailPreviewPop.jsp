<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    #prehtmlContentsArea1_tools{
           display: none;
    }
</style>
<script>
var sendData = null;
function rteInit() {
    $("#prehtmlContentsArea1").ejRTE({
        height : "700px",
        width : "100%",
        minWidth : "10px",
        showFooter : false,
        showHtmlSource : false,
        maxLength:90000000,
        allowEditing: false,
        tools : {
            formatStyle : [  ],
            font : [ ],
            style : [ ],
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
            prehtmlContentsArea1ViewfocusCHeck = 'prehtmlContentsArea1_Iframe'
        }
    });
    
    prehtmlContentsArea1ViewObj = $("#prehtmlContentsArea1").data("ejRTE");
    
    setTimeout(function () {
        if ($("#prehtmlContentsArea1").length) {
            prehtmlContentsArea1ViewObj.setHtml(sendData);
        }
    }, 200);
}

//개인화 속성 값 조회
function setPersonalProperty(){
    //개인화 속성 로드
    $.ifvSyncPostJSON('<ifvm:action name="getConPersonalList"/>',{
        contentTypeCodeValue : "LOYPERSONALIZATION"
    }, function(result) {
        var size = result.length;
        arrStore = {};
        arrStore.markName = '';
        for (var i = size; i >= 0; i--) {
            if (i != 0) {
                temp = result[i - 1];
                result[i] = temp;
            }
            else {
                result[0] = {};
                result[0] = arrStore;
            }
        }
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal1").empty().append(temp);
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal2").empty().append(temp);
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal3").empty().append(temp);
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal4").empty().append(temp);
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal5").empty().append(temp);
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal6").empty().append(temp);
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal7").empty().append(temp);
    });
}

function emailInitPop(){
    
        $.ifvSyncPostJSON('<ifvm:action name="getEmailDtlList"/>', {
            id : conid
	     }, function(result) {
		      $('#pretitle').val(result.title)                                    //제목
		      sendData = result.html              //전송 메세지
	     });
}
function sendChannelTestFun(){
    emailValueCheck = $("#emailValueArea").ifvValidation();
    if(emailValueCheck.confirm()){
            $.ifvSyncPostJSON('<ifvm:action name="sendEmailTestSend"/>',{
                id                     :        conid
                ,emailValue        :       $('#emailValue').val()  
                ,persnal1          :         $('#persnal1').val()   
                ,persnal1Value :         $('#persnal1Value').val() 
                ,persnal2          :         $('#persnal2').val()   
                ,persnal2Value :         $('#persnal2Value').val() 
                ,persnal3          :         $('#persnal3').val()   
                ,persnal3Value :         $('#persnal3Value').val() 
                ,persnal4          :         $('#persnal4').val()   
                ,persnal4Value :         $('#persnal4Value').val()                 
                ,persnal5          :         $('#persnal5').val()   
                ,persnal5Value :         $('#persnal5Value').val() 
                ,persnal6          :         $('#persnal6').val()   
                ,persnal6Value :         $('#persnal6Value').val()          
                ,persnal7          :         $('#persnal7').val()   
                ,persnal7Value :         $('#persnal7Value').val()                      
            },
            function(result) {
                alert("<spring:message code='O00178'/>");
            },
            function(result) {
                alert("<spring:message code='O00179'/>");
            });
    } 
}

    $(document).ready(function(){
        setPersonalProperty();
        emailInitPop();

        rteInit();
         $('#sendChannelTest').on('click', function(){
             sendChannelTestFun();
         });
    });
</script>

<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>
</script>

<div class="content_pop_wrap" style="padding: 12px" id="emailPreviewPopupArea">
    <div class="email_preview_wrap">
          <div class="col-xs-12">
            <ifvm:inputNew type="textarea" id="pretitle"  conClass="10" label="제목" labelClass="2"  rows="1" maxLength="500" readonly="true"/>
         </div>
         <div class="col-xs-12">
            <ifvm:inputNew type="textarea" id="prehtmlContentsArea1"  conClass="10" label="전송 메세지" labelClass="2"  rows="20"  readonly="true"/>
         </div>
<!--         <div class="file_box row" style="display: none;"> -->
<%--             <span class="file_tit"><spring:message code="M00420"/></span> --%>
<!--             <p class="file_link"><a href="javascript:;" id="fileNameCon">파일 첨부된 이름</a></p> -->
<!--         </div> -->
        
    </div>
    <div class="send_desc_wrap" style="float: right; width: 192px; padding : 0px 0px 10px 20px">
        <div>
            <header class="temp_title">
                <p><spring:message code="M00424"/></p>
            </header>
            <ul class="description_guide">
                <li><spring:message code="M00425"/></li>
                <li><spring:message code="M00426"/></li>
                <li class="last"><spring:message code="M00427"/></li>
            </ul>
        </div>
        <div>
            <header class="temp_title">
                <p><spring:message code="이메일 주소"/></p>
            </header>
              <div class="form-horizontal row" id ="emailValueArea">
                                 <ifvm:inputNew type="text" placeholder="이메일 주소 입력" id="emailValue" className="form-control input_email" required="true" />
            
            </div>
        </div>        
        <div>
            <header class="temp_title">
                <p><spring:message code="개인화 테스트 발송"/></p>
            </header>
            
            <div class="form-horizontal row">
                        <div class="col-xs-12">
                                    <ifvm:input type="select" id="persnal1"/>
                        </div>
                        <ifvm:input type="text" placeholder="값 입력" id="persnal1Value" className="form-control input_email"  />
            </div>
            
            <div class="form-horizontal row">
                        <div class="col-xs-12">
                                    <ifvm:input type="select" id="persnal2"/>
                        </div>
                        <ifvm:input type="text" placeholder="값 입력" id="persnal2Value" className="form-control input_email"  />
            </div>
            
            <div class="form-horizontal row">
                        <div class="col-xs-12">
                                    <ifvm:input type="select" id="persnal3"/>
                        </div>
                        <ifvm:input type="text" placeholder="값 입력" id="persnal3Value" className="form-control input_email"  />
            </div>
            
            <div class="form-horizontal row">
                        <div class="col-xs-12">
                                    <ifvm:input type="select" id="persnal4"/>
                        </div>
                        <ifvm:input type="text" placeholder="값 입력" id="persnal4Value" className="form-control input_email"  />
            </div>            
            <div class="form-horizontal row">
                        <div class="col-xs-12">
                                    <ifvm:input type="select" id="persnal5"/>
                        </div>
                        <ifvm:input type="text" placeholder="값 입력" id="persnal5Value" className="form-control input_email"  />
            </div>
            <div class="form-horizontal row">
                        <div class="col-xs-12">
                                    <ifvm:input type="select" id="persnal6"/>
                        </div>
                        <ifvm:input type="text" placeholder="값 입력" id="persnal6Value" className="form-control input_email"  />
            </div>
            <div class="form-horizontal row">
                        <div class="col-xs-12">
                                    <ifvm:input type="select" id="persnal7"/>
                        </div>
                        <ifvm:input type="text" placeholder="값 입력" id="persnal7Value" className="form-control input_email"  />
            </div>                        
            <div class="text-center send_preview_btn_area">
                <button class="btn btn-sm btn_gray" id="sendChannelTest" objCode="emailPreviewTest_OBJ">         
                    <spring:message code="M00391"/>
                </button>
            </div>
        </div>
    </div>
</div>