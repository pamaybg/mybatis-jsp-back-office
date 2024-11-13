<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 일별 등급별 매출 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="dayTierSaleSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="dayTierSaleSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>


	</div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
			<label class="col-xs-1 control-label"  id="labelTab">년</label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="year" names="year" dto="year" />
			</div>
			<label class="col-xs-1 control-label"  id="labelTab">월</label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="month" names="month" dto="month" />
			</div>
			<label class="col-xs-1 control-label">통합회원유형</label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="checkBox" id="custTypeI" 
					label="개인" labelClass="2" conClass="1"/>
			 	<ifvm:inputNew type="checkBox" id="custTypeC" 
					label="법인" labelClass="2" conClass="1"/>
				<ifvm:inputNew type="checkBox" id="custTypeE" 
					label="임직원" labelClass="2" conClass="1"/>
<%-- 				<ifvm:inputNew type="checkBox" id="custTypeOD" 
					label="기타" labelClass="2" conClass="1"/> --%>			
			</div>
			<label class="col-xs-1 control-label" id="chnlTypeTab"> 구분 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlType" names="chnlType" dto="chnlType" />
			</div>
			
			<label class="col-xs-1 control-label" > 매장상태 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlStat" names="chnlStat" dto="chnlStat" />
			</div>
			
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab"><spring:message code="매장" /></label>
			<div class="col-xs-2 control_content">
				<div class="input-group">
					<ifvm:input type="text" disabled="true" maxLength="10" id="chnlNm" />
					<span class="input-group-addon" id="btnChnlListPop"> <a id="chnlListBtn"><i class="fa fa-search"></i></a>
					</span>
					<ifvm:input type="hidden" id="rid"/>
				</div>
			</div>
			
			
		</div>
		
	</div>
</div>

<%-- 그리드 영역 --%>
<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn" objCode="dayTierSaleExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="dtSaleGrid" class="white_bg grid_bd0"></div>
    
    <div class="page_btn_area" >
   		<div class="col-xs-7">
		 <span>용어설명</span>
    	</div>
    </div>
<textarea id="desc" class = "descript" maxlength="100" rows="6" readonly = true>
• 일자 : 결제완료 일자
• 구매회원수 : 결제완료를 한 통합 회원의 수
• 객단가 : 실결제금액/구매회원수
• IPT(Item per Transaction) : 주문당구매수량(구매상품수량/구매건수)
</textarea>    
    
</div>
<div id="chnlListPopDialog" class="popup_container"></div>


<style type="text/css">
.descript{
	width : 98%;
	font-size: 13px;
	box-sizing: border-box;
	margin: 10px;
	padding: 10px;

}

#labelTab{
	width: 5%;
}
#chnlTypeTab{
	width: 6%;
}
</style>


<script type="text/javascript">
var dtSaleGrid;
var sumobj  = {};
var chnl_Type_Rid =null;
var chnl_SubType_Cd =null;

function getDayTierSaleList(){
    var ejGridOption = {
           serializeGridData : function(data) {
        	   if($('#month').val()=="ALLMonth"){
        		   data.monthValue="ALL";
        		   data.yyyy = $('#year').val();
        	   }else{
        		   data.monthValue="NOTALL";
        		   data.yyyymm = $('#year').val()+$('#month').val();
        	   }
        	   data.chnlType = $('#chnlType').val();
        	   data.chnlStat = $('#chnlStat').val();
                data.custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
                data.custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
                data.custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
/*                 data.custTypeO = $("#custTypeOD").is(':checked') ? 'O' : '';
                data.custTypeD = $("#custTypeOD").is(':checked') ? 'D' : '';   */
                data.rid = $("#rid").val();
                return data;
             },
          showStackedHeader: true,
          stackedHeaderRows: [
        	  
        	     		{
  			  	  stackedHeaderColumns: 
           		[
           			{headerText: "",textAlign : 'center',column: "yyyymmdd,chnlNm,allMbrCnt"},
           			{headerText: "",textAlign : 'center',column: "purMbrCnt"},
           			{headerText: "전체(회원+비회원)",textAlign : 'center',column: "allOrdCnt,allSellAmt,allDiscntAmt,allSettleAmt,allAvgSettleAmt,allSkuQty,allSalQty,allAvgSalQty,allAvgUnitPrice,mmbrAmtRate"},
           			{headerText: "회원",textAlign : 'center',column: "mOrdCnt,mSellAmt,mDiscntAmt,mSettleAmt,mAvgSettleAmt,mSkuQty,mSalQty,mAvgSalQty,mAvgUnitPrice,mUnitPrice"},
         			{headerText: "비회원",textAlign : 'center',column: "bOrdCnt,bSellAmt,bDiscntAmt,bSettleAmt,bAvgSettleAmt,bSkuQty,bSalQty,bAvgSalQty,bAvgUnitPrice"},
         			{headerText: "LL Member",textAlign : 'center',column: "lMbrCnt,lOrdCnt,lSellAmt,lDiscntAmt,lSettleAmt,lAvgSettleAmt,lUnitPrice,lSkuQty,lSalQty,lAvgSalQty,lAvgUnitPrice"},
         			{headerText: "VIP",textAlign : 'center',column: "vMbrCnt,vOrdCnt,vSellAmt,vDiscntAmt,vSettleAmt,vAvgSettleAmt,vUnitPrice,vSkuQty,vSalQty,vAvgSalQty,vAvgUnitPrice"},
         			{headerText: "VVIP",textAlign : 'center',column: "wMbrCnt,wOrdCnt,wSellAmt,wDiscntAmt,wSettleAmt,wAvgSettleAmt,wUnitPrice,wSkuQty,wSalQty,wAvgSalQty,wAvgUnitPrice"},
         			{headerText: "PC",textAlign : 'center',column: "pMbrCnt,pOrdCnt,pSellAmt,pDiscntAmt,pSettleAmt,pAvgSettleAmt,pUnitPrice,pSkuQty,pSalQty,pAvgSalQty,pAvgUnitPrice"},
         			{headerText: "WEB(MOBILE)",textAlign : 'center',column: "webMbrCnt,webOrdCnt,webSellAmt,webDiscntAmt,webSettleAmt,webAvgSettleAmt,webUnitPrice,webSkuQty,webSalQty,webAvgSalQty,webAvgUnitPrice"},
         			{headerText: "APP",textAlign : 'center',column: "aMbrCnt,aOrdCnt,aSellAmt,aDiscntAmt,aSettleAmt,aAvgSettleAmt,aUnitPrice,aSkuQty,aSalQty,aAvgSalQty,aAvgUnitPrice"},

           		/* 	{headerText: "   ",textAlign : 'center',column: "mOrdCnt,mSellAmt,mDiscntAmt,mSettleAmt,mAvgSettleAmt,mSkuQty,mSalQty,mAvgSalQty,mAvgUnitPrice"},
         			{headerText: "    ",textAlign : 'center',column: "bOrdCnt,bSellAmt,bDiscntAmt,bSettleAmt,bAvgSettleAmt,bSkuQty,bSalQty,bAvgSalQty,bAvgUnitPrice"},
         			{headerText: "     ",textAlign : 'center',column: "lMbrCnt,lOrdCnt,lSellAmt,lDiscntAmt,lSettleAmt,lAvgSettleAmt,lUnitPrice,lSkuQty,lSalQty,lAvgSalQty,lAvgUnitPrice"},
         			{headerText: "      ",textAlign : 'center',column: "vMbrCnt,vOrdCnt,vSellAmt,vDiscntAmt,vSettleAmt,vAvgSettleAmt,vUnitPrice,vSkuQty,vSalQty,vAvgSalQty,vAvgUnitPrice"},
         			{headerText: "       ",textAlign : 'center',column: "wMbrCnt,wOrdCnt,wSellAmt,wDiscntAmt,wSettleAmt,wAvgSettleAmt,wUnitPrice,wSkuQty,wSalQty,wAvgSalQty,wAvgUnitPrice"}
     */
           			]
         		}
         		
         		],
          showSummary: true,
          summaryRows: [{
              title: "월 합계",
              summaryColumns: [
            	  
            	  
               	 {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allMbrCnt", format: "{0:n0}"}
             	, {summaryType: ej.Grid.SummaryType.Custom,customSummaryValue: currency,  displayColumn: "allSalAmt", format: "{0:n0}"}
             	, {summaryType: ej.Grid.SummaryType.Custom,customSummaryValue: currency,  displayColumn: "mmSellAmt", format: "{0:n0}"}
             	, {summaryType: ej.Grid.SummaryType.Custom,customSummaryValue: currency,  displayColumn: "mmDiscntAmt", format: "{0:n0}"}
             	, {summaryType: ej.Grid.SummaryType.Custom,customSummaryValue: currency,  displayColumn: "mmSettleAmt", format: "{0:n0}"}
             	
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "purMbrCnt",  format: "{0:n0}"}

             	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allOrdCnt",  format: "{0:n0}"}
             	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allSellAmt",  format: "{0:n0}"}
             	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allDiscntAmt", format: "{0:n0}" }
             	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allSettleAmt", format: "{0:n0}" }
            	  
             	 ,{summaryType: ej.Grid.SummaryType.Custom, 
            		 customSummaryValue: currency,
            		 displayColumn: "allAvgSettleAmt",
            		 format: "{0:n0}"}
                 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "allSkuQty", dataMember: "allSkuQty", format: "{0:n0}" }
                 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allAvgSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allAvgUnitPrice", format: "{0:n0}" }
             	 ,{summaryType: ej.Grid.SummaryType.Custom,customSummaryValue: currency,  displayColumn: "mmbrAmtRate", format: "{0:n0}%"}
                                                                          
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "mOrdCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "mSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "mDiscntAmt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "mSettleAmt", format: "{0:n0}" }
            	 
             	 ,{summaryType: ej.Grid.SummaryType.Custom, 
            		 customSummaryValue: currency,
            		 displayColumn: "mAvgSettleAmt",
            		 format: "{0:n0}"}
             	 
              	 ,{summaryType: ej.Grid.SummaryType.Custom, 
            		 customSummaryValue: currency,
            		 displayColumn: "mUnitPrice",
            		 format: "{0:n0}"}
             	
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "mSkuQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "mSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "mAvgSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "mAvgUnitPrice", format: "{0:n0}" }
                                                            
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "bOrdCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "bSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "bDiscntAmt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "bSettleAmt",  format: "{0:n0}" }
            	 
             	 ,{summaryType: ej.Grid.SummaryType.Custom, 
            		 customSummaryValue: currency,
            		 displayColumn: "bAvgSettleAmt",
            		 format: "{0:n0}"}
            	 
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "bSkuQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "bSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "bAvgSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "bAvgUnitPrice", format: "{0:n0}" }
                                                            
            	                                            
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lMbrCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lOrdCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lDiscntAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lSettleAmt",  format: "{0:n0}" }
            	 
             	 ,{summaryType: ej.Grid.SummaryType.Custom, 
            		 customSummaryValue: currency,
            		 displayColumn: "lAvgSettleAmt",
            		 format: "{0:n0}"}
            	 
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lSkuQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lAvgSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lUnitPrice", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "lAvgUnitPrice", format: "{0:n0}" }
            	                                           
            	                                           
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vMbrCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vOrdCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vSellAmt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vDiscntAmt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vSettleAmt", format: "{0:n0}" }

            	 ,{summaryType: ej.Grid.SummaryType.Custom, 
            		 customSummaryValue: currency,
            		 displayColumn: "vAvgSettleAmt",
            		 format: "{0:n0}"}
            	 
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vSkuQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vAvgSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vUnitPrice", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "vAvgUnitPrice",  format: "{0:n0}" }
            	                                          
            	                                          
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wMbrCnt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wOrdCnt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wDiscntAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wSettleAmt",  format: "{0:n0}" }
            	
            	 ,{summaryType: ej.Grid.SummaryType.Custom, 
            		 customSummaryValue: currency,
            		 displayColumn: "wAvgSettleAmt",
            		 format: "{0:n0}"}
            	 
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wSkuQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wAvgSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wUnitPrice",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "wAvgUnitPrice", format: "{0:n0}" } 
          	
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pMbrCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pOrdCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pDiscntAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pSettleAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pAvgSettleAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pSkuQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pAvgSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pUnitPrice", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "pAvgUnitPrice",  format: "{0:n0}" }
            	 
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webMbrCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webOrdCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webDiscntAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webSettleAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webAvgSettleAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webSkuQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webAvgSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webUnitPrice", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "webAvgUnitPrice",  format: "{0:n0}" }
            	 
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aMbrCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aOrdCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aDiscntAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aSettleAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aAvgSettleAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aSkuQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aSalQty",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aAvgSalQty", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aUnitPrice", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "aAvgUnitPrice",  format: "{0:n0}" }
            	 ]
          }],
          dataUrl : '<ifvm:action name="getDayTierSaleList"/>',
          columns:[
          	    {
                   field : 'yyyymmdd' ,headerText : '일자', headerTextAlign : 'center', textAlign: 'center', width:'80',
                   customAttributes : {
                      index : 'yyyymmdd' , sortable: false}/*  */
                },{
                   field : 'chnlNm' ,headerText : '거래 매장', headerTextAlign : 'center', textAlign: 'center', width:'180',
                   customAttributes : {
                      index : 'chnlNm' , sortable: false}/*  */
                },{
                   field : 'allMbrCnt', headerText : '통합회원 가입 수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'allMbrCnt' , sortable: false}/* */
                },                 
                
               /*  전체  */ //구매회원수 필드 수정필요
				{
                    field : 'purMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'purMbrCnt' , sortable: false}/*  */
                },
                {
                    field : 'allOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'allOrdCnt' , sortable: false}/*  */
                },{
                    field : 'allSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'allSellAmt' , sortable: false}/* */
                },{
                   field : 'allDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'allDiscntAmt' , sortable: false}/* */
                },{
                   field : 'allSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'allSettleAmt' , sortable: false}/*  */
                },{
                   field : 'allAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'allAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'allSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'allSkuQty' , sortable: false}/*  */
                },{
                    field : 'allSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'allSalQty' , sortable: false}/* */
                },{
                   field : 'allAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'allAvgSalQty' , sortable: false}/*   */
                },
                {
                    field : 'mmbrAmtRate', headerText : '회원 매출비(%)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}%', width:'80',
                    customAttributes : {
                       index : 'mmbrAmtRate' , sortable: false}
                 },
                /* 회원 */
                
                {
                    field : 'mOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'mOrdCnt' , sortable: false}/*  */
                },{
                    field : 'mSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'mSellAmt' , sortable: false}/* */
                },{
                   field : 'mDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'mDiscntAmt' , sortable: false}/* */
                },{
                   field : 'mSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'mSettleAmt' , sortable: false}/*  */
                },{
                   field : 'mAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'mAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'mUnitPrice', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'mUnitPrice' , sortable: false}/*  */
                 },{
                    field : 'mSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'mSkuQty' , sortable: false}/*  */
                },{
                    field : 'mSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'mSalQty' , sortable: false}/* */
                },{
                   field : 'mAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'mAvgSalQty' , sortable: false}/*   */
                },
                
                /* 비회원 */
                
                {
                    field : 'bOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'bOrdCnt' , sortable: false}/*  */
                },{
                    field : 'bSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'bSellAmt' , sortable: false}/* */
                },{
                   field : 'bDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'bDiscntAmt' , sortable: false}/* */
                },{
                   field : 'bSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'bSettleAmt' , sortable: false}/*  */
                },{
                   field : 'bAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'bAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'bSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'bSkuQty' , sortable: false}/*  */
                },{
                    field : 'bSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'bSalQty' , sortable: false}/* */
                },{
                   field : 'bAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'bAvgSalQty' , sortable: false}/*   */
                },
                
                /* llm등급 */
                
                {
                    field : 'lMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'lMbrCnt' , sortable: false}/*  */
                },{
                    field : 'lOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'lOrdCnt' , sortable: false}/*  */
                },{
                    field : 'lSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'lSellAmt' , sortable: false}/* */
                },{
                   field : 'lDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'lDiscntAmt' , sortable: false}/* */
                },{
                   field : 'lSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'lSettleAmt' , sortable: false}/*  */
                },{
                   field : 'lAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'lAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'lUnitPrice', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'lUnitPrice' , sortable: false}/*  */
                 },{
                    field : 'lSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'lSkuQty' , sortable: false}/*  */
                },{
                    field : 'lSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'lSalQty' , sortable: false}/* */
                },{
                   field : 'lAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'lAvgSalQty' , sortable: false}/*   */
                },
                
                /* vip 등급*/
                
                {
                    field : 'vMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'vMbrCnt' , sortable: false}/*  */
                },{
                    field : 'vOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'vOrdCnt' , sortable: false}/*  */
                },{
                    field : 'vSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'vSellAmt' , sortable: false}/* */
                },{
                   field : 'vDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'vDiscntAmt' , sortable: false}/* */
                },{
                   field : 'vSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'vSettleAmt' , sortable: false}/*  */
                },{
                   field : 'vAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'vAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'vUnitPrice', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'vUnitPrice' , sortable: false}/*  */
                 },{
                    field : 'vSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'vSkuQty' , sortable: false}/*  */
                },{
                    field : 'vSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'vSalQty' , sortable: false}/* */
                },{
                   field : 'vAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'vAvgSalQty' , sortable: false}/*   */
                },
                
  				/* vvip 등급*/
                
                {
                    field : 'wMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'wMbrCnt' , sortable: false}/*  */
                },{
                    field : 'wOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'wOrdCnt' , sortable: false}/*  */
                },{
                    field : 'wSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'wSellAmt' , sortable: false}/* */
                },{
                   field : 'wDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'wDiscntAmt' , sortable: false}/* */
                },{
                   field : 'wSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'wSettleAmt' , sortable: false}/*  */
                },{
                   field : 'wAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'wAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'wUnitPrice', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'wUnitPrice' , sortable: false}/*  */
                 },{
                    field : 'wSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'wSkuQty' , sortable: false}/*  */
                },{
                    field : 'wSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'wSalQty' , sortable: false}/* */
                },{
                   field : 'wAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'wAvgSalQty' , sortable: false}/*   */
                },
                /* PC */                
                {
                    field : 'pMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'pMbrCnt' , sortable: false}/*  */
                },{
                    field : 'pOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'pOrdCnt' , sortable: false}/*  */
                },{
                    field : 'pSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'pSellAmt' , sortable: false}/* */
                },{
                   field : 'pDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'pDiscntAmt' , sortable: false}/* */
                },{
                   field : 'pSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'pSettleAmt' , sortable: false}/*  */
                },{
                   field : 'pAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'pAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'pUnitPrice', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'pUnitPrice' , sortable: false}/*  */
                 },{
                    field : 'pSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'pSkuQty' , sortable: false}/*  */
                },{
                    field : 'pSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'pSalQty' , sortable: false}/* */
                },{
                   field : 'pAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'pAvgSalQty' , sortable: false}/*   */
                },
                
                /* WEB */                
                {
                    field : 'webMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'webMbrCnt' , sortable: false}/*  */
                },{
                    field : 'webOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'webOrdCnt' , sortable: false}/*  */
                },{
                    field : 'webSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'webSellAmt' , sortable: false}/* */
                },{
                   field : 'webDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'webDiscntAmt' , sortable: false}/* */
                },{
                   field : 'webSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'webSettleAmt' , sortable: false}/*  */
                },{
                   field : 'webAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'webAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'webUnitPrice', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'webUnitPrice' , sortable: false}/*  */
                 },{
                    field : 'webSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'webSkuQty' , sortable: false}/*  */
                },{
                    field : 'webSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'webSalQty' , sortable: false}/* */
                },{
                   field : 'webAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'webAvgSalQty' , sortable: false}/*   */
                },
                
                /* APP */                
                {
                    field : 'aMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'aMbrCnt' , sortable: false}/*  */
                },{
                    field : 'aOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'aOrdCnt' , sortable: false}/*  */
                },{
                    field : 'aSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'aSellAmt' , sortable: false}/* */
                },{
                   field : 'aDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'aDiscntAmt' , sortable: false}/* */
                },{
                   field : 'aSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'aSettleAmt' , sortable: false}/*  */
                },{
                   field : 'aAvgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'aAvgSettleAmt' , sortable: false}/*  */
                },{
                    field : 'aUnitPrice', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'aUnitPrice' , sortable: false}/*  */
                 },{
                    field : 'aSkuQty', headerText : '구매 SKU', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'aSkuQty' , sortable: false}/*  */
                },{
                    field : 'aSalQty', headerText : '구매상품수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'90',
                    customAttributes : {
                       index : 'aSalQty' , sortable: false}/* */
                },{
                   field : 'aAvgSalQty', headerText : 'IPT', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'aAvgSalQty' , sortable: false}/*   */
                }
          ],     
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1 desc ,2',
          	  sord : 'asc',
          	  _search : false,
         },
         isHorizontalScroll:true,
         rowList : [10,25,50,100],
         gridDataInit: true,
         radio: false,
         tempId : 'ifvGridSimplePageTemplete2',
      };
      dtSaleGrid = $("#dtSaleGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}


 function currency(args,data){
	
	return sumobj[args.displayColumn];
	
} 

 // SUMMARY CUSTOM 계산 
function getCustomSummary(){
	  sumobj = {};
	   var custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
	   var custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
	   var custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
/* 	   var custTypeO = $("#custTypeOD").is(':checked') ? 'O' : '';
	   var custTypeD = $("#custTypeOD").is(':checked') ? 'D' : ''; */
	   var monthVal=null;
	   var yyyy=null;
	   var yyyymm=null;
	   
	   if($('#month').val()=="ALLMonth"){
		   monthVal="ALL";
		   yyyy = $('#year').val();
	   }else{
		   monthVal="NOTALL";
		   yyyymm = $('#year').val()+$('#month').val();
	   }
	   
	$.ifvSyncPostJSON('<ifvm:action name="getDayTierSaleList2"/>',{
	      monthValue : monthVal,
	      yyyy : yyyy,
	      yyyymm :yyyymm,
          chnlType : $('#chnlType').val(),
          chnlStat :  $('#chnlStat').val(),
          custTypeI : custTypeI,
          custTypeC : custTypeC,
          custTypeE : custTypeE,
/*           custTypeO : custTypeO,
          custTypeD : custTypeD, */
          rid : $("#rid").val()
	},
	function(result) {
		sumobj = result.rows[0]; 
	});
	 
 }
//조회조건 set
function commcodeSetting(){
		//년
	   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
		//월
	   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
		//구분
	  $("#custTypeI").prop('checked',true);
      $("#month").append("<option value='ALLMonth'>전체</option>")

	   $.fn.ifvmSetSelectOptionCommCode("chnlType", "LOY_CHNL_TYPE_CD", null, null, true);
	   $("#chnlType").append("<option value='ALL'>전체</option>")
	   $("#chnlType").val("ALL");
	   
	   $.fn.ifvmSetSelectOptionCommCode("chnlStat", "LOY_CHNL_STAT_CD", null, null, true);
	   $("#chnlStat").append("<option value='ALL'>전체</option>")
// 	   $("#chnlStat").val("ALL");

	}
//현재날짜 조회
function sysdateSet(){
	   var d= new Date();
	   var reqYear =String(d.getFullYear());
	   var reqMonth =d.getMonth()+1;
	   reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
	   $('#year').val(reqYear);
	   $('#month').val(reqMonth);
   }

function chnlListPop(){
	chnl_Type_Rid=$("#rid").val();
	chnl_SubType_Cd = $("#chnlType").val();

	$("#chnlListPopDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="KprChnlListPop"/>',
        contentType: "ajax",
        title: '매장',
        width: 650,
        close : 'chnlListPopClose'
    });
	
}
function chnlListPopClose(){
	
	chnlListPopDialog._destroy();
}

function searchCondInit(){
	
	sysdateSet();
	$("#custTypeI").prop('checked',false);
	$("#custTypeC").prop('checked',false);
	$("#custTypeE").prop('checked',false);
	$("#chnlNm").val("");
	$("#rid").val("");
	$("#chnlType").val("ALL");
	$("#chnlStat").val("ALL");
	
}
$(document).ready(function() {
	
	commcodeSetting();
	sysdateSet();
	getDayTierSaleList();
	
	
	$('#chnlType').find('[value=P]').hide();
	$('#chnlType').find('[value=E]').hide();
	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getDayTierSaleList();
    	getCustomSummary();
    });

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
    
    $('#btnChnlListPop').on('click',function(){
    	chnlListPop();
    });
    
    
	//엑셀다운로드
    $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/dayTierListExcelDown.do','dtSaleGrid' );
    });
	
	
});
</script>