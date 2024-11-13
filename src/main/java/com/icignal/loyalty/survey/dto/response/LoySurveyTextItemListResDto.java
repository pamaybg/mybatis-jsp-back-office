package com.icignal.loyalty.survey.dto.response;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.loyalty.survey.dto.response
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-03-02 오후 2:06
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-03-02		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoySurveyTextItemListResDto
 * 2. 클래스명: LoySurveyTextItemListResDto
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-03-02
 */

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   설문 Text Item 제어 List Response Dto	
 */
@CommCode
public class LoySurveyTextItemListResDto extends GridPagingItemResDto {
    private String rid;
    private String sectNo;
    private String itemNo;
    private String itemTitle;
    private String fieldTypeCd;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getSectNo() {
        return sectNo;
    }

    public void setSectNo(String sectNo) {
        this.sectNo = sectNo;
    }

    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    public String getItemTitle() {
        return itemTitle;
    }

    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }

    public String getFieldTypeCd() {
        return fieldTypeCd;
    }

    public void setFieldTypeCd(String fieldTypeCd) {
        this.fieldTypeCd = fieldTypeCd;
    }
}
