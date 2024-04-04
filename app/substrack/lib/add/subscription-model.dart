class SubscriptionModel {
  late String subscriptionName,
      subscriptionCost,
      subscriptionDay,
      subscriptionMonth,
      subscriptionCycle,
      subscriptionCategory,
      currentUserID,
      subscriptionYear;
  late bool isDateIncrease;
  late String subscriptionId;
  String subscriptionLastMonth;

  SubscriptionModel(
      this.subscriptionName,
      this.subscriptionCost,
      this.subscriptionDay,
      this.subscriptionMonth,
      this.subscriptionCycle,
      this.subscriptionCategory,
      this.currentUserID,
      this.isDateIncrease,
      this.subscriptionYear,
      this.subscriptionLastMonth);

  Map<String, dynamic> toJson() {
    return {
      'subscriptionName': subscriptionName,
      'subscriptionCost': subscriptionCost,
      'subscriptionDay': subscriptionDay,
      'subscriptionMonth': subscriptionMonth,
      'subscriptionCycle': subscriptionCycle,
      'subscriptionCategory': subscriptionCategory,
      'currentUserID': currentUserID,
      'isDateIncrease': isDateIncrease,
      'subscriptionYear': subscriptionYear,
      'subscriptionLastMonth': subscriptionLastMonth,
    };
  }
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      json['subscriptionName'] ?? '',
      json['subscriptionCost'] ?? '',
      json['subscriptionDay'] ?? '',
      json['subscriptionMonth'] ?? '',
      json['subscriptionCycle'] ?? '',
      json['subscriptionCategory'] ?? '',
      json['currentUserID'] ?? '',
      json['isDateIncrease'] ?? false,
      json['subscriptionYear'] ?? '',
      json['subscriptionLastMonth'] ?? '',
    );
  }

}
