package com.icignal.loyalty.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : infavor.loyalty.common.dto.response.LOYPurPayListResponseDTO
 * @date : 2017. 6. 29.
 * @author : "jh.kim"
 * @description : 구매이력의 결제 상세 목록 Response DTO
 */
@PersonalData
public class LoyPurPayListResDto extends GridPagingItemResDto {
    
    private String rid;              //RID
    private String ridIntactPur;     //RID_INTACT_PUR
    private String payMethdCd;       //결제 수단 코드
    private String channelCd;        //카드 유형 코드 
    private String amt;              //금액
    private String cardNo;           //카드 번호
    private String flag;             //활성화 여부
    private String modNum;           //MOD_NUM
    private String createDate;       //등록일시
    private String createBy;         //CREATE_BY
    private String modifyDate;       //수정일시
    private String modifyBy;         //MODIFY_BY
    
    @Decrypted(masked = "cardNum")
    private String cardNm;           //카드명
    private String payMethdCdNm;     //결제수단명
    
    public String getPayMethdCdNm() {
        return payMethdCdNm;
    }
    
    public void setPayMethdCdNm(String payMethdCdNm) {
        this.payMethdCdNm = payMethdCdNm;
    }
    
    public String getCardNm() {
        return cardNm;
    }
    
    public void setCardNm(String cardNm) {
        this.cardNm = cardNm;
    }
    
    public String getRid() {
        return rid;
    }
    
    public void setRid(String rid) {
        this.rid = rid;
    }
    
    public String getRidIntactPur() {
        return ridIntactPur;
    }
    
    public void setRidIntactPur(String ridIntactPur) {
        this.ridIntactPur = ridIntactPur;
    }
    
    public String getPayMethdCd() {
        return payMethdCd;
    }
    
    public void setPayMethdCd(String payMethdCd) {
        this.payMethdCd = payMethdCd;
    }
    
    public String getChannelCd() {
        return channelCd;
    }
    
    public void setChannelCd(String channelCd) {
        this.channelCd = channelCd;
    }
    
    public String getAmt() {
        return amt;
    }
    
    public void setAmt(String amt) {
        this.amt = amt;
    }
    
    public String getCardNo() {
        return cardNo;
    }
    
    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }
    
    public String getFlag() {
        return flag;
    }
    
    public void setFlag(String flag) {
        this.flag = flag;
    }
    
    public String getModNum() {
        return modNum;
    }
    
    public void setModNum(String modNum) {
        this.modNum = modNum;
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
    
}
