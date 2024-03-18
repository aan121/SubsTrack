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

  SubscriptionModel(
      this.subscriptionName,
      this.subscriptionCost,
      this.subscriptionDay,
      this.subscriptionMonth,
      this.subscriptionCycle,
      this.subscriptionCategory,
      this.currentUserID,
      this.isDateIncrease,
      this.subscriptionYear);

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
    };
  }
}
