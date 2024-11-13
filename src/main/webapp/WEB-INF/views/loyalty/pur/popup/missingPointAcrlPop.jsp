<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
    <div class="pop_inner_wrap" >
        <div class="temp_title_bb">
            누락포인트 조정
        </div>
    </div>
    <div class="form-horizontal" id="msPntForm">
        <%-- <div class="row">
            <ifvm:inputNew
				type="text"
				id="reasonCd1"
				dto="reasonCd1"
				required="true"
				label="사유코드"
				nuc="true"
				labelClass="2"
				conClass="3"
				maxLength="24"/>
        </div> --%>
        <div class="row">
            <ifvm:inputNew
				type="select"
				id="reasonCd2"
				dto="reasonCd2"
				required="true"
				label="사유코드"
				text="시스템오류|영수증분실"
				values="시스템오류|영수증분실"
				nuc="true"
				labelClass="2"
				conClass="3"/>
        </div>
		<div class="row">
			<ifvm:inputNew
				id="addPnt"
				dto="addPnt"
				type="text"
				required="true"
				label="지급할포인트액"
				labelClass="2"
				conClass="3"
				nuc="true"
				maxLength="5" />
		</div>
        <div class="row">
            <ifvm:inputNew
				type="textarea"
				id="desc"
				dto="desc"
				label="메모"
				nuc="true"
				labelClass="2"
				conClass="9"
				rows="5"
				maxLength="500"/>
        </div>
    </div>
</div>
<br/>

<div class="pop_btn_area">
    <ifvm:inputNew
            type="button"
            btnType="save"
            text="저장"
            nuc="true"
            btnFunc="addPnt"/>
    <ifvm:inputNew
            type="button"
            btnType="cancel"
            text="취소"
            nuc="true"
            btnFunc="missingPointAcrlPopClose"/>
</div>

<script>
    //지역변수
    var msPntFormVali = $("#msPntForm").ifvValidation();

    //getCommCodeList();

    //공통코드 조회
    function getCommCodeList() {
        $.ifvGetCommCodeList("select", "pgmTypeCd", "<ifvm:action name='getCommCodeList'/>", "JOB_PGM_TYPE_CD", "neims", false, false);
    }

    //누락 포인트 추가
    function addPnt() {
        if (msPntFormVali.confirm()) {
            var sendData = $("#msPntForm").getSubmitData();
            var url = "<ifvm:action name='addPnt'/>";
            var confirmMsg = "저장되었습니다.";
            $.ifvPostJSON(
                url,
                sendData,
                function () {
                    missingPointAcrlPopClose();
                    //jobGrid.requestData();
                    alert(confirmMsg);
                }
            );
        }
    }
    
</script>