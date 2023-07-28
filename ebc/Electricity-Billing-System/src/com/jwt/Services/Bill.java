package com.jwt.Services;


import java.util.List;


public class Bill {
	
	private String bill_no;
	private String cus_id;
	private String from_date;
	private String to_date;
	private String status;
	private String trans_id;
	private double amount;

	public Bill(List<Object> row) {
		this.bill_no = (String) row.get(0);
		this.cus_id = (String) row.get(1);
		this.from_date = (String) row.get(2);
		this.to_date = (String) row.get(3);
		this.status = (String) row.get(4);
		this.trans_id = (String) row.get(5);
		this.amount = Double.parseDouble((String) row.get(6));
//		System.out.println(bill_no);

	}

		
		
	public String getBill_no() {
		return bill_no;
	}

	public void setBill_no(String bill_no) {
		this.bill_no = bill_no;
	}

	public String getCus_id() {
		return cus_id;
	}

	public void setCus_id(String cus_id) {
		this.cus_id = cus_id;
	}

	public String getFrom_date() {
		return from_date;
	}

	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}

	public String getTo_date() {
		return to_date;
	}

	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTrans_id() {
		return trans_id;
	}

	public void setTrans_id(String trans_id) {
		this.trans_id = trans_id;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}



}

