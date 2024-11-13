package com.icignal.loyalty.channel.dto.response;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-05-10 오전 10:23
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-05-10		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyChnlExcelDnDto
 * 2. 클래스명: LoyChnlExcelDnDto
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-05-10
 */

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   채널 엑셀다운 헤더 DTO	
 */
public class LoyChnlExcelDnDto extends GridPagingItemResDto {

    private String RID;
    private String CHNL_NO;
    private String CHNL_NM;
    private String EMP_NO;

    public String getRID() {
        return RID;
    }

    public void setRID(String RID) {
        this.RID = RID;
    }

    public String getCHNL_NO() {
        return CHNL_NO;
    }

    public void setCHNL_NO(String CHNL_NO) {
        this.CHNL_NO = CHNL_NO;
    }

    public String getCHNL_NM() {
        return CHNL_NM;
    }

    public void setCHNL_NM(String CHNL_NM) {
        this.CHNL_NM = CHNL_NM;
    }

    public String getEMP_NO() {
        return EMP_NO;
    }

    public void setEMP_NO(String EMP_NO) {
        this.EMP_NO = EMP_NO;
    }
}
