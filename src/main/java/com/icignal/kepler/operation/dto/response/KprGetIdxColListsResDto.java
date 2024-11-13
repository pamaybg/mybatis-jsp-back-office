package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 8. 1.
 * @author : LEE
 * @description : 인덱스 컬럼 ResponseDTO
 */
public class KprGetIdxColListsResDto extends GridPagingItemResDto {
	
	
	List<KprGetIdxColListResDto> items;

	public List<KprGetIdxColListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprGetIdxColListResDto> items) {
		this.items = items;
	}
	
}
