<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="issueCardPopValid">
    <div class="form-horizontal underline top_well">
        <div class="row">
            <div class="col-xs-6">
               <ifvm:inputNew type="text" id="mbtNo" label="L00433" labelClass="3" conClass="8" disabled="true"/>
               <span class="input-group-addon" style="padding: 6px;" id="btnOfrCompPop"> <a><i class="fa fa-search"></i></a></span>
               <ifvm:inputNew type="hidden" id="mbrCardRid"/>
            </div>
            <div class="col-xs-6">
                 <ifvm:inputNew type="text" id="cardNo" label="V00046" labelClass="3" conClass="9"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                 <ifvm:inputNew type="text" id="issueDate" label="L00368" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="chnlNm" label="M01922" labelClass="3" conClass="8" disabled="true" required="true"/>
                <span class="input-group-addon" style="padding: 6px;" id="btnOfrPop"> <a><i class="fa fa-search"></i></a></span>
                <ifvm:inputNew type="hidden" id="ridChnl"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                 <ifvm:inputNew type="text" id="pswdNo" label="M01923" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="checkBox" id="existCardExpireFlg" label="M01924" labelClass="3" conClass="9"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="checkBox" id="mbrJoinTp" label="M01925" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                 <ifvm:inputNew type="text" id="custNm" label="L00435" labelClass="3" conClass="9"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="select" id="custTypeCd" names="custTypeCd" label="L00318" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="select" id="mbrTypeCd" names="mbrTypeCd" label="L02799" labelClass="3" conClass="9"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="select" id="identiTypeCd" names="identiTypeCd" label="M01926" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                 <ifvm:inputNew type="text" id="identiVal" label="L00342" labelClass="3" conClass="9"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                 <ifvm:inputNew type="text" id="hhpNo" label="L00436" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                 <ifvm:inputNew type="text" id="emailAddr" label="L01802" labelClass="3" conClass="9"/>
            </div>
        </div>
    </div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="btnIssueCardSave" objCode="issueCardPoptBtnSave_OBJ">
        <spring:message code="C00164" />
    </button>
    <button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="issueCardPoptBtnCancel_OBJ">
        <spring:message code="M00441" />
    </button>
</div>

<script type="text/javascript">
</script>