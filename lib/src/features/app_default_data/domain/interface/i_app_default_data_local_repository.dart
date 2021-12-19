abstract class IAppDefaultDataLocalRepository {
  Future<bool> statusesExists();
  Future<bool> subscriptionsExists();

  Future<List<Map<String, dynamic>>> getStatuses();
  Future<List<Map<String, dynamic>>> getSubscriptions();

  Future<void> saveStatuses({required List<Map<String, dynamic>> statuses});
  Future<void> saveSubscriptions(
      {required List<Map<String, dynamic>> subscriptions});
}
