package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name infavor.Loyalty.member.mbr.dto.request.LoyEncryptRequestDTO
 * @date 2018. 10. 29.
 * @author jh.kim
 * @description 암복호화를 위한 Request DTO
 */
public class LoyEncryptReqDto extends MKTBaseReqDto {

    private String value;
    private String cipherKey;
    private String decryptType;

    public String getDecryptType() {
        return decryptType;
    }

    public void setDecryptType(String decryptType) {
        this.decryptType = decryptType;
    }

    public LoyEncryptReqDto() {
      /*  try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch (Exception e) {
            LogUtil.error(e);
        }*/
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getCipherKey() {
        return cipherKey;
    }

    public void setCipherKey(String cipherKey) {
        this.cipherKey = cipherKey;
    }

}
