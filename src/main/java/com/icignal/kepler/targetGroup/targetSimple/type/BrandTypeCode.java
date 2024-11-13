package com.icignal.kepler.targetGroup.targetSimple.type;


import java.util.Arrays;

public enum BrandTypeCode {
    LECOQ("Q", "MainShopCode_Q"),
    LECOQ_GOLF("G", "MainShopCode_G"),
    DESCENTE("S", "MainShopCode_S"),
    DESCENTE_GOLF("D", "MainShopCode_D"),
    UMBRO("U", "MainShopCode_U"),
    MUNSINGWEAR("M", "MainShopCode_M"),
    NO_BRAND("", "MainShopCode")  // MainShopCode 컬럼은 아무 값도 없는 컬럼임      테이블 FACTMEMBER > AS-IS : MainShopCode  TO-BE : 브랜드별 MainShopCode
    ;
    private final String code;
    private final String mainShopColumn;

    public String getCode() {
        return this.code;
    }

    public String getMainShopColumn() {
        return this.mainShopColumn;
    }

    BrandTypeCode(String code, String mainShopColumn) {
        this.code = code;
        this.mainShopColumn = mainShopColumn;
    }

    public static BrandTypeCode fromCode(String code) {
        return Arrays.stream(BrandTypeCode.values())
                .filter(type -> type.getCode().equals(code))
                .findFirst()
                .orElse(BrandTypeCode.NO_BRAND);
    }
}
