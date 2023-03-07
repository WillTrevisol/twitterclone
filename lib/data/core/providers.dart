import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';

final appWriteClientProvider = Provider(
  (ProviderRef ref) {
    Client client = Client();
    return client
      .setEndpoint(AppWriteConstants.endPoint)
      .setProject(AppWriteConstants.projectId)
      .setSelfSigned(status: true);
  }
);

final appWriteAccountProvider = Provider(
  (ProviderRef ref) {
    final client = ref.watch(appWriteClientProvider);
    return Account(client);
  }
);

final appWriteDatabaseProvider = Provider(
  (ProviderRef ref) {
    final client = ref.watch(appWriteClientProvider);
    return Databases(client);
  } ,
);

final appwriteStorageProvider = Provider(
  (ProviderRef ref) {
    final client = ref.watch(appWriteClientProvider);
    return Storage(client);
});

final realtimeProvider = Provider(
  (ProviderRef ref) {
    final client = ref.watch(appWriteClientProvider); 
    return Realtime(client);
  },
);