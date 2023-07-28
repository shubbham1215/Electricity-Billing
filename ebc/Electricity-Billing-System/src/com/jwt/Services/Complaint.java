package com.jwt.Services;

import java.util.List;

public class Complaint {
	
	private String complaint_id;
	private String cus_id;
	private String bill_no;
	private String description;
	private double amount;
	
	public Complaint(List<Object> row) {
		this.complaint_id = (String) row.get(0);
		this.cus_id = (String) row.get(1);
		this.bill_no = (String) row.get(2);
		this.description = (String) row.get(3);
		this.amount = Double.parseDouble((String) row.get(4));
	}
	
	public String getComplaint_id() {
		return complaint_id;
	}
	public void setComplaint_id(String complaint_id) {
		this.complaint_id = complaint_id;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}

}
