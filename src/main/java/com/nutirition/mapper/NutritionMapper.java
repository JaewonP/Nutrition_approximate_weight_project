package com.nutirition.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nutirition.dao.NuTbl;

public interface NutritionMapper {
	public List<NuTbl> getType(); //데이터 타입 분류
	public List<NuTbl> itemlist(@Param("fegie_name") String fegie_name); //데이터 전체 출력
	public List<NuTbl> itemEach(@Param("fegie_name") String fegie_name,@Param("amount_name") String amount_name,@Param("amount") int amount); //전체 입력 시 해당 데이터만 출력
	public void itemAdd(@Param("fegie_name") String fegie_name,@Param("amount_name") String amount_name, @Param("amount") int amount, @Param("weight") float weight); //데이터 추가
	public List<NuTbl> AllList(); //전체 데이터 목록
	public void itemDelete (@Param("bno") int bno);

}
