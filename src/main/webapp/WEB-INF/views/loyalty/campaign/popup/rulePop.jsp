<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div class="form-horizontal underline top_well" id="promotionInfoDetail">
        
        	<div class="page_btn_area">
				<div class="col-xs-12">
					<span style="font-size: 10pt">프로모션 유형</span>
				</div>
			</div>
        
            <div class="row qt_border">

                <%-- <%-- 캠페인명 --%>
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="대유형"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="promTypeLv1Cd" names="promTypeLv1Cd" required="true" dto="promTypeLv1Cd" maxLength="50"  />
                    <ifvm:input type="hidden" id="promStatCd" names="promStatCd" />
                </div>
                
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="소유형"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="promTypeLv2Cd" dto="promTypeLv2Cd" required="true" names="promTypeLv2Cd" maxLength="50"  />
                </div> 
                
            </div>
            <div class="row qt_border">

                <%-- 유형 --%>
                <label class="col-xs-1 control-label"><spring:message code="오퍼"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="ofrNo" dto="ofrNo" disabled="true" names="ofrNo"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="ofrNm" dto="ofrNm" names="ofrNm" disabled="true" />
                    <span class="input-group-addon" id="offerSearchPopBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>

            </div>
           <div class="row qt_border">

                <label class="col-xs-1 control-label"><spring:message code="오퍼 수량 정의"/></label>
                <div class="col-xs-4 control_content">
                   		<ifvm:input type="select" id="promOfferAmtDefCd" names="promOfferAmtDefCd" dto="promOfferAmtDefCd" />
                </div>
                
            </div>
             
            <div class="row qt_border">

                <%-- 유형 --%>
                <label class="col-xs-1 control-label"><spring:message code="대상 고객군"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="tgtGrpNo" dto="tgtGrpNo" disabled="true" names="tgtGrpNo"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="tgtGrpNm" dto="tgtGrpNm" names="tgtGrpNm" disabled="true" />
                    <span class="input-group-addon" id="tgtGrpIncPopBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>
                
                <label class="col-xs-1 control-label"><spring:message code="제외 고객군"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="expectTgtGrpNo" dto="expectTgtGrpNo" disabled="true" names="expectTgtGrpNo"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="expectTgtGrpNm" dto="expectTgtGrpNm" names="expectTgtGrpNm" disabled="true" />
                    <span class="input-group-addon" id="expectTgtGrpIncPopBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>

            </div>

			<div class="page_btn_area">
				<div class="col-xs-12">
					<span style="font-size: 10pt">Rule 설정</span>
				</div>
			</div>

			<div id="ruleDetail">
				
				
    		</div>
    		<br>
    <div class="pop_btn_area">
        <%-- 저장 --%>
        <button class="btn btn-sm btn_gray" id="promRuleSaveBtn" objCode="rulePopSave_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- 닫기 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="promRuleCancelBtn" objCode="rulePopCancel_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

<div id="offerListPop" class="popup_container"></div>
<div id="offerissListPop" class="popup_container"></div>
<div id="tgtGrpIncPop" class="popup_container"></div>
<div id="chnlTgtGrpPop" class="popup_container"></div>
<div id="prodTgtGrpPop" class="popup_container"></div>
<div id="prodTgtGrpPop2" class="popup_container"></div>
<div id="expectTgtGrpIncPop" class="popup_container"></div>
<div id="sa1RuleOfrPop" class="popup_container"></div>
<div id="clubListPop" class="popup_container"></div>
<div id="surveyListPop" class="popup_container"></div>

<script id="sa1genTemp" type="text/x-jquery-tmpl">
<div class="row qt_border" id="ruleSa1GridList">
	        		<div class="col-xs-6">
	            		<label id="label"><ifvm:input type="checkBox" names="chnlConYn" id="chnlConYn"/><spring:message code="채널(판매처)조건"/></label> 
	       			 </div>
	       			 
	       			 
	       			 <div class="col-xs-15">
	            		<label id="label"><ifvm:input type="checkBox" names="payMethYn" id="payMethYn"/><spring:message code="결제 수단 조건"/></label> 
	       			 </div>
				</div>
				
				<div class="row qt-border">
				
				<label class="col-xs-1 control-label"><spring:message code="대상그룹"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="chnlTgtGrpNo" dto="chnlTgtGrpNo" disabled="true" names="chnlTgtGrpNo"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="chnlTgtGrpNm" dto="chnlTgtGrpNm" names="chnlTgtGrpNm" disabled="true" />
                    <span class="input-group-addon" id="chnlTgtGrpBtn" onClick="chnlTgtGrpPopup()">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>
                
                <label class="col-xs-2 control-label"><spring:message code="결제수단"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="select" id="payMethTypeCd" dto="payMethTypeCd" names="payMethTypeCd"  />
                </div>
                
				</div>
				
				<br>
				
				<div class="row qt_border">
	        		<div class="col-xs-8">
	            		<label id="label"><ifvm:input type="checkBox" names="prodConYn" id="prodConYn"/><spring:message code="상품 조건"/></label> 
	       			 </div>
				</div>
				
				<div class="row qt-border">
				
				<label class="col-xs-1 control-label"><spring:message code="대상그룹1"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="prodTgtGrpNo" dto="prodTgtGrpNo" disabled="true" names="prodTgtGrpNo"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="prodTgtGrpNm" dto="prodTgtGrpNm" names="prodTgtGrpNm" disabled="true" />
                    <span class="input-group-addon" id="prodTgtGrpBtn" onClick="prodTgtGrpPopup()">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>
                
				</div>
				
				<div class="row qt-border">
				
				<label class="col-xs-1 control-label"><spring:message code="대상그룹2"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="prodTgtGrpNo2" dto="prodTgtGrpNo2" disabled="true" names="prodTgtGrpNo2"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="prodTgtGrpNm2" dto="prodTgtGrpNm2" names="prodTgtGrpNm2" disabled="true" />
                    <span class="input-group-addon" id="prodTgtGrpBtn2" onClick="prodTgtGrpPopup2()">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>
                
				</div>
				
				
				<div class="row qt-border">
				
				<label class="col-xs-1 control-label"><spring:message code="모든 그룹 구매"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="checkBox" id="prodGrpAllYn" dto="prodGrpAllYn" names="prodGrpAllYn"  />
                </div>
                
				</div>
				
				<br>
				
				<div class="row qt_border">
	        		<div class="col-xs-8">
	            		<label id="label"><ifvm:input type="checkBox" checked="checked" names="sellAmtOfrYn" id="sellAmtOfrYn"/><spring:message code="금액대"/></label> 
	       			 </div>
				</div>
				
</script>

<script id="sa1genXmTemp" type="text/x-jquery-tmpl">
				<div class="row qt_border ruleSa1GridList" ruleSa1SeqNo=${'${'}ruleSa1SeqNo} id="ruleSa1GridList${'${'}ruleSa1SeqNo}">
				<div class="flex_btn_area">
        			<button class="btn_searchitem_add_remove actionItemPlusBtn" onClick="addSa1PlusBtn()">Plus</button>
        			<button class="btn_searchitem_add_remove actionItemMinusBtn" onClick="removeSa1MinusBtn(${'${'}ruleSa1SeqNo})" id="itemSa1Minusfirst${'${'}ruleSa1SeqNo}">Minus</button>
    			</div>

	    		<div class="col-xs-1 control_content">
        			<ifvm:input type="text" id="startVal${'${'}ruleSa1SeqNo}" className = "text-right"  />
        		</div>
        			<div style="float: left">~</div>
        		<div class="col-xs-1 control_content">
        			<ifvm:input type="text" id="endVal${'${'}ruleSa1SeqNo}" className = "text-right"  />
        		</div>
 
  					<ifvm:input type="hidden" id="sa1RuleRid${'${'}ruleSa1SeqNo}" names="tierGroupRid" />
  					<ifvm:input type="hidden" id="sa1RuleOfrRid${'${'}ruleSa1SeqNo}" names="tierGroupRid" />
					<ifvm:input type="hidden" id="sa1CpnYn${'${'}ruleSa1SeqNo}" names="tierGroupRid" />
  					<ifvm:input type="hidden" id="salRuleXmRid${'${'}ruleSa1SeqNo}" names="promActTierRid" />
   		
   				<label class="col-xs-1 control-label"><spring:message code="오퍼"/></label>
                <div class="col-xs-1 control_content">
                    <ifvm:input type="text" id="sa1RuleOfrNo${'${'}ruleSa1SeqNo}" dto="sa1RuleOfrNo${'${'}ruleSa1SeqNo}" disabled="true" names="sa1OfrNo${'${'}ruleSa1SeqNo}"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="sa1RuleOfrNm${'${'}ruleSa1SeqNo}" dto="sa1RuleOfrNm${'${'}ruleSa1SeqNo}" names="sa1OfrNm${'${'}ruleSa1SeqNo}" disabled="true" />
                    <span class="input-group-addon" id="sa1RuleOfrPopup" onClick="sa1RuleOfrPopup('\${ruleSa1SeqNo}')">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>

				<div class="col-xs-1 control_content">
    					<ifvm:input type="select" id="ofrAmtType${'${'}ruleSa1SeqNo}"  names="ofrAmtType${'${'}ruleSa1SeqNo}" className="searchConditionOfrAmtTpye" />
					</div>
			
        		<label class="col-xs-1 control-label"><spring:message code="수량/적립금"/></label>
        		<div class="col-xs-1 control_content">
        			<ifvm:input type="number" id="ofrAmt${'${'}ruleSa1SeqNo}" className="text-right"/>
					</div><lebel id="info${'${'}ruleSa1SeqNo}"></lebel>
        		</div>
        
       			
       
    	</div>
</script>

<script id="sa1AniTemp" type="text/x-jquery-tmpl">
	<div class="row qt_border" id="ruleSa1AniGridList">
				<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="유형"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="conditionCd" names="conditionCd" dto="conditionCd" maxLength="50"  />
                </div>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="operCd" dto="operCd" required="true" names="operCd" maxLength="50"  />
                </div> 
                <div class="col-xs-1 control_content">
                    <ifvm:input type="number" id="dayVal" dto="dayVal" required="true" names="dayVal"  className="text-right"  />
                </div>
                <label class="control-label" style="margin-left:0px">일</label>
            </div>            			
</script>

<script id="ac2ConTemp" type="text/x-jquery-tmpl">
<div class="row qt_border" id="ruleSa1GridList">
				<label class="col-xs-3 control-label"></label>
					<div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="hhpYn" id="hhpYn"/><spring:message code="HHP"/></label>
	       			 </div>
	       			 
	       			 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="emailYn" id="emailYn"/><spring:message code="이메일"/></label>
	       			 </div>
	       			 
	       			 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="addrYn" id="addrYn"/><spring:message code="주소"/></label>
	       			 </div>
</div>
</script>

<script id="ac2AgrTemp" type="text/x-jquery-tmpl">
<div class="row qt_border" id="ruleSa1GridList">
					<div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="textYn" id="textYn"/><spring:message code="문자"/></label>
	       			 </div>
	       			 
	       			 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="emailYn" id="emailYn"/><spring:message code="이메일"/></label>
	       			 </div>
	       			 
	       			 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="tmYn" id="tmYn"/><spring:message code="TM"/></label>
	       			 </div>
					
					 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="dmYn" id="dmYn"/><spring:message code="DM"/></label>
	       			 </div>
					
					 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="pushYn" id="pushYn"/><spring:message code="Push"/></label>
	       			 </div>
					
					 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="checkBox" names="kkfYn" id="kkfYn"/><spring:message code="친구톡"/></label>
	       			 </div>
</div>
</script>

<script id="ac2SurTemp" type="text/x-jquery-tmpl">
	<div class="row qt_border" id="ruleAc1ClbGridList">
	<label class="col-xs-1 control-label"><spring:message code="설문"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="surveyNo" dto="surveyNo" disabled="true" names="surveyNo"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="surveyNm" dto="surveyNm" names="surveyNm" disabled="true" />
                    <span class="input-group-addon" id="surveyPopup" onClick="surveyPopup()">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>
</div>
</script>


<script id="sa2SumTemp" type="text/x-jquery-tmpl"> 
	<div class="row qt_border ruleSa2SumGridList" ruleSa2SumSeqNo=${'${'}ruleSa2SumSeqNo} id="ruleSa2SumGridList${'${'}ruleSa2SumSeqNo}">
				<div class="flex_btn_area">
        			<button class="btn_searchitem_add_remove actionItemPlusBtn" onClick="addSa2SumPlusBtn()">Plus</button>
        			<button class="btn_searchitem_add_remove actionItemMinusBtn" onClick="removeSa2SumMinusBtn(${'${'}ruleSa2SumSeqNo})" id="itemSa2SumMinusfirst${'${'}ruleSa2SumSeqNo}">Minus</button>
    			</div>

	    		<div class="col-xs-1 control_content">
        			<ifvm:input type="text" id="sa2SumStartVal${'${'}ruleSa2SumSeqNo}" className = "text-right"  />
        		</div>
        			<div style="float: left">~</div>
        		<div class="col-xs-1 control_content">
        			<ifvm:input type="text" id="sa2SumEndVal${'${'}ruleSa2SumSeqNo}" className = "text-right"  />
        		</div>
 
  					
  					<ifvm:input type="hidden" id="sa2SumRuleOfrRid${'${'}ruleSa2SumSeqNo}" names="tierGroupRid" />
  					<ifvm:input type="hidden" id="sa2SumRuleRid${'${'}ruleSa2SumSeqNo}" names="promActTierRid" />
   		
   				<label class="col-xs-1 control-label"><spring:message code="오퍼"/></label>
                <div class="col-xs-1 control_content">
                    <ifvm:input type="text" id="sa2SumRuleOfrNo${'${'}ruleSa2SumSeqNo}" dto="sa2SumRuleOfrNo${'${'}ruleSa2SumSeqNo}" disabled="true" names="sa2SumRuleOfrNo${'${'}ruleSa2SumSeqNo}"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="sa2SumRuleOfrNm${'${'}ruleSa2SumSeqNo}" dto="sa2SumRuleOfrNm${'${'}ruleSa2SumSeqNo}" names="sa1OfrNm${'${'}ruleSa2SumSeqNo}" disabled="true" />
                    <span class="input-group-addon" id="sa2SumRuleOfrPopup" onClick="sa1RuleOfrPopup('\${ruleSa2SumSeqNo}')">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>

				<div class="col-xs-1 control_content">
    					<ifvm:input type="select" id="sa2SumOfrAmtType${'${'}ruleSa2SumSeqNo}"  names="sa2SumOfrAmtType${'${'}ruleSa2SumSeqNo}" className="searchConditionOfrAmtTpye" />
					</div>
			
        		<label class="col-xs-1 control-label"><spring:message code="수량/적립금"/></label>
        		<div class="col-xs-1 control_content">
        			<ifvm:input type="number" id="sa2SumOfrAmt${'${'}ruleSa2SumSeqNo}" className="text-right"/>
        		</div>
        
       			
       
    	</div>
</script>

<script id="ac2OnTemp" type="text/x-jquery-tmpl">
	<div id="ruleAc2OnGridValid"> 
	<div class="row qt_border ruleAc2OnGridList" ruleAc2OnSumSeqNo=${'${'}ruleAc2OnSeqNo} id="ruleAc2OnGridList${'${'}ruleAc2OnSeqNo}">
				<div class="flex_btn_area">
        			<button class="btn_searchitem_add_remove actionItemPlusBtn" onClick="addAc2OnPlusBtn()">Plus</button>
        			<button class="btn_searchitem_add_remove actionItemMinusBtn" onClick="removeAc2OnMinusBtn(${'${'}ruleAc2OnSeqNo})" id="itemAc2OnMinusfirst${'${'}ruleAc2OnSeqNo}">Minus</button>
    			</div>

        		<div class="col-xs-2 control_content">
        			<ifvm:input type="select" id="onlActCd${'${'}ruleAc2OnSeqNo}" names="onlActCd${'${'}ruleAc2OnSeqNo}" />
        		</div>
			
  					<ifvm:input type="hidden" id="ac2OnRuleOfrRid${'${'}ruleAc2OnSeqNo}" names="tierGroupRid" />
  					<ifvm:input type="hidden" id="ac2OnRuleRid${'${'}ruleAc2OnSeqNo}" names="promActTierRid" />
   		
   				<label class="col-xs-1 control-label"><spring:message code="오퍼"/></label>
                <div class="col-xs-1 control_content">
                    <ifvm:input type="text" id="ac2OnRuleOfrNo${'${'}ruleAc2OnSeqNo}" dto="ac2OnSumRuleOfrNo${'${'}ruleAc2OnSeqNo}" disabled="true" names="ac2OnOfrNo${'${'}ruleAc2OnSeqNo}"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="ac2OnRuleOfrNm${'${'}ruleAc2OnSeqNo}" dto="ac2OnRuleOfrNm${'${'}ruleAc2OnSeqNo}" names="ac2OnOfrNm${'${'}ruleAc2OnSeqNo}" disabled="true" />
                    <span class="input-group-addon" id="sa1RuleOfrPopup" onClick="sa1RuleOfrPopup('\${ruleAc2OnSeqNo}')">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>

				    <div class="col-xs-1 control_content">
    					<ifvm:input type="select" id="ac2OnOfrAmtType${'${'}ruleAc2OnSeqNo}"  names="ac2OnOfrAmtType${'${'}ruleAc2OnSeqNo}" className="searchCondition" />
					</div>
			
        		<label class="col-xs-1 control-label"><spring:message code="수량"/></label>
        		<div class="col-xs-1 control_content">
        			<ifvm:input type="number" id="ac2OnOfrAmt${'${'}ruleAc2OnSeqNo}" className="text-right"/>
        		</div>
        
       			
       
    	</div>
</div>
</script>

<script id="ac2AddTemp" type="text/x-jquery-tmpl"> 
	<div class="row qt_border ruleAc2AddGridList" ruleAc2AddSumSeqNo=${'${'}ruleAc2AddSeqNo} id="ruleAc2OnGridList${'${'}ruleAc2AddSeqNo}">
				<div class="flex_btn_area">
        			<button class="btn_searchitem_add_remove actionItemPlusBtn" onClick="addAc2AddPlusBtn()">Plus</button>
        			<button class="btn_searchitem_add_remove actionItemMinusBtn" onClick="removeAc2AddMinusBtn(${'${'}ruleAc2AddSeqNo})" id="itemAc2AddMinusfirst${'${'}ruleAc2AddSeqNo}">Minus</button>
    			</div>

        		<div class="col-xs-2 control_content">
        			<ifvm:input type="select" id="addInfoCd${'${'}ruleAc2AddSeqNo}" names="addInfoCd${'${'}ruleAc2AddSeqNo}" />
        		</div>
			
  					<ifvm:input type="hidden" id="ac2AddRuleRid${'${'}ruleAc2AddSeqNo}" names="promActTierRid" />
    	</div>
</script>

<script id="ac1JoinTemp" type="text/x-jquery-tmpl"> 
	<div class="row qt_border" id="ruleAc1JoinGridList">
					<label class="col-xs-3 control-label"></label>
					<div class="col-xs-2">
	            		<label id="label"><ifvm:input type="radio" names="Join" id="ALL"/><spring:message code="전체"/></label>
	       			 </div>
	       			 
	       			 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="radio" names="Join" id="APP"/><spring:message code="앱"/></label>
	       			 </div>
	       			 
	       			 <div class="col-xs-1">
	            		<label id="label"><ifvm:input type="radio" names="Join" id="CHNL"/><spring:message code="특정채널그룹"/></label>
 					</div>
                </div>
</script>

<script id="ac1FrndTemp" type="text/x-jquery-tmpl"> 
	<div class="row qt_border" id="ruleAc1FrndGridList">
					<label class="col-xs-3 control-label"></label>
					<div class="col-xs-1">
	            		<label id="label"><ifvm:input type="radio" names="frnd" id="ONLY"/><spring:message code="추천인 Only"/></label>
	       			 </div>

					<label class="col-xs-1 control-label"></label>
					<div class="col-xs-2">
	            		<label id="label"><ifvm:input type="radio" names="frnd" id="NONLY"/><spring:message code="피추천인 Only"/></label>
	       			 </div>
	       			 
	       			 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="radio" names="frnd" id="NOTONLY"/><spring:message code="추천인+피추천인"/></label>
	       			 </div>

					

</div>
</script>

<script id="ac1FamTemp" type="text/x-jquery-tmpl"> 
	<div class="row qt_border" id="ruleAc1FamGridList">
					<label class="col-xs-4 control-label"></label>
					<div class="col-xs-2">
	            		<label id="label"><ifvm:input type="radio" names="fam" id="F"/><spring:message code="최초 구성시"/></label>
	       			 </div>
	       			 
	       			 <div class="col-xs-2">
	            		<label id="label"><ifvm:input type="radio" names="fam" id="A"/><spring:message code="가족 추가시 마다"/></label>
	       			 </div>

</div>
</script>

<script id="ac1CardTemp" type="text/x-jquery-tmpl"> 
<div class="row qt_border" id="ruleAc1CardGridList">
	<label class="col-xs-1 control-label"><spring:message code="채널그룹"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="chnlTgtGrpNo" dto="chnlTgtGrpNo" disabled="true" names="chnlTgtGrpNo"  />
                </div>
</div>
</script>

<script id="ac1ClbTemp" type="text/x-jquery-tmpl"> 
<div class="row qt_border" id="ruleAc1ClbGridList">
	<label class="col-xs-1 control-label"><spring:message code="클럽"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="clubNo" dto="clubNo" disabled="true" names="clubNo"  />
                </div>
                <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="clubNm" dto="clubNm" names="clubNm" disabled="true" />
                    <span class="input-group-addon" id="clubPopup" onClick="clubPopup()">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>
</div>
</script>

<script>
var promTypeLv1Cd=null;
var promTypeLv2Cd=null;
var ruleOfrRid=null;
var ruleTgtGrpRid=null;
var ruleExpectTgtGrpRid=null;
var promRuleRid=null;

var typeCheck=true;

//SA1(구매일반전용 변수)
var ruleSa1SeqNo = 1;
var prodTgtGrpRid=null;
var prodTgtGrpRid2=null;
var chnlTgtGrpRid=null;
var promSa1RuleRid=null;;
var ruleXmSaveYn = false;

//SA1ANI(기념일 전용 변수)
var promSa1AniRuleRid=null;

//AC2CON(연락처 갱신 전용 변수)
var promAc2ConRuleRid=null;

//AC2AGR(동의 전용 변수)
var promAc2AgrRuelRid=null;

//AC2SUR설문전용변수
var promAc2SurRuleRid=null;
var surveyRid=null;

//누적(횟수,금액)변수
var ruleSa2SumSeqNo = 1;

//온라인활동 변수
var ruleAc2OnSeqNo = 1;

//부가정보 변수
var ruleAc2AddSeqNo = 1;

//회원용 변수
var ac1JoinChnlTgtGrpRid=null;
var promAc1JoinRuleRid=null;

//추천용 변수
var promAc1FrndRuleRid=null;

//가구화 변수
var promAc1FamRuleRid=null;

//클럽 변수
var promAc1ClbRuleRid=null;
var clubRid=null;

//카드 전용변수
var promAc1CardRuleRid=null;
var promAc1CardChnlTgtRid=null;

var rtnDatas = [];
var removeRtnDatas = [];

var defaultOfrNo = null;
var defaultOfrNm = null;
var defaultOfrRid = null;
var defaulPromOfrCd = null;
var ofrPromRuleYn=null;

$(document).on("change", '.searchConditionOfrAmtTpye', function() {
	ofrValTypeChange($(this).attr("id"));
});

function ofrValTypeChange(temp) {

	var btnSeqNo = temp.charAt(temp.length-1);
	$("#"+temp).parents("seqNo");
	if(cpnYn=='Y') {	
		$("#info"+btnSeqNo).text("개");
 	 } else {
 		 if($("#"+temp).val()=='RATE') $("#info"+btnSeqNo).text("%");
 		 else if($("#"+temp).val()=='AMT') $("#info"+btnSeqNo).text("P");
 		 else if($("#"+temp).val()=='RULE') $("#info"+btnSeqNo).text("%");
 		 else $("#info"+btnSeqNo).text("");
 	 } 
}

function rulePopupInit() {
	
	$.fn.ifvmSetSelectOptionCommCode("promTypeLv1Cd", "PROM_TYPE_LV1",null,null,true);


    //조직
    $.fn.ifvmSetSelectOptionCommCodeSync("promTypeLv2Cd", "PROM_TYPE_LV2", null, "promTypeLv1Cd", false);
    
    $.fn.ifvmSetSelectOptionCommCode("promOfferAmtDefCd", "PROM_OFFER_AMT_DEF", null, null, true);
	
	cDialog.model.title = '보상 Rule 상세 정보';
    $("#dialog_title").append('보상 Rule 상세 정보');
    cDialog.model.width = "1450";
    cDialog.model.close = "closerulePop";
}

function rulePopupData() {
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromRuleInfo"/>', {
    	rid : campaign.id
    },
    function(result) {
    	
    	    $("#promotionInfoDetail").dataSetting(result);
    		$("#promStatCd").val(result.promStatCd);
    		defaulPromOfrCd = result.promOfferAmtDefCd;
    	    defaultOfrNo =  result.ofrNo;
    	    defaultOfrNm =  result.ofrNm;
    	    defaultOfrRid =  result.ofrRid;	
    		
    		promTypeLv1Cd = result.promTypeLv1Cd;
			promTypeLv2Cd = result.promTypeLv2Cd;
			
			$.fn.ifvmSetSelectOptionCommCode("promTypeLv1Cd", "PROM_TYPE_LV1",null,null,true);
			$("#promTypeLv1Cd").val(result.promTypeLv1Cd);

		    //조직
		    $.fn.ifvmSetSelectOptionCommCodeSync("promTypeLv2Cd", "PROM_TYPE_LV2", $("#promTypeLv1Cd").val(), "promTypeLv1Cd", false);
			
			$("#promTypeLv2Cd").val(result.promTypeLv2Cd);
			
			
			
			ruleOfrRid    = result.ofrRid;
			ruleTgtGrpRid = result.tgtRuleGrpRid;
			ruleExpectTgtGrpRid = result.expectTgtRuleGrpRid;
			promRuleRid  = result.rid;
			
			$("#ruleDetail").empty();
			
			ruleCheck();
			
   	
    });
}

function ruleCheck() {
	
	if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_GEN') {   
		/* cDialog.model.width = "1450";
		cDialog.option.hide = false; */
		getPromSa1Detail();
	}  else if ( $("#promTypeLv1Cd").val() == 'ACT' && $("#promTypeLv2Cd").val() == 'CNTCT_CHG') {
		/* cDialog.model.width = "1000"; */
		getPromAc2ConDetail();
	}  else if ( $("#promTypeLv1Cd").val() == 'ACT' && $("#promTypeLv2Cd").val() == 'SURVEY') {
		getPromAc2SurDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_CMLTV') {
		getPromSa2SumDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_CMLTV') {
		getPromSa2SumDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_PTR_CMLTV') {
		getPromSa2SumDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_PTR_GEN') {
		getPromSa1Detail();
	} else if ( $("#promTypeLv1Cd").val() == 'AC2' && $("#promTypeLv2Cd").val() == 'AC2ON') {
		getPromAc2OnDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'MBR' && $("#promTypeLv2Cd").val() == 'ADD_INF') {
		getPromAc2AddDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'MBR' && $("#promTypeLv2Cd").val() == 'MBR_JOIN') {
		getPromAc1JoinDetail();
	} /* else if ( $("#promTypeLv1Cd").val() == 'MBR' && $("#promTypeLv2Cd").val() == 'RCMNDED') {
		getPromAc1FrndDetail();
	} */ else if ( $("#promTypeLv1Cd").val() == 'CLB' && $("#promTypeLv2Cd").val() == 'CLUB_JOIN') {
		getPromAc1ClbDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'FML' && $("#promTypeLv2Cd").val() == 'FML_JOIN') {
		getPromAc1FamDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'AC1' && $("#promTypeLv2Cd").val() == 'AC1CARD') {
		getPromAc1CardDetail();
	} else if ( $("#promTypeLv1Cd").val() == 'SA1' && $("#promTypeLv2Cd").val() == 'CBBG') {
		getPromSa1Detail();
	} /* else if ( $("#promTypeLv1Cd").val() == 'ACT' && $("#promTypeLv2Cd").val() == 'RCMND') {
		getPromSa1Detail();
	} */
}

function getPromAc1ClbDetail() {
	var temp = $("#ac1ClbTemp").tmpl();
    $("#ruleDetail").append(temp);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc1ClbDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					$("#clubNo").val(result.clubNo);
		    	    $("#clubNm").val(result.clubNm);
		    	    clubRid = result.clubRid;
		        	promAc1ClbRuleRid = result.rid;
				} 
			}, function(result) {
				
			});
}

function getPromAc1CardDetail() {
	var temp = $("#ac1CardTemp").tmpl();
    $("#ruleDetail").append(temp);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc1CardDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					$("#chnlTgtGrpNo").val(result.chnlTgtGrpNo);
		    	    $("#chnlTgtGrpNm").val(result.chnlTgtGrpNm);
		        	promAc1CardRuleRid = result.rid;
		        	promAc1CardChnlTgtRid = result.chnTgtGrpRid;
				} 
			}, function(result) {
				
			});
}

function getPromAc1FamDetail() {
	var temp = $("#ac1FamTemp").tmpl();
    $("#ruleDetail").append(temp);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc1FamDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					if(result.prulFamCd=='F')
		        		$("input:radio[id='F']").attr("checked", true);
		        	if(result.prulFamCd == 'A')
		        		$("input:radio[id='A']").attr("checked", true);
		        	promAc1FamRuleRid = result.rid;
				} 
			}, function(result) {
				
			});
}

function getPromAc1FrndDetail() {
	var temp = $("#ac1FrndTemp").tmpl();
    $("#ruleDetail").append(temp);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc1FrndDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					if(result.prulJoinChnlCd=='ONLY')
		        		$("input:radio[id='ONLY']").attr("checked", true);
		        	if(result.prulJoinChnlCd == 'NOTONLY')
		        		$("input:radio[id='NOTONLY']").attr("checked", true);
		        	if(result.prulJoinChnlCd == 'NONLY')
	        		$("input:radio[id='NONLY']").attr("checked", true);
		        	promAc1FrndRuleRid = result.rid;
				} 
			}, function(result) {
				
			});
}

function getPromAc1JoinDetail() {
	var temp = $("#ac1JoinTemp").tmpl();
    $("#ruleDetail").append(temp);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc1JoinDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					if(result.prulJoinChnlCd=='ALL')
		        		$("input:radio[id='ALL']").attr("checked", true);
						$("#ac1JoinChnlNo").val(result.tgtGrpNo);
	        			$("#ac1JoinChnlNm").val(result.tgtGrpNm);
		        		ac1JoinChnlTgtGrpRid = result.chnlTgtGrpRid;
		        	if(result.prulJoinChnlCd == 'APP')
		        		$("input:radio[id='APP']").attr("checked", true);
		        		$("#ac1JoinChnlNo").val(result.tgtGrpNo);
	        			$("#ac1JoinChnlNm").val(result.tgtGrpNm);
		        		ac1JoinChnlTgtGrpRid = result.chnlTgtGrpRid;
		        	if(result.prulJoinChnlCd == 'CHNL') {
		        		$("input:radio[id='CHNL']").attr("checked", true);
		        		$("#ac1JoinChnlNo").val(result.tgtGrpNo);
		        		$("#ac1JoinChnlNm").val(result.tgtGrpNm);
			        	ac1JoinChnlTgtGrpRid = result.chnlTgtGrpRid;
		        	}
		        	promAc1JoinRuleRid = result.rid;
				} 
			}, function(result) {
				
			});
}

function getPromAc2AddDetail() {
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc2AddRuleInfo"/>', {
    	promRid : campaign.id
    },
    function(result) {
			
    		if ($.fn.ifvmIsNotEmpty(result)){ 
	    		
				if(result.length>0) {
					for(var i=0;i<result.length;i++) {
							
							ruleAc2AddSeqNo = result[i].seqNo;
							var temp = $("#ac2AddTemp").tmpl(ruleAc2AddSeqNo);
				    	    $("#ruleDetail").append(temp);
				    	    
				    	    $.fn.ifvmSetSelectOptionCommCode("addInfoCd"+ruleAc2AddSeqNo, "PROM_ADD_INFO_TYPE", null, null, true);			  			    	   
							
		                	$("#ac2AddRuleRid"+result[i].seqNo).val(result[i].rid);
		                	$("#addInfoCd"+result[i].seqNo).val(result[i].addInfoCd);
					}
				} 
				
				
			} else {
				var temp = $("#ac2AddTemp").tmpl(ruleAc2AddSeqNo);
	    	    $("#ruleDetail").append(temp);
	    	    
	    	    $.fn.ifvmSetSelectOptionCommCode("addInfoCd"+ruleAc2AddSeqNo, "PROM_ADD_INFO_TYPE", null, null, true);			  
	    	    $("#itemAc2AddMinusfirst1").hide();

			}
    });
}

function getPromAc2OnDetail() {
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc2OnRuleInfo"/>', {
    	promRid : campaign.id
    },
    function(result) {
			if ($.fn.ifvmIsNotEmpty(result)){ 
	    		
				if(result.length>0) {
					for(var i=0;i<result.length;i++) {
						
							ruleAc2OnSeqNo = result[i].seqNo;
							var temp = $("#ac2OnTemp").tmpl(ruleAc2OnSeqNo);
				    	    $("#ruleDetail").append(temp);
				    	    
				    	    $.fn.ifvmSetSelectOptionCommCode("ac2OnOfrAmtType"+ruleAc2OnSeqNo, "PROM_ACT_AMT_TYPE", null, null, false);
				    	    $.fn.ifvmSetSelectOptionCommCode("onlActCd"+ruleAc2OnSeqNo, "PROM_ONL_ACT_TYPE", null, null, true);			  			    	   
	
		                	$("#ac2OnRuleOfrRid"+result[i].seqNo).val(result[i].ofrRid);
		                	$("#ac2OnRuleRid"+result[i].seqNo).val(result[i].rid);
		                	$("#ac2OnRuleOfrNo"+result[i].seqNo).val(result[i].ofrNo);
		                	$("#ac2OnRuleOfrNm"+result[i].seqNo).val(result[i].ofrNm);
		                	$("#ac2OnOfrAmtType"+result[i].seqNo).val(result[i].ofrAmtType);
		                	$("#ac2OnOfrAmt"+result[i].seqNo).val(result[i].ofrAmt);
		                	$("#onlActCd"+result[i].seqNo).val(result[i].onlActCd);
		                	//$("#ac2OnEffStrtDayCnt"+result[i].seqNo).val(result[i].effStrtDayCnt);
		                	
		                	if($("#promOfferAmtDefCd").val()=='ACT') {
		                		$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",true);
		                      	 $("#ac2OnOfrAmt"+ruleAc2OnSeqNo).attr("disabled",true);
		       		             
		                    } else if($("#promOfferAmtDefCd").val()=='RULE') {
		                    	$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",false); 
		                    	$("#ac2OnOfrAmt"+ruleAc2OnSeqNo).attr("disabled",false);
		       		             
		                    }
		                	
		                	if(result[i].cpnYn=='Y') {
		                		$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",true);
		                		$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).val('');
		       		             
		                    } else {
		                    	$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",false);
		                    }
					}
				} 
				
				
			} else {
				var temp = $("#ac2OnTemp").tmpl(ruleSa2SumSeqNo);
	    	    $("#ruleDetail").append(temp);
	    	    $("#ac2OnRuleOfrNm"+ruleAc2OnSeqNo).val(defaultOfrNm);
	    	    $("#ac2OnRuleOfrNo"+ruleAc2OnSeqNo).val(defaultOfrNo);
	    	    $("#ac2OnRuleOfrRid"+ruleAc2OnSeqNo).val(defaultOfrRid);
	    	    
	    	    $.fn.ifvmSetSelectOptionCommCode("ac2OnOfrAmtType"+ruleAc2OnSeqNo, "PROM_ACT_AMT_TYPE", null, null, false);			  
	    	    $.fn.ifvmSetSelectOptionCommCode("onlActCd"+ruleAc2OnSeqNo, "PROM_ONL_ACT_TYPE", null, null, true);			  
	    	    $("#itemAc2OnMinusfirst"+ruleAc2OnSeqNo).hide();

	    	    if($("#promOfferAmtDefCd").val()=='ACT') {
	    	    	$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",true);
                 	 $("#ac2OnOfrAmt"+ruleAc2OnSeqNo).attr("disabled",true);
  		             
                } else if($("#promOfferAmtDefCd").val()=='RULE') {
                	$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",false);
                 	 $("#ac2OnOfrAmt"+ruleAc2OnSeqNo).attr("disabled",false);
   		             
                }
	    	    
	    	    if(result[i].cpnYn=='Y') {
            		$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",true);
            		$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).val('');
   		             
                } else {
                	$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",false);
                }
			}
    });
}

function getPromSa2SumDetail() {
	$.ifvSyncPostJSON('<ifvm:action name="getPromSa2SumRuleInfo"/>', {
    	promRid : campaign.id
    },
    function(result) {
			if ($.fn.ifvmIsNotEmpty(result)){ 
	    		
				if(result.length>0) {
					for(var i=0;i<result.length;i++) {
						
							ruleSa2SumSeqNo = result[i].seqNo;
							var temp = $("#sa2SumTemp").tmpl(ruleSa2SumSeqNo);
				    	    $("#ruleDetail").append(temp);
				    	    
				    	    $.fn.ifvmSetSelectOptionCommCode("sa2SumOfrAmtType"+ruleSa2SumSeqNo, "PROM_ACT_AMT_TYPE", null, null, false);			  
				    	    
				    	    $("#sa2SumStartVal"+ruleSa2SumSeqNo).attr("onKEYUP", "inputNumberAutoComma(this);");
				    		$("#sa2SumEndVal"+ruleSa2SumSeqNo).attr("onKEYUP", "inputNumberAutoComma(this);");
							
		                	$("#sa2SumRuleOfrRid"+result[i].seqNo).val(result[i].ofrRid);
		                	$("#sa2SumRuleRid"+result[i].seqNo).val(result[i].rid);
		                	$("#sa2SumStartVal"+result[i].seqNo).val(numberWithCommas(result[i].startVal));
		                	$("#sa2SumEndVal"+result[i].seqNo).val(numberWithCommas(result[i].endVal));
		                	$("#sa2SumRuleOfrNo"+result[i].seqNo).val(result[i].ofrNo);
		                	$("#sa2SumRuleOfrNm"+result[i].seqNo).val(result[i].ofrNm);
		                	$("#sa2SumOfrAmtType"+result[i].seqNo).val(result[i].ofrAmtType);
		                	$("#sa2SumOfrAmt"+result[i].seqNo).val(result[i].ofrAmt);
		                	//$("#sa2SumEffStrtDayCnt"+result[i].seqNo).val(result[i].effStrtDayCnt);
		                	
		                	if($("#promOfferAmtDefCd").val()=='ACT') {
		                      	 $("#sa2SumOfrAmtType"+result[i].seqNo).attr("disabled",true);
		       		             $("#sa2SumOfrAmt"+result[i].seqNo).attr("disabled",true);
		                    } else if($("#promOfferAmtDefCd").val()=='RULE') {
		                      	$("#sa2SumOfrAmtType"+result[i].seqNo).attr("disabled",false);
		       		             $("#sa2SumOfrAmt"+result[i].seqNo).attr("disabled",false);
		       		             
		                    }
		                	
		                	if(result[i].cpnYn=='Y') {
		                      	 $("#sa2SumOfrAmtType"+result[i].seqNo).attr("disabled",true);
		       		             $("#sa2SumOfrAmt"+result[i].seqNo).val('');
		                    } else {
		                    	$("#sa2SumOfrAmtType"+result[i].seqNo).attr("disabled",false);
		                    }
					}
				} 
				
				
			} else {
				var temp = $("#sa2SumTemp").tmpl(ruleSa2SumSeqNo);
	    	    $("#ruleDetail").append(temp);
	    	    $("#sa2SumRuleOfrNm"+ruleSa2SumSeqNo).val(defaultOfrNm);
	    	    $("#sa2SumRuleOfrNo"+ruleSa2SumSeqNo).val(defaultOfrNo);
	    	    $("#sa2SumRuleOfrRid"+ruleSa2SumSeqNo).val(defaultOfrRid);
	    	    
	    	    $.fn.ifvmSetSelectOptionCommCode("sa2SumOfrAmtType"+ruleSa2SumSeqNo, "PROM_ACT_AMT_TYPE", null, null, false);			  
	    	    $("#itemSa2SumMinusfirst"+ruleSa2SumSeqNo).hide();
	    	    
	    	    $("#sa2SumStartVal1").attr("onKEYUP", "inputNumberAutoComma(this);");
	    		$("#sa2SumEndVal1").attr("onKEYUP", "inputNumberAutoComma(this);");
	    		
	    		if($("#promOfferAmtDefCd").val()=='ACT') {
	    			$("#sa2SumOfrAmtType"+ruleSa2SumSeqNo).attr("disabled",true);
	    			$("#sa2SumOfrAmt"+ruleSa2SumSeqNo).attr("disabled",true);
	            } else if($("#promOfferAmtDefCd").val()=='RULE') {
	            	$("#sa2SumOfrAmtType"+ruleSa2SumSeqNo).attr("disabled",false);
	    			$("#sa2SumOfrAmt"+ruleSa2SumSeqNo).attr("disabled",false);
   		             
                }
	    		
	    		if(result[i].cpnYn=='Y') {
                 	 $("#sa2SumOfrAmtType"+result[i].seqNo).attr("disabled",true);
  		             $("#sa2SumOfrAmt"+result[i].seqNo).val('');
               } else {
               	$("#sa2SumOfrAmtType"+result[i].seqNo).attr("disabled",false);
               }
			}
    });
}

function getPromAc2ConDetail() {
	var temp = $("#ac2ConTemp").tmpl();
    $("#ruleDetail").append(temp);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc2ConDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {

					if(result.hhpYn=='Y')
		        		$("input:checkbox[id='hhpYn']").attr("checked", true);
		        	if(result.emailYn == 'Y')
		        		$("input:checkbox[id='emailYn']").attr("checked", true);
		        	if(result.addrYn == 'Y') 
		        		$("input:checkbox[id='addrYn']").attr("checked", true);
		        	promAc2ConRuleRid = result.rid;
				} 
			}, function(result) {
				
			});
}

function getPromAc2SurDetail() {
	var temp = $("#ac2SurTemp").tmpl();
    $("#ruleDetail").append(temp);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc2SurDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {

					$("#surveyNo").val(result.surveyNo);
					$("#surveyNm").val(result.surveyNm);
					surveyRid = result.surveyRid
					promAc2SurRuleRid = result.rid;
				} 
			}, function(result) {
				
			});
}

function getPromAc2AgrDetail() {
	var temp = $("#ac2AgrTemp").tmpl();
    $("#ruleDetail").append(temp);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromAc2AgrDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					$("#textYn").prop("checked", "Y" === result.textYn ? true : false);
					$("#emailYn").prop("checked", "Y" === result.emailYn ? true : false);
					$("#tmYn").prop("checked", "Y" === result.tmYn ? true : false);
					$("#dmYn").prop("checked", "Y" === result.dmYn ? true : false);
					$("#pushYn").prop("checked", "Y" === result.pushYn ? true : false);
					$("#kkfYn").prop("checked", "Y" === result.kkfYn ? true : false);
					promAc2AgrRuelRid = result.rid;
					/* if(result.hhpYn=='Y')
		        		$("input:checkbox[id='hhpYn']").attr("checked", true);
		        	if(result.emailYn == 'Y')
		        		$("input:checkbox[id='emailYn']").attr("checked", true);
		        	if(result.addrYn == 'Y') 
		        		$("input:checkbox[id='addrYn']").attr("checked", true);
		        	if(result.addrYn == 'Y') 
		        		$("input:checkbox[id='addrYn']").attr("checked", true);
		        	if(result.addrYn == 'Y') 
		        		$("input:checkbox[id='addrYn']").attr("checked", true); */
				} 
			}, function(result) {
						
			});
}

function getPromSalAniDetail() {
	var temp = $("#sa1AniTemp").tmpl();
    $("#ruleDetail").append(temp);
    $.fn.ifvmSetSelectOptionCommCode("conditionCd", "CUST_ANNI_CODE", null, null, true);
    $.fn.ifvmSetSelectOptionCommCode("operCd", "ANNI_OPER_CODE", null, null, true);
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromSa1AniDetail"/>', {
    	promRid : campaign.id
    },
    function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {

					$("#conditionCd").val(result.conditionCd);
					$("#operCd").val(result.operCd);
					$("#dayVal").val(result.dayVal);
					promSa1AniRuleRid = result.rid;
				} 
			}, function(result) {
				
			});
}

function numberWithCommas(x) {
	if(x!=null) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	else return;
}

$(document).on("change", '.searchConditionOfrAmtTpye', function() {
	ofrValTypeChange($(this).attr("id"));
});


function getPromSa1Detail() {
	$.ifvSyncPostJSON('<ifvm:action name="getPromSa1RuleInfo"/>', {
    	promRid : campaign.id
    },
    function(result) {
    	
    	//$("#promotionInfoDetail").dataSetting(result);
    			var temp = $("#sa1genTemp").tmpl(ruleSa1SeqNo);
	    	    $("#ruleDetail").append(temp);
	    	    $.fn.ifvmSetSelectOptionCommCode("payMethTypeCd", "PROM_PAY_TYPE", null, null, true);
			if ($.fn.ifvmIsNotEmpty(result)){ 
				promSa1RuleRid = result.rid;
				chnlTgtGrpRid  = result.chnlTgtGrpRid;
				prodTgtGrpRid  = result.prodTgtGrpRid;
				prodTgtGrpRid2 = result.prodTgtGrpRid2;
				
	    	    $("#chnlTgtGrpNo").val(result.chnlTgtGrpNo);
	    	    $("#chnlTgtGrpNm").val(result.chnlTgtGrpNm);
	    	    $("#payMethTypeCd").val(result.payMethTypeCd);
	    	    $("#prodTgtGrpNo").val(result.prodTgtGrpNo);
	    	    $("#prodTgtGrpNm").val(result.prodTgtGrpNm);
	    	    $("#prodTgtGrpNo2").val(result.prodTgtGrpNo2);
	    	    $("#prodTgtGrpNm2").val(result.prodTgtGrpNm2);
	    		
				if(result.promotionSalXmRuleDetail.length>0) {
					for(var i=0;i<result.promotionSalXmRuleDetail.length;i++) {
						
							ruleSa1SeqNo = result.promotionSalXmRuleDetail[i].seqNo;
							var temp = $("#sa1genXmTemp").tmpl(ruleSa1SeqNo);
				    	    $("#ruleDetail").append(temp);
				    	    
				    	    $.fn.ifvmSetSelectOptionCommCode("ofrAmtType"+ruleSa1SeqNo, "PROM_ACT_AMT_TYPE", null, null, false);			  
				    	    
				    	    $("#startVal"+ruleSa1SeqNo).attr("onKEYUP", "inputNumberAutoComma(this);");
				    		$("#endVal"+ruleSa1SeqNo).attr("onKEYUP", "inputNumberAutoComma(this);");
						
						$("#sa1RuleRid"+result.promotionSalXmRuleDetail[i].seqNo).val(result.promotionSalXmRuleDetail[i].paulSa1genRid);
		                $("#sa1RuleOfrRid"+result.promotionSalXmRuleDetail[i].seqNo).val(result.promotionSalXmRuleDetail[i].ofrRid);
		                $("#salRuleXmRid"+result.promotionSalXmRuleDetail[i].seqNo).val(result.promotionSalXmRuleDetail[i].rid);
		                $("#startVal"+result.promotionSalXmRuleDetail[i].seqNo).val(numberWithCommas(result.promotionSalXmRuleDetail[i].startVal));
		                $("#endVal"+result.promotionSalXmRuleDetail[i].seqNo).val(numberWithCommas(result.promotionSalXmRuleDetail[i].endVal));
		                $("#sa1RuleOfrNo"+result.promotionSalXmRuleDetail[i].seqNo).val(result.promotionSalXmRuleDetail[i].ofrNo);
		                $("#sa1RuleOfrNm"+result.promotionSalXmRuleDetail[i].seqNo).val(result.promotionSalXmRuleDetail[i].ofrNm);
		                $("#ofrAmtType"+result.promotionSalXmRuleDetail[i].seqNo).val(result.promotionSalXmRuleDetail[i].ofrAmtType);
		                $("#ofrAmt"+result.promotionSalXmRuleDetail[i].seqNo).val(result.promotionSalXmRuleDetail[i].ofrAmt);
		                //$("#effStrtDayCnt"+result.promotionSalXmRuleDetail[i].seqNo).val(result.promotionSalXmRuleDetail[i].effStrtDayCnt);
		                
		                
		                if($("#promOfferAmtDefCd").val()=='ACT') {
		                	 $("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",true);
				             $("#ofrAmt"+ruleSa1SeqNo).attr("disabled",true);
		                } else if($("#promOfferAmtDefCd").val()=='RULE') {
		                	$("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",false)
				             $("#ofrAmt"+ruleSa1SeqNo).attr("disabled",false)
	    
				             
	                    }
		                
		                if(result.promotionSalXmRuleDetail[i].cpnYn=='Y') {
		                	$("#ofrAmtType"+result.promotionSalXmRuleDetail[i].seqNo).attr("disabled",true);
		        	      	$("#info"+result.promotionSalXmRuleDetail[i].seqNo).text("개");
		                } else {
		        			$("#ofrAmtType"+result.promotionSalXmRuleDetail[i].seqNo).attr("disabled",false);
		        			
		        		}
		                
		                if(result.promotionSalXmRuleDetail[i].ofrAmtType=='RATE') {
		                	$("#info"+result.promotionSalXmRuleDetail[i].seqNo).text("%");
		                } else if(result.promotionSalXmRuleDetail[i].ofrAmtType=='AMT') {
		                	$("#info"+result.promotionSalXmRuleDetail[i].seqNo).text("P");
		                }
		                
		                /* if(result.promotionSalXmRuleDetail[i].cpnYn=='Y') {
		                	 $("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",true);
				             $("#ofrAmt"+ruleSa1SeqNo).val('');
		                } else {
		                	$("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",false);
		                } */
		                
					}
				} else {
					var temp = $("#sa1genXmTemp").tmpl(ruleSa1SeqNo);
		    	    $("#ruleDetail").append(temp);
		    	    
		    	    $.fn.ifvmSetSelectOptionCommCode("ofrAmtType1", "PROM_ACT_AMT_TYPE", null, null, false);
		    	    $("#itemSa1Minusfirst"+ruleSa1SeqNo).hide();
		    	    
		    	    $("#startVal1").attr("onKEYUP", "inputNumberAutoComma(this);");
		    		$("#endVal1").attr("onKEYUP", "inputNumberAutoComma(this);");
		    		
		    		
		    		if($("#promOfferAmtDefCd").val()=='ACT') {
	                	 $("#ofrAmtType1").attr("disabled",true);
			             $("#ofrAmt1").attr("disabled",true);
	                } else if($("#promOfferAmtDefCd").val()=='RULE') {
	                	$("#ofrAmtType1").attr("disabled",false);
			             $("#ofrAmt1").attr("disabled",false);
       		             
                    }
		    	
		    		/* if(result.promotionSalXmRuleDetail[i].cpnYn=='Y') {
	                	 $("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",true);
			             $("#ofrAmt"+ruleSa1SeqNo).val('');
	                } else {
	                	$("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",false);
	                } */
				}
				
				if(result.chnlConYn=='Y')
	        		$("input:checkbox[id='chnlConYn']").attr("checked", true);
	        	if(result.prodConYn == 'Y')
	        		$("input:checkbox[id='prodConYn']").attr("checked", true);
	        	if(result.payMethYn == 'Y') 
	        		$("input:checkbox[id='payMethYn']").attr("checked", true);
	        	if(result.sellAmtOfrYn == 'Y') 
	        		$("input:checkbox[id='sellAmtOfrYn']").attr("checked", true);
	        	else 
	        		$("input:checkbox[id='sellAmtOfrYn']").attr("checked", false);
	        	
	        	if(result.prodGrpAllYn == 'Y') 
	        		$("input:checkbox[id='prodGrpAllYn']").attr("checked", true);
	        	
			} else {
				var temp = $("#sa1genXmTemp").tmpl(ruleSa1SeqNo);
	    	    $("#ruleDetail").append(temp);
	    	    $("#sa1RuleOfrNm"+ruleSa1SeqNo).val(defaultOfrNm);
	    	    $("#sa1RuleOfrNo"+ruleSa1SeqNo).val(defaultOfrNo);
	    	    $("#sa1RuleOfrRid"+ruleSa1SeqNo).val(defaultOfrRid);
	    	    
	    	    $.fn.ifvmSetSelectOptionCommCode("ofrAmtType1", "PROM_ACT_AMT_TYPE", null, null, false);
	    	    $("#itemSa1Minusfirst"+ruleSa1SeqNo).hide();
	    	    
	    	    $("#startVal1").attr("onKEYUP", "inputNumberAutoComma(this);");
	    		$("#endVal1").attr("onKEYUP", "inputNumberAutoComma(this);");
	    		
	    		if($("#promOfferAmtDefCd").val()=='ACT') {
               	 	 $("#ofrAmtType1").attr("disabled",true);
		             $("#ofrAmt1").attr("disabled",true);
                } else if($("#promOfferAmtDefCd").val()=='RULE') {
                	$("#ofrAmtType1").attr("disabled",false);
		             $("#ofrAmt1").attr("disabled",false);
   		             
                }
			}
    });
	
}

function promRuleTgtPopup() {
	$("#tgtGrpIncPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tgtGrpIncPop"/>',
        contentType: "ajax",
        title: '대상고객군 등록',
        width: 680,
        close : 'tgtGrpIncClosePop'
	});
}

function tgtGrpIncClosePop() {
	tgtGrpIncPop._destroy();
}

function promRuleExpTgtPopup() {
	$("#expectTgtGrpIncPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="expectTgtGrpIncPop"/>',
        contentType: "ajax",
        title: '제외고객군 등록',
        width: 680,
        close : 'expectTgtGrpIncClosePop'
	});
}

function expectTgtGrpIncClosePop() {
	expectTgtGrpIncPop._destroy();
}

function offerListPopup() {
	$("#offerListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrPop"/>',
        contentType: "ajax",
        title: '오퍼 등록',
        width: 880,
        close : 'offerPopupClose'
	});
}

function offerissTypePopup() {
	$("#offerissListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrIssPop"/>',
        contentType: "ajax",
        title: '오퍼 등록',
        width: 950,
        close : 'offerissPopupClose'
	});
}

function offerissPopupClose() {
	offerissListPop._destroy();
}

function offerPopupClose() {
	offerListPop._destroy();
}

function sa1RuleOfrPopup(index) {
	if(defaulPromOfrCd=='ACT') {
		alert("제공오퍼수량 ACTION 정의는 수정할수 없습니다.");
		return;
	}

	
	ruleSa1SeqNo = index;
	$("#sa1RuleOfrPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="sa1RuleOfrPop"/>',
        contentType: "ajax",
        title: '금액대별 오퍼 등록',
        width: 880,
        close : 'sa1RuleOfrClosePop'
	});
	
}

function sa1RuleOfrClosePop() {
	sa1RuleOfrPop._destroy();
}

function chnlTgtGrpPopup() {
	$("#chnlTgtGrpPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlTgtGrpPop"/>',
        contentType: "ajax",
        title: '채널 조회',
        width: 880,
        close : 'chnlTgtGrpClosePop'
	});
}

function chnlTgtGrpClosePop() {
	chnlTgtGrpPop._destroy();
}

function prodTgtGrpPopup() {
	$("#prodTgtGrpPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="prodTgtGrpPop"/>',
        contentType: "ajax",
        title: '상품 그룹 조회',
        width: 880,
        close : 'prodTgtGrpClosePop'
	});
}

function prodTgtGrpClosePop() {
	prodTgtGrpPop._destroy();
}

function prodTgtGrpPopup() {
	$("#prodTgtGrpPop2").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="prodTgtGrpPop"/>',
        contentType: "ajax",
        title: '상품 그룹 조회',
        width: 880,
        close : 'prodTgtGrpClosePop'
	});
}

function prodTgtGrpClosePop() {
	prodTgtGrpPop._destroy();
}

function prodTgtGrpPopup2() {
	$("#prodTgtGrpPop2").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="prodTgtGrpPop2"/>',
        contentType: "ajax",
        title: '상품 그룹 조회',
        width: 880,
        close : 'prodTgtGrpClosePop2'
	});
}

function prodTgtGrpClosePop2() {
	prodTgtGrpPop2._destroy();
}

function tgtGrpIncPopup() {
	$("#tgtGrpIncPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tgtGrpIncPop"/>',
        contentType: "ajax",
        title: '대상고객군 등록',
        width: 680,
        close : 'tgtGrpIncClosePop'
	});
}

function tgtGrpIncClosePop() {
	tgtGrpIncPop._destroy();
}

function expectTgtGrpIncPopup() {
	$("#expectTgtGrpIncPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="expectTgtGrpIncPop"/>',
        contentType: "ajax",
        title: '제외고객군 등록',
        width: 680,
        close : 'expectTgtGrpIncClosePop'
	});
}

function expectTgtGrpIncClosePop() {
	expectTgtGrpIncPop._destroy();
}

function clubPopup() {
	$("#clubListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="clubListPop"/>',
        contentType: "ajax",
        title: '클럽 등록',
        width: 880,
        close : 'clubListClosePop'
	});
}

function clubListClosePop() {
	clubListPop._destroy();
}

function surveyPopup() {
	$("#surveyListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="surveyListPop"/>',
        contentType: "ajax",
        title: '설문 등록',
        width: 900,
        close : 'surveyListClosePop'
	});
}

function surveyListClosePop() {
	surveyListPop._destroy();
}


function ruleSa1MinusBtn(){
	
	if( $('.ruleSa1GridList').length == 1){
        $('.itemSa1Minusfirst1').hide();
    }else{
        $('.itemSa1Minusfirst1').show();
    }
}

function removeSa1MinusBtn(ruleSa1SeqNo) {
	if($("#promStatCd").val()!='W') {
		alert('작성중이 아닌 프로모션은 삭제할수 없습니다.');
		return;
	}
	else {
    if(ruleSa1SeqNo!=1) {
    	
    	if($("#salRuleXmRid"+ruleSa1SeqNo).val() != '') {
    		if( confirm('<spring:message code="I01500"/>') == true ){
    	        $.ifvSyncPostJSON('<ifvm:action name="removeRuleSa1Xm"/>', {
    	            rid: $("#salRuleXmRid"+ruleSa1SeqNo).val()
    	        },
    	        function(result) {
    				alert('<spring:message code="I00726"/>');
    				$("#ruleSa1GridList"+ruleSa1SeqNo).remove();
    				ruleSa1MinusBtn();
           		 	ruleSa1SeqNo = ruleSa1SeqNo - 1;
    	        });
    	    }
    	}
    	else {
    		$("#ruleSa1GridList"+ruleSa1SeqNo).remove();
    		 ruleSa1MinusBtn();
    		 ruleSa1SeqNo = ruleSa1SeqNo - 1;
    	}

    }
	}
}

function removeSa2SumMinusBtn(ruleSa2SumSeqNo) {
    if(ruleSa2SumSeqNo!=1) {
 
    	if($("#sa2SumRuleRid"+ruleSa2SumSeqNo).val() != '') {
    		if( confirm('<spring:message code="I01500"/>') == true ){
    	        $.ifvSyncPostJSON('<ifvm:action name="removeRuleSa2Sum"/>', {
    	            rid: $("#sa2SumRuleRid"+ruleSa2SumSeqNo).val()
    	        },
    	        function(result) {
    	        	alert('<spring:message code="I00726"/>');
    				$("#ruleSa2SumGridList"+ruleSa2SumSeqNo).remove();
    				ruleSa2SumMinusBtn();
    				ruleSa2SumSeqNo = ruleSa2SumSeqNo - 1;
    	        });
    	    }
    	}
    	else {
    		$("#ruleSa2SumGridList"+ruleSa2SumSeqNo).remove();
    		ruleSa2SumMinusBtn();
    		ruleSa2SumSeqNo = ruleSa2SumSeqNo - 1;
    	}

    }
}


function removeAc2OnMinusBtn(ruleAc2OnSeqNo) {
    if(ruleAc2OnSeqNo!=1) {
 
    	if($("#ac2OnRuleRid"+ruleAc2OnSeqNo).val() != '') {
    		if( confirm('<spring:message code="I01500"/>') == true ){
    	        $.ifvSyncPostJSON('<ifvm:action name="removeRuleAc2On"/>', {
    	            rid: $("#ac2OnRuleRid"+ruleAc2OnSeqNo).val()
    	        },
    	        function(result) {
    				alert('<spring:message code="I00726"/>');
    				$("#ruleAc2OnGridList"+ruleAc2OnSeqNo).remove();
    				ruleAc2OnMinusBtn();
    				ruleAc2OnSeqNo = ruleAc2OnSeqNo - 1;
    	        });
    	    }
    	}
    	else {
    		$("#ruleAc2OnGridList"+ruleAc2OnSeqNo).remove();
    		ruleAc2OnMinusBtn();
    		ruleAc2OnSeqNo = ruleAc2OnSeqNo - 1;
    	}

    }
}

function removeAc2AddMinusBtn(ruleAc2AddSeqNo) {
    if(ruleAc2AddSeqNo!=1) {
 
    	if($("#Ac2OnRuleRid"+ruleAc2AddSeqNo).val() != '') {
    		if( confirm('<spring:message code="I01500"/>') == true ){
    	        $.ifvSyncPostJSON('<ifvm:action name="removeRuleAc2Add"/>', {
    	            rid: $("#ac2AddRuleRid"+ruleAc2AddSeqNo).val()
    	        },
    	        function(result) {
    				alert('<spring:message code="I00726"/>');
    				$("#ruleAc2AddGridList"+ruleAc2AddSeqNo).remove();
    				ruleAc2AddMinusBtn();
    				ruleAc2AddSeqNo = ruleAc2AddSeqNo - 1;
    	        });
    	    }
    	}
    	else {
    		$("#ruleAc2AddGridList"+ruleAc2AddSeqNo).remove();
    		ruleAc2AddMinusBtn();
    		ruleAc2AddSeqNo = ruleAc2AddSeqNo - 1;
    	}

    }
}

function ruleAc2AddMinusBtn(){
	
	if( $('.ruleAc2AddGridList').length == 1){
        $('.itemAc2AddMinusfirst1').hide();
    }else{
        $('.itemAc2AddMinusfirst1').show();
    }
}

function ruleSa2SumMinusBtn(){
	
	if( $('.ruleSa2SumGridList').length == 1){
        $('.itemSa2SumMinusfirst1').hide();
    }else{
        $('.itemSa2SumMinusfirst1').show();
    }
}

function ruleAc2OnMinusBtn(){
	
	if( $('.ruleAc2OnGridList').length == 1){
        $('.itemAc2OnMinusfirst1').hide();
    }else{
        $('.itemSa2SumMinusfirst1').show();
    }
}

function addSa1PlusBtn() {
	$("#itemSa1Minusfirst1").show();
	ruleSa1SeqNo = Number(ruleSa1SeqNo) + 1;
	var temp = $("#sa1genXmTemp").tmpl(ruleSa1SeqNo);
	$("#ruleDetail").append(temp);
	$("#sa1RuleOfrNm"+ruleSa1SeqNo).val(defaultOfrNm);
    $("#sa1RuleOfrNo"+ruleSa1SeqNo).val(defaultOfrNo);
    $("#sa1RuleOfrRid"+ruleSa1SeqNo).val(defaultOfrRid);
	//$("#promActionTierRid"+ruleSa1SeqNo).val('');
	$.fn.ifvmSetSelectOptionCommCode("ofrAmtType"+ruleSa1SeqNo, "PROM_ACT_AMT_TYPE", null, null, false);
	$("#startVal"+ruleSa1SeqNo).attr("onKEYUP", "inputNumberAutoComma(this);");
	 $("#endVal"+ruleSa1SeqNo).attr("onKEYUP", "inputNumberAutoComma(this);");
	 
	 if($("#promOfferAmtDefCd").val()=='ACT') {
       	 $("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",true);
         $("#ofrAmt"+ruleSa1SeqNo).attr("disabled",true);
     } else if($("#promOfferAmtDefCd").val()=='RULE') {
    	 $("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",false);
         $("#ofrAmt"+ruleSa1SeqNo).attr("disabled",false);
            
     }
	 
	 if(cpnYn=='Y') {	
			$("#info"+seqNo).text("개");
	 	 }
}

function addSa2SumPlusBtn() {
	$("#itemSa2SumMinusfirst1").show();
	ruleSa2SumSeqNo = Number(ruleSa2SumSeqNo) + 1;
	var temp = $("#sa2SumTemp").tmpl(ruleSa2SumSeqNo);
	$("#ruleDetail").append(temp);
	
	$("#sa2SumRuleOfrNm"+ruleSa2SumSeqNo).val(defaultOfrNm);    
    $("#sa2SumRuleOfrNo"+ruleSa2SumSeqNo).val(defaultOfrNo);
    $("#sa2SumRuleOfrRid"+ruleSa2SumSeqNo).val(defaultOfrRid);
    
	$.fn.ifvmSetSelectOptionCommCode("sa2SumOfrAmtType"+ruleSa2SumSeqNo, "PROM_ACT_AMT_TYPE", null, null, false);
	$("#sa2SumStartVal"+ruleSa2SumSeqNo).attr("onKEYUP", "inputNumberAutoComma(this);");
	 $("#sa2SumEndVal"+ruleSa2SumSeqNo).attr("onKEYUP", "inputNumberAutoComma(this);");
	 
	 if($("#promOfferAmtDefCd").val()=='ACT') {
       	 $("#ofrAmtType"+ruleSa2SumSeqNo).attr("disabled",true);
         $("#ofrAmt"+ruleSa2SumSeqNo).attr("disabled",true);
     } else if($("#promOfferAmtDefCd").val()=='RULE') {
    	 $("#sa2SumOfrAmtType"+ruleSa2SumSeqNo).attr("disabled",false);
         $("#sa2SumOfrAmt"+ruleSa2SumSeqNo).attr("disabled",false);
     }
}

function addAc2OnPlusBtn() {
	$("#itemAc2OnMinusfirst1").show();
	ruleAc2OnSeqNo = Number(ruleAc2OnSeqNo) + 1;
	var temp = $("#ac2OnTemp").tmpl(ruleAc2OnSeqNo);
	$("#ruleDetail").append(temp);
	
	$("#ac2OnRuleOfrNm"+ruleAc2OnSeqNo).val(defaultOfrNm);
    $("#ac2OnRuleOfrNo"+ruleAc2OnSeqNo).val(defaultOfrNo);
    $("#ac2OnRuleOfrRid"+ruleAc2OnSeqNo).val(defaultOfrRid);
	
    $.fn.ifvmSetSelectOptionCommCode("ac2OnOfrAmtType"+ruleAc2OnSeqNo, "PROM_ACT_AMT_TYPE", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("onlActCd"+ruleAc2OnSeqNo, "PROM_ONL_ACT_TYPE", null, null, true);
	
	if($("#promOfferAmtDefCd").val()=='ACT') {
		$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",true);
      	 $("#ac2OnOfrAmt"+ruleAc2OnSeqNo).attr("disabled",true);
    } else if($("#promOfferAmtDefCd").val()=='RULE') {
    	$("#ac2OnOfrAmtType"+ruleAc2OnSeqNo).attr("disabled",false);
        $("#ac2OnOfrAmt"+ruleAc2OnSeqNo).attr("disabled",false);
    }
}

function addAc2AddPlusBtn() {
	$("#itemAc2AddMinusfirst1").show();
	ruleAc2AddSeqNo = Number(ruleAc2AddSeqNo) + 1;
	var temp = $("#ac2AddTemp").tmpl(ruleAc2AddSeqNo);
	$("#ruleDetail").append(temp);
	$.fn.ifvmSetSelectOptionCommCode("addInfoCd"+ruleAc2AddSeqNo, "PROM_ADD_INFO_TYPE", null, null, true);
}

//dialog close
function closeRulePop(args) {
	/* $(".tiersGridList").each(function(i,item) {
            $(this).remove(); */
		
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}
	
function promAc2AddRuleSave() {
	
	rtnDatas = [];
		$(".ruleAc2AddGridList").each(function(i,item) {
			i=i+1;
			
			var addInfoCd = $("#addInfoCd"+i).val();
			var rid = $("#ac2AddRuleRid"+i).val();
			
			var rowData = {
					seqNum : i,
					addInfoCd : addInfoCd,
					promRid : campaign.id,
					rid : rid
			};
			rtnDatas.push(rowData); 
	});
		
	

		
		/* var promotionInfoDetail = $("#promotionInfoDetail").ifvValidation(); */
		//if(promotionInfoDetail.confirm()) {
			$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc2AddRule"/>', rtnDatas
					, function(result) {
						if ($.fn.ifvmIsNotEmpty(result)) {
							ruleXmSaveYn = true;
						}
					}, function(result) {
						ruleXmSaveYn = false;
						return ruleXmSaveYn;
					});

}	
	
	
function promAc2OnRuleSave() {
	rtnDatas = [];
		$(".ruleAc2OnGridList").each(function(i,item) {
			i=i+1;
			
			var ac2OnRuleOfrRid = $("#ac2OnRuleOfrRid"+i).val();
			//var effStrtDayCnt = $("#ac2OnEffStrtDayCnt"+i).val();
			var ofrAmt = $("#ac2OnOfrAmt"+i).val();
			var ofrAmtType = $("#ac2OnOfrAmtType"+i).val();
			var onlActCd = $("#onlActCd"+i).val();
			var rid = $("#ac2OnRuleRid"+i).val();
			
			var rowData = {
					/* effStrtDayCnt : effStrtDayCnt, */
					ofrAmt : ofrAmt,
					ofrAmtType : ofrAmtType,
					onlActCd : onlActCd,
					ofrRid     : ac2OnRuleOfrRid,
					seqNum : i,
					promRid : campaign.id,
					rid : rid
			};
			rtnDatas.push(rowData); 
	});
		
		

		
		/* var promotionInfoDetail = $("#promotionInfoDetail").ifvValidation(); */
		//if(promotionInfoDetail.confirm()) {
			$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc2OnRule"/>', rtnDatas
					, function(result) {
						if ($.fn.ifvmIsNotEmpty(result)) {
							ruleXmSaveYn = true;
						}
					}, function(result) {
						ruleXmSaveYn = false;
						return ruleXmSaveYn;
					});

}
	
function promSa2SumRuleSave() {
		rtnDatas = [];
			$(".ruleSa2SumGridList").each(function(i,item) {
				i=i+1;
				var startVal = removeComma($("#sa2SumStartVal"+i).val());
				var endVal = removeComma($("#sa2SumEndVal"+i).val());
				var sa1RuleOfrRid = $("#sa2SumRuleOfrRid"+i).val();
				//var effStrtDayCnt = $("#sa2SumEffStrtDayCnt"+i).val();
				var ofrAmt = $("#sa2SumOfrAmt"+i).val();
				var ofrAmtType = $("#sa2SumOfrAmtType"+i).val();
				var rid = $("#sa2SumRuleRid"+i).val();
				
				var rowData = {	
						startVal : startVal,
						endVal : endVal,
						/* effStrtDayCnt : effStrtDayCnt, */
						ofrAmt : ofrAmt,
						ofrAmtType : ofrAmtType,
						ofrRid     : sa1RuleOfrRid,
						seqNum : i,
						promRid : campaign.id,
						rid : rid
				};
				rtnDatas.push(rowData); 
		});
			
			

			
			/* var promotionInfoDetail = $("#promotionInfoDetail").ifvValidation(); */
			//if(promotionInfoDetail.confirm()) {
				$.ifvSyncPostJSON('<ifvm:action name="savePromotionSa2SumRule"/>', rtnDatas
						, function(result) {
							if ($.fn.ifvmIsNotEmpty(result)) {
								ruleXmSaveYn = true;
							}
						}, function(result) {
							ruleXmSaveYn = false;
							return ruleXmSaveYn;
						});
		//}

}
	
function promSa1RuleSave() {
	rtnDatas = [];
		$(".ruleSa1GridList").each(function(i,item) {
			i=i+1;
			var startVal = removeComma($("#startVal"+i).val());
			var endVal = removeComma($("#endVal"+i).val());
			var sa1RuleOfrRid = $("#sa1RuleOfrRid"+i).val();
			//var effStrtDayCnt = $("#effStrtDayCnt"+i).val();
			var ofrAmt = $("#ofrAmt"+i).val();
			var ofrAmtType = $("#ofrAmtType"+i).val();
			var rid = $("#salRuleXmRid"+i).val();
			
			var rowData = {
					startVal : startVal,
					endVal : endVal,
					/* effStrtDayCnt : effStrtDayCnt, */
					ofrAmt : ofrAmt,
					ofrAmtType : ofrAmtType,
					ofrRid     : sa1RuleOfrRid,
					seqNum : i,
					rid : rid
			};
			rtnDatas.push(rowData); 
	});
		
		if($('input:checkbox[id="chnlConYn"]').is(":checked") == true){
			chnlConYn = 'Y'
		}else{
			chnlConYn = 'N'
		}
		
		if($('input:checkbox[id="payMethYn"]').is(":checked") == true){
			payMethYn = 'Y'
		}else{
			payMethYn = 'N'
		}
		
		if($('input:checkbox[id="prodConYn"]').is(":checked") == true){
			prodConYn = 'Y'
		}else{
			prodConYn = 'N'
		}
		
		if($('input:checkbox[id="prodGrpAllYn"]').is(":checked") == true){
			prodGrpAllYn = 'Y'
		}else{
			prodGrpAllYn = 'N'
		}
		
		if($('input:checkbox[id="sellAmtOfrYn"]').is(":checked") == true){
			sellAmtOfrYn = 'Y'
		}else{
			sellAmtOfrYn = 'N'
		}
		var requestData = {
				promotionSalXmRuleDetail 	: rtnDatas,
				chnlTgtGrpRid  :  chnlTgtGrpRid,
				payMethTypeCd  :  $("#payMethTypeCd").val(),
				prodTgtGrpRid  :  prodTgtGrpRid,
				prodTgtGrpRid2 :  prodTgtGrpRid2,
				prodGrpAllYn   :  prodGrpAllYn,
				promRid        :  campaign.id,
				chnlConYn      :  chnlConYn,
				payMethYn	   :  payMethYn,
				prodConYn      :  prodConYn,
				sellAmtOfrYn   :  sellAmtOfrYn,
				rid			   :  promSa1RuleRid
				
		};
		
		/* var promotionInfoDetail = $("#promotionInfoDetail").ifvValidation(); */
		//if(promotionInfoDetail.confirm()) {
			$.ifvSyncPostJSON('<ifvm:action name="savePromotionSa1Rule"/>', requestData
					, function(result) {
						if ($.fn.ifvmIsNotEmpty(result)) {
							ruleXmSaveYn = true;
						}
					}, function(result) {
						ruleXmSaveYn = false;
						return ruleXmSaveYn;
					});
	//}

}

function promAc2ConRuleSave() {
	
	var requestData = {
			hhpYn 		: $("#hhpYn").is(":checked") ? "Y" : "N",
			emailYn 	: $("#emailYn").is(":checked") ? "Y" : "N",
			addrYn 		: $("#addrYn").is(":checked") ? "Y" : "N",
			promRid     : campaign.id,
			rid			:  promAc2ConRuleRid
	};
	
		$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc2ConRule"/>', requestData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						ruleXmSaveYn = true;
					}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
				});
}
	
function promRuleSave() {
		
	var requestData = {
				promRid			: campaign.id,			
				promTypeLv1Cd : $("#promTypeLv1Cd").val(),
	    		promTypeLv2Cd : $("#promTypeLv2Cd").val(),
	    		ofrRid    : ruleOfrRid,
	    		promOfferAmtDefCd : $("#promOfferAmtDefCd").val(),
	    		tgtGrpRid : ruleTgtGrpRid,
	    		expectTgtGrpRid : ruleExpectTgtGrpRid,
				rid   : promRuleRid
				
		};
		
		/* var promotionInfoDetail = $("#promotionInfoDetail").ifvValidation();
		if(promotionInfoDetail.confirm()) { */
			$.ifvSyncPostJSON('<ifvm:action name="savePromotionRule"/>', requestData
					, function(result) {
						if ($.fn.ifvmIsNotEmpty(result)) {
							if(result.success){
								if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_GEN') {   
									promSa1RuleSave();
									ruleSaveCheck();
								}  else if ($("#promTypeLv1Cd").val() == 'ACT' && $("#promTypeLv2Cd").val() == 'CNTCT_CHG') {
									promAc2ConRuleSave();
									ruleSaveCheck();
								}  else if ($("#promTypeLv1Cd").val() == 'ACT' && $("#promTypeLv2Cd").val() == 'SURVEY') {
									promAc2SurRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_CMLTV') {
									promSa2SumRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_CMLTV') {
									promSa2SumRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_PTR_GEN') {
									promSa1RuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_PTR_CMLTV') {
									promSa2SumRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'AC2' && $("#promTypeLv2Cd").val() == 'AC2ON') {
									promAc2OnRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'MBR' && $("#promTypeLv2Cd").val() == 'ADD_INF') {
									promAc2AddRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'MBR' && $("#promTypeLv2Cd").val() == 'MBR_JOIN') {
									promAc1JoinRuleSave();
									ruleSaveCheck();
								} /* else if ($("#promTypeLv1Cd").val() == 'MBR' && $("#promTypeLv2Cd").val() == 'RCMNDED') {
									promAc1FrndRuleSave();
									ruleSaveCheck();
								} */ else if ($("#promTypeLv1Cd").val() == 'FML' && $("#promTypeLv2Cd").val() == 'FML_JOIN') {
									promAc1FamRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'AC1' && $("#promTypeLv2Cd").val() == 'AC1CARD') {
									promAc1CardRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'CLB' && $("#promTypeLv2Cd").val() == 'CLUB_JOIN') {
									
									promAc1ClbRuleSave();
									ruleSaveCheck();
								} else if ($("#promTypeLv1Cd").val() == 'SA1' && $("#promTypeLv2Cd").val() == 'CBBG') {
									promSa1RuleSave();
									ruleSaveCheck();
								} /* else if ($("#promTypeLv1Cd").val() == 'ACT' && $("#promTypeLv2Cd").val() == 'RCMND') {
									promSa1RuleSave();
									ruleSaveCheck();
								} */ else {
									ruleXmSaveYn = true;
									ruleSaveCheck();
								}

							}
						}
					}, function(result) {
						alert("<spring:message code="M02248" />");
					});
		//}
}

function promAc1ClbRuleSave() {
	var requestData = {
			clubRid 	: clubRid,
			promRid		: campaign.id,
			rid			:  promAc1ClbRuleRid
	};
		
		$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc1ClbRule"/>', requestData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						ruleXmSaveYn = true;
					}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
				});
}

function promAc1CardRuleSave() {

	var requestData = {
			chnTgtGrpRid 	: promAc1CardChnlTgtRid,
			promRid		: campaign.id,
			rid			:  promAc1CardRuleRid
	};
	
		$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc1CardRule"/>', requestData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						ruleXmSaveYn = true;
					}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
				});
}

function promAc1FamRuleSave() {
	if($('input:radio[id="F"]').is(":checked") == true){
		prulFamCd = 'F';
	} else if($('input:radio[id="A"]').is(":checked") == true) {
		prulFamCd = 'A';
	} 
	
	var requestData = {
			prulFamCd 	: prulFamCd,
			promRid		: campaign.id,
			rid			:  promAc1FamRuleRid
	};
	
		$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc1FamRule"/>', requestData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						ruleXmSaveYn = true;
					}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
				});
}

function promAc1FrndRuleSave() {
	if($('input:radio[id="ONLY"]').is(":checked") == true){
		prulRecomCd = 'ONLY';
	} else if($('input:radio[id="NOTONLY"]').is(":checked") == true) {
		prulRecomCd = 'NOTONLY';
	} else if($('input:radio[id="NONLY"]').is(":checked") == true) {
		prulRecomCd = 'NONLY';
	} 
	
	var requestData = {
			prulRecomCd 	: prulRecomCd,
			promRid		: campaign.id,
			rid			:  promAc1FrndRuleRid
	};
	
		$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc1FrndRule"/>', requestData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						ruleXmSaveYn = true;
					}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
				});
}

function promAc1JoinRuleSave() {
	if($('input:radio[id="ALL"]').is(":checked") == true){
		prulJoinChnlCd = 'ALL';
	} else if($('input:radio[id="APP"]').is(":checked") == true) {
		prulJoinChnlCd = 'APP';
	} else if($('input:radio[id="CHNL"]').is(":checked") == true) {
		prulJoinChnlCd = 'CHNL';
	}
	
	var requestData = {
			prulJoinChnlCd 	: prulJoinChnlCd,
			chnlTgtGrpRid : ac1JoinChnlTgtGrpRid,
			promRid		: campaign.id,
			rid			:  promAc1JoinRuleRid
	};
	
		$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc1JoinRule"/>', requestData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						ruleXmSaveYn = true;
					}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
				});
}



function promAc2SurRuleSave() {
	var requestData = {
			surveyRid    : surveyRid,
    		promRid	    : campaign.id,
			rid   		: promAc2SurRuleRid
			
	};
	$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc2SurRule"/>', requestData
			  , function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
				ruleXmSaveYn = true;
			}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
			});
}

function promAc2AgrRuleSave() {
	
	var requestData = {
			textYn 		: $("#textYn").is(":checked") ? "Y" : "N",
			emailYn 	: $("#emailYn").is(":checked") ? "Y" : "N",
			tmYn 		: $("#tmYn").is(":checked") ? "Y" : "N",
			dmYn 		: $("#dmYn").is(":checked") ? "Y" : "N",
			pushYn 		: $("#pushYn").is(":checked") ? "Y" : "N",
			kkfYn 		: $("#kkfYn").is(":checked") ? "Y" : "N",	
			promRid		: campaign.id,
			rid			:  promAc2AgrRuelRid
	};
	
		$.ifvSyncPostJSON('<ifvm:action name="savePromotionAc2AgrRule"/>', requestData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						ruleXmSaveYn = true;
					}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
				});
}

function ruleSaveCheck() {
	
	if(!ruleXmSaveYn){
		alert("<spring:message code="M02248" />");
		return;
	} else {
		alert("<spring:message code="C00094" />");
		closeRulePop();
	}
}

function promSa1AniRuleSave() {
	var requestData = {
			conditionCd	: $("#conditionCd").val(),	
			operCd 		: $("#operCd").val(),
    		dayVal 		: $("#dayVal").val(),
    		promRid	    : campaign.id,
			rid   		: promSa1AniRuleRid
			
	};
	$.ifvSyncPostJSON('<ifvm:action name="savePromotionSa1AniRule"/>', requestData
			  , function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
				ruleXmSaveYn = true;
			}
				}, function(result) {
					ruleXmSaveYn = false;
					return ruleXmSaveYn;
			});
}

function inputNumberAutoComma(obj) {
	   
    // 콤마( , )의 경우도 문자로 인식되기때문에 콤마를 따로 제거한다.
    var deleteComma = obj.value.replace(/\,/g, "");
    // 기존에 들어가있던 콤마( , )를 제거한 이 후의 입력값에 다시 콤마( , )를 삽입한다.
    obj.value = inputNumberWithComma(inputNumberRemoveComma(obj.value));
}

// 천단위 이상의 숫자에 콤마( , )를 삽입하는 함수
function inputNumberWithComma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
}

function inputNumberRemoveComma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, "");
}

function removeComma(str)
{
	n = parseInt(str.replace(/,/g,""));
	return n;
}

function ruleRemove() {
	if($("#promStatCd").val()!='W') {
		alert("작성중이 아닌 프로모션은 룰 변경이 불가능합니다.");
	}
	else{
	if( confirm('<spring:message code="유형 변경시 기존 Rule데이터는 삭제됩니다. 변경저장하시겠습니까?"/>') == true ){
		$("#ruleDetail").empty();
		
		$.ifvSyncPostJSON('<ifvm:action name="removeSa1Rule"/>', {
            rid			     : promSa1RuleRid,
            promTypeLv1Cd    : $("#promTypeLv1Cd").val(),
            promTypeLv2Cd    : $("#promTypeLv2Cd").val(),
            prePromTypeLv1Cd : promTypeLv1Cd,
            prePromTypeLv2Cd : promTypeLv2Cd,
            promRid		     : campaign.id
        },
        function(result) {
        	//rulePopupInit();
        	ruleCheck();
        });
	} else {
		//$("#promTypeLv1Cd").val(promTypeLv1Cd);
		//$("#promTypeLv2Cd").val(promTypeLv2Cd);

	    //조직
	    //$.fn.ifvmSetSelectOptionCommCodeSync("promTypeLv2Cd", "PROM_TYPE_LV2", $("#promTypeLv1Cd").val(), "promTypeLv1Cd", false);
	}
	}

}

function actionCheck() {
	if($("#promOfferAmtDefCd").val()=='ACT') {
		if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_GEN') {   
			for(var i=1;i<=ruleSa1SeqNo;i++) {
				$("#ofrAmtType"+i).attr("disabled",true);
				$("#ofrAmtType"+i).val('');
				$("#ofrAmt"+i).val('');
				$("#ofrAmt"+i).attr("disabled",true);
			}
			
		} else if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_CMLTV') {   
			for(var i=1;i<=ruleSa2SumSeqNo;i++) {
				$("#sa2SumOfrAmtType"+i).attr("disabled",true);
				$("#sa2SumOfrAmtType"+i).val('');
				$("#sa2SumOfrAmt"+i).val('');
				$("#sa2SumOfrAmt"+i).attr("disabled",true);
			}

		} else if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_CMLTV') {   
			for(var i=1;i<=ruleSa2SumSeqNo;i++) {
				$("#sa2SumOfrAmtType"+i).attr("disabled",true);
				$("#sa2SumOfrAmtType"+i).val('');
				$("#sa2SumOfrAmt"+i).val('');
				$("#sa2SumOfrAmt"+i).attr("disabled",true);
			}
		} else if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_PTR_CMLTV') {   
			for(var i=1;i<=ruleSa2SumSeqNo;i++) {
				$("#sa2SumOfrAmtType"+i).attr("disabled",true);
				$("#sa2SumOfrAmtType"+i).val('');
				$("#sa2SumOfrAmt"+i).val('');
				$("#sa2SumOfrAmt"+i).attr("disabled",true);
			}
		} else if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_PTR_GEN') {   
			for(var i=1;i<=ruleSa1SeqNo;i++) {
				$("#ofrAmtType"+i).attr("disabled",true);
				$("#ofrAmtType"+i).val('');
				$("#ofrAmt"+i).val('');
				$("#ofrAmt"+i).attr("disabled",true);
			}
		} else if($("#promTypeLv1Cd").val() == 'AC2' && $("#promTypeLv2Cd").val() == 'AC2ON') {   
			for(var i=1;i<=ruleAc2OnSeqNo;i++) {
				$("#ac2OnOfrAmtType"+i).attr("disabled",true);
				$("#ac2OnOfrAmtType"+i).val('');
				$("#ac2OnOfrAmt"+i).val('');
				$("#ac2OnOfrAmt"+i).attr("disabled",true);
			}
			
		}
	} else if($("#promOfferAmtDefCd").val()=='RULE') {
		if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_GEN') {   
			for(var i=1;i<=ruleSa1SeqNo;i++) {
				$("#ofrAmtType"+i).attr("disabled",false);
				$("#ofrAmt"+i).attr("disabled",false);
			}
		} else if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_CMLTV') {   
			for(var i=1;i<=ruleSa2SumSeqNo;i++) {
				$("#sa2SumOfrAmtType"+i).attr("disabled",false);
				$("#sa2SumOfrAmt"+i).attr("disabled",false);
			}
		} else if($("#promTypeLv1Cd").val() == 'PUR' && $("#promTypeLv2Cd").val() == 'PUR_CMLTV') {   
			for(var i=1;i<=ruleSa2SumSeqNo;i++) {
				$("#sa2SumOfrAmtType"+i).attr("disabled",false);
				$("#sa2SumOfrAmt"+i).attr("disabled",false);
			}
		} else if($("#promTypeLv1Cd").val() == 'AC2' && $("#promTypeLv2Cd").val() == 'AC2ON') {   
			for(var i=1;i<=ruleAc2OnSeqNo;i++) {
				$("#ac2OnOfrAmtType"+i).attr("disabled",false);
				$("#ac2OnOfrAmt"+i).attr("disabled",false);
			}
		}
	}
}

function rulePromInfoData() {
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromInfo"/>', {
    	promRid: campaign.id
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)){
        	cpnYn = result.cpnYn;
        }
    });
}



$(document).ready(function () {	
	/* $("#promotionInfoDetail :ifvm:input").empty();
	$("#ruleDetail :input").empty(); */
	
	rulePopupInit();	
	
	rulePromInfoData();
	
	rulePopupData();
	
	 $("#sellAmtOfrYn").change(function(){
		if($("#sellAmtOfrYn").is(":checked")){
            
        }else{
            
        }
    }); 
    
    $("#promOfferAmtDefCd").change(function(){
		
    	actionCheck();
    });
	
	$('#promTypeLv1Cd').change(function(){
		typeCheck = true;
	});
	  
	
	$('#promTypeLv2Cd').change(function(){
		
		if(typeCheck) { 
			ruleRemove();
		}
		typeCheck = true;
	});
	 
    $("#promRuleTgtPopBtn").click(function(){
    	promRuleTgtPopup();
	});
    
    $("#promRuleExpTgtPopBtn").click(function(){
    	promRuleExpTgtPopup();
	});
    
  //저장 클릭시
    $('#promRuleSaveBtn').on('click', function(){
    	promRuleSave();
    });
	 
  //취소 클릭시
    $('#promRuleCancelBtn').on('click', function(){
    	closeRulePop();
    });
  
    $("#offerSearchPopBtn").click(function(){
		if($("#promTypeLv2Cd").val()=='EVENT_FIRST') {
			offerissTypePopup();
		}else {
			offerListPopup();
		}
	});
    
    /* $("#offerSearchPopBtn").click(function(){
		offerListPopup();
	}); */
    
    $("#tgtGrpIncPopBtn").click(function(){
    	tgtGrpIncPopup();
	});
    
    $("#expectTgtGrpIncPopBtn").click(function(){
    	expectTgtGrpIncPopup();
	});
    
    promStatCheck();
});


</script>