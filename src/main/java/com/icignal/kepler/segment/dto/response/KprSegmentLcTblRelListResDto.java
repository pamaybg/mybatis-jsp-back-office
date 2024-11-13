package com.icignal.kepler.segment.dto.response;

import com.icignal.common.util.StringUtil;
import org.apache.commons.lang.builder.ToStringBuilder;

public class KprSegmentLcTblRelListResDto implements Comparable<KprSegmentLcTblRelListResDto> {

    private String joinTypeCd;
    private String joinTypeNm;
    private String joinOprtCd;
    private String joinOprtNm;
    private String leftTblAlias;
    private String leftSchmaTblNm;
    private String leftTblAliasColNm;
    private String rightTblAlias;
    private String rightSchmaTblNm;
    private String rightTblAliasColNm;
    private String leftLgcCompTblRelId;

    public KprSegmentLcTblRelListResDto(String leftTblAlias, String leftSchmaTblNm, String rightTblAlias, String rightSchmaTblNm) {
        this.leftTblAlias = leftTblAlias;
        this.leftSchmaTblNm = leftSchmaTblNm;
        this.rightTblAlias = rightTblAlias;
        this.rightSchmaTblNm = rightSchmaTblNm;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    @Override
    public int compareTo(KprSegmentLcTblRelListResDto o) {
        int r = 0;
        r = StringUtil.convertNull(this.leftTblAlias).compareTo(StringUtil.convertNull(o.leftTblAlias));
        r += StringUtil.convertNull(this.rightTblAlias).compareTo(StringUtil.convertNull(o.rightTblAlias));

        return r;
    }



    public String getJoinTypeCd() {
        return joinTypeCd;
    }

    public void setJoinTypeCd(String joinTypeCd) {
        this.joinTypeCd = joinTypeCd;
    }

    public String getJoinOprtCd() {
        return joinOprtCd;
    }

    public void setJoinOprtCd(String joinOprtCd) {
        this.joinOprtCd = joinOprtCd;
    }

    public String getLeftTblAlias() {
        return leftTblAlias;
    }

    public void setLeftTblAlias(String leftTblAlias) {
        this.leftTblAlias = leftTblAlias;
    }

    public String getLeftSchmaTblNm() {
        return leftSchmaTblNm;
    }

    public void setLeftSchmaTblNm(String leftSchmaTblNm) {
        this.leftSchmaTblNm = leftSchmaTblNm;
    }

    public String getLeftTblAliasColNm() {
        return leftTblAliasColNm;
    }

    public void setLeftTblAliasColNm(String leftTblAliasColNm) {
        this.leftTblAliasColNm = leftTblAliasColNm;
    }

    public String getRightTblAlias() {
        return rightTblAlias;
    }

    public void setRightTblAlias(String rightTblAlias) {
        this.rightTblAlias = rightTblAlias;
    }

    public String getRightSchmaTblNm() {
        return rightSchmaTblNm;
    }

    public void setRightSchmaTblNm(String rightSchmaTblNm) {
        this.rightSchmaTblNm = rightSchmaTblNm;
    }

    public String getRightTblAliasColNm() {
        return rightTblAliasColNm;
    }

    public void setRightTblAliasColNm(String rightTblAliasColNm) {
        this.rightTblAliasColNm = rightTblAliasColNm;
    }

    public String getLeftLgcCompTblRelId() {
        return leftLgcCompTblRelId;
    }

    public void setLeftLgcCompTblRelId(String leftLgcCompTblRelId) {
        this.leftLgcCompTblRelId = leftLgcCompTblRelId;
    }

    public String getJoinTypeNm() {
        return joinTypeNm;
    }

    public void setJoinTypeNm(String joinTypeNm) {
        this.joinTypeNm = joinTypeNm;
    }

    public String getJoinOprtNm() {
        return joinOprtNm;
    }

    public void setJoinOprtNm(String joinOprtNm) {
        this.joinOprtNm = joinOprtNm;
    }
}
