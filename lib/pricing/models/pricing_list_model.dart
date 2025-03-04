class PricingListModel {
  String? title;
  String? subTitle;
  String? leadingIcon;
  String? description;

  PricingListModel(
      {this.title, this.subTitle, this.leadingIcon, this.description});

  PricingListModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    leadingIcon = json['leadingIcon'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['leadingIcon'] = leadingIcon;
    data['description'] = description;
    return data;
  }
}
