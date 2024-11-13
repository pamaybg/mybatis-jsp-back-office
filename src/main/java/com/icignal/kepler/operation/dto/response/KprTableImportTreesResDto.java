package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 8. 4.
 * @author : LEE
 * @description : 테이블 불러오기 ResponseDTO
 */
public class KprTableImportTreesResDto extends GridPagingItemResDto {
	
	List<KprTableImportTreeResDto> items;

	public List<KprTableImportTreeResDto> getItems() {
		return items;
	}

	public void setItems(List<KprTableImportTreeResDto> items) {
		this.items = items;
	}

}
