class AppWriteConstants {
  static const String databaseId = '63f7b7bb0cf1dc3128c6';
  static const String projectId = '63f7af6ea6769894dafa';
  static const String endPoint = 'http://localhost:8080/v1';

  static const String usersCollectionId = '63fd4b7f763980614f81'; 
  static const String tweetsColletionId = '64012b4920d18eab77fd';

  static const String imagesBucketId = '64013611bdc0fab173c5';

  static String imageUrl(String imageId) => 
    '$endPoint/storage/buckets/$imagesBucketId/files/$imageId/view?project=$projectId&mode=admin';
}