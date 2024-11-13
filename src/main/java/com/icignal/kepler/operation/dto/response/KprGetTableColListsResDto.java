package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 8. 3.
 * @author : LEE
 * @description : 테이블 컬럼목록 ResponseDTO
 */
public class KprGetTableColListsResDto extends GridPagingItemResDto {
	
	
	List<KprGetTableColListResDto> items;

	public List<KprGetTableColListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprGetTableColListResDto> items) {
		this.items = items;
	}
	
}
