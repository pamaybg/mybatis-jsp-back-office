package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class OfferResDto extends GridPagingItemResDto {

    // 시스템
    private String rid;
    private String createDate;
    private String createBy;
    private String modifyDate;
    private String modifyBy;

    // 릴레이션
    private String ridChnl;
    private String chnlNm;
    private String ridOfrgrp;
    private String ofrgrpNm;
    private String effStartDayCnt;
    private String effStartDate;
    private String effDateType;
    private String useMinPurAmt;
    private String useMaxDcAmt;
    private String useDupYn;
    private String camNm;
    private String camApiKey;
    private String camCreateDate;
    private String offerTypeCodeName;
    private String cpndescText;

    // 코드
    private String statCd;
    @MarkName(groupCode = "LOY_OFR_STAT_TYPE", codeField = "statCd")
    private String statCdNm;
    private String ofrType;
    @MarkName(groupCode = "COM_OFR_TYPE", codeField = "ofrType")
    private String ofrTypeNm;
    private String ofrSubType;
    @MarkName(groupCode = "X_DK_OFR_SUB_TYPE", codeField = "ofrSubType")
    private String ofrSubTypeNm;
    private String ofrValType;
    @MarkName(groupCode = "LOY_OFR_VAL_TYPE", codeField = "ofrValType")
    private String ofrValTypeNm;
    private String settleType;
    @MarkName(groupCode = "LOY_OFR_SETTLE_TYPE", codeField = "settleType")
    private String settleTypeNm;
    private String expirType;
    @MarkName(groupCode = "LOY_OFR_EXPIR_TYPE", codeField = "expirType")
    private String expirTypeNm;
    // 기본 필드
    private String ofrNo;
    private String ofrNm;
    private String descText;
    private String validStartDate;
    private String validEndDate;
    private String feeAmt;
    private String feeCurncy;
    private String feeShareBaseAmt;
    private String ofrValAmt;
    private String ofrCostAmt;
    private String hqSettleRate;
    private String feeSettleUseRate;
    private String cpnYn;
    private String feeYn;
    private String vocYn;
    private String giftYn;
    private String useChnlLimitYn;
    private String useProdLimitYn;
    private String expirMM;

    private String refCd;
    private String settleRefCd;

    private String maxAmt;
    private String maxLimitTypeCd;
    private String maxLimitAmt;

    private String validDate;
    private String usableMaxCnt;
    private String empYn;
    private String ofrCtg;
    @MarkName(groupCode = "LOY_OFR_MST_TYPE", codeField = "ofrCtg")
    private String ofrCtgNm;
    private String expirCnt;
    private String useFixStartDate;
    private String useFixEndDate;
    private String useExpirType;
    private String valDate;
    @MarkName(groupCode = "LOY_CPN_EXPIR_TYPE", codeField = "useExpirType")
    private String useExpirTypeNM;
    private String useExpirDayCnt;
    private String useExpirDay;


    public String getExpirCnt() {
        return expirCnt;
    }

    public void setExpirCnt(String expirCnt) {
        this.expirCnt = expirCnt;
    }

    public String getOfrCtgNm() {
        return ofrCtgNm;
    }

    public void setOfrCtgNm(String ofrCtgNm) {
        this.ofrCtgNm = ofrCtgNm;
    }

    public String getOfrCtg() {
        return ofrCtg;
    }

    public void setOfrCtg(String ofrCtg) {
        this.ofrCtg = ofrCtg;
    }

    public String getEmpYn() {
        return empYn;
    }

    public void setEmpYn(String empYn) {
        this.empYn = empYn;
    }

    public String getUseMinPurAmt() {
        return useMinPurAmt;
    }

    public void setUseMinPurAmt(String useMinPurAmt) {
        this.useMinPurAmt = useMinPurAmt;
    }

    public String getUseMaxDcAmt() {
        return useMaxDcAmt;
    }

    public void setUseMaxDcAmt(String useMaxDcAmt) {
        this.useMaxDcAmt = useMaxDcAmt;
    }

    public String getUseDupYn() {
        return useDupYn;
    }

    public void setUseDupYn(String useDupYn) {
        this.useDupYn = useDupYn;
    }

    public String getEffStartDayCnt() {
        return effStartDayCnt;
    }

    public void setEffStartDayCnt(String effStartDayCnt) {
        this.effStartDayCnt = effStartDayCnt;
    }

    public String getEffStartDate() {
        return effStartDate;
    }

    public void setEffStartDate(String effStartDate) {
        this.effStartDate = effStartDate;
    }

    public String getEffDateType() {
        return effDateType;
    }

    public void setEffDateType(String effDateType) {
        this.effDateType = effDateType;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getRidChnl() {
        return ridChnl;
    }

    public void setRidChnl(String ridChnl) {
        this.ridChnl = ridChnl;
    }

    public String getChnlNm() {
        return chnlNm;
    }

    public void setChnlNm(String chnlNm) {
        this.chnlNm = chnlNm;
    }

    public String getRidOfrgrp() {
        return ridOfrgrp;
    }

    public void setRidOfrgrp(String ridOfrgrp) {
        this.ridOfrgrp = ridOfrgrp;
    }

    public String getOfrgrpNm() {
        return ofrgrpNm;
    }

    public void setOfrgrpNm(String ofrgrpNm) {
        this.ofrgrpNm = ofrgrpNm;
    }

    public String getStatCd() {
        return statCd;
    }

    public void setStatCd(String statCd) {
        this.statCd = statCd;
    }

    public String getStatCdNm() {
        return statCdNm;
    }

    public void setStatCdNm(String statCdNm) {
        this.statCdNm = statCdNm;
    }

    public String getOfrType() {
        return ofrType;
    }

    public void setOfrType(String ofrType) {
        this.ofrType = ofrType;
    }

    public String getOfrTypeNm() {
        return ofrTypeNm;
    }

    public void setOfrTypeNm(String ofrTypeNm) {
        this.ofrTypeNm = ofrTypeNm;
    }

    public String getOfrSubType() {
        return ofrSubType;
    }

    public void setOfrSubType(String ofrSubType) {
        this.ofrSubType = ofrSubType;
    }

    public String getOfrSubTypeNm() {
        return ofrSubTypeNm;
    }

    public void setOfrSubTypeNm(String ofrSubTypeNm) {
        this.ofrSubTypeNm = ofrSubTypeNm;
    }

    public String getOfrValType() {
        return ofrValType;
    }

    public void setOfrValType(String ofrValType) {
        this.ofrValType = ofrValType;
    }

    public String getOfrValTypeNm() {
        return ofrValTypeNm;
    }

    public void setOfrValTypeNm(String ofrValTypeNm) {
        this.ofrValTypeNm = ofrValTypeNm;
    }

    public String getSettleType() {
        return settleType;
    }

    public void setSettleType(String settleType) {
        this.settleType = settleType;
    }

    public String getSettleTypeNm() {
        return settleTypeNm;
    }

    public void setSettleTypeNm(String settleTypeNm) {
        this.settleTypeNm = settleTypeNm;
    }

    public String getExpirType() {
        return expirType;
    }

    public void setExpirType(String expirType) {
        this.expirType = expirType;
    }

    public String getExpirTypeNm() {
        return expirTypeNm;
    }

    public void setExpirTypeNm(String expirTypeNm) {
        this.expirTypeNm = expirTypeNm;
    }

    public String getOfrNo() {
        return ofrNo;
    }

    public void setOfrNo(String ofrNo) {
        this.ofrNo = ofrNo;
    }

    public String getOfrNm() {
        return ofrNm;
    }

    public void setOfrNm(String ofrNm) {
        this.ofrNm = ofrNm;
    }

    public String getDescText() {
        return descText;
    }

    public void setDescText(String descText) {
        this.descText = descText;
    }

    public String getValidStartDate() {
        return validStartDate;
    }

    public void setValidStartDate(String validStartDate) {
        this.validStartDate = validStartDate;
    }

    public String getValidEndDate() {
        return validEndDate;
    }

    public void setValidEndDate(String validEndDate) {
        this.validEndDate = validEndDate;
    }

    public String getFeeAmt() {
        return feeAmt;
    }

    public void setFeeAmt(String feeAmt) {
        this.feeAmt = feeAmt;
    }

    public String getFeeCurncy() {
        return feeCurncy;
    }

    public void setFeeCurncy(String feeCurncy) {
        this.feeCurncy = feeCurncy;
    }

    public String getFeeShareBaseAmt() {
        return feeShareBaseAmt;
    }

    public void setFeeShareBaseAmt(String feeShareBaseAmt) {
        this.feeShareBaseAmt = feeShareBaseAmt;
    }

    public String getOfrValAmt() {
        return ofrValAmt;
    }

    public void setOfrValAmt(String ofrValAmt) {
        this.ofrValAmt = ofrValAmt;
    }

    public String getOfrCostAmt() {
        return ofrCostAmt;
    }

    public void setOfrCostAmt(String ofrCostAmt) {
        this.ofrCostAmt = ofrCostAmt;
    }

    public String getHqSettleRate() {
        return hqSettleRate;
    }

    public void setHqSettleRate(String hqSettleRate) {
        this.hqSettleRate = hqSettleRate;
    }

    public String getFeeSettleUseRate() {
        return feeSettleUseRate;
    }

    public void setFeeSettleUseRate(String feeSettleUseRate) {
        this.feeSettleUseRate = feeSettleUseRate;
    }

    public String getCpnYn() {
        return cpnYn;
    }

    public void setCpnYn(String cpnYn) {
        this.cpnYn = cpnYn;
    }

    public String getFeeYn() {
        return feeYn;
    }

    public void setFeeYn(String feeYn) {
        this.feeYn = feeYn;
    }

    public String getVocYn() {
        return vocYn;
    }

    public void setVocYn(String vocYn) {
        this.vocYn = vocYn;
    }

    public String getGiftYn() {
        return giftYn;
    }

    public void setGiftYn(String giftYn) {
        this.giftYn = giftYn;
    }

    public String getUseChnlLimitYn() {
        return useChnlLimitYn;
    }

    public void setUseChnlLimitYn(String useChnlLimitYn) {
        this.useChnlLimitYn = useChnlLimitYn;
    }

    public String getUseProdLimitYn() {
        return useProdLimitYn;
    }

    public void setUseProdLimitYn(String useProdLimitYn) {
        this.useProdLimitYn = useProdLimitYn;
    }

    public String getExpirMM() {
        return expirMM;
    }

    public void setExpirMM(String expirMM) {
        this.expirMM = expirMM;
    }

    public String getRefCd() {
        return refCd;
    }

    public void setRefCd(String refCd) {
        this.refCd = refCd;
    }

    public String getSettleRefCd() {
        return settleRefCd;
    }

    public void setSettleRefCd(String settleRefCd) {
        this.settleRefCd = settleRefCd;
    }

    public String getMaxAmt() {
        return maxAmt;
    }

    public void setMaxAmt(String maxAmt) {
        this.maxAmt = maxAmt;
    }

    public String getMaxLimitTypeCd() {
        return maxLimitTypeCd;
    }

    public void setMaxLimitTypeCd(String maxLimitTypeCd) {
        this.maxLimitTypeCd = maxLimitTypeCd;
    }

    public String getMaxLimitAmt() {
        return maxLimitAmt;
    }

    public void setMaxLimitAmt(String maxLimitAmt) {
        this.maxLimitAmt = maxLimitAmt;
    }

    public String getValidDate() {
        return validDate;
    }

    public void setValidDate(String validDate) {
        this.validDate = validDate;
    }

    public String getUsableMaxCnt() {
        return usableMaxCnt;
    }

    public void setUsableMaxCnt(String usableMaxCnt) {
        this.usableMaxCnt = usableMaxCnt;
    }

    public String getCamNm() {
        return camNm;
    }

    public void setCamNm(String camNm) {
        this.camNm = camNm;
    }

    public String getCamApiKey() {
        return camApiKey;
    }

    public void setCamApiKey(String camApiKey) {
        this.camApiKey = camApiKey;
    }

    public String getCamCreateDate() {
        return camCreateDate;
    }

    public void setCamCreateDate(String camCreateDate) {
        this.camCreateDate = camCreateDate;
    }

    public String getUseFixStartDate() {
        return useFixStartDate;
    }

    public void setUseFixStartDate(String useFixStartDate) {
        this.useFixStartDate = useFixStartDate;
    }

    public String getUseFixEndDate() {
        return useFixEndDate;
    }

    public void setUseFixEndDate(String useFixEndDate) {
        this.useFixEndDate = useFixEndDate;
    }

    public String getUseExpirType() {
        return useExpirType;
    }

    public void setUseExpirType(String useExpirType) {
        this.useExpirType = useExpirType;
    }

    public String getUseExpirTypeNM() {
        return useExpirTypeNM;
    }

    public void setUseExpirTypeNM(String useExpirTypeNM) {
        this.useExpirTypeNM = useExpirTypeNM;
    }

    public String getUseExpirDayCnt() {
        return useExpirDayCnt;
    }

    public void setUseExpirDayCnt(String useExpirDayCnt) {
        this.useExpirDayCnt = useExpirDayCnt;
    }

    public String getValDate() {
        return valDate;
    }

    public void setValDate(String valDate) {
        this.valDate = valDate;
    }

    public String getOfferTypeCodeName() {
        return offerTypeCodeName;
    }

    public void setOfferTypeCodeName(String offerTypeCodeName) {
        this.offerTypeCodeName = offerTypeCodeName;
    }

    public String getCpndescText() {
        return cpndescText;
    }

    public void setCpndescText(String cpndescText) {
        this.cpndescText = cpndescText;
    }

    public String getUseExpirDay() {
        return useExpirDay;
    }

    public void setUseExpirDay(String useExpirDay) {
        this.useExpirDay = useExpirDay;
    }
}
