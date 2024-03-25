class OldSubscriptionModel {
  late String oldSubscriptionCost, subscriptionMonth, subscriptionYear;

  OldSubscriptionModel(
      this.oldSubscriptionCost, this.subscriptionMonth, this.subscriptionYear);

  Map<String, dynamic> toJson() {
    return {
      'oldSubscriptionCost': oldSubscriptionCost,
      'subscriptionMonth': subscriptionMonth,
      'subscriptionYear': subscriptionYear,
    };
  }
}
