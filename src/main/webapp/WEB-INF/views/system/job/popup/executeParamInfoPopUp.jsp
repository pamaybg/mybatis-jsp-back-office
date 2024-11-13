<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<div>
    <div class="form-horizontal">
        <div class="pop_inner_wrap">
            <div class="temp_title_bb">
                기본 정보
            </div>
        </div>
        <div class="row" id="jobStepParamInfoForm">
            <div class="col-xs-6">
                <ifvm:inputNew type="select" id="argsType" dto="argsType" required="true" label="인수 유형" nuc="true" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="number" id="argsSeq" dto="argsSeq" required="true" label="인수 순서" nuc="true" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="argsNm" dto="argsNm" required="true" label="인수 명" nuc="true" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="argsVal" dto="argsVal" label="인수 값" nuc="true" labelClass="3" conClass="9"/>
            </div>
        </div>
    </div>
</div>
<br/>

<div class="pop_btn_area">
    <ifvm:inputNew type="button" btnType="save" text="저장" nuc="true" btnFunc="saveParamInfo" objCode="saveParamInfo_OBJ"/>
    <ifvm:inputNew type="button" btnType="cancel" text="취소" nuc="true" btnFunc="paramPopupClose" objCode="paramPopupClose_OBJ"/>
</div>

<script>
    var infoRid = '<%=cleanXss(request.getParameter("rid"))%>';
    if(infoRid == 'null' || infoRid =='undefined') infoRid = null;

    $(document).ready(function(){
        commcode();
        if($.fn.ifvmIsNotEmpty(infoRid)) {
            paramInfoDtl();
        }
    });

    function commcode(){
        $.ifvGetCommCodeList('select', 'argsType', '<ifvm:action name="getCommCodeList"/>', 'ARGS_TYPE', 'com', false, true, true);
    }

    //상세
    function paramInfoDtl(){
        $.ifvPostJSON('<ifvm:action name="getParamInfoDtl"/>',{
                rid : infoRid
        },function(result){
            $('#argsType').val(result.argsType);
            $('#argsSeq').val(result.argsSeq);
            $('#argsNm').val(result.argsNm);
            $('#argsVal').val(result.argsVal);
        });
    }

    //저장및 수정
    function saveParamInfo(){
        var validation = $('#jobStepParamInfoForm').ifvValidation();
        if(validation.confirm()){
            let dataUrl;
            if($.fn.ifvmIsEmpty(infoRid)){
                dataUrl = '<ifvm:action name="saveParamInfo"/>';
            }else{
                dataUrl = '<ifvm:action name="editParamInfo"/>';
            }

            $.ifvPostJSON(dataUrl, {
                    argsType : $('#argsType').val(),
                    argsSeq : $('#argsSeq').val(),
                    argsNm : $('#argsNm').val(),
                    argsVal : $('#argsVal').val(),
                    rid : gJobStepParamRid,
                    infoRid : infoRid
                },
                function(){
                    if(infoRid == null){
                        alert('저장되었습니다.');
                    }else{
                        alert('수정되었습니다.');
                    }
                    infoExecuteParamGridFn();
                    paramPopupClose();
                },function(){
                    alert('저장실패');
                    paramPopupClose();
                }
            )
        }
    }
</script>