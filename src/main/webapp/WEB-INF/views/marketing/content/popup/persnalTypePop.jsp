<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var persnal_chnnelType ;
var persnal_id ;

/**
 * 개인화 치환 파일 화면 조회
 * 
 * @param getChnnelType 채널 종류
 * @param getId 컨텐츠 ID
 */
function persanlPop_getInitData(getChnnelType, getId) {

    persnal_chnnelType = getChnnelType;
    persnal_id = getId;

    $.ifvSyncPostJSON('<ifvm:action name="getContsPrsnlFile"/>', {
        contsId : persnal_id
    }, function(result) {
        
        // 등록된 개인화 파일이 존재함. 
        if (result != null) {
            $('#persnalFileUploadView').hide();
            $('#persnalFileDownloadView').show();

            $('#fileName').html('<span class="txt_link">' + result.oriFileName + '</span>');
            $('#fileName').attr('href', 'javascript:persanlPop_fileDownload("' + result.oriFileName + '","' + result.filePath + result.fileName + '")');
            
            $('#dataCnt').html('<span class="txt_blue">' + result.dataCnt + '</span> <spring:message code="C00036"/>');

            $('#persnalFileResult').parent().hide();
        }
        // 등록된 개인화 파일이 없음. 
        else {
            $('#persnalFileUploadView').show();
            $('#persnalFileDownloadView').hide();
        }
    });
}

/**
 * 개인화 파일 다운로드
 */
function persanlPop_fileDownload(getFileName, getFilePath) {
    var params = { 
          fileName: getFileName
        , filePath: getFilePath
    };
    $.fn.ifvmFileDownload(params);
}

/**
 * 개인화 파일 업로드
 */
function persanlPop_searchPersnalFile() {
    $("#persnalFileAdd").trigger('click');
}
function persnalPop_persnalFileAdd(_this) {
    if (_this.value) {
        var persnalForm = new FormData();
        persnalForm.append("file", $("#persnalFileAdd")[0].files[0]);
        persnalForm.append("contsId", persnal_id);
        
        $.ifvFilePostJSON('<ifvm:action name="uploadPrsnlFile"/>', persnalForm, 
        function(resultData) {

            // 상세화면 출력
            persanlPop_getInitData(persnal_chnnelType, persnal_id);
            
            // 메세지 출력
            $('#persnalFileResult').parent().show();
            if (resultData.dataInsert.success == true) {
                $('#persnalFileResult').html('<span class="txt_blue">' + '<spring:message code="M02364"/>' + '</span>');
            }
            else {
                $('#persnalFileResult').html('<span class="txt_red">' + '<spring:message code="M02365"/>' + '</span>');
            }
        });
    }
}

/**
 * 개인화 삭제 
 */
function persnalPop_removePersanl() {
    
    if (confirm('<spring:message code="C00079"/>')) {
        $.ifvSyncPostJSON('<ifvm:action name="removePrsnl"/>', {
            contsId : persnal_id
        }, function(result) {
            
            if (result.success == true) {
                alert('<spring:message code="L00034"/>');
            }
            
            persanlPop_getInitData(persnal_chnnelType, persnal_id);
        });
    }
}

$(document).ready(function() {

    $('#persnalFileUploadView').hide();
    $('#persnalFileDownloadView').hide();

    // 템플릿 다운로드 버튼 
    $('#persnalTempFileDownBtn').on('click', function() {
        persanlPop_fileDownload('persnalTemplate.csv', 'resources/fileDownload/persnalTemplate.csv');
    });

    // 개인화 파일 업로드 버튼
    $('#persnalFileUploadBtn').on('click', function() {
        persanlPop_searchPersnalFile();
    });
    $("#persnalFileAdd").on("change", function() {
        persnalPop_persnalFileAdd(this);
    });

    // 업로드 화면 닫기버튼
    $('#persnalFileUploadView #persnalPopCloseBtn').on('click', function() {
        uploadPersnalTypePopClose();
    });

    // 다운로드 화면 닫기버튼
    $('#persnalFileDownloadView #persnalPopCloseBtn').on('click', function() {
        uploadPersnalTypePopClose();
    });
    
    // 삭제 버튼
    $('#persnalFileDownloadView #persnalRemoveBtn').on('click', function() {
        persnalPop_removePersanl();
    });
});

</script>

<style>

#uploadPersnalTypePopup .control-label.label_txt {
    text-align: left;
    width: 250px;
}

#uploadPersnalTypePopup .control-label {
    width: 50px
}

#uploadPersnalTypePopup .guide_area {
    width: 100%;
}
#uploadPersnalTypePopup .guide_area .description_guide {
    margin-right: 18px;
    margin-bottom: 0px;
}

#uploadPersnalTypePopup .guide_area .description_guide li.guide_btn_area {
    background: none;
    text-align: center;
    padding: 10px 0px 0px 0px;
}
#uploadPersnalTypePopup .hidePersnalFile {
    width: 0px;
    height: 0px;
    overflow: hidden;
}

#uploadPersnalTypePopup span.txt_link {
    color: blue;
    font-weight: bold;
}

#uploadPersnalTypePopup span.txt_blue {
    color: #629ae4;
}

#uploadPersnalTypePopup span.txt_red {
    color: red;
}

</style>

<div id="persnalFileUploadView">
    <div class="pop_inner_wrap">
        <div class="guide_area form-horizontal underline top_well">
            <ul class="description_guide">
                <li><spring:message code="M02360"/></li>
                <li class="guide_btn_area">
                    <button class="btn_Load" id="persnalTempFileDownBtn">
                        <spring:message code="M01748"/>
                    </button>
                </li>
            </ul>
        </div>
    </div>
    <div class="pop_btn_area">
    
        <%-- 업로드버튼 --%>
        <button class="btn btn-sm btn_gray" id="persnalFileUploadBtn">
            <spring:message code="L01672"/>
        </button>
        <button class="btn btn-sm btn_gray" id="persnalPopCloseBtn">
            <spring:message code="L00970"/>
        </button>
    </div>
    <div class="hidePersnalFile">
        <ifvm:input type="file" id="persnalFileAdd"/>
    </div>
</div>

<div id="persnalFileDownloadView">

    <div class="pop_inner_wrap">
        
        <div class="guide_area form-horizontal underline top_well">
            <div class="description_guide">
                <div class="row">
                
                    <%-- 파일명 --%>
                    <label class="control-label"><spring:message code="L01626"/></label>
                    <label class="control-label label_txt"><a href="javascript:;" id="fileName"></a></label>
                </div>
                <div class="row">
                
                    <%-- 결과 --%>
                    <label class="control-label"><spring:message code="M02361"/></label>
                    <label class="control-label label_txt" id="persnalFileResult"></label>
                </div>
                <div class="row" style="margin-bottom: 0px;">
                    
                    <%-- 건수 --%>
                    <label class="control-label"><spring:message code="M02362"/></label>
                    <label class="control-label label_txt" id="dataCnt"></label>
                </div>
            </div>
        </div>        
    </div>
    <div class="pop_btn_area">
    
        <%-- 삭제버튼 --%>
        <button class="btn btn-sm btn_gray" id="persnalRemoveBtn">
            <spring:message code="M00275"/>
        </button>
        <button class="btn btn-sm btn_gray" id="persnalPopCloseBtn">
            <spring:message code="L00970"/>
        </button> 
    </div>
</div>
