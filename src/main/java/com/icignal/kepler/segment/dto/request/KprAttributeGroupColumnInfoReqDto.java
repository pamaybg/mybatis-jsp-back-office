package com.icignal.kepler.segment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 속성그룹 컬럼 정보 RequestDTO
 */
public class KprAttributeGroupColumnInfoReqDto extends CommonDataAuthReqDto {
	
	private String atribGroupColId;  //어트리뷰트 컬럼 아이디
    private String simpleCheck;
    private String searchYn;
    private String searchText;
    private String mainShop;

    public String getAtribGroupColId() {
        return atribGroupColId;
    }

    public void setAtribGroupColId(String atribGroupColId) {
        this.atribGroupColId = atribGroupColId;
    }

    public String getSimpleCheck() {
        return simpleCheck;
    }

    public void setSimpleCheck(String simpleCheck) {
        this.simpleCheck = simpleCheck;
    }

    public String getSearchYn() {return searchYn;}

    public void setSearchYn(String searchYn) {this.searchYn = searchYn;}

    @Override
    public String getSearchText() {return searchText;}

    @Override
    public void setSearchText(String searchText) {this.searchText = searchText;}

    public String getMainShop() {
        return mainShop;
    }

    public void setMainShop(String mainShop) {
        this.mainShop = mainShop;
    }
}
