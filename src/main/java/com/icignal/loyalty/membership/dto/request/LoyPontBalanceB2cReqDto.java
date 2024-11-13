package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name infavor.loyalty.member.mbr.dto.request.LOYPontBalanceB2cRequestDTO
 * @date 2018. 10. 24.
 * @author jh.kim
 * @description B2C 포인트 정보 조회
 */
public class LoyPontBalanceB2cReqDto extends MKTBaseReqDto {

    private String rid;
    private String p_Rst;
    private String p_RstCd;
    private String p_RstMsg;
    private String p_UsePnt;
    private String p_AccrualPnt;
    private String p_Expr1MonthPnt;
    private String p_PreAcrlPnt;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getP_Rst() {
        return p_Rst;
    }

    public void setP_Rst(String p_Rst) {
        this.p_Rst = p_Rst;
    }

    public String getP_RstCd() {
        return p_RstCd;
    }

    public void setP_RstCd(String p_RstCd) {
        this.p_RstCd = p_RstCd;
    }

    public String getP_RstMsg() {
        return p_RstMsg;
    }

    public void setP_RstMsg(String p_RstMsg) {
        this.p_RstMsg = p_RstMsg;
    }

    public String getP_UsePnt() {
        return p_UsePnt;
    }

    public void setP_UsePnt(String p_UsePnt) {
        this.p_UsePnt = p_UsePnt;
    }

    public String getP_AccrualPnt() {
        return p_AccrualPnt;
    }

    public void setP_AccrualPnt(String p_AccrualPnt) {
        this.p_AccrualPnt = p_AccrualPnt;
    }

    public String getP_Expr1MonthPnt() {
        return p_Expr1MonthPnt;
    }

    public void setP_Expr1MonthPnt(String p_Expr1MonthPnt) {
        this.p_Expr1MonthPnt = p_Expr1MonthPnt;
    }

    public String getP_PreAcrlPnt() {
        return p_PreAcrlPnt;
    }

    public void setP_PreAcrlPnt(String p_PreAcrlPnt) {
        this.p_PreAcrlPnt = p_PreAcrlPnt;
    }

}
