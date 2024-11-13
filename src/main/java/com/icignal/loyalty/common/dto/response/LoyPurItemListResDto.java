package com.icignal.loyalty.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.loyalty.common.dto.response.LOYPurItemListResponseDTO
 * @date : 2017. 6. 29.
 * @author : "jh.kim"
 * @description : 구매이력의 항목 상세 목록 Responser DTO 
 */
public class LoyPurItemListResDto extends GridPagingItemResDto {
    
    private String rid;              //RID
    private String ridIntactPur;     //RID_INTACT_PUR
    private String itemNum;          //아이템 수
    private String brdId;            //브랜드 코드
    private String catId;            //카테고리 코드
    private String ridProd;          //상품 RID
    private String amt;              //금액
    private String occuDt;           //발생일
    private String cancDt;           //취소일
    private String vol;              //수량
    private String flag;             //FLAG
    private String modNum;           //MOD_NUM
    private String createDate;       //등록일시
    private String createBy;         //CREATE_BY
    private String modifyDate;       //수정일시
    private String modifyBy;         //MODIFY_BY
    
    private String brdNm;            //브랜드명
    private String catNm;            //카테고리명
    private String prodNm;           //상품명 
    private String prodId;           //상품코드
    
    public String getBrdNm() {
        return brdNm;
    }
    
    public void setBrdNm(String brdNm) {
        this.brdNm = brdNm;
    }
    
    public String getCatNm() {
        return catNm;
    }
    
    public void setCatNm(String catNm) {
        this.catNm = catNm;
    }
    
    public String getProdNm() {
        return prodNm;
    }
    
    public void setProdNm(String prodNm) {
        this.prodNm = prodNm;
    }
    
    public String getProdId() {
        return prodId;
    }
    
    public void setProdId(String prodId) {
        this.prodId = prodId;
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
    
    public String getItemNum() {
        return itemNum;
    }
    
    public void setItemNum(String itemNum) {
        this.itemNum = itemNum;
    }
    
    public String getBrdId() {
        return brdId;
    }
    
    public void setBrdId(String brdId) {
        this.brdId = brdId;
    }
    
    public String getCatId() {
        return catId;
    }
    
    public void setCatId(String catId) {
        this.catId = catId;
    }
    
    public String getRidProd() {
        return ridProd;
    }
    
    public void setRidProd(String ridProd) {
        this.ridProd = ridProd;
    }
    
    public String getAmt() {
        return amt;
    }
    
    public void setAmt(String amt) {
        this.amt = amt;
    }
    
    public String getOccuDt() {
        return occuDt;
    }
    
    public void setOccuDt(String occuDt) {
        this.occuDt = occuDt;
    }
    
    public String getCancDt() {
        return cancDt;
    }
    
    public void setCancDt(String cancDt) {
        this.cancDt = cancDt;
    }
    
    public String getVol() {
        return vol;
    }
    
    public void setVol(String vol) {
        this.vol = vol;
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
