package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 18.
 * @author : 이원준
 * @description : 주제영역 목록 ResponseDTO
 */
public class KprSubjectAreaTreesResDto extends GridPagingItemResDto {
	
	List<KprSubjectAreaTreeResDto> items;

	public List<KprSubjectAreaTreeResDto> getItems() {
		return items;
	}

	public void setItems(List<KprSubjectAreaTreeResDto> items) {
		this.items = items;
	}

}
