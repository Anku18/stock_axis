class PricingDataModel {
  List<PricingData>? data;

  PricingDataModel({this.data});

  PricingDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PricingData>[];
      json['data'].forEach((v) {
        data!.add(PricingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PricingData {
  String? pCode;
  String? pDescription;
  num? pAmount;
  String? pDuration;
  String? pKGName;
  String? comboOffer;
  String? alertMsg;
  String? couponCode;
  int? srNo;
  String? pTotaAmount;

  PricingData(
      {this.pCode,
      this.pDescription,
      this.pAmount,
      this.pDuration,
      this.pKGName,
      this.comboOffer,
      this.alertMsg,
      this.couponCode,
      this.srNo,
      this.pTotaAmount});

  PricingData.fromJson(Map<String, dynamic> json) {
    pCode = json['PCode'];
    pDescription = json['PDescription'];
    pAmount = num.parse(json['PAmount']);
    pDuration = json['PDuration'];
    pKGName = json['PKGName'];
    comboOffer = json['ComboOffer'];
    alertMsg = json['AlertMsg'];
    couponCode = json['CouponCode'];
    srNo = json['SrNo'];
    pTotaAmount = json['PTotaAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PCode'] = pCode;
    data['PDescription'] = pDescription;
    data['PAmount'] = pAmount;
    data['PDuration'] = pDuration;
    data['PKGName'] = pKGName;
    data['ComboOffer'] = comboOffer;
    data['AlertMsg'] = alertMsg;
    data['CouponCode'] = couponCode;
    data['SrNo'] = srNo;
    data['PTotaAmount'] = pTotaAmount;
    return data;
  }

  @override
  String toString() {
    return pAmount != null
        ? "$pDuration - Rs. $pAmount"
        : 'Select a Plan (inclusive of GST)';
  }
}
