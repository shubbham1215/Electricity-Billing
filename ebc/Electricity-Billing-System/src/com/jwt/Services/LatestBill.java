package com.jwt.Services;

import java.math.BigInteger;
import java.util.List;

public class LatestBill {
	
	private int disId;
	private String cusId;
	private String cusName;
	private String cusAddress;
	private String email;
	private BigInteger phoneNumber;
	private String toDate;
	private String fromDate;
	private Double elec_charge;
	private Double fixedCharge;
	private Double sancRate;
	private Double payDue;
	private BigInteger meterNumber;
	private String catgName;
	private int catgId;
	private String disName;
	private Double subsidy;
	private Double finalAmount;
	private String billno;
	private String status;
	private Double quantity;
	
	public BigInteger getMeterNumber() {
		return meterNumber;
	}

	public void setMeterNumber(BigInteger meterNumber) {
		this.meterNumber = meterNumber;
	}

	public String getCatgName() {
		return catgName;
	}

	public void setCatgName(String catgName) {
		this.catgName = catgName;
	}

	public String getDisName() {
		return disName;
	}

	public void setDisName(String disName) {
		this.disName = disName;
	}

	public int getDisId() {
		return disId;
	}

	public void setDisId(int disId) {
		this.disId = disId;
	}

	public String getCusId() {
		return cusId;
	}

	public void setCusId(String cusId) {
		this.cusId = cusId;
	}

	public String getCusName() {
		return cusName;
	}

	public void setCusName(String cusName) {
		this.cusName = cusName;
	}

	public String getCusAddress() {
		return cusAddress;
	}

	public void setCusAddress(String cusAddress) {
		this.cusAddress = cusAddress;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public BigInteger getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(BigInteger phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public Double getElec_charge() {
		return elec_charge;
	}

	public void setElec_charge(Double elec_charge) {
		this.elec_charge = elec_charge;
	}

	public Double getFixedCharge() {
		return fixedCharge;
	}

	public void setFixedCharge(Double fixedCharge) {
		this.fixedCharge = fixedCharge;
	}

	public Double getSancRate() {
		return sancRate;
	}

	public void setSancRate(Double sancRate) {
		this.sancRate = sancRate;
	}

	public Double getPayDue() {
		return payDue;
	}

	public void setPayDue(Double payDue) {
		this.payDue = payDue;
	}

	public Double getSubsidy() {
		return subsidy;
	}

	public void setSubsidy(Double subsidy) {
		this.subsidy = subsidy;
	}

	public Double getFinalAmount() {
		return finalAmount;
	}

	public void setFinalAmount(Double finalAmount) {
		this.finalAmount = finalAmount;
	}
	
	public int getCatgId() {
		return catgId;
	}

	public void setCatgId(int catgId) {
		this.catgId = catgId;
	}

	public String getBillno() {
		return billno;
	}

	public void setBillno(String billno) {
		this.billno = billno;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public LatestBill(List<Object> row) {
		this.disId = Integer.parseInt((String) row.get(0));
		this.catgId = Integer.parseInt((String) row.get(1));
		this.cusId = (String) row.get(2);
		this.cusName = (String) row.get(3);
		this.cusAddress = (String) row.get(4);
		this.payDue = Double.parseDouble((String) row.get(5));
		this.email = (String) row.get(6);
		this.phoneNumber = new BigInteger((String) row.get(7));
		
		this.toDate = (String) row.get(9);
		this.fromDate = (String) row.get(10);
		
		this.elec_charge = (Double) row.get(11);
		this.fixedCharge = (Double)  row.get(12);
		this.sancRate = (Double)  row.get(13);
		this.quantity = (Double) row.get(14);
		this.subsidy = (Double)  row.get(15);
		this.finalAmount = (Double)  row.get(16);
		this.meterNumber = new BigInteger((String) row.get(17));
		this.catgName = (String) row.get(18);
		this.disName = (String) row.get(19);
		this.billno = (String) row.get(20);
		this.status = (String) row.get(21);
	}

	public Double getQuantity() {
		return quantity;
	}

	public void setQuantity(Double quantity) {
		this.quantity = quantity;
	}



	
}
