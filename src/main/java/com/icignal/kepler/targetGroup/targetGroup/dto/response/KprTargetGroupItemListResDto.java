package com.icignal.kepler.targetGroup.targetGroup.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : infavor.kepler.targetGroup.dto.response.KPRTargetGroupItemListResponseDTO
 * @date : 2019. 11. 11.
 * @author : dg.ryu
 * @description :
 */


@PersonalData
public class KprTargetGroupItemListResDto extends GridPagingItemResDto {

	private String memId;
	private String attrib01;
	private String attrib02;
	private String attrib03;
	private String attrib04;
	private String attrib05;
	
	@Decrypted(masked = "none")
	private String unMaskAttrib01;
	@Decrypted(masked = "none")
	private String unMaskAttrib02;
	@Decrypted(masked = "none")
	private String unMaskAttrib03;
	

	public String getUnMaskAttrib01() {
		return unMaskAttrib01;
	}

	public void setUnMaskAttrib01(String unMaskAttrib01) {
		this.unMaskAttrib01 = unMaskAttrib01;
	}

	public String getUnMaskAttrib02() {
		return unMaskAttrib02;
	}

	public void setUnMaskAttrib02(String unMaskAttrib02) {
		this.unMaskAttrib02 = unMaskAttrib02;
	}

	public String getUnMaskAttrib03() {
		return unMaskAttrib03;
	}

	public void setUnMaskAttrib03(String unMaskAttrib03) {
		this.unMaskAttrib03 = unMaskAttrib03;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getAttrib01() {
		return attrib01;
	}

	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}

	public String getAttrib02() {
		return attrib02;
	}

	public void setAttrib02(String attrib02) {
		this.attrib02 = attrib02;
	}

	public String getAttrib03() {
		return attrib03;
	}

	public void setAttrib03(String attrib03) {
		this.attrib03 = attrib03;
	}

	public String getAttrib04() {
		return attrib04;
	}

	public void setAttrib04(String attrib04) {
		this.attrib04 = attrib04;
	}

	public String getAttrib05() {
		return attrib05;
	}

	public void setAttrib05(String attrib05) {
		this.attrib05 = attrib05;
	}

}
