package com.kk.result;

import java.util.List;

public class DatatablesResult<T> {
	private List<T> data; // data 与datatales 加载的“dataSrc"对应

	private int recordsTotal;

	private int recordsFiltered;

	private int draw;

	private Double allcome_onmoney;//入金总额
	private Double allexpendmoney;//出金总额

	public Double getAllcome_onmoney() {
		return allcome_onmoney;
	}

	public void setAllcome_onmoney(Double allcome_onmoney) {
		this.allcome_onmoney = allcome_onmoney;
	}

	public Double getAllexpendmoney() {
		return allexpendmoney;
	}

	public void setAllexpendmoney(Double allexpendmoney) {
		this.allexpendmoney = allexpendmoney;
	}

	public DatatablesResult() {

	}

	public int getDraw() {
		return draw;
	}

	public void setDraw(int draw) {
		this.draw = draw;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public int getRecordsTotal() {
		return recordsTotal;
	}

	public void setRecordsTotal(int recordsTotal) {
		this.recordsTotal = recordsTotal;
		this.recordsFiltered = recordsTotal;
	}

	public int getRecordsFiltered() {
		return recordsFiltered;
	}

	public void setRecordsFiltered(int recordsFiltered) {
		this.recordsFiltered = recordsFiltered;
	}
}
