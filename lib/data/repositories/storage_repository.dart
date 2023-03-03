import 'dart:developer';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitterclone/data/constants/constants.dart';
import 'package:twitterclone/data/core/core.dart';
import 'package:twitterclone/domain/repositories/i_storage_repository.dart';

final storageRepositoryProvider = Provider(
  (ProviderRef ref) {
    final storage = ref.watch(appwriteStorageProvider);
    return StorageRepository(storage: storage);
});

class StorageRepository implements IStorageRepository {

  final Storage _storage;

  StorageRepository({
    required Storage storage,
  }) : _storage = storage;

  @override
  FutureEither<List<String>> storeImages(List<File> images) async {
    List<String> imagesLinks = [];

    try {
      for (final image in images) {
        final uploadedImage = await _storage.createFile(
          bucketId: AppWriteConstants.imagesBucketId, 
          fileId: ID.unique(), 
          file: InputFile(path: image.path),
        );

        imagesLinks.add(AppWriteConstants.imageUrl(uploadedImage.$id));
      }

      return right(imagesLinks);
    } on AppwriteException catch (error, stackTrace) {
      log(error.toString());
      return left(Failure(error.message ?? 'Unexpected error ocurred', stackTrace));
    } catch (error, stackTrace) {
      log(error.toString());
      return left(Failure(error.toString(), stackTrace));
    }
  }

}
