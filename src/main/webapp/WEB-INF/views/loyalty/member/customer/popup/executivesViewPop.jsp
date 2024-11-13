<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script id="mbrStatCdNewTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script type="text/javascript">
var lcirid = null;
var lcrid = null;

    function initMain() {
        
        $.ifvSyncPostJSON('<ifvm:action name="getExecutivesPopComm"/>',{
        }, function(result){
            var temp = $("#mbrStatCdNewTemp").tmpl(result);
            $("#mbrStatCdNew").append(temp);
        });
        
        $.ifvSyncPostJSON('<ifvm:action name="executivesViewSelect"/>',{
            mbrRid :  mbr_rid
            }, function(result){
                $("#mktExec").dataSetting(result);
                lcirid = result.lcirid;
                lcrid = result.lcrid;

        });
        

    }
    function saveBtnFun(){
            $.ifvSyncPostJSON('<ifvm:action name="executivesExistSelect"/>',{
                empNo :  $("#empNoNew").val()
            }, function(result1){
			       if(result1 != null && result1 != ''){
			                        $.ifvSyncPostJSON('<ifvm:action name="empNoUpdateExecutives"/>',{
			                              custiRid :  lcirid,
			                              mbrRid :  mbr_rid,
			                              empNo : $("#empNo").val(),
			                              empNoNew : $("#empNoNew").val()
			                         }, function(result2){
			                             if(result2.message == 'notExist'){
			                                           $.ifvSyncPostJSON('<ifvm:action name="StatCdUpdateExecutives"/>',{
			                                               mbrRid :  mbr_rid,
			                                               custRid : lcrid,
			                                               mbrStatCd : $("#mbrStatCdNew").val(),
			                                               custStatCd : $("#mbrStatCdNew").val(),
			                                               oldMbrStatCd : $("#mbrStatCd").val()
			                                           }, function(result3){
			                                               alert('<spring:message code="C00094"/>');
			                                               executivesViewClosePop();
			                                               history.back();
			                                               //qtjs.href('<ifvm:url name="mbrListNewPage"/>' + '?rid=' + mbr_rid);
			                                       });       
			                                } else {
			                                     alert('<spring:message code="C00179"/>');
			                                }
			                          });
                        } else {
                            if($('#mbrStatCdNew').val() != 'S'){
		                            if($("#empNoNew").val() != null && $("#empNoNew").val() != ''){
			                            alert('<spring:message code="C00180"/>');
		                            } else {
		                                alert('<spring:message code="C00181"/>');
		                            }
                            } else {
	                                        $.ifvSyncPostJSON('<ifvm:action name="StatCdUpdateExecutives"/>',{
	                                                     mbrRid :  mbr_rid,
	                                                     custRid : lcrid,
	                                                     mbrStatCd : $("#mbrStatCdNew").val(),
	                                                     custStatCd : $("#mbrStatCdNew").val(),
	                                                     oldMbrStatCd : $("#mbrStatCd").val()
	                                        }, function(result3){
	                                                     alert('<spring:message code="C00182"/>');
	                                                     executivesViewClosePop();
	                                                     history.back();
	                                                     //qtjs.href('<ifvm:url name="mbrListNewPage"/>' + '?rid=' + mbr_rid);
	                                        });       
	                               }
                        }
     	      });
    }
    
    $(document).ready(function() {
        
        initMain();
		    //저장버튼
		$("#saveBtn").click(function() {
		    saveBtnFun();
		});
		//취소버튼
		$("#cancelBtn").click(function() {
		    executivesViewClosePop();
		});
    });
</script>
<div class="form-horizontal top_well underline" id="mktExec">
        <div class="row">
              <ifvm:inputNew type="text" id="empNo" dto="empNo"  label="사원번호 변경" labelClass="4" disabled="true" conClass="4" required="true"/>
              <ifvm:inputNew type="text" id="empNoNew" dto="empNoNew" title="변경할 사원번호" conClass="4" disabled="false"  />
        </div>
        <div class="row">
              <ifvm:inputNew type="text" id="mbrStatCd" dto="mbrStatCd"  label="상태 변경" title="인증유형" labelClass="4" conClass="4" disabled="true" />
              <ifvm:inputNew type="select" id="mbrStatCdNew" names="mbrStatCdNew"  dto="mbrStatCdNew"  conClass="4"/>
        </div>
</div>

<!-- End -->
<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <!-- 저장 -->
        <button class="btn btn-sm btn_gray" id="saveBtn" objCode="saveBtn_OBJ">
            <spring:message code="C00164"/>
        </button>
        <!-- 닫기 --> 
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="cancelBtn_OBJ">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>